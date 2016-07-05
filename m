From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 10/27] HID: wacom: use devm_kasprintf for allocating the name of the remote
Date: Tue,  5 Jul 2016 16:39:06 +0200
Message-ID: <1467729563-23318-11-git-send-email-benjamin.tissoires@redhat.com>
References: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467729563-23318-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The sysfs group was indeed removed by kobject_put(wacom->remote_dir) in
wacom_remove(), but the name of the group was never freed.

Also remove the misplaced kobject_put(wacom->remote_dir) in the error
path of wacom_remote_create_attr_group().

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index c08a752..ec088c1 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -25,7 +25,6 @@
 #define WAC_CMD_RETRIES		10
 #define WAC_CMD_DELETE_PAIRING	0x20
 #define WAC_CMD_UNPAIR_ALL	0xFF
-#define WAC_REMOTE_SERIAL_MAX_STRLEN	9
 
 #define DEV_ATTR_RW_PERM (S_IRUGO | S_IWUSR | S_IWGRP)
 #define DEV_ATTR_WO_PERM (S_IWUSR | S_IWGRP)
@@ -1233,23 +1232,21 @@ DEVICE_EKR_ATTR_GROUP(4);
 int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial, int index)
 {
 	int error = 0;
-	char *buf;
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 
 	wacom_wac->serial[index] = serial;
 
-	buf = kzalloc(WAC_REMOTE_SERIAL_MAX_STRLEN, GFP_KERNEL);
-	if (!buf)
+	wacom->remote_group[index].name = devm_kasprintf(&wacom->hdev->dev,
+							 GFP_KERNEL,
+							 "%d", serial);
+	if (!wacom->remote_group[index].name)
 		return -ENOMEM;
-	snprintf(buf, WAC_REMOTE_SERIAL_MAX_STRLEN, "%d", serial);
-	wacom->remote_group[index].name = buf;
 
 	error = sysfs_create_group(wacom->remote_dir,
 				   &wacom->remote_group[index]);
 	if (error) {
 		hid_err(wacom->hdev,
 			"cannot create sysfs group err: %d\n", error);
-		kobject_put(wacom->remote_dir);
 		return error;
 	}
 
@@ -1271,7 +1268,8 @@ void wacom_remote_destroy_attr_group(struct wacom *wacom, __u32 serial)
 			if (wacom->remote_group[i].name) {
 				sysfs_remove_group(wacom->remote_dir,
 						   &wacom->remote_group[i]);
-				kfree(wacom->remote_group[i].name);
+				devm_kfree(&wacom->hdev->dev,
+					   (char *)wacom->remote_group[i].name);
 				wacom->remote_group[i].name = NULL;
 			}
 		}
-- 
2.5.5
