From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH 1/4] Replace Alps U1 Touchpad code
Date: Thu, 27 Apr 2017 16:40:31 +0900
Message-ID: <1493278834-8523-2-git-send-email-masaki.ota@jp.alps.com>
References: <1493278834-8523-1-git-send-email-masaki.ota@jp.alps.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1493278834-8523-1-git-send-email-masaki.ota@jp.alps.com>
Sender: linux-kernel-owner@vger.kernel.org
To: benjamin.tissoires@redhat.com, jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com
List-Id: linux-input@vger.kernel.org

>From Masaki Ota <masaki.ota@jp.alps.com>

- Separate U1 device initialization from common initialization.

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/hid/hid-alps.c | 188 ++++++++++++++++++++++++++-----------------------
 1 file changed, 99 insertions(+), 89 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index ed9c0ea..984e452 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -55,24 +55,22 @@
 #define MAX_TOUCHES	5
 
 /**
- * struct u1_data
+ * struct u1_dev
  *
  * @input: pointer to the kernel input device
  * @input2: pointer to the kernel input2 device
  * @hdev: pointer to the struct hid_device
  *
- * @dev_ctrl: device control parameter
  * @dev_type: device type
- * @sen_line_num_x: number of sensor line of X
- * @sen_line_num_y: number of sensor line of Y
- * @pitch_x: sensor pitch of X
- * @pitch_y: sensor pitch of Y
- * @resolution: resolution
- * @btn_info: button information
+ * @max_fingers: total number of fingers
+ * @has_sp: boolean of sp existense
+ * @sp_btn_info: button information
  * @x_active_len_mm: active area length of X (mm)
  * @y_active_len_mm: active area length of Y (mm)
  * @x_max: maximum x coordinate value
  * @y_max: maximum y coordinate value
+ * @x_min: minimum x coordinate value
+ * @y_min: minimum y coordinate value
  * @btn_cnt: number of buttons
  * @sp_btn_cnt: number of stick buttons
  */
@@ -81,19 +79,15 @@ struct u1_dev {
 	struct input_dev *input2;
 	struct hid_device *hdev;
 
-	u8	dev_ctrl;
-	u8	dev_type;
-	u8	sen_line_num_x;
-	u8	sen_line_num_y;
-	u8	pitch_x;
-	u8	pitch_y;
-	u8	resolution;
-	u8	btn_info;
+	u8  max_fingers;
+	u8  has_sp;
 	u8	sp_btn_info;
 	u32	x_active_len_mm;
 	u32	y_active_len_mm;
 	u32	x_max;
 	u32	y_max;
+	u32	x_min;
+	u32	y_min;
 	u32	btn_cnt;
 	u32	sp_btn_cnt;
 };
@@ -255,108 +249,149 @@ static int alps_post_resume(struct hid_device *hdev)
 }
 #endif /* CONFIG_PM */
 
-static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
+static int u1_init(struct hid_device *hdev, struct u1_dev *pri_data)
 {
-	struct u1_dev *data = hid_get_drvdata(hdev);
-	struct input_dev *input = hi->input, *input2;
-	struct u1_dev devInfo;
 	int ret;
-	int res_x, res_y, i;
-
-	data->input = input;
-
-	hid_dbg(hdev, "Opening low level driver\n");
-	ret = hid_hw_open(hdev);
-	if (ret)
-		return ret;
-
-	/* Allow incoming hid reports */
-	hid_device_io_start(hdev);
+	u8 tmp, dev_ctrl, sen_line_num_x, sen_line_num_y;
+	u8 pitch_x, pitch_y, resolution;
 
 	/* Device initialization */
 	ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-			&devInfo.dev_ctrl, 0, true);
+			&dev_ctrl, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_DEV_CTRL_1 (%d)\n", ret);
 		goto exit;
 	}
 
-	devInfo.dev_ctrl &= ~U1_DISABLE_DEV;
-	devInfo.dev_ctrl |= U1_TP_ABS_MODE;
+	dev_ctrl &= ~U1_DISABLE_DEV;
+	dev_ctrl |= U1_TP_ABS_MODE;
 	ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-			NULL, devInfo.dev_ctrl, false);
