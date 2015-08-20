From: Aaron Skomra <skomra@gmail.com>
Subject: [PATCH 1/2] HID: wacom: Set button bits based on a new numbered_buttons
Date: Thu, 20 Aug 2015 16:05:16 -0700
Message-ID: <1440111917-4496-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33442 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbbHTXFx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 19:05:53 -0400
Received: by pdrh1 with SMTP id h1so19458387pdr.0
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2015 16:05:53 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, benjamin.tissoires@redhat.com, killertofu@gmail.com, pinglinux@gmail.com, linux-input@vger.kernel.org
Cc: Aaron Skomra <skomra@gmail.com>, Aaron Skomra <aaron.skomra@wacom.com>

Prior to this commit, numbered button bit setting was done separately
for each device type in wacom_setup_pad_capabilities(). Here we add a
numbered_buttons property to the wacom_features struct and extract the
repeated bit setting code to a new function:
wacom_settup_numbered_buttons().

Signed-off-by: Aaron Skomra <aaron.skomra@wacom.com>
Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_wac.c | 175 +++++++++++++++++-------------------------------
 drivers/hid/wacom_wac.h |   1 +
 2 files changed, 61 insertions(+), 115 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index baba9a0..a19aeae 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2513,11 +2513,23 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 	return 0;
 }
 
