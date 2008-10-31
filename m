From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch]fix memleak in error case of hiddev
Date: Fri, 31 Oct 2008 16:10:10 +0100
Message-ID: <200810311610.11604.oliver@neukum.org>
References: <200810311031.39083.oliver@neukum.org> <alpine.LNX.1.10.0810311507070.31273@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:41896 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbYJaPKR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Oct 2008 11:10:17 -0400
In-Reply-To: <alpine.LNX.1.10.0810311507070.31273@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jiri Kosina <jikos@jikos.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

Am Freitag, 31. Oktober 2008 15:08:07 schrieb Jiri Kosina:
> Now, you are right that hiddev_open() doesn't handle error condition from 
> usbhid_open(), and that should be fixed. But that doesn't seem to be 
> addressed by your patch at all ... ?

Very well, this is what I've found in hiddev (with the autosuspend patch).
I am porting this to the vanilla and the stable tree.

- failure to test for lower range of minors
- addition to list before open finishes
- failure to handle errors from usbhid_open()
- possibility to miss a wakeup in hiddev_read
- open() races with hiddev_connect()

Note that this is untested and should be tested.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 6834d1f..3b3e179 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -268,40 +268,42 @@ static int hiddev_release(struct inode * inode, struct file * file)
 static int hiddev_open(struct inode *inode, struct file *file)
 {
 	struct hiddev_list *list;
-	unsigned long flags;
 	int res;
 
 	int i = iminor(inode) - HIDDEV_MINOR_BASE;
 
-	if (i >= HIDDEV_MINORS || !hiddev_table[i])
+	if (i >= HIDDEV_MINORS || i < 0 || !hiddev_table[i])
 		return -ENODEV;
 
 	if (!(list = kzalloc(sizeof(struct hiddev_list), GFP_KERNEL)))
 		return -ENOMEM;
 
 	list->hiddev = hiddev_table[i];
-
-	spin_lock_irqsave(&list->hiddev->list_lock, flags);
-	list_add_tail(&list->node, &hiddev_table[i]->list);
-	spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
-
 	file->private_data = list;
 
 	if (!list->hiddev->open++)
 		if (list->hiddev->exist) {
 			struct hid_device *hid = hiddev_table[i]->hid;
 			res = usbhid_get_power(hid);
-			if (res < 0) {
-				spin_lock_irqsave(&list->hiddev->list_lock, flags);
-				list_del(&list->node);
-				spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
-				kfree(list->hiddev);
-				return -EIO;
-			}
-			usbhid_open(hid);
+			if (res < 0)
+				goto bail;
+			res = usbhid_open(hid);
+			if (res < 0)
+				goto bail_power_put;
 		}
 
+	spin_lock_irq(&list->hiddev->list_lock);
+	list_add_tail(&list->node, &hiddev_table[i]->list);
+	spin_unlock_irq(&list->hiddev->list_lock);
+
 	return 0;
+
+bail_power_put:
+	usbhid_put_power(list->hiddev->hid);
+bail:
+	file->private_data = NULL;
+	kfree(list->hiddev);
+	return -EIO;
 }
 
 /*
@@ -330,8 +332,8 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 
 	while (retval == 0) {
 		if (list->head == list->tail) {
-			add_wait_queue(&list->hiddev->wait, &wait);
 			set_current_state(TASK_INTERRUPTIBLE);
+			add_wait_queue(&list->hiddev->wait, &wait);
 
 			while (list->head == list->tail) {
 				if (file->f_flags & O_NONBLOCK) {
@@ -348,7 +350,6 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 				}
 
 				schedule();
-				set_current_state(TASK_INTERRUPTIBLE);
 			}
 
 			set_current_state(TASK_RUNNING);
@@ -823,13 +824,6 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
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
@@ -841,6 +835,14 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 
 	hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] = hiddev;
 
+	retval = usb_register_dev(usbhid->intf, &hiddev_class);
+	if (retval) {
+		err_hid("Not able to get a minor for this device.");
+		hiddev_table[usbhid->intf->minor - HIDDEV_MINOR_BASE] = NULL;
+		kfree(hiddev);
+		return -1;
+	}
+
 	return 0;
 }
 

