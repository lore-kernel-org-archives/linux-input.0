From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH 3/7] Add some variables
Date: Fri,  6 Oct 2017 10:16:57 +0900
Message-ID: <20171006011701.3761-4-masaki.ota@jp.alps.com>
References: <20171006011701.3761-1-masaki.ota@jp.alps.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171006011701.3761-1-masaki.ota@jp.alps.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com
List-Id: linux-input@vger.kernel.org

From: Masaki Ota <masaki.ota@jp.alps.com>
-Create x_min, y_min and max_fingers variables for set correct XY minimum value and the number of max finger on each devices.
-Move the Button pad checking code to U1 init function, because this checking code is for U1 device.

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
---
 drivers/hid/hid-alps.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index c4ea5c6c9be9..201fe175cba3 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -73,9 +73,12 @@
  * @y_active_len_mm: active area length of Y (mm)
  * @x_max: maximum x coordinate value
  * @y_max: maximum y coordinate value
+ * @x_min: minimum x coordinate value
+ * @y_min: minimum y coordinate value
  * @btn_cnt: number of buttons
  * @sp_btn_cnt: number of stick buttons
  * @has_sp: boolean of sp existense
+ * @max_fingers: total number of fingers
  */
 struct u1_dev {
 	struct input_dev *input;
@@ -95,9 +98,12 @@ struct u1_dev {
 	u32	y_active_len_mm;
 	u32	x_max;
 	u32	y_max;
+	u32	x_min;
+	u32	y_min;
 	u32	btn_cnt;
 	u32	sp_btn_cnt;
 	u8	has_sp;
+	u8	max_fingers;
 };
 
 static int u1_read_write_register(struct hid_device *hdev, u32 address,
@@ -319,8 +325,10 @@ static int u1_init(struct hid_device *hdev, struct u1_dev *pri_data)
 
 	pri_data->x_max =
 		(pri_data->resolution << 2) * (pri_data->sen_line_num_x - 1);
+	pri_data->x_min = 1;
 	pri_data->y_max =
 		(pri_data->resolution << 2) * (pri_data->sen_line_num_y - 1);
+	pri_data->y_min = 1;
 
 	ret = u1_read_write_register(hdev, ADDRESS_U1_PAD_BTN,
 			&pri_data->btn_info, 0, true);
@@ -328,6 +336,12 @@ static int u1_init(struct hid_device *hdev, struct u1_dev *pri_data)
 		dev_err(&hdev->dev, "failed U1_PAD_BTN (%d)\n", ret);
 		goto exit;
 	}
+	if ((pri_data->btn_info & 0x0F) == (pri_data->btn_info & 0xF0) >> 4) {
+		pri_data->btn_cnt = (pri_data->btn_info & 0x0F);
+	} else {
+		/* Button pad */
+		pri_data->btn_cnt = 1;
+	}
 
 	pri_data->has_sp = 0;
 	/* Check StickPointer device */
@@ -355,7 +369,7 @@ static int u1_init(struct hid_device *hdev, struct u1_dev *pri_data)
 		}
 		pri_data->has_sp = 1;
 	}
-
+	pri_data->max_fingers = 5;
 exit:
 	return ret;
 }
@@ -383,8 +397,10 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		goto exit;
 
 	__set_bit(EV_ABS, input->evbit);
-	input_set_abs_params(input, ABS_MT_POSITION_X, 1, data->x_max, 0, 0);
-	input_set_abs_params(input, ABS_MT_POSITION_Y, 1, data->y_max, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_X,
+						data->x_min, data->x_max, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y,
+						data->y_min, data->y_max, 0, 0);
 
 	if (data->x_active_len_mm && data->y_active_len_mm) {
 		res_x = (data->x_max - 1) / data->x_active_len_mm;
@@ -396,26 +412,21 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 
 	input_set_abs_params(input, ABS_MT_PRESSURE, 0, 64, 0, 0);
 
-	input_mt_init_slots(input, MAX_TOUCHES, INPUT_MT_POINTER);
+	input_mt_init_slots(input, data->max_fingers, INPUT_MT_POINTER);
 
 	__set_bit(EV_KEY, input->evbit);
-	if ((data->btn_info & 0x0F) == (data->btn_info & 0xF0) >> 4) {
-		data->btn_cnt = (data->btn_info & 0x0F);
-	} else {
-		/* Button pad */
-		data->btn_cnt = 1;
+
+	if (data->btn_cnt == 1)
 		__set_bit(INPUT_PROP_BUTTONPAD, input->propbit);
-	}
 
 	for (i = 0; i < data->btn_cnt; i++)
 		__set_bit(BTN_LEFT + i, input->keybit);
 
-
 	/* Stick device initialization */
 	if (data->has_sp) {
 		input2 = input_allocate_device();
 		if (!input2) {
-			ret = -ENOMEM;
+			input_free_device(input2);
 			goto exit;
 		}
 
@@ -439,8 +450,7 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		__set_bit(INPUT_PROP_POINTER, input2->propbit);
 		__set_bit(INPUT_PROP_POINTING_STICK, input2->propbit);
 
-		ret = input_register_device(data->input2);
-		if (ret) {
+		if (input_register_device(data->input2)) {
 			input_free_device(input2);
 			goto exit;
 		}
-- 
2.11.0
