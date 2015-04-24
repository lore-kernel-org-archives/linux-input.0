From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH v3] HID: wacom: retrieve name from HID descriptor for generic devices
Date: Fri, 24 Apr 2015 15:32:51 -0700
Message-ID: <1429914771-32172-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:35806 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755263AbbDXWcr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Apr 2015 18:32:47 -0400
Received: by pabtp1 with SMTP id tp1so60142270pab.2
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2015 15:32:47 -0700 (PDT)
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

Names from descriptor may contain extra whitespaces. To comfort
readers' eyes, we removed those extra whitespaces too.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Jason Gerecke <killertofu@gmail.com>
---
v3: get rid of trailing whitespace as suggested by Jason.
---
 drivers/hid/wacom_sys.c | 57 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 1b00d8d..c78f5b0 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1392,6 +1392,52 @@ static size_t wacom_compute_pktlen(struct hid_device *hdev)
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
+					break;
+				/* shift everything including the terminator */
+				memmove(gap, gap+1, strlen(gap));
+			}
+			/* get rid of trailing whitespace */
+			if (wacom_wac->name[strlen(wacom_wac->name)-1] == ' ')
+				wacom_wac->name[strlen(wacom_wac->name)-1] = '\0';
+		} else {
+			/* no meaningful name retrieved. use product ID */
+			snprintf(wacom_wac->name, sizeof(wacom_wac->name),
+				 "%s %X", features->name, wacom->hdev->product);
+		}
+	} else {
+		strlcpy(wacom_wac->name, features->name, sizeof(wacom_wac->name));
+	}
+
+	/* Append the device type to the name */
+	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
+		"%s Pad", wacom_wac->name);
+
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
@@ -1517,17 +1562,7 @@ static int wacom_probe(struct hid_device *hdev,
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

