From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] Input: wacom - add support for DTU-1031
Date: Thu, 16 Jan 2014 13:29:39 -0800
Message-ID: <1389907779-12125-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:57338 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbaAPV3p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jan 2014 16:29:45 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so3118523pdj.12
        for <linux-input@vger.kernel.org>; Thu, 16 Jan 2014 13:29:45 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c | 80 +++++++++++++++++++++++++++++++++++++++-
 drivers/input/tablet/wacom_wac.h |  6 ++-
 2 files changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 0bcc7a6..fed2f04 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -210,6 +210,70 @@ static int wacom_dtu_irq(struct wacom_wac *wacom)
 	return 1;
 }
 
+static int wacom_dtus_irq(struct wacom_wac *wacom)
+{
+	char *data = wacom->data;
+	struct input_dev *input = wacom->input;
+	unsigned short prox, pressure = 0;
+	int retval = 0;
+
+	if (data[0] != WACOM_REPORT_DTUS && data[0] != WACOM_REPORT_DTUSPAD) {
+		dev_dbg(input->dev.parent,
+		"%s: received unknown report #%d", __func__, data[0]);
+		goto exit;
+	}
+
+	if (data[0] == WACOM_REPORT_DTUSPAD) {
+		input_report_key(input, BTN_0, (data[1] & 0x01));
+		input_report_key(input, BTN_1, (data[1] & 0x02));
+		input_report_key(input, BTN_2, (data[1] & 0x04));
+		input_report_key(input, BTN_3, (data[1] & 0x08));
+		if (data[1] & 0x0f) {
+			input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+		} else {
+			input_report_abs(input, ABS_MISC, 0);
+		}
+		/* serial number is required when expresskeys are
+		 * reported through pen interface.
+		 */
+		input_event(input, EV_MSC, MSC_SERIAL, 0xf0);
+		retval = 1;
+		goto exit;
+	}
+
+	prox = data[1] & 0x80;
+	if (prox) {
+		switch ((data[1] >> 3) & 3) {
+		case 1: /* Rubber */
+			wacom->tool[0] = BTN_TOOL_RUBBER;
+			wacom->id[0] = ERASER_DEVICE_ID;
+			break;
+
+		case 2: /* Pen */
+			wacom->tool[0] = BTN_TOOL_PEN;
+			wacom->id[0] = STYLUS_DEVICE_ID;
+			break;
+		}
+	}
+
+	input_report_key(input, BTN_STYLUS, data[1] & 0x20);
+	input_report_key(input, BTN_STYLUS2, data[1] & 0x40);
+	input_report_abs(input, ABS_X, be16_to_cpup((__be16 *)&data[3]));
+	input_report_abs(input, ABS_Y, be16_to_cpup((__be16 *)&data[5]));
+	pressure = ((data[1] & 0x03) << 8) | (data[2] & 0xff);
+	input_report_abs(input, ABS_PRESSURE, pressure);
+	input_report_key(input, BTN_TOUCH, pressure > 10);
+
+	if (!prox) /* out-prox */
+		wacom->id[0] = 0;
+	input_report_key(input, wacom->tool[0], prox);
+	input_report_abs(input, ABS_MISC, wacom->id[0]);
+	input_event(input, EV_MSC, MSC_SERIAL, 1);
+	retval = 1;
+exit:
+	return retval;
+}
+
 static int wacom_graphire_irq(struct wacom_wac *wacom)
 {
 	struct wacom_features *features = &wacom->features;
@@ -1371,6 +1435,10 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		sync = wacom_dtu_irq(wacom_wac);
 		break;
 
+	case DTUS:
+		sync = wacom_dtus_irq(wacom_wac);
+		break;
+
 	case INTUOS:
 	case INTUOS3S:
 	case INTUOS3:
@@ -1562,7 +1630,7 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 	wacom_abs_set_axis(input_dev, wacom_wac);
 
-	switch (wacom_wac->features.type) {
+	switch (features->type) {
 	case WACOM_MO:
 		input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
 		/* fall through */
@@ -1773,8 +1841,14 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 
 		/* fall through */
 
+	case DTUS:
 	case PL:
 	case DTU:
+		if (features->type == DTUS) {
+			input_set_capability(input_dev, EV_MSC, MSC_SERIAL);
+			for (i = 0; i < 3; i++)
+				__set_bit(BTN_0 + i, input_dev->keybit);
+		}
 		__set_bit(BTN_TOOL_PEN, input_dev->keybit);
 		__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
 		__set_bit(BTN_STYLUS, input_dev->keybit);
@@ -2096,6 +2170,9 @@ static const struct wacom_features wacom_features_0xCE =
 static const struct wacom_features wacom_features_0xF0 =
 	{ "Wacom DTU1631",        WACOM_PKGLEN_GRAPHIRE,  34623, 19553,  511,
 	  0, DTU, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0xFB =
+	{ "Wacom DTU1031",        WACOM_PKGLEN_DTUS,      22096, 13960,  511,
+	  0, DTUS, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
 static const struct wacom_features wacom_features_0x57 =
 	{ "Wacom DTK2241",        WACOM_PKGLEN_INTUOS,    95840, 54260, 2047,
 	  63, DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES};
@@ -2402,6 +2479,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0xF8) },
 	{ USB_DEVICE_DETAILED(0xF6, USB_CLASS_HID, 0, 0) },
 	{ USB_DEVICE_WACOM(0xFA) },
+	{ USB_DEVICE_WACOM(0xFB) },
 	{ USB_DEVICE_WACOM(0x0307) },
 	{ USB_DEVICE_DETAILED(0x0309, USB_CLASS_HID, 0, 0) },
 	{ USB_DEVICE_LENOVO(0x6004) },
diff --git a/drivers/input/tablet/wacom_wac.h b/drivers/input/tablet/wacom_wac.h
index 3600cf7..f69c0eb 100644
--- a/drivers/input/tablet/wacom_wac.h
+++ b/drivers/input/tablet/wacom_wac.h
@@ -12,7 +12,7 @@
 #include <linux/types.h>
 
 /* maximum packet length for USB devices */
-#define WACOM_PKGLEN_MAX	64
+#define WACOM_PKGLEN_MAX	68
 
 #define WACOM_NAME_MAX		64
 
@@ -29,6 +29,7 @@
 #define WACOM_PKGLEN_WIRELESS	32
 #define WACOM_PKGLEN_MTOUCH	62
 #define WACOM_PKGLEN_MTTPC	40
+#define WACOM_PKGLEN_DTUS	68
 
 /* wacom data size per MT contact */
 #define WACOM_BYTES_PER_MT_PACKET	11
@@ -47,11 +48,13 @@
 #define WACOM_REPORT_INTUOSWRITE	6
 #define WACOM_REPORT_INTUOSPAD		12
 #define WACOM_REPORT_INTUOS5PAD		3
+#define WACOM_REPORT_DTUSPAD		21
 #define WACOM_REPORT_TPC1FG		6
 #define WACOM_REPORT_TPC2FG		13
 #define WACOM_REPORT_TPCMT		13
 #define WACOM_REPORT_TPCHID		15
 #define WACOM_REPORT_TPCST		16
+#define WACOM_REPORT_DTUS		17
 #define WACOM_REPORT_TPC1FGE		18
 #define WACOM_REPORT_24HDT		1
 #define WACOM_REPORT_WL			128
@@ -70,6 +73,7 @@ enum {
 	PTU,
 	PL,
 	DTU,
+	DTUS,
 	INTUOS,
 	INTUOS3S,
 	INTUOS3,
-- 
1.8.3.2

