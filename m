From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] input - wacom: add support to Cintiq 22HD
Date: Tue, 10 Jul 2012 18:21:53 -0700
Message-ID: <1341969713-25402-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62224 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544Ab2GKBRn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jul 2012 21:17:43 -0400
Received: by pbbrp8 with SMTP id rp8so1130224pbb.19
        for <linux-input@vger.kernel.org>; Tue, 10 Jul 2012 18:17:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |   21 +++++++++++++++++++--
 drivers/input/tablet/wacom_wac.h |    3 ++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 6533f44..0020419 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -464,7 +464,7 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
 		t = (data[6] << 2) | ((data[7] >> 6) & 3);
 		if ((features->type >= INTUOS4S && features->type <= INTUOS4L) ||
                     (features->type >= INTUOS5S && features->type <= INTUOS5L) ||
-		    features->type == WACOM_21UX2 || features->type == WACOM_24HD) {
+		    (features->type >= WACOM_21UX2 && features->type <= WACOM_24HD)) {
 			t = (t << 1) | (data[1] & 1);
 		}
 		input_report_abs(input, ABS_PRESSURE, t);
@@ -614,7 +614,7 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 				input_report_abs(input, ABS_MISC, 0);
 			}
 		} else {
-			if (features->type == WACOM_21UX2) {
+			if (features->type == WACOM_21UX2 || features->type == WACOM_22HD) {
 				input_report_key(input, BTN_0, (data[5] & 0x01));
 				input_report_key(input, BTN_1, (data[6] & 0x01));
 				input_report_key(input, BTN_2, (data[6] & 0x02));
@@ -633,6 +633,12 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 				input_report_key(input, BTN_Z, (data[8] & 0x20));
 				input_report_key(input, BTN_BASE, (data[8] & 0x40));
 				input_report_key(input, BTN_BASE2, (data[8] & 0x80));
+
+				if (features->type == WACOM_22HD) {
+					input_report_key(input, KEY_PROG1, data[9] & 0x01);
+					input_report_key(input, KEY_PROG2, data[9] & 0x02);
+					input_report_key(input, KEY_PROG3, data[9] & 0x04);
+				}
 			} else {
 				input_report_key(input, BTN_0, (data[5] & 0x01));
 				input_report_key(input, BTN_1, (data[5] & 0x02));
@@ -1231,6 +1237,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case CINTIQ:
 	case WACOM_BEE:
 	case WACOM_21UX2:
+	case WACOM_22HD:
 	case WACOM_24HD:
 		sync = wacom_intuos_irq(wacom_wac);
 		break;
@@ -1432,6 +1439,12 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 		wacom_setup_cintiq(wacom_wac);
 		break;
 
+	case WACOM_22HD:
+		__set_bit(KEY_PROG1, input_dev->keybit);
+		__set_bit(KEY_PROG2, input_dev->keybit);
+		__set_bit(KEY_PROG3, input_dev->keybit);
+		/* fall through */
+
 	case WACOM_21UX2:
 		__set_bit(BTN_A, input_dev->keybit);
 		__set_bit(BTN_B, input_dev->keybit);
@@ -1858,6 +1871,9 @@ static const struct wacom_features wacom_features_0xF0 =
 static const struct wacom_features wacom_features_0xCC =
 	{ "Wacom Cintiq 21UX2",   WACOM_PKGLEN_INTUOS,    87200, 65600, 2047,
 	  63, WACOM_21UX2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+static const struct wacom_features wacom_features_0xFA =
+	{ "Wacom Cintiq 22HD",    WACOM_PKGLEN_INTUOS,    95840, 54260, 2047,
+	  63, WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0x90 =
 	{ "Wacom ISDv4 90",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
 	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2075,6 +2091,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xEF) },
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
+	{ USB_DEVICE_WACOM(0xFA) },
 	{ USB_DEVICE_LENOVO(0x6004) },
 	{ }
 };
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index bd5d37b..96c185c 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -73,8 +73,9 @@ enum {
 	INTUOS5S,
 	INTUOS5,
 	INTUOS5L,
-	WACOM_24HD,
 	WACOM_21UX2,
+	WACOM_22HD,
+	WACOM_24HD,
 	CINTIQ,
 	WACOM_BEE,
 	WACOM_MO,
-- 
1.7.7.6

