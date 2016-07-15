From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 1/4] of_touchscreen-helpers: Add support for inverted / swapped axis
Date: Fri, 15 Jul 2016 15:48:08 +0200
Message-ID: <1468590491-10269-2-git-send-email-hdegoede@redhat.com>
References: <1468590491-10269-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59370 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751758AbcGONsR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jul 2016 09:48:17 -0400
In-Reply-To: <1468590491-10269-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Extend touchscreen_parse_properties() with support for the
touchscreen-inverted-x/y and touchscreen-swapped-x-y properties and
add touchscreen_set_mt_pos() and touchscreen_report_pos() helper
functions for storing coordinates into a input_mt_pos struct, or
directly reporting them, taking these properties into account.

This commit also modifies the existing callers of
touchscreen_parse_properties() to pass in NULL for the new third
argument, keeping the existing behavior.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-No changes
Changes in v3:
-Add touchscreen_set_mt_pos / touchscreen_report_pos helpers replacing
 the touchscreen_apply_properties helper
Changes in v4:
-Also add extra NULL parameter to touchscreen_parse_properties() calls
 in ad7879.c and cyttsp_core.c
---
 drivers/input/touchscreen/ad7879.c         |  2 +-
 drivers/input/touchscreen/cyttsp_core.c    |  2 +-
 drivers/input/touchscreen/edt-ft5x06.c     |  2 +-
 drivers/input/touchscreen/of_touchscreen.c | 91 +++++++++++++++++++++++++++++-
 drivers/input/touchscreen/pixcir_i2c_ts.c  |  2 +-
 drivers/input/touchscreen/tsc200x-core.c   |  2 +-
 include/linux/input/touchscreen.h          | 20 ++++++-
 7 files changed, 114 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index e4bf110..e16a446 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -595,7 +595,7 @@ struct ad7879 *ad7879_probe(struct device *dev, u8 devid, unsigned int irq,
 	} else {
 		input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0, 0);
 		input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
-		touchscreen_parse_properties(input_dev, false);
+		touchscreen_parse_properties(input_dev, false, NULL);
 		if (!input_abs_get_max(input_dev, ABS_PRESSURE)) {
 			dev_err(dev, "Touchscreen pressure is not specified\n");
 			return ERR_PTR(-EINVAL);
diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
index 91cda8f..79381cc 100644
--- a/drivers/input/touchscreen/cyttsp_core.c
+++ b/drivers/input/touchscreen/cyttsp_core.c
@@ -657,7 +657,7 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
 
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
 	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
-	touchscreen_parse_properties(input_dev, true);
+	touchscreen_parse_properties(input_dev, true, NULL);
 
 	error = input_mt_init_slots(input_dev, CY_MAX_ID, 0);
 	if (error) {
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
index bb6f2fe..26357b4 100644
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
@@ -104,5 +108,90 @@ void touchscreen_parse_properties(struct input_dev *input, bool multitouch)
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
+static void touchscreen_apply_prop_to_x_y(
+	const struct touchscreen_properties *prop,
+	unsigned int *x, unsigned int *y)
+{
+	if (prop->invert_x)
+		*x = prop->max_x - *x;
+
+	if (prop->invert_y)
+		*y = prop->max_y - *y;
+
+	if (prop->swap_x_y) {
+		unsigned int tmp;
+
+		tmp = *x;
+		*x = *y;
+		*y = tmp;
+	}
+}
+
+/**
+ * touchscreen_set_mt_pos - Set input_mt_pos coordinates
+ * @pos: input_mt_pos to set coordinates of
+ * @prop: pointer to a struct touchscreen_properties
+ * @x: X coordinate to store in pos
+ * @y: Y coordinate to store in pos
+ *
+ * Adjust the passed in x and y values applying any axis inversion and
+ * swapping requested in the passed in touchscreen_properties and store
+ * the result in a struct input_mt_pos.
+ */
+void touchscreen_set_mt_pos(struct input_mt_pos *pos,
+			    const struct touchscreen_properties *prop,
+			    unsigned int x, unsigned int y)
+{
+	touchscreen_apply_prop_to_x_y(prop, &x, &y);
+	pos->x = x;
+	pos->y = y;
+}
+EXPORT_SYMBOL(touchscreen_set_mt_pos);
+
+/**
+ * touchscreen_report_pos - Report touchscreen coordinates
+ * @input: input_device to report coordinates for
+ * @prop: pointer to a struct touchscreen_properties
+ * @x: X coordinate to report
+ * @y: Y coordinate to report
+ * @multitouch: Report coordinates on single-touch or multi-touch axes
+ *
+ * Adjust the passed in x and y values applying any axis inversion and
+ * swapping requested in the passed in touchscreen_properties and then
+ * report the resulting coordinates on the input_dev's x and y axis.
+ */
+void touchscreen_report_pos(struct input_dev *input,
+			    const struct touchscreen_properties *prop,
+			    unsigned int x, unsigned int y,
+			    bool multitouch)
+{
+	touchscreen_apply_prop_to_x_y(prop, &x, &y);
+	input_report_abs(input, multitouch ? ABS_MT_POSITION_X : ABS_X, x);
+	input_report_abs(input, multitouch ? ABS_MT_POSITION_Y : ABS_Y, y);
+}
+EXPORT_SYMBOL(touchscreen_report_pos);
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
index c91e137..f07c39c 100644
--- a/include/linux/input/touchscreen.h
+++ b/include/linux/input/touchscreen.h
@@ -11,6 +11,24 @@
 
 struct input_dev;
 
-void touchscreen_parse_properties(struct input_dev *dev, bool multitouch);
+struct touchscreen_properties {
+	unsigned int max_x;
+	unsigned int max_y;
+	bool invert_x;
+	bool invert_y;
+	bool swap_x_y;
+};
+
+void touchscreen_parse_properties(struct input_dev *input, bool multitouch,
+				  struct touchscreen_properties *prop);
+
+void touchscreen_set_mt_pos(struct input_mt_pos *pos,
+			    const struct touchscreen_properties *prop,
+			    unsigned int x, unsigned int y);
+
+void touchscreen_report_pos(struct input_dev *input,
+			    const struct touchscreen_properties *prop,
+			    unsigned int x, unsigned int y,
+			    bool multitouch);
 
 #endif
-- 
2.7.4

