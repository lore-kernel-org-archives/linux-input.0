From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] input : wacom - Integrate resolution calculation
Date: Fri, 19 Jul 2013 16:10:55 -0700
Message-ID: <1374275455-28465-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:64376 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752772Ab3GSXLH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Jul 2013 19:11:07 -0400
Received: by mail-pb0-f51.google.com with SMTP id um15so4964521pbc.10
        for <linux-input@vger.kernel.org>; Fri, 19 Jul 2013 16:11:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Reviewed-by: Jason Gerecke <killertofu@gmail.com>
Tested-by: Jason Gerecke <killertofu@gmail.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c | 75 ++++++++++++++++++----------------------
 drivers/input/tablet/wacom_wac.c | 19 +++-------
 2 files changed, 37 insertions(+), 57 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index aaf23ae..0ca248a 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -221,39 +221,6 @@ static int wacom_calc_hid_res(int logical_extents, int physical_extents,
 	return logical_extents / physical_extents;
 }
 
-/*
- * The physical dimension specified by the HID descriptor is likely not in
- * the "100th of a mm" units expected by wacom_calculate_touch_res. This
- * function adjusts the value of [xy]_phy based on the unit and exponent
- * provided by the HID descriptor. If an error occurs durring conversion
- * (e.g. from the unit being left unspecified) [xy]_phy is not modified.
- */
-static void wacom_fix_phy_from_hid(struct wacom_features *features)
-{
-	int xres = wacom_calc_hid_res(features->x_max, features->x_phy,
-					features->unit, features->unitExpo);
-	int yres = wacom_calc_hid_res(features->y_max, features->y_phy,
-					features->unit, features->unitExpo);
-
-	if (xres > 0 && yres > 0) {
-		features->x_phy = (100 * features->x_max) / xres;
-		features->y_phy = (100 * features->y_max) / yres;
-	}
-}
-
-/*
- * Static values for max X/Y and resolution of Pen interface is stored in
- * features. This mean physical size of active area can be computed.
- * This is useful to do when Pen and Touch have same active area of tablet.
- * This means for Touch device, we only need to find max X/Y value and we
- * have enough information to compute resolution of touch.
- */
-static void wacom_set_phy_from_res(struct wacom_features *features)
-{
-	features->x_phy = (features->x_max * 100) / features->x_resolution;
-	features->y_phy = (features->y_max * 100) / features->y_resolution;
-}
-
 static int wacom_parse_logical_collection(unsigned char *report,
 					  struct wacom_features *features)
 {
@@ -265,8 +232,6 @@ static int wacom_parse_logical_collection(unsigned char *report,
 		features->pktlen = WACOM_PKGLEN_BBTOUCH3;
 		features->device_type = BTN_TOOL_FINGER;
 
-		wacom_set_phy_from_res(features);
-
 		features->x_max = features->y_max =
 			get_unaligned_le16(&report[10]);
 
@@ -640,9 +605,6 @@ static int wacom_retrieve_hid_descriptor(struct usb_interface *intf,
 		}
 	}
 	error = wacom_parse_hid(intf, hid_desc, features);
-	if (error)
-		goto out;
-	wacom_fix_phy_from_hid(features);
 
  out:
 	return error;
@@ -1228,7 +1190,6 @@ static void wacom_wireless_work(struct work_struct *work)
 			*((struct wacom_features *)id->driver_info);
 		wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
 		wacom_wac2->features.device_type = BTN_TOOL_FINGER;
-		wacom_set_phy_from_res(&wacom_wac2->features);
 		wacom_wac2->features.x_max = wacom_wac2->features.y_max = 4096;
 		error = wacom_register_input(wacom2);
 		if (error)
@@ -1251,6 +1212,29 @@ fail1:
 	return;
 }
 
