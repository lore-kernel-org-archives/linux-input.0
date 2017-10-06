From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH 4/7] replace some variables
Date: Fri,  6 Oct 2017 10:16:58 +0900
Message-ID: <20171006011701.3761-5-masaki.ota@jp.alps.com>
References: <20171006011701.3761-1-masaki.ota@jp.alps.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171006011701.3761-1-masaki.ota@jp.alps.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com
List-Id: linux-input@vger.kernel.org

From: Masaki Ota <masaki.ota@jp.alps.com>
-Move some variables(dev_ctrl, dev_type, sen_line_num_x, sen_line_num_y, pitch_x, pitch_y, resolution, btn_info) from u1_dev structure to "u1_init()", because these variables are only used in "u1_init()" function.

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/hid/hid-alps.c | 67 ++++++++++++++++++++------------------------------
 1 file changed, 27 insertions(+), 40 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 201fe175cba3..4c323b58e009 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -61,14 +61,10 @@
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
@@ -77,22 +73,14 @@
  * @y_min: minimum y coordinate value
  * @btn_cnt: number of buttons
  * @sp_btn_cnt: number of stick buttons
- * @has_sp: boolean of sp existense
- * @max_fingers: total number of fingers
  */
 struct u1_dev {
 	struct input_dev *input;
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
@@ -102,8 +90,6 @@ struct u1_dev {
 	u32	y_min;
 	u32	btn_cnt;
 	u32	sp_btn_cnt;
-	u8	has_sp;
-	u8	max_fingers;
 };
 
 static int u1_read_write_register(struct hid_device *hdev, u32 address,
@@ -266,78 +252,80 @@ static int alps_post_resume(struct hid_device *hdev)
 static int u1_init(struct hid_device *hdev, struct u1_dev *pri_data)
 {
 	int ret;
+	u8 tmp, dev_ctrl, sen_line_num_x, sen_line_num_y;
+	u8 pitch_x, pitch_y, resolution;
 
 	/* Device initialization */
 	ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-			&pri_data->dev_ctrl, 0, true);
+			&dev_ctrl, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_DEV_CTRL_1 (%d)\n", ret);
 		goto exit;
 	}
 
-	pri_data->dev_ctrl &= ~U1_DISABLE_DEV;
-	pri_data->dev_ctrl |= U1_TP_ABS_MODE;
+	dev_ctrl &= ~U1_DISABLE_DEV;
+	dev_ctrl |= U1_TP_ABS_MODE;
 	ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-			NULL, pri_data->dev_ctrl, false);
+			NULL, dev_ctrl, false);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed to change TP mode (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_NUM_SENS_X,
-			&pri_data->sen_line_num_x, 0, true);
+			&sen_line_num_x, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_NUM_SENS_X (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_NUM_SENS_Y,
-			&pri_data->sen_line_num_y, 0, true);
+			&sen_line_num_y, 0, true);
 		if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_NUM_SENS_Y (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_PITCH_SENS_X,
-			&pri_data->pitch_x, 0, true);
+			&pitch_x, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_PITCH_SENS_X (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_PITCH_SENS_Y,
-			&pri_data->pitch_y, 0, true);
+			&pitch_y, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_PITCH_SENS_Y (%d)\n", ret);
 		goto exit;
 	}
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_RESO_DWN_ABS,
-		&pri_data->resolution, 0, true);
+		&resolution, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_RESO_DWN_ABS (%d)\n", ret);
 		goto exit;
 	}
 	pri_data->x_active_len_mm =
-		(pri_data->pitch_x * (pri_data->sen_line_num_x - 1)) / 10;
+		(pitch_x * (sen_line_num_x - 1)) / 10;
 	pri_data->y_active_len_mm =
-		(pri_data->pitch_y * (pri_data->sen_line_num_y - 1)) / 10;
+		(pitch_y * (sen_line_num_y - 1)) / 10;
 
 	pri_data->x_max =
-		(pri_data->resolution << 2) * (pri_data->sen_line_num_x - 1);
+		(resolution << 2) * (sen_line_num_x - 1);
 	pri_data->x_min = 1;
 	pri_data->y_max =
-		(pri_data->resolution << 2) * (pri_data->sen_line_num_y - 1);
+		(resolution << 2) * (sen_line_num_y - 1);
 	pri_data->y_min = 1;
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_PAD_BTN,
-			&pri_data->btn_info, 0, true);
+			&tmp, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_PAD_BTN (%d)\n", ret);
 		goto exit;
 	}
-	if ((pri_data->btn_info & 0x0F) == (pri_data->btn_info & 0xF0) >> 4) {
-		pri_data->btn_cnt = (pri_data->btn_info & 0x0F);
+	if ((tmp & 0x0F) == (tmp & 0xF0) >> 4) {
+		pri_data->btn_cnt = (tmp & 0x0F);
 	} else {
 		/* Button pad */
 		pri_data->btn_cnt = 1;
@@ -346,16 +334,15 @@ static int u1_init(struct hid_device *hdev, struct u1_dev *pri_data)
 	pri_data->has_sp = 0;
 	/* Check StickPointer device */
 	ret = u1_read_write_register(hdev, ADDRESS_U1_DEVICE_TYP,
-			&pri_data->dev_type, 0, true);
+			&tmp, 0, true);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "failed U1_DEVICE_TYP (%d)\n", ret);
 		goto exit;
 	}
-
-	if (pri_data->dev_type & U1_DEVTYPE_SP_SUPPORT) {
-		pri_data->dev_ctrl |= U1_SP_ABS_MODE;
+	if (tmp & U1_DEVTYPE_SP_SUPPORT) {
+		dev_ctrl |= U1_SP_ABS_MODE;
 		ret = u1_read_write_register(hdev, ADDRESS_U1_DEV_CTRL_1,
-			NULL, pri_data->dev_ctrl, false);
+			NULL, dev_ctrl, false);
 		if (ret < 0) {
 			dev_err(&hdev->dev, "failed SP mode (%d)\n", ret);
 			goto exit;
-- 
2.11.0
