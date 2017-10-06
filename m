From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH 2/7] Separate U1 device code
Date: Fri,  6 Oct 2017 10:16:56 +0900
Message-ID: <20171006011701.3761-3-masaki.ota@jp.alps.com>
References: <20171006011701.3761-1-masaki.ota@jp.alps.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171006011701.3761-1-masaki.ota@jp.alps.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com
List-Id: linux-input@vger.kernel.org

From: Masaki Ota <masaki.ota@jp.alps.com>
-Create "static int u1_init()" function for separate U1 device initialization code from Main initialization.
-Create "has_sp" variable for checking whether it has SP device or not.

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/hid/hid-alps.c | 120 +++++++++++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 53 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 519bfcf9eaf0..c4ea5c6c9be9 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -75,6 +75,7 @@
  * @y_max: maximum y coordinate value
  * @btn_cnt: number of buttons
  * @sp_btn_cnt: number of stick buttons
+ * @has_sp: boolean of sp existense
  */
 struct u1_dev {
 	struct input_dev *input;
@@ -96,6 +97,7 @@ struct u1_dev {
 	u32	y_max;
 	u32	btn_cnt;
 	u32	sp_btn_cnt;
+	u8	has_sp;
 };
 
 static int u1_read_write_register(struct hid_device *hdev, u32 address,
@@ -255,99 +257,130 @@ static int alps_post_resume(struct hid_device *hdev)
 }
 #endif /* CONFIG_PM */
 
-static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
+static int u1_init(struct hid_device *hdev, struct u1_dev *pri_data)
 {
-	struct u1_dev *data = hid_get_drvdata(hdev);
-	struct input_dev *input = hi->input, *input2;
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
 
 	/* Device initialization */
 	ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-			&data->dev_ctrl, 0, true);
+			&pri_data->dev_ctrl, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_DEV_CTRL_1 (%d)\n", ret);
 		goto exit;
 	}
 
-	data->dev_ctrl &= ~U1_DISABLE_DEV;
-	data->dev_ctrl |= U1_TP_ABS_MODE;
+	pri_data->dev_ctrl &= ~U1_DISABLE_DEV;
+	pri_data->dev_ctrl |= U1_TP_ABS_MODE;
 	ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-			NULL, data->dev_ctrl, false);
+			NULL, pri_data->dev_ctrl, false);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed to change TP mode (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_NUM_SENS_X,
-			&data->sen_line_num_x, 0, true);
+			&pri_data->sen_line_num_x, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_NUM_SENS_X (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_NUM_SENS_Y,
-			&data->sen_line_num_y, 0, true);
+			&pri_data->sen_line_num_y, 0, true);
 		if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_NUM_SENS_Y (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_PITCH_SENS_X,
-			&data->pitch_x, 0, true);
+			&pri_data->pitch_x, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_PITCH_SENS_X (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_PITCH_SENS_Y,
-			&data->pitch_y, 0, true);
+			&pri_data->pitch_y, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_PITCH_SENS_Y (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_RESO_DWN_ABS,
-		&data->resolution, 0, true);
+		&pri_data->resolution, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_RESO_DWN_ABS (%d)\n", ret);
 		goto exit;
 	}
+	pri_data->x_active_len_mm =
+		(pri_data->pitch_x * (pri_data->sen_line_num_x - 1)) / 10;
+	pri_data->y_active_len_mm =
+		(pri_data->pitch_y * (pri_data->sen_line_num_y - 1)) / 10;
+
+	pri_data->x_max =
+		(pri_data->resolution << 2) * (pri_data->sen_line_num_x - 1);
+	pri_data->y_max =
+		(pri_data->resolution << 2) * (pri_data->sen_line_num_y - 1);
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_PAD_BTN,
-			&data->btn_info, 0, true);
+			&pri_data->btn_info, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_PAD_BTN (%d)\n", ret);
 		goto exit;
 	}
 
+	pri_data->has_sp = 0;
 	/* Check StickPointer device */
 	ret = u1_read_write_register(hdev, ADDRESS_U1_DEVICE_TYP,
-			&data->dev_type, 0, true);
+			&pri_data->dev_type, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_DEVICE_TYP (%d)\n", ret);
 		goto exit;
 	}
 
-	data->x_active_len_mm =
-		(data->pitch_x * (data->sen_line_num_x - 1)) / 10;
-	data->y_active_len_mm =
-		(data->pitch_y * (data->sen_line_num_y - 1)) / 10;
+	if (pri_data->dev_type & U1_DEVTYPE_SP_SUPPORT) {
+		pri_data->dev_ctrl |= U1_SP_ABS_MODE;
+		ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
+			NULL, pri_data->dev_ctrl, false);
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
 
-	data->x_max =
-		(data->resolution << 2) * (data->sen_line_num_x - 1);
-	data->y_max =
-		(data->resolution << 2) * (data->sen_line_num_y - 1);
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
+
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
+	ret = u1_init(hdev, data);
+
+	if (ret)
+		goto exit;
 
 	__set_bit(EV_ABS, input->evbit);
 	input_set_abs_params(input, ABS_MT_POSITION_X, 1, data->x_max, 0, 0);
@@ -379,8 +412,7 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 
 
 	/* Stick device initialization */
-	if (data->dev_type & U1_DEVTYPE_SP_SUPPORT) {
-
+	if (data->has_sp) {
 		input2 = input_allocate_device();
 		if (!input2) {
 			ret = -ENOMEM;
@@ -388,24 +420,6 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		}
 
 		data->input2 = input2;
-
-		data->dev_ctrl |= U1_SP_ABS_MODE;
-		ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-			NULL, data->dev_ctrl, false);
-		if (ret < 0) {
-			dev_err(&hdev->dev, "failed SP mode (%d)\n", ret);
-			input_free_device(input2);
-			goto exit;
-		}
-
-		ret = u1_read_write_register(hdev, ADDRESS_U1_SP_BTN,
-			&data->sp_btn_info, 0, true);
-		if (ret < 0) {
-			dev_err(&hdev->dev, "failed U1_SP_BTN (%d)\n", ret);
-			input_free_device(input2);
-			goto exit;
-		}
-
 		input2->phys = input->phys;
 		input2->name = "DualPoint Stick";
 		input2->id.bustype = BUS_I2C;
-- 
2.11.0