+/*
+ * Not all devices report physical dimensions from HID.
+ * Compute the default from hardcoded logical dimension
+ * and resolution before driver overwrites them.
+ */
+static void wacom_set_default_phy(struct wacom_features *features)
+{
+	if (features->x_resolution) {
+		features->x_phy = (features->x_max * 100) / features->x_resolution;
+		features->y_phy = (features->y_max * 100) / features->y_resolution;
+	}
+}
+
+static void wacom_calculate_res(struct wacom_features *features)
+{
+	features->x_resolution = wacom_calc_hid_res(features->x_max,
+				 features->x_phy, features->unit,
+				 features->unitExpo);
+	features->y_resolution = wacom_calc_hid_res(features->y_max,
+				 features->y_phy, features->unit,
+				 features->unitExpo);
+}
+
 static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *id)
 {
 	struct usb_device *dev = interface_to_usbdev(intf);
@@ -1297,6 +1281,9 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 
 	endpoint = &intf->cur_altsetting->endpoint[0].desc;
 
+	/* set the default size in case we do not get them from hid */
+	wacom_set_default_phy(features);
+
 	/* Retrieve the physical and logical size for touch devices */
 	error = wacom_retrieve_hid_descriptor(intf, features);
 	if (error)
@@ -1312,8 +1299,6 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 			features->device_type = BTN_TOOL_FINGER;
 			features->pktlen = WACOM_PKGLEN_BBTOUCH3;
 
-			wacom_set_phy_from_res(features);
-
 			features->x_max = 4096;
 			features->y_max = 4096;
 		} else {
@@ -1323,6 +1308,13 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 
 	wacom_setup_device_quirks(features);
 
+	/* set unit to "100th of a mm" for devices not reported by HID */
+	if (!features->unit) {
+		features->unit = 0x11;
+		features->unitExpo = 16-3;
+	}
+	wacom_calculate_res(features);
+
 	strlcpy(wacom_wac->name, features->name, sizeof(wacom_wac->name));
 
 	if (features->quirks & WACOM_QUIRK_MULTI_INPUT) {
@@ -1334,7 +1326,6 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 				" Pen" : " Finger",
 			sizeof(wacom_wac->name));
 
-
 		other_dev = wacom_get_sibling(dev, features->oVid, features->oPid);
 		if (other_dev == NULL || wacom_get_usbdev_data(other_dev) == NULL)
 			other_dev = dev;
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 384fbcd..7d691a5 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1445,13 +1445,6 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 	}
 }
 
-static unsigned int wacom_calculate_touch_res(unsigned int logical_max,
-					      unsigned int physical_max)
-{
-       /* Touch physical dimensions are in 100th of mm */
-       return (logical_max * 100) / physical_max;
-}
-
 static void wacom_abs_set_axis(struct input_dev *input_dev,
 			       struct wacom_wac *wacom_wac)
 {
@@ -1475,11 +1468,9 @@ static void wacom_abs_set_axis(struct input_dev *input_dev,
 			input_set_abs_params(input_dev, ABS_Y, 0,
 				features->y_max, features->y_fuzz, 0);
 			input_abs_set_res(input_dev, ABS_X,
-				wacom_calculate_touch_res(features->x_max,
-							features->x_phy));
+				features->x_resolution);
 			input_abs_set_res(input_dev, ABS_Y,
-				wacom_calculate_touch_res(features->y_max,
-							features->y_phy));
+				features->y_resolution);
 		}
 
 		if (features->touch_max > 1) {
@@ -1488,11 +1479,9 @@ static void wacom_abs_set_axis(struct input_dev *input_dev,
 			input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
 				features->y_max, features->y_fuzz, 0);
 			input_abs_set_res(input_dev, ABS_MT_POSITION_X,
-				wacom_calculate_touch_res(features->x_max,
-							features->x_phy));
+				features->x_resolution);
 			input_abs_set_res(input_dev, ABS_MT_POSITION_Y,
-				wacom_calculate_touch_res(features->y_max,
-							features->y_phy));
+				features->y_resolution);
 		}
 	}
 }
-- 
1.8.1.2