+void wacom_setup_numbered_buttons(struct input_dev *input_dev,
+				int button_count)
+{
+	int i;
+
+	for (i = 0; i < button_count && i < 10; i++)
+		__set_bit(BTN_0 + i, input_dev->keybit);
+	for (i = 10; i < button_count && i < 16; i++)
+		__set_bit(BTN_A + (i-10), input_dev->keybit);
+	for (i = 16; i < button_count && i < 18; i++)
+		__set_bit(BTN_BASE + (i-16), input_dev->keybit);
+}
+
 int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 				   struct wacom_wac *wacom_wac)
 {
 	struct wacom_features *features = &wacom_wac->features;
-	int i;
 
 	if (!(features->device_type & WACOM_DEVICETYPE_PAD))
 		return -ENODEV;
@@ -2534,10 +2546,14 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	/* kept for making udev and libwacom accepting the pad */
 	__set_bit(BTN_STYLUS, input_dev->keybit);
 
+	wacom_setup_numbered_buttons(input_dev, features->numbered_buttons);
+
 	switch (features->type) {
+
+	case CINTIQ_HYBRID:
+	case DTK:
+	case DTUS:
 	case GRAPHIRE_BT:
-		__set_bit(BTN_0, input_dev->keybit);
-		__set_bit(BTN_1, input_dev->keybit);
 		break;
 
 	case WACOM_MO:
@@ -2555,16 +2571,6 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case WACOM_24HD:
-		__set_bit(BTN_A, input_dev->keybit);
-		__set_bit(BTN_B, input_dev->keybit);
-		__set_bit(BTN_C, input_dev->keybit);
-		__set_bit(BTN_X, input_dev->keybit);
-		__set_bit(BTN_Y, input_dev->keybit);
-		__set_bit(BTN_Z, input_dev->keybit);
-
-		for (i = 0; i < 10; i++)
-			__set_bit(BTN_0 + i, input_dev->keybit);
-
 		__set_bit(KEY_PROG1, input_dev->keybit);
 		__set_bit(KEY_PROG2, input_dev->keybit);
 		__set_bit(KEY_PROG3, input_dev->keybit);
@@ -2586,12 +2592,6 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		__set_bit(INPUT_PROP_ACCELEROMETER, input_dev->propbit);
 		break;
 
-	case DTK:
-		for (i = 0; i < 6; i++)
-			__set_bit(BTN_0 + i, input_dev->keybit);
-
-		break;
-
 	case WACOM_22HD:
 		__set_bit(KEY_PROG1, input_dev->keybit);
 		__set_bit(KEY_PROG2, input_dev->keybit);
@@ -2599,52 +2599,22 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		/* fall through */
 
 	case WACOM_21UX2:
-		__set_bit(BTN_A, input_dev->keybit);
-		__set_bit(BTN_B, input_dev->keybit);
-		__set_bit(BTN_C, input_dev->keybit);
-		__set_bit(BTN_X, input_dev->keybit);
-		__set_bit(BTN_Y, input_dev->keybit);
-		__set_bit(BTN_Z, input_dev->keybit);
-		__set_bit(BTN_BASE, input_dev->keybit);
-		__set_bit(BTN_BASE2, input_dev->keybit);
-		/* fall through */
-
 	case WACOM_BEE:
-		__set_bit(BTN_8, input_dev->keybit);
-		__set_bit(BTN_9, input_dev->keybit);
-		/* fall through */
-
 	case CINTIQ:
-		for (i = 0; i < 8; i++)
-			__set_bit(BTN_0 + i, input_dev->keybit);
-
 		input_set_abs_params(input_dev, ABS_RX, 0, 4096, 0, 0);
 		input_set_abs_params(input_dev, ABS_RY, 0, 4096, 0, 0);
 		break;
 
 	case WACOM_13HD:
-		for (i = 0; i < 9; i++)
-			__set_bit(BTN_0 + i, input_dev->keybit);
-
 		input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
 		break;
 
 	case INTUOS3:
 	case INTUOS3L:
-		__set_bit(BTN_4, input_dev->keybit);
-		__set_bit(BTN_5, input_dev->keybit);
-		__set_bit(BTN_6, input_dev->keybit);
-		__set_bit(BTN_7, input_dev->keybit);
-
 		input_set_abs_params(input_dev, ABS_RY, 0, 4096, 0, 0);
 		/* fall through */
 
 	case INTUOS3S:
-		__set_bit(BTN_0, input_dev->keybit);
-		__set_bit(BTN_1, input_dev->keybit);
-		__set_bit(BTN_2, input_dev->keybit);
-		__set_bit(BTN_3, input_dev->keybit);
-
 		input_set_abs_params(input_dev, ABS_RX, 0, 4096, 0, 0);
 		break;
 
@@ -2652,15 +2622,8 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	case INTUOS5L:
 	case INTUOSPM:
 	case INTUOSPL:
-		__set_bit(BTN_7, input_dev->keybit);
-		__set_bit(BTN_8, input_dev->keybit);
-		/* fall through */
-
 	case INTUOS5S:
 	case INTUOSPS:
-		for (i = 0; i < 7; i++)
-			__set_bit(BTN_0 + i, input_dev->keybit);
-
 		input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
 		break;
 
@@ -2675,28 +2638,10 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 
 	case INTUOS4:
 	case INTUOS4L:
-		__set_bit(BTN_7, input_dev->keybit);
-		__set_bit(BTN_8, input_dev->keybit);
-		/* fall through */
-
 	case INTUOS4S:
-		for (i = 0; i < 7; i++)
-			__set_bit(BTN_0 + i, input_dev->keybit);
-
 		input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
 		break;
 
-	case CINTIQ_HYBRID:
-		for (i = 0; i < 9; i++)
-			__set_bit(BTN_0 + i, input_dev->keybit);
-
-		break;
-
-	case DTUS:
-		for (i = 0; i < 4; i++)
-			__set_bit(BTN_0 + i, input_dev->keybit);
-		break;
-
 	case INTUOSHT:
 	case BAMBOO_PT:
 		__clear_bit(ABS_MISC, input_dev->absbit);
@@ -2723,7 +2668,7 @@ static const struct wacom_features wacom_features_0x10 =
 	  GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RES };
 static const struct wacom_features wacom_features_0x81 =
 	{ "Wacom Graphire BT", 16704, 12064, 511, 32,
-	  GRAPHIRE_BT, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RES };
+	  GRAPHIRE_BT, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RES, 2 };
 static const struct wacom_features wacom_features_0x11 =
 	{ "Wacom Graphire2 4x5", 10206, 7422, 511, 63,
 	  GRAPHIRE, WACOM_GRAPHIRE_RES, WACOM_GRAPHIRE_RES };
