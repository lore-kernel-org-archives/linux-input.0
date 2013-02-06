From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] Input: wacom - add support for DTH-2242
Date: Tue,  5 Feb 2013 18:10:24 -0800
Message-ID: <1360116624-2457-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:52652 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754612Ab3BFCKm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Feb 2013 21:10:42 -0500
Received: by mail-pa0-f44.google.com with SMTP id kp1so490347pab.31
        for <linux-input@vger.kernel.org>; Tue, 05 Feb 2013 18:10:42 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pingc@wacom.com>

It is a pen with 10 finger touch device.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   25 ++++++++++++++++++++++++-
 drivers/input/tablet/wacom_wac.h |    1 +
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 264138f..562ff03 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -359,6 +359,7 @@ static int wacom_intuos_inout(struct wacom_wac *wacom)
 		case 0x802: /* Intuos4 General Pen */
 		case 0x804: /* Intuos4 Marker Pen */
 		case 0x40802: /* Intuos4 Classic Pen */
+		case 0x18803: /* DTH2242 Grip Pen */
 		case 0x022:
 			wacom->tool[idx] = BTN_TOOL_PEN;
 			break;
@@ -538,6 +539,13 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 				input_report_key(input, wacom->tool[1], 0);
 				input_report_abs(input, ABS_MISC, 0);
 			}
+		} else if (features->type == DTK) {
+			input_report_key(input, BTN_0, (data[6] & 0x01));
+			input_report_key(input, BTN_1, (data[6] & 0x02));
+			input_report_key(input, BTN_2, (data[6] & 0x04));
+			input_report_key(input, BTN_3, (data[6] & 0x08));
+			input_report_key(input, BTN_4, (data[6] & 0x10));
+			input_report_key(input, BTN_5, (data[6] & 0x20));
 		} else if (features->type == WACOM_24HD) {
 			input_report_key(input, BTN_0, (data[6] & 0x01));
 			input_report_key(input, BTN_1, (data[6] & 0x02));
@@ -1319,6 +1327,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case WACOM_21UX2:
 	case WACOM_22HD:
 	case WACOM_24HD:
+	case DTK:
 		sync = wacom_intuos_irq(wacom_wac);
 		break;
 
@@ -1513,12 +1522,17 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 		__set_bit(BTN_Y, input_dev->keybit);
 		__set_bit(BTN_Z, input_dev->keybit);
 
-		for (i = 0; i < 10; i++)
+		for (i = 6; i < 10; i++)
 			__set_bit(BTN_0 + i, input_dev->keybit);
 
 		__set_bit(KEY_PROG1, input_dev->keybit);
 		__set_bit(KEY_PROG2, input_dev->keybit);
 		__set_bit(KEY_PROG3, input_dev->keybit);
+		/* fall through */
+
+	case DTK:
+		for (i = 0; i < 6; i++)
+			__set_bit(BTN_0 + i, input_dev->keybit);
 
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_set_abs_params(input_dev, ABS_THROTTLE, 0, 71, 0, 0);
@@ -1978,6 +1992,13 @@ static const struct wacom_features wacom_features_0xCE =
 static const struct wacom_features wacom_features_0xF0 =
 	{ "Wacom DTU1631",        WACOM_PKGLEN_GRAPHIRE,  34623, 19553,  511,
 	  0, DTU, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x59 = /* Pen */
+	{ "Wacom DTH2242",        WACOM_PKGLEN_INTUOS,    95840, 54260, 2047,
+	  63, DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5D };
+static const struct wacom_features wacom_features_0x5D = /* Touch */
+	{ "Wacom DTH2242",       .type = WACOM_24HDT,
+	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x59, .touch_max = 10 };
 static const struct wacom_features wacom_features_0xCC =
 	{ "Wacom Cintiq 21UX2",   WACOM_PKGLEN_INTUOS,    87200, 65600, 2047,
 	  63, WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
@@ -2152,6 +2173,8 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x43) },
 	{ USB_DEVICE_WACOM(0x44) },
 	{ USB_DEVICE_WACOM(0x45) },
+	{ USB_DEVICE_WACOM(0x59) },
+	{ USB_DEVICE_WACOM(0x5D) },
 	{ USB_DEVICE_WACOM(0xB0) },
 	{ USB_DEVICE_WACOM(0xB1) },
 	{ USB_DEVICE_WACOM(0xB2) },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 9396d77..cf2cd7b 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -78,6 +78,7 @@ enum {
 	INTUOS5L,
 	WACOM_21UX2,
 	WACOM_22HD,
+	DTK,
 	WACOM_24HD,
 	CINTIQ,
 	WACOM_BEE,
-- 
1.7.10.4