+			NULL, dev_ctrl, false);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed to change TP mode (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_NUM_SENS_X,
-			&devInfo.sen_line_num_x, 0, true);
+			&sen_line_num_x, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_NUM_SENS_X (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_NUM_SENS_Y,
-			&devInfo.sen_line_num_y, 0, true);
+			&sen_line_num_y, 0, true);
 		if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_NUM_SENS_Y (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_PITCH_SENS_X,
-			&devInfo.pitch_x, 0, true);
+			&pitch_x, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_PITCH_SENS_X (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_PITCH_SENS_Y,
-			&devInfo.pitch_y, 0, true);
+			&pitch_y, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_PITCH_SENS_Y (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_RESO_DWN_ABS,
-		&devInfo.resolution, 0, true);
+		&resolution, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_RESO_DWN_ABS (%d)\n", ret);
 		goto exit;
 	}
+	pri_data->x_active_len_mm =
+		(pitch_x * (sen_line_num_x - 1)) / 10;
+	pri_data->y_active_len_mm =
+		(pitch_y * (sen_line_num_y - 1)) / 10;
+
+	pri_data->x_max =
+		(resolution << 2) * (sen_line_num_x - 1);
+	pri_data->x_min = 1;
+	pri_data->y_max =
+		(resolution << 2) * (sen_line_num_y - 1);
+	pri_data->y_min = 1;
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_PAD_BTN,
-			&devInfo.btn_info, 0, true);
+			&tmp, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_PAD_BTN (%d)\n", ret);
 		goto exit;
 	}
+	if ((tmp & 0x0F) == (tmp & 0xF0) >> 4) {
+		pri_data->btn_cnt = (tmp & 0x0F);
+	} else {
+		/* Button pad */
+		pri_data->btn_cnt = 1;
+	}
 
+	pri_data->has_sp = 0;
 	/* Check StickPointer device */
 	ret = u1_read_write_register(hdev, ADDRESS_U1_DEVICE_TYP,
-			&devInfo.dev_type, 0, true);
+			&tmp, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_DEVICE_TYP (%d)\n", ret);
 		goto exit;
 	}
