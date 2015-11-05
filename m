From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH 20/26] Input: synaptics-rmi4: Create common functions for 2D sensors
Date: Thu, 5 Nov 2015 15:42:05 -0800
Message-ID: <1446766925-31123-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>
List-Id: linux-input@vger.kernel.org

RMI4 defines two functions for 2D sensors. This patch moves some of the
code which is shared between the two functions into a new file to avoid
duplicating the code on rmi_f11.c and rmi_f12.c.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
---
 .../bindings/input/rmi4/rmi_2d_sensor.txt          |  55 +++
 drivers/input/rmi4/Kconfig                         |  11 +
 drivers/input/rmi4/Makefile                        |   2 +
 drivers/input/rmi4/rmi_2d_sensor.c                 | 370 ++++++++++++++++
 drivers/input/rmi4/rmi_2d_sensor.h                 |  87 ++++
 drivers/input/rmi4/rmi_f11.c                       | 487 +++++----------------
 include/linux/rmi.h                                |  30 +-
 7 files changed, 639 insertions(+), 403 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
 create mode 100644 drivers/input/rmi4/rmi_2d_sensor.c
 create mode 100644 drivers/input/rmi4/rmi_2d_sensor.h

diff --git a/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
new file mode 100644
index 0000000..79411c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rmi4/rmi_2d_sensor.txt
@@ -0,0 +1,55 @@
+Synaptics RMI4 2D Sensor Device Binding
+
+The Synaptics RMI4 core is able to support RMI4 devices using differnet
+transports and differnet functions. This file describes the device tree
+bindings for devices which contain 2D sensors using Function 11 or
+Function 12. Complete documentation for transports and other functions
+can be found in:
+Documentation/devicetree/bindings/input/rmi4.
+
+RMI4 Function 11 and Function 12 are for 2D touch position sensing.
+Additional documentation for F11 can be found at:
+http://www.synaptics.com/sites/default/files/511-000136-01-Rev-E-RMI4-Interfacing-Guide.pdf
+
+Optional Properties:
+- syna,swap-axes: Swap X and Y positions when reporting (boolean).
+- syna,flip-x: Reverse the direction of X (boolean).
+- syna,flip-y: Reverse the direction of Y (boolean).
+- syna,clip-x-low: Sets a minimum value for X.
+- syna,clip-y-low: Sets a minimum value for Y.
+- syna,clip-x-high: Sets a maximum value for X.
+- syna,clip-y-high: Sets a maximum value for Y.
+- syna,offset-x: Add an offset to X.
+- syna,offset_y: Add an offset to Y.
+- syna,delta-x-threshold: Set the minimum distance on the X axis required
+				to generate an interrupt in reduced reporting
+				mode.
+- syna,delta-y-threshold: Set the minimum distance on the Y axis required
+				to generate an interrupt in reduced reporting
+				mode.
+- syna,type-a: Report type A multitouch events.
+- syna,sensor-type: Set the sensor type. 1 for touchscreen 2 for touchpad.
+- syna,x-mm: The length in millimeters of the X axis.
+- syna,y-mm: The length in millimeters of the Y axis.
+- syna,disable-report-mask: Mask for disabling posiiton reporting. Used to
+				disable reporing absolute position data.
+- syna,rezero-wait: Time in miliseconds to wait after issuing a rezero
+				command.
+
+
+Example of a RMI4 I2C device with F11:
+Example:
+	&i2c1 {
+		rmi-i2c-dev@2c {
+			compatible = "syna,rmi-i2c";
+
+			...
+
+			rmi-f11@11 {
+				reg = <0x11>;
+				syna,flip-y;
+				syna,sensor-type = <2>;
+			};
+		};
+	};
+
diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index 88a3919..db2c1be 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -45,6 +45,17 @@ config RMI4_SPI
 
 	  If unsure, say N.
 
+config RMI4_2D_SENSOR
+	bool "RMI4 2D Sensors"
+	depends on RMI4_CORE
+	default y if RMI4_CORE
+	help
+	  Say Y here if you want to add support for 2D Sensors.
+
+	  Provides core functionality for 2D multifinger pointing for
+	  touchscreens and touchpads using RMI4 functions 11 and 12. This
+	  feature is needed is the device contains either F11 or F12.
+
 config RMI4_F11
 	bool "RMI4 Function 11 (2D pointing)"
 	depends on RMI4_CORE
diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index 1745757..e4812d8 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -1,6 +1,8 @@
 obj-$(CONFIG_RMI4_CORE) += rmi_core.o
 rmi_core-y := rmi_bus.o rmi_driver.o rmi_f01.o
 
+rmi_core-$(CONFIG_RMI4_2D_SENSOR) += rmi_2d_sensor.o
+
 # Function drivers
 rmi_core-$(CONFIG_RMI4_F11) += rmi_f11.o
 
diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
new file mode 100644
index 0000000..57c0ba8
--- /dev/null
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -0,0 +1,370 @@
+/*
+ * Copyright (c) 2011-2015 Synaptics Incorporated
+ * Copyright (c) 2011 Unixphere
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/of.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/rmi.h>
+#include "rmi_driver.h"
+#include "rmi_2d_sensor.h"
+
+#define RMI_2D_REL_POS_MIN		-128
+#define RMI_2D_REL_POS_MAX		127
+
+/* maximum ABS_MT_POSITION displacement (in mm) */
+#define DMAX 10
+
+void rmi_2d_sensor_abs_process(struct rmi_2d_sensor *sensor,
+				struct rmi_2d_sensor_abs_object *obj,
+				int slot)
+{
+	struct rmi_2d_axis_alignment *axis_align = &sensor->axis_align;
+
+	/* we keep the previous values if the finger is released */
+	if (obj->type == RMI_2D_OBJECT_NONE)
+		return;
+
+	if (axis_align->swap_axes)
+		swap(obj->x, obj->y);
+
+	if (axis_align->flip_x)
+		obj->x = sensor->max_x - obj->x;
+
+	if (axis_align->flip_y)
+		obj->y = sensor->max_y - obj->y;
+
+	/*
+	 * Here checking if X offset or y offset are specified is
+	 * redundant. We just add the offsets or clip the values.
+	 *
+	 * Note: offsets need to be applied before clipping occurs,
+	 * or we could get funny values that are outside of
+	 * clipping boundaries.
+	 */
+	obj->x += axis_align->offset_x;
+	obj->y += axis_align->offset_y;
+
+	obj->x =  max(axis_align->clip_x_low, obj->x);
+	obj->y =  max(axis_align->clip_y_low, obj->y);
+
+	if (axis_align->clip_x_high)
+		obj->x = min(sensor->max_x, obj->x);
+
+	if (axis_align->clip_y_high)
+		obj->y =  min(sensor->max_y, obj->y);
+
+	sensor->tracking_pos[slot].x = obj->x;
+	sensor->tracking_pos[slot].y = obj->y;
+}
+EXPORT_SYMBOL_GPL(rmi_2d_sensor_abs_process);
+
+void rmi_2d_sensor_abs_report(struct rmi_2d_sensor *sensor,
+				struct rmi_2d_sensor_abs_object *obj,
+				int slot)
+{
+	struct rmi_2d_axis_alignment *axis_align = &sensor->axis_align;
+	struct input_dev *input = sensor->input;
+	int wide, major, minor;
+
+	if (sensor->kernel_tracking)
+		input_mt_slot(input, sensor->tracking_slots[slot]);
+	else
+		input_mt_slot(input, slot);
+
+	input_mt_report_slot_state(input, obj->mt_tool,
+				   obj->type != RMI_2D_OBJECT_NONE);
+
+	if (obj->type != RMI_2D_OBJECT_NONE) {
+		obj->x = sensor->tracking_pos[slot].x;
+		obj->y = sensor->tracking_pos[slot].y;
+
+		if (axis_align->swap_axes)
+			swap(obj->wx, obj->wy);
+
+		wide = (obj->wx > obj->wy);
+		major = max(obj->wx, obj->wy);
+		minor = min(obj->wx, obj->wy);
+
+		if (obj->type == RMI_2D_OBJECT_STYLUS) {
+			major = max(1, major);
+			minor = max(1, minor);
+		}
+
+		input_event(sensor->input, EV_ABS, ABS_MT_POSITION_X, obj->x);
+		input_event(sensor->input, EV_ABS, ABS_MT_POSITION_Y, obj->y);
+		input_event(sensor->input, EV_ABS, ABS_MT_ORIENTATION, wide);
+		input_event(sensor->input, EV_ABS, ABS_MT_PRESSURE, obj->z);
+		input_event(sensor->input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
+		input_event(sensor->input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
+
+		dev_dbg(&sensor->input->dev, "%s: obj[%d]: type: 0x%02x X: %d Y: %d Z: %d WX: %d WY: %d\n",
+			__func__, slot, obj->type, obj->x, obj->y, obj->z,
+			obj->wx, obj->wy);
+	}
+}
+EXPORT_SYMBOL_GPL(rmi_2d_sensor_abs_report);
+
+void rmi_2d_sensor_rel_report(struct rmi_2d_sensor *sensor, int x, int y)
+{
+	struct rmi_2d_axis_alignment *axis_align = &sensor->axis_align;
+
+	x = min(RMI_2D_REL_POS_MAX, max(RMI_2D_REL_POS_MIN, (int)x));
+	y = min(RMI_2D_REL_POS_MAX, max(RMI_2D_REL_POS_MIN, (int)y));
+
+	if (axis_align->swap_axes)
+		swap(x, y);
+
+	if (axis_align->flip_x)
+		x = min(RMI_2D_REL_POS_MAX, -x);
+
+	if (axis_align->flip_y)
+		y = min(RMI_2D_REL_POS_MAX, -y);
+
+	if (x || y) {
+		input_report_rel(sensor->input, REL_X, x);
+		input_report_rel(sensor->input, REL_Y, y);
+	}
+}
+EXPORT_SYMBOL_GPL(rmi_2d_sensor_rel_report);
+
+static void rmi_2d_sensor_set_input_params(struct rmi_2d_sensor *sensor)
+{
+	struct input_dev *input = sensor->input;
+	int res_x;
+	int res_y;
+	int input_flags = 0;
+
+	if (sensor->report_abs) {
+		if (sensor->axis_align.swap_axes)
+			swap(sensor->max_x, sensor->max_y);
+
+		sensor->min_x = sensor->axis_align.clip_x_low;
+		if (sensor->axis_align.clip_x_high)
+			sensor->max_x = min(sensor->max_x,
+				sensor->axis_align.clip_x_high);
+
+		sensor->min_y = sensor->axis_align.clip_y_low;
+		if (sensor->axis_align.clip_y_high)
+			sensor->max_y = min(sensor->max_y,
+				sensor->axis_align.clip_y_high);
+
+		set_bit(EV_ABS, input->evbit);
+		input_set_abs_params(input, ABS_MT_POSITION_X, 0, sensor->max_x,
+					0, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, sensor->max_y,
+					0, 0);
+
+		if (sensor->x_mm && sensor->y_mm) {
+			res_x = (sensor->max_x - sensor->min_x) / sensor->x_mm;
+			res_y = (sensor->max_y - sensor->min_y) / sensor->y_mm;
+
+			input_abs_set_res(input, ABS_X, res_x);
+			input_abs_set_res(input, ABS_Y, res_y);
+
+			input_abs_set_res(input, ABS_MT_POSITION_X, res_x);
+			input_abs_set_res(input, ABS_MT_POSITION_Y, res_y);
+
+			if (!sensor->dmax)
+				sensor->dmax = DMAX * res_x;
+		}
+
+		input_set_abs_params(input, ABS_MT_PRESSURE, 0,	0xff, 0, 0);
+		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR,	0, 0x0f, 0, 0);
+		input_set_abs_params(input, ABS_MT_TOUCH_MINOR,	0, 0x0f, 0, 0);
+		input_set_abs_params(input, ABS_MT_ORIENTATION,	0, 1, 0, 0);
+
+		if (sensor->sensor_type == rmi_sensor_touchpad)
+			input_flags = INPUT_MT_POINTER;
+		else
+			input_flags = INPUT_MT_DIRECT;
+
+		if (sensor->kernel_tracking)
+			input_flags |= INPUT_MT_TRACK;
+
+		input_mt_init_slots(input, sensor->nbr_fingers, input_flags);
+	}
+
+	if (sensor->report_rel) {
+		set_bit(EV_REL, input->evbit);
+		set_bit(REL_X, input->relbit);
+		set_bit(REL_Y, input->relbit);
+	}
+
+	if (sensor->topbuttonpad)
+		set_bit(INPUT_PROP_TOPBUTTONPAD, input->propbit);
+}
+EXPORT_SYMBOL_GPL(rmi_2d_sensor_set_input_params);
+
+int rmi_2d_sensor_configure_input(struct rmi_function *fn,
+					struct rmi_2d_sensor *sensor)
+{
+	struct rmi_device *rmi_dev = fn->rmi_dev;
+	struct input_dev *input_dev;
+	struct rmi_driver *driver = rmi_dev->driver;
+	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
+	int rc;
+
+	if (!drv_data->input) {
+		input_dev = input_allocate_device();
+	} else {
+		input_dev = drv_data->input;
+		sensor->unified_input = true;
+	}
+
+	if (!input_dev) {
+		rc = -ENOMEM;
+		goto error_unregister;
+	}
+
+	sensor->input = input_dev;
+
+	if (!sensor->unified_input) {
+		if (driver->set_input_params) {
+			rc = driver->set_input_params(rmi_dev, input_dev);
+			if (rc < 0) {
+				dev_err(&fn->dev,
+					"%s: Error in setting input device.\n",
+					__func__);
+				goto error_unregister;
+			}
+		}
+		snprintf(sensor->input_phys, sizeof(sensor->input_phys),
+			"%s.abs/input0", dev_name(&fn->dev));
+		input_dev->phys = sensor->input_phys;
+		input_dev->dev.parent = &rmi_dev->dev;
+	}
+
+	rmi_2d_sensor_set_input_params(sensor);
+
+	if (!sensor->unified_input) {
+		rc = input_register_device(input_dev);
+		if (rc) {
+			input_free_device(input_dev);
+			sensor->input = NULL;
+			goto error_unregister;
+		}
+	}
+
+	return 0;
+
+error_unregister:
+	if (!sensor->unified_input && sensor->input) {
+		input_unregister_device(sensor->input);
+		sensor->input = NULL;
+	}
+
+	return rc;
+}
+
+#ifdef CONFIG_OF
+int rmi_2d_sensor_of_probe(struct device *dev,
+				struct rmi_2d_sensor_platform_data *pdata)
+{
+	int retval;
+
+	pdata->axis_align.swap_axes = of_property_read_bool(dev->of_node,
+						"syna,swap-axes");
+
+	pdata->axis_align.flip_x = of_property_read_bool(dev->of_node,
+						"syna,flip-x");
+
+	pdata->axis_align.flip_y = of_property_read_bool(dev->of_node,
+						"syna,flip-y");
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->axis_align.clip_x_low,
+			"syna,clip-x-low", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->axis_align.clip_y_low,
+			"syna,clip-y-low", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->axis_align.clip_x_high,
+			"syna,clip-x-high", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->axis_align.clip_y_high,
+			"syna,clip-y-high", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->axis_align.offset_x,
+			"syna,offset-x", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev,
+			&pdata->axis_align.offset_y,
+			"syna,offset_y", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->axis_align.delta_x_threshold,
+			"syna,delta-x-threshold", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u8(dev,
+			&pdata->axis_align.delta_y_threshold,
+			"syna,delta-y-threshold", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->sensor_type,
+			"syna,sensor-type", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->x_mm,
+			"syna,x-mm", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->y_mm,
+			"syna,y-mm", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u32(dev,
+			(u32 *)&pdata->disable_report_mask,
+			"syna,disable-report-mask", 1);
+	if (retval)
+		return retval;
+
+	retval = rmi_of_property_read_u16(dev, &pdata->rezero_wait,
+			"syna,rezero-wait", 1);
+	if (retval)
+		return retval;
+
+	return 0;
+}
+#else
+inline int rmi_2d_sensor_of_probe(struct device *dev,
+				struct rmi_2d_sensor *sensor,
+				struct rmi_2d_sensor_platform_data *pdata)
+{
+	return -ENODEV;
+}
+
+
+#endif
diff --git a/drivers/input/rmi4/rmi_2d_sensor.h b/drivers/input/rmi4/rmi_2d_sensor.h
new file mode 100644
index 0000000..c13a50d
--- /dev/null
+++ b/drivers/input/rmi4/rmi_2d_sensor.h
@@ -0,0 +1,87 @@
+/*
+ * Copyright (c) 2011-2015 Synaptics Incorporated
+ * Copyright (c) 2011 Unixphere
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _RMI_2D_SENSOR_H
+#define _RMI_2D_SENSOR_H
+
+enum rmi_2d_sensor_object_type {
+	RMI_2D_OBJECT_NONE,
+	RMI_2D_OBJECT_FINGER,
+	RMI_2D_OBJECT_STYLUS,
+	RMI_2D_OBJECT_PALM,
+	RMI_2D_OBJECT_UNCLASSIFIED,
+};
+
+struct rmi_2d_sensor_abs_object {
+	enum rmi_2d_sensor_object_type type;
+	int mt_tool;
+	u16 x;
+	u16 y;
+	u8 z;
+	u8 wx;
+	u8 wy;
+};
+
+/**
+ * @axis_align - controls parameters that are useful in system prototyping
+ * and bring up.
+ * @max_x - The maximum X coordinate that will be reported by this sensor.
+ * @max_y - The maximum Y coordinate that will be reported by this sensor.
+ * @nbr_fingers - How many fingers can this sensor report?
+ * @data_pkt - buffer for data reported by this sensor.
+ * @pkt_size - number of bytes in that buffer.
+ * @type_a - some early RMI4 2D sensors do not reliably track the finger
+ * position when two fingers are on the device.  When this is true, we
+ * assume we have one of those sensors and report events appropriately.
+ * @sensor_type - indicates whether we're touchscreen or touchpad.
+ * @input - input device for absolute pointing stream
+ * @input_phys - buffer for the absolute phys name for this sensor.
+ */
+struct rmi_2d_sensor {
+	struct rmi_2d_axis_alignment axis_align;
+	struct input_mt_pos *tracking_pos;
+	int *tracking_slots;
+	bool kernel_tracking;
+	struct rmi_2d_sensor_abs_object *objs;
+	int dmax;
+	u16 min_x;
+	u16 max_x;
+	u16 min_y;
+	u16 max_y;
+	u8 nbr_fingers;
+	u8 *data_pkt;
+	int pkt_size;
+	bool topbuttonpad;
+	enum rmi_sensor_type sensor_type;
+	struct input_dev *input;
+	bool unified_input;
+	struct rmi_function *fn;
+	char input_phys[32];
+	u8 report_abs;
+	u8 report_rel;
+	u8 x_mm;
+	u8 y_mm;
+};
+
+int rmi_2d_sensor_of_probe(struct device *dev,
+				struct rmi_2d_sensor_platform_data *pdata);
+
+void rmi_2d_sensor_abs_process(struct rmi_2d_sensor *sensor,
+				struct rmi_2d_sensor_abs_object *obj,
+				int slot);
+
+void rmi_2d_sensor_abs_report(struct rmi_2d_sensor *sensor,
+				struct rmi_2d_sensor_abs_object *obj,
+				int slot);
+
+void rmi_2d_sensor_rel_report(struct rmi_2d_sensor *sensor, int x, int y);
+
+int rmi_2d_sensor_configure_input(struct rmi_function *fn,
+					struct rmi_2d_sensor *sensor);
+#endif /* _RMI_2D_SENSOR_H */
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index 146691f..ee4b155 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -15,14 +15,13 @@
 #include <linux/kconfig.h>
 #include <linux/rmi.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include "rmi_driver.h"
+#include "rmi_2d_sensor.h"
 
 #define F11_MAX_NUM_OF_FINGERS		10
 #define F11_MAX_NUM_OF_TOUCH_SHAPES	16
 
-#define F11_REL_POS_MIN		-128
-#define F11_REL_POS_MAX		127
-
 #define FINGER_STATE_MASK	0x03
 
 #define F11_CTRL_SENSOR_MAX_X_POS_OFFSET	6
@@ -34,7 +33,6 @@
 #define DEFAULT_MAX_ABS_MT_ORIENTATION 1
 #define DEFAULT_MIN_ABS_MT_TRACKING_ID 1
 #define DEFAULT_MAX_ABS_MT_TRACKING_ID 10
-#define FUNCTION_NUMBER 0x11
 
 /** A note about RMI4 F11 register structure.
  *
@@ -488,48 +486,6 @@ struct f11_2d_data {
 	s8	*scroll_zones;
 };
 
-/**
- * @axis_align - controls parameters that are useful in system prototyping
- * and bring up.
- * @sens_query - query registers for this particular sensor.
- * @data - the data reported by this sensor, mapped into a collection of
- * structs.
- * @max_x - The maximum X coordinate that will be reported by this sensor.
- * @max_y - The maximum Y coordinate that will be reported by this sensor.
- * @nbr_fingers - How many fingers can this sensor report?
- * @data_pkt - buffer for data reported by this sensor.
- * @pkt_size - number of bytes in that buffer.
- * @sensor_index - identifies this particular 2D touch sensor
- * @sensor_type - indicates whether we're touchscreen or touchpad.
- * @input - input device for absolute pointing stream
- * @input_phys - buffer for the absolute phys name for this sensor.
- */
-struct f11_2d_sensor {
-	struct rmi_f11_2d_axis_alignment axis_align;
-	struct f11_2d_sensor_queries sens_query;
-	struct f11_2d_data data;
-	struct input_mt_pos *tracking_pos;
-	int *tracking_slots;
-	bool kernel_tracking;
-	int dmax;
-	u16 max_x;
-	u16 max_y;
-	u8 nbr_fingers;
-	u8 *data_pkt;
-	int pkt_size;
-	u8 sensor_index;
-	bool topbuttonpad;
-	enum rmi_f11_sensor_type sensor_type;
-	struct input_dev *input;
-	bool unified_input;
-	struct rmi_function *fn;
-	char input_phys[NAME_BUFFER_SIZE];
-	u8 report_abs;
-	u8 report_rel;
-	u8 x_mm;
-	u8 y_mm;
-};
-
 /** Data pertaining to F11 in general.  For per-sensor data, see struct
  * f11_2d_sensor.
  *
@@ -551,7 +507,10 @@ struct f11_data {
 	struct f11_2d_ctrl dev_controls;
 	struct mutex dev_controls_mutex;
 	u16 rezero_wait_ms;
-	struct f11_2d_sensor sensor;
+	struct rmi_2d_sensor sensor;
+	struct f11_2d_sensor_queries sens_query;
+	struct f11_2d_data data;
+	struct rmi_2d_sensor_platform_data sensor_pdata;
 	unsigned long *abs_mask;
 	unsigned long *rel_mask;
 	unsigned long *result_bits;
@@ -567,151 +526,60 @@ enum f11_finger_state {
 /** F11_INACCURATE state is overloaded to indicate pen present. */
 #define F11_PEN F11_INACCURATE
 
-static int rmi_f11_get_tool_type(struct f11_2d_sensor *sensor,
+static int rmi_f11_get_tool_type(struct f11_data *f11,
 				 enum f11_finger_state finger_state)
 {
 	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) &&
-			sensor->sens_query.has_pen &&
+			f11->sens_query.has_pen &&
 			finger_state == F11_PEN)
 		return MT_TOOL_PEN;
 
 	return MT_TOOL_FINGER;
 }
 
-static void rmi_f11_rel_pos_report(struct f11_2d_sensor *sensor, u8 n_finger)
+static void rmi_f11_rel_pos_report(struct f11_data *f11, u8 n_finger)
 {
-	struct f11_2d_data *data = &sensor->data;
-	struct rmi_f11_2d_axis_alignment *axis_align = &sensor->axis_align;
+	struct rmi_2d_sensor *sensor = &f11->sensor;
+	struct f11_2d_data *data = &f11->data;
 	s8 x, y;
-	s8 temp;
 
 	x = data->rel_pos[n_finger * 2];
 	y = data->rel_pos[n_finger * 2 + 1];
 
-	x = min(F11_REL_POS_MAX, max(F11_REL_POS_MIN, (int)x));
-	y = min(F11_REL_POS_MAX, max(F11_REL_POS_MIN, (int)y));
-
-	if (axis_align->swap_axes) {
-		temp = x;
-		x = y;
-		y = temp;
-	}
-	if (axis_align->flip_x)
-		x = min(F11_REL_POS_MAX, -x);
-	if (axis_align->flip_y)
-		y = min(F11_REL_POS_MAX, -y);
-
-	if (x || y) {
-		input_report_rel(sensor->input, REL_X, x);
-		input_report_rel(sensor->input, REL_Y, y);
-	}
-}
-
-static void rmi_f11_abs_parse_xy(struct f11_data *f11,
-				 struct f11_2d_sensor *sensor,
-				 enum f11_finger_state finger_state,
-				 u8 n_finger)
-{
-	struct f11_2d_data *data = &sensor->data;
-	struct rmi_f11_2d_axis_alignment *axis_align = &sensor->axis_align;
-	u8 *pos_data = &data->abs_pos[n_finger * RMI_F11_ABS_BYTES];
-	u16 x, y;
-
-	/* we keep the previous values if the finger is released */
-	if (!finger_state)
-		return;
-
-	x = (pos_data[0] << 4) | (pos_data[2] & 0x0F);
-	y = (pos_data[1] << 4) | (pos_data[2] >> 4);
-
-	if (axis_align->swap_axes)
-		swap(x, y);
-
-	if (axis_align->flip_x)
-		x = max(sensor->max_x - x, 0);
-
-	if (axis_align->flip_y)
-		y = max(sensor->max_y - y, 0);
-
-	/*
-	 * Here checking if X offset or y offset are specified is
-	 * redundant. We just add the offsets or clip the values.
-	 *
-	 * Note: offsets need to be applied before clipping occurs,
-	 * or we could get funny values that are outside of
-	 * clipping boundaries.
-	 */
-	x += axis_align->offset_x;
-	y += axis_align->offset_y;
-	x =  max(axis_align->clip_x_low, x);
-	y =  max(axis_align->clip_y_low, y);
-	if (axis_align->clip_x_high)
-		x = min(axis_align->clip_x_high, x);
-	if (axis_align->clip_y_high)
-		y =  min(axis_align->clip_y_high, y);
-
-	sensor->tracking_pos[n_finger].x = x;
-	sensor->tracking_pos[n_finger].y = y;
+	rmi_2d_sensor_rel_report(sensor, x, y);
 }
 
-static void rmi_f11_abs_pos_report(struct f11_data *f11,
-				   struct f11_2d_sensor *sensor,
+static void rmi_f11_abs_pos_process(struct f11_data *f11,
+				   struct rmi_2d_sensor *sensor,
+				   struct rmi_2d_sensor_abs_object *obj,
 				   enum f11_finger_state finger_state,
 				   u8 n_finger)
 {
-	struct f11_2d_data *data = &sensor->data;
-	struct input_dev *input = sensor->input;
-	struct rmi_f11_2d_axis_alignment *axis_align = &sensor->axis_align;
+	struct f11_2d_data *data = &f11->data;
 	u8 *pos_data = &data->abs_pos[n_finger * RMI_F11_ABS_BYTES];
-	u16 x, y, z;
-	int w_x, w_y, w_max, w_min, orient;
-	int tool_type = rmi_f11_get_tool_type(sensor, finger_state);
-
-	if (sensor->kernel_tracking)
-		input_mt_slot(input, sensor->tracking_slots[n_finger]);
-	else
-		input_mt_slot(input, n_finger);
-	input_mt_report_slot_state(input, tool_type,
-				   finger_state != F11_NO_FINGER);
-
-	if (finger_state) {
-		x = sensor->tracking_pos[n_finger].x;
-		y = sensor->tracking_pos[n_finger].y;
-
-		w_x = pos_data[3] & 0x0f;
-		w_y = pos_data[3] >> 4;
-
-		if (axis_align->swap_axes)
-			swap(w_x, w_y);
-
-		orient = w_x > w_y ? 1 : 0;
-
-		w_max = max(w_x, w_y);
-		w_min = min(w_x, w_y);
-
-		/*
-		 * Some UIs ignore W of zero, so we fudge it to 1 for pens.  This
-		 * only appears to be an issue when reporting pens, not plain old
-		 * fingers.
-		 */
-		if (tool_type == MT_TOOL_PEN) {
-			w_max = max(1, w_max);
-			w_min = max(1, w_min);
-		}
-
-		z = pos_data[4];
+	int tool_type = rmi_f11_get_tool_type(f11, finger_state);
+
+	switch (finger_state) {
+	case F11_PEN:
+		if (IS_ENABLED(CONFIG_RMI4_F11_PEN) &&
+		    f11->sens_query.has_pen)
+			obj->type = RMI_2D_OBJECT_STYLUS;
+		break;
+	case F11_PRESENT:
+		obj->type = RMI_2D_OBJECT_FINGER;
+		break;
+	default:
+		obj->type = RMI_2D_OBJECT_NONE;
+	}
 
-		input_report_abs(input, ABS_MT_PRESSURE, z);
-		input_report_abs(input, ABS_MT_TOUCH_MAJOR, w_max);
-		input_report_abs(input, ABS_MT_TOUCH_MINOR, w_min);
-		input_report_abs(input, ABS_MT_ORIENTATION, orient);
-		input_report_abs(input, ABS_MT_POSITION_X, x);
-		input_report_abs(input, ABS_MT_POSITION_Y, y);
+	obj->mt_tool = tool_type;
+	obj->x = (pos_data[0] << 4) | (pos_data[2] & 0x0F);
+	obj->y = (pos_data[1] << 4) | (pos_data[2] >> 4);
+	obj->z = pos_data[4];
+	obj->wx = pos_data[3] & 0x0f;
+	obj->wy = pos_data[3] >> 4;
 
-		dev_dbg(&sensor->fn->dev,
-			"finger[%d]:%d - x:%d y:%d z:%d w_max:%d w_min:%d\n",
-			n_finger, finger_state, x, y, z, w_max, w_min);
-	}
+	rmi_2d_sensor_abs_process(sensor, obj, n_finger);
 }
 
 static inline u8 rmi_f11_parse_finger_state(const u8 *f_state, u8 n_finger)
@@ -721,10 +589,10 @@ static inline u8 rmi_f11_parse_finger_state(const u8 *f_state, u8 n_finger)
 }
 
 static void rmi_f11_finger_handler(struct f11_data *f11,
-				   struct f11_2d_sensor *sensor,
+				   struct rmi_2d_sensor *sensor,
 				   unsigned long *irq_bits, int num_irq_regs)
 {
-	const u8 *f_state = sensor->data.f_state;
+	const u8 *f_state = f11->data.f_state;
 	u8 finger_state;
 	u8 i;
 
@@ -742,10 +610,11 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 		}
 
 		if (abs_bits)
-			rmi_f11_abs_parse_xy(f11, sensor, finger_state, i);
+			rmi_f11_abs_pos_process(f11, sensor, &sensor->objs[i],
+							finger_state, i);
 
 		if (rel_bits)
-			rmi_f11_rel_pos_report(sensor, i);
+			rmi_f11_rel_pos_report(f11, i);
 	}
 
 	if (abs_bits) {
@@ -766,7 +635,7 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 				/* no need to send twice the error */
 				continue;
 
-			rmi_f11_abs_pos_report(f11, sensor, finger_state, i);
+			rmi_2d_sensor_abs_report(sensor, &sensor->objs[i], i);
 		}
 
 		input_mt_sync_frame(sensor->input);
