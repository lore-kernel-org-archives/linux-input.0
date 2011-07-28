From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 16/16] HID: wiimote: Allow EEPROM debugfs access
Date: Thu, 28 Jul 2011 18:08:36 +0200
Message-ID: <1311869316-17128-17-git-send-email-dh.herrmann@googlemail.com>
References: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62287 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab1G1QJ0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 12:09:26 -0400
Received: by mail-fx0-f46.google.com with SMTP id 19so1400084fxh.19
        for <linux-input@vger.kernel.org>; Thu, 28 Jul 2011 09:09:25 -0700 (PDT)
In-Reply-To: <1311869316-17128-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, padovan@profusion.mobi, dh.herrmann@googlemail.com

Add "eeprom" file to debugfs for every wiimote. Reading from this file allows to
read the internal EEPROM of a wiimote. Writing to eeprom is currently not
allowed and eeprom memory hasn't been reverse-engineered, yet.

This file shall only be used for debugging. Reading large blocks from this file
may block other access to the wiimote, hence, each block has been limited to 16
bytes to avoid large memory transfers while holding the wiimote lock.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote.c |  131 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 131 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-wiimote.c b/drivers/hid/hid-wiimote.c
index 64200e5..56cdb3b 100644
--- a/drivers/hid/hid-wiimote.c
+++ b/drivers/hid/hid-wiimote.c
@@ -12,12 +12,14 @@
 
 #include <linux/atomic.h>
 #include <linux/completion.h>
+#include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/hid.h>
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/uaccess.h>
 #include "hid-ids.h"
 
 #define WIIMOTE_VERSION "0.1"
@@ -43,6 +45,8 @@ struct wiimote_state {
 	/* results of synchronous requests */
 	__u8 cmd_battery;
 	__u8 cmd_err;
+	__u8 *cmd_read_buf;
+	__u8 cmd_read_size;
 };
 
 struct wiimote_data {
@@ -57,6 +61,10 @@ struct wiimote_data {
 	struct work_struct worker;
 
 	struct wiimote_state state;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debug_eeprom;
+#endif
 };
 
 #define WIIPROTO_FLAG_LED1		0x01
@@ -815,6 +823,110 @@ static ssize_t wiifs_ir_set(struct device *dev, struct device_attribute *attr,
 
 static DEVICE_ATTR(ir, S_IRUGO | S_IWUSR, wiifs_ir_show, wiifs_ir_set);
 
+#ifdef CONFIG_DEBUG_FS
+
+static int wiifs_eeprom_open(struct inode *i, struct file *f)
+{
+	f->private_data = i->i_private;
+	return 0;
+}
+
+static ssize_t wiifs_eeprom_read(struct file *f, char __user *u, size_t s,
+								loff_t *off)
+{
+	struct wiimote_data *wdata = f->private_data;
+	unsigned long flags;
+	ssize_t ret;
+	char *buf;
+	__u16 size;
+
+	if (s == 0)
+		return -EINVAL;
+	if (*off > 0xffffff)
+		return 0;
+	if (s > 16)
+		s = 16;
+
+	if (!atomic_read(&wdata->ready))
+		return -EBUSY;
+	/* smp_rmb: Make sure wdata->xy is available when wdata->ready is 1 */
+	smp_rmb();
+
+	buf = kmalloc(s, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	ret = wiimote_cmd_acquire(wdata);
+	if (ret)
+		goto error;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.cmd_read_size = s;
+	wdata->state.cmd_read_buf = buf;
+	wiimote_cmd_set(wdata, WIIPROTO_REQ_RMEM, *off & 0xffff);
+	wiiproto_req_reeprom(wdata, *off, s);
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	ret = wiimote_cmd_wait(wdata);
+	if (!ret)
+		size = wdata->state.cmd_read_size;
+
+	spin_lock_irqsave(&wdata->state.lock, flags);
+	wdata->state.cmd_read_buf = NULL;
+	spin_unlock_irqrestore(&wdata->state.lock, flags);
+
+	wiimote_cmd_release(wdata);
+
+	if (ret)
+		goto error;
+	if (size == 0) {
+		ret = -EIO;
+		goto error;
+	}
+	if (copy_to_user(u, buf, size)) {
+		ret = -EFAULT;
+		goto error;
+	}
+
+	*off += size;
+	ret = size;
+
+error:
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations wiifs_eeprom_fops = {
+	.owner = THIS_MODULE,
+	.open = wiifs_eeprom_open,
+	.read = wiifs_eeprom_read,
+	.llseek = generic_file_llseek,
+};
+
+static void wiimote_debugfs_init(struct wiimote_data *wdata)
+{
+	wdata->debug_eeprom = debugfs_create_file("eeprom", S_IRUSR,
+			wdata->hdev->debug_dir, wdata, &wiifs_eeprom_fops);
+}
+
+static void wiimote_debugfs_deinit(struct wiimote_data *wdata)
+{
+	if (wdata->debug_eeprom)
+		debugfs_remove(wdata->debug_eeprom);
+}
+
+#else /* CONFIG_DEBUG_FS */
+
+static void wiimote_debugfs_init(void *s)
+{
+}
+
+static void wiimote_debugfs_deinit(void *s)
+{
+}
+
+#endif /* CONFIG_DEBUG_FS */
+
 static int wiimote_input_event(struct input_dev *dev, unsigned int type,
 						unsigned int code, int value)
 {
@@ -929,7 +1041,23 @@ static void handler_status(struct wiimote_data *wdata, const __u8 *payload)
 
 static void handler_data(struct wiimote_data *wdata, const __u8 *payload)
 {
+	__u16 offset = payload[3] << 8 | payload[4];
+	__u8 size = (payload[2] >> 4) + 1;
+	__u8 err = payload[2] & 0x0f;
+
 	handler_keys(wdata, payload);
+
+	if (wiimote_cmd_pending(wdata, WIIPROTO_REQ_RMEM, offset)) {
+		if (err)
+			size = 0;
+		else if (size > wdata->state.cmd_read_size)
+			size = wdata->state.cmd_read_size;
+
+		wdata->state.cmd_read_size = size;
+		if (wdata->state.cmd_read_buf)
+			memcpy(wdata->state.cmd_read_buf, &payload[5], size);
+		wiimote_cmd_complete(wdata);
+	}
 }
 
 static void handler_return(struct wiimote_data *wdata, const __u8 *payload)
@@ -1222,6 +1350,8 @@ static int wiimote_hid_probe(struct hid_device *hdev,
 		goto err_stop;
 	}
 
+	wiimote_debugfs_init(wdata);
+
 	/* smp_wmb: Write wdata->xy first before wdata->ready is set to 1 */
 	smp_wmb();
 	atomic_set(&wdata->ready, 1);
@@ -1256,6 +1386,7 @@ static void wiimote_hid_remove(struct hid_device *hdev)
 
 	hid_info(hdev, "Device removed\n");
 
+	wiimote_debugfs_deinit(wdata);
 	device_remove_file(&hdev->dev, &dev_attr_led1);
 	device_remove_file(&hdev->dev, &dev_attr_led2);
 	device_remove_file(&hdev->dev, &dev_attr_led3);
-- 
1.7.6

