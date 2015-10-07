From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Add support for Cintiq Companion 2
Date: Wed,  7 Oct 2015 16:55:44 -0700
Message-ID: <1444262144-19327-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33898 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbbJGX4C (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2015 19:56:02 -0400
Received: by padhy16 with SMTP id hy16so35209449pad.1
        for <linux-input@vger.kernel.org>; Wed, 07 Oct 2015 16:56:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, expiredpopsicle@gmail.com, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
Signed-off-by: Clifford Jolly <expiredpopsicle@gmail.com>
---
 drivers/hid/wacom_sys.c |  2 +-
 drivers/hid/wacom_wac.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 drivers/hid/wacom_wac.h |  1 +
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 5f6e48e..2e7a1c7 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -420,7 +420,7 @@ static int wacom_query_tablet_data(struct hid_device *hdev,
 			/* MT Tablet PC touch */
 			return wacom_set_device_mode(hdev, 3, 4, 4);
 		}
-		else if (features->type == WACOM_24HDT || features->type == CINTIQ_HYBRID) {
+		else if (features->type == WACOM_24HDT || features->type == CINTIQ_HYBRID || features->type == CINTIQ_COMPANION_2) {
 			return wacom_set_device_mode(hdev, 18, 3, 2);
 		}
 		else if (features->type == WACOM_27QHDT) {
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 46bd02b..44d4cc3 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -765,7 +765,7 @@ static void wacom_intuos_general(struct wacom_wac *wacom)
 	/* general pen packet */
 	if ((data[1] & 0xb8) == 0xa0) {
 		t = (data[6] << 2) | ((data[7] >> 6) & 3);
-		if (features->type >= INTUOS4S && features->type <= CINTIQ_HYBRID) {
+		if (features->type >= INTUOS4S && features->type <= CINTIQ_COMPANION_2) {
 			t = (t << 1) | (data[1] & 1);
 		}
 		input_report_abs(input, ABS_PRESSURE, t);
@@ -948,6 +948,27 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 			} else {
 				input_report_abs(input, ABS_MISC, 0);
 			}
+
+		} else if (features->type == CINTIQ_COMPANION_2) {
+			input_report_key(input, BTN_1, (data[1] & 0x02));
+			input_report_key(input, BTN_2, (data[2] & 0x01));
+			input_report_key(input, BTN_3, (data[2] & 0x02));
+			input_report_key(input, BTN_4, (data[2] & 0x04));
+			input_report_key(input, BTN_5, (data[2] & 0x08));
+			input_report_key(input, BTN_6, (data[1] & 0x04));
+
+			input_report_key(input, BTN_7, (data[2] & 0x10));  /* Right  */
+			input_report_key(input, BTN_8, (data[2] & 0x20));  /* Up	 */
+			input_report_key(input, BTN_9, (data[2] & 0x40));  /* Left   */
+			input_report_key(input, BTN_A, (data[2] & 0x80));  /* Down   */
+			input_report_key(input, BTN_0, (data[1] & 0x01));  /* Center */
+
+			if (data[4] | (data[3] & 0x01)) {
+				input_report_abs(input, ABS_MISC, PAD_DEVICE_ID);
+			} else {
+				input_report_abs(input, ABS_MISC, 0);
+			}
+
 		} else if (features->type >= INTUOS5S && features->type <= INTUOSPL) {
 			int i;
 
@@ -2290,6 +2311,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case WACOM_27QHD:
 	case DTK:
 	case CINTIQ_HYBRID:
+	case CINTIQ_COMPANION_2:
 		sync = wacom_intuos_irq(wacom_wac);
 		break;
 
@@ -2543,6 +2565,7 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 	case CINTIQ:
 	case WACOM_13HD:
 	case CINTIQ_HYBRID:
+	case CINTIQ_COMPANION_2:
 		input_set_abs_params(input_dev, ABS_Z, -900, 899, 0, 0);
 		input_abs_set_res(input_dev, ABS_Z, 287);
 		__set_bit(INPUT_PROP_DIRECT, input_dev->propbit);
@@ -2595,6 +2618,12 @@ int wacom_setup_pen_input_capabilities(struct input_dev *input_dev,
 		__clear_bit(ABS_MISC, input_dev->absbit);
 		/* fall through */
 
+	case CINTIQ_COMPANION_2:
+		for (i = 0; i < 10; i++)
+			__set_bit(BTN_0 + i, input_dev->keybit);
+		__set_bit(BTN_A, input_dev->keybit);
+		break;
+
 	case DTUS:
 	case DTUSX:
 	case PL:
@@ -3347,6 +3376,14 @@ static const struct wacom_features wacom_features_0x318 =
 static const struct wacom_features wacom_features_0x319 =
 	{ "Wacom Wireless Bamboo PAD", 4095, 4095, /* Touch */
 	  .type = BAMBOO_PAD, 35, 48, .touch_max = 4 };
+static const struct wacom_features wacom_features_0x325 =
+	{ "Wacom ISDv5 325", 59552, 33848, 2047, 63,
+	  CINTIQ_COMPANION_2, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
+	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x326 };
+static const struct wacom_features wacom_features_0x326 = /* Touch */
+	{ "Wacom ISDv5 326", .type = HID_GENERIC, .oVid = USB_VENDOR_ID_WACOM,
+	  .oPid = 0x325 };
 static const struct wacom_features wacom_features_0x323 =
 	{ "Wacom Intuos P M", 21600, 13500, 1023, 31,
 	  INTUOSHT, WACOM_INTUOS_RES, WACOM_INTUOS_RES,
@@ -3506,6 +3543,8 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x318) },
 	{ USB_DEVICE_WACOM(0x319) },
 	{ USB_DEVICE_WACOM(0x323) },
+	{ USB_DEVICE_WACOM(0x325) },
+	{ USB_DEVICE_WACOM(0x326) },
 	{ USB_DEVICE_WACOM(0x32A) },
 	{ USB_DEVICE_WACOM(0x32B) },
 	{ USB_DEVICE_WACOM(0x32C) },
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 809c03e..5a1ec76 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -124,6 +124,7 @@ enum {
 	WACOM_24HD,
 	WACOM_27QHD,
 	CINTIQ_HYBRID,
+	CINTIQ_COMPANION_2,
 	CINTIQ,
 	WACOM_BEE,
 	WACOM_13HD,
-- 
2.6.1

