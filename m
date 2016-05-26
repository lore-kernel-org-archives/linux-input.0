From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH] Alps I2C HID Touchpad-Stick support
Date: Thu, 26 May 2016 13:40:55 +0900
Message-ID: <1464237655-2242-1-git-send-email-masaki.ota@jp.alps.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35659 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbcEZElB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 00:41:01 -0400
Received: by mail-pa0-f67.google.com with SMTP id gp3so830604pac.2
        for <linux-input@vger.kernel.org>; Wed, 25 May 2016 21:41:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissorires@redhat.com
Cc: linux-input@vger.kernel.org, peter.hutterer@who-t.net, hdegoede@redhat.com, dmitry.torokhov@gmail.com, masaki.ota@jp.alps.com

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/hid/Makefile   |   1 +
 drivers/hid/hid-alps.c | 513 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-core.c |   5 +
 drivers/hid/hid-ids.h  |   2 +
 include/linux/hid.h    |   1 +
 5 files changed, 522 insertions(+)
 create mode 100644 drivers/hid/hid-alps.c

diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
index 00011fe..31e493a 100644
--- a/drivers/hid/Makefile
+++ b/drivers/hid/Makefile
@@ -21,6 +21,7 @@ hid-wiimote-y		:= hid-wiimote-core.o hid-wiimote-modules.o
 hid-wiimote-$(CONFIG_DEBUG_FS)	+= hid-wiimote-debug.o
 
 obj-$(CONFIG_HID_A4TECH)	+= hid-a4tech.o
+obj-$(CONFIG_HID_ALPS)		+= hid-alps.o
 obj-$(CONFIG_HID_ACRUX)		+= hid-axff.o
 obj-$(CONFIG_HID_APPLE)		+= hid-apple.o
 obj-$(CONFIG_HID_APPLEIR)	+= hid-appleir.o
diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
new file mode 100644
index 0000000..328571a
--- /dev/null
+++ b/drivers/hid/hid-alps.c
@@ -0,0 +1,513 @@
+/*
+ *  Copyright (c) 2016 Masaki Ota <masaki.ota@jp.alps.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/hid.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/module.h>
+#include "hid-ids.h"
+
+/* ALPS Device Product ID */
+#define HID_PRODUCT_ID_T3_BTNLESS	0xD0C0
+#define HID_PRODUCT_ID_COSMO		0x1202
+#define HID_PRODUCT_ID_U1_PTP_1		0x1207
+#define HID_PRODUCT_ID_U1			0x1209
+#define HID_PRODUCT_ID_U1_PTP_2		0x120A
+#define HID_PRODUCT_ID_U1_DUAL		0x120B
+#define HID_PRODUCT_ID_T4_BTNLESS	0x120C
+
+#define DEV_SINGLEPOINT				0x01
+#define DEV_DUALPOINT				0x02
+
+#define U1_MOUSE_REPORT_ID			0x01 /* Mouse data ReportID */
+#define U1_ABSOLUTE_REPORT_ID		0x03 /* Absolute data ReportID */
+#define U1_FEATURE_REPORT_ID		0x05 /* Feature ReportID */
+#define U1_SP_ABSOLUTE_REPORT_ID	0x06 /* Feature ReportID */
+
+#define U1_FEATURE_REPORT_LEN		0x08 /* Feature Report Length */
+#define U1_FEATURE_REPORT_LEN_ALL	0x0A
+#define U1_CMD_REGISTER_READ		0xD1
+#define U1_CMD_REGISTER_WRITE		0xD2
+
+#define	U1_DEVTYPE_SP_SUPPORT		0x10 /* SP Support */
+#define	U1_DISABLE_DEV				0x01
+#define U1_TP_ABS_MODE				0x02
+#define	U1_SP_ABS_MODE				0x80
+
+#define ADDRESS_U1_DEV_CTRL_1	0x00800040
+#define ADDRESS_U1_DEVICE_TYP	0x00800043
+#define ADDRESS_U1_NUM_SENS_X	0x00800047
+#define ADDRESS_U1_NUM_SENS_Y	0x00800048
+#define ADDRESS_U1_PITCH_SENS_X	0x00800049
+#define ADDRESS_U1_PITCH_SENS_Y	0x0080004A
+#define ADDRESS_U1_RESO_DWN_ABS 0x0080004E
+#define ADDRESS_U1_PAD_BTN		0x00800052
+#define ADDRESS_U1_SP_BTN		0x0080009F
+
+#define MAX_TOUCHES	5
+
+/**
+ * struct u1_data
+ *
+ * @input: pointer to the kernel input device
+ * @input2: pointer to the kernel input2 device
+ * @hdev: pointer to the struct hid_device
+ *
+ * @dev_ctrl: device control parameter
+ * @dev_type: device type
+ * @sen_line_num_x: number of sensor line of X
+ * @sen_line_num_y: number of sensor line of Y
+ * @pitch_x: sensor pitch of X
+ * @pitch_y: sensor pitch of Y
+ * @resolution: resolution
+ * @btn_info: button information
+ * @x_active_len_mm: active area length of X (mm)
+ * @y_active_len_mm: active area length of Y (mm)
+ * @x_max: maximum x coordinate value
+ * @y_max: maximum y coordinate value
+ * @btn_cnt: number of buttons
+ * @sp_btn_cnt: number of stick buttons
+ */
+struct u1_dev {
+	struct input_dev *input;
+	struct input_dev *input2;
+	struct hid_device *hdev;
+
+	u8	dev_ctrl;
+	u8	dev_type;
+	u8	sen_line_num_x;
+	u8	sen_line_num_y;
+	u8	pitch_x;
+	u8	pitch_y;
+	u8	resolution;
+	u8	btn_info;
+	u8	sp_btn_info;
+	u32	x_active_len_mm;
+	u32	y_active_len_mm;
+	u32	x_max;
+	u32	y_max;
+	u32	btn_cnt;
+	u32	sp_btn_cnt;
+};
+
+struct u1_dev *priv;
+
+static int u1_write_register(struct hid_device *hdev, u32 address, u8 value)
+{
+	int ret, i;
+	u8 input[8];
+	u8 check_sum;
+
+	input[0] = U1_FEATURE_REPORT_ID;
+	input[1] = U1_CMD_REGISTER_WRITE;
+	input[2] = address & 0x000000FF;
+	input[3] = (address & 0x0000FF00) >> 8;
+	input[4] = (address & 0x00FF0000) >> 16;
+	input[5] = (address & 0xFF000000) >> 24;
+	input[6] = value;
+
+	/* Calculate the checksum */
+	check_sum = U1_FEATURE_REPORT_LEN_ALL;
+	for (i = 0; i < U1_FEATURE_REPORT_LEN - 1; i++)
+		check_sum += input[i];
+
+	input[7] = check_sum;
+
+	ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, input,
+			sizeof(input), HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to write register (%d)\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int u1_read_register(struct hid_device *hdev, u32 address, u8 *value)
+{
+	int ret, i;
+	u8 input[8];
+	u8 readbuf[8];
+	u8 check_sum;
+
+	input[0] = U1_FEATURE_REPORT_ID;
+	input[1] = U1_CMD_REGISTER_READ;
+	input[2] = address & 0x000000FF;
+	input[3] = (address & 0x0000FF00) >> 8;
+	input[4] = (address & 0x00FF0000) >> 16;
+	input[5] = (address & 0xFF000000) >> 24;
+	input[6] = 0x00;
+
+	/* Calculate the checksum */
+	check_sum = U1_FEATURE_REPORT_LEN_ALL;
+	for (i = 0; i < U1_FEATURE_REPORT_LEN - 1; i++)
+		check_sum += input[i];
+
+	input[7] = check_sum;
+
+	ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, input,
+			sizeof(input), HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
+
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to read command (%d)\n", ret);
+		return ret;
+	}
+
+	ret = hid_hw_raw_request(hdev, U1_FEATURE_REPORT_ID, readbuf,
+			sizeof(readbuf), HID_FEATURE_REPORT,
+			HID_REQ_GET_REPORT);
+
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to read register (%d)\n", ret);
+		return ret;
+	}
+
+	*value = readbuf[6];
+
+	return 0;
+}
+
+static int alps_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size)
+{
+	int x[MAX_TOUCHES], y[MAX_TOUCHES], z[MAX_TOUCHES];
+	int i, left, right, middle;
+	short sp_x, sp_y, sp_z;
+	struct u1_dev *hdata = hid_get_drvdata(hdev);
+
+	switch (data[0]) {
+	case U1_MOUSE_REPORT_ID:
+		break;
+	case U1_FEATURE_REPORT_ID:
+		break;
+	case U1_ABSOLUTE_REPORT_ID:
+		for (i = 0; i < MAX_TOUCHES; i++) {
+			x[i] = (data[3+(5*i)] | (data[4+(5*i)] << 8));
+			y[i] = (data[5+(5*i)] | (data[6+(5*i)] << 8));
+			z[i] = data[7+(5*i)] & 0x7F;
+			left = data[1] & 0x1;
+			right = (data[1] & 0x2) >> 1;
+			middle = (data[1] & 0x4) >> 2;
+
+			input_mt_slot(hdata->input, i);
+
+			if (z[i] != 0) {
+				input_mt_report_slot_state(hdata->input,
+					MT_TOOL_FINGER, 1);
+			} else {
+				input_mt_report_slot_state(hdata->input,
+					MT_TOOL_FINGER, 0);
+				break;
+			}
+
+			input_event(hdata->input, EV_ABS,
+				ABS_MT_POSITION_X, x[i]);
+			input_event(hdata->input, EV_ABS,
+				ABS_MT_POSITION_Y, y[i]);
+			input_event(hdata->input, EV_ABS,
+				ABS_MT_PRESSURE, z[i]);
+		}
+
+		input_mt_sync_frame(hdata->input);
+		input_sync(hdata->input);
+
+		input_event(hdata->input, EV_KEY, BTN_LEFT, left);
+		input_event(hdata->input, EV_KEY, BTN_RIGHT, right);
+		input_event(hdata->input, EV_KEY, BTN_MIDDLE, middle);
+
+		input_sync(hdata->input);
+
+		return 1;
+
+	case U1_SP_ABSOLUTE_REPORT_ID:
+		sp_x = (data[2] | (data[3] << 8));
+		sp_y = (data[4] | (data[5] << 8));
+		sp_z = (data[6] | data[7]) & 0x7FFF;
+		left = data[1] & 0x1;
+		right = (data[1] & 0x2) >> 1;
+		middle = (data[1] & 0x4) >> 2;
+
+		sp_x = sp_x / 8;
+		sp_y = sp_y / 8;
+
+		input_event(priv->input2, EV_REL, REL_X, sp_x);
+		input_event(priv->input2, EV_REL, REL_Y, sp_y);
+
+		input_event(priv->input2, EV_KEY, BTN_LEFT, left);
+		input_event(priv->input2, EV_KEY, BTN_RIGHT, right);
+		input_event(priv->input2, EV_KEY, BTN_MIDDLE, middle);
+
+		input_sync(priv->input2);
+
+		return 1;
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int alps_post_reset(struct hid_device *hdev)
+{
+	return u1_write_register(hdev, ADDRESS_U1_DEV_CTRL_1, U1_TP_ABS_MODE);
+}
+
+static int alps_post_resume(struct hid_device *hdev)
+{
+	return u1_write_register(hdev, ADDRESS_U1_DEV_CTRL_1, U1_TP_ABS_MODE);
+}
+#endif /* CONFIG_PM */
+
+static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
+{
+	struct u1_dev *data = hid_get_drvdata(hdev);
+	struct input_dev *input = hi->input, *input2;
+	struct u1_dev devInfo;
+	int ret;
+	int res_x, res_y, i;
+
+	/* Check device product ID*/
+	switch (hdev->product) {
+	case HID_PRODUCT_ID_U1:
+	case HID_PRODUCT_ID_U1_DUAL:
+		break;
+	default:
+		return 0;
+	}
+
+	priv = kzalloc(sizeof(struct u1_dev), GFP_KERNEL);
+	input2 = input_allocate_device();
+	if (!priv || !input2)
+		return 0;
+
+	priv->input2 = input2;
+	data->input = input;
+
+	hid_dbg(hdev, "Opening low level driver\n");
+	ret = hid_hw_open(hdev);
+	if (ret)
+		return ret;
+
+	/* Allow incoming hid reports */
+	hid_device_io_start(hdev);
+
+	/* Device initialization */
+	ret = u1_read_register(hdev, ADDRESS_U1_DEV_CTRL_1, &devInfo.dev_ctrl);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed U1_DEV_CTRL_1 (%d)\n", ret);
+		goto exit;
+	}
+
+	devInfo.dev_ctrl &= ~U1_DISABLE_DEV;
+	devInfo.dev_ctrl |= U1_TP_ABS_MODE;
+	ret = u1_write_register(hdev, ADDRESS_U1_DEV_CTRL_1, devInfo.dev_ctrl);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed to change TP mode (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = u1_read_register(hdev, ADDRESS_U1_NUM_SENS_X,
+		&devInfo.sen_line_num_x);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed U1_NUM_SENS_X (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = u1_read_register(hdev, ADDRESS_U1_NUM_SENS_Y,
+		&devInfo.sen_line_num_y);
+		if (ret < 0) {
+		dev_err(&hdev->dev, "failed U1_NUM_SENS_Y (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = u1_read_register(hdev, ADDRESS_U1_PITCH_SENS_X, &devInfo.pitch_x);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed U1_PITCH_SENS_X (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = u1_read_register(hdev, ADDRESS_U1_PITCH_SENS_Y, &devInfo.pitch_y);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed U1_PITCH_SENS_Y (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = u1_read_register(hdev, ADDRESS_U1_RESO_DWN_ABS,
+		&devInfo.resolution);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed U1_RESO_DWN_ABS (%d)\n", ret);
+		goto exit;
+	}
+
+	ret = u1_read_register(hdev, ADDRESS_U1_PAD_BTN, &devInfo.btn_info);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed U1_PAD_BTN (%d)\n", ret);
+		goto exit;
+	}
+
+	/* Check StickPointer device */
+	ret = u1_read_register(hdev, ADDRESS_U1_DEVICE_TYP, &devInfo.dev_type);
+	if (ret < 0) {
+		dev_err(&hdev->dev, "failed U1_DEVICE_TYP (%d)\n", ret);
+		goto exit;
+	}
+
+	devInfo.x_active_len_mm =
+		(devInfo.pitch_x * (devInfo.sen_line_num_x - 1)) / 10;
+	devInfo.y_active_len_mm =
+		(devInfo.pitch_y * (devInfo.sen_line_num_y - 1)) / 10;
+
+	devInfo.x_max =
+		(devInfo.resolution << 2) * (devInfo.sen_line_num_x - 1);
+	devInfo.y_max =
+		(devInfo.resolution << 2) * (devInfo.sen_line_num_y - 1);
+
+	__set_bit(EV_ABS, input->evbit);
+	input_set_abs_params(input, ABS_MT_POSITION_X, 1, devInfo.x_max, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 1, devInfo.y_max, 0, 0);
+
+	if (devInfo.x_active_len_mm && devInfo.y_active_len_mm) {
+		res_x = (devInfo.x_max - 1) / devInfo.x_active_len_mm;
+		res_y = (devInfo.y_max - 1) / devInfo.y_active_len_mm;
+
+		input_abs_set_res(input, ABS_MT_POSITION_X, res_x);
+		input_abs_set_res(input, ABS_MT_POSITION_Y, res_y);
+	}
+
+	input_set_abs_params(input, ABS_MT_PRESSURE, 0, 64, 0, 0);
+
+	input_mt_init_slots(input, MAX_TOUCHES, INPUT_MT_POINTER);
+
+	__set_bit(EV_KEY, input->evbit);
+	if ((devInfo.btn_info & 0x0F) == (devInfo.btn_info & 0xF0) >> 4) {
+		devInfo.btn_cnt = (devInfo.btn_info & 0x0F);
+	} else {
+		/* Button pad */
+		devInfo.btn_cnt = 1;
+		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
+	}
+
+	for (i = 0; i < devInfo.btn_cnt; i++)
+		__set_bit(BTN_LEFT + i, input->keybit);
+
+
+	/* Stick device initialization */
+	if (devInfo.dev_type & U1_DEVTYPE_SP_SUPPORT) {
+		devInfo.dev_ctrl |= U1_SP_ABS_MODE;
+		ret = u1_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
+			devInfo.dev_ctrl);
+		if (ret < 0) {
+			dev_err(&hdev->dev, "failed SP mode (%d)\n", ret);
+			goto exit;
+		}
+
+		ret = u1_read_register(hdev, ADDRESS_U1_SP_BTN,
+			&devInfo.sp_btn_info);
+		if (ret < 0) {
+			dev_err(&hdev->dev, "failed U1_SP_BTN (%d)\n", ret);
+			goto exit;
+		}
+
+		input2->phys = input->phys;
+		input2->name = "DualPoint Stick";
+		input2->id.bustype = BUS_I2C;
+		input2->id.vendor  = input->id.vendor;
+		input2->id.product = input->id.product;
+		input2->id.version = input->id.version;
+		input2->dev.parent = input->dev.parent;
+
+		__set_bit(EV_KEY, input2->evbit);
+		devInfo.sp_btn_cnt = (devInfo.sp_btn_info & 0x0F);
+		for (i = 0; i < devInfo.sp_btn_cnt; i++)
+			__set_bit(BTN_LEFT + i, input2->keybit);
+
+		__set_bit(EV_REL, input2->evbit);
+		__set_bit(REL_X, input2->relbit);
+		__set_bit(REL_Y, input2->relbit);
+		__set_bit(INPUT_PROP_POINTER, input2->propbit);
+		__set_bit(INPUT_PROP_POINTING_STICK, input2->propbit);
+
+		if (input_register_device(priv->input2))
+			goto exit;
+	}
+
+exit:
+	input_free_device(input2);
+	hid_device_io_stop(hdev);
+	hid_hw_close(hdev);
+	return ret;
+}
+
+static int alps_input_mapping(struct hid_device *hdev,
+		struct hid_input *hi, struct hid_field *field,
+		struct hid_usage *usage, unsigned long **bit, int *max)
+{
+	return -1;
+}
+
+static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
+{
+	struct u1_dev *data = NULL;
+	int ret;
+
+	data = devm_kzalloc(&hdev->dev, sizeof(struct u1_dev), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	data->hdev = hdev;
+	hid_set_drvdata(hdev, data);
+
+	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
+
+	ret = hid_parse(hdev);
+	if (ret) {
+		hid_err(hdev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
+	if (ret) {
+		hid_err(hdev, "hw start failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static void alps_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+}
+
+static const struct hid_device_id alps_id[] = {
+	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ALPS, HID_ANY_ID, HID_ANY_ID) },
+	{ }
+};
+MODULE_DEVICE_TABLE(hid, alps_id);
+
+static struct hid_driver alps_driver = {
+	.name = "hid-alps",
+	.id_table		= alps_id,
+	.probe			= alps_probe,
+	.remove			= alps_remove,
+	.raw_event		= alps_raw_event,
+	.input_mapping		= alps_input_mapping,
+	.input_configured	= alps_input_configured,
+#ifdef CONFIG_PM
+	.resume			= alps_post_resume,
+	.reset_resume		= alps_post_reset,
+#endif
+};
+
+module_hid_driver(alps_driver);
+
+MODULE_AUTHOR("Masaki Ota <masaki.ota@jp.alps.com>");
+MODULE_DESCRIPTION("ALPS HID driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 7e89288..124fc38 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -833,6 +833,11 @@ static int hid_scan_report(struct hid_device *hid)
 				 */
 				hid->group = HID_GROUP_RMI;
 		break;
+	case USB_VENDOR_ID_ALPS_JP:
+		if ((hid->group == HID_GROUP_GENERIC) &&
+			(hid->bus == BUS_I2C))
+			hid->group = HID_GROUP_ALPS;
+		break;
 	}
 
 	vfree(parser);
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b6ff6e7..cac68c7 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -67,6 +67,8 @@
 #define USB_VENDOR_ID_ALPS		0x0433
 #define USB_DEVICE_ID_IBM_GAMEPAD	0x1101
 
+#define USB_VENDOR_ID_ALPS_JP		0x044E
+
 #define USB_VENDOR_ID_ANTON		0x1130
 #define USB_DEVICE_ID_ANTON_TOUCH_PAD	0x3101
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 75b66ec..e35cabf 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -345,6 +345,7 @@ struct hid_item {
 #define HID_GROUP_RMI				0x0100
 #define HID_GROUP_WACOM				0x0101
 #define HID_GROUP_LOGITECH_DJ_DEVICE		0x0102
+#define HID_GROUP_ALPS				0x0103
 
 /*
  * This is the global environment of the parser. This information is
-- 
2.7.4

