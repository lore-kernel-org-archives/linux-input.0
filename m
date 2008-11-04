From: Oliver Neukum <oliver@neukum.org>
Subject: Re: cleanup of hiddev
Date: Tue, 4 Nov 2008 14:07:27 +0100
Message-ID: <200811041407.28543.oliver@neukum.org>
References: <200811031731.38055.oliver@neukum.org> <490F57D3.6060503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:38579 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751681AbYKDNHR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Nov 2008 08:07:17 -0500
In-Reply-To: <490F57D3.6060503@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org

Am Montag, 3. November 2008 20:58:11 schrieb Jiri Slaby:
> Hi.
> 
> > this is the cleanup of hiddev against current vanilla. What do you think?
> 
> See my comments below.

Hi,

I've addressed all comments I understood. In addition it seems to me that
the read method is not thread-safe.

	Regards
		Oliver

Signed-off-by: Oliver Neukum <oneukum@suse.de>

---

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 3ac3207..a35576b 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -63,6 +63,7 @@ struct hiddev_list {
 	struct fasync_struct *fasync;
 	struct hiddev *hiddev;
 	struct list_head node;
+	struct mutex thread_lock;
 };
 
 static struct hiddev *hiddev_table[HIDDEV_MINORS];
@@ -266,29 +267,38 @@ static int hiddev_release(struct inode * inode, struct file * file)
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
 
-	spin_lock_irqsave(&list->hiddev->list_lock, flags);
-	list_add_tail(&list->node, &hiddev_table[i]->list);
-	spin_unlock_irqrestore(&list->hiddev->list_lock, flags);
-
 	file->private_data = list;
 
-	if (!list->hiddev->open++)
-		if (list->hiddev->exist)
-			usbhid_open(hiddev_table[i]->hid);
+	if (!list->hiddev->open++) {
+		if (list->hiddev->exist) {
+			res = usbhid_open(hiddev_table[i]->hid);
+			if (res < 0)
+				goto bail;
+		}
+	}
+
+	spin_lock_irq(&list->hiddev->list_lock);
+	list_add_tail(&list->node, &hiddev_table[i]->list);
+	spin_unlock_irq(&list->hiddev->list_lock);
 
 	return 0;
+bail:
+	file->private_data = NULL;
+	kfree(list->hiddev);
+	return -EIO;
 }
 
 /*
@@ -307,7 +317,7 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 	DECLARE_WAITQUEUE(wait, current);
 	struct hiddev_list *list = file->private_data;
 	int event_size;
-	int retval = 0;
+	int retval;
 
 	event_size = ((list->flags & HIDDEV_FLAG_UREF) != 0) ?
 		sizeof(struct hiddev_usage_ref) : sizeof(struct hiddev_event);
@@ -315,10 +325,14 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
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
@@ -337,32 +351,38 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 				schedule();
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
@@ -370,6 +390,7 @@ static ssize_t hiddev_read(struct file * file, char __user * buffer, size_t coun
 		}
 
 	}
+	mutex_unlock(&list->thread_lock);
 
 	return retval;
 }
@@ -810,13 +831,6 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
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
@@ -828,6 +842,14 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 
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
 

