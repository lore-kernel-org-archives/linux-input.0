From: Christopher Heiny <cheiny@synaptics.com>
Subject: [PATCH 2/3] Input: synaptics-rmi4 - ability disable abs or rel reporting
Date: Tue, 18 Mar 2014 18:03:50 -0700
Message-ID: <1395191031-3144-2-git-send-email-cheiny@synaptics.com>
References: <1395191031-3144-1-git-send-email-cheiny@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [192.147.44.131] ([192.147.44.131]:48903 "EHLO
	us-mx2.synaptics.com" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1758366AbaCSBEc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Mar 2014 21:04:32 -0400
In-Reply-To: <1395191031-3144-1-git-send-email-cheiny@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Even if the RMI4 touchscreen/touchpad provides reporting both
relative and absolute coordinates, reporting both to userspace
could be confusing. Allow the platform data to disable either
absolute or relative coordinates.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Acked-by: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linux Walleij <linus.walleij@linaro.org>
Cc: David Herrmann <dh.herrmann@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>

---
 drivers/input/rmi4/rmi_f11.c | 78 +++++++++++++++++++++++++++++++++++++-------
 include/linux/rmi.h          |  6 ++++
 2 files changed, 73 insertions(+), 11 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 07044d79..c87c6cc3 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -520,6 +520,8 @@ struct f11_2d_sensor {
 	struct rmi_function *fn;
 	char input_phys[NAME_BUFFER_SIZE];
 	char input_phys_mouse[NAME_BUFFER_SIZE];
+	u8 report_abs;
+	u8 report_rel;
 };
 
 /** Data pertaining to F11 in general.  For per-sensor data, see struct
@@ -544,6 +546,10 @@ struct f11_data {
 	struct mutex dev_controls_mutex;
 	u16 rezero_wait_ms;
 	struct f11_2d_sensor sensor;
+	unsigned long *abs_mask;
+	unsigned long *rel_mask;
+	unsigned long *result_bits;
+	unsigned long mask_memory[];
 };
 
 enum finger_state_values {
@@ -591,10 +597,14 @@ static void rmi_f11_rel_pos_report(struct f11_2d_sensor *sensor, u8 n_finger)
 	if (x || y) {
 		input_report_rel(sensor->input, REL_X, x);
 		input_report_rel(sensor->input, REL_Y, y);
-		input_report_rel(sensor->mouse_input, REL_X, x);
-		input_report_rel(sensor->mouse_input, REL_Y, y);
+
+		if (sensor->mouse_input) {
+			input_report_rel(sensor->mouse_input, REL_X, x);
+			input_report_rel(sensor->mouse_input, REL_Y, y);
+		}
 	}
-	input_sync(sensor->mouse_input);
+	if (sensor->mouse_input)
+		input_sync(sensor->mouse_input);
 }
 
 static void rmi_f11_abs_pos_report(struct f11_data *f11,
@@ -694,13 +704,17 @@ static void rmi_f11_abs_pos_report(struct f11_data *f11,
 }
 
 static void rmi_f11_finger_handler(struct f11_data *f11,
-				   struct f11_2d_sensor *sensor)
+				   struct f11_2d_sensor *sensor,
+				   unsigned long *irq_bits, int num_irq_regs)
 {
 	const u8 *f_state = sensor->data.f_state;
 	u8 finger_state;
 	u8 finger_pressed_count;
 	u8 i;
 
+	int rel_bits;
+	int abs_bits;
+
 	for (i = 0, finger_pressed_count = 0; i < sensor->nbr_fingers; i++) {
 		/* Possible of having 4 fingers per f_statet register */
 		finger_state = (f_state[i / 4] >> (2 * (i % 4))) &
@@ -714,13 +728,19 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 			finger_pressed_count++;
 		}
 
-		if (sensor->data.abs_pos)
+		abs_bits = bitmap_and(f11->result_bits, irq_bits, f11->abs_mask,
+				num_irq_regs);
+		if (abs_bits)
 			rmi_f11_abs_pos_report(f11, sensor, finger_state, i);
 
-		if (sensor->data.rel_pos)
+		rel_bits = bitmap_and(f11->result_bits, irq_bits, f11->rel_mask,
+				num_irq_regs);
+		if (rel_bits)
 			rmi_f11_rel_pos_report(sensor, i);
 	}
+
 	input_report_key(sensor->input, BTN_TOUCH, finger_pressed_count);
+
 	input_sync(sensor->input);
 }
 
@@ -1180,21 +1200,33 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	u16 max_x_pos, max_y_pos, temp;
 	int rc;
 	const struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
+	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	struct f11_2d_sensor *sensor;
 	u8 buf;
+	int mask_size;
 
 	dev_dbg(&fn->dev, "Initializing F11 values for %s.\n",
 		 pdata->sensor_name);
 
+	mask_size = BITS_TO_LONGS(drvdata->irq_count) * sizeof(unsigned long);
+
 	/*
 	** init instance data, fill in values and create any sysfs files
 	*/
-	f11 = devm_kzalloc(&fn->dev, sizeof(struct f11_data), GFP_KERNEL);
+	f11 = devm_kzalloc(&fn->dev, sizeof(struct f11_data) + mask_size * 3,
+			GFP_KERNEL);
 	if (!f11)
 		return -ENOMEM;
 
 	f11->rezero_wait_ms = pdata->f11_rezero_wait;
 
