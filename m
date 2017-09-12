From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH 5/7] Support new Alps device that name is T4
Date: Tue, 12 Sep 2017 11:54:12 +0900
Message-ID: <20170912025414.3784-6-masaki.ota@jp.alps.com>
References: <20170912025414.3784-1-masaki.ota@jp.alps.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33809 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbdILCyk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 11 Sep 2017 22:54:40 -0400
In-Reply-To: <20170912025414.3784-1-masaki.ota@jp.alps.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

From: Masaki Ota <masaki.ota@jp.alps.com>
-Add T4 device code and Product ID
-This device is used on HP EliteBook 1000 series and Zbook Stduio

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/hid/hid-alps.c | 343 ++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/hid/hid-core.c |   3 +-
 drivers/hid/hid-ids.h  |   1 +
 3 files changed, 326 insertions(+), 21 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 4c323b58e009..0a6c54fb47c8 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -52,8 +52,30 @@
 #define ADDRESS_U1_PAD_BTN		0x00800052
 #define ADDRESS_U1_SP_BTN		0x0080009F
 
+#define T4_INPUT_REPORT_LEN			sizeof(struct t4_input_report)
+#define T4_FEATURE_REPORT_LEN		T4_INPUT_REPORT_LEN
+#define T4_FEATURE_REPORT_ID		7
+#define T4_CMD_REGISTER_READ			0x08
+#define T4_CMD_REGISTER_WRITE			0x07
+
+#define T4_ADDRESS_BASE				0xC2C0
+#define PRM_SYS_CONFIG_1			(T4_ADDRESS_BASE + 0x0002)
+#define T4_PRM_FEED_CONFIG_1		(T4_ADDRESS_BASE + 0x0004)
+#define T4_PRM_FEED_CONFIG_4		(T4_ADDRESS_BASE + 0x001A)
+#define T4_PRM_ID_CONFIG_3			(T4_ADDRESS_BASE + 0x00B0)
+
+
+#define T4_FEEDCFG4_ADVANCED_ABS_ENABLE			0x01
+#define T4_I2C_ABS	0x78
+
+#define T4_COUNT_PER_ELECTRODE		256
 #define MAX_TOUCHES	5
 
+enum dev_num {
+	U1,
+	T4,
+	UNKNOWN,
+};
 /**
  * struct u1_data
  *
@@ -74,11 +96,12 @@
  * @btn_cnt: number of buttons
  * @sp_btn_cnt: number of stick buttons
  */
