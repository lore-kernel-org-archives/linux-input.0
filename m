From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch]fix memleak in error case of hiddev
Date: Wed, 12 Nov 2008 15:48:38 +0100 (CET)
Message-ID: <alpine.LNX.1.10.0811121547400.32143@jikos.suse.cz>
References: <200810311031.39083.oliver@neukum.org> <alpine.LNX.1.10.0810311507070.31273@jikos.suse.cz> <200810311610.11604.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:38452 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751617AbYKLOsk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2008 09:48:40 -0500
In-Reply-To: <200810311610.11604.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Jiri Kosina <jikos@jikos.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

On Fri, 31 Oct 2008, Oliver Neukum wrote:

> > Now, you are right that hiddev_open() doesn't handle error condition from 
> > usbhid_open(), and that should be fixed. But that doesn't seem to be 
> > addressed by your patch at all ... ?
> Very well, this is what I've found in hiddev (with the autosuspend patch).
> I am porting this to the vanilla and the stable tree.
> - failure to test for lower range of minors
> - addition to list before open finishes
> - failure to handle errors from usbhid_open()
> - possibility to miss a wakeup in hiddev_read
> - open() races with hiddev_connect()
> Note that this is untested and should be tested.

Does the patch below look OK to you? I have removed the dependency on 
autosuspend code for now.

Thanks.


 drivers/hid/usbhid/hiddev.c |   38 ++++++++++++++++++++++----------------
 1 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 3ac3207..99b6c65 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -270,7 +270,7 @@ static int hiddev_open(struct inode *inode, struct file *file)
 
 	int i = iminor(inode) - HIDDEV_MINOR_BASE;
 
-	if (i >= HIDDEV_MINORS || !hiddev_table[i])
+	if (i >= HIDDEV_MINORS || i < 0 || !hiddev_table[i])
 		return -ENODEV;
 
 	if (!(list = kzalloc(sizeof(struct hiddev_list), GFP_KERNEL)))
@@ -278,16 +278,22 @@ static int hiddev_open(struct inode *inode, struct file *file)
 
 	list->hiddev = hiddev_table[i];
 
+	file->private_data = list;
+
+	if (!list->hiddev->open++) {
+		if (list->hiddev->exist) {
+			if (usbhid_open(hiddev_table[i]->hid) < 0) {
+				file->private_data = NULL;
+				kfree(list->hiddev);
+				return -EIO;
+			}
+		}
+	}
+
 	spin_lock_irqsave(&list->hiddev->list_lock, flags);
 	list_add_tail(&list->node, &hiddev_table[i]->list);
 	spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
 
-	file->private_data = list;
-
-	if (!list->hiddev->open++)
-		if (list->hiddev->exist)
-			usbhid_open(hiddev_table[i]->hid);
-
 	return 0;
 }
 
@@ -317,8 +323,8 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 
 	while (retval == 0) {
 		if (list->head == list->tail) {
-			add_wait_queue(&list->hiddev->wait, &wait);
 			set_current_state(TASK_INTERRUPTIBLE);
+			add_wait_queue(&list->hiddev->wait, &wait);
 
 			while (list->head == list->tail) {
 				if (file->f_flags & O_NONBLOCK) {
@@ -335,7 +341,6 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 				}
 
 				schedule();
-				set_current_state(TASK_INTERRUPTIBLE);
 			}
 
 			set_current_state(TASK_RUNNING);
@@ -810,13 +815,6 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
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
@@ -828,6 +826,14 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 
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
 
