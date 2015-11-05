From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 11/26] Input: synaptics-rmi4 - f11: add support for kernel tracking
Date: Thu, 5 Nov 2015 15:39:54 -0800
Message-ID: <1446766794-30715-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Kernel tracking is used in 2 use cases:
- filter out jumps when the sensor is not relieable enough
- provide a MT protocol B when the sensor is providing MT protocol A data

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_f11.c | 153 +++++++++++++++++++++++++++++--------------
 include/linux/rmi.h          |  14 ++--
 2 files changed, 115 insertions(+), 52 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 02e3a6b..146691f 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -65,6 +65,9 @@
  * devices currently in the field.
  */
 
+/* maximum ABS_MT_POSITION displacement (in mm) */
+#define DMAX 10
+
 /**
  * @rezero - writing this to the F11 command register will cause the sensor to
  * calibrate to the current capacitive state.
@@ -497,9 +500,6 @@ struct f11_2d_data {
  * @data_pkt - buffer for data reported by this sensor.
  * @pkt_size - number of bytes in that buffer.
  * @sensor_index - identifies this particular 2D touch sensor
- * @type_a - some early RMI4 2D sensors do not reliably track the finger
- * position when two fingers are on the device.  When this is true, we
- * assume we have one of those sensors and report events appropriately.
  * @sensor_type - indicates whether we're touchscreen or touchpad.
  * @input - input device for absolute pointing stream
  * @input_phys - buffer for the absolute phys name for this sensor.
@@ -508,13 +508,16 @@ struct f11_2d_sensor {
 	struct rmi_f11_2d_axis_alignment axis_align;
 	struct f11_2d_sensor_queries sens_query;
 	struct f11_2d_data data;
+	struct input_mt_pos *tracking_pos;
+	int *tracking_slots;
+	bool kernel_tracking;
+	int dmax;
 	u16 max_x;
 	u16 max_y;
 	u8 nbr_fingers;
 	u8 *data_pkt;
 	int pkt_size;
 	u8 sensor_index;
-	u32 type_a;	/* boolean but debugfs API requires u32 */
 	bool topbuttonpad;
 	enum rmi_f11_sensor_type sensor_type;
 	struct input_dev *input;
@@ -604,6 +607,53 @@ static void rmi_f11_rel_pos_report(struct f11_2d_sensor *sensor, u8 n_finger)
 	}
 }
 
