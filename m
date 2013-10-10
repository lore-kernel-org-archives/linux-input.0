From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH v2 1/2] Input - wacom: Not all multi-interface devices support touch
Date: Thu, 10 Oct 2013 14:17:13 -0700
Message-ID: <1381439833-1116-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:33250 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992Ab3JJVRW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Oct 2013 17:17:22 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so3171171pbc.4
        for <linux-input@vger.kernel.org>; Thu, 10 Oct 2013 14:17:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, peter.hutterer@who-t.net, chris@cnpbagwell.com, Ping Cheng <pingc@wacom.com>

Some multi-interface devices support expresskeys on a separate interface,
such as Bamboo; some multi-interface devices do not support touch at all,
such as Pen only Intuos5. Make sure we report the right device names.

Tested-by: Jason Gerecke <killertofu@gmail.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c | 58 +++++++++++++++++++++++++---------------
 drivers/input/tablet/wacom_wac.h |  4 ++-
 2 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 63971b8..7bdb5e9 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -1188,34 +1188,47 @@ static void wacom_wireless_work(struct work_struct *work)
 		wacom_wac1->features =
 			*((struct wacom_features *)id->driver_info);
 		wacom_wac1->features.device_type = BTN_TOOL_PEN;
+		snprintf(wacom_wac1->name, WACOM_NAME_MAX, "%s (WL) Pen",
+			 wacom_wac1->features.name);
 		error = wacom_register_input(wacom1);
 		if (error)
-			goto fail1;
+			goto fail;
 
 		/* Touch interface */
-		wacom_wac2->features =
-			*((struct wacom_features *)id->driver_info);
-		wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
-		wacom_wac2->features.device_type = BTN_TOOL_FINGER;
-		wacom_wac2->features.x_max = wacom_wac2->features.y_max = 4096;
-		error = wacom_register_input(wacom2);
-		if (error)
-			goto fail2;
+		if (wacom_wac1->features.touch_max) {
+			wacom_wac2->features =
+				*((struct wacom_features *)id->driver_info);
+			wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
+			wacom_wac2->features.device_type = BTN_TOOL_FINGER;
+			wacom_wac2->features.x_max = wacom_wac2->features.y_max = 4096;
+			if (wacom_wac2->features.touch_max)
+				snprintf(wacom_wac2->name, WACOM_NAME_MAX,
+					 "%s (WL) Finger",wacom_wac2->features.name);
+			else
+				snprintf(wacom_wac2->name, WACOM_NAME_MAX,
+					 "%s (WL) Pad",wacom_wac2->features.name);
+			error = wacom_register_input(wacom2);
+			if (error)
+				goto fail;
+		}
 
 		error = wacom_initialize_battery(wacom);
 		if (error)
-			goto fail3;
+			goto fail;
 	}
 
 	return;
 
-fail3:
-	input_unregister_device(wacom_wac2->input);
-	wacom_wac2->input = NULL;
-fail2:
-	input_unregister_device(wacom_wac1->input);
-	wacom_wac1->input = NULL;
-fail1:
+fail:
+	if (wacom_wac2->input) {
+		input_unregister_device(wacom_wac2->input);
+		wacom_wac2->input = NULL;
+	}
+	if (wacom_wac1->input) {
+
+		input_unregister_device(wacom_wac1->input);
+		wacom_wac1->input = NULL;
+	}
 	return;
 }
 
@@ -1332,10 +1345,13 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 		struct usb_device *other_dev;
 
 		/* Append the device type to the name */
-		strlcat(wacom_wac->name,
-			features->device_type == BTN_TOOL_PEN ?
-				" Pen" : " Finger",
-			sizeof(wacom_wac->name));
+		if (features->device_type == BTN_TOOL_FINGER) {
+			if (features->touch_max)
+				strlcat(wacom_wac->name, " Finger", WACOM_NAME_MAX);
+			else
+				strlcat(wacom_wac->name, " Pad", WACOM_NAME_MAX);
+		} else
+			strlcat(wacom_wac->name, " Pen", WACOM_NAME_MAX);
 
 		other_dev = wacom_get_sibling(dev, features->oVid, features->oPid);
 		if (other_dev == NULL || wacom_get_usbdev_data(other_dev) == NULL)
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 2a432e6..fd23a37 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -14,6 +14,8 @@
 /* maximum packet length for USB devices */
 #define WACOM_PKGLEN_MAX	64
 
+#define WACOM_NAME_MAX		64
+
 /* packet length for individual models */
 #define WACOM_PKGLEN_PENPRTN	 7
 #define WACOM_PKGLEN_GRAPHIRE	 8
@@ -130,7 +132,7 @@ struct wacom_shared {
 };
 
 struct wacom_wac {
-	char name[64];
+	char name[WACOM_NAME_MAX];
 	unsigned char *data;
 	int tool[2];
 	int id[2];
-- 
1.8.1.2

