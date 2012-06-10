From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 05/16] HID: uhid: implement write() on uhid devices
Date: Sun, 10 Jun 2012 15:16:17 +0200
Message-ID: <1339334188-21766-6-git-send-email-dh.herrmann@googlemail.com>
References: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33409 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803Ab2FJNQp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jun 2012 09:16:45 -0400
Received: by weyu7 with SMTP id u7so1506960wey.19
        for <linux-input@vger.kernel.org>; Sun, 10 Jun 2012 06:16:44 -0700 (PDT)
In-Reply-To: <1339334188-21766-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Similar to read() you can only write() a single event with one call to an
uhid device. To write multiple events use writev() which is supported by
uhid.

We currently always return -EOPNOTSUPP but other events will be added in
later patches.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/uhid.c |   31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 9386082..31e8379 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -30,6 +30,7 @@
 struct uhid_device {
 	struct mutex devlock;
 	struct hid_device *hid;
+	struct uhid_event input_buf;
 
 	wait_queue_head_t waitq;
 	spinlock_t qlock;
@@ -156,7 +157,35 @@ try_again:
 static ssize_t uhid_char_write(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos)
 {
-	return 0;
+	struct uhid_device *uhid = file->private_data;
+	int ret;
+	size_t len;
+
+	/* we need at least the "type" member of uhid_event */
+	if (count < sizeof(__u32))
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&uhid->devlock);
+	if (ret)
+		return ret;
+
+	memset(&uhid->input_buf, 0, sizeof(uhid->input_buf));
+	len = min(count, sizeof(uhid->input_buf));
+	if (copy_from_user(&uhid->input_buf, buffer, len)) {
+		ret = -EFAULT;
+		goto unlock;
+	}
+
+	switch (uhid->input_buf.type) {
+	default:
+		ret = -EOPNOTSUPP;
+	}
+
+unlock:
+	mutex_unlock(&uhid->devlock);
+
+	/* return "count" not "len" to not confuse the caller */
+	return ret ? ret : count;
 }
 
 static unsigned int uhid_char_poll(struct file *file, poll_table *wait)
-- 
1.7.10.4

