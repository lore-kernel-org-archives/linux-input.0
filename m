From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 1/4] of_touchscreen-helpers: Add support for inverted / swapped axis
Date: Wed, 27 Jan 2016 19:25:21 +0100
Message-ID: <1453919124-3840-2-git-send-email-hdegoede@redhat.com>
References: <1453919124-3840-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54940 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935214AbcA0SZh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2016 13:25:37 -0500
In-Reply-To: <1453919124-3840-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

Extend touchscreen_parse_properties() with support for the
touchscreen-inverted-x/y and touchscreen-swapped-x-y properties and
add a touchscreen_apply_prop_to_x_y() helper function for adjusting
x and y coordinates to take these properties into account.

This commit also modifies the existing callers of
touchscreen_parse_properties() to pass in NULL for the new third
argument, keeping the existing behavior.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/touchscreen/edt-ft5x06.c     |  2 +-
 drivers/input/touchscreen/of_touchscreen.c | 56 +++++++++++++++++++++++++++++-
 drivers/input/touchscreen/pixcir_i2c_ts.c  |  2 +-
 drivers/input/touchscreen/tsc200x-core.c   |  2 +-
 include/linux/input/touchscreen.h          | 16 ++++++++-
 5 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 0b0f8c1..a97b54a 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -966,7 +966,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	input_set_abs_params(input, ABS_MT_POSITION_Y,
 			     0, tsdata->num_y * 64 - 1, 0, 0);
 
-	touchscreen_parse_properties(input, true);
+	touchscreen_parse_properties(input, true, NULL);
 
 	error = input_mt_init_slots(input, tsdata->max_support_points,
 				INPUT_MT_DIRECT);
diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
index bb6f2fe..6fd9872 100644
--- a/drivers/input/touchscreen/of_touchscreen.c
+++ b/drivers/input/touchscreen/of_touchscreen.c
@@ -55,12 +55,16 @@ static void touchscreen_set_params(struct input_dev *dev,
  * @input: input device that should be parsed
  * @multitouch: specifies whether parsed properties should be applied to
  *	single-touch or multi-touch axes
+ * @prop: pointer to a struct touchscreen_properties into which to store
+ *	axis swap and invert info for use with touchscreen_report_x_y();
+ *	or NULL
  *
  * This function parses common DT properties for touchscreens and setups the
  * input device accordingly. The function keeps previously set up default
  * values if no value is specified via DT.
  */
-void touchscreen_parse_properties(struct input_dev *input, bool multitouch)
+void touchscreen_parse_properties(struct input_dev *input, bool multitouch,
+				  struct touchscreen_properties *prop)
 {
 	struct device *dev = input->dev.parent;
 	unsigned int axis;
@@ -104,5 +108,55 @@ void touchscreen_parse_properties(struct input_dev *input, bool multitouch)
 						&fuzz);
 	if (data_present)
 		touchscreen_set_params(input, axis, maximum, fuzz);
+
+	if (!prop)
+		return;
+
+	axis = multitouch ? ABS_MT_POSITION_X : ABS_X;
+
+	prop->max_x = input_abs_get_max(input, axis);
+	prop->max_y = input_abs_get_max(input, axis + 1);
+	prop->invert_x =
+		device_property_read_bool(dev, "touchscreen-inverted-x");
+	prop->invert_y =
+		device_property_read_bool(dev, "touchscreen-inverted-y");
+	prop->swap_x_y =
+		device_property_read_bool(dev, "touchscreen-swapped-x-y");
+
+	if (prop->swap_x_y) {
+		struct input_absinfo tmp_absinfo;
+
+		tmp_absinfo = input->absinfo[axis];
+		input->absinfo[axis] = input->absinfo[axis + 1];
+		input->absinfo[axis + 1] = tmp_absinfo;
+	}
 }
 EXPORT_SYMBOL(touchscreen_parse_properties);
+
+/**
+ * touchscreen_apply_prop_to_x_y - Adjust abs x and y coordinates
+ * @prop: pointer to a struct touchscreen_properties
+ * @x: X coordinate to apply inversion and swapping to
+ * @y: Y coordinate to apply inversion and swapping to
+ *
+ * Adjust the passed in x and y values applying any axis inversion and
+ * swapping requested in the passed in touchscreen_properties.
+ */
+void touchscreen_apply_prop_to_x_y(struct touchscreen_properties *prop,
+				   s16 *x, s16 *y)
+{
+	if (prop->invert_x)
+		*x = prop->max_x - *x;
+
+	if (prop->invert_y)
+		*y = prop->max_y - *y;
+
+	if (prop->swap_x_y) {
+		s16 tmp;
+
+		tmp = *x;
+		*x = *y;
+		*y = tmp;
+	}
+}
+EXPORT_SYMBOL(touchscreen_apply_prop_to_x_y);
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 09523a3..f58784d 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -515,7 +515,7 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 	} else {
 		input_set_capability(input, EV_ABS, ABS_MT_POSITION_X);
 		input_set_capability(input, EV_ABS, ABS_MT_POSITION_Y);
-		touchscreen_parse_properties(input, true);
+		touchscreen_parse_properties(input, true, NULL);
 		if (!input_abs_get_max(input, ABS_MT_POSITION_X) ||
 		    !input_abs_get_max(input, ABS_MT_POSITION_Y)) {
 			dev_err(dev, "Touchscreen size is not specified\n");
diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index 15240c1..26e81d1 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -559,7 +559,7 @@ int tsc200x_probe(struct device *dev, int irq, __u16 bustype,
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, max_p, fudge_p, 0);
 
 	if (np)
-		touchscreen_parse_properties(input_dev, false);
+		touchscreen_parse_properties(input_dev, false, NULL);
 
 	input_dev->open = tsc200x_open;
 	input_dev->close = tsc200x_close;
diff --git a/include/linux/input/touchscreen.h b/include/linux/input/touchscreen.h
index c91e137..9e6ba20 100644
--- a/include/linux/input/touchscreen.h
+++ b/include/linux/input/touchscreen.h
@@ -9,8 +9,22 @@
 #ifndef _TOUCHSCREEN_H
 #define _TOUCHSCREEN_H
 
+#include <asm/types.h>
+
 struct input_dev;
 
-void touchscreen_parse_properties(struct input_dev *dev, bool multitouch);
+struct touchscreen_properties {
+	s32 max_x;
+	s32 max_y;
+	bool invert_x;
+	bool invert_y;
+	bool swap_x_y;
+};
+
+void touchscreen_parse_properties(struct input_dev *input, bool multitouch,
+				  struct touchscreen_properties *prop);
+
+void touchscreen_apply_prop_to_x_y(struct touchscreen_properties *prop,
+				   s16 *x, s16 *y);
 
 #endif
-- 
2.5.0