-struct u1_dev {
+struct alps_dev {
 	struct input_dev *input;
 	struct input_dev *input2;
 	struct hid_device *hdev;
 
+	enum dev_num dev_type;
 	u8  max_fingers;
 	u8  has_sp;
 	u8	sp_btn_info;
@@ -92,6 +115,145 @@ struct u1_dev {
 	u32	sp_btn_cnt;
 };
 
+struct t4_contact_data {
+	u8  palm;
+	u8	x_lo;
+	u8	x_hi;
+	u8	y_lo;
+	u8	y_hi;
+};
+
+struct t4_input_report {
+	u8  reportID;
+	u8  numContacts;
+	struct t4_contact_data contact[5];
+	u8  button;
+	u8  track[5];
+	u8  zx[5], zy[5];
+	u8  palmTime[5];
+	u8  kilroy;
+	u16 timeStamp;
+};
+
+static u16 t4_calc_check_sum(u8 *buffer,
+		unsigned long offset, unsigned long length)
+{
+	u16 sum1 = 0xFF, sum2 = 0xFF;
+	unsigned long i = 0;
+
+	if (offset + length >= 50)
+		return 0;
+
+	while (length > 0) {
+		u32 tlen = length > 20 ? 20 : length;
+
+		length -= tlen;
+
+		do {
+			sum1 += buffer[offset + i];
+			sum2 += sum1;
+			i++;
+		} while (--tlen > 0);
+
+		sum1 = (sum1 & 0xFF) + (sum1 >> 8);
+		sum2 = (sum2 & 0xFF) + (sum2 >> 8);
+	}
+
+	sum1 = (sum1 & 0xFF) + (sum1 >> 8);
+	sum2 = (sum2 & 0xFF) + (sum2 >> 8);
+
+	return(sum2 << 8 | sum1);
+}
+
+static int t4_read_write_register(struct hid_device *hdev, u32 address,
+	u8 *read_val, u8 write_val, bool read_flag)
+{
+	int ret;
+	u16 check_sum;
+	u8 *input;
+	u8 *readbuf;
+
+	input = kzalloc(T4_FEATURE_REPORT_LEN, GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+
+	input[0] = T4_FEATURE_REPORT_ID;
+	if (read_flag) {
+		input[1] = T4_CMD_REGISTER_READ;
+		input[8] = 0x00;
+	} else {
+		input[1] = T4_CMD_REGISTER_WRITE;
+		input[8] = write_val;
+	}
+	put_unaligned_le32(address, input + 2);
+	input[6] = 1;
+	input[7] = 0;
+
+	/* Calculate the checksum */
+	check_sum = t4_calc_check_sum(input, 1, 8);
+	input[9] = (u8)check_sum;
+	input[10] = (u8)(check_sum >> 8);
+	input[11] = 0;
+
+	ret = hid_hw_raw_request(hdev, T4_FEATURE_REPORT_ID, input,
+			T4_FEATURE_REPORT_LEN,
+			HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to read command (%d)\n", ret);
+		goto exit;
+	}
+
+	if (read_flag) {
+		readbuf = kzalloc(T4_FEATURE_REPORT_LEN, GFP_KERNEL);
+		if (!readbuf) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+
+		ret = hid_hw_raw_request(hdev, T4_FEATURE_REPORT_ID, readbuf,
+				T4_FEATURE_REPORT_LEN,
+				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+		if (ret < 0) {
+			dev_err(&hdev->dev, "failed read register (%d)\n", ret);
+			kfree(readbuf);
+			goto exit;
+		}
+
+		if (*(u32 *)&readbuf[6] != address) {
+			dev_err(&hdev->dev, "read register address error (%x,%x)\n",
+			*(u32 *)&readbuf[6], address);
+			kfree(readbuf);
+			goto exit;
+		}
+
+		if (*(u16 *)&readbuf[10] != 1) {
+			dev_err(&hdev->dev, "read register size error (%x)\n",
+			*(u16 *)&readbuf[10]);
+			kfree(readbuf);
+			goto exit;
+		}
+
+		check_sum = t4_calc_check_sum(readbuf, 6, 7);
+		if (*(u16 *)&readbuf[13] != check_sum) {
+			dev_err(&hdev->dev, "read register checksum error (%x,%x)\n",
+			*(u16 *)&readbuf[13], check_sum);
+			kfree(readbuf);
+			goto exit;
+		}
+
+		*read_val = readbuf[12];
+
+		kfree(readbuf);
+	}
+
+	ret = 0;
+
+exit:
+	kfree(input);
+	return ret;
+}
+
 static int u1_read_write_register(struct hid_device *hdev, u32 address,
 	u8 *read_val, u8 write_val, bool read_flag)
 {
@@ -159,21 +321,60 @@ static int u1_read_write_register(struct hid_device *hdev, u32 address,
 	return ret;
 }
 
-static int alps_raw_event(struct hid_device *hdev,
-		struct hid_report *report, u8 *data, int size)
+static int t4_raw_event(struct alps_dev *hdata, u8 *data, int size)
+{
+	unsigned int x, y, z;
+	int i;
+	struct t4_input_report *p_report = (struct t4_input_report *)data;
+
+	if (!data)
+		return 0;
+	for (i = 0; i < hdata->max_fingers; i++) {
+		x = p_report->contact[i].x_hi << 8 | p_report->contact[i].x_lo;
+		y = p_report->contact[i].y_hi << 8 | p_report->contact[i].y_lo;
+		y = hdata->y_max - y + hdata->y_min;
+		z = (p_report->contact[i].palm < 0x80 &&
+			p_report->contact[i].palm > 0) * 62;
+		if (x == 0xffff) {
+			x = 0;
+			y = 0;
+			z = 0;
+		}
+		input_mt_slot(hdata->input, i);
+
+		input_mt_report_slot_state(hdata->input,
+			MT_TOOL_FINGER, z != 0);
+
+		if (!z)
+			continue;
+
+		input_report_abs(hdata->input, ABS_MT_POSITION_X, x);
+		input_report_abs(hdata->input, ABS_MT_POSITION_Y, y);
+		input_report_abs(hdata->input, ABS_MT_PRESSURE, z);
+	}
+	input_mt_sync_frame(hdata->input);
+
+	input_report_key(hdata->input, BTN_LEFT,	p_report->button);
+
+	input_sync(hdata->input);
+	return 1;
+}
+
+static int u1_raw_event(struct alps_dev *hdata, u8 *data, int size)
 {
 	unsigned int x, y, z;
 	int i;
 	short sp_x, sp_y;
-	struct u1_dev *hdata = hid_get_drvdata(hdev);
 
+	if (!data)
+		return 0;
 	switch (data[0]) {
 	case U1_MOUSE_REPORT_ID:
 		break;
 	case U1_FEATURE_REPORT_ID:
 		break;
 	case U1_ABSOLUTE_REPORT_ID:
-		for (i = 0; i < MAX_TOUCHES; i++) {
+		for (i = 0; i < hdata->max_fingers; i++) {
 			u8 *contact = &data[i * 5];
 
 			x = get_unaligned_le16(contact + 3);
@@ -235,21 +436,52 @@ static int alps_raw_event(struct hid_device *hdev,
 	return 0;
 }
 
-#ifdef CONFIG_PM
-static int alps_post_reset(struct hid_device *hdev)
+static int alps_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size)
 {
-	return u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-				NULL, U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
+	int ret = 0;
+	struct alps_dev *hdata = hid_get_drvdata(hdev);
+
+	switch (hdev->product) {
+	case HID_PRODUCT_ID_T4_BTNLESS:
+		ret = t4_raw_event(hdata, data, size);
+		break;
+	default:
+		ret = u1_raw_event(hdata, data, size);
+		break;
+	}
+	return ret;
 }
 
-static int alps_post_resume(struct hid_device *hdev)
+static int __maybe_unused alps_post_reset(struct hid_device *hdev)
 {
-	return u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-				NULL, U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
+	int ret = -1;
+	struct alps_dev *data = hid_get_drvdata(hdev);
+
+	switch (data->dev_type) {
+	case T4:
+		ret = t4_read_write_register(hdev, T4_PRM_FEED_CONFIG_1,
+			NULL, T4_I2C_ABS, false);
+		ret = t4_read_write_register(hdev, T4_PRM_FEED_CONFIG_4,
+			NULL, T4_FEEDCFG4_ADVANCED_ABS_ENABLE, false);
+		break;
+	case U1:
+		ret = u1_read_write_register(hdev,
+			ADDRESS_U1_DEV_CTRL_1, NULL,
+			U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
+		break;
+	default:
+		break;
+	}
+	return ret;
 }
-#endif /* CONFIG_PM */
 
-static int u1_init(struct hid_device *hdev, struct u1_dev *pri_data)
+static int __maybe_unused alps_post_resume(struct hid_device *hdev)
+{
+	return alps_post_reset(hdev);
+}
+
+static int u1_init(struct hid_device *hdev, struct alps_dev *pri_data)
 {
 	int ret;
 	u8 tmp, dev_ctrl, sen_line_num_x, sen_line_num_y;
@@ -361,9 +593,60 @@ static int u1_init(struct hid_device *hdev, struct u1_dev *pri_data)
 	return ret;
 }
 
+static int T4_init(struct hid_device *hdev, struct alps_dev *pri_data)
+{
+	int ret;
+	u8 tmp, sen_line_num_x, sen_line_num_y;
+
+	ret = t4_read_write_register(hdev, T4_PRM_ID_CONFIG_3, &tmp, 0, true);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed T4_PRM_ID_CONFIG_3 (%d)\n", ret);
+		goto exit;
+	}
+	sen_line_num_x = 16 + ((tmp & 0x0F)  | (tmp & 0x08 ? 0xF0 : 0));
+	sen_line_num_y = 12 + (((tmp & 0xF0) >> 4)  | (tmp & 0x80 ? 0xF0 : 0));
+
+	pri_data->x_max = sen_line_num_x * T4_COUNT_PER_ELECTRODE;
+	pri_data->x_min = T4_COUNT_PER_ELECTRODE;
+	pri_data->y_max = sen_line_num_y * T4_COUNT_PER_ELECTRODE;
+	pri_data->y_min = T4_COUNT_PER_ELECTRODE;
+	pri_data->x_active_len_mm = pri_data->y_active_len_mm = 0;
+	pri_data->btn_cnt = 1;
+
+	ret = t4_read_write_register(hdev, PRM_SYS_CONFIG_1, &tmp, 0, true);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed PRM_SYS_CONFIG_1 (%d)\n", ret);
+		goto exit;
+	}
+	tmp |= 0x02;
+	ret = t4_read_write_register(hdev, PRM_SYS_CONFIG_1, NULL, tmp, false);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed PRM_SYS_CONFIG_1 (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = t4_read_write_register(hdev, T4_PRM_FEED_CONFIG_1,
+					NULL, T4_I2C_ABS, false);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed T4_PRM_FEED_CONFIG_1 (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = t4_read_write_register(hdev, T4_PRM_FEED_CONFIG_4, NULL,
+				T4_FEEDCFG4_ADVANCED_ABS_ENABLE, false);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed T4_PRM_FEED_CONFIG_4 (%d)\n", ret);
+		goto exit;
+	}
+	pri_data->max_fingers = 5;
+	pri_data->has_sp = 0;
+exit:
+	return ret;
+}
+
 static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 {
-	struct u1_dev *data = hid_get_drvdata(hdev);
+	struct alps_dev *data = hid_get_drvdata(hdev);
 	struct input_dev *input = hi->input, *input2;
 	int ret;
 	int res_x, res_y, i;
@@ -377,8 +660,16 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 
 	/* Allow incoming hid reports */
 	hid_device_io_start(hdev);
-
-	ret = u1_init(hdev, data);
+	switch (data->dev_type) {
+	case T4:
+		ret = T4_init(hdev, data);
+		break;
+	case U1:
+		ret = u1_init(hdev, data);
+		break;
+	default:
+		break;
+	}
 
 	if (ret)
 		goto exit;
@@ -458,10 +749,9 @@ static int alps_input_mapping(struct hid_device *hdev,
 
 static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
-	struct u1_dev *data = NULL;
+	struct alps_dev *data = NULL;
 	int ret;
-
-	data = devm_kzalloc(&hdev->dev, sizeof(struct u1_dev), GFP_KERNEL);
+	data = devm_kzalloc(&hdev->dev, sizeof(struct alps_dev), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -476,6 +766,17 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
+	switch (hdev->product) {
+	case HID_DEVICE_ID_ALPS_T4_BTNLESS:
+		data->dev_type = T4;
+		break;
+	case HID_DEVICE_ID_ALPS_U1_DUAL:
+		data->dev_type = U1;
+		break;
+	default:
+		data->dev_type = UNKNOWN;
+	}
+
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
@@ -493,6 +794,8 @@ static void alps_remove(struct hid_device *hdev)
 static const struct hid_device_id alps_id[] = {
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
 		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
+		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_T4_BTNLESS) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, alps_id);
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index ea36b557d5ee..9c3cb2e467e9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1774,7 +1774,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_A4TECH, USB_DEVICE_ID_A4TECH_RP_649) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0x0802) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ACRUX, 0xf705) },
-	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY, USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
+	{ HID_I2C_DEVICE(USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_T4_BTNLESS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MIGHTYMOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICMOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICTRACKPAD) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 350accfee8e8..0b9726d321ee 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -75,6 +75,7 @@
 
 #define USB_VENDOR_ID_ALPS_JP		0x044E
 #define HID_DEVICE_ID_ALPS_U1_DUAL	0x120B
+#define HID_DEVICE_ID_ALPS_T4_BTNLESS	0x120C
 
 #define USB_VENDOR_ID_AMI		0x046b
 #define USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE	0xff10
-- 
2.11.0

