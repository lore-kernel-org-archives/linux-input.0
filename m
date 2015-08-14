From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] drivers/hid: Fix debugfs_create_dir's error checking method for hid-core
Date: Sat, 15 Aug 2015 00:43:37 +0600
Message-ID: <1439577817-9948-1-git-send-email-kuleshovmail@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
List-Id: linux-input@vger.kernel.org

The debugfs_create_dir() function returns NULL if an error occurs. This patch
adds check of the result of the debufs_create_dir() execution in the
hid_debug_register().

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 drivers/hid/hid-core.c  | 6 ++++--
 drivers/hid/hid-debug.c | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index e6fce23..315a980 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2599,8 +2599,10 @@ int hid_add_device(struct hid_device *hdev)
 	ret = device_add(&hdev->dev);
 	if (!ret)
 		hdev->status |= HID_STAT_ADDED;
-	else
-		hid_debug_unregister(hdev);
+	else {
+		if (hdev->debug_dir)
+			hid_debug_unregister(hdev);
+	}
 
 	return ret;
 }
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 2886b64..80fa03d 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1223,6 +1223,9 @@ static const struct file_operations hid_debug_events_fops = {
 void hid_debug_register(struct hid_device *hdev, const char *name)
 {
 	hdev->debug_dir = debugfs_create_dir(name, hid_debug_root);
+	if (!hdev->debug_dir)
+		return -ENOMEM;
+
 	hdev->debug_rdesc = debugfs_create_file("rdesc", 0400,
 			hdev->debug_dir, hdev, &hid_debug_rdesc_fops);
 	hdev->debug_events = debugfs_create_file("events", 0400,
-- 
2.5.0
