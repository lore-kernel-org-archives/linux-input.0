From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH] input synaptics-rmi4: elliminate multiple sensor support from rmi_f11.c
Date: Thu, 5 Dec 2013 17:59:27 -0800
Message-ID: <1386295167-866-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us-mx2.synaptics.com ([192.147.44.131]:18244 "EHLO
	us-mx2.synaptics.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab3LFCM1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Dec 2013 21:12:27 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Christopher Heiny <cheiny@synaptics.com>, Andrew Duggan <aduggan@synaptics.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Vivian Ly <vly@synaptics.com>, Daniel Rosenberg <daniel.rosenberg@synaptics.com>, Jean Delvare <khali@linux-fr.org>, Joerie de Gram <j.de.gram@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

This patch implements changes to the synaptics-rmi4 branch of
Dmitry's input tree.  The base for the patch is commit
8ca01dc61a42b6f7bcba052a8c084000f7057a34.

This patch elliminates support for multiple sensors in rmi_f11. This feature
has been removed from the RMI4 spec and no devices have every used multiple
F11 sensors on a single device.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 drivers/input/rmi4/rmi_f11.c | 374 +++++++++++++++++++------------------------
 include/linux/rmi.h          |  10 +-
 2 files changed, 170 insertions(+), 214 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 8984054..d3a9ba8 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -19,7 +19,6 @@
 #include <linux/slab.h>
 #include "rmi_driver.h"
 
-#define F11_MAX_NUM_OF_SENSORS		8
 #define F11_MAX_NUM_OF_FINGERS		10
 #define F11_MAX_NUM_OF_TOUCH_SHAPES	16
 
@@ -42,40 +41,23 @@
 
 /** A note about RMI4 F11 register structure.
  *
- *  There may be one or more individual 2D touch surfaces associated with an
- * instance for F11.  For example, a handheld device might have a touchscreen
- * display on the front, and a touchpad on the back.  F11 represents these touch
- * surfaces as individual sensors, up to 7 on a given RMI4 device.
- *
  * The properties for
  * a given sensor are described by its query registers.  The number of query
  * registers and the layout of their contents are described by the F11 device
- * queries as well as the per-sensor query information.  The query registers
- * for sensor[n+1] immediately follow those for sensor[n], so the start address
- * of the sensor[n+1] queries can only be computed if you know the size of the
- * sensor[n] queries.  Because each of the sensors may have different
- * properties, the size of the query registers for each sensor must be
- * calculated on a sensor by sensor basis.
+ * queries as well as the sensor query information.
  *
  * Similarly, each sensor has control registers that govern its behavior.  The
  * size and layout of the control registers for a given sensor can be determined
- * by parsing that sensors query registers.  The control registers for
- * sensor[n+1] immediately follow those for sensor[n], so you can only know
- * the start address for the sensor[n+1] controls if you know the size (and
- * location) of the sensor[n] controls.
+ * by parsing that sensors query registers.
  *
  * And in a likewise fashion, each sensor has data registers where it reports
  * its touch data and other interesting stuff.  The size and layout of a
  * sensors data registers must be determined by parsing its query registers.
- * The data registers for sensor[n+1] immediately follow those for sensor[n],
- * so you can only know the start address for the sensor[n+1] controls if you
- * know the size (and location) of the sensor[n] controls.
  *
  * The short story is that we need to read and parse a lot of query
- * registers in order to determine the attributes of a sensor[0].  Then
+ * registers in order to determine the attributes of a sensor. Then
  * we need to use that data to compute the size of the control and data
- * registers for sensor[0].  Once we have that figured out, we can then do
- * the same thing for each subsequent sensor.
+ * registers for sensor.
  *
  * The end result is that we have a number of structs that aren't used to
  * directly generate the input events, but their size, location and contents
@@ -811,7 +793,7 @@ struct f11_data {
 	struct f11_2d_ctrl dev_controls;
 	struct mutex dev_controls_mutex;
 	u16 rezero_wait_ms;
-	struct f11_2d_sensor sensors[F11_MAX_NUM_OF_SENSORS];
+	struct f11_2d_sensor sensor;
 };
 
 enum finger_state_values {
@@ -1519,10 +1501,10 @@ static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
 /* This operation is done in a number of places, so we have a handy routine
  * for it.
  */
-static void f11_set_abs_params(struct rmi_function *fn, int index)
+static void f11_set_abs_params(struct rmi_function *fn)
 {
 	struct f11_data *f11 = fn->data;
-	struct f11_2d_sensor *sensor = &f11->sensors[index];
+	struct f11_2d_sensor *sensor = &f11->sensor;
 	struct input_dev *input = sensor->input;
 	u16 device_x_max =
 		f11->dev_controls.ctrl0_9->sensor_max_x_pos;
@@ -1604,8 +1586,8 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	u16 control_base_addr;
 	u16 max_x_pos, max_y_pos, temp;
 	int rc;
-	int i;
 	struct rmi_device_platform_data *pdata = to_rmi_platform_data(rmi_dev);
+	struct f11_2d_sensor *sensor;
 
 	dev_dbg(&fn->dev, "Initializing F11 values for %s.\n",
 		 pdata->sensor_name);
@@ -1628,92 +1610,88 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 		return rc;
 
 	query_offset = (query_base_addr + 1);
-	/* Increase with one since number of sensors is zero based */
-	for (i = 0; i < (f11->dev_query.nbr_of_sensors + 1); i++) {
-		struct f11_2d_sensor *sensor = &f11->sensors[i];
-		sensor->sensor_index = i;
-		sensor->fn = fn;
-
-		rc = rmi_f11_get_query_parameters(rmi_dev, &f11->dev_query,
-				&sensor->sens_query, query_offset);
-		if (rc < 0)
-			return rc;
-		query_offset += rc;
+	sensor = &f11->sensor;
+	sensor->fn = fn;
 
-		rc = f11_allocate_control_regs(fn,
-				&f11->dev_query, &sensor->sens_query,
-				&f11->dev_controls, control_base_addr);
-		if (rc < 0) {
-			dev_err(&fn->dev,
-				"Failed to allocate F11 control params.\n");
-			return rc;
-		}
+	rc = rmi_f11_get_query_parameters(rmi_dev, &f11->dev_query,
+			&sensor->sens_query, query_offset);
+	if (rc < 0)
+		return rc;
+	query_offset += rc;
 
-		rc = f11_read_control_regs(fn, &f11->dev_controls,
-				control_base_addr);
-		if (rc < 0) {
-			dev_err(&fn->dev,
-				"Failed to read F11 control params.\n");
-			return rc;
-		}
+	rc = f11_allocate_control_regs(fn,
+			&f11->dev_query, &sensor->sens_query,
+			&f11->dev_controls, control_base_addr);
+	if (rc < 0) {
+		dev_err(&fn->dev,
+			"Failed to allocate F11 control params.\n");
+		return rc;
+	}
 
-		if (i < pdata->f11_sensor_count) {
-			sensor->axis_align =
-				pdata->f11_sensor_data[i].axis_align;
-			sensor->type_a = pdata->f11_sensor_data[i].type_a;
-			sensor->sensor_type =
-					pdata->f11_sensor_data[i].sensor_type;
-		}
+	rc = f11_read_control_regs(fn, &f11->dev_controls,
+			control_base_addr);
+	if (rc < 0) {
+		dev_err(&fn->dev,
+			"Failed to read F11 control params.\n");
+		return rc;
+	}
 
-		rc = rmi_read_block(rmi_dev,
-			control_base_addr + F11_CTRL_SENSOR_MAX_X_POS_OFFSET,
-			(u8 *)&max_x_pos, sizeof(max_x_pos));
-		if (rc < 0)
-			return rc;
+	if (pdata->f11_sensor_data) {
+		sensor->axis_align =
+			pdata->f11_sensor_data->axis_align;
+		sensor->type_a = pdata->f11_sensor_data->type_a;
+		sensor->sensor_type =
+				pdata->f11_sensor_data->sensor_type;
+	}
 
-		rc = rmi_read_block(rmi_dev,
-			control_base_addr + F11_CTRL_SENSOR_MAX_Y_POS_OFFSET,
-			(u8 *)&max_y_pos, sizeof(max_y_pos));
-		if (rc < 0)
-			return rc;
+	rc = rmi_read_block(rmi_dev,
+		control_base_addr + F11_CTRL_SENSOR_MAX_X_POS_OFFSET,
+		(u8 *)&max_x_pos, sizeof(max_x_pos));
+	if (rc < 0)
+		return rc;
 
-		if (sensor->axis_align.swap_axes) {
-			temp = max_x_pos;
-			max_x_pos = max_y_pos;
-			max_y_pos = temp;
-		}
-		sensor->max_x = max_x_pos;
-		sensor->max_y = max_y_pos;
+	rc = rmi_read_block(rmi_dev,
+		control_base_addr + F11_CTRL_SENSOR_MAX_Y_POS_OFFSET,
+		(u8 *)&max_y_pos, sizeof(max_y_pos));
+	if (rc < 0)
+		return rc;
 
-		rc = f11_2d_construct_data(sensor);
-		if (rc < 0)
-			return rc;
+	if (sensor->axis_align.swap_axes) {
+		temp = max_x_pos;
+		max_x_pos = max_y_pos;
+		max_y_pos = temp;
+	}
+	sensor->max_x = max_x_pos;
+	sensor->max_y = max_y_pos;
 
-		ctrl = &f11->dev_controls;
-		if (sensor->axis_align.delta_x_threshold) {
-			ctrl->ctrl0_9->delta_x_threshold =
-				sensor->axis_align.delta_x_threshold;
-			rc = rmi_write_block(rmi_dev,
-					ctrl->ctrl0_9_address,
-					ctrl->ctrl0_9,
-					sizeof(*ctrl->ctrl0_9));
-			if (rc < 0)
-				dev_warn(&fn->dev, "Failed to write to delta_x_threshold %d. Code: %d.\n",
-					i, rc);
+	rc = f11_2d_construct_data(sensor);
+	if (rc < 0)
+		return rc;
 
-		}
+	ctrl = &f11->dev_controls;
+	if (sensor->axis_align.delta_x_threshold) {
+		ctrl->ctrl0_9->delta_x_threshold =
+			sensor->axis_align.delta_x_threshold;
+		rc = rmi_write_block(rmi_dev,
+				ctrl->ctrl0_9_address,
+				ctrl->ctrl0_9,
+				sizeof(*ctrl->ctrl0_9));
+		if (rc < 0)
+			dev_warn(&fn->dev, "Failed to write to delta_x_threshold. Code: %d.\n",
+				rc);
 
-		if (sensor->axis_align.delta_y_threshold) {
-			ctrl->ctrl0_9->delta_y_threshold =
-				sensor->axis_align.delta_y_threshold;
-			rc = rmi_write_block(rmi_dev,
-					ctrl->ctrl0_9_address,
-					ctrl->ctrl0_9,
-					sizeof(*ctrl->ctrl0_9));
-			if (rc < 0)
-				dev_warn(&fn->dev, "Failed to write to delta_y_threshold %d. Code: %d.\n",
-					i, rc);
-		}
+	}
+
+	if (sensor->axis_align.delta_y_threshold) {
+		ctrl->ctrl0_9->delta_y_threshold =
+			sensor->axis_align.delta_y_threshold;
+		rc = rmi_write_block(rmi_dev,
+				ctrl->ctrl0_9_address,
+				ctrl->ctrl0_9,
+				sizeof(*ctrl->ctrl0_9));
+		if (rc < 0)
+			dev_warn(&fn->dev, "Failed to write to delta_y_threshold. Code: %d.\n",
+				rc);
 	}
 
 	mutex_init(&f11->dev_controls_mutex);
@@ -1728,22 +1706,61 @@ static int rmi_f11_register_devices(struct rmi_function *fn)
 	struct input_dev *input_dev_mouse;
 	struct rmi_driver_data *driver_data = dev_get_drvdata(&rmi_dev->dev);
 	struct rmi_driver *driver = rmi_dev->driver;
-	int sensors_itertd = 0;
-	int i;
+	struct f11_2d_sensor *sensor = &f11->sensor;
 	int rc;
 
-	for (i = 0; i < (f11->dev_query.nbr_of_sensors + 1); i++) {
-		struct f11_2d_sensor *sensor = &f11->sensors[i];
-		sensors_itertd = i;
-		input_dev = input_allocate_device();
-		if (!input_dev) {
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		rc = -ENOMEM;
+		goto error_unregister;
+	}
+
+	sensor->input = input_dev;
+	if (driver->set_input_params) {
+		rc = driver->set_input_params(rmi_dev, input_dev);
+		if (rc < 0) {
+			dev_err(&fn->dev,
+			"%s: Error in setting input device.\n",
+			__func__);
+			goto error_unregister;
+		}
+	}
+	sprintf(sensor->input_phys, "%s.abs/input0",
+		dev_name(&fn->dev));
+	input_dev->phys = sensor->input_phys;
+	input_dev->dev.parent = &rmi_dev->dev;
+	input_set_drvdata(input_dev, f11);
+
+	set_bit(EV_SYN, input_dev->evbit);
+	set_bit(EV_ABS, input_dev->evbit);
+	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
+
+	f11_set_abs_params(fn);
+
+	if (sensor->sens_query.info.has_rel) {
+		set_bit(EV_REL, input_dev->evbit);
+		set_bit(REL_X, input_dev->relbit);
+		set_bit(REL_Y, input_dev->relbit);
+	}
+	rc = input_register_device(input_dev);
+	if (rc < 0) {
+		input_free_device(input_dev);
+		sensor->input = NULL;
+		goto error_unregister;
+	}
+
+	if (sensor->sens_query.info.has_rel) {
+		/*create input device for mouse events  */
+		input_dev_mouse = input_allocate_device();
+		if (!input_dev_mouse) {
 			rc = -ENOMEM;
 			goto error_unregister;
 		}
 
-		sensor->input = input_dev;
+		sensor->mouse_input = input_dev_mouse;
 		if (driver->set_input_params) {
-			rc = driver->set_input_params(rmi_dev, input_dev);
+			rc = driver->set_input_params(rmi_dev,
+				input_dev_mouse);
 			if (rc < 0) {
 				dev_err(&fn->dev,
 				"%s: Error in setting input device.\n",
@@ -1751,87 +1768,39 @@ static int rmi_f11_register_devices(struct rmi_function *fn)
 				goto error_unregister;
 			}
 		}
-		sprintf(sensor->input_phys, "%s.abs%d/input0",
-			dev_name(&fn->dev), i);
-		input_dev->phys = sensor->input_phys;
-		input_dev->dev.parent = &rmi_dev->dev;
-		input_set_drvdata(input_dev, f11);
-
-		set_bit(EV_SYN, input_dev->evbit);
-		set_bit(EV_ABS, input_dev->evbit);
-		input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
-
-		f11_set_abs_params(fn, i);
-
-		if (sensor->sens_query.info.has_rel) {
-			set_bit(EV_REL, input_dev->evbit);
-			set_bit(REL_X, input_dev->relbit);
-			set_bit(REL_Y, input_dev->relbit);
-		}
-		rc = input_register_device(input_dev);
+		sprintf(sensor->input_phys_mouse, "%s.rel/input0",
+			dev_name(&fn->dev));
+		set_bit(EV_REL, input_dev_mouse->evbit);
+		set_bit(REL_X, input_dev_mouse->relbit);
+		set_bit(REL_Y, input_dev_mouse->relbit);
+
+		set_bit(BTN_MOUSE, input_dev_mouse->evbit);
+		/* Register device's buttons and keys */
+		set_bit(EV_KEY, input_dev_mouse->evbit);
+		set_bit(BTN_LEFT, input_dev_mouse->keybit);
+		set_bit(BTN_MIDDLE, input_dev_mouse->keybit);
+		set_bit(BTN_RIGHT, input_dev_mouse->keybit);
+
+		rc = input_register_device(input_dev_mouse);
 		if (rc < 0) {
-			input_free_device(input_dev);
-			sensor->input = NULL;
+			input_free_device(input_dev_mouse);
+			sensor->mouse_input = NULL;
 			goto error_unregister;
 		}
 
-		if (sensor->sens_query.info.has_rel) {
-			/*create input device for mouse events  */
-			input_dev_mouse = input_allocate_device();
-			if (!input_dev_mouse) {
-				rc = -ENOMEM;
-				goto error_unregister;
-			}
-
-			sensor->mouse_input = input_dev_mouse;
-			if (driver->set_input_params) {
-				rc = driver->set_input_params(rmi_dev,
-					input_dev_mouse);
-				if (rc < 0) {
-					dev_err(&fn->dev,
-					"%s: Error in setting input device.\n",
-					__func__);
-					goto error_unregister;
-				}
-			}
-			sprintf(sensor->input_phys_mouse, "%s.rel%d/input0",
-				dev_name(&fn->dev), i);
-			set_bit(EV_REL, input_dev_mouse->evbit);
-			set_bit(REL_X, input_dev_mouse->relbit);
-			set_bit(REL_Y, input_dev_mouse->relbit);
-
-			set_bit(BTN_MOUSE, input_dev_mouse->evbit);
-			/* Register device's buttons and keys */
-			set_bit(EV_KEY, input_dev_mouse->evbit);
-			set_bit(BTN_LEFT, input_dev_mouse->keybit);
-			set_bit(BTN_MIDDLE, input_dev_mouse->keybit);
-			set_bit(BTN_RIGHT, input_dev_mouse->keybit);
-
-			rc = input_register_device(input_dev_mouse);
-			if (rc < 0) {
-				input_free_device(input_dev_mouse);
-				sensor->mouse_input = NULL;
-				goto error_unregister;
-			}
-
-			set_bit(BTN_RIGHT, input_dev_mouse->keybit);
-		}
-
+		set_bit(BTN_RIGHT, input_dev_mouse->keybit);
 	}
 
 	return 0;
 
 error_unregister:
-	for (; sensors_itertd > 0; sensors_itertd--) {
-		if (f11->sensors[sensors_itertd].input) {
-			if (f11->sensors[sensors_itertd].mouse_input) {
-				input_unregister_device(
-				   f11->sensors[sensors_itertd].mouse_input);
-				f11->sensors[sensors_itertd].mouse_input = NULL;
-			}
-			input_unregister_device(f11->sensors[i].input);
-			f11->sensors[i].input = NULL;
+	if (f11->sensor.input) {
+		if (f11->sensor.mouse_input) {
+			input_unregister_device(f11->sensor.mouse_input);
+			f11->sensor.mouse_input = NULL;
 		}
+		input_unregister_device(f11->sensor.input);
+		f11->sensor.input = NULL;
 	}
 
 	return rc;
@@ -1840,28 +1809,22 @@ error_unregister:
 static void rmi_f11_free_devices(struct rmi_function *fn)
 {
 	struct f11_data *f11 = fn->data;
-	int i;
 
-	for (i = 0; i < (f11->dev_query.nbr_of_sensors + 1); i++) {
-		if (f11->sensors[i].input)
-			input_unregister_device(f11->sensors[i].input);
-		if (f11->sensors[i].mouse_input)
-			input_unregister_device(f11->sensors[i].mouse_input);
-	}
+	if (f11->sensor.input)
+		input_unregister_device(f11->sensor.input);
+	if (f11->sensor.mouse_input)
+		input_unregister_device(f11->sensor.mouse_input);
 }
 
 static int rmi_f11_config(struct rmi_function *fn)
 {
 	struct f11_data *f11 = fn->data;
-	int i;
 	int rc;
 
-	for (i = 0; i < (f11->dev_query.nbr_of_sensors + 1); i++) {
-		rc = f11_write_control_regs(fn, &f11->sensors[i].sens_query,
-				   &f11->dev_controls, fn->fd.query_base_addr);
-		if (rc < 0)
-			return rc;
-	}
+	rc = f11_write_control_regs(fn, &f11->sensor.sens_query,
+			   &f11->dev_controls, fn->fd.query_base_addr);
+	if (rc < 0)
+		return rc;
 
 	return 0;
 }
@@ -1874,19 +1837,16 @@ int rmi_f11_attention(struct rmi_function *fn,
 	u16 data_base_addr = fn->fd.data_base_addr;
 	u16 data_base_addr_offset = 0;
 	int error;
-	int i;
 
-	for (i = 0; i < f11->dev_query.nbr_of_sensors + 1; i++) {
-		error = rmi_read_block(rmi_dev,
-				data_base_addr + data_base_addr_offset,
-				f11->sensors[i].data_pkt,
-				f11->sensors[i].pkt_size);
-		if (error < 0)
-			return error;
+	error = rmi_read_block(rmi_dev,
+			data_base_addr + data_base_addr_offset,
+			f11->sensor.data_pkt,
+			f11->sensor.pkt_size);
+	if (error < 0)
+		return error;
 
-		rmi_f11_finger_handler(f11, &f11->sensors[i]);
-		data_base_addr_offset += f11->sensors[i].pkt_size;
-	}
+	rmi_f11_finger_handler(f11, &f11->sensor);
+	data_base_addr_offset += f11->sensor.pkt_size;
 
 	return 0;
 }
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index dc94dc1..735e978 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -222,13 +222,10 @@ struct rmi_device_platform_data_spi {
  * @spi_data - override default settings for SPI delays and SSB management (see
  * above).
  *
- * @f11_sensor_data - an array of platform data for individual F11 2D sensors.
- * @f11_sensor_count - the length of f11_sensor_data array.  Extra entries will
- * be ignored; if there are too few entries, all settings for the additional
- * sensors will be defaulted.
+ * @f11_sensor_data - platform data for the F11 2D sensor.
  * @f11_rezero_wait - if non-zero, this is how may milliseconds the F11 2D
- * sensor(s) will wait before being be rezeroed on exit from suspend.  If
- * this value is zero, the F11 2D sensor(s) will not be rezeroed on resume.
+ * sensor will wait before being be rezeroed on exit from suspend.  If
+ * this value is zero, the F11 2D sensor will not be rezeroed on resume.
  * @pre_suspend - this will be called before any other suspend operations are
  * done.
  * @power_management - overrides default touch sensor doze mode settings (see
@@ -266,7 +263,6 @@ struct rmi_device_platform_data {
 
 	/* function handler pdata */
 	struct rmi_f11_sensor_data *f11_sensor_data;
-	u8 f11_sensor_count;
 	u16 f11_rezero_wait;
 	struct rmi_f01_power_management power_management;
 	struct rmi_button_map *f19_button_map;
-- 
1.8.3.2