@@ -776,10 +645,11 @@ static void rmi_f11_finger_handler(struct f11_data *f11,
 		input_sync(sensor->input);
 }
 
-static int f11_2d_construct_data(struct f11_2d_sensor *sensor)
+static int f11_2d_construct_data(struct f11_data *f11)
 {
-	struct f11_2d_sensor_queries *query = &sensor->sens_query;
-	struct f11_2d_data *data = &sensor->data;
+	struct rmi_2d_sensor *sensor = &f11->sensor;
+	struct f11_2d_sensor_queries *query = &f11->sens_query;
+	struct f11_2d_data *data = &f11->data;
 	int i;
 
 	sensor->nbr_fingers = (query->nr_fingers == 5 ? 10 :
@@ -1151,102 +1021,6 @@ static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
 	return query_size;
 }
 
-/* This operation is done in a number of places, so we have a handy routine
- * for it.
- */
-static void f11_set_abs_params(struct rmi_function *fn, struct f11_data *f11)
-{
-	struct f11_2d_sensor *sensor = &f11->sensor;
-	struct input_dev *input = sensor->input;
-	/* These two lines are not doing what we want them to.  So we use
-	 * some shifts instead.
-	int device_x_max = le16_to_cpu(*(f11->dev_controls.ctrl0_9 + 6));
-	int device_y_max = le16_to_cpu(*(f11->dev_controls.ctrl0_9 + 8));
-	 */
-	u16 device_x_max = f11->dev_controls.ctrl0_9[6] |
-			((f11->dev_controls.ctrl0_9[7] & 0x0F) << 8);
-	u16 device_y_max = f11->dev_controls.ctrl0_9[8] |
-			((f11->dev_controls.ctrl0_9[9] & 0x0F) << 8);
-	u16 x_min, x_max, y_min, y_max;
-	unsigned int input_flags;
-	int res_x, res_y;
-
-	/* We assume touchscreen unless demonstrably a touchpad or specified
-	 * as a touchpad in the platform data
-	 */
-	if (sensor->sensor_type == rmi_f11_sensor_touchpad)
-		input_flags = INPUT_MT_POINTER;
-	else
-		input_flags = INPUT_MT_DIRECT;
-
-	if (sensor->kernel_tracking)
-		input_flags |= INPUT_MT_TRACK;
-
-	if (sensor->axis_align.swap_axes) {
-		int temp = device_x_max;
-		device_x_max = device_y_max;
-		device_y_max = temp;
-	}
-	/* Use the max X and max Y read from the device, or the clip values,
-	 * whichever is stricter.
-	 */
-	x_min = sensor->axis_align.clip_x_low;
-	if (sensor->axis_align.clip_x_high)
-		x_max = min(device_x_max,
-			sensor->axis_align.clip_x_high);
-	else
-		x_max = device_x_max;
-
-	y_min = sensor->axis_align.clip_y_low;
-	if (sensor->axis_align.clip_y_high)
-		y_max = min(device_y_max,
-			sensor->axis_align.clip_y_high);
-	else
-		y_max = device_y_max;
-
-	dev_dbg(&fn->dev, "Set ranges X=[%d..%d] Y=[%d..%d].",
-			x_min, x_max, y_min, y_max);
-
-	input_set_abs_params(input, ABS_MT_PRESSURE, 0,
-			DEFAULT_MAX_ABS_MT_PRESSURE, 0, 0);
-	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR,
-			0, DEFAULT_MAX_ABS_MT_TOUCH, 0, 0);
-	input_set_abs_params(input, ABS_MT_TOUCH_MINOR,
-			0, DEFAULT_MAX_ABS_MT_TOUCH, 0, 0);
-	input_set_abs_params(input, ABS_MT_ORIENTATION,
-			0, DEFAULT_MAX_ABS_MT_ORIENTATION, 0, 0);
-	input_set_abs_params(input, ABS_MT_TRACKING_ID,
-			DEFAULT_MIN_ABS_MT_TRACKING_ID,
-			DEFAULT_MAX_ABS_MT_TRACKING_ID, 0, 0);
-	/* TODO get max_x_pos (and y) from control registers. */
-	input_set_abs_params(input, ABS_MT_POSITION_X,
-			x_min, x_max, 0, 0);
-	input_set_abs_params(input, ABS_MT_POSITION_Y,
-			y_min, y_max, 0, 0);
-
-	if (sensor->x_mm && sensor->y_mm) {
-		res_x = (x_max - x_min) / sensor->x_mm;
-		res_y = (y_max - y_min) / sensor->y_mm;
-
-		input_abs_set_res(input, ABS_X, res_x);
-		input_abs_set_res(input, ABS_Y, res_y);
-
-		input_abs_set_res(input, ABS_MT_POSITION_X, res_x);
-		input_abs_set_res(input, ABS_MT_POSITION_Y, res_y);
-
-		if (!sensor->dmax)
-			sensor->dmax = DMAX * res_x;
-	}
-
-	input_mt_init_slots(input, sensor->nbr_fingers, input_flags);
-	if (IS_ENABLED(CONFIG_RMI4_F11_PEN) && sensor->sens_query.has_pen)
-		input_set_abs_params(input, ABS_MT_TOOL_TYPE,
-				     0, MT_TOOL_MAX, 0, 0);
-	else
-		input_set_abs_params(input, ABS_MT_TOOL_TYPE,
-				     0, MT_TOOL_FINGER, 0, 0);
-}
-
 static int rmi_f11_initialize(struct rmi_function *fn)
 {
 	struct rmi_device *rmi_dev = fn->rmi_dev;
@@ -1255,11 +1029,11 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	u8 query_offset;
 	u16 query_base_addr;
 	u16 control_base_addr;
-	u16 max_x_pos, max_y_pos, temp;
+	u16 max_x_pos, max_y_pos;
 	int rc;
 	const struct rmi_device_platform_data *pdata = rmi_get_platform_data(rmi_dev);
 	struct rmi_driver_data *drvdata = dev_get_drvdata(&rmi_dev->dev);
-	struct f11_2d_sensor *sensor;
+	struct rmi_2d_sensor *sensor;
 	u8 buf;
 	int mask_size;
 
@@ -1276,7 +1050,15 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	if (!f11)
 		return -ENOMEM;
 
-	f11->rezero_wait_ms = pdata->f11_rezero_wait;
+	if (fn->dev.of_node) {
+		rc = rmi_2d_sensor_of_probe(&fn->dev, &f11->sensor_pdata);
+		if (rc)
+			return rc;
+	} else if (pdata->sensor_pdata) {
+		f11->sensor_pdata = *pdata->sensor_pdata;
+	}
+
+	f11->rezero_wait_ms = f11->sensor_pdata.rezero_wait;
 
 	f11->abs_mask = (unsigned long *)((char *)f11
 			+ sizeof(struct f11_data));
@@ -1306,7 +1088,7 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	sensor->fn = fn;
 
 	rc = rmi_f11_get_query_parameters(rmi_dev, f11,
-			&sensor->sens_query, query_offset);
+			&f11->sens_query, query_offset);
 	if (rc < 0)
 		return rc;
 	query_offset += rc;
