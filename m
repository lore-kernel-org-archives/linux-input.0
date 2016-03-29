From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH resend 1/4] of_touchscreen-helpers: Add support for inverted / swapped axis
Date: Tue, 29 Mar 2016 10:29:26 +0200
Message-ID: <1459240169-11531-2-git-send-email-hdegoede@redhat.com>
References: <1459240169-11531-1-git-send-email-hdegoede@redhat.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459240169-11531-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Extend touchscreen_parse_properties() with support for the
touchscreen-inverted-x/y and touchscreen-swapped-x-y properties and
add a touchscreen_apply_prop_to_x_y() helper function for adjusting
x and y coordinates to take these properties into account.

This commit also modifies the existing callers of
touchscreen_parse_properties() to pass in NULL for the new third
argument, keeping the existing behavior.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/input/touchscreen/edt-ft5x06.c     |  2 +-
 drivers/input/touchscreen/of_touchscreen.c | 56 +++++++++++++++++++++++++++++-
 drivers/input/touchscreen/pixcir_i2c_ts.c  |  2 +-
 drivers/input/touchscreen/tsc200x-core.c   |  2 +-
 include/linux/input/touchscreen.h          | 16 ++++++++-
 5 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 23fbe38..e8825e5 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -972,7 +972,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
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
index 15240c1..26e81d1b 100644
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
2.7.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
