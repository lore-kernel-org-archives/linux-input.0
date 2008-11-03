From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: cleanup of hiddev
Date: Mon, 3 Nov 2008 17:31:36 +0100
Message-ID: <200811031731.38055.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: Jiri Kosina <jikos-wDf7oJUeT2I@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Ji=C5=99is,

this is the cleanup of hiddev against current vanilla. What do you thin=
k?

	Regards
		Oliver

---

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 3ac3207..78f5a3b 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -266,11 +266,11 @@ static int hiddev_release(struct inode * inode, s=
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
@@ -278,17 +278,25 @@ static int hiddev_open(struct inode *inode, struc=
t file *file)
=20
 	list->hiddev =3D hiddev_table[i];
=20
-	spin_lock_irqsave(&list->hiddev->list_lock, flags);
-	list_add_tail(&list->node, &hiddev_table[i]->list);
-	spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
-
 	file->private_data =3D list;
=20
-	if (!list->hiddev->open++)
-		if (list->hiddev->exist)
-			usbhid_open(hiddev_table[i]->hid);
+	if (!list->hiddev->open++) {
+		if (list->hiddev->exist) {
+			res =3D usbhid_open(hiddev_table[i]->hid);
+			if (res < 0)
+				goto bail;
+		}
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
+	return -EIO;
 }
=20
 /*
@@ -317,8 +325,8 @@ static ssize_t hiddev_read(struct file * file, char=
 __user * buffer, size_t coun
=20
 	while (retval =3D=3D 0) {
 		if (list->head =3D=3D list->tail) {
-			add_wait_queue(&list->hiddev->wait, &wait);
 			set_current_state(TASK_INTERRUPTIBLE);
+			add_wait_queue(&list->hiddev->wait, &wait);
=20
 			while (list->head =3D=3D list->tail) {
 				if (file->f_flags & O_NONBLOCK) {
@@ -335,7 +343,6 @@ static ssize_t hiddev_read(struct file * file, char=
 __user * buffer, size_t coun
 				}
=20
 				schedule();
-				set_current_state(TASK_INTERRUPTIBLE);
 			}
=20
 			set_current_state(TASK_RUNNING);
@@ -810,13 +817,6 @@ int hiddev_connect(struct hid_device *hid, unsigne=
d int force)
 	if (!(hiddev =3D kzalloc(sizeof(struct hiddev), GFP_KERNEL)))
 		return -1;
=20
-	retval =3D usb_register_dev(usbhid->intf, &hiddev_class);
-	if (retval) {
-		err_hid("Not able to get a minor for this device.");
-		kfree(hiddev);
-		return -1;
-	}
