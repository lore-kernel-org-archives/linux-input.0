From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [patch]cleanup of hiddev
Date: Tue, 16 Dec 2008 07:13:54 +0100
Message-ID: <200812160713.55976.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This is a cleanup of hiddev and fixes the following issues:

- thread safety by locking in read & ioctl, introducing a per device mutex
- race between ioctl and disconnect, introducing a flag and locking
  in form of a per low level device mutex
- race between open and other methods, making sure only successfully
  opened devices are put on the list, changing order of events
- range checking both upper and lower limits of the minor range
- make sure further calls to open fail for unplugged devices even if
  the device still has opened files
- error checking for low level open
- possible loss of wakeup events, using standard waiting macros
- race in initialisation by moving registration after full initialisation

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>

	Regards
		Oliver
----

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 83e851a..defe912 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -49,6 +49,7 @@
 struct hiddev {
 	int exist;
 	int open;
+	struct mutex existancelock;
 	wait_queue_head_t wait;
 	struct hid_device *hid;
 	struct list_head list;
@@ -63,6 +64,7 @@ struct hiddev_list {
 	struct fasync_struct *fasync;
 	struct hiddev *hiddev;
 	struct list_head node;
+	struct mutex thread_lock;
 };
 
 static struct hiddev *hiddev_table[HIDDEV_MINORS];
@@ -264,29 +266,48 @@ static int hiddev_release(struct inode * inode, struct file * file)
 static int hiddev_open(struct inode *inode, struct file *file)
 {
 	struct hiddev_list *list;
-	unsigned long flags;
+	int res;
 
 	int i = iminor(inode) - HIDDEV_MINOR_BASE;
 
-	if (i >= HIDDEV_MINORS || !hiddev_table[i])
+	if (i >= HIDDEV_MINORS || i < 0 || !hiddev_table[i])
 		return -ENODEV;
 
 	if (!(list = kzalloc(sizeof(struct hiddev_list), GFP_KERNEL)))
 		return -ENOMEM;
+	mutex_init(&list->thread_lock);
 
 	list->hiddev = hiddev_table[i];
-
-	spin_lock_irqsave(&list->hiddev->list_lock, flags);
-	list_add_tail(&list->node, &hiddev_table[i]->list);
-	spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
+	
 
 	file->private_data = list;
 
-	if (!list->hiddev->open++)
-		if (list->hiddev->exist)
-			usbhid_open(hiddev_table[i]->hid);
+	/*
+	 * no need for locking because the USB major number
+	 * is shared which usbcore guards against disconnect
+	 */
+	if (list->hiddev->exist) {
+		if (!list->hiddev->open++) {
+			res = usbhid_open(hiddev_table[i]->hid);
+			if (res < 0) {
+				res = -EIO;
+				goto bail;
+			}
+		}
+	} else {
+		res = -ENODEV;
+		goto bail;
+	}
+
+	spin_lock_irq(&list->hiddev->list_lock);
+	list_add_tail(&list->node, &hiddev_table[i]->list);
+	spin_unlock_irq(&list->hiddev->list_lock);
 
 	return 0;
+bail:
+	file->private_data = NULL;
+	kfree(list->hiddev);
+	return res;
 }
 
 /*
@@ -305,7 +326,7 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 	DECLARE_WAITQUEUE(wait, current);
 	struct hiddev_list *list = file->private_data;
 	int event_size;
-	int retval = 0;
+	int retval;
 
 	event_size = ((list->flags & HIDDEV_FLAG_UREF) != 0) ?
 		sizeof(struct hiddev_usage_ref) : sizeof(struct hiddev_event);
@@ -313,10 +334,14 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 	if (count < event_size)
 		return 0;
 
+	/* lock against other threads */
+	retval = mutex_lock_interruptible(&list->thread_lock);
+	if (retval)
+		return -ERESTARTSYS;
+
 	while (retval == 0) {
 		if (list->head == list->tail) {
-			add_wait_queue(&list->hiddev->wait, &wait);
-			set_current_state(TASK_INTERRUPTIBLE);
+			prepare_to_wait(&list->hiddev->wait, &wait, TASK_INTERRUPTIBLE);
 
 			while (list->head == list->tail) {
 				if (file->f_flags & O_NONBLOCK) {
@@ -332,35 +357,45 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 					break;
 				}
 
+				/* let O_NONBLOCK tasks run */
+				mutex_unlock(&list->thread_lock);
 				schedule();
+				if (mutex_lock_interruptible(&list->thread_lock))
+					return -EINTR;
 				set_current_state(TASK_INTERRUPTIBLE);
 			}
+			finish_wait(&list->hiddev->wait, &wait);
 
-			set_current_state(TASK_RUNNING);
-			remove_wait_queue(&list->hiddev->wait, &wait);
 		}
 
-		if (retval)
+		if (retval) {
+			mutex_unlock(&list->thread_lock);
 			return retval;
+		}
 
 
 		while (list->head != list->tail &&
 		       retval + event_size <= count) {
 			if ((list->flags & HIDDEV_FLAG_UREF) == 0) {
-				if (list->buffer[list->tail].field_index !=
-				    HID_FIELD_INDEX_NONE) {
+				if (list->buffer[list->tail].field_index != HID_FIELD_INDEX_NONE) {
 					struct hiddev_event event;
+
 					event.hid = list->buffer[list->tail].usage_code;
 					event.value = list->buffer[list->tail].value;
-					if (copy_to_user(buffer + retval, &event, sizeof(struct hiddev_event)))
+					if (copy_to_user(buffer + retval, &event, sizeof(struct hiddev_event))) {
+						mutex_unlock(&list->thread_lock);
 						return -EFAULT;
+					}
 					retval += sizeof(struct hiddev_event);
 				}
 			} else {
 				if (list->buffer[list->tail].field_index != HID_FIELD_INDEX_NONE ||
 				    (list->flags & HIDDEV_FLAG_REPORT) != 0) {
-					if (copy_to_user(buffer + retval, list->buffer + list->tail, sizeof(struct hiddev_usage_ref)))
+
+					if (copy_to_user(buffer + retval, list->buffer + list->tail, sizeof(struct hiddev_usage_ref))) {
+						mutex_unlock(&list->thread_lock);
 						return -EFAULT;
+					}
 					retval += sizeof(struct hiddev_usage_ref);
 				}
 			}
@@ -368,6 +403,7 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 		}
 
 	}
+	mutex_unlock(&list->thread_lock);
 
 	return retval;
 }
@@ -555,7 +591,7 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct hid_field *field;
 	struct usbhid_device *usbhid = hid->driver_data;
 	void __user *user_arg = (void __user *)arg;
-	int i;
+	int i, r;
 	
 	/* Called without BKL by compat methods so no BKL taken */
 
@@ -619,10 +655,22 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 
 	case HIDIOCGSTRING:
-		return hiddev_ioctl_string(hiddev, cmd, user_arg);
+		mutex_lock(&hiddev->existancelock);
+		if (!hiddev->exist)
+			r = hiddev_ioctl_string(hiddev, cmd, user_arg);
+		else
+			r = -ENODEV;
+		mutex_unlock(&hiddev->existancelock);
+		return r;
 
 	case HIDIOCINITREPORT:
+		mutex_lock(&hiddev->existancelock);
+		if (!hiddev->exist) {
+			mutex_unlock(&hiddev->existancelock);
+			return -ENODEV;
+		}
 		usbhid_init_reports(hid);
+		mutex_unlock(&hiddev->existancelock);
 
 		return 0;
 
@@ -636,8 +684,12 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
 			return -EINVAL;
 
-		usbhid_submit_report(hid, report, USB_DIR_IN);
-		usbhid_wait_io(hid);
+		mutex_lock(&hiddev->existancelock);
+		if (hiddev->exist) {
+			usbhid_submit_report(hid, report, USB_DIR_IN);
+			usbhid_wait_io(hid);
+		}
+		mutex_unlock(&hiddev->existancelock);
 
 		return 0;
 
@@ -651,8 +703,12 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
 			return -EINVAL;
 
-		usbhid_submit_report(hid, report, USB_DIR_OUT);
-		usbhid_wait_io(hid);
+		mutex_lock(&hiddev->existancelock);
+		if (hiddev->exist) {
+			usbhid_submit_report(hid, report, USB_DIR_OUT);
+			usbhid_wait_io(hid);
+		}
+		mutex_unlock(&hiddev->existancelock);
 
 		return 0;
 
@@ -710,7 +766,13 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case HIDIOCGUSAGES:
 	case HIDIOCSUSAGES:
 	case HIDIOCGCOLLECTIONINDEX:
-		return hiddev_ioctl_usage(hiddev, cmd, user_arg);
+		mutex_lock(&hiddev->existancelock);
+		if (hiddev->exist)
+			r = hiddev_ioctl_usage(hiddev, cmd, user_arg);
+		else
+			r = -ENODEV;
+		mutex_unlock(&hiddev->existancelock);
+		return r;
 
 	case HIDIOCGCOLLECTIONINFO:
 		if (copy_from_user(&cinfo, user_arg, sizeof(cinfo)))
@@ -808,23 +870,22 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 	if (!(hiddev = kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
 		return -1;
 
-	retval = usb_register_dev(usbhid->intf, &hiddev_class);
-	if (retval) {
-		err_hid("Not able to get a minor for this device.");
-		kfree(hiddev);
-		return -1;
-	}
-
 	init_waitqueue_head(&hiddev->wait);
 	INIT_LIST_HEAD(&hiddev->list);
 	spin_lock_init(&hiddev->list_lock);
+	mutex_init(&hiddev->existancelock);
 	hiddev->hid = hid;
 	hiddev->exist = 1;
 
-	hid->minor = usbhid->intf->minor;
-	hid->hiddev = hiddev;
