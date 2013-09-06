From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] Input: wacom - add support for three new Intuos Pro devices
Date: Fri,  6 Sep 2013 11:50:20 -0700
Message-ID: <1378493420-5740-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36596 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab3IFSuY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Sep 2013 14:50:24 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so3627488pdj.12
        for <linux-input@vger.kernel.org>; Fri, 06 Sep 2013 11:50:24 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c | 10 ++++++++--
 drivers/input/tablet/wacom_wac.c | 37 ++++++++++++++++++++++++++++++-------
 drivers/input/tablet/wacom_wac.h |  3 +++
 3 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 79b69ea..cec3f9a 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -719,7 +719,7 @@ static int wacom_led_control(struct wacom *wacom)
 		return -ENOMEM;
 
 	if (wacom->wacom_wac.features.type >= INTUOS5S &&
-	    wacom->wacom_wac.features.type <= INTUOS5L)	{
+	    wacom->wacom_wac.features.type <= INTUOSPL)	{
 		/*
 		 * Touch Ring and crop mark LED luminance may take on
 		 * one of four values:
@@ -981,6 +981,9 @@ static int wacom_initialize_leds(struct wacom *wacom)
 	case INTUOS5S:
 	case INTUOS5:
 	case INTUOS5L:
+	case INTUOSPS:
+	case INTUOSPM:
+	case INTUOSPL:
 		wacom->led.select[0] = 0;
 		wacom->led.select[1] = 0;
 		wacom->led.llv = 32;
@@ -1024,6 +1027,9 @@ static void wacom_destroy_leds(struct wacom *wacom)
 	case INTUOS5S:
 	case INTUOS5:
 	case INTUOS5L:
+	case INTUOSPS:
+	case INTUOSPM:
+	case INTUOSPL:
 		sysfs_remove_group(&wacom->intf->dev.kobj,
 				   &intuos5_led_attr_group);
 		break;
@@ -1298,7 +1304,7 @@ static int wacom_probe(struct usb_interface *intf, const struct usb_device_id *i
 	 * HID descriptor. If this is the touch interface (wMaxPacketSize
 	 * of WACOM_PKGLEN_BBTOUCH3), override the table values.
 	 */
-	if (features->type >= INTUOS5S && features->type <= INTUOS5L) {
+	if (features->type >= INTUOS5S && features->type <= INTUOSPL) {
 		if (endpoint->wMaxPacketSize == WACOM_PKGLEN_BBTOUCH3) {
 			features->device_type = BTN_TOOL_FINGER;
 			features->pktlen = WACOM_PKGLEN_BBTOUCH3;
diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 541197b..d15dfdb 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -619,14 +619,14 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 			} else {
 				input_report_abs(input, ABS_MISC, 0);
 			}
-		} else if (features->type >= INTUOS5S && features->type <= INTUOS5L) {
+		} else if (features->type >= INTUOS5S && features->type <= INTUOSPL) {
 			int i;
 
 			/* Touch ring mode switch has no capacitive sensor */
 			input_report_key(input, BTN_0, (data[3] & 0x01));
 
 			/*
-			 * ExpressKeys on Intuos5 have a capacitive sensor in
+			 * ExpressKeys on Intuos5/Intuos Pro have a capacitive sensor in
 			 * addition to the mechanical switch. Switch data is
 			 * stored in data[4], capacitive data in data[5].
 			 */
@@ -714,7 +714,9 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	     features->type == INTUOS4 ||
 	     features->type == INTUOS4S ||
 	     features->type == INTUOS5 ||
-	     features->type == INTUOS5S)) {
+	     features->type == INTUOS5S ||
+	     features->type == INTUOSPM ||
+	     features->type == INTUOSPS)) {
 
 		return 0;
 	}
