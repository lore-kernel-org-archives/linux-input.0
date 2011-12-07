From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH v2 1/2] Input: wacom: Add support for Cintiq 24HD
Date: Wed,  7 Dec 2011 15:04:56 -0800
Message-ID: <1323299097-1576-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:36774 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750696Ab1LGXGT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Dec 2011 18:06:19 -0500
Received: by iakc1 with SMTP id c1so1598012iak.19
        for <linux-input@vger.kernel.org>; Wed, 07 Dec 2011 15:06:19 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pinglinux@gmail.com, dmitry.torokhov@gmail.com
Cc: Jason Gerecke <killertofu@gmail.com>

Adds support for the Cintiq 24HD. There are two quirks about this
model that haven't been seen in prior tablets. First, a second
touch ring is present on this display; it is being exposed via the
ABS_THROTTLE axis. Second, three capacitive buttons at the top of
the unit are available; though physically a touch strip, we report
the use of these buttons with generic KEY_ events.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
Changes from v1:
 * s/ABS_WHEEL2/ABS_THROTTLE/
 * Clarify comment about clearing 2nd wheel value

 drivers/input/tablet/wacom_wac.c |   77 +++++++++++++++++++++++++++++++++++++-
 drivers/input/tablet/wacom_wac.h |    1 +
 2 files changed, 77 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index ecfcbc8..a22e778 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -452,7 +452,7 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
 	if ((data[1] & 0xb8) == 0xa0) {
 		t = (data[6] << 2) | ((data[7] >> 6) & 3);
 		if ((features->type >= INTUOS4S && features->type <= INTUOS4L) ||
-		    features->type == WACOM_21UX2) {
+		    features->type == WACOM_21UX2 || features->type == WACOM_24HD) {
 			t = (t << 1) | (data[1] & 1);
 		}
 		input_report_abs(input, ABS_PRESSURE, t);
@@ -519,6 +519,56 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 				input_report_key(input, wacom->tool[1], 0);
 				input_report_abs(input, ABS_MISC, 0);
 			}
+		} else if (features->type == WACOM_24HD) {
+			input_report_key(input, BTN_0, (data[6] & 0x01));
+			input_report_key(input, BTN_1, (data[6] & 0x02));
+			input_report_key(input, BTN_2, (data[6] & 0x04));
+			input_report_key(input, BTN_3, (data[6] & 0x08));
+			input_report_key(input, BTN_4, (data[6] & 0x10));
+			input_report_key(input, BTN_5, (data[6] & 0x20));
+			input_report_key(input, BTN_6, (data[6] & 0x40));
+			input_report_key(input, BTN_7, (data[6] & 0x80));
+			input_report_key(input, BTN_8, (data[8] & 0x01));
+			input_report_key(input, BTN_9, (data[8] & 0x02));
+			input_report_key(input, BTN_A, (data[8] & 0x04));
+			input_report_key(input, BTN_B, (data[8] & 0x08));
+			input_report_key(input, BTN_C, (data[8] & 0x10));
+			input_report_key(input, BTN_X, (data[8] & 0x20));
+			input_report_key(input, BTN_Y, (data[8] & 0x40));
+			input_report_key(input, BTN_Z, (data[8] & 0x80));
+
+			/*
+			 * Three "buttons" are available on the 24HD which are
+			 * physically implemented as a touchstrip. Each button
+			 * is approximately 3 bits wide with a 2 bit spacing.
+			 * The raw touchstrip bits are stored at:
+			 *    ((data[3] & 0x1f) << 8) | data[4])
+			 */
+			input_report_key(input, KEY_PROG1, data[4] & 0x07);
+			input_report_key(input, KEY_PROG2, data[4] & 0xE0);
+			input_report_key(input, KEY_PROG3, data[3] & 0x1C);
+
+			if (data[1] & 0x80) {
+				input_report_abs(input, ABS_WHEEL, (data[1] & 0x7f));
+			} else {
+				/* Out of proximity, clear wheel value. */
+				input_report_abs(input, ABS_WHEEL, 0);
+			}
+
+			if (data[2] & 0x80) {
+				input_report_abs(input, ABS_THROTTLE, (data[2] & 0x7f));
+			} else {
+				/* Out of proximity, clear second wheel value. */
+				input_report_abs(input, ABS_THROTTLE, 0);
+			}
+
+			if (data[1] | data[2] | (data[3] & 0x1f) | data[4] | data[6] | data[8]) {
+				input_report_key(input, wacom->tool[1], 1);
+				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+			} else {
+				input_report_key(input, wacom->tool[1], 0);
+				input_report_abs(input, ABS_MISC, 0);
+			}
 		} else {
 			if (features->type == WACOM_21UX2) {
 				input_report_key(input, BTN_0, (data[5] & 0x01));
@@ -1019,6 +1069,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case CINTIQ:
 	case WACOM_BEE:
 	case WACOM_21UX2:
+	case WACOM_24HD:
 		sync = wacom_intuos_irq(wacom_wac);
 		break;
 
@@ -1174,6 +1225,26 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 		break;
 
+	case WACOM_24HD:
+		__set_bit(BTN_A, input_dev->keybit);
+		__set_bit(BTN_B, input_dev->keybit);
+		__set_bit(BTN_C, input_dev->keybit);
+		__set_bit(BTN_X, input_dev->keybit);
+		__set_bit(BTN_Y, input_dev->keybit);
+		__set_bit(BTN_Z, input_dev->keybit);
+
+		for (i = 0; i < 10; i++)
+			__set_bit(BTN_0 + i, input_dev->keybit);
+
+		__set_bit(KEY_PROG1, input_dev->keybit);
+		__set_bit(KEY_PROG2, input_dev->keybit);
+		__set_bit(KEY_PROG3, input_dev->keybit);
+
+		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+		input_set_abs_params(input_dev, ABS_THROTTLE, 0, 71, 0, 0);
+		wacom_setup_cintiq(wacom_wac);
+		break;
+
 	case WACOM_21UX2:
 		__set_bit(BTN_A, input_dev->keybit);
 		__set_bit(BTN_B, input_dev->keybit);
@@ -1503,6 +1574,9 @@ static const struct wacom_features wacom_features_0xBB =
 static const struct wacom_features wacom_features_0xBC =
 	{ "Wacom Intuos4 WL",     WACOM_PKGLEN_INTUOS,    40840, 25400, 2047,
 	  63, INTUOS4, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+static const struct wacom_features wacom_features_0xF4 =
+	{ "Wacom Cintiq 24HD",    WACOM_PKGLEN_INTUOS,   104480, 65600, 2047,
+	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0x3F =
 	{ "Wacom Cintiq 21UX",    WACOM_PKGLEN_INTUOS,    87200, 65600, 1023,
 	  63, CINTIQ, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
@@ -1702,6 +1776,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xE3) },
 	{ USB_DEVICE_WACOM(0xE6) },
 	{ USB_DEVICE_WACOM(0x47) },
+	{ USB_DEVICE_WACOM(0xF4) },
 	{ USB_DEVICE_LENOVO(0x6004) },
 	{ }
 };
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 27f1d1c..050acae 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -59,6 +59,7 @@ enum {
 	INTUOS4S,
 	INTUOS4,
 	INTUOS4L,
+	WACOM_24HD,
 	WACOM_21UX2,
 	CINTIQ,
 	WACOM_BEE,
-- 
1.7.7.3