@@ -2849,77 +2794,77 @@ static const struct wacom_features wacom_features_0x45 =
 	  INTUOS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xB0 =
 	{ "Wacom Intuos3 4x5", 25400, 20320, 1023, 63,
-	  INTUOS3S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS3S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 4 };
 static const struct wacom_features wacom_features_0xB1 =
 	{ "Wacom Intuos3 6x8", 40640, 30480, 1023, 63,
-	  INTUOS3, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS3, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 8 };
 static const struct wacom_features wacom_features_0xB2 =
 	{ "Wacom Intuos3 9x12", 60960, 45720, 1023, 63,
-	  INTUOS3, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS3, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 8 };
 static const struct wacom_features wacom_features_0xB3 =
 	{ "Wacom Intuos3 12x12", 60960, 60960, 1023, 63,
-	  INTUOS3L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS3L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 8 };
 static const struct wacom_features wacom_features_0xB4 =
 	{ "Wacom Intuos3 12x19", 97536, 60960, 1023, 63,
-	  INTUOS3L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS3L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 8 };
 static const struct wacom_features wacom_features_0xB5 =
 	{ "Wacom Intuos3 6x11", 54204, 31750, 1023, 63,
-	  INTUOS3, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS3, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 8 };
 static const struct wacom_features wacom_features_0xB7 =
 	{ "Wacom Intuos3 4x6", 31496, 19685, 1023, 63,
-	  INTUOS3S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS3S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 4 };
 static const struct wacom_features wacom_features_0xB8 =
 	{ "Wacom Intuos4 4x6", 31496, 19685, 2047, 63,
-	  INTUOS4S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS4S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 7 };
 static const struct wacom_features wacom_features_0xB9 =
 	{ "Wacom Intuos4 6x9", 44704, 27940, 2047, 63,
-	  INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9 };
 static const struct wacom_features wacom_features_0xBA =
 	{ "Wacom Intuos4 8x13", 65024, 40640, 2047, 63,
-	  INTUOS4L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS4L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9 };
 static const struct wacom_features wacom_features_0xBB =
 	{ "Wacom Intuos4 12x19", 97536, 60960, 2047, 63,
-	  INTUOS4L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS4L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9 };
 static const struct wacom_features wacom_features_0xBC =
 	{ "Wacom Intuos4 WL", 40640, 25400, 2047, 63,
-	  INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9 };
 static const struct wacom_features wacom_features_0xBD =
 	{ "Wacom Intuos4 WL", 40640, 25400, 2047, 63,
-	  INTUOS4WL, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS4WL, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9 };
 static const struct wacom_features wacom_features_0x26 =
 	{ "Wacom Intuos5 touch S", 31496, 19685, 2047, 63,
-	  INTUOS5S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, .touch_max = 16 };
+	  INTUOS5S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 7, .touch_max = 16 };
 static const struct wacom_features wacom_features_0x27 =
 	{ "Wacom Intuos5 touch M", 44704, 27940, 2047, 63,
-	  INTUOS5, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, .touch_max = 16 };
+	  INTUOS5, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9, .touch_max = 16 };
 static const struct wacom_features wacom_features_0x28 =
 	{ "Wacom Intuos5 touch L", 65024, 40640, 2047, 63,
-	  INTUOS5L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, .touch_max = 16 };
+	  INTUOS5L, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9, .touch_max = 16 };
 static const struct wacom_features wacom_features_0x29 =
 	{ "Wacom Intuos5 S", 31496, 19685, 2047, 63,
-	  INTUOS5S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS5S, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 7 };
 static const struct wacom_features wacom_features_0x2A =
 	{ "Wacom Intuos5 M", 44704, 27940, 2047, 63,
-	  INTUOS5, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  INTUOS5, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9 };
 static const struct wacom_features wacom_features_0x314 =
 	{ "Wacom Intuos Pro S", 31496, 19685, 2047, 63,
-	  INTUOSPS, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, .touch_max = 16,
+	  INTUOSPS, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 7, .touch_max = 16,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x315 =
 	{ "Wacom Intuos Pro M", 44704, 27940, 2047, 63,
-	  INTUOSPM, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, .touch_max = 16,
+	  INTUOSPM, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9, .touch_max = 16,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x317 =
 	{ "Wacom Intuos Pro L", 65024, 40640, 2047, 63,
-	  INTUOSPL, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, .touch_max = 16,
+	  INTUOSPL, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9, .touch_max = 16,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0xF4 =
 	{ "Wacom Cintiq 24HD", 104080, 65200, 2047, 63,
-	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 16,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0xF8 =
 	{ "Wacom Cintiq 24HD touch", 104080, 65200, 2047, 63, /* Pen */
-	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 16,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf6 };
 static const struct wacom_features wacom_features_0xF6 =
@@ -2928,11 +2873,11 @@ static const struct wacom_features wacom_features_0xF6 =
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x32A =
 	{ "Wacom Cintiq 27QHD", 119740, 67520, 2047, 63,
-	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 0,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x32B =
 	{ "Wacom Cintiq 27QHD touch", 119740, 67520, 2047, 63,
-	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 0,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x32C };
 static const struct wacom_features wacom_features_0x32C =
@@ -2940,20 +2885,20 @@ static const struct wacom_features wacom_features_0x32C =
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x32B, .touch_max = 10 };
 static const struct wacom_features wacom_features_0x3F =
 	{ "Wacom Cintiq 21UX", 87200, 65600, 1023, 63,
-	  CINTIQ, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  CINTIQ, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 8 };
 static const struct wacom_features wacom_features_0xC5 =
 	{ "Wacom Cintiq 20WSX", 86680, 54180, 1023, 63,
-	  WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 10 };
 static const struct wacom_features wacom_features_0xC6 =
 	{ "Wacom Cintiq 12WX", 53020, 33440, 1023, 63,
-	  WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+	  WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 10 };
 static const struct wacom_features wacom_features_0x304 =
 	{ "Wacom Cintiq 13HD", 59152, 33448, 1023, 63,
-	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x333 =
 	{ "Wacom Cintiq 13HD touch", 59152, 33448, 2047, 63,
-	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x335 };
 static const struct wacom_features wacom_features_0x335 =
@@ -2972,22 +2917,22 @@ static const struct wacom_features wacom_features_0xF0 =
 	  DTU, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0xFB =
 	{ "Wacom DTU1031", 21896, 13760, 511, 0,
-	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4,
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 static const struct wacom_features wacom_features_0x32F =
 	{ "Wacom DTU1031X", 22472, 12728, 511, 0,
-	  DTUSX, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
+	  DTUSX, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 0,
 	  WACOM_DTU_OFFSET, WACOM_DTU_OFFSET };
 static const struct wacom_features wacom_features_0x336 =
 	{ "Wacom DTU1141", 23472, 13203, 1023, 0,
-	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+	  DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES, 4 };
 static const struct wacom_features wacom_features_0x57 =
 	{ "Wacom DTK2241", 95640, 54060, 2047, 63,
-	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 6,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x59 = /* Pen */
 	{ "Wacom DTH2242", 95640, 54060, 2047, 63,
-	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 6,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5D };
 static const struct wacom_features wacom_features_0x5D = /* Touch */
@@ -2996,15 +2941,15 @@ static const struct wacom_features wacom_features_0x5D = /* Touch */
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0xCC =
 	{ "Wacom Cintiq 21UX2", 86800, 65200, 2047, 63,
-	  WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 18,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0xFA =
 	{ "Wacom Cintiq 22HD", 95440, 53860, 2047, 63,
-	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 18,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET };
 static const struct wacom_features wacom_features_0x5B =
 	{ "Wacom Cintiq 22HDT", 95440, 53860, 2047, 63,
-	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 18,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5e };
 static const struct wacom_features wacom_features_0x5E =
@@ -3151,7 +3096,7 @@ static const struct wacom_features wacom_features_0x6004 =
 	  TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x307 =
 	{ "Wacom ISDv5 307", 59152, 33448, 2047, 63,
-	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x309 };
 static const struct wacom_features wacom_features_0x309 =
@@ -3160,7 +3105,7 @@ static const struct wacom_features wacom_features_0x309 =
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
 static const struct wacom_features wacom_features_0x30A =
 	{ "Wacom ISDv5 30A", 59152, 33448, 2047, 63,
-	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  CINTIQ_HYBRID, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, 9,
 	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x30C };
 static const struct wacom_features wacom_features_0x30C =
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 2978c30..5f9d495 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -149,6 +149,7 @@ struct wacom_features {
 	int type;
 	int x_resolution;
 	int y_resolution;
+	int numbered_buttons;
 	int x_min;
 	int y_min;
 	int device_type;
-- 
2.4.3

