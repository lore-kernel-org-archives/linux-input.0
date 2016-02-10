From: Andrew Duggan <aduggan@synaptics.com>
Subject: [PATCH v4 04/10] Input: synaptics-rmi4: Add support for 2D sensors and F11
Date: Tue, 9 Feb 2016 17:41:16 -0800
Message-ID: <1455068476-12063-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Duggan <aduggan@synaptics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Christopher Heiny <cheiny@synaptics.com>, Stephen Chandler Paul <cpaul@redhat.com>, Vincent Huang <vincent.huang@tw.synaptics.com>, Chris Healy <cphealy@gmail.com>, Andrey Gusakov <andrey.gusakov@cogentembedded.com>
List-Id: linux-input@vger.kernel.org

RMI4 currently defines two functions for reporting data for 2D sensors
(F11 and F12). This patch adds the common functionality which is shared
by devices with 2D reporting along with implementing functionality for
=4611.

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Christopher Heiny <cheiny@synaptics.com>
---
 drivers/input/rmi4/Kconfig         |   15 +
 drivers/input/rmi4/Makefile        |    5 +
 drivers/input/rmi4/rmi_2d_sensor.c |  221 ++++++
 drivers/input/rmi4/rmi_2d_sensor.h |   84 +++
 drivers/input/rmi4/rmi_bus.c       |    3 +
 drivers/input/rmi4/rmi_driver.h    |    2 +-
 drivers/input/rmi4/rmi_f11.c       | 1312 ++++++++++++++++++++++++++++=
++++++++
 include/linux/rmi.h                |   83 +++
 8 files changed, 1724 insertions(+), 1 deletion(-)
 create mode 100644 drivers/input/rmi4/rmi_2d_sensor.c
 create mode 100644 drivers/input/rmi4/rmi_2d_sensor.h
 create mode 100644 drivers/input/rmi4/rmi_f11.c

diff --git a/drivers/input/rmi4/Kconfig b/drivers/input/rmi4/Kconfig
index cc3f7c5..dc7de6b 100644
--- a/drivers/input/rmi4/Kconfig
+++ b/drivers/input/rmi4/Kconfig
@@ -17,3 +17,18 @@ config RMI4_I2C
 	  bus.
=20
 	  If unsure, say Y.
+
+config RMI4_2D_SENSOR
+	bool
+	depends on RMI4_CORE
+
+config RMI4_F11
+	bool "RMI4 Function 11 (2D pointing)"
+	select RMI4_2D_SENSOR
+	depends on RMI4_CORE
+	help
+	  Say Y here if you want to add support for RMI4 function 11.
+
+	  Function 11 provides 2D multifinger pointing for touchscreens and
+	  touchpads. For sensors that support relative pointing, F11 also
+	  provides mouse input.
diff --git a/drivers/input/rmi4/Makefile b/drivers/input/rmi4/Makefile
index 5539494..9e7424a 100644
--- a/drivers/input/rmi4/Makefile
+++ b/drivers/input/rmi4/Makefile
@@ -1,5 +1,10 @@
 obj-$(CONFIG_RMI4_CORE) +=3D rmi_core.o
 rmi_core-y :=3D rmi_bus.o rmi_driver.o rmi_f01.o
=20
+rmi_core-$(CONFIG_RMI4_2D_SENSOR) +=3D rmi_2d_sensor.o
+
+# Function drivers
+rmi_core-$(CONFIG_RMI4_F11) +=3D rmi_f11.o
+
 # Transports
 obj-$(CONFIG_RMI4_I2C) +=3D rmi_i2c.o
diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rm=
i_2d_sensor.c
new file mode 100644
index 0000000..8f48647
--- /dev/null
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -0,0 +1,221 @@
+/*
+ * Copyright (c) 2011-2016 Synaptics Incorporated
+ * Copyright (c) 2011 Unixphere
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished by
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
+	struct rmi_2d_axis_alignment *axis_align =3D &sensor->axis_align;
+
+	/* we keep the previous values if the finger is released */
+	if (obj->type =3D=3D RMI_2D_OBJECT_NONE)
+		return;
+
+	if (axis_align->swap_axes)
+		swap(obj->x, obj->y);
+
+	if (axis_align->flip_x)
+		obj->x =3D sensor->max_x - obj->x;
+
+	if (axis_align->flip_y)
+		obj->y =3D sensor->max_y - obj->y;
+
+	/*
+	 * Here checking if X offset or y offset are specified is
+	 * redundant. We just add the offsets or clip the values.
+	 *
+	 * Note: offsets need to be applied before clipping occurs,
+	 * or we could get funny values that are outside of
+	 * clipping boundaries.
+	 */
+	obj->x +=3D axis_align->offset_x;
+	obj->y +=3D axis_align->offset_y;
+
+	obj->x =3D  max(axis_align->clip_x_low, obj->x);
+	obj->y =3D  max(axis_align->clip_y_low, obj->y);
+
+	if (axis_align->clip_x_high)
+		obj->x =3D min(sensor->max_x, obj->x);
+
+	if (axis_align->clip_y_high)
+		obj->y =3D  min(sensor->max_y, obj->y);
+
+	sensor->tracking_pos[slot].x =3D obj->x;
+	sensor->tracking_pos[slot].y =3D obj->y;
+}
+EXPORT_SYMBOL_GPL(rmi_2d_sensor_abs_process);
+
+void rmi_2d_sensor_abs_report(struct rmi_2d_sensor *sensor,
+				struct rmi_2d_sensor_abs_object *obj,
+				int slot)
+{
+	struct rmi_2d_axis_alignment *axis_align =3D &sensor->axis_align;
+	struct input_dev *input =3D sensor->input;
+	int wide, major, minor;
+
+	if (sensor->kernel_tracking)
+		input_mt_slot(input, sensor->tracking_slots[slot]);
+	else
+		input_mt_slot(input, slot);
+
+	input_mt_report_slot_state(input, obj->mt_tool,
+				   obj->type !=3D RMI_2D_OBJECT_NONE);
+
+	if (obj->type !=3D RMI_2D_OBJECT_NONE) {
+		obj->x =3D sensor->tracking_pos[slot].x;
+		obj->y =3D sensor->tracking_pos[slot].y;
+
+		if (axis_align->swap_axes)
+			swap(obj->wx, obj->wy);
+
+		wide =3D (obj->wx > obj->wy);
+		major =3D max(obj->wx, obj->wy);
+		minor =3D min(obj->wx, obj->wy);
+
+		if (obj->type =3D=3D RMI_2D_OBJECT_STYLUS) {
+			major =3D max(1, major);
+			minor =3D max(1, minor);
+		}
+
+		input_event(sensor->input, EV_ABS, ABS_MT_POSITION_X, obj->x);
+		input_event(sensor->input, EV_ABS, ABS_MT_POSITION_Y, obj->y);
+		input_event(sensor->input, EV_ABS, ABS_MT_ORIENTATION, wide);
+		input_event(sensor->input, EV_ABS, ABS_MT_PRESSURE, obj->z);
+		input_event(sensor->input, EV_ABS, ABS_MT_TOUCH_MAJOR, major);
+		input_event(sensor->input, EV_ABS, ABS_MT_TOUCH_MINOR, minor);
+
+		rmi_dbg(RMI_DEBUG_2D_SENSOR, &sensor->input->dev,
+			"%s: obj[%d]: type: 0x%02x X: %d Y: %d Z: %d WX: %d WY: %d\n",
+			__func__, slot, obj->type, obj->x, obj->y, obj->z,
+			obj->wx, obj->wy);
+	}
+}
+EXPORT_SYMBOL_GPL(rmi_2d_sensor_abs_report);
+
+void rmi_2d_sensor_rel_report(struct rmi_2d_sensor *sensor, int x, int=
 y)