@@ -767,8 +769,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 
 		} else if (wacom->tool[idx] == BTN_TOOL_MOUSE) {
 			/* I4 mouse */
-			if ((features->type >= INTUOS4S && features->type <= INTUOS4L) ||
-			    (features->type >= INTUOS5S && features->type <= INTUOS5L)) {
+			if (features->type >= INTUOS4S && features->type <= INTUOSPL) {
 				input_report_key(input, BTN_LEFT,   data[6] & 0x01);
 				input_report_key(input, BTN_MIDDLE, data[6] & 0x02);
 				input_report_key(input, BTN_RIGHT,  data[6] & 0x04);
@@ -795,7 +796,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 				}
 			}
 		} else if ((features->type < INTUOS3S || features->type == INTUOS3L ||
-				features->type == INTUOS4L || features->type == INTUOS5L) &&
+				features->type == INTUOS4L || features->type == INTUOS5L ||
+				features->type == INTUOSPL) &&
 			   wacom->tool[idx] == BTN_TOOL_LENS) {
 			/* Lens cursor packets */
 			input_report_key(input, BTN_LEFT,   data[8] & 0x01);
@@ -1335,6 +1337,9 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case INTUOS5S:
 	case INTUOS5:
 	case INTUOS5L:
+	case INTUOSPS:
+	case INTUOSPM:
+	case INTUOSPL:
 		if (len == WACOM_PKGLEN_BBTOUCH3)
 			sync = wacom_bpt3_touch(wacom_wac);
 		else
@@ -1418,7 +1423,7 @@ void wacom_setup_device_quirks(struct wacom_features *features)
 
 	/* these device have multiple inputs */
 	if (features->type >= WIRELESS ||
-	    (features->type >= INTUOS5S && features->type <= INTUOS5L) ||
+	    (features->type >= INTUOS5S && features->type <= INTUOSPL) ||
 	    (features->oVid && features->oPid))
 		features->quirks |= WACOM_QUIRK_MULTI_INPUT;
 
@@ -1625,6 +1630,8 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 	case INTUOS5:
 	case INTUOS5L:
+	case INTUOSPM:
+	case INTUOSPL:
 		if (features->device_type == BTN_TOOL_PEN) {
 			__set_bit(BTN_7, input_dev->keybit);
 			__set_bit(BTN_8, input_dev->keybit);
@@ -1632,6 +1639,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 		/* fall through */
 
 	case INTUOS5S:
+	case INTUOSPS:
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 
 		if (features->device_type == BTN_TOOL_PEN) {
@@ -1950,6 +1958,18 @@ static const struct wacom_features wacom_features_0x29 =
 static const struct wacom_features wacom_features_0x2A =
 	{ "Wacom Intuos5 M", WACOM_PKGLEN_INTUOS,  44704, 27940, 2047,
 	  63, INTUOS5, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+static const struct wacom_features wacom_features_0x314 =
+	{ "Wacom Intuos Pro S", WACOM_PKGLEN_INTUOS,  31496, 19685, 2047,
+	  63, INTUOSPS, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  .touch_max = 16 };
+static const struct wacom_features wacom_features_0x315 =
+	{ "Wacom Intuos Pro M", WACOM_PKGLEN_INTUOS,  44704, 27940, 2047,
+	  63, INTUOSPM, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  .touch_max = 16 };
+static const struct wacom_features wacom_features_0x317 =
+	{ "Wacom Intuos Pro L", WACOM_PKGLEN_INTUOS,  65024, 40640, 2047,
+	  63, INTUOSPL, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  .touch_max = 16 };
 static const struct wacom_features wacom_features_0xF4 =
 	{ "Wacom Cintiq 24HD",       WACOM_PKGLEN_INTUOS,   104480, 65600, 2047,
 	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
@@ -2241,6 +2261,9 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x101) },
 	{ USB_DEVICE_WACOM(0x10D) },
 	{ USB_DEVICE_WACOM(0x304) },
+	{ USB_DEVICE_DETAILED(0x314, USB_CLASS_HID, 0, 0) },
+	{ USB_DEVICE_DETAILED(0x315, USB_CLASS_HID, 0, 0) },
+	{ USB_DEVICE_DETAILED(0x317, USB_CLASS_HID, 0, 0) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index dfc9e08..d6dec58 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -76,6 +76,9 @@ enum {
 	INTUOS5S,
 	INTUOS5,
 	INTUOS5L,
+	INTUOSPS,
+	INTUOSPM,
+	INTUOSPL,
 	WACOM_21UX2,
 	WACOM_22HD,
 	DTK,
-- 
1.8.1.2

