From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [patch]cleanup of hiddev
Date: Tue, 9 Dec 2008 13:19:58 +0100
Message-ID: <200812091319.59054.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

this is a cleanup of hiddev against Linus' current tree.
It addresses, I hope, the issues Ji=C5=99i Slaby found. EINTR
is used where appropriate and BKL is avoided by introducing a
new mutex.

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>

	Regards
		Oliver
----

commit f05614115c77fae393b3a262780f8f13ff485173
Author: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Date:   Tue Dec 9 13:09:56 2008 +0100

    cleanup of hiddev
   =20
    - thread safety
    - fix race between ioctl and disconnect
    - race in open
    - error checking
    - O_NONBLOCK handled

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
=20
 static struct hiddev *hiddev_table[HIDDEV_MINORS];
@@ -264,29 +266,48 @@ static int hiddev_release(struct inode * inode, s=
truct file * file)
 static int hiddev_open(struct inode *inode, struct file *file)
 {
 	struct hiddev_list *list;
-	unsigned long flags;
+	int res;
=20
 	int i =3D iminor(inode) - HIDDEV_MINOR_BASE;
=20
-	if (i >=3D HIDDEV_MINORS || !hiddev_table[i])
+	if (i >=3D HIDDEV_MINORS || i < 0 || !hiddev_table[i])
 		return -ENODEV;
=20
 	if (!(list =3D kzalloc(sizeof(struct hiddev_list), GFP_KERNEL)))
 		return -ENOMEM;
+	mutex_init(&list->thread_lock);
=20
 	list->hiddev =3D hiddev_table[i];
-
-	spin_lock_irqsave(&list->hiddev->list_lock, flags);
-	list_add_tail(&list->node, &hiddev_table[i]->list);
-	spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
+=09
=20
 	file->private_data =3D list;
=20
-	if (!list->hiddev->open++)
-		if (list->hiddev->exist)
-			usbhid_open(hiddev_table[i]->hid);
+	/*
+	 * no need for locking because the USB major number
+	 * is shared which usbcore guards against disconnect
+	 */
+	if (list->hiddev->exist) {
+		if (!list->hiddev->open++) {
+			res =3D usbhid_open(hiddev_table[i]->hid);
+			if (res < 0) {
+				res =3D -EIO;
+				goto bail;
+			}
+		}
+	} else {
+		res =3D -ENODEV;
+		goto bail;
+	}
+
+	spin_lock_irq(&list->hiddev->list_lock);
+	list_add_tail(&list->node, &hiddev_table[i]->list);
+	spin_unlock_irq(&list->hiddev->list_lock);
=20
 	return 0;
+bail:
+	file->private_data =3D NULL;
+	kfree(list->hiddev);
+	return res;
 }
