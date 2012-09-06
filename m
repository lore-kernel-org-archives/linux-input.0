From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 4/5] Input: wacom - Clean up wacom_query_tablet_data
Date: Thu,  6 Sep 2012 15:53:29 -0700
Message-ID: <1346972010-1330-4-git-send-email-killertofu@gmail.com>
References: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51702 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755090Ab2IFWxr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Sep 2012 18:53:47 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so3164584pbb.19
        for <linux-input@vger.kernel.org>; Thu, 06 Sep 2012 15:53:47 -0700 (PDT)
In-Reply-To: <1346972010-1330-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, pinglinux@gmail.com, chris@cnpbagwell.com
Cc: Jason Gerecke <killertofu@gmail.com>

Rewrites this function to be easier to read and understand. The new
function 'wacom_set_device_mode' now handles the grunt work of
assembling the proper feature report, sending it to the device,
and ensuring the setting "sticks".

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_sys.c | 74 +++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 39 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 08ab0b0..b34a92b 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -500,56 +500,52 @@ static int wacom_parse_hid(struct usb_interface *intf,
 	return result;
 }
 
-static int wacom_query_tablet_data(struct usb_interface *intf, struct wacom_features *features)
+static int wacom_set_device_mode(struct usb_interface *intf, int report_id, int length, int mode)
 {
 	unsigned char *rep_data;
-	int limit = 0, report_id = 2;
-	int error = -ENOMEM;
+	int error = -ENOMEM, limit = 0;
 
-	rep_data = kmalloc(4, GFP_KERNEL);
+	rep_data = kzalloc(length, GFP_KERNEL);
 	if (!rep_data)
 		return error;
 
-	/* ask to report Wacom data */
+	rep_data[0] = report_id;
+	rep_data[1] = mode;
+
+	do {
+		error = wacom_set_report(intf, WAC_HID_FEATURE_REPORT,
+		                         report_id, rep_data, length, 1);
+		if (error >= 0)
+			error = wacom_get_report(intf, WAC_HID_FEATURE_REPORT,
+			                         report_id, rep_data, length, 1);
+	} while ((error < 0 || rep_data[1] != mode) && limit++ < WAC_MSG_RETRIES);
+
+	kfree(rep_data);
+
+	return error < 0 ? error : 0;
+}
+
+/*
+ * Switch the tablet into its most-capable mode. Wacom tablets are
+ * typically configured to power-up in a mode which sends mouse-like
+ * reports to the OS. To get absolute position, pressure data, etc.
+ * from the tablet, it is necessary to switch the tablet out of this
+ * mode and into one which sends the full range of tablet data.
+ */
+static int wacom_query_tablet_data(struct usb_interface *intf, struct wacom_features *features)
+{
 	if (features->device_type == BTN_TOOL_FINGER) {
-		/* if it is an MT Tablet PC touch */
 		if (features->type > TABLETPC) {
-			do {
-				rep_data[0] = 3;
-				rep_data[1] = 4;
-				rep_data[2] = 0;
-				rep_data[3] = 0;
-				report_id = 3;
-				error = wacom_set_report(intf,
-							 WAC_HID_FEATURE_REPORT,
-							 report_id,
-							 rep_data, 4, 1);
-				if (error >= 0)
-					error = wacom_get_report(intf,
-							WAC_HID_FEATURE_REPORT,
-							report_id,
-							rep_data, 4, 1);
-			} while ((error < 0 || rep_data[1] != 4) &&
-				 limit++ < WAC_MSG_RETRIES);
+			/* MT Tablet PC touch */
+			return wacom_set_device_mode(intf, 3, 4, 4);
+		}
+	} else if (features->device_type == BTN_TOOL_PEN) {
+		if (features->type <= BAMBOO_PT && features->type != WIRELESS) {
+			return wacom_set_device_mode(intf, 2, 2, 2);
 		}
-	} else if (features->type <= BAMBOO_PT &&
-		   features->type != WIRELESS &&
-		   features->device_type == BTN_TOOL_PEN) {
-		do {
-			rep_data[0] = 2;
-			rep_data[1] = 2;
-			error = wacom_set_report(intf, WAC_HID_FEATURE_REPORT,
-						 report_id, rep_data, 2, 1);
-			if (error >= 0)
-				error = wacom_get_report(intf,
-						WAC_HID_FEATURE_REPORT,
-						report_id, rep_data, 2, 1);
-		} while ((error < 0 || rep_data[1] != 2) && limit++ < WAC_MSG_RETRIES);
 	}
 
-	kfree(rep_data);
-
-	return error < 0 ? error : 0;
+	return 0;
 }
 
 static int wacom_retrieve_hid_descriptor(struct usb_interface *intf,
-- 
1.7.12