+	if (tmp & U1_DEVTYPE_SP_SUPPORT) {
+		dev_ctrl |= U1_SP_ABS_MODE;
+		ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
+			NULL, dev_ctrl, false);
+		if (ret < 0) {
+			dev_err(&hdev->dev, "failed SP mode (%d)\n", ret);
+			goto exit;
+		}
+
+		ret = u1_read_write_register(hdev, ADDRESS_U1_SP_BTN,
+			&pri_data->sp_btn_info, 0, true);
+		if (ret < 0) {
+			dev_err(&hdev->dev, "failed U1_SP_BTN (%d)\n", ret);
+			goto exit;
+		}
+		pri_data->has_sp = 1;
+	}
+	pri_data->max_fingers = 5;
+exit:
+	return ret;
+}
+
+static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
+{
+	struct u1_dev *data = hid_get_drvdata(hdev);
+	struct input_dev *input = hi->input, *input2;
+	int ret;
+	int res_x, res_y, i;
 
-	devInfo.x_active_len_mm =
-		(devInfo.pitch_x * (devInfo.sen_line_num_x - 1)) / 10;
-	devInfo.y_active_len_mm =
-		(devInfo.pitch_y * (devInfo.sen_line_num_y - 1)) / 10;
+	data->input = input;
+
+	hid_dbg(hdev, "Opening low level driver\n");
+	ret = hid_hw_open(hdev);
+	if (ret)
+		return ret;
 
-	devInfo.x_max =
-		(devInfo.resolution << 2) * (devInfo.sen_line_num_x - 1);
-	devInfo.y_max =
-		(devInfo.resolution << 2) * (devInfo.sen_line_num_y - 1);
+	/* Allow incoming hid reports */
+	hid_device_io_start(hdev);
+
+	ret = u1_init(hdev, data);
+
+	if (ret)
+		goto exit;
 
 	__set_bit(EV_ABS, input->evbit);
-	input_set_abs_params(input, ABS_MT_POSITION_X, 1, devInfo.x_max, 0, 0);
-	input_set_abs_params(input, ABS_MT_POSITION_Y, 1, devInfo.y_max, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_X,
+						data->x_min, data->x_max, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y,
+						data->y_min, data->y_max, 0, 0);
 
-	if (devInfo.x_active_len_mm && devInfo.y_active_len_mm) {
-		res_x = (devInfo.x_max - 1) / devInfo.x_active_len_mm;
-		res_y = (devInfo.y_max - 1) / devInfo.y_active_len_mm;
+	if (data->x_active_len_mm && data->y_active_len_mm) {
+		res_x = (data->x_max - 1) / data->x_active_len_mm;
+		res_y = (data->y_max - 1) / data->y_active_len_mm;
 
 		input_abs_set_res(input, ABS_MT_POSITION_X, res_x);
 		input_abs_set_res(input, ABS_MT_POSITION_Y, res_y);
@@ -364,49 +399,25 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 
 	input_set_abs_params(input, ABS_MT_PRESSURE, 0, 64, 0, 0);
 
-	input_mt_init_slots(input, MAX_TOUCHES, INPUT_MT_POINTER);
+	input_mt_init_slots(input, data->max_fingers, INPUT_MT_POINTER);
 
 	__set_bit(EV_KEY, input->evbit);
-	if ((devInfo.btn_info & 0x0F) == (devInfo.btn_info & 0xF0) >> 4) {
-		devInfo.btn_cnt = (devInfo.btn_info & 0x0F);
-	} else {
-		/* Button pad */
-		devInfo.btn_cnt = 1;
+
+	if (data->btn_cnt == 1)
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
-	}
 
-	for (i = 0; i < devInfo.btn_cnt; i++)
+	for (i = 0; i < data->btn_cnt; i++)
 		__set_bit(BTN_LEFT + i, input->keybit);
 
-
 	/* Stick device initialization */
-	if (devInfo.dev_type & U1_DEVTYPE_SP_SUPPORT) {
-
+	if (data->has_sp) {
 		input2 = input_allocate_device();
 		if (!input2) {
-			ret = -ENOMEM;
-			goto exit;
-		}
-
-		data->input2 = input2;
-
-		devInfo.dev_ctrl |= U1_SP_ABS_MODE;
-		ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-			NULL, devInfo.dev_ctrl, false);
-		if (ret < 0) {
-			dev_err(&hdev->dev, "failed SP mode (%d)\n", ret);
-			input_free_device(input2);
-			goto exit;
-		}
-
-		ret = u1_read_write_register(hdev, ADDRESS_U1_SP_BTN,
-			&devInfo.sp_btn_info, 0, true);
-		if (ret < 0) {
-			dev_err(&hdev->dev, "failed U1_SP_BTN (%d)\n", ret);
 			input_free_device(input2);
 			goto exit;
 		}
 
+		data->input2 = input2;
 		input2->phys = input->phys;
 		input2->name = "DualPoint Stick";
 		input2->id.bustype = BUS_I2C;
@@ -416,8 +427,8 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		input2->dev.parent = input->dev.parent;
 
 		__set_bit(EV_KEY, input2->evbit);
-		devInfo.sp_btn_cnt = (devInfo.sp_btn_info & 0x0F);
-		for (i = 0; i < devInfo.sp_btn_cnt; i++)
+		data->sp_btn_cnt = (data->sp_btn_info & 0x0F);
+		for (i = 0; i < data->sp_btn_cnt; i++)
 			__set_bit(BTN_LEFT + i, input2->keybit);
 
 		__set_bit(EV_REL, input2->evbit);
@@ -426,8 +437,7 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		__set_bit(INPUT_PROP_POINTER, input2->propbit);
 		__set_bit(INPUT_PROP_POINTING_STICK, input2->propbit);
 
-		ret = input_register_device(data->input2);
-		if (ret) {
+		if (input_register_device(data->input2)) {
 			input_free_device(input2);
 			goto exit;
 		}
-- 
2.7.4