=20
 /*
@@ -305,7 +326,7 @@ static ssize_t hiddev_read(struct file * file, char=
 __user * buffer, size_t coun
 	DECLARE_WAITQUEUE(wait, current);
 	struct hiddev_list *list =3D file->private_data;
 	int event_size;
-	int retval =3D 0;
+	int retval;
=20
 	event_size =3D ((list->flags & HIDDEV_FLAG_UREF) !=3D 0) ?
 		sizeof(struct hiddev_usage_ref) : sizeof(struct hiddev_event);
@@ -313,10 +334,14 @@ static ssize_t hiddev_read(struct file * file, ch=
ar __user * buffer, size_t coun
 	if (count < event_size)
 		return 0;
=20
+	/* lock against other threads */
+	retval =3D mutex_lock_interruptible(&list->thread_lock);
+	if (retval)
+		return -ERESTARTSYS;
+
 	while (retval =3D=3D 0) {
 		if (list->head =3D=3D list->tail) {
-			add_wait_queue(&list->hiddev->wait, &wait);
-			set_current_state(TASK_INTERRUPTIBLE);
+			prepare_to_wait(&list->hiddev->wait, &wait, TASK_INTERRUPTIBLE);
=20
 			while (list->head =3D=3D list->tail) {
 				if (file->f_flags & O_NONBLOCK) {
@@ -332,35 +357,45 @@ static ssize_t hiddev_read(struct file * file, ch=
ar __user * buffer, size_t coun
 					break;
 				}
=20
+				/* let O_NONBLOCK tasks run */
+				mutex_unlock(&list->thread_lock);
 				schedule();
+				if (mutex_lock_interruptible(&list->thread_lock))
+					return -EINTR;
 				set_current_state(TASK_INTERRUPTIBLE);
 			}
+			finish_wait(&list->hiddev->wait, &wait);
=20
-			set_current_state(TASK_RUNNING);
-			remove_wait_queue(&list->hiddev->wait, &wait);
 		}
=20
-		if (retval)
+		if (retval) {
+			mutex_unlock(&list->thread_lock);
 			return retval;
+		}
=20
=20
 		while (list->head !=3D list->tail &&
 		       retval + event_size <=3D count) {
 			if ((list->flags & HIDDEV_FLAG_UREF) =3D=3D 0) {
-				if (list->buffer[list->tail].field_index !=3D
-				    HID_FIELD_INDEX_NONE) {
+				if (list->buffer[list->tail].field_index !=3D HID_FIELD_INDEX_NONE=
) {
 					struct hiddev_event event;
+
 					event.hid =3D list->buffer[list->tail].usage_code;
 					event.value =3D list->buffer[list->tail].value;
-					if (copy_to_user(buffer + retval, &event, sizeof(struct hiddev_ev=
ent)))
+					if (copy_to_user(buffer + retval, &event, sizeof(struct hiddev_ev=
ent))) {
+						mutex_unlock(&list->thread_lock);
 						return -EFAULT;
+					}
 					retval +=3D sizeof(struct hiddev_event);
 				}
 			} else {
 				if (list->buffer[list->tail].field_index !=3D HID_FIELD_INDEX_NONE=
 ||
 				    (list->flags & HIDDEV_FLAG_REPORT) !=3D 0) {
-					if (copy_to_user(buffer + retval, list->buffer + list->tail, size=
of(struct hiddev_usage_ref)))
+
+					if (copy_to_user(buffer + retval, list->buffer + list->tail, size=
of(struct hiddev_usage_ref))) {
+						mutex_unlock(&list->thread_lock);
 						return -EFAULT;
+					}
 					retval +=3D sizeof(struct hiddev_usage_ref);
 				}
 			}
@@ -368,6 +403,7 @@ static ssize_t hiddev_read(struct file * file, char=
 __user * buffer, size_t coun
 		}
=20
 	}
+	mutex_unlock(&list->thread_lock);
=20
 	return retval;
 }
@@ -555,7 +591,7 @@ static long hiddev_ioctl(struct file *file, unsigne=
d int cmd, unsigned long arg)
 	struct hid_field *field;
 	struct usbhid_device *usbhid =3D hid->driver_data;
 	void __user *user_arg =3D (void __user *)arg;
-	int i;
+	int i, r;
 =09
 	/* Called without BKL by compat methods so no BKL taken */
=20
@@ -619,10 +655,22 @@ static long hiddev_ioctl(struct file *file, unsig=
ned int cmd, unsigned long arg)
 		}
=20
 	case HIDIOCGSTRING:
-		return hiddev_ioctl_string(hiddev, cmd, user_arg);
+		mutex_lock(&hiddev->existancelock);
+		if (!hiddev->exist)
+			r =3D hiddev_ioctl_string(hiddev, cmd, user_arg);
+		else
+			r =3D -ENODEV;
+		mutex_unlock(&hiddev->existancelock);
+		return r;
=20
 	case HIDIOCINITREPORT:
+		mutex_lock(&hiddev->existancelock);
+		if (!hiddev->exist) {
+			mutex_unlock(&hiddev->existancelock);
+			return -ENODEV;
+		}
 		usbhid_init_reports(hid);
+		mutex_unlock(&hiddev->existancelock);
=20
 		return 0;
=20
@@ -636,8 +684,12 @@ static long hiddev_ioctl(struct file *file, unsign=
ed int cmd, unsigned long arg)
 		if ((report =3D hiddev_lookup_report(hid, &rinfo)) =3D=3D NULL)
 			return -EINVAL;
=20
-		usbhid_submit_report(hid, report, USB_DIR_IN);
-		usbhid_wait_io(hid);
+		mutex_lock(&hiddev->existancelock);
+		if (hiddev->exist) {
+			usbhid_submit_report(hid, report, USB_DIR_IN);
+			usbhid_wait_io(hid);
+		}
+		mutex_unlock(&hiddev->existancelock);
=20
 		return 0;
=20
@@ -651,8 +703,12 @@ static long hiddev_ioctl(struct file *file, unsign=
ed int cmd, unsigned long arg)
 		if ((report =3D hiddev_lookup_report(hid, &rinfo)) =3D=3D NULL)
 			return -EINVAL;
=20
-		usbhid_submit_report(hid, report, USB_DIR_OUT);
-		usbhid_wait_io(hid);
+		mutex_lock(&hiddev->existancelock);
+		if (hiddev->exist) {
+			usbhid_submit_report(hid, report, USB_DIR_OUT);
+			usbhid_wait_io(hid);
+		}
+		mutex_unlock(&hiddev->existancelock);
=20
 		return 0;
=20
@@ -710,7 +766,13 @@ static long hiddev_ioctl(struct file *file, unsign=
ed int cmd, unsigned long arg)
 	case HIDIOCGUSAGES:
 	case HIDIOCSUSAGES:
 	case HIDIOCGCOLLECTIONINDEX:
-		return hiddev_ioctl_usage(hiddev, cmd, user_arg);
+		mutex_lock(&hiddev->existancelock);
+		if (hiddev->exist)
+			r =3D hiddev_ioctl_usage(hiddev, cmd, user_arg);
+		else
+			r =3D -ENODEV;
+		mutex_unlock(&hiddev->existancelock);
+		return r;
=20
 	case HIDIOCGCOLLECTIONINFO:
 		if (copy_from_user(&cinfo, user_arg, sizeof(cinfo)))
@@ -808,23 +870,22 @@ int hiddev_connect(struct hid_device *hid, unsign=
ed int force)
 	if (!(hiddev =3D kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
 		return -1;
=20
-	retval =3D usb_register_dev(usbhid->intf, &hiddev_class);
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
 	hiddev->hid =3D hid;
 	hiddev->exist =3D 1;
=20
-	hid->minor =3D usbhid->intf->minor;
-	hid->hiddev =3D hiddev;
