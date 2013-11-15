From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/4 v3] Input: wacom - add support for three new Intuos devices
Date: Fri, 15 Nov 2013 11:59:44 -0800
Message-ID: <1384545584-15510-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:58445 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010Ab3KOT7v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Nov 2013 14:59:51 -0500
Received: by mail-pa0-f54.google.com with SMTP id lj1so4087520pab.13
        for <linux-input@vger.kernel.org>; Fri, 15 Nov 2013 11:59:51 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, killertofu@gmail.com, chris@cnpbagwell.com, peter.hutterer@who-t.net, Ping Cheng <pingc@wacom.com>

Two tablets in this series support both pen and touch. One (Intuos S)
only supports pen. This patch also updates the driver to process wireless
devices that do not support touch interface.

Tested-by: Jason Gerecke <killertofu@gmail.com>
Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>
Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |  6 ++--
 drivers/input/tablet/wacom_wac.c | 62 ++++++++++++++++++++++++++++++----------
 drivers/input/tablet/wacom_wac.h |  2 ++
 3 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 3d71b60..3a7d99c 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -1198,7 +1198,8 @@ static void wacom_wireless_work(struct work_struct *work)
 			goto fail;
 
 		/* Touch interface */
-		if (wacom_wac1->features.touch_max) {
+		if (wacom_wac1->features.touch_max ||
+		    wacom_wac1->features.type == INTUOSHT) {
 			wacom_wac2->features =
 				*((struct wacom_features *)id->driver_info);
 			wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
@@ -1321,7 +1322,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	 * HID descriptor. If this is the touch interface (wMaxPacketSize
 	 * of WACOM_PKGLEN_BBTOUCH3), override the table values.
 	 */
-	if (features->type >= INTUOS5S && features->type <= INTUOSPL) {
+	if (features->type >= INTUOS5S && features->type <= INTUOSHT) {
 		if (endpoint->wMaxPacketSize == WACOM_PKGLEN_BBTOUCH3) {
 			features->device_type = BTN_TOOL_FINGER;
 			features->pktlen = WACOM_PKGLEN_BBTOUCH3;
@@ -1391,7 +1392,6 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 			goto fail5;
 		}
 	}
-
 	return 0;
 
  fail5: wacom_destroy_leds(wacom);
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 3f75f1d..c0cd85d 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1176,10 +1176,17 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
 static void wacom_bpt3_button_msg(struct wacom_wac *wacom, unsigned char *data)
 {
 	struct input_dev *input = wacom->input;
+	struct wacom_features *features = &wacom->features;
 
-	input_report_key(input, BTN_LEFT, (data[1] & 0x08) != 0);
+	if (features->type == INTUOSHT) {
+		input_report_key(input, BTN_LEFT, (data[1] & 0x02) != 0);
+		input_report_key(input, BTN_BACK, (data[1] & 0x08) != 0);
+	} else {
+
+		input_report_key(input, BTN_BACK, (data[1] & 0x02) != 0);
+		input_report_key(input, BTN_LEFT, (data[1] & 0x08) != 0);
+	}
 	input_report_key(input, BTN_FORWARD, (data[1] & 0x04) != 0);
-	input_report_key(input, BTN_BACK, (data[1] & 0x02) != 0);
 	input_report_key(input, BTN_RIGHT, (data[1] & 0x01) != 0);
 }
 
@@ -1217,7 +1224,7 @@ static int wacom_bpt_pen(struct wacom_wac *wacom)
 	unsigned char *data = wacom->data;
 	int prox = 0, x = 0, y = 0, p = 0, d = 0, pen = 0, btn1 = 0, btn2 = 0;
 
-	if (data[0] != 0x02)
+	if (data[0] != WACOM_REPORT_PENABLED)
 	    return 0;
 
 	prox = (data[1] & 0x20) == 0x20;
@@ -1297,7 +1304,7 @@ static int wacom_wireless_irq(struct wacom_wac *wacom, size_t len)
 	unsigned char *data = wacom->data;
 	int connected;
 
-	if (len != WACOM_PKGLEN_WIRELESS || data[0] != 0x80)
+	if (len != WACOM_PKGLEN_WIRELESS || data[0] != WACOM_REPORT_WL)
 		return 0;
 
 	connected = data[1] & 0x01;
@@ -1391,6 +1398,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case BAMBOO_PT:
+	case INTUOSHT:
 		sync = wacom_bpt_irq(wacom_wac, len);
 		break;
 
@@ -1459,7 +1467,7 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 
 	/* these device have multiple inputs */
 	if (features->type >= WIRELESS ||
-	    (features->type >= INTUOS5S && features->type <= INTUOSPL) ||
+	    (features->type >= INTUOS5S && features->type <= INTUOSHT) ||
 	    (features->oVid && features->oPid))
 		features->quirks |= WACOM_QUIRK_MULTI_INPUT;
 
@@ -1771,33 +1779,43 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 		break;
 
+	case INTUOSHT:
 	case BAMBOO_PT:
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
-		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
-
 		if (features->device_type == BTN_TOOL_FINGER) {
-			unsigned int flags = INPUT_MT_POINTER;
 
 			__set_bit(BTN_LEFT, input_dev->keybit);
 			__set_bit(BTN_FORWARD, input_dev->keybit);
 			__set_bit(BTN_BACK, input_dev->keybit);
 			__set_bit(BTN_RIGHT, input_dev->keybit);
 
-			if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
-				input_set_abs_params(input_dev,
+			if (features->touch_max) {
+				/* touch interface */
+				unsigned int flags = INPUT_MT_POINTER;
+
+				__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
+				if (features->pktlen == WACOM_PKGLEN_BBTOUCH3) {
+					input_set_abs_params(input_dev,
 						     ABS_MT_TOUCH_MAJOR,
 						     0, features->x_max, 0, 0);
-				input_set_abs_params(input_dev,
+					input_set_abs_params(input_dev,
 						     ABS_MT_TOUCH_MINOR,
 						     0, features->y_max, 0, 0);
+				} else {
+					__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
+					__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
+					flags = 0;
+				}
+				input_mt_init_slots(input_dev, features->touch_max, flags);
 			} else {
-				__set_bit(BTN_TOOL_FINGER, input_dev->keybit);
-				__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
-				flags = 0;
+				/* buttons/keys only interface */
+				__clear_bit(ABS_X, input_dev->absbit);
+				__clear_bit(ABS_Y, input_dev->absbit);
+				__clear_bit(BTN_TOUCH, input_dev->keybit);
 			}
-			input_mt_init_slots(input_dev, features->touch_max, flags);
 		} else if (features->device_type == BTN_TOOL_PEN) {
+			__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
 			__set_bit(BTN_STYLUS, input_dev->keybit);
@@ -2194,6 +2212,17 @@ static const struct wacom_features wacom_features_0x300 =
 static const struct wacom_features wacom_features_0x301 =
 	{ "Wacom Bamboo One M",    WACOM_PKGLEN_BBPEN,    21648, 13530, 1023,
 	  31, BAMBOO_PT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x302 =
+	{ "Wacom Intuos PT S",     WACOM_PKGLEN_BBPEN,    15200,  9500, 1023,
+	  31, INTUOSHT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 16 };
+static const struct wacom_features wacom_features_0x303 =
+	{ "Wacom Intuos PT M",     WACOM_PKGLEN_BBPEN,    21600, 13500, 1023,
+	  31, INTUOSHT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  .touch_max = 16 };
+static const struct wacom_features wacom_features_0x30E =
+	{ "Wacom Intuos S",        WACOM_PKGLEN_BBPEN,    15200,  9500, 1023,
+	  31, INTUOSHT, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x6004 =
 	{ "ISD-V4",               WACOM_PKGLEN_GRAPHIRE,  12800,  8000,  255,
 	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2329,6 +2358,9 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x10D) },
 	{ USB_DEVICE_WACOM(0x300) },
 	{ USB_DEVICE_WACOM(0x301) },
+	{ USB_DEVICE_DETAILED(0x302, USB_CLASS_HID, 0, 0) },
+	{ USB_DEVICE_DETAILED(0x303, USB_CLASS_HID, 0, 0) },
+	{ USB_DEVICE_DETAILED(0x30E, USB_CLASS_HID, 0, 0) },
 	{ USB_DEVICE_WACOM(0x304) },
 	{ USB_DEVICE_DETAILED(0x314, USB_CLASS_HID, 0, 0) },
 	{ USB_DEVICE_DETAILED(0x315, USB_CLASS_HID, 0, 0) },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index fd23a37..854cceb 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -54,6 +54,7 @@
 #define WACOM_REPORT_TPCST		16
 #define WACOM_REPORT_TPC1FGE		18
 #define WACOM_REPORT_24HDT		1
+#define WACOM_REPORT_WL			128
 
 /* device quirks */
 #define WACOM_QUIRK_MULTI_INPUT		0x0001
@@ -81,6 +82,7 @@ enum {
 	INTUOSPS,
 	INTUOSPM,
 	INTUOSPL,
+	INTUOSHT,
 	WACOM_21UX2,
 	WACOM_22HD,
 	DTK,
-- 
1.8.3.2

