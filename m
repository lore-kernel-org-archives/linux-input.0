From: David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 15/16] HID: wiimote: Allow direct DRM debug access
Date: Sun, 13 Nov 2011 14:27:18 +0100
Message-ID: <1321190839-3517-16-git-send-email-dh.herrmann@googlemail.com>
References: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43554 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab1KMN2Q (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Nov 2011 08:28:16 -0500
Received: by mail-bw0-f46.google.com with SMTP id 11so4910956bke.19
        for <linux-input@vger.kernel.org>; Sun, 13 Nov 2011 05:28:15 -0800 (PST)
In-Reply-To: <1321190839-3517-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, David Herrmann <dh.herrmann@googlemail.com>

Keep track of current drm and add new debugfs file which reads or writes the
current DRM.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 drivers/hid/hid-wiimote-core.c  |    2 +
 drivers/hid/hid-wiimote-debug.c |  107 +++++++++++++++++++++++++++++++++++++--
 drivers/hid/hid-wiimote.h       |    2 +
 3 files changed, 107 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 2fd2f03..745667e 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -238,6 +238,7 @@ void wiiproto_req_drm(struct wiimote_data *wdata, __u8 drm)
 	cmd[1] = 0;
 	cmd[2] = drm;
 
+	wdata->state.drm = drm;
 	wiiproto_keep_rumble(wdata, &cmd[1]);
 	wiimote_queue(wdata, cmd, sizeof(cmd));
 }
@@ -1141,6 +1142,7 @@ static struct wiimote_data *wiimote_create(struct hid_device *hdev)
 	spin_lock_init(&wdata->state.lock);
 	init_completion(&wdata->state.ready);
 	mutex_init(&wdata->state.sync);
+	wdata->state.drm = WIIPROTO_REQ_DRM_K;
 
 	return wdata;
 
diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index f81243c..17dabc1 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -12,6 +12,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/module.h>
+#include <linux/seq_file.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
 #include "hid-wiimote.h"
@@ -19,6 +20,7 @@
 struct wiimote_debug {
 	struct wiimote_data *wdata;
 	struct dentry *eeprom;
+	struct dentry *drm;
 };
 
 static int wiidebug_eeprom_open(struct inode *i, struct file *f)
@@ -86,10 +88,97 @@ static const struct file_operations wiidebug_eeprom_fops = {
 	.llseek = generic_file_llseek,
 };
 