+static void rmi_f11_abs_parse_xy(struct f11_data *f11,
+				 struct f11_2d_sensor *sensor,
+				 enum f11_finger_state finger_state,
+				 u8 n_finger)
+{
+	struct f11_2d_data *data = &sensor->data;
+	struct rmi_f11_2d_axis_alignment *axis_align = &sensor->axis_align;
+	u8 *pos_data = &data->abs_pos[n_finger * RMI_F11_ABS_BYTES];
+	u16 x, y;
+
+	/* we keep the previous values if the finger is released */
+	if (!finger_state)
+		return;
+
+	x = (pos_data[0] << 4) | (pos_data[2] & 0x0F);
+	y = (pos_data[1] << 4) | (pos_data[2] >> 4);
+
+	if (axis_align->swap_axes)
+		swap(x, y);
+
+	if (axis_align->flip_x)
+		x = max(sensor->max_x - x, 0);
+
+	if (axis_align->flip_y)
+		y = max(sensor->max_y - y, 0);
+
+	/*
+	 * Here checking if X offset or y offset are specified is
+	 * redundant. We just add the offsets or clip the values.
+	 *
+	 * Note: offsets need to be applied before clipping occurs,
+	 * or we could get funny values that are outside of
+	 * clipping boundaries.
+	 */
+	x += axis_align->offset_x;
+	y += axis_align->offset_y;
+	x =  max(axis_align->clip_x_low, x);
+	y =  max(axis_align->clip_y_low, y);
+	if (axis_align->clip_x_high)
+		x = min(axis_align->clip_x_high, x);
+	if (axis_align->clip_y_high)
+		y =  min(axis_align->clip_y_high, y);
+
+	sensor->tracking_pos[n_finger].x = x;
+	sensor->tracking_pos[n_finger].y = y;
+}
+
 static void rmi_f11_abs_pos_report(struct f11_data *f11,
 				   struct f11_2d_sensor *sensor,
 				   enum f11_finger_state finger_state,
@@ -617,44 +667,16 @@ static void rmi_f11_abs_pos_report(struct f11_data *f11,
 	int w_x, w_y, w_max, w_min, orient;
 	int tool_type = rmi_f11_get_tool_type(sensor, finger_state);
 
-	if (sensor->type_a) {
-		input_report_abs(input, ABS_MT_TRACKING_ID, n_finger);
-		input_report_abs(input, ABS_MT_TOOL_TYPE, tool_type);
-	} else {
+	if (sensor->kernel_tracking)
+		input_mt_slot(input, sensor->tracking_slots[n_finger]);
+	else
 		input_mt_slot(input, n_finger);
-		input_mt_report_slot_state(input, tool_type,
-					   finger_state != F11_NO_FINGER);
-	}
+	input_mt_report_slot_state(input, tool_type,
+				   finger_state != F11_NO_FINGER);
 
 	if (finger_state) {
-		x = (pos_data[0] << 4) | (pos_data[2] & 0x0F);
-		y = (pos_data[1] << 4) | (pos_data[2] >> 4);
-
-		if (axis_align->swap_axes)
-			swap(x, y);
-
-		if (axis_align->flip_x)
-			x = max(sensor->max_x - x, 0);
-
-		if (axis_align->flip_y)
-			y = max(sensor->max_y - y, 0);
-
-		/*
-		 * Here checking if X offset or y offset are specified is
-		 * redundant. We just add the offsets or clip the values.
-		 *
-		 * Note: offsets need to be applied before clipping occurs,
-		 * or we could get funny values that are outside of
-		 * clipping boundaries.
-		 */
-		x += axis_align->offset_x;
-		y += axis_align->offset_y;
-		x =  max(axis_align->clip_x_low, x);
-		y =  max(axis_align->clip_y_low, y);
-		if (axis_align->clip_x_high)
-			x = min(axis_align->clip_x_high, x);
-		if (axis_align->clip_y_high)
-			y =  min(axis_align->clip_y_high, y);
+		x = sensor->tracking_pos[n_finger].x;
+		y = sensor->tracking_pos[n_finger].y;
 
 		w_x = pos_data[3] & 0x0f;
 		w_y = pos_data[3] >> 4;
@@ -690,10 +712,6 @@ static void rmi_f11_abs_pos_report(struct f11_data *f11,
 			"finger[%d]:%d - x:%d y:%d z:%d w_max:%d w_min:%d\n",
 			n_finger, finger_state, x, y, z, w_max, w_min);
 	}
-
-	/* MT sync between fingers */
-	if (sensor->type_a)
-		input_mt_sync(input);
 }
 
 static inline u8 rmi_f11_parse_finger_state(const u8 *f_state, u8 n_finger)
@@ -724,13 +742,36 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 		}
 
 		if (abs_bits)
-			rmi_f11_abs_pos_report(f11, sensor, finger_state, i);
+			rmi_f11_abs_parse_xy(f11, sensor, finger_state, i);
 
 		if (rel_bits)
 			rmi_f11_rel_pos_report(sensor, i);
 	}
 
-	input_mt_sync_frame(sensor->input);
+	if (abs_bits) {
+		/*
+		 * the absolute part is made in 2 parts to allow the kernel
+		 * tracking to take place.
+		 */
+		if (sensor->kernel_tracking)
+			input_mt_assign_slots(sensor->input,
+					      sensor->tracking_slots,
+					      sensor->tracking_pos,
+					      sensor->nbr_fingers,
+					      sensor->dmax);
+
+		for (i = 0; i < sensor->nbr_fingers; i++) {
+			finger_state = rmi_f11_parse_finger_state(f_state, i);
+			if (finger_state == F11_RESERVED)
+				/* no need to send twice the error */
+				continue;
+
+			rmi_f11_abs_pos_report(f11, sensor, finger_state, i);
+		}
+
+		input_mt_sync_frame(sensor->input);
+	}
+
 	if (!sensor->unified_input)
 		input_sync(sensor->input);
 }
@@ -1138,6 +1179,9 @@ static void f11_set_abs_params(struct rmi_function *fn, struct f11_data *f11)
 	else
 		input_flags = INPUT_MT_DIRECT;
 
