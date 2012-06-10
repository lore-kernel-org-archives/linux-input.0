From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 04/16] HID: uhid: implement read() on uhid devices
Date: Sun, 10 Jun 2012 15:16:16 +0200
Message-ID: <1339334188-21766-5-git-send-email-dh.herrmann@googlemail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:49312 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754796Ab2FJNQo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jun 2012 09:16:44 -0400
Received: by weyu7 with SMTP id u7so1506957wey.19
        for <linux-input@vger.kernel.org>; Sun, 10 Jun 2012 06:16:43 -0700 (PDT)
In-Reply-To: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

User-space can use read() to get a single event from uhid devices. read()
does never return multiple events. This allows us to extend the event
structure and still keep backwards compatibility.

If user-space wants to get multiple events in one syscall, they should use
the readv()/writev() syscalls which are supported by uhid.

This introduces a new lock which helps us synchronizing simultaneous reads
from user-space. We also correctly return -EINVAL/-EFAULT only on errors
and retry the read() when some other thread captured the event faster than
we did.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/uhid.c |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index b1a477f..9386082 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -28,6 +28,7 @@
 #define UHID_BUFSIZE	32
 
 struct uhid_device {
+	struct mutex devlock;
 	struct hid_device *hid;
 
 	wait_queue_head_t waitq;
@@ -81,6 +82,7 @@ static int uhid_char_open(struct inode *inode, struct file *file)
 	if (!uhid)
 		return -ENOMEM;
 
+	mutex_init(&uhid->devlock);
 	spin_lock_init(&uhid->qlock);
 	init_waitqueue_head(&uhid->waitq);
 
@@ -106,7 +108,49 @@ static int uhid_char_release(struct inode *inode, struct file *file)
 static ssize_t uhid_char_read(struct file *file, char __user *buffer,
 				size_t count, loff_t *ppos)
 {
-	return 0;
+	struct uhid_device *uhid = file->private_data;
+	int ret;
+	unsigned long flags;
+	size_t len;
+
+	/* they need at least the "type" member of uhid_event */
+	if (count < sizeof(__u32))
+		return -EINVAL;
+
+try_again:
+	if (file->f_flags & O_NONBLOCK) {
+		if (uhid->head == uhid->tail)
+			return -EAGAIN;
+	} else {
+		ret = wait_event_interruptible(uhid->waitq,
+						uhid->head != uhid->tail);
+		if (ret)
+			return ret;
+	}
+
+	ret = mutex_lock_interruptible(&uhid->devlock);
+	if (ret)
+		return ret;
+
+	if (uhid->head == uhid->tail) {
+		mutex_unlock(&uhid->devlock);
+		goto try_again;
+	} else {
+		len = min(count, sizeof(**uhid->outq));
+		if (copy_to_user(buffer, &uhid->outq[uhid->tail], len)) {
+			ret = -EFAULT;
+		} else {
+			kfree(uhid->outq[uhid->tail]);
+			uhid->outq[uhid->tail] = NULL;
+
+			spin_lock_irqsave(&uhid->qlock, flags);
+			uhid->tail = (uhid->tail + 1) % UHID_BUFSIZE;
+			spin_unlock_irqrestore(&uhid->qlock, flags);
+		}
+	}
+
+	mutex_unlock(&uhid->devlock);
+	return ret ? ret : len;
 }
 
 static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
-- 
1.7.10.4

