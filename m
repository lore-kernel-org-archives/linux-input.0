From: Ratan Nalumasu <ratan@google.com>
Subject: [PATCH] hidraw: don't deallocate memory when it is in use
Date: Sat, 22 Sep 2012 11:46:30 -0700
Message-ID: <20120922184630.GA23401@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f202.google.com ([209.85.220.202]:65005 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825Ab2IVSqc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Sep 2012 14:46:32 -0400
Received: by vcbfy27 with SMTP id fy27so584126vcb.1
        for <linux-input@vger.kernel.org>; Sat, 22 Sep 2012 11:46:31 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

When a device is unplugged, wait for all processes that have opened the device
to close before deallocating the device.

Signed-off-by: Ratan Nalumasu <ratan@google.com>
---
 drivers/hid/hidraw.c |   69 +++++++++++++++++++-------------------------------
 1 files changed, 26 insertions(+), 43 deletions(-)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 3b6f7bf..c46c5f1 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -42,6 +42,7 @@ static struct cdev hidraw_cdev;
 static struct class *hidraw_class;
 static struct hidraw *hidraw_table[HIDRAW_MAX_DEVICES];
 static DEFINE_MUTEX(minors_lock);
+static void drop_ref(struct hidraw *hid, int exists_bit);
 
 static ssize_t hidraw_read(struct file *file, char __user *buffer, size_t count, loff_t *ppos)
 {
@@ -113,7 +114,7 @@ static ssize_t hidraw_send_report(struct file *file, const char __user *buffer,
 	__u8 *buf;
 	int ret = 0;
 
-	if (!hidraw_table[minor]) {
+	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
 		ret = -ENODEV;
 		goto out;
 	}
@@ -261,7 +262,7 @@ static int hidraw_open(struct inode *inode, struct file *file)
 	}
 
 	mutex_lock(&minors_lock);
-	if (!hidraw_table[minor]) {
+	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
 		err = -ENODEV;
 		goto out_unlock;
 	}
@@ -298,36 +299,12 @@ out:
 static int hidraw_release(struct inode * inode, struct file * file)
 {
 	unsigned int minor = iminor(inode);
-	struct hidraw *dev;
 	struct hidraw_list *list = file->private_data;
-	int ret;
-	int i;
-
-	mutex_lock(&minors_lock);
-	if (!hidraw_table[minor]) {
-		ret = -ENODEV;
-		goto unlock;
-	}
 
+	drop_ref(hidraw_table[minor], 0);
 	list_del(&list->node);
-	dev = hidraw_table[minor];
-	if (!--dev->open) {
-		if (list->hidraw->exist) {
-			hid_hw_power(dev->hid, PM_HINT_NORMAL);
-			hid_hw_close(dev->hid);
-		} else {
-			kfree(list->hidraw);
-		}
-	}
-
-	for (i = 0; i < HIDRAW_BUFFER_SIZE; ++i)
-		kfree(list->buffer[i].value);
 	kfree(list);
-	ret = 0;
-unlock:
-	mutex_unlock(&minors_lock);
-
-	return ret;
+	return 0;
 }
 
 static long hidraw_ioctl(struct file *file, unsigned int cmd,
@@ -529,21 +506,7 @@ EXPORT_SYMBOL_GPL(hidraw_connect);
 void hidraw_disconnect(struct hid_device *hid)
 {
 	struct hidraw *hidraw = hid->hidraw;
-
-	mutex_lock(&minors_lock);
-	hidraw->exist = 0;
-
-	device_destroy(hidraw_class, MKDEV(hidraw_major, hidraw->minor));
-
-	hidraw_table[hidraw->minor] = NULL;
-
-	if (hidraw->open) {
-		hid_hw_close(hid);
-		wake_up_interruptible(&hidraw->wait);
-	} else {
-		kfree(hidraw);
-	}
-	mutex_unlock(&minors_lock);
+	drop_ref(hidraw, 1);
 }
 EXPORT_SYMBOL_GPL(hidraw_disconnect);
 
@@ -585,3 +548,23 @@ void hidraw_exit(void)
 	unregister_chrdev_region(dev_id, HIDRAW_MAX_DEVICES);
 
 }
+
+static void drop_ref(struct hidraw *hidraw, int exists_bit)
+{
+	mutex_lock(&minors_lock);
+	if (exists_bit) {
+		hid_hw_close(hidraw->hid);
+		hidraw->exist = 0;
+		if (hidraw->open)
+			wake_up_interruptible(&hidraw->wait);
+	} else {
+		--hidraw->open;
+	}
+
+	if (!hidraw->open && !hidraw->exist) {
+		device_destroy(hidraw_class, MKDEV(hidraw_major, hidraw->minor));
+		hidraw_table[hidraw->minor] = NULL;
+		kfree(hidraw);
+	}
+	mutex_unlock(&minors_lock);
+}
-- 
1.7.7.3

