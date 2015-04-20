From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH v2] HID: wacom: retrieve name from HID descriptor for generic devices
Date: Mon, 20 Apr 2015 14:09:59 -0700
Message-ID: <1429564199-16873-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:34416 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357AbbDTVKE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Apr 2015 17:10:04 -0400
Received: by pdbqa5 with SMTP id qa5so219151563pdb.1
        for <linux-input@vger.kernel.org>; Mon, 20 Apr 2015 14:10:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>

HID generic devices share the same default name, "Wacom HID". This
causes userland programs to show same device names for different
devices, which would confuse end users with same device names for
different devices too.

This patch uses name retrieved from HID descriptor, if a meaningful
name is reported. Otherwise, affix its product ID to "Wacom HID".

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
v2: updated with Jason's pid affix and extract whitespace suggestions.
---
 drivers/hid/wacom_sys.c | 53 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 1b00d8d..a857cd2 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1392,6 +1392,47 @@ static size_t wacom_compute_pktlen(struct hid_device *hdev)
 	return size;
 }
 
+static void wacom_update_name(struct wacom *wacom)
+{
+	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
+	struct wacom_features *features = &wacom_wac->features;
+
+	/* Generic devices name unspecified */
+	if ((features->type == HID_GENERIC) && !strcmp("Wacom HID", features->name)) {
+		if (strstr(wacom->hdev->name, "Wacom") ||
+		    strstr(wacom->hdev->name, "wacom") ||
+		    strstr(wacom->hdev->name, "WACOM")) {
+			/* name is in HID descriptor, use it */
+			strlcpy(wacom_wac->name, wacom->hdev->name,
+				sizeof(wacom_wac->name));
+
+			/* strip out excess whitespaces */
+			while (1) {
+				char *gap = strstr(wacom_wac->name, "  ");
+				if (gap == NULL)
+	 				break;
+				memmove(gap, gap+1, strlen(gap));
+			}
+		} else {
+			/* no meaningful name retrieved. use product ID */
+			snprintf(wacom_wac->name, sizeof(wacom_wac->name),
+				 "%s %x", features->name, wacom->hdev->product);
+		}
+	} else {
+		strlcpy(wacom_wac->name, features->name, sizeof(wacom_wac->name));
+	}
+	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
+		"%s Pad", wacom_wac->name);
+
+	/* Append the device type to the name */
+	if (features->device_type != BTN_TOOL_FINGER)
+		strlcat(wacom_wac->name, " Pen", WACOM_NAME_MAX);
+	else if (features->touch_max)
+		strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
+	else
+		strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
+}
+
 static int wacom_probe(struct hid_device *hdev,
 		const struct hid_device_id *id)
 {
@@ -1517,17 +1558,7 @@ static int wacom_probe(struct hid_device *hdev,
 	}
 	wacom_calculate_res(features);
 
-	strlcpy(wacom_wac->name, features->name, sizeof(wacom_wac->name));
-	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
-		"%s Pad", features->name);
-
-	/* Append the device type to the name */
-	if (features->device_type != BTN_TOOL_FINGER)
-		strlcat(wacom_wac->name, " Pen", WACOM_NAME_MAX);
-	else if (features->touch_max)
-		strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
-	else
-		strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
+	wacom_update_name(wacom);
 
 	error = wacom_add_shared_data(hdev);
 	if (error)
-- 
1.9.1

