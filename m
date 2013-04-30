From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] input: wacom - add three new display tablets
Date: Tue, 30 Apr 2013 15:14:44 -0700
Message-ID: <1367360084-30172-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:48734 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760674Ab3D3WPB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Apr 2013 18:15:01 -0400
Received: by mail-da0-f50.google.com with SMTP id a4so432050dad.9
        for <linux-input@vger.kernel.org>; Tue, 30 Apr 2013 15:15:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Cintiq 13HD, DTK 2241, and Cintiq 22HDT are supported.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 3.7/wacom_wac.c |   36 ++++++++++++++++++++++++++++++++++++
 3.7/wacom_wac.h |    1 +
 2 files changed, 37 insertions(+)

diff --git a/3.7/wacom_wac.c b/3.7/wacom_wac.c
index 0bfd8cf..afe4fe0 100644
--- a/3.7/wacom_wac.c
+++ b/3.7/wacom_wac.c
@@ -546,6 +546,16 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 			input_report_key(input, BTN_3, (data[6] & 0x08));
 			input_report_key(input, BTN_4, (data[6] & 0x10));
 			input_report_key(input, BTN_5, (data[6] & 0x20));
+		} else if (features->type == WACOM_13HD) {
+			input_report_key(input, BTN_0, (data[3] & 0x01));
+			input_report_key(input, BTN_1, (data[4] & 0x01));
+			input_report_key(input, BTN_2, (data[4] & 0x02));
+			input_report_key(input, BTN_3, (data[4] & 0x04));
+			input_report_key(input, BTN_4, (data[4] & 0x08));
+			input_report_key(input, BTN_5, (data[4] & 0x10));
+			input_report_key(input, BTN_6, (data[4] & 0x20));
+			input_report_key(input, BTN_7, (data[4] & 0x40));
+			input_report_key(input, BTN_8, (data[4] & 0x80));
 		} else if (features->type == WACOM_24HD) {
 			input_report_key(input, BTN_0, (data[6] & 0x01));
 			input_report_key(input, BTN_1, (data[6] & 0x02));
@@ -1301,6 +1311,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case INTUOS4L:
 	case CINTIQ:
 	case WACOM_BEE:
+	case WACOM_13HD:
 	case WACOM_21UX2:
 	case WACOM_22HD:
 	case WACOM_24HD:
@@ -1579,6 +1590,15 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
 		wacom_setup_cintiq(wacom_wac);
 		break;
 
+	case WACOM_13HD:
+		for (i = 0; i < 9; i++)
+			__set_bit(BTN_0 + i, input_dev->keybit);
+
+		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
+		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
+		wacom_setup_cintiq(wacom_wac);
+		break;
+
 	case INTUOS3:
 	case INTUOS3L:
 		__set_bit(BTN_4, input_dev->keybit);
@@ -1950,6 +1970,9 @@ static const struct wacom_features wacom_features_0xC5 =
 static const struct wacom_features wacom_features_0xC6 =
 	{ "Wacom Cintiq 12WX",    WACOM_PKGLEN_INTUOS,    53020, 33440, 1023,
 	  63, WACOM_BEE, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+static const struct wacom_features wacom_features_0x304 =
+	{ "Wacom Cintiq 13HD",    WACOM_PKGLEN_INTUOS,    59552, 33848, 1023,
+	  63, WACOM_13HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
 static const struct wacom_features wacom_features_0xC7 =
 	{ "Wacom DTU1931",        WACOM_PKGLEN_GRAPHIRE,  37832, 30305,  511,
 	  0, PL, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -1959,6 +1982,9 @@ static const struct wacom_features wacom_features_0xCE =
 static const struct wacom_features wacom_features_0xF0 =
 	{ "Wacom DTU1631",        WACOM_PKGLEN_GRAPHIRE,  34623, 19553,  511,
 	  0, DTU, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
+static const struct wacom_features wacom_features_0x57 =
+	{ "Wacom DTK2241",        WACOM_PKGLEN_INTUOS,    95840, 54260, 2047,
+	  63, DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES};
 static const struct wacom_features wacom_features_0x59 = /* Pen */
 	{ "Wacom DTH2242",        WACOM_PKGLEN_INTUOS,    95840, 54260, 2047,
 	  63, DTK, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
@@ -1972,6 +1998,12 @@ static const struct wacom_features wacom_features_0xCC =
 static const struct wacom_features wacom_features_0xFA =
 	{ "Wacom Cintiq 22HD",    WACOM_PKGLEN_INTUOS,    95840, 54260, 2047,
 	  63, WACOM_22HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+static const struct wacom_features wacom_features_0x5B =
+	{ "Wacom Cintiq 22HDT", WACOM_PKGLEN_INTUOS,      95840, 54260, 2047,
+	  63, WACOM_24HD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES, .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5e };
+static const struct wacom_features wacom_features_0x5E =
+	{ "Wacom Cintiq 22HDT", .type = WACOM_24HDT,
+	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x5b, .touch_max = 10 };
 static const struct wacom_features wacom_features_0x90 =
 	{ "Wacom ISDv4 90",       WACOM_PKGLEN_GRAPHIRE,  26202, 16325,  255,
 	  0, TABLETPC, WACOM_INTUOS_RES, WACOM_INTUOS_RES };
@@ -2143,8 +2175,11 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x43) },
 	{ USB_DEVICE_WACOM(0x44) },
 	{ USB_DEVICE_WACOM(0x45) },
+	{ USB_DEVICE_WACOM(0x57) },
 	{ USB_DEVICE_WACOM(0x59) },
 	{ USB_DEVICE_DETAILED(0x5D, USB_CLASS_HID, 0, 0) },
+	{ USB_DEVICE_WACOM(0x5B) },
+	{ USB_DEVICE_DETAILED(0x5E, USB_CLASS_HID, 0, 0) },
 	{ USB_DEVICE_WACOM(0xB0) },
 	{ USB_DEVICE_WACOM(0xB1) },
 	{ USB_DEVICE_WACOM(0xB2) },
@@ -2205,6 +2240,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x100) },
 	{ USB_DEVICE_WACOM(0x101) },
 	{ USB_DEVICE_WACOM(0x10D) },
+	{ USB_DEVICE_WACOM(0x304) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
diff --git a/3.7/wacom_wac.h b/3.7/wacom_wac.h
index 5f9a772..dfc9e08 100644
--- a/3.7/wacom_wac.h
+++ b/3.7/wacom_wac.h
@@ -82,6 +82,7 @@ enum {
 	WACOM_24HD,
 	CINTIQ,
 	WACOM_BEE,
+	WACOM_13HD,
 	WACOM_MO,
 	WIRELESS,
 	BAMBOO_PT,
-- 
1.7.10.4

