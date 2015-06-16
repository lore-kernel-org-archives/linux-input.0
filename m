From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 1/5] HID: wacom: Simplify 'wacom_update_name'
Date: Mon, 15 Jun 2015 18:01:41 -0700
Message-ID: <1434416505-12685-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34948 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbbFPBCC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Jun 2015 21:02:02 -0400
Received: by pdbnf5 with SMTP id nf5so1879456pdb.2
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2015 18:02:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

A little bit of cleanup work for 'wacom_update_name' to make it easier on
the eyes. Creates a temporary 'name' variable on which we'll perform our
edits. Once the name is in its final form, it will be copied (with
appropriate suffix) to 'wacom_wac->name' and 'wacom_wac->pad_name'.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
No changes from v1.

 drivers/hid/wacom_sys.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index eea18a6..bdf31c9 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1417,6 +1417,7 @@ static void wacom_update_name(struct wacom *wacom)
 {
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct wacom_features *features = &wacom_wac->features;
+	char name[WACOM_NAME_MAX];
 
 	/* Generic devices name unspecified */
 	if ((features->type == HID_GENERIC) && !strcmp("Wacom HID", features->name)) {
@@ -1424,41 +1425,43 @@ static void wacom_update_name(struct wacom *wacom)
 		    strstr(wacom->hdev->name, "wacom") ||
 		    strstr(wacom->hdev->name, "WACOM")) {
 			/* name is in HID descriptor, use it */
-			strlcpy(wacom_wac->name, wacom->hdev->name,
-				sizeof(wacom_wac->name));
+			strlcpy(name, wacom->hdev->name, sizeof(name));
 
 			/* strip out excess whitespaces */
 			while (1) {
-				char *gap = strstr(wacom_wac->name, "  ");
+				char *gap = strstr(name, "  ");
 				if (gap == NULL)
 					break;
 				/* shift everything including the terminator */
 				memmove(gap, gap+1, strlen(gap));
 			}
 			/* get rid of trailing whitespace */
-			if (wacom_wac->name[strlen(wacom_wac->name)-1] == ' ')
-				wacom_wac->name[strlen(wacom_wac->name)-1] = '\0';
+			if (name[strlen(name)-1] == ' ')
+				name[strlen(name)-1] = '\0';
 		} else {
 			/* no meaningful name retrieved. use product ID */
-			snprintf(wacom_wac->name, sizeof(wacom_wac->name),
+			snprintf(name, sizeof(name),
 				 "%s %X", features->name, wacom->hdev->product);
 		}
 	} else {
-		strlcpy(wacom_wac->name, features->name, sizeof(wacom_wac->name));
+		strlcpy(name, features->name, sizeof(name));
 	}
 
 	/* Append the device type to the name */
 	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
-		"%s Pad", wacom_wac->name);
+		"%s Pad", name);
 
 	if (features->device_type == BTN_TOOL_PEN) {
-		strlcat(wacom_wac->name, " Pen", WACOM_NAME_MAX);
+		snprintf(wacom_wac->name, sizeof(wacom_wac->name),
+			"%s Pen", name);
 	}
 	else if (features->device_type == BTN_TOOL_FINGER) {
 		if (features->touch_max)
-			strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
+			snprintf(wacom_wac->name, sizeof(wacom_wac->name),
+				"%s Finger", name);
 		else
-			strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
+			snprintf(wacom_wac->name, sizeof(wacom_wac->name),
+				"%s Pad", name);
 	}
 }
 
-- 
2.4.2

