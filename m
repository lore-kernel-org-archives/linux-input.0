From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH v2 14/17] HID: wiimote: Allow direct eeprom access
Date: Thu, 17 Nov 2011 14:12:11 +0100
Message-ID: <1321535534-7950-15-git-send-email-dh.herrmann@googlemail.com>
References: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:40756 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130Ab1KQNNH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Nov 2011 08:13:07 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so1873584eye.19
        for <linux-input@vger.kernel.org>; Thu, 17 Nov 2011 05:13:06 -0800 (PST)
In-Reply-To: <1321535534-7950-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, oneukum@suse.de, David Herrmann <dh.herrmann@googlemail.com>

The wiimote provides direct access to parts of its eeprom. This implements read
support for small chunks of the eeprom. This isn't very fast but prevents the
reader from blocking the wiimote stream for too long.

Write support is not yet supported as the wiimote breaks if we overwrite its
memory. Use hidraw to reverse-engineer the eeprom before implementing write
support here.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-core.c  |   10 +----
 drivers/hid/hid-wiimote-debug.c |   76 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-wiimote.h       |    7 ++++
 3 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 919abba..2fd2f03 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -320,14 +320,8 @@ static void wiiproto_req_wmem(struct wiimote_data *wdata, bool eeprom,
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
 
-#define wiiproto_req_rreg(wdata, os, sz) \
-				wiiproto_req_rmem((wdata), false, (os), (sz))
-
-#define wiiproto_req_reeprom(wdata, os, sz) \
-				wiiproto_req_rmem((wdata), true, (os), (sz))
-
-static void wiiproto_req_rmem(struct wiimote_data *wdata, bool eeprom,
-						__u32 offset, __u16 size)
+void wiiproto_req_rmem(struct wiimote_data *wdata, bool eeprom, __u32 offset,
+								__u16 size)
 {
 	__u8 cmd[7];
 
diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index 6282e3c..f81243c 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -10,12 +10,80 @@
  * any later version.
  */
 
+#include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/uaccess.h>
 #include "hid-wiimote.h"
 
 struct wiimote_debug {
 	struct wiimote_data *wdata;
+	struct dentry *eeprom;
+};
+
+static int wiidebug_eeprom_open(struct inode *i, struct file *f)
+{
+	f->private_data = i->i_private;
+	return 0;
+}
+
+static ssize_t wiidebug_eeprom_read(struct file *f, char __user *u, size_t s,
+								loff_t *off)
+{
+	struct wiimote_debug *dbg = f->private_data;
+	struct wiimote_data *wdata = dbg->wdata;
+	unsigned long flags;
+	ssize_t ret;
+	char buf[16];
+	__u16 size;
+
+	if (s == 0)
+		return -EINVAL;
+	if (*off > 0xffffff)
+		return 0;
+	if (s > 16)
+		s = 16;
+
+	ret = wiimote_cmd_acquire(wdata);
+	if (ret)
+		return ret;
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
+		return ret;
+	else if (size == 0)
+		return -EIO;
+
+	if (copy_to_user(u, buf, size))
+		return -EFAULT;
+
+	*off += size;
+	ret = size;
+
+	return ret;
+}
+
+static const struct file_operations wiidebug_eeprom_fops = {
+	.owner = THIS_MODULE,
+	.open = wiidebug_eeprom_open,
+	.read = wiidebug_eeprom_read,
+	.llseek = generic_file_llseek,
 };
 
 int wiidebug_init(struct wiimote_data *wdata)
@@ -29,6 +97,13 @@ int wiidebug_init(struct wiimote_data *wdata)
 
 	dbg->wdata = wdata;
 
+	dbg->eeprom = debugfs_create_file("eeprom", S_IRUSR,
+		dbg->wdata->hdev->debug_dir, dbg, &wiidebug_eeprom_fops);
+	if (!dbg->eeprom) {
+		kfree(dbg);
+		return -ENOMEM;
+	}
+
 	spin_lock_irqsave(&wdata->state.lock, flags);
 	wdata->debug = dbg;
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
@@ -48,5 +123,6 @@ void wiidebug_deinit(struct wiimote_data *wdata)
 	wdata->debug = NULL;
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
+	debugfs_remove(dbg->eeprom);
 	kfree(dbg);
 }
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 89b8851..7b67657 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -120,6 +120,13 @@ extern int wiimote_cmd_write(struct wiimote_data *wdata, __u32 offset,
 extern ssize_t wiimote_cmd_read(struct wiimote_data *wdata, __u32 offset,
 							__u8 *rmem, __u8 size);
 
+#define wiiproto_req_rreg(wdata, os, sz) \
+				wiiproto_req_rmem((wdata), false, (os), (sz))
+#define wiiproto_req_reeprom(wdata, os, sz) \
+				wiiproto_req_rmem((wdata), true, (os), (sz))
+extern void wiiproto_req_rmem(struct wiimote_data *wdata, bool eeprom,
+						__u32 offset, __u16 size);
+
 #ifdef CONFIG_HID_WIIMOTE_EXT
 
 extern int wiiext_init(struct wiimote_data *wdata);
-- 
1.7.7.3