@@ -1319,46 +1101,44 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 		return rc;
 	}
 
-	if (sensor->sens_query.has_info2) {
-		if (sensor->sens_query.is_clear)
-			sensor->sensor_type = rmi_f11_sensor_touchscreen;
+	if (f11->sens_query.has_info2) {
+		if (f11->sens_query.is_clear)
+			f11->sensor.sensor_type = rmi_sensor_touchscreen;
 		else
-			sensor->sensor_type = rmi_f11_sensor_touchpad;
+			f11->sensor.sensor_type = rmi_sensor_touchpad;
 	}
 
-	sensor->report_abs = sensor->sens_query.has_abs;
-
-	if (pdata->f11_sensor_data) {
-		sensor->axis_align =
-			pdata->f11_sensor_data->axis_align;
-		sensor->topbuttonpad = pdata->f11_sensor_data->topbuttonpad;
-		sensor->kernel_tracking =
-			pdata->f11_sensor_data->kernel_tracking;
-		sensor->dmax = pdata->f11_sensor_data->dmax;
-
-		if (sensor->sens_query.has_physical_props) {
-			sensor->x_mm = sensor->sens_query.x_sensor_size_mm;
-			sensor->y_mm = sensor->sens_query.y_sensor_size_mm;
-		} else if (pdata->f11_sensor_data) {
-			sensor->x_mm = pdata->f11_sensor_data->x_mm;
-			sensor->y_mm = pdata->f11_sensor_data->y_mm;
-		}
+	sensor->report_abs = f11->sens_query.has_abs;
 
-		if (sensor->sensor_type == rmi_f11_sensor_default)
-			sensor->sensor_type =
-				pdata->f11_sensor_data->sensor_type;
+	sensor->axis_align =
+		f11->sensor_pdata.axis_align;
 
-		sensor->report_abs = sensor->report_abs
-			&& !(pdata->f11_sensor_data->disable_report_mask
-				& RMI_F11_DISABLE_ABS_REPORT);
+	sensor->topbuttonpad = f11->sensor_pdata.topbuttonpad;
+	sensor->kernel_tracking = f11->sensor_pdata.kernel_tracking;
+	sensor->dmax = f11->sensor_pdata.dmax;
+
+	if (f11->sens_query.has_physical_props) {
+		sensor->x_mm = f11->sens_query.x_sensor_size_mm;
+		sensor->y_mm = f11->sens_query.y_sensor_size_mm;
+	} else {
+		sensor->x_mm = f11->sensor_pdata.x_mm;
+		sensor->y_mm = f11->sensor_pdata.y_mm;
 	}
 
+	if (sensor->sensor_type == rmi_sensor_default)
+		sensor->sensor_type =
+			f11->sensor_pdata.sensor_type;
+
+	sensor->report_abs = sensor->report_abs
+		&& !(f11->sensor_pdata.disable_report_mask
+			& RMI_F11_DISABLE_ABS_REPORT);
+
 	if (!sensor->report_abs)
 		/*
 		 * If device doesn't have abs or if it has been disables
 		 * fallback to reporting rel data.
 		 */
-		sensor->report_rel = sensor->sens_query.has_rel;
+		sensor->report_rel = f11->sens_query.has_rel;
 
 	rc = rmi_read_block(rmi_dev,
 		control_base_addr + F11_CTRL_SENSOR_MAX_X_POS_OFFSET,
@@ -1372,15 +1152,13 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	if (rc < 0)
 		return rc;
 
-	if (sensor->axis_align.swap_axes) {
-		temp = max_x_pos;
-		max_x_pos = max_y_pos;
-		max_y_pos = temp;
-	}
+	if (sensor->axis_align.swap_axes)
+		swap(max_x_pos, max_y_pos);
+
 	sensor->max_x = max_x_pos;
 	sensor->max_y = max_y_pos;
 
-	rc = f11_2d_construct_data(sensor);
+	rc = f11_2d_construct_data(f11);
 	if (rc < 0)
 		return rc;
 
@@ -1390,7 +1168,10 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 			GFP_KERNEL);
 	sensor->tracking_slots = devm_kzalloc(&fn->dev,
 			sizeof(int) * sensor->nbr_fingers, GFP_KERNEL);
-	if (!sensor->tracking_pos || !sensor->tracking_slots)
+	sensor->objs = devm_kzalloc(&fn->dev,
+			sizeof(struct rmi_2d_sensor_abs_object)
+			* sensor->nbr_fingers, GFP_KERNEL);
+	if (!sensor->tracking_pos || !sensor->tracking_slots || !sensor->objs)
 		return -ENOMEM;
 
 	ctrl = &f11->dev_controls;
@@ -1423,84 +1204,11 @@ static int rmi_f11_initialize(struct rmi_function *fn)
 	return 0;
 }
 
-static int rmi_f11_register_devices(struct rmi_function *fn)
-{
-	struct rmi_device *rmi_dev = fn->rmi_dev;
-	struct rmi_driver_data *drv_data = dev_get_drvdata(&rmi_dev->dev);
-	struct f11_data *f11 = dev_get_drvdata(&fn->dev);
-	struct input_dev *input_dev;
-	struct rmi_driver *driver = rmi_dev->driver;
-	struct f11_2d_sensor *sensor = &f11->sensor;
-	int rc;
-
-	if (!drv_data->input) {
-		input_dev = input_allocate_device();
-	} else {
-		input_dev = drv_data->input;
-		sensor->unified_input = true;
-	}
-	if (!input_dev) {
-		rc = -ENOMEM;
-		goto error_unregister;
-	}
-
-	sensor->input = input_dev;
-
-	if (!sensor->unified_input) {
-		if (driver->set_input_params) {
-			rc = driver->set_input_params(rmi_dev, input_dev);
-			if (rc < 0) {
-				dev_err(&fn->dev,
-					"%s: Error in setting input device.\n",
-					__func__);
-				goto error_unregister;
-			}
-		}
-		sprintf(sensor->input_phys, "%s.abs/input0",
-			dev_name(&fn->dev));
-		input_dev->phys = sensor->input_phys;
-		input_dev->dev.parent = &rmi_dev->dev;
-	}
-
-	set_bit(EV_ABS, input_dev->evbit);
-	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
-
-	if (sensor->report_abs)
-		f11_set_abs_params(fn, f11);
-
-	if (sensor->topbuttonpad)
-		set_bit(INPUT_PROP_TOPBUTTONPAD, input_dev->propbit);
-
-	if (sensor->report_rel) {
-		set_bit(EV_REL, input_dev->evbit);
-		set_bit(REL_X, input_dev->relbit);
-		set_bit(REL_Y, input_dev->relbit);
-	}
-	if (!sensor->unified_input) {
-		rc = input_register_device(input_dev);
-		if (rc) {
-			input_free_device(input_dev);
-			sensor->input = NULL;
-			goto error_unregister;
-		}
-	}
-
-	return 0;
-
-error_unregister:
-	if (!sensor->unified_input && sensor->input) {
-		input_unregister_device(sensor->input);
-		sensor->input = NULL;
-	}
-
-	return rc;
-}
-
 static int rmi_f11_config(struct rmi_function *fn)
 {
 	struct f11_data *f11 = dev_get_drvdata(&fn->dev);
 	struct rmi_driver *drv = fn->rmi_dev->driver;
-	struct f11_2d_sensor *sensor = &f11->sensor;
+	struct rmi_2d_sensor *sensor = &f11->sensor;
 	int rc;
 
 	if (!sensor->report_abs)
@@ -1513,7 +1221,7 @@ static int rmi_f11_config(struct rmi_function *fn)
 	else
 		drv->set_irq_bits(fn->rmi_dev, f11->rel_mask);
 
-	rc = f11_write_control_regs(fn, &f11->sensor.sens_query,
+	rc = f11_write_control_regs(fn, &f11->sens_query,
 			   &f11->dev_controls, fn->fd.query_base_addr);
 	if (rc < 0)
 		return rc;
@@ -1574,12 +1282,15 @@ static SIMPLE_DEV_PM_OPS(rmi_f11_pm_ops, NULL, rmi_f11_resume);
 static int rmi_f11_probe(struct rmi_function *fn)
 {
 	int error;
+	struct f11_data *f11;
+
 
 	error = rmi_f11_initialize(fn);
 	if (error)
 		return error;
 
-	error = rmi_f11_register_devices(fn);
+	f11 = dev_get_drvdata(&fn->dev);
+	error = rmi_2d_sensor_configure_input(fn, &f11->sensor);
 	if (error)
 		return error;
 
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index c781d09..0092787 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -32,7 +32,7 @@ enum rmi_attn_polarity {
 };
 
 /**
- * struct rmi_f11_axis_alignment - target axis alignment
+ * struct rmi_2d_axis_alignment - target axis alignment
  * @swap_axes: set to TRUE if desired to swap x- and y-axis
  * @flip_x: set to TRUE if desired to flip direction on x-axis
  * @flip_y: set to TRUE if desired to flip direction on y-axis
@@ -49,10 +49,10 @@ enum rmi_attn_polarity {
  * @rel_report_enabled - if set to true, the relative reporting will be
  *               automatically enabled for this sensor.
  */
-struct rmi_f11_2d_axis_alignment {
-	u32 swap_axes;	/* boolean, but u32 is needed by debugfs API */
-	u32 flip_x;	/* boolean */
-	u32 flip_y;	/* boolean */
+struct rmi_2d_axis_alignment {
+	bool swap_axes;
+	bool flip_x;
+	bool flip_y;
 	u16 clip_x_low;
 	u16 clip_y_low;
 	u16 clip_x_high;
@@ -73,16 +73,16 @@ struct rmi_f11_2d_axis_alignment {
  * @rmi_f11_sensor_touchpad - thread the sensor as a touchpad (indirect
  * pointing).
  */
-enum rmi_f11_sensor_type {
-	rmi_f11_sensor_default = 0,
-	rmi_f11_sensor_touchscreen,
-	rmi_f11_sensor_touchpad
+enum rmi_sensor_type {
+	rmi_sensor_default = 0,
+	rmi_sensor_touchscreen,
+	rmi_sensor_touchpad
 };
 
 #define RMI_F11_DISABLE_ABS_REPORT      BIT(0)
 
 /**
- * struct rmi_f11_sensor_data - overrides defaults for a single F11 2D sensor.
+ * struct rmi_2d_sensor_data - overrides defaults for a 2D sensor.
  * @axis_align - provides axis alignment overrides (see above).
  * @sensor_type - Forces the driver to treat the sensor as an indirect
  * pointing device (touchpad) rather than a direct pointing device
@@ -101,12 +101,13 @@ enum rmi_f11_sensor_type {
  * @dmax - the maximum distance (in sensor units) the kernel tracking allows two
  * distincts fingers to be considered the same.
  */
-struct rmi_f11_sensor_data {
-	struct rmi_f11_2d_axis_alignment axis_align;
-	enum rmi_f11_sensor_type sensor_type;
+struct rmi_2d_sensor_platform_data {
+	struct rmi_2d_axis_alignment axis_align;
+	enum rmi_sensor_type sensor_type;
 	int x_mm;
 	int y_mm;
 	int disable_report_mask;
+	u16 rezero_wait;
 	bool topbuttonpad;
 	bool kernel_tracking;
 	int dmax;
@@ -268,8 +269,7 @@ struct rmi_device_platform_data {
 	struct rmi_device_platform_data_spi spi_data;
 
 	/* function handler pdata */
-	struct rmi_f11_sensor_data *f11_sensor_data;
-	u16 f11_rezero_wait;
+	struct rmi_2d_sensor_platform_data *sensor_pdata;
 	struct rmi_f01_power_management power_management;
 	struct rmi_button_map *f19_button_map;
 	struct rmi_button_map *f1a_button_map;
-- 
2.1.4