+	if (sensor->kernel_tracking)
+		input_flags |= INPUT_MT_TRACK;
+
 	if (sensor->axis_align.swap_axes) {
 		int temp = device_x_max;
 		device_x_max = device_y_max;
@@ -1189,10 +1233,12 @@ static void f11_set_abs_params(struct rmi_function *fn, struct f11_data *f11)
 
 		input_abs_set_res(input, ABS_MT_POSITION_X, res_x);
 		input_abs_set_res(input, ABS_MT_POSITION_Y, res_y);
+
+		if (!sensor->dmax)
+			sensor->dmax = DMAX * res_x;
 	}
 
-	if (!sensor->type_a)
-		input_mt_init_slots(input, sensor->nbr_fingers, input_flags);
+	input_mt_init_slots(input, sensor->nbr_fingers, input_flags);
 	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) && sensor->sens_query.has_pen)
 		input_set_abs_params(input, ABS_MT_TOOL_TYPE,
 				     0, MT_TOOL_MAX, 0, 0);
@@ -1285,8 +1331,10 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	if (pdata->f11_sensor_data) {
 		sensor->axis_align =
 			pdata->f11_sensor_data->axis_align;
-		sensor->type_a = pdata->f11_sensor_data->type_a;
 		sensor->topbuttonpad = pdata->f11_sensor_data->topbuttonpad;
+		sensor->kernel_tracking =
+			pdata->f11_sensor_data->kernel_tracking;
+		sensor->dmax = pdata->f11_sensor_data->dmax;
 
 		if (sensor->sens_query.has_physical_props) {
 			sensor->x_mm = sensor->sens_query.x_sensor_size_mm;
@@ -1336,6 +1384,15 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	if (rc < 0)
 		return rc;
 
+	/* allocate the in-kernel tracking buffers */
+	sensor->tracking_pos = devm_kzalloc(&fn->dev,
+			sizeof(struct input_mt_pos) * sensor->nbr_fingers,
+			GFP_KERNEL);
+	sensor->tracking_slots = devm_kzalloc(&fn->dev,
+			sizeof(int) * sensor->nbr_fingers, GFP_KERNEL);
+	if (!sensor->tracking_pos || !sensor->tracking_slots)
+		return -ENOMEM;
+
 	ctrl = &f11->dev_controls;
 	if (sensor->axis_align.delta_x_threshold) {
 		ctrl->ctrl0_9[RMI_F11_DELTA_X_THRESHOLD] =
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 4ffe9fe..f270ff9 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -84,9 +84,6 @@ enum rmi_f11_sensor_type {
 /**
  * struct rmi_f11_sensor_data - overrides defaults for a single F11 2D sensor.
  * @axis_align - provides axis alignment overrides (see above).
- * @type_a - all modern RMI F11 firmwares implement Multifinger Type B
- * protocol.  Set this to true to force MF Type A behavior, in case you find
- * an older sensor.
  * @sensor_type - Forces the driver to treat the sensor as an indirect
  * pointing device (touchpad) rather than a direct pointing device
  * (touchscreen).  This is useful when F11_2D_QUERY14 register is not
@@ -95,15 +92,24 @@ enum rmi_f11_sensor_type {
  * by the firware.
  * @topbuttonpad - Used with the "5 buttons touchpads" found on the Lenovo 40
  * series
+ * @kernel_tracking - most moderns RMI f11 firmwares implement Multifinger
+ * Type B protocol. However, there are some corner cases where the user
+ * triggers some jumps by tapping with two fingers on the touchpad.
+ * Use this setting and dmax to filter out these jumps.
+ * Also, when using an old sensor using MF Type A behavior, set to true to
+ * report an actual MT protocol B.
+ * @dmax - the maximum distance (in sensor units) the kernel tracking allows two
+ * distincts fingers to be considered the same.
  */
 struct rmi_f11_sensor_data {
 	struct rmi_f11_2d_axis_alignment axis_align;
-	bool type_a;
 	enum rmi_f11_sensor_type sensor_type;
 	int x_mm;
 	int y_mm;
 	int disable_report_mask;
 	bool topbuttonpad;
+	bool kernel_tracking;
+	int dmax;
 };
 
 /**
-- 
2.1.4