+	f11->abs_mask = f11->mask_memory + mask_size * 0;
+	f11->rel_mask = f11->mask_memory + mask_size * 1;
+	f11->result_bits = f11->mask_memory + mask_size * 2;
+
+	set_bit(fn->irq_pos, f11->abs_mask);
+	set_bit(fn->irq_pos + 1, f11->rel_mask);
+
 	query_base_addr = fn->fd.query_base_addr;
 	control_base_addr = fn->fd.control_base_addr;
 
@@ -1226,12 +1258,25 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 		return rc;
 	}
 
+	sensor->report_rel = sensor->sens_query.has_rel;
+	sensor->report_abs = sensor->sens_query.has_abs;
+
 	if (pdata->f11_sensor_data) {
 		sensor->axis_align =
 			pdata->f11_sensor_data->axis_align;
 		sensor->type_a = pdata->f11_sensor_data->type_a;
 		sensor->sensor_type =
 				pdata->f11_sensor_data->sensor_type;
+
+		if (sensor->sens_query.has_abs)
+			sensor->report_abs = sensor->report_abs
+				&& !(pdata->f11_sensor_data->disable_report_mask
+					& RMI_F11_DISABLE_ABS_REPORT);
+
+		if (sensor->sens_query.has_rel)
+			sensor->report_rel = sensor->report_rel
+				&& !(pdata->f11_sensor_data->disable_report_mask
+					& RMI_F11_DISABLE_REL_REPORT);
 	}
 
 	rc = rmi_read_block(rmi_dev,
@@ -1324,9 +1369,10 @@ static int rmi_f11_register_devices(struct rmi_function *fn)
 	set_bit(EV_ABS, input_dev->evbit);
 	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
 
-	f11_set_abs_params(fn, f11);
+	if (sensor->report_abs)
+		f11_set_abs_params(fn, f11);
 
-	if (sensor->sens_query.has_rel) {
+	if (sensor->report_rel) {
 		set_bit(EV_REL, input_dev->evbit);
 		set_bit(REL_X, input_dev->relbit);
 		set_bit(REL_Y, input_dev->relbit);
@@ -1338,7 +1384,7 @@ static int rmi_f11_register_devices(struct rmi_function *fn)
 		goto error_unregister;
 	}
 
-	if (sensor->sens_query.has_rel) {
+	if (sensor->report_rel) {
 		/*create input device for mouse events  */
 		input_dev_mouse = input_allocate_device();
 		if (!input_dev_mouse) {
@@ -1407,8 +1453,16 @@ error_unregister:
 static int rmi_f11_config(struct rmi_function *fn)
 {
 	struct f11_data *f11 = dev_get_drvdata(&fn->dev);
+	struct rmi_driver *drv = fn->rmi_dev->driver;
+	struct f11_2d_sensor *sensor = &f11->sensor;
 	int rc;
 
+	if (!sensor->report_abs)
+		drv->clear_irq_bits(fn->rmi_dev, f11->abs_mask);
+
+	if (!sensor->report_rel)
+		drv->clear_irq_bits(fn->rmi_dev, f11->rel_mask);
+
 	rc = f11_write_control_regs(fn, &f11->sensor.sens_query,
 			   &f11->dev_controls, fn->fd.query_base_addr);
 	if (rc < 0)
@@ -1420,6 +1474,7 @@ static int rmi_f11_config(struct rmi_function *fn)
 static int rmi_f11_attention(struct rmi_function *fn, unsigned long *irq_bits)
 {
 	struct rmi_device *rmi_dev = fn->rmi_dev;
+	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
 	struct f11_data *f11 = dev_get_drvdata(&fn->dev);
 	u16 data_base_addr = fn->fd.data_base_addr;
 	u16 data_base_addr_offset = 0;
@@ -1432,7 +1487,8 @@ static int rmi_f11_attention(struct rmi_function *fn, unsigned long *irq_bits)
 	if (error)
 		return error;
 
-	rmi_f11_finger_handler(f11, &f11->sensor);
+	rmi_f11_finger_handler(f11, &f11->sensor, irq_bits,
+				drvdata->num_of_irq_regs);
 	data_base_addr_offset += f11->sensor.pkt_size;
 
 	return 0;
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index 735e978..a0d0187 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -76,6 +76,9 @@ enum rmi_f11_sensor_type {
 	rmi_f11_sensor_touchpad
 };
 
+#define RMI_F11_DISABLE_ABS_REPORT      (1 << 0)
+#define RMI_F11_DISABLE_REL_REPORT      (1 << 1)
+
 /**
  * struct rmi_f11_sensor_data - overrides defaults for a single F11 2D sensor.
  * @axis_align - provides axis alignment overrides (see above).
@@ -86,11 +89,14 @@ enum rmi_f11_sensor_type {
  * pointing device (touchpad) rather than a direct pointing device
  * (touchscreen).  This is useful when F11_2D_QUERY14 register is not
  * available.
+ * @disable_report_mask - Force data to not be reported even if it is supported
+ * by the firware.
  */
 struct rmi_f11_sensor_data {
 	struct rmi_f11_2d_axis_alignment axis_align;
 	bool type_a;
 	enum rmi_f11_sensor_type sensor_type;
+	int disable_report_mask;
 };
 
 /**
-- 
1.8.3.2

