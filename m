From: Oliver Neukum <oliver@neukum.org>
Subject: cleanup of hiddev
Date: Wed, 5 Nov 2008 12:52:39 +0100
Message-ID: <200811051252.40133.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:52431 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318AbYKELw0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Nov 2008 06:52:26 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jikos@jikos.cz>

Hi,

this, I think, fixes everything.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum@suse.de>

---

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 3ac3207..a158bd1 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -63,6 +63,7 @@ struct hiddev_list {
 	struct fasync_struct *fasync;
 	struct hiddev *hiddev;
 	struct list_head node;
+	struct mutex thread_lock;
 };
 
 static struct hiddev *hiddev_table[HIDDEV_MINORS];
@@ -266,29 +267,44 @@ static int hiddev_release(struct inode * inode, struct file * file)
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
@@ -307,7 +323,7 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 	DECLARE_WAITQUEUE(wait, current);
 	struct hiddev_list *list = file->private_data;
 	int event_size;
-	int retval = 0;
+	int retval;
 
 	event_size = ((list->flags & HIDDEV_FLAG_UREF) != 0) ?
 		sizeof(struct hiddev_usage_ref) : sizeof(struct hiddev_event);
@@ -315,10 +331,14 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
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
@@ -334,35 +354,45 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 					break;
 				}
 
+				/* let O_NONBLOCK tasks run */
+				mutex_unlock(&list->thread_lock);
 				schedule();
+				if (mutex_lock_interruptible(&list->thread_lock))
+					return -ERESTARTSYS;
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
@@ -370,6 +400,7 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 		}
 
 	}
+	mutex_unlock(&list->thread_lock);
 
 	return retval;
 }
@@ -557,7 +588,7 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	struct hid_field *field;
 	struct usbhid_device *usbhid = hid->driver_data;
 	void __user *user_arg = (void __user *)arg;
-	int i;
+	int i, r;
 	
 	/* Called without BKL by compat methods so no BKL taken */
 
@@ -621,10 +652,22 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		}
 
 	case HIDIOCGSTRING:
-		return hiddev_ioctl_string(hiddev, cmd, user_arg);
+		lock_kernel();
+		if (!hiddev->exist)
+			r = hiddev_ioctl_string(hiddev, cmd, user_arg);
+		else
+			r = -ENODEV;
+		unlock_kernel();
+		return r;
 
 	case HIDIOCINITREPORT:
+		lock_kernel();
+		if (!hiddev->exist) {
+			unlock_kernel();
+			return -ENODEV;
+		}
 		usbhid_init_reports(hid);
+		unlock_kernel();
 
 		return 0;
 
@@ -638,8 +681,12 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
 			return -EINVAL;
 
-		usbhid_submit_report(hid, report, USB_DIR_IN);
-		usbhid_wait_io(hid);
+		lock_kernel();
+		if (hiddev->exist) {
+			usbhid_submit_report(hid, report, USB_DIR_IN);
+			usbhid_wait_io(hid);
+		}
+		unlock_kernel();
 
 		return 0;
 
@@ -653,8 +700,11 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		if ((report = hiddev_lookup_report(hid, &rinfo)) == NULL)
 			return -EINVAL;
 
-		usbhid_submit_report(hid, report, USB_DIR_OUT);
-		usbhid_wait_io(hid);
+		lock_kernel();
+		if (hiddev->exist) {
+			usbhid_submit_report(hid, report, USB_DIR_OUT);
+			usbhid_wait_io(hid);
+		}
 
 		return 0;
 
@@ -712,7 +762,13 @@ static long hiddev_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case HIDIOCGUSAGES:
 	case HIDIOCSUSAGES:
 	case HIDIOCGCOLLECTIONINDEX:
-		return hiddev_ioctl_usage(hiddev, cmd, user_arg);
+		lock_kernel();
+		if (hiddev->exist)
+			r = hiddev_ioctl_usage(hiddev, cmd, user_arg);
+		else
+			r = -ENODEV;
+		unlock_kernel();
+		return r;
 
 	case HIDIOCGCOLLECTIONINFO:
 		if (copy_from_user(&cinfo, user_arg, sizeof(cinfo)))
@@ -810,23 +866,21 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
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
 	hiddev->hid = hid;
 	hiddev->exist = 1;
 
-	hid->minor = usbhid->intf->minor;
-	hid->hiddev = hiddev;
-
-	hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] = hiddev;
+	retval = usb_register_dev(usbhid->intf, &hiddev_class);
+	if (retval) {
+		err_hid("Not able to get a minor for this device.");
+		kfree(hiddev);
+		return -1;
+	} else {
+		hid->minor = usbhid->intf->minor;
+		hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] = hiddev;
+	}
 
 	return 0;
 }
@@ -841,7 +895,9 @@ void hiddev_disconnect(struct hid_device *hid)
 	struct hiddev *hiddev = hid->hiddev;
 	struct usbhid_device *usbhid = hid->driver_data;
 
+	lock_kernel();
 	hiddev->exist = 0;
+	unlock_kernel();
 
 	hiddev_table[hiddev->hid->minor - HIDDEV_MINOR_BASE] = NULL;
 	usb_deregister_dev(usbhid->intf, &hiddev_class);
