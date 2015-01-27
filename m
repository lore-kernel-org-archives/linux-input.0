From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/3] Add support for Cintiq 27QHD and 27QHD touch
Date: Tue, 27 Jan 2015 13:30:03 -0800
Message-ID: <1422394203-15146-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:63906 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbA0V3t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 16:29:49 -0500
Received: by mail-pd0-f180.google.com with SMTP id ft15so21150746pdb.11
        for <linux-input@vger.kernel.org>; Tue, 27 Jan 2015 13:29:49 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

These devices have accelerometers. To report accelerometer coordinates,
a new property, INPUT_PROP_ACCELEROMETER, is added.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/hid/wacom_sys.c    |  3 ++
 drivers/hid/wacom_wac.c    | 87 ++++++++++++++++++++++++++++++++++++++--------
 drivers/hid/wacom_wac.h    |  7 +++-
 include/uapi/linux/input.h |  1 +
 4 files changed, 83 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index f01ab3a..f0568a7 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -403,6 +403,9 @@ static int wacom_query_tablet_data(struct hid_device *hdev,
 		else if (features->type == WACOM_24HDT || features->type == CINTIQ_HYBRID) {
 			return wacom_set_device_mode(hdev, 18, 3, 2);
 		}
+		else if (features->type == WACOM_27QHDT) {
+			return wacom_set_device_mode(hdev, 131, 3, 2);
+		}
 	} else if (features->device_type == BTN_TOOL_PEN) {
 		if (features->type <= BAMBOO_PT && features->type != WIRELESS) {
 			return wacom_set_device_mode(hdev, 2, 2, 2);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index d239d82..1a65079 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -656,6 +656,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 	    data[0] != WACOM_REPORT_INTUOSREAD &&
 	    data[0] != WACOM_REPORT_INTUOSWRITE &&
 	    data[0] != WACOM_REPORT_INTUOSPAD &&
+	    data[0] != WACOM_REPORT_CINTIQ &&
+	    data[0] != WACOM_REPORT_CINTIQPAD &&
 	    data[0] != WACOM_REPORT_INTUOS5PAD) {
 		dev_dbg(input->dev.parent,
 			"%s: received unknown report #%d\n", __func__, data[0]);
@@ -667,7 +669,8 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 		idx = data[1] & 0x01;
 
 	/* pad packets. Works as a second tool and is always in prox */
-	if (data[0] == WACOM_REPORT_INTUOSPAD || data[0] == WACOM_REPORT_INTUOS5PAD) {
+	if (data[0] == WACOM_REPORT_INTUOSPAD || data[0] == WACOM_REPORT_INTUOS5PAD ||
+	    data[0] == WACOM_REPORT_CINTIQPAD) {
 		input = wacom->pad_input;
 		if (features->type >= INTUOS4S && features->type <= INTUOS4L) {
 			input_report_key(input, BTN_0, (data[2] & 0x01));
@@ -767,6 +770,14 @@ static int wacom_intuos_irq(struct wacom_wac *wacom)
 			} else {
 				input_report_abs(input, ABS_MISC, 0);
 			}
+		} else if (features->type == WACOM_27QHD) {
+			input_report_key(input, KEY_PROG1, data[2] & 0x01);
+			input_report_key(input, KEY_PROG2, data[2] & 0x02);
+			input_report_key(input, KEY_PROG3, data[2] & 0x04);
+
+			input_report_abs(input, ABS_X, be16_to_cpup((__be16 *)&data[4]));
+			input_report_abs(input, ABS_Y, be16_to_cpup((__be16 *)&data[6]));
+			input_report_abs(input, ABS_Z, be16_to_cpup((__be16 *)&data[8]));
 		} else if (features->type == CINTIQ_HYBRID) {
 			/*
 			 * Do not send hardware buttons under Android. They
@@ -1027,8 +1038,20 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	struct input_dev *input = wacom->input;
 	unsigned char *data = wacom->data;
 	int i;
-	int current_num_contacts = data[61];
+	int current_num_contacts = 0;
 	int contacts_to_send = 0;
+	int num_contacts_left = 4; /* maximum contacts per packet */
+	int byte_per_packet = WACOM_BYTES_PER_24HDT_PACKET;
+	int y_offset = 2;
+
+	if (wacom->features.type == WACOM_27QHDT) {
+		current_num_contacts = data[63];
+		num_contacts_left = 10;
+		byte_per_packet = WACOM_BYTES_PER_QHDTHID_PACKET;
+		y_offset = 0;
+	} else {
+		current_num_contacts = data[61];
+	}
 
 	/*
 	 * First packet resets the counter since only the first
@@ -1037,11 +1060,10 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 	if (current_num_contacts)
 		wacom->num_contacts_left = current_num_contacts;
 
-	/* There are at most 4 contacts per packet */
-	contacts_to_send = min(4, wacom->num_contacts_left);
+	contacts_to_send = min(num_contacts_left, wacom->num_contacts_left);
 
 	for (i = 0; i < contacts_to_send; i++) {
-		int offset = (WACOM_BYTES_PER_24HDT_PACKET * i) + 1;
+		int offset = (byte_per_packet * i) + 1;
 		bool touch = (data[offset] & 0x1) && !wacom->shared->stylus_in_proximity;
 		int slot = input_mt_get_slot_by_key(input, data[offset + 1]);
 
@@ -1052,18 +1074,23 @@ static int wacom_24hdt_irq(struct wacom_wac *wacom)
 
 		if (touch) {
 			int t_x = get_unaligned_le16(&data[offset + 2]);
-			int c_x = get_unaligned_le16(&data[offset + 4]);
-			int t_y = get_unaligned_le16(&data[offset + 6]);
-			int c_y = get_unaligned_le16(&data[offset + 8]);
-			int w = get_unaligned_le16(&data[offset + 10]);
-			int h = get_unaligned_le16(&data[offset + 12]);
+			int t_y = get_unaligned_le16(&data[offset + 4 + y_offset]);
 
 			input_report_abs(input, ABS_MT_POSITION_X, t_x);
 			input_report_abs(input, ABS_MT_POSITION_Y, t_y);
-			input_report_abs(input, ABS_MT_TOUCH_MAJOR, min(w,h));
-			input_report_abs(input, ABS_MT_WIDTH_MAJOR, min(w, h) + int_dist(t_x, t_y, c_x, c_y));
-			input_report_abs(input, ABS_MT_WIDTH_MINOR, min(w, h));
-			input_report_abs(input, ABS_MT_ORIENTATION, w > h);
+
+			if (wacom->features.type != WACOM_27QHDT) {
+				int c_x = get_unaligned_le16(&data[offset + 4]);
+				int c_y = get_unaligned_le16(&data[offset + 8]);
+				int w = get_unaligned_le16(&data[offset + 10]);
+				int h = get_unaligned_le16(&data[offset + 12]);
+
+				input_report_abs(input, ABS_MT_TOUCH_MAJOR, min(w,h));
+				input_report_abs(input, ABS_MT_WIDTH_MAJOR,
+						 min(w, h) + int_dist(t_x, t_y, c_x, c_y));
+				input_report_abs(input, ABS_MT_WIDTH_MINOR, min(w, h));
+				input_report_abs(input, ABS_MT_ORIENTATION, w > h);
+			}
 		}
 	}
 	input_mt_report_pointer_emulation(input, true);
@@ -1894,6 +1921,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 	case WACOM_21UX2:
 	case WACOM_22HD:
 	case WACOM_24HD:
+	case WACOM_27QHD:
 	case DTK:
 	case CINTIQ_HYBRID:
 		sync = wacom_intuos_irq(wacom_wac);
@@ -1904,6 +1932,7 @@ void wacom_wac_irq(struct wacom_wac *wacom_wac, size_t len)
 		break;
 
 	case WACOM_24HDT:
+	case WACOM_27QHDT:
 		sync = wacom_24hdt_irq(wacom_wac);
 		break;
 
@@ -2115,6 +2144,7 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 		__set_bit(INPUT_PROP_POINTER, input_dev->propbit);
 		break;
 
+	case WACOM_27QHD:
 	case WACOM_24HD:
 	case DTK:
 	case WACOM_22HD:
@@ -2183,6 +2213,7 @@ int wacom_setup_pentouch_input_capabilities(struct input_dev *input_dev,
 		}
 		/* fall through */
 
+	case WACOM_27QHDT:
 	case MTSCREEN:
 	case MTTPC:
 	case MTTPC_B:
@@ -2330,6 +2361,19 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		input_set_abs_params(input_dev, ABS_THROTTLE, 0, 71, 0, 0);
 		break;
 
+	case WACOM_27QHD:
+		__set_bit(KEY_PROG1, input_dev->keybit);
+		__set_bit(KEY_PROG2, input_dev->keybit);
+		__set_bit(KEY_PROG3, input_dev->keybit);
+		input_set_abs_params(input_dev, ABS_X, -2048, 2048, 0, 0);
+		input_abs_set_res(input_dev, ABS_X, 1024); /* points/g */
+		input_set_abs_params(input_dev, ABS_Y, -2048, 2048, 0, 0);
+		input_abs_set_res(input_dev, ABS_Y, 1024);
+		input_set_abs_params(input_dev, ABS_Z, -2048, 2048, 0, 0);
+		input_abs_set_res(input_dev, ABS_Z, 1024);
+		__set_bit(INPUT_PROP_ACCELEROMETER, input_dev->propbit);
+		break;
+
 	case DTK:
 		for (i = 0; i < 6; i++)
 			__set_bit(BTN_0 + i, input_dev->keybit);
@@ -2680,6 +2724,18 @@ static const struct wacom_features wacom_features_0xF6 =
 	{ "Wacom Cintiq 24HD touch", .type = WACOM_24HDT, /* Touch */
 	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0xf8, .touch_max = 10,
 	  .check_for_hid_type = true, .hid_type = HID_TYPE_USBNONE };
+static const struct wacom_features wacom_features_0x32A =
+	{ "Wacom Cintiq 27QHD", 119740, 67520, 2047,
+	  63, WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
+static const struct wacom_features wacom_features_0x32B =
+	{ "Wacom Cintiq 27QHD touch", 119740, 67520, 2047, 63,
+	  WACOM_27QHD, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES,
+	  WACOM_CINTIQ_OFFSET, WACOM_CINTIQ_OFFSET,
+	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x32C };
+static const struct wacom_features wacom_features_0x32C =
+	{ "Wacom Cintiq 27QHD touch", .type = WACOM_27QHDT,
+	  .oVid = USB_VENDOR_ID_WACOM, .oPid = 0x32B, .touch_max = 10 };
 static const struct wacom_features wacom_features_0x3F =
 	{ "Wacom Cintiq 21UX", 87200, 65600, 1023, 63,
 	  CINTIQ, WACOM_INTUOS3_RES, WACOM_INTUOS3_RES };
@@ -3046,6 +3102,9 @@ const struct hid_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x315) },
 	{ USB_DEVICE_WACOM(0x317) },
 	{ USB_DEVICE_WACOM(0x323) },
+	{ USB_DEVICE_WACOM(0x32A) },
+	{ USB_DEVICE_WACOM(0x32B) },
+	{ USB_DEVICE_WACOM(0x32C) },
 	{ USB_DEVICE_WACOM(0x32F) },
 	{ USB_DEVICE_WACOM(0x4001) },
 	{ USB_DEVICE_WACOM(0x4004) },
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index 72e78cc..021ee1c 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -13,7 +13,7 @@
 #include <linux/hid.h>
 
 /* maximum packet length for USB devices */
-#define WACOM_PKGLEN_MAX	68
+#define WACOM_PKGLEN_MAX	192
 
 #define WACOM_NAME_MAX		64
 
@@ -37,6 +37,7 @@
 /* wacom data size per MT contact */
 #define WACOM_BYTES_PER_MT_PACKET	11
 #define WACOM_BYTES_PER_24HDT_PACKET	14
+#define WACOM_BYTES_PER_QHDTHID_PACKET	 6
 
 /* device IDs */
 #define STYLUS_DEVICE_ID	0x02
@@ -58,6 +59,8 @@
 #define WACOM_REPORT_TPCMT		13
 #define WACOM_REPORT_TPCMT2		3
 #define WACOM_REPORT_TPCHID		15
+#define WACOM_REPORT_CINTIQ		16
+#define WACOM_REPORT_CINTIQPAD		17
 #define WACOM_REPORT_TPCST		16
 #define WACOM_REPORT_DTUS		17
 #define WACOM_REPORT_TPC1FGE		18
@@ -109,6 +112,7 @@ enum {
 	WACOM_22HD,
 	DTK,
 	WACOM_24HD,
+	WACOM_27QHD,
 	CINTIQ_HYBRID,
 	CINTIQ,
 	WACOM_BEE,
@@ -117,6 +121,7 @@ enum {
 	WIRELESS,
 	BAMBOO_PT,
 	WACOM_24HDT,
+	WACOM_27QHDT,
 	TABLETPC,   /* add new TPC below */
 	TABLETPCE,
 	TABLETPC2FG,
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index a1d7e93..b0a8130 100644
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -166,6 +166,7 @@ struct input_keymap_entry {
 #define INPUT_PROP_SEMI_MT		0x03	/* touch rectangle only */
 #define INPUT_PROP_TOPBUTTONPAD		0x04	/* softbuttons at top of pad */
 #define INPUT_PROP_POINTING_STICK	0x05	/* is a pointing stick */
+#define INPUT_PROP_ACCELEROMETER	0x06	/* has accelerometer */
 
 #define INPUT_PROP_MAX			0x1f
 #define INPUT_PROP_CNT			(INPUT_PROP_MAX + 1)
-- 
1.9.1