+static const char *wiidebug_drmmap[] = {
+	[WIIPROTO_REQ_NULL] = "NULL",
+	[WIIPROTO_REQ_DRM_K] = "K",
+	[WIIPROTO_REQ_DRM_KA] = "KA",
+	[WIIPROTO_REQ_DRM_KE] = "KE",
+	[WIIPROTO_REQ_DRM_KAI] = "KAI",
+	[WIIPROTO_REQ_DRM_KEE] = "KEE",
+	[WIIPROTO_REQ_DRM_KAE] = "KAE",
+	[WIIPROTO_REQ_DRM_KIE] = "KIE",
+	[WIIPROTO_REQ_DRM_KAIE] = "KAIE",
+	[WIIPROTO_REQ_DRM_E] = "E",
+	[WIIPROTO_REQ_DRM_SKAI1] = "SKAI1",
+	[WIIPROTO_REQ_DRM_SKAI2] = "SKAI2",
+	[WIIPROTO_REQ_MAX] = NULL
+};
+
+static int wiidebug_drm_show(struct seq_file *f, void *p)
+{
+	struct wiimote_debug *dbg = f->private;
+	const char *str = NULL;
+	unsigned long flags;
+	__u8 drm;
+
+	spin_lock_irqsave(&dbg->wdata->state.lock, flags);
+	drm = dbg->wdata->state.drm;
+	spin_unlock_irqrestore(&dbg->wdata->state.lock, flags);
+
+	if (drm < WIIPROTO_REQ_MAX)
+		str = wiidebug_drmmap[drm];
+	if (!str)
+		str = "unknown";
+
+	seq_printf(f, "%s\n", str);
+
+	return 0;
+}
+
+static int wiidebug_drm_open(struct inode *i, struct file *f)
+{
+	return single_open(f, wiidebug_drm_show, i->i_private);
+}
+
+static ssize_t wiidebug_drm_write(struct file *f, const char __user *u,
+							size_t s, loff_t *off)
+{
+	struct wiimote_debug *dbg = f->private_data;
+	unsigned long flags;
+	char buf[16];
+	ssize_t len;
+	int i;
+
+	if (s == 0)
+		return -EINVAL;
+
+	len = min((size_t) 15, s);
+	if (copy_from_user(buf, u, len))
+		return -EFAULT;
+
+	buf[15] = 0;
+
+	for (i = 0; i < WIIPROTO_REQ_MAX; ++i) {
+		if (!wiidebug_drmmap[i])
+			continue;
+		if (!strcasecmp(buf, wiidebug_drmmap[i]))
+			break;
+	}
+
+	if (i == WIIPROTO_REQ_MAX)
+		i = simple_strtoul(buf, NULL, 10);
+
+	spin_lock_irqsave(&dbg->wdata->state.lock, flags);
+	wiiproto_req_drm(dbg->wdata, (__u8) i);
+	spin_unlock_irqrestore(&dbg->wdata->state.lock, flags);
+
+	return len;
+}
+
+static const struct file_operations wiidebug_drm_fops = {
+	.owner = THIS_MODULE,
+	.open = wiidebug_drm_open,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.write = wiidebug_drm_write,
+	.release = single_release,
+};
+
 int wiidebug_init(struct wiimote_data *wdata)
 {
 	struct wiimote_debug *dbg;
 	unsigned long flags;
+	int ret = -ENOMEM;
 
 	dbg = kzalloc(sizeof(*dbg), GFP_KERNEL);
 	if (!dbg)
@@ -99,16 +188,25 @@ int wiidebug_init(struct wiimote_data *wdata)
 
 	dbg->eeprom = debugfs_create_file("eeprom", S_IRUSR,
 		dbg->wdata->hdev->debug_dir, dbg, &wiidebug_eeprom_fops);
-	if (!dbg->eeprom) {
-		kfree(dbg);
-		return -ENOMEM;
-	}
+	if (!dbg->eeprom)
+		goto err;
+
+	dbg->drm = debugfs_create_file("drm", S_IRUSR,
+			dbg->wdata->hdev->debug_dir, dbg, &wiidebug_drm_fops);
+	if (!dbg->drm)
+		goto err_drm;
 
 	spin_lock_irqsave(&wdata->state.lock, flags);
 	wdata->debug = dbg;
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
 	return 0;
+
+err_drm:
+	debugfs_remove(dbg->eeprom);
+err:
+	kfree(dbg);
+	return ret;
 }
 
 void wiidebug_deinit(struct wiimote_data *wdata)
@@ -123,6 +221,7 @@ void wiidebug_deinit(struct wiimote_data *wdata)
 	wdata->debug = NULL;
 	spin_unlock_irqrestore(&wdata->state.lock, flags);
 
+	debugfs_remove(dbg->drm);
 	debugfs_remove(dbg->eeprom);
 	kfree(dbg);
 }
diff --git a/drivers/hid/hid-wiimote.h b/drivers/hid/hid-wiimote.h
index 7b67657..c81dbeb 100644
--- a/drivers/hid/hid-wiimote.h
+++ b/drivers/hid/hid-wiimote.h
@@ -52,6 +52,7 @@ struct wiimote_state {
 	spinlock_t lock;
 	__u8 flags;
 	__u8 accel_split[2];
+	__u8 drm;
 
 	/* synchronous cmd requests */
 	struct mutex sync;
@@ -109,6 +110,7 @@ enum wiiproto_reqs {
 	WIIPROTO_REQ_DRM_E = 0x3d,
 	WIIPROTO_REQ_DRM_SKAI1 = 0x3e,
 	WIIPROTO_REQ_DRM_SKAI2 = 0x3f,
+	WIIPROTO_REQ_MAX
 };
 
 #define dev_to_wii(pdev) hid_get_drvdata(container_of(pdev, struct hid_device, \
-- 
1.7.7.3

