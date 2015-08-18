From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH v2] drivers/hid: Check result of debugfs_create_dir() and debugfs_create_file()
Date: Wed, 19 Aug 2015 00:35:09 +0600
Message-ID: <1439922909-18452-1-git-send-email-kuleshovmail@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:34409 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbbHRSfp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Aug 2015 14:35:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>

The debugfs_create_dir() and debugfs_create_file() functions may return -errno
if an error occurs. This patch adds a couple of checks of the result of the
debufs_create_dir() and debugfs_create_file() functions execution in the
hid_debug_register() and othre places.

Changelog:

v2:

  * add check for the result of the debugfs_create_file() calls
  * call hid_debug_init() and hid_debug_exit() only if hid_debug
  * add check for the hid_debug_root in the hid_debug_register()

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 drivers/hid/hid-core.c  | 15 ++++++++++-----
 drivers/hid/hid-debug.c | 38 ++++++++++++++++++++++++++++++++++----
 2 files changed, 44 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e6fce23..8aa2c20 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2599,8 +2599,10 @@ int hid_add_device(struct hid_device *hdev)
 	ret = device_add(&hdev->dev);
 	if (!ret)
 		hdev->status |= HID_STAT_ADDED;
-	else
-		hid_debug_unregister(hdev);
+	else {
+		if (hdev->debug)
+			hid_debug_unregister(hdev);
+	}
 
 	return ret;
 }
@@ -2644,7 +2646,8 @@ static void hid_remove_device(struct hid_device *hdev)
 {
 	if (hdev->status & HID_STAT_ADDED) {
 		device_del(&hdev->dev);
-		hid_debug_unregister(hdev);
+		if (hdev->debug)
+			hid_debug_unregister(hdev);
 		hdev->status &= ~HID_STAT_ADDED;
 	}
 	kfree(hdev->dev_rdesc);
@@ -2737,7 +2740,8 @@ static int __init hid_init(void)
 	if (ret)
 		goto err_bus;
 
-	hid_debug_init();
+	if (hid_debug)
+		hid_debug_init();
 
 	return 0;
 err_bus:
@@ -2748,7 +2752,8 @@ err:
 
 static void __exit hid_exit(void)
 {
-	hid_debug_exit();
+	if (hid_debug)
+		hid_debug_exit();
 	hidraw_exit();
 	bus_unregister(&hid_bus_type);
 }
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 2886b64..5db1e6e 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1222,30 +1222,60 @@ static const struct file_operations hid_debug_events_fops = {
 
 void hid_debug_register(struct hid_device *hdev, const char *name)
 {
+	if (!hid_debug_root)
+		goto debugfs_root_error
+
 	hdev->debug_dir = debugfs_create_dir(name, hid_debug_root);
+
+	if (!hdev->debug_dir) {
+		printk(KERN_WARNING "Could not create '%s' debugfs directory\n",
+			name);
+		return;
+	}
+
 	hdev->debug_rdesc = debugfs_create_file("rdesc", 0400,
 			hdev->debug_dir, hdev, &hid_debug_rdesc_fops);
+	if (!hdev->debug_rdesc) {
+		printk(KERN_WARNING "Could not create rdesc debugfs file\n");
+		goto error
+	}
+
 	hdev->debug_events = debugfs_create_file("events", 0400,
 			hdev->debug_dir, hdev, &hid_debug_events_fops);
+	if (!hdev->debug_events) {
+		printk(KERN_WARNING "Could not create events debugfs file\n");
+		goto error
+	}
+
 	hdev->debug = 1;
+
+	return;
+
+error:
+	debugfs_remove_recursive(hdev->debug_dir);
+	return;
+
+debugfs_root_error:
+	return;
 }
 
 void hid_debug_unregister(struct hid_device *hdev)
 {
 	hdev->debug = 0;
 	wake_up_interruptible(&hdev->debug_wait);
-	debugfs_remove(hdev->debug_rdesc);
-	debugfs_remove(hdev->debug_events);
-	debugfs_remove(hdev->debug_dir);
+	debugfs_remove_recursive(hdev->debug_dir);
 }
 
 void hid_debug_init(void)
 {
 	hid_debug_root = debugfs_create_dir("hid", NULL);
+	if (!hid_debug_root)
+		printk(KERN_WARNING "Could not create root 'hid' debugfs directory\n");
 }
 
 void hid_debug_exit(void)
 {
-	debugfs_remove_recursive(hid_debug_root);
+	if (hid_debug_root)
+		debugfs_remove_recursive(hid_debug_root);
 }
 
-- 
2.5.0

