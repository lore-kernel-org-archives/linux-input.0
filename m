From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH] Improve Alps HID Touchpad code
Date: Tue, 21 Jun 2016 17:14:59 +0900
Message-ID: <1466496899-9392-1-git-send-email-masaki.ota@jp.alps.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36273 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752350AbcFUIaD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 04:30:03 -0400
Received: by mail-pf0-f195.google.com with SMTP id i123so885226pfg.3
        for <linux-input@vger.kernel.org>; Tue, 21 Jun 2016 01:30:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: benjamin.tissorires@redhat.com, peter.hutterer@who-t.net, hdegoede@redhat.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, masaki.ota@jp.alps.com, naoki.saito@jp.alps.com

>From Masaki Ota <masaki.ota@jp.alps.com>

Remove the unnecessary codes.
Add the device ID of "HID_DEVICE_ID_ALPS_U1_DUAL" to hid-ids.h

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/hid/hid-alps.c | 96 +++++++++++++++++++++-----------------------------
 drivers/hid/hid-core.c |  4 +--
 drivers/hid/hid-ids.h  |  1 +
 3 files changed, 43 insertions(+), 58 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 776b3a4..e6a0e88 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -15,6 +15,9 @@
 #include <asm/unaligned.h>
 #include "hid-ids.h"
 
+#define STATUS_SUCCESS	0
+#define STATUS_FAIL	1
+
 /* ALPS Device Product ID */
 #define HID_PRODUCT_ID_T3_BTNLESS	0xD0C0
 #define HID_PRODUCT_ID_COSMO		0x1202
@@ -98,8 +101,6 @@ struct u1_dev {
 	u32	sp_btn_cnt;
 };
 