+{
+	struct rmi_2d_axis_alignment *axis_align =3D &sensor->axis_align;
+
+	x =3D min(RMI_2D_REL_POS_MAX, max(RMI_2D_REL_POS_MIN, (int)x));
+	y =3D min(RMI_2D_REL_POS_MAX, max(RMI_2D_REL_POS_MIN, (int)y));
+
+	if (axis_align->swap_axes)
+		swap(x, y);
+
+	if (axis_align->flip_x)
+		x =3D min(RMI_2D_REL_POS_MAX, -x);
+
+	if (axis_align->flip_y)
+		y =3D min(RMI_2D_REL_POS_MAX, -y);
+
+	if (x || y) {
+		input_report_rel(sensor->input, REL_X, x);
+		input_report_rel(sensor->input, REL_Y, y);
+	}
+}
+EXPORT_SYMBOL_GPL(rmi_2d_sensor_rel_report);
+
+static void rmi_2d_sensor_set_input_params(struct rmi_2d_sensor *senso=
r)
+{
+	struct input_dev *input =3D sensor->input;
+	int res_x;
+	int res_y;
+	int input_flags =3D 0;
+
+	if (sensor->report_abs) {
+		if (sensor->axis_align.swap_axes)
+			swap(sensor->max_x, sensor->max_y);
+
+		sensor->min_x =3D sensor->axis_align.clip_x_low;
+		if (sensor->axis_align.clip_x_high)
+			sensor->max_x =3D min(sensor->max_x,
+				sensor->axis_align.clip_x_high);
+
+		sensor->min_y =3D sensor->axis_align.clip_y_low;
+		if (sensor->axis_align.clip_y_high)
+			sensor->max_y =3D min(sensor->max_y,
+				sensor->axis_align.clip_y_high);
+
+		set_bit(EV_ABS, input->evbit);
+		input_set_abs_params(input, ABS_MT_POSITION_X, 0, sensor->max_x,
+					0, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, sensor->max_y,
+					0, 0);
+
+		if (sensor->x_mm && sensor->y_mm) {
+			res_x =3D (sensor->max_x - sensor->min_x) / sensor->x_mm;
+			res_y =3D (sensor->max_y - sensor->min_y) / sensor->y_mm;
+
+			input_abs_set_res(input, ABS_X, res_x);
+			input_abs_set_res(input, ABS_Y, res_y);
+
+			input_abs_set_res(input, ABS_MT_POSITION_X, res_x);
+			input_abs_set_res(input, ABS_MT_POSITION_Y, res_y);
+
+			if (!sensor->dmax)
+				sensor->dmax =3D DMAX * res_x;
+		}
+
+		input_set_abs_params(input, ABS_MT_PRESSURE, 0,	0xff, 0, 0);
+		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR,	0, 0x0f, 0, 0);
+		input_set_abs_params(input, ABS_MT_TOUCH_MINOR,	0, 0x0f, 0, 0);
+		input_set_abs_params(input, ABS_MT_ORIENTATION,	0, 1, 0, 0);
+
+		if (sensor->sensor_type =3D=3D rmi_sensor_touchpad)
+			input_flags =3D INPUT_MT_POINTER;
+		else
+			input_flags =3D INPUT_MT_DIRECT;
+
+		if (sensor->kernel_tracking)
+			input_flags |=3D INPUT_MT_TRACK;
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
+	struct rmi_device *rmi_dev =3D fn->rmi_dev;
+	struct rmi_driver_data *drv_data =3D dev_get_drvdata(&rmi_dev->dev);
+
+	if (!drv_data->input)
+		return -ENODEV;
+
+	sensor->input =3D drv_data->input;
+	rmi_2d_sensor_set_input_params(sensor);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rmi_2d_sensor_configure_input);
diff --git a/drivers/input/rmi4/rmi_2d_sensor.h b/drivers/input/rmi4/rm=
i_2d_sensor.h
new file mode 100644
index 0000000..6a715d3
--- /dev/null
+++ b/drivers/input/rmi4/rmi_2d_sensor.h
@@ -0,0 +1,84 @@
+/*
+ * Copyright (c) 2011-2016 Synaptics Incorporated
+ * Copyright (c) 2011 Unixphere
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished by
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
+ * @axis_align - controls parameters that are useful in system prototy=
ping
+ * and bring up.
+ * @max_x - The maximum X coordinate that will be reported by this sen=
sor.
+ * @max_y - The maximum Y coordinate that will be reported by this sen=
sor.
+ * @nbr_fingers - How many fingers can this sensor report?
+ * @data_pkt - buffer for data reported by this sensor.
+ * @pkt_size - number of bytes in that buffer.
+ * @attn_size - Size of the HID attention report (only contains abs da=
ta).
+ * position when two fingers are on the device.  When this is true, we
+ * assume we have one of those sensors and report events appropriately=
=2E
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
+	int attn_size;
+	bool topbuttonpad;
+	enum rmi_sensor_type sensor_type;
+	struct input_dev *input;
+	struct rmi_function *fn;
+	char input_phys[32];
+	u8 report_abs;
+	u8 report_rel;
+	u8 x_mm;
+	u8 y_mm;
+};
+
+void rmi_2d_sensor_abs_process(struct rmi_2d_sensor *sensor,
+				struct rmi_2d_sensor_abs_object *obj,
+				int slot);
+
+void rmi_2d_sensor_abs_report(struct rmi_2d_sensor *sensor,
+				struct rmi_2d_sensor_abs_object *obj,
+				int slot);
+
+void rmi_2d_sensor_rel_report(struct rmi_2d_sensor *sensor, int x, int=
 y);
+
+int rmi_2d_sensor_configure_input(struct rmi_function *fn,
+					struct rmi_2d_sensor *sensor);
+#endif /* _RMI_2D_SENSOR_H */
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.=
c
index 7f3f8e1..19e6c4e 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -306,6 +306,9 @@ struct bus_type rmi_bus_type =3D {
=20
 static struct rmi_function_handler *fn_handlers[] =3D {
 	&rmi_f01_handler,
+#ifdef CONFIG_RMI4_F11
+	&rmi_f11_handler,
+#endif
 };
=20
 #define RMI_FN_HANDLER_ARRAY_SIZE \
diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_d=
river.h
index 3ab3f1a..09d2aa7 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -99,5 +99,5 @@ void rmi_unregister_physical_driver(void);
 char *rmi_f01_get_product_ID(struct rmi_function *fn);
=20
 extern struct rmi_function_handler rmi_f01_handler;
-
+extern struct rmi_function_handler rmi_f11_handler;
 #endif
diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.=
c
new file mode 100644
index 0000000..948a360b
--- /dev/null
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -0,0 +1,1312 @@
+/*
+ * Copyright (c) 2011-2015 Synaptics Incorporated
+ * Copyright (c) 2011 Unixphere
+ *
+ * This program is free software; you can redistribute it and/or modif=
y it
+ * under the terms of the GNU General Public License version 2 as publ=
ished by
+ * the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/kconfig.h>
+#include <linux/rmi.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include "rmi_driver.h"
+#include "rmi_2d_sensor.h"
+
+#define F11_MAX_NUM_OF_FINGERS		10
+#define F11_MAX_NUM_OF_TOUCH_SHAPES	16
+
+#define FINGER_STATE_MASK	0x03
+
+#define F11_CTRL_SENSOR_MAX_X_POS_OFFSET	6
+#define F11_CTRL_SENSOR_MAX_Y_POS_OFFSET	8
+
+#define DEFAULT_XY_MAX 9999
+#define DEFAULT_MAX_ABS_MT_PRESSURE 255
+#define DEFAULT_MAX_ABS_MT_TOUCH 15
+#define DEFAULT_MAX_ABS_MT_ORIENTATION 1
+#define DEFAULT_MIN_ABS_MT_TRACKING_ID 1
+#define DEFAULT_MAX_ABS_MT_TRACKING_ID 10
+
+/** A note about RMI4 F11 register structure.
+ *
+ * The properties for
+ * a given sensor are described by its query registers.  The number of=
 query
+ * registers and the layout of their contents are described by the F11=
 device
+ * queries as well as the sensor query information.
+ *
+ * Similarly, each sensor has control registers that govern its behavi=
or.  The
+ * size and layout of the control registers for a given sensor can be =
determined
+ * by parsing that sensors query registers.
+ *
+ * And in a likewise fashion, each sensor has data registers where it =
reports
+ * its touch data and other interesting stuff.  The size and layout of=
 a
+ * sensors data registers must be determined by parsing its query regi=
sters.
+ *
+ * The short story is that we need to read and parse a lot of query
+ * registers in order to determine the attributes of a sensor. Then
+ * we need to use that data to compute the size of the control and dat=
a
+ * registers for sensor.
+ *
+ * The end result is that we have a number of structs that aren't used=
 to
+ * directly generate the input events, but their size, location and co=
ntents
+ * are critical to determining where the data we are interested in liv=
es.
+ *
+ * At this time, the driver does not yet comprehend all possible F11
+ * configuration options, but it should be sufficient to cover 99% of =
RMI4 F11
+ * devices currently in the field.
+ */
+
+/* maximum ABS_MT_POSITION displacement (in mm) */
+#define DMAX 10
+
+/**
+ * @rezero - writing this to the F11 command register will cause the s=
ensor to
+ * calibrate to the current capacitive state.
+ */
+#define RMI_F11_REZERO  0x01
+
+#define RMI_F11_HAS_QUERY9              (1 << 3)
+#define RMI_F11_HAS_QUERY11             (1 << 4)
+#define RMI_F11_HAS_QUERY12             (1 << 5)
+#define RMI_F11_HAS_QUERY27             (1 << 6)
+#define RMI_F11_HAS_QUERY28             (1 << 7)
+
+/** Defs for Query 1 */
+
+#define RMI_F11_NR_FINGERS_MASK 0x07
+#define RMI_F11_HAS_REL                 (1 << 3)
+#define RMI_F11_HAS_ABS                 (1 << 4)
+#define RMI_F11_HAS_GESTURES            (1 << 5)
+#define RMI_F11_HAS_SENSITIVITY_ADJ     (1 << 6)
+#define RMI_F11_CONFIGURABLE            (1 << 7)
+
+/** Defs for Query 2, 3, and 4. */
+#define RMI_F11_NR_ELECTRODES_MASK      0x7F
+
+/** Defs for Query 5 */
+
+#define RMI_F11_ABS_DATA_SIZE_MASK      0x03
+#define RMI_F11_HAS_ANCHORED_FINGER     (1 << 2)
+#define RMI_F11_HAS_ADJ_HYST            (1 << 3)
+#define RMI_F11_HAS_DRIBBLE             (1 << 4)
+#define RMI_F11_HAS_BENDING_CORRECTION  (1 << 5)
+#define RMI_F11_HAS_LARGE_OBJECT_SUPPRESSION    (1 << 6)
+#define RMI_F11_HAS_JITTER_FILTER       (1 << 7)
+
+/** Defs for Query 7 */
+#define RMI_F11_HAS_SINGLE_TAP                  (1 << 0)
+#define RMI_F11_HAS_TAP_AND_HOLD                (1 << 1)
+#define RMI_F11_HAS_DOUBLE_TAP                  (1 << 2)
+#define RMI_F11_HAS_EARLY_TAP                   (1 << 3)
+#define RMI_F11_HAS_FLICK                       (1 << 4)
+#define RMI_F11_HAS_PRESS                       (1 << 5)
+#define RMI_F11_HAS_PINCH                       (1 << 6)
+#define RMI_F11_HAS_CHIRAL                      (1 << 7)
+
+/** Defs for Query 8 */
+#define RMI_F11_HAS_PALM_DET                    (1 << 0)
+#define RMI_F11_HAS_ROTATE                      (1 << 1)
+#define RMI_F11_HAS_TOUCH_SHAPES                (1 << 2)
+#define RMI_F11_HAS_SCROLL_ZONES                (1 << 3)
+#define RMI_F11_HAS_INDIVIDUAL_SCROLL_ZONES     (1 << 4)
+#define RMI_F11_HAS_MF_SCROLL                   (1 << 5)
+#define RMI_F11_HAS_MF_EDGE_MOTION              (1 << 6)
+#define RMI_F11_HAS_MF_SCROLL_INERTIA           (1 << 7)
+
+/** Defs for Query 9. */
+#define RMI_F11_HAS_PEN                         (1 << 0)
+#define RMI_F11_HAS_PROXIMITY                   (1 << 1)
+#define RMI_F11_HAS_PALM_DET_SENSITIVITY        (1 << 2)
+#define RMI_F11_HAS_SUPPRESS_ON_PALM_DETECT     (1 << 3)
+#define RMI_F11_HAS_TWO_PEN_THRESHOLDS          (1 << 4)
+#define RMI_F11_HAS_CONTACT_GEOMETRY            (1 << 5)
+#define RMI_F11_HAS_PEN_HOVER_DISCRIMINATION    (1 << 6)
+#define RMI_F11_HAS_PEN_FILTERS                 (1 << 7)
+
+/** Defs for Query 10. */
+#define RMI_F11_NR_TOUCH_SHAPES_MASK            0x1F
+
+/** Defs for Query 11 */
+
+#define RMI_F11_HAS_Z_TUNING                    (1 << 0)
+#define RMI_F11_HAS_ALGORITHM_SELECTION         (1 << 1)
+#define RMI_F11_HAS_W_TUNING                    (1 << 2)
+#define RMI_F11_HAS_PITCH_INFO                  (1 << 3)
+#define RMI_F11_HAS_FINGER_SIZE                 (1 << 4)
+#define RMI_F11_HAS_SEGMENTATION_AGGRESSIVENESS (1 << 5)
+#define RMI_F11_HAS_XY_CLIP                     (1 << 6)
+#define RMI_F11_HAS_DRUMMING_FILTER             (1 << 7)
+
+/** Defs for Query 12. */
+
+#define RMI_F11_HAS_GAPLESS_FINGER              (1 << 0)
+#define RMI_F11_HAS_GAPLESS_FINGER_TUNING       (1 << 1)
+#define RMI_F11_HAS_8BIT_W                      (1 << 2)
+#define RMI_F11_HAS_ADJUSTABLE_MAPPING          (1 << 3)
+#define RMI_F11_HAS_INFO2                       (1 << 4)
+#define RMI_F11_HAS_PHYSICAL_PROPS              (1 << 5)
+#define RMI_F11_HAS_FINGER_LIMIT                (1 << 6)
+#define RMI_F11_HAS_LINEAR_COEFF                (1 << 7)
+
+/** Defs for Query 13. */
+
+#define RMI_F11_JITTER_WINDOW_MASK              0x1F
+#define RMI_F11_JITTER_FILTER_MASK              0x60
+#define RMI_F11_JITTER_FILTER_SHIFT             5
+
+/** Defs for Query 14. */
+#define RMI_F11_LIGHT_CONTROL_MASK              0x03
+#define RMI_F11_IS_CLEAR                        (1 << 2)
+#define RMI_F11_CLICKPAD_PROPS_MASK             0x18
+#define RMI_F11_CLICKPAD_PROPS_SHIFT            3
+#define RMI_F11_MOUSE_BUTTONS_MASK              0x60
+#define RMI_F11_MOUSE_BUTTONS_SHIFT             5
+#define RMI_F11_HAS_ADVANCED_GESTURES           (1 << 7)
+
+#define RMI_F11_QUERY_SIZE                      4
+#define RMI_F11_QUERY_GESTURE_SIZE              2
+
+#define F11_LIGHT_CTL_NONE 0x00
+#define F11_LUXPAD	   0x01
+#define F11_DUAL_MODE      0x02
+
+#define F11_NOT_CLICKPAD     0x00
+#define F11_HINGED_CLICKPAD  0x01
+#define F11_UNIFORM_CLICKPAD 0x02
+
+/**
+ * Query registers 1 through 4 are always present.
+ *
+ * @nr_fingers - describes the maximum number of fingers the 2-D senso=
r
+ * supports.
+ * @has_rel - the sensor supports relative motion reporting.
+ * @has_abs - the sensor supports absolute poition reporting.
+ * @has_gestures - the sensor supports gesture reporting.
+ * @has_sensitivity_adjust - the sensor supports a global sensitivity
+ * adjustment.
+ * @configurable - the sensor supports various configuration options.
+ * @num_of_x_electrodes -  the maximum number of electrodes the 2-D se=
nsor
+ * supports on the X axis.
+ * @num_of_y_electrodes -  the maximum number of electrodes the 2-D se=
nsor
+ * supports on the Y axis.
+ * @max_electrodes - the total number of X and Y electrodes that may b=
e
+ * configured.
+ *
+ * Query 5 is present if the has_abs bit is set.
+ *
+ * @abs_data_size - describes the format of data reported by the absol=
ute
+ * data source.  Only one format (the kind used here) is supported at =
this
+ * time.
+ * @has_anchored_finger - then the sensor supports the high-precision =
second
+ * finger tracking provided by the manual tracking and motion sensitiv=
ity
+ * options.
+ * @has_adjust_hyst - the difference between the finger release thresh=
old and
+ * the touch threshold.
+ * @has_dribble - the sensor supports the generation of dribble interr=
upts,
+ * which may be enabled or disabled with the dribble control bit.
+ * @has_bending_correction - Bending related data registers 28 and 36,=
 and
+ * control register 52..57 are present.
+ * @has_large_object_suppression - control register 58 and data regist=
er 28
+ * exist.
+ * @has_jitter_filter - query 13 and control 73..76 exist.
+ *
+ * Gesture information queries 7 and 8 are present if has_gestures bit=
 is set.
+ *
+ * @has_single_tap - a basic single-tap gesture is supported.
+ * @has_tap_n_hold - tap-and-hold gesture is supported.
+ * @has_double_tap - double-tap gesture is supported.
+ * @has_early_tap - early tap is supported and reported as soon as the=
 finger
+ * lifts for any tap event that could be interpreted as either a singl=
e tap
+ * or as the first tap of a double-tap or tap-and-hold gesture.
+ * @has_flick - flick detection is supported.
+ * @has_press - press gesture reporting is supported.
+ * @has_pinch - pinch gesture detection is supported.
+ * @has_palm_det - the 2-D sensor notifies the host whenever a large c=
onductive
+ * object such as a palm or a cheek touches the 2-D sensor.
+ * @has_rotate - rotation gesture detection is supported.
+ * @has_touch_shapes - TouchShapes are supported.  A TouchShape is a f=
ixed
+ * rectangular area on the sensor that behaves like a capacitive butto=
n.
+ * @has_scroll_zones - scrolling areas near the sensor edges are suppo=
rted.
+ * @has_individual_scroll_zones - if 1, then 4 scroll zones are suppor=
ted;
+ * if 0, then only two are supported.
+ * @has_mf_scroll - the multifinger_scrolling bit will be set when
+ * more than one finger is involved in a scrolling action.
+ *
+ * Convenience for checking bytes in the gesture info registers.  This=
 is done
+ * often enough that we put it here to declutter the conditionals
+ *
+ * @query7_nonzero - true if none of the query 7 bits are set
+ * @query8_nonzero - true if none of the query 8 bits are set
+ *
+ * Query 9 is present if the has_query9 is set.
+ *
+ * @has_pen - detection of a stylus is supported and registers F11_2D_=
Ctrl20
+ * and F11_2D_Ctrl21 exist.
+ * @has_proximity - detection of fingers near the sensor is supported =
and
+ * registers F11_2D_Ctrl22 through F11_2D_Ctrl26 exist.
+ * @has_palm_det_sensitivity -  the sensor supports the palm detect se=
nsitivity
+ * feature and register F11_2D_Ctrl27 exists.
+ * @has_two_pen_thresholds - is has_pen is also set, then F11_2D_Ctrl3=
5 exists.
+ * @has_contact_geometry - the sensor supports the use of contact geom=
etry to
+ * map absolute X and Y target positions and registers F11_2D_Data18
+ * through F11_2D_Data27 exist.
+ *
+ * Touch shape info (query 10) is present if has_touch_shapes is set.
+ *
+ * @nr_touch_shapes - the total number of touch shapes supported.
+ *
+ * Query 11 is present if the has_query11 bit is set in query 0.
+ *
+ * @has_z_tuning - if set, the sensor supports Z tuning and registers
+ * F11_2D_Ctrl29 through F11_2D_Ctrl33 exist.
+ * @has_algorithm_selection - controls choice of noise suppression alg=
orithm
+ * @has_w_tuning - the sensor supports Wx and Wy scaling and registers
+ * F11_2D_Ctrl36 through F11_2D_Ctrl39 exist.
+ * @has_pitch_info - the X and Y pitches of the sensor electrodes can =
be
+ * configured and registers F11_2D_Ctrl40 and F11_2D_Ctrl41 exist.
+ * @has_finger_size -  the default finger width settings for the
+ * sensor can be configured and registers F11_2D_Ctrl42 through F11_2D=
_Ctrl44
+ * exist.
+ * @has_segmentation_aggressiveness - the sensor=E2=80=99s ability to =
distinguish
+ * multiple objects close together can be configured and register F11_=
2D_Ctrl45
+ * exists.
+ * @has_XY_clip -  the inactive outside borders of the sensor can be
+ * configured and registers F11_2D_Ctrl46 through F11_2D_Ctrl49 exist.
+ * @has_drumming_filter - the sensor can be configured to distinguish
+ * between a fast flick and a quick drumming movement and registers
+ * F11_2D_Ctrl50 and F11_2D_Ctrl51 exist.
+ *
+ * Query 12 is present if hasQuery12 bit is set.
+ *
+ * @has_gapless_finger - control registers relating to gapless finger =
are
+ * present.
+ * @has_gapless_finger_tuning - additional control and data registers =
relating
+ * to gapless finger are present.
+ * @has_8bit_w - larger W value reporting is supported.
+ * @has_adjustable_mapping - TBD
+ * @has_info2 - the general info query14 is present
+ * @has_physical_props - additional queries describing the physical pr=
operties
+ * of the sensor are present.
+ * @has_finger_limit - indicates that F11 Ctrl 80 exists.
+ * @has_linear_coeff - indicates that F11 Ctrl 81 exists.
+ *
+ * Query 13 is present if Query 5's has_jitter_filter bit is set.
+ * @jitter_window_size - used by Design Studio 4.
+ * @jitter_filter_type - used by Design Studio 4.
+ *
+ * Query 14 is present if query 12's has_general_info2 flag is set.
+ *
+ * @light_control - Indicates what light/led control features are pres=
ent, if
+ * any.
+ * @is_clear - if set, this is a clear sensor (indicating direct point=
ing
+ * application), otherwise it's opaque (indicating indirect pointing).
+ * @clickpad_props - specifies if this is a clickpad, and if so what s=
ort of
+ * mechanism it uses
+ * @mouse_buttons - specifies the number of mouse buttons present (if =
any).
+ * @has_advanced_gestures - advanced driver gestures are supported.
+ */
+struct f11_2d_sensor_queries {
+	/* query1 */
+	u8 nr_fingers;
+	bool has_rel;
+	bool has_abs;
+	bool has_gestures;
+	bool has_sensitivity_adjust;
+	bool configurable;
+
+	/* query2 */
+	u8 nr_x_electrodes;
+
+	/* query3 */
+	u8 nr_y_electrodes;
+
+	/* query4 */
+	u8 max_electrodes;
+
+	/* query5 */
+	u8 abs_data_size;
+	bool has_anchored_finger;
+	bool has_adj_hyst;
+	bool has_dribble;
+	bool has_bending_correction;
+	bool has_large_object_suppression;
+	bool has_jitter_filter;
+
+	u8 f11_2d_query6;
+
+	/* query 7 */
+	bool has_single_tap;
+	bool has_tap_n_hold;
+	bool has_double_tap;
+	bool has_early_tap;
+	bool has_flick;
+	bool has_press;
+	bool has_pinch;
+	bool has_chiral;
+
+	bool query7_nonzero;
+
+	/* query 8 */
+	bool has_palm_det;
+	bool has_rotate;
+	bool has_touch_shapes;
+	bool has_scroll_zones;
+	bool has_individual_scroll_zones;
+	bool has_mf_scroll;
+	bool has_mf_edge_motion;
+	bool has_mf_scroll_inertia;
+
+	bool query8_nonzero;
+
+	/* Query 9 */
+	bool has_pen;
+	bool has_proximity;
+	bool has_palm_det_sensitivity;
+	bool has_suppress_on_palm_detect;
+	bool has_two_pen_thresholds;
+	bool has_contact_geometry;
+	bool has_pen_hover_discrimination;
+	bool has_pen_filters;
+
+	/* Query 10 */
+	u8 nr_touch_shapes;
+
+	/* Query 11. */
+	bool has_z_tuning;
+	bool has_algorithm_selection;
+	bool has_w_tuning;
+	bool has_pitch_info;
+	bool has_finger_size;
+	bool has_segmentation_aggressiveness;
+	bool has_XY_clip;
+	bool has_drumming_filter;
+
+	/* Query 12 */
+	bool has_gapless_finger;
+	bool has_gapless_finger_tuning;
+	bool has_8bit_w;
+	bool has_adjustable_mapping;
+	bool has_info2;
+	bool has_physical_props;
+	bool has_finger_limit;
+	bool has_linear_coeff_2;
+
+	/* Query 13 */
+	u8 jitter_window_size;
+	u8 jitter_filter_type;
+
+	/* Query 14 */
+	u8 light_control;
+	bool is_clear;
+	u8 clickpad_props;
+	u8 mouse_buttons;
+	bool has_advanced_gestures;
+
+	/* Query 15 - 18 */
+	u16 x_sensor_size_mm;
+	u16 y_sensor_size_mm;
+};
+
+/* Defs for Ctrl0. */
+#define RMI_F11_REPORT_MODE_MASK        0x07
+#define RMI_F11_ABS_POS_FILT            (1 << 3)
+#define RMI_F11_REL_POS_FILT            (1 << 4)
+#define RMI_F11_REL_BALLISTICS          (1 << 5)
+#define RMI_F11_DRIBBLE                 (1 << 6)
+#define RMI_F11_REPORT_BEYOND_CLIP      (1 << 7)
+
+/* Defs for Ctrl1. */
+#define RMI_F11_PALM_DETECT_THRESH_MASK 0x0F
+#define RMI_F11_MOTION_SENSITIVITY_MASK 0x30
+#define RMI_F11_MANUAL_TRACKING         (1 << 6)
+#define RMI_F11_MANUAL_TRACKED_FINGER   (1 << 7)
+
+#define RMI_F11_DELTA_X_THRESHOLD       2
+#define RMI_F11_DELTA_Y_THRESHOLD       3
+
+#define RMI_F11_CTRL_REG_COUNT          12
+
+struct f11_2d_ctrl {
+	u8              ctrl0_11[RMI_F11_CTRL_REG_COUNT];
+	u16             ctrl0_11_address;
+};
+
+#define RMI_F11_ABS_BYTES 5
+#define RMI_F11_REL_BYTES 2
+
+/* Defs for Data 8 */
+
+#define RMI_F11_SINGLE_TAP              (1 << 0)
+#define RMI_F11_TAP_AND_HOLD            (1 << 1)
+#define RMI_F11_DOUBLE_TAP              (1 << 2)
+#define RMI_F11_EARLY_TAP               (1 << 3)
+#define RMI_F11_FLICK                   (1 << 4)
+#define RMI_F11_PRESS                   (1 << 5)
+#define RMI_F11_PINCH                   (1 << 6)
+
+/* Defs for Data 9 */
+
+#define RMI_F11_PALM_DETECT                     (1 << 0)
+#define RMI_F11_ROTATE                          (1 << 1)
+#define RMI_F11_SHAPE                           (1 << 2)
+#define RMI_F11_SCROLLZONE                      (1 << 3)
+#define RMI_F11_GESTURE_FINGER_COUNT_MASK       0x70
+
+/** Handy pointers into our data buffer.
+ *
+ * @f_state - start of finger state registers.
+ * @abs_pos - start of absolute position registers (if present).
+ * @rel_pos - start of relative data registers (if present).
+ * @gest_1  - gesture flags (if present).
+ * @gest_2  - gesture flags & finger count (if present).
+ * @pinch   - pinch motion register (if present).
+ * @flick   - flick distance X & Y, flick time (if present).
+ * @rotate  - rotate motion and finger separation.
+ * @multi_scroll - chiral deltas for X and Y (if present).
+ * @scroll_zones - scroll deltas for 4 regions (if present).
+ */
+struct f11_2d_data {
+	u8	*f_state;
+	u8	*abs_pos;
+	s8	*rel_pos;
+	u8	*gest_1;
+	u8	*gest_2;
+	s8	*pinch;
+	u8	*flick;
+	u8	*rotate;
+	u8	*shapes;
+	s8	*multi_scroll;
+	s8	*scroll_zones;
+};
+
+/** Data pertaining to F11 in general.  For per-sensor data, see struc=
t
+ * f11_2d_sensor.
+ *
+ * @dev_query - F11 device specific query registers.
+ * @dev_controls - F11 device specific control registers.
+ * @dev_controls_mutex - lock for the control registers.
+ * @rezero_wait_ms - if nonzero, upon resume we will wait this many
+ * milliseconds before rezeroing the sensor(s).  This is useful in sys=
tems with
+ * poor electrical behavior on resume, where the initial calibration o=
f the
+ * sensor(s) coming out of sleep state may be bogus.
+ * @sensors - per sensor data structures.
+ */
+struct f11_data {
+	bool has_query9;
+	bool has_query11;
+	bool has_query12;
+	bool has_query27;
+	bool has_query28;
+	bool has_acm;
+	struct f11_2d_ctrl dev_controls;
+	struct mutex dev_controls_mutex;
+	u16 rezero_wait_ms;
+	struct rmi_2d_sensor sensor;
+	struct f11_2d_sensor_queries sens_query;
+	struct f11_2d_data data;
+	struct rmi_2d_sensor_platform_data sensor_pdata;
+	unsigned long *abs_mask;
+	unsigned long *rel_mask;
+	unsigned long *result_bits;
+};
+
+enum f11_finger_state {
+	F11_NO_FINGER	=3D 0x00,
+	F11_PRESENT	=3D 0x01,
+	F11_INACCURATE	=3D 0x02,
+	F11_RESERVED	=3D 0x03
+};
+
+static void rmi_f11_rel_pos_report(struct f11_data *f11, u8 n_finger)
+{
+	struct rmi_2d_sensor *sensor =3D &f11->sensor;
+	struct f11_2d_data *data =3D &f11->data;
+	s8 x, y;
+
+	x =3D data->rel_pos[n_finger * 2];
+	y =3D data->rel_pos[n_finger * 2 + 1];
+
+	rmi_2d_sensor_rel_report(sensor, x, y);
+}
+
+static void rmi_f11_abs_pos_process(struct f11_data *f11,
+				   struct rmi_2d_sensor *sensor,
+				   struct rmi_2d_sensor_abs_object *obj,
+				   enum f11_finger_state finger_state,
+				   u8 n_finger)
+{
+	struct f11_2d_data *data =3D &f11->data;
+	u8 *pos_data =3D &data->abs_pos[n_finger * RMI_F11_ABS_BYTES];
+	int tool_type =3D MT_TOOL_FINGER;
+
+	switch (finger_state) {
+	case F11_PRESENT:
+		obj->type =3D RMI_2D_OBJECT_FINGER;
+		break;
+	default:
+		obj->type =3D RMI_2D_OBJECT_NONE;
+	}
+
+	obj->mt_tool =3D tool_type;
+	obj->x =3D (pos_data[0] << 4) | (pos_data[2] & 0x0F);
+	obj->y =3D (pos_data[1] << 4) | (pos_data[2] >> 4);
+	obj->z =3D pos_data[4];
+	obj->wx =3D pos_data[3] & 0x0f;
+	obj->wy =3D pos_data[3] >> 4;
+
+	rmi_2d_sensor_abs_process(sensor, obj, n_finger);
+}
+
+static inline u8 rmi_f11_parse_finger_state(const u8 *f_state, u8 n_fi=
nger)
+{
+	return (f_state[n_finger / 4] >> (2 * (n_finger % 4))) &
+							FINGER_STATE_MASK;
+}
+
+static void rmi_f11_finger_handler(struct f11_data *f11,
+				   struct rmi_2d_sensor *sensor,
+				   unsigned long *irq_bits, int num_irq_regs)
+{
+	const u8 *f_state =3D f11->data.f_state;
+	u8 finger_state;
+	u8 i;
+
+	int abs_bits =3D bitmap_and(f11->result_bits, irq_bits, f11->abs_mask=
,
+				  num_irq_regs * 8);
+	int rel_bits =3D bitmap_and(f11->result_bits, irq_bits, f11->rel_mask=
,
+				  num_irq_regs * 8);
+
+	for (i =3D 0; i < sensor->nbr_fingers; i++) {
+		/* Possible of having 4 fingers per f_statet register */
+		finger_state =3D rmi_f11_parse_finger_state(f_state, i);
+		if (finger_state =3D=3D F11_RESERVED) {
+			pr_err("Invalid finger state[%d]: 0x%02x", i,
+				finger_state);
+			continue;
+		}
+
+		if (abs_bits)
+			rmi_f11_abs_pos_process(f11, sensor, &sensor->objs[i],
+							finger_state, i);
+
+		if (rel_bits)
+			rmi_f11_rel_pos_report(f11, i);
+	}
+
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
+		for (i =3D 0; i < sensor->nbr_fingers; i++) {
+			finger_state =3D rmi_f11_parse_finger_state(f_state, i);
+			if (finger_state =3D=3D F11_RESERVED)
+				/* no need to send twice the error */
+				continue;
+
+			rmi_2d_sensor_abs_report(sensor, &sensor->objs[i], i);
+		}
+
+		input_mt_sync_frame(sensor->input);
+	}
+}
+
+static int f11_2d_construct_data(struct f11_data *f11)
+{
+	struct rmi_2d_sensor *sensor =3D &f11->sensor;
+	struct f11_2d_sensor_queries *query =3D &f11->sens_query;
+	struct f11_2d_data *data =3D &f11->data;
+	int i;
+
+	sensor->nbr_fingers =3D (query->nr_fingers =3D=3D 5 ? 10 :
+				query->nr_fingers + 1);
+
+	sensor->pkt_size =3D DIV_ROUND_UP(sensor->nbr_fingers, 4);
+
+	if (query->has_abs) {
+		sensor->pkt_size +=3D (sensor->nbr_fingers * 5);
+		sensor->attn_size =3D sensor->pkt_size;
+	}
+
+	if (query->has_rel)
+		sensor->pkt_size +=3D  (sensor->nbr_fingers * 2);
+
+	/* Check if F11_2D_Query7 is non-zero */
+	if (query->query7_nonzero)
+		sensor->pkt_size +=3D sizeof(u8);
+
+	/* Check if F11_2D_Query7 or F11_2D_Query8 is non-zero */
+	if (query->query7_nonzero || query->query8_nonzero)
+		sensor->pkt_size +=3D sizeof(u8);
+
+	if (query->has_pinch || query->has_flick || query->has_rotate) {
+		sensor->pkt_size +=3D 3;
+		if (!query->has_flick)
+			sensor->pkt_size--;
+		if (!query->has_rotate)
+			sensor->pkt_size--;
+	}
+
+	if (query->has_touch_shapes)
+		sensor->pkt_size +=3D
+			DIV_ROUND_UP(query->nr_touch_shapes + 1, 8);
+
+	sensor->data_pkt =3D devm_kzalloc(&sensor->fn->dev, sensor->pkt_size,
+					GFP_KERNEL);
+	if (!sensor->data_pkt)
+		return -ENOMEM;
+
+	data->f_state =3D sensor->data_pkt;
+	i =3D DIV_ROUND_UP(sensor->nbr_fingers, 4);
+
+	if (query->has_abs) {
+		data->abs_pos =3D &sensor->data_pkt[i];
+		i +=3D (sensor->nbr_fingers * RMI_F11_ABS_BYTES);
+	}
+
+	if (query->has_rel) {
+		data->rel_pos =3D &sensor->data_pkt[i];
+		i +=3D (sensor->nbr_fingers * RMI_F11_REL_BYTES);
+	}
+
+	if (query->query7_nonzero) {
+		data->gest_1 =3D &sensor->data_pkt[i];
+		i++;
+	}
+
+	if (query->query7_nonzero || query->query8_nonzero) {
+		data->gest_2 =3D &sensor->data_pkt[i];
+		i++;
+	}
+
+	if (query->has_pinch) {
+		data->pinch =3D &sensor->data_pkt[i];
+		i++;
+	}
+
+	if (query->has_flick) {
+		if (query->has_pinch) {
+			data->flick =3D data->pinch;
+			i +=3D 2;
+		} else {
+			data->flick =3D &sensor->data_pkt[i];
+			i +=3D 3;
+		}
+	}
+
+	if (query->has_rotate) {
+		if (query->has_flick) {
+			data->rotate =3D data->flick + 1;
+		} else {
+			data->rotate =3D &sensor->data_pkt[i];
+			i +=3D 2;
+		}
+	}
+
+	if (query->has_touch_shapes)
+		data->shapes =3D &sensor->data_pkt[i];
+
+	return 0;
+}
+
+static int f11_read_control_regs(struct rmi_function *fn,
+				struct f11_2d_ctrl *ctrl, u16 ctrl_base_addr) {
+	struct rmi_device *rmi_dev =3D fn->rmi_dev;
+	int error =3D 0;
+
+	ctrl->ctrl0_11_address =3D ctrl_base_addr;
+	error =3D rmi_read_block(rmi_dev, ctrl_base_addr, ctrl->ctrl0_11,
+				RMI_F11_CTRL_REG_COUNT);
+	if (error < 0) {
+		dev_err(&fn->dev, "Failed to read ctrl0, code: %d.\n", error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int f11_write_control_regs(struct rmi_function *fn,
+					struct f11_2d_sensor_queries *query,
+					struct f11_2d_ctrl *ctrl,
+					u16 ctrl_base_addr)
+{
+	struct rmi_device *rmi_dev =3D fn->rmi_dev;
+	int error;
+
+	error =3D rmi_write_block(rmi_dev, ctrl_base_addr, ctrl->ctrl0_11,
+				RMI_F11_CTRL_REG_COUNT);
+	if (error < 0)
+		return error;
+
+	return 0;
+}
+
+static int rmi_f11_get_query_parameters(struct rmi_device *rmi_dev,
+			struct f11_data *f11,
+			struct f11_2d_sensor_queries *sensor_query,
+			u16 query_base_addr)
+{
+	int query_size;
+	int rc;
+	u8 query_buf[RMI_F11_QUERY_SIZE];
+	bool has_query36 =3D false;
+
+	rc =3D rmi_read_block(rmi_dev, query_base_addr, query_buf,
+				RMI_F11_QUERY_SIZE);
+	if (rc < 0)
+		return rc;
+
+	sensor_query->nr_fingers =3D query_buf[0] & RMI_F11_NR_FINGERS_MASK;
+	sensor_query->has_rel =3D !!(query_buf[0] & RMI_F11_HAS_REL);
+	sensor_query->has_abs =3D !!(query_buf[0] & RMI_F11_HAS_ABS);
+	sensor_query->has_gestures =3D !!(query_buf[0] & RMI_F11_HAS_GESTURES=
);
+	sensor_query->has_sensitivity_adjust =3D
+		!!(query_buf[0] && RMI_F11_HAS_SENSITIVITY_ADJ);
+	sensor_query->configurable =3D !!(query_buf[0] & RMI_F11_CONFIGURABLE=
);
+
+	sensor_query->nr_x_electrodes =3D
+				query_buf[1] & RMI_F11_NR_ELECTRODES_MASK;
+	sensor_query->nr_y_electrodes =3D
+				query_buf[2] & RMI_F11_NR_ELECTRODES_MASK;
+	sensor_query->max_electrodes =3D
+				query_buf[3] & RMI_F11_NR_ELECTRODES_MASK;
+
+	query_size =3D RMI_F11_QUERY_SIZE;
+
+	if (sensor_query->has_abs) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
+		if (rc < 0)
+			return rc;
+
+		sensor_query->abs_data_size =3D
+			query_buf[0] & RMI_F11_ABS_DATA_SIZE_MASK;
+		sensor_query->has_anchored_finger =3D
+			!!(query_buf[0] & RMI_F11_HAS_ANCHORED_FINGER);
+		sensor_query->has_adj_hyst =3D
+			!!(query_buf[0] & RMI_F11_HAS_ADJ_HYST);
+		sensor_query->has_dribble =3D
+			!!(query_buf[0] & RMI_F11_HAS_DRIBBLE);
+		sensor_query->has_bending_correction =3D
+			!!(query_buf[0] & RMI_F11_HAS_BENDING_CORRECTION);
+		sensor_query->has_large_object_suppression =3D
+		!!(query_buf[0] && RMI_F11_HAS_LARGE_OBJECT_SUPPRESSION);
+		sensor_query->has_jitter_filter =3D
+			!!(query_buf[0] & RMI_F11_HAS_JITTER_FILTER);
+		query_size++;
+	}
+
+	if (sensor_query->has_rel) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size,
+					&sensor_query->f11_2d_query6);
+		if (rc < 0)
+			return rc;
+		query_size++;
+	}
+
+	if (sensor_query->has_gestures) {
+		rc =3D rmi_read_block(rmi_dev, query_base_addr + query_size,
+					query_buf, RMI_F11_QUERY_GESTURE_SIZE);
+		if (rc < 0)
+			return rc;
+
+		sensor_query->has_single_tap =3D
+			!!(query_buf[0] & RMI_F11_HAS_SINGLE_TAP);
+		sensor_query->has_tap_n_hold =3D
+			!!(query_buf[0] & RMI_F11_HAS_TAP_AND_HOLD);
+		sensor_query->has_double_tap =3D
+			!!(query_buf[0] & RMI_F11_HAS_DOUBLE_TAP);
+		sensor_query->has_early_tap =3D
+			!!(query_buf[0] & RMI_F11_HAS_EARLY_TAP);
+		sensor_query->has_flick =3D
+			!!(query_buf[0] & RMI_F11_HAS_FLICK);
+		sensor_query->has_press =3D
+			!!(query_buf[0] & RMI_F11_HAS_PRESS);
+		sensor_query->has_pinch =3D
+			!!(query_buf[0] & RMI_F11_HAS_PINCH);
+		sensor_query->has_chiral =3D
+			!!(query_buf[0] & RMI_F11_HAS_CHIRAL);
+
+		/* query 8 */
+		sensor_query->has_palm_det =3D
+			!!(query_buf[1] & RMI_F11_HAS_PALM_DET);
+		sensor_query->has_rotate =3D
+			!!(query_buf[1] & RMI_F11_HAS_ROTATE);
+		sensor_query->has_touch_shapes =3D
+			!!(query_buf[1] & RMI_F11_HAS_TOUCH_SHAPES);
+		sensor_query->has_scroll_zones =3D
+			!!(query_buf[1] & RMI_F11_HAS_SCROLL_ZONES);
+		sensor_query->has_individual_scroll_zones =3D
+			!!(query_buf[1] & RMI_F11_HAS_INDIVIDUAL_SCROLL_ZONES);
+		sensor_query->has_mf_scroll =3D
+			!!(query_buf[1] & RMI_F11_HAS_MF_SCROLL);
+		sensor_query->has_mf_edge_motion =3D
+			!!(query_buf[1] & RMI_F11_HAS_MF_EDGE_MOTION);
+		sensor_query->has_mf_scroll_inertia =3D
+			!!(query_buf[1] & RMI_F11_HAS_MF_SCROLL_INERTIA);
+
+		sensor_query->query7_nonzero =3D !!(query_buf[0]);
+		sensor_query->query8_nonzero =3D !!(query_buf[1]);
+
+		query_size +=3D 2;
+	}
+
+	if (f11->has_query9) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
+		if (rc < 0)
+			return rc;
+
+		sensor_query->has_pen =3D
+			!!(query_buf[0] & RMI_F11_HAS_PEN);
+		sensor_query->has_proximity =3D
+			!!(query_buf[0] & RMI_F11_HAS_PROXIMITY);
+		sensor_query->has_palm_det_sensitivity =3D
+			!!(query_buf[0] & RMI_F11_HAS_PALM_DET_SENSITIVITY);
+		sensor_query->has_suppress_on_palm_detect =3D
+			!!(query_buf[0] & RMI_F11_HAS_SUPPRESS_ON_PALM_DETECT);
+		sensor_query->has_two_pen_thresholds =3D
+			!!(query_buf[0] & RMI_F11_HAS_TWO_PEN_THRESHOLDS);
+		sensor_query->has_contact_geometry =3D
+			!!(query_buf[0] & RMI_F11_HAS_CONTACT_GEOMETRY);
+		sensor_query->has_pen_hover_discrimination =3D
+			!!(query_buf[0] & RMI_F11_HAS_PEN_HOVER_DISCRIMINATION);
+		sensor_query->has_pen_filters =3D
+			!!(query_buf[0] & RMI_F11_HAS_PEN_FILTERS);
+
+		query_size++;
+	}
+
+	if (sensor_query->has_touch_shapes) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
+		if (rc < 0)
+			return rc;
+
+		sensor_query->nr_touch_shapes =3D query_buf[0] &
+				RMI_F11_NR_TOUCH_SHAPES_MASK;
+
+		query_size++;
+	}
+
+	if (f11->has_query11) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
+		if (rc < 0)
+			return rc;
+
+		sensor_query->has_z_tuning =3D
+			!!(query_buf[0] & RMI_F11_HAS_Z_TUNING);
+		sensor_query->has_algorithm_selection =3D
+			!!(query_buf[0] & RMI_F11_HAS_ALGORITHM_SELECTION);
+		sensor_query->has_w_tuning =3D
+			!!(query_buf[0] & RMI_F11_HAS_W_TUNING);
+		sensor_query->has_pitch_info =3D
+			!!(query_buf[0] & RMI_F11_HAS_PITCH_INFO);
+		sensor_query->has_finger_size =3D
+			!!(query_buf[0] & RMI_F11_HAS_FINGER_SIZE);
+		sensor_query->has_segmentation_aggressiveness =3D
+			!!(query_buf[0] &
+				RMI_F11_HAS_SEGMENTATION_AGGRESSIVENESS);
+		sensor_query->has_XY_clip =3D
+			!!(query_buf[0] & RMI_F11_HAS_XY_CLIP);
+		sensor_query->has_drumming_filter =3D
+			!!(query_buf[0] & RMI_F11_HAS_DRUMMING_FILTER);
+
+		query_size++;
+	}
+
+	if (f11->has_query12) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
+		if (rc < 0)
+			return rc;
+
+		sensor_query->has_gapless_finger =3D
+			!!(query_buf[0] & RMI_F11_HAS_GAPLESS_FINGER);
+		sensor_query->has_gapless_finger_tuning =3D
+			!!(query_buf[0] & RMI_F11_HAS_GAPLESS_FINGER_TUNING);
+		sensor_query->has_8bit_w =3D
+			!!(query_buf[0] & RMI_F11_HAS_8BIT_W);
+		sensor_query->has_adjustable_mapping =3D
+			!!(query_buf[0] & RMI_F11_HAS_ADJUSTABLE_MAPPING);
+		sensor_query->has_info2 =3D
+			!!(query_buf[0] & RMI_F11_HAS_INFO2);
+		sensor_query->has_physical_props =3D
+			!!(query_buf[0] & RMI_F11_HAS_PHYSICAL_PROPS);
+		sensor_query->has_finger_limit =3D
+			!!(query_buf[0] & RMI_F11_HAS_FINGER_LIMIT);
+		sensor_query->has_linear_coeff_2 =3D
+			!!(query_buf[0] & RMI_F11_HAS_LINEAR_COEFF);
+
+		query_size++;
+	}
+
+	if (sensor_query->has_jitter_filter) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
+		if (rc < 0)
+			return rc;
+
+		sensor_query->jitter_window_size =3D query_buf[0] &
+			RMI_F11_JITTER_WINDOW_MASK;
+		sensor_query->jitter_filter_type =3D (query_buf[0] &
+			RMI_F11_JITTER_FILTER_MASK) >>
+			RMI_F11_JITTER_FILTER_SHIFT;
+
+		query_size++;
+	}
+
+	if (sensor_query->has_info2) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size, query_buf);
+		if (rc < 0)
+			return rc;
+
+		sensor_query->light_control =3D
+			query_buf[0] & RMI_F11_LIGHT_CONTROL_MASK;
+		sensor_query->is_clear =3D
+			!!(query_buf[0] & RMI_F11_IS_CLEAR);
+		sensor_query->clickpad_props =3D
+			(query_buf[0] & RMI_F11_CLICKPAD_PROPS_MASK) >>
+			RMI_F11_CLICKPAD_PROPS_SHIFT;
+		sensor_query->mouse_buttons =3D
+			(query_buf[0] & RMI_F11_MOUSE_BUTTONS_MASK) >>
+			RMI_F11_MOUSE_BUTTONS_SHIFT;
+		sensor_query->has_advanced_gestures =3D
+			!!(query_buf[0] & RMI_F11_HAS_ADVANCED_GESTURES);
+
+		query_size++;
+	}
+
+	if (sensor_query->has_physical_props) {
+		rc =3D rmi_read_block(rmi_dev, query_base_addr
+			+ query_size, query_buf, 4);
+		if (rc < 0)
+			return rc;
+
+		sensor_query->x_sensor_size_mm =3D
+			(query_buf[0] | (query_buf[1] << 8)) / 10;
+		sensor_query->y_sensor_size_mm =3D
+			(query_buf[2] | (query_buf[3] << 8)) / 10;
+
+		/*
+		 * query 15 - 18 contain the size of the sensor
+		 * and query 19 - 26 contain bezel dimensions
+		 */
+		query_size +=3D 12;
+	}
+
+	if (f11->has_query27)
+		++query_size;
+
+	if (f11->has_query28) {
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size,
+				query_buf);
+		if (rc < 0)
+			return rc;
+
+		has_query36 =3D !!(query_buf[0] & BIT(6));
+	}
+
+	if (has_query36) {
+		query_size +=3D 2;
+		rc =3D rmi_read(rmi_dev, query_base_addr + query_size,
+				query_buf);
+		if (rc < 0)
+			return rc;
+
+		if (!!(query_buf[0] & BIT(5)))
+			f11->has_acm =3D true;
+	}
+
+	return query_size;
+}
+
+static int rmi_f11_initialize(struct rmi_function *fn)
+{
+	struct rmi_device *rmi_dev =3D fn->rmi_dev;
+	struct f11_data *f11;
+	struct f11_2d_ctrl *ctrl;
+	u8 query_offset;
+	u16 query_base_addr;
+	u16 control_base_addr;
+	u16 max_x_pos, max_y_pos;
+	int rc;
+	const struct rmi_device_platform_data *pdata =3D
+				rmi_get_platform_data(rmi_dev);
+	struct rmi_driver_data *drvdata =3D dev_get_drvdata(&rmi_dev->dev);
+	struct rmi_2d_sensor *sensor;
+	u8 buf;
+	int mask_size;
+
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Initializing F11 values.\n");
+
+	mask_size =3D BITS_TO_LONGS(drvdata->irq_count) * sizeof(unsigned lon=
g);
+
+	/*
+	** init instance data, fill in values and create any sysfs files
+	*/
+	f11 =3D devm_kzalloc(&fn->dev, sizeof(struct f11_data) + mask_size * =
3,
+			GFP_KERNEL);
+	if (!f11)
+		return -ENOMEM;
+
+	if (pdata->sensor_pdata)
+		f11->sensor_pdata =3D *pdata->sensor_pdata;
+
+	f11->rezero_wait_ms =3D f11->sensor_pdata.rezero_wait;
+
+	f11->abs_mask =3D (unsigned long *)((char *)f11
+			+ sizeof(struct f11_data));
+	f11->rel_mask =3D (unsigned long *)((char *)f11
+			+ sizeof(struct f11_data) + mask_size);
+	f11->result_bits =3D (unsigned long *)((char *)f11
+			+ sizeof(struct f11_data) + mask_size * 2);
+
+	set_bit(fn->irq_pos, f11->abs_mask);
+	set_bit(fn->irq_pos + 1, f11->rel_mask);
+
+	query_base_addr =3D fn->fd.query_base_addr;
+	control_base_addr =3D fn->fd.control_base_addr;
+
+	rc =3D rmi_read(rmi_dev, query_base_addr, &buf);
+	if (rc < 0)
+		return rc;
+
+	f11->has_query9 =3D !!(buf & RMI_F11_HAS_QUERY9);
+	f11->has_query11 =3D !!(buf & RMI_F11_HAS_QUERY11);
+	f11->has_query12 =3D !!(buf & RMI_F11_HAS_QUERY12);
+	f11->has_query27 =3D !!(buf & RMI_F11_HAS_QUERY27);
+	f11->has_query28 =3D !!(buf & RMI_F11_HAS_QUERY28);
+
+	query_offset =3D (query_base_addr + 1);
+	sensor =3D &f11->sensor;
+	sensor->fn =3D fn;
+
+	rc =3D rmi_f11_get_query_parameters(rmi_dev, f11,
+			&f11->sens_query, query_offset);
+	if (rc < 0)
+		return rc;
+	query_offset +=3D rc;
+
+	rc =3D f11_read_control_regs(fn, &f11->dev_controls,
+			control_base_addr);
+	if (rc < 0) {
+		dev_err(&fn->dev,
+			"Failed to read F11 control params.\n");
+		return rc;
+	}
+
+	if (f11->sens_query.has_info2) {
+		if (f11->sens_query.is_clear)
+			f11->sensor.sensor_type =3D rmi_sensor_touchscreen;
+		else
+			f11->sensor.sensor_type =3D rmi_sensor_touchpad;
+	}
+
+	sensor->report_abs =3D f11->sens_query.has_abs;
+
+	sensor->axis_align =3D
+		f11->sensor_pdata.axis_align;
+
+	sensor->topbuttonpad =3D f11->sensor_pdata.topbuttonpad;
+	sensor->kernel_tracking =3D f11->sensor_pdata.kernel_tracking;
+	sensor->dmax =3D f11->sensor_pdata.dmax;
+
+	if (f11->sens_query.has_physical_props) {
+		sensor->x_mm =3D f11->sens_query.x_sensor_size_mm;
+		sensor->y_mm =3D f11->sens_query.y_sensor_size_mm;
+	} else {
+		sensor->x_mm =3D f11->sensor_pdata.x_mm;
+		sensor->y_mm =3D f11->sensor_pdata.y_mm;
+	}
+
+	if (sensor->sensor_type =3D=3D rmi_sensor_default)
+		sensor->sensor_type =3D
+			f11->sensor_pdata.sensor_type;
+
+	sensor->report_abs =3D sensor->report_abs
+		&& !(f11->sensor_pdata.disable_report_mask
+			& RMI_F11_DISABLE_ABS_REPORT);
+
+	if (!sensor->report_abs)
+		/*
+		 * If device doesn't have abs or if it has been disables
+		 * fallback to reporting rel data.
+		 */
+		sensor->report_rel =3D f11->sens_query.has_rel;
+
+	rc =3D rmi_read_block(rmi_dev,
+		control_base_addr + F11_CTRL_SENSOR_MAX_X_POS_OFFSET,
+		(u8 *)&max_x_pos, sizeof(max_x_pos));
+	if (rc < 0)
+		return rc;
+
+	rc =3D rmi_read_block(rmi_dev,
+		control_base_addr + F11_CTRL_SENSOR_MAX_Y_POS_OFFSET,
+		(u8 *)&max_y_pos, sizeof(max_y_pos));
+	if (rc < 0)
+		return rc;
+
+	sensor->max_x =3D max_x_pos;
+	sensor->max_y =3D max_y_pos;
+
+	rc =3D f11_2d_construct_data(f11);
+	if (rc < 0)
+		return rc;
+
+	if (f11->has_acm)
+		f11->sensor.attn_size +=3D f11->sensor.nbr_fingers * 2;
+
+	/* allocate the in-kernel tracking buffers */
+	sensor->tracking_pos =3D devm_kzalloc(&fn->dev,
+			sizeof(struct input_mt_pos) * sensor->nbr_fingers,
+			GFP_KERNEL);
+	sensor->tracking_slots =3D devm_kzalloc(&fn->dev,
+			sizeof(int) * sensor->nbr_fingers, GFP_KERNEL);
+	sensor->objs =3D devm_kzalloc(&fn->dev,
+			sizeof(struct rmi_2d_sensor_abs_object)
+			* sensor->nbr_fingers, GFP_KERNEL);
+	if (!sensor->tracking_pos || !sensor->tracking_slots || !sensor->objs=
)
+		return -ENOMEM;
+
+	ctrl =3D &f11->dev_controls;
+	if (sensor->axis_align.delta_x_threshold)
+		ctrl->ctrl0_11[RMI_F11_DELTA_X_THRESHOLD] =3D
+			sensor->axis_align.delta_x_threshold;
+
+	if (sensor->axis_align.delta_y_threshold)
+		ctrl->ctrl0_11[RMI_F11_DELTA_Y_THRESHOLD] =3D
+			sensor->axis_align.delta_y_threshold;
+
+	if (f11->sens_query.has_dribble)
+		ctrl->ctrl0_11[0] =3D ctrl->ctrl0_11[0] & ~BIT(6);
+
+	if (f11->sens_query.has_palm_det)
+		ctrl->ctrl0_11[11] =3D ctrl->ctrl0_11[11] & ~BIT(0);
+
+	rc =3D f11_write_control_regs(fn, &f11->sens_query,
+			   &f11->dev_controls, fn->fd.query_base_addr);
+	if (rc)
+		dev_warn(&fn->dev, "Failed to write control registers\n");
+
+	mutex_init(&f11->dev_controls_mutex);
+
+	dev_set_drvdata(&fn->dev, f11);
+
+	return 0;
+}
+
+static int rmi_f11_config(struct rmi_function *fn)
+{
+	struct f11_data *f11 =3D dev_get_drvdata(&fn->dev);
+	struct rmi_driver *drv =3D fn->rmi_dev->driver;
+	struct rmi_2d_sensor *sensor =3D &f11->sensor;
+	int rc;
+
+	if (!sensor->report_abs)
+		drv->clear_irq_bits(fn->rmi_dev, f11->abs_mask);
+	else
+		drv->set_irq_bits(fn->rmi_dev, f11->abs_mask);
+
+	if (!sensor->report_rel)
+		drv->clear_irq_bits(fn->rmi_dev, f11->rel_mask);
+	else
+		drv->set_irq_bits(fn->rmi_dev, f11->rel_mask);
+
+	rc =3D f11_write_control_regs(fn, &f11->sens_query,
+			   &f11->dev_controls, fn->fd.query_base_addr);
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+static int rmi_f11_attention(struct rmi_function *fn, unsigned long *i=
rq_bits)
+{
+	struct rmi_device *rmi_dev =3D fn->rmi_dev;
+	struct rmi_driver_data *drvdata =3D dev_get_drvdata(&rmi_dev->dev);
+	struct f11_data *f11 =3D dev_get_drvdata(&fn->dev);
+	u16 data_base_addr =3D fn->fd.data_base_addr;
+	u16 data_base_addr_offset =3D 0;
+	int error;
+
+	if (rmi_dev->xport->attn_data) {
+		memcpy(f11->sensor.data_pkt, rmi_dev->xport->attn_data,
+			f11->sensor.attn_size);
+		rmi_dev->xport->attn_data +=3D f11->sensor.attn_size;
+		rmi_dev->xport->attn_size -=3D f11->sensor.attn_size;
+	} else {
+		error =3D rmi_read_block(rmi_dev,
+				data_base_addr + data_base_addr_offset,
+				f11->sensor.data_pkt,
+				f11->sensor.pkt_size);
+		if (error < 0)
+			return error;
+	}
+
+	rmi_f11_finger_handler(f11, &f11->sensor, irq_bits,
+				drvdata->num_of_irq_regs);
+	data_base_addr_offset +=3D f11->sensor.pkt_size;
+
+	return 0;
+}
+
+static int rmi_f11_resume(struct rmi_function *fn)
+{
+	struct f11_data *f11 =3D dev_get_drvdata(&fn->dev);
+	int error;
+
+	rmi_dbg(RMI_DEBUG_FN, &fn->dev, "Resuming...\n");
+	if (!f11->rezero_wait_ms)
+		return 0;
+
+	mdelay(f11->rezero_wait_ms);
+
+	error =3D rmi_write(fn->rmi_dev, fn->fd.command_base_addr,
+				RMI_F11_REZERO);
+	if (error) {
+		dev_err(&fn->dev,
+			"%s: failed to issue rezero command, error =3D %d.",
+			__func__, error);
+		return error;
+	}
+
+	return 0;
+}
+
+static int rmi_f11_probe(struct rmi_function *fn)
+{
+	int error;
+	struct f11_data *f11;
+
+	error =3D rmi_f11_initialize(fn);
+	if (error)
+		return error;
+
+	f11 =3D dev_get_drvdata(&fn->dev);
+	error =3D rmi_2d_sensor_configure_input(fn, &f11->sensor);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+struct rmi_function_handler rmi_f11_handler =3D {
+	.driver =3D {
+		.name	=3D "rmi4_f11",
+	},
+	.func		=3D 0x11,
+	.probe		=3D rmi_f11_probe,
+	.config		=3D rmi_f11_config,
+	.attention	=3D rmi_f11_attention,
+	.resume		=3D rmi_f11_resume,
+};
diff --git a/include/linux/rmi.h b/include/linux/rmi.h
index c748fa3..b527064 100644
--- a/include/linux/rmi.h
+++ b/include/linux/rmi.h
@@ -20,6 +20,88 @@
 #define NAME_BUFFER_SIZE 256
=20
 /**
+ * struct rmi_2d_axis_alignment - target axis alignment
+ * @swap_axes: set to TRUE if desired to swap x- and y-axis
+ * @flip_x: set to TRUE if desired to flip direction on x-axis
+ * @flip_y: set to TRUE if desired to flip direction on y-axis
+ * @clip_x_low - reported X coordinates below this setting will be cli=
pped to
+ *               the specified value
+ * @clip_x_high - reported X coordinates above this setting will be cl=
ipped to
+ *               the specified value
+ * @clip_y_low - reported Y coordinates below this setting will be cli=
pped to
+ *               the specified value
+ * @clip_y_high - reported Y coordinates above this setting will be cl=
ipped to
+ *               the specified value
+ * @offset_x - this value will be added to all reported X coordinates
+ * @offset_y - this value will be added to all reported Y coordinates
+ * @rel_report_enabled - if set to true, the relative reporting will b=
e
+ *               automatically enabled for this sensor.
+ */
+struct rmi_2d_axis_alignment {
+	bool swap_axes;
+	bool flip_x;
+	bool flip_y;
+	u16 clip_x_low;
+	u16 clip_y_low;
+	u16 clip_x_high;
+	u16 clip_y_high;
+	u16 offset_x;
+	u16 offset_y;
+	u8 delta_x_threshold;
+	u8 delta_y_threshold;
+};
+
+/** This is used to override any hints an F11 2D sensor might have pro=
vided
+ * as to what type of sensor it is.
+ *
+ * @rmi_f11_sensor_default - do not override, determine from F11_2D_QU=
ERY14 if
+ * available.
+ * @rmi_f11_sensor_touchscreen - treat the sensor as a touchscreen (di=
rect
+ * pointing).
+ * @rmi_f11_sensor_touchpad - thread the sensor as a touchpad (indirec=
t
+ * pointing).
+ */
+enum rmi_sensor_type {
+	rmi_sensor_default =3D 0,
+	rmi_sensor_touchscreen,
+	rmi_sensor_touchpad
+};
+
+#define RMI_F11_DISABLE_ABS_REPORT      BIT(0)
+
+/**
+ * struct rmi_2d_sensor_data - overrides defaults for a 2D sensor.
+ * @axis_align - provides axis alignment overrides (see above).
+ * @sensor_type - Forces the driver to treat the sensor as an indirect
+ * pointing device (touchpad) rather than a direct pointing device
+ * (touchscreen).  This is useful when F11_2D_QUERY14 register is not
+ * available.
+ * @disable_report_mask - Force data to not be reported even if it is =
supported
+ * by the firware.
+ * @topbuttonpad - Used with the "5 buttons touchpads" found on the Le=
novo 40
+ * series
+ * @kernel_tracking - most moderns RMI f11 firmwares implement Multifi=
nger
+ * Type B protocol. However, there are some corner cases where the use=
r
+ * triggers some jumps by tapping with two fingers on the touchpad.
+ * Use this setting and dmax to filter out these jumps.
+ * Also, when using an old sensor using MF Type A behavior, set to tru=
e to
+ * report an actual MT protocol B.
+ * @dmax - the maximum distance (in sensor units) the kernel tracking =
allows two
+ * distincts fingers to be considered the same.
+ */
+struct rmi_2d_sensor_platform_data {
+	struct rmi_2d_axis_alignment axis_align;
+	enum rmi_sensor_type sensor_type;
+	int x_mm;
+	int y_mm;
+	int disable_report_mask;
+	u16 rezero_wait;
+	bool topbuttonpad;
+	bool kernel_tracking;
+	int dmax;
+};
+
+/**
  * struct rmi_f01_power - override default power management settings.
  *
  */
@@ -63,6 +145,7 @@ struct rmi_device_platform_data {
 	int reset_delay_ms;
=20
 	/* function handler pdata */
+	struct rmi_2d_sensor_platform_data *sensor_pdata;
 	struct rmi_f01_power_management power_management;
 };
=20
--=20
2.5.0