-struct u1_dev *priv;
-
 static int u1_read_write_register(struct hid_device *hdev, u32 address,
 	u8 *read_val, u8 write_val, bool read_flag)
 {
@@ -108,16 +109,10 @@ static int u1_read_write_register(struct hid_device *hdev, u32 address,
 	u8 *input;
 	u8 *readbuf;
 
-	input = kzalloc(sizeof(u8)*U1_FEATURE_REPORT_LEN, GFP_KERNEL);
+	input = kzalloc(U1_FEATURE_REPORT_LEN, GFP_KERNEL);
 	if (!input)
 		return -ENOMEM;
 
-	readbuf = kzalloc(sizeof(u8)*U1_FEATURE_REPORT_LEN, GFP_KERNEL);
-	if (!readbuf) {
-		kfree(input);
-		return -ENOMEM;
-	}
-
 	input[0] = U1_FEATURE_REPORT_ID;
 	if (read_flag) {
 		input[1] = U1_CMD_REGISTER_READ;
@@ -136,7 +131,7 @@ static int u1_read_write_register(struct hid_device *hdev, u32 address,
 
 	input[7] = check_sum;
 	ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, input,
-			sizeof(u8)*U1_FEATURE_REPORT_LEN,
+			U1_FEATURE_REPORT_LEN,
 			HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
 
 	if (ret < 0) {
@@ -145,8 +140,14 @@ static int u1_read_write_register(struct hid_device *hdev, u32 address,
 	}
 
 	if (read_flag) {
+		readbuf = kzalloc(U1_FEATURE_REPORT_LEN, GFP_KERNEL);
+		if (!readbuf) {
+			kfree(input);
+			return -ENOMEM;
+		}
+
 		ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, readbuf,
-				sizeof(u8)*U1_FEATURE_REPORT_LEN,
+				U1_FEATURE_REPORT_LEN,
 				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 
 		if (ret < 0) {
@@ -155,15 +156,14 @@ static int u1_read_write_register(struct hid_device *hdev, u32 address,
 		}
 
 		*read_val = readbuf[6];
+
+		kfree(readbuf);
 	}
 
-	kfree(input);
-	kfree(readbuf);
-	return 0;
+	ret = STATUS_SUCCESS;
 
 exit:
 	kfree(input);
-	kfree(readbuf);
 	return ret;
 }
 
@@ -171,7 +171,7 @@ static int alps_raw_event(struct hid_device *hdev,
 		struct hid_report *report, u8 *data, int size)
 {
 	int x[MAX_TOUCHES], y[MAX_TOUCHES], z[MAX_TOUCHES];
-	int i, left, right, middle;
+	int i;
 	short sp_x, sp_y, sp_z;
 	struct u1_dev *hdata = hid_get_drvdata(hdev);
 
@@ -182,12 +182,9 @@ static int alps_raw_event(struct hid_device *hdev,
 		break;
 	case U1_ABSOLUTE_REPORT_ID:
 		for (i = 0; i < MAX_TOUCHES; i++) {
-			x[i] = (data[3+(5*i)] | (data[4+(5*i)] << 8));
-			y[i] = (data[5+(5*i)] | (data[6+(5*i)] << 8));
+			x[i] = get_unaligned_le16(data+3+(5*i));
+			y[i] = get_unaligned_le16(data+5+(5*i));
 			z[i] = data[7+(5*i)] & 0x7F;
-			left = data[1] & 0x1;
-			right = (data[1] & 0x2) >> 1;
-			middle = (data[1] & 0x4) >> 2;
 
 			input_mt_slot(hdata->input, i);
 
@@ -209,33 +206,37 @@ static int alps_raw_event(struct hid_device *hdev,
 		}
 
 		input_mt_sync_frame(hdata->input);
-		input_sync(hdata->input);
 
-		input_event(hdata->input, EV_KEY, BTN_LEFT, left);
-		input_event(hdata->input, EV_KEY, BTN_RIGHT, right);
-		input_event(hdata->input, EV_KEY, BTN_MIDDLE, middle);
+		input_event(hdata->input, EV_KEY, BTN_LEFT,
+			data[1] & 0x1);
+		input_event(hdata->input, EV_KEY, BTN_RIGHT,
+			(data[1] & 0x2) >> 1);
+		input_event(hdata->input, EV_KEY, BTN_MIDDLE,
+			(data[1] & 0x4) >> 2);
+
+		input_sync(hdata->input);
 
 		return 1;
 
 	case U1_SP_ABSOLUTE_REPORT_ID:
-		sp_x = (data[2] | (data[3] << 8));
-		sp_y = (data[4] | (data[5] << 8));
+		sp_x = get_unaligned_le16(data+2);
+		sp_y = get_unaligned_le16(data+4);
 		sp_z = (data[6] | data[7]) & 0x7FFF;
-		left = data[1] & 0x1;
-		right = (data[1] & 0x2) >> 1;
-		middle = (data[1] & 0x4) >> 2;
 
 		sp_x = sp_x / 8;
 		sp_y = sp_y / 8;
 
-		input_event(priv->input2, EV_REL, REL_X, sp_x);
-		input_event(priv->input2, EV_REL, REL_Y, sp_y);
+		input_event(hdata->input2, EV_REL, REL_X, sp_x);
+		input_event(hdata->input2, EV_REL, REL_Y, sp_y);
 
-		input_event(priv->input2, EV_KEY, BTN_LEFT, left);
-		input_event(priv->input2, EV_KEY, BTN_RIGHT, right);
-		input_event(priv->input2, EV_KEY, BTN_MIDDLE, middle);
+		input_event(hdata->input2, EV_KEY, BTN_LEFT,
+			data[1] & 0x1);
+		input_event(hdata->input2, EV_KEY, BTN_RIGHT,
+			(data[1] & 0x2) >> 1);
+		input_event(hdata->input2, EV_KEY, BTN_MIDDLE,
+			(data[1] & 0x4) >> 2);
 
-		input_sync(priv->input2);
+		input_sync(hdata->input2);
 
 		return 1;
 	}
@@ -265,15 +266,6 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	int ret;
 	int res_x, res_y, i;
 
-	/* Check device product ID */
-	switch (hdev->product) {
-	case HID_PRODUCT_ID_U1:
-	case HID_PRODUCT_ID_U1_DUAL:
-		break;
-	default:
-		return 0;
-	}
-
 	data->input = input;
 
 	hid_dbg(hdev, "Opening low level driver\n");
@@ -393,20 +385,13 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	/* Stick device initialization */
 	if (devInfo.dev_type & U1_DEVTYPE_SP_SUPPORT) {
 
-		priv = kzalloc(sizeof(struct u1_dev), GFP_KERNEL);
-		if (!priv) {
-			hid_device_io_stop(hdev);
-			hid_hw_close(hdev);
-			return -ENOMEM;
-		}
-
 		input2 = input_allocate_device();
 		if (!input2) {
 			input_free_device(input2);
 			goto exit;
 		}
 
-		priv->input2 = input2;
+		data->input2 = input2;
 
 		devInfo.dev_ctrl |= U1_SP_ABS_MODE;
 		ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
@@ -444,7 +429,7 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		__set_bit(INPUT_PROP_POINTER, input2->propbit);
 		__set_bit(INPUT_PROP_POINTING_STICK, input2->propbit);
 
-		if (input_register_device(priv->input2)) {
+		if (input_register_device(data->input2)) {
 			input_free_device(input2);
 			goto exit;
 		}
@@ -495,12 +480,11 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static void alps_remove(struct hid_device *hdev)
 {
 	hid_hw_stop(hdev);
-	kfree(priv);
 }
 
 static const struct hid_device_id alps_id[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
-		USB_VENDOR_ID_ALPS_JP, HID_ANY_ID) },
+		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, alps_id);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 470663d..33255b1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1731,8 +1731,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0x0802) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0xf705) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0xf705) },
-	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, USB_VENDER_ID_ALPS_JP,
-	HID_ANY_ID) },
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, USB_VENDOR_ID_ALPS_JP,
+	HID_DEVICE_ID_ALPS_U1_DUAL) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICMOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICTRACKPAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_FOUNTAIN_ANSI) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index cac68c7..2038056 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -68,6 +68,7 @@
 #define USB_DEVICE_ID_IBM_GAMEPAD	0x1101
 
 #define USB_VENDOR_ID_ALPS_JP		0x044E
+#define HID_DEVICE_ID_ALPS_U1_DUAL	0x120B
 
 #define USB_VENDOR_ID_ANTON		0x1130
 #define USB_DEVICE_ID_ANTON_TOUCH_PAD	0x3101
-- 
2.7.4

