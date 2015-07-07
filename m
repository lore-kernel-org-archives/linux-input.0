From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] Input: of_touchscreen - switch to using device properties
Date: Mon,  6 Jul 2015 17:27:29 -0700
Message-ID: <1436228849-29530-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1436228849-29530-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:36310 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756281AbbGGA1x (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 20:27:53 -0400
In-Reply-To: <1436228849-29530-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org

Let's switch form OF to device properties so that common parsing code could
work not only on device tree but also on ACPI-based platforms.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/Kconfig          |  4 +--
 drivers/input/touchscreen/Makefile         |  2 +-
 drivers/input/touchscreen/edt-ft5x06.c     |  2 +-
 drivers/input/touchscreen/of_touchscreen.c | 56 ++++++++++++++++--------------
 drivers/input/touchscreen/tsc2005.c        |  2 +-
 include/linux/input/touchscreen.h          | 11 ++----
 6 files changed, 37 insertions(+), 40 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 2dc9d62..38d0f99 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -11,9 +11,9 @@ menuconfig INPUT_TOUCHSCREEN
 
 if INPUT_TOUCHSCREEN
 
-config OF_TOUCHSCREEN
+config TOUCHSCREEN_PROPERTIES
 	def_tristate INPUT
-	depends on INPUT && OF
+	depends on INPUT
 
 config TOUCHSCREEN_88PM860X
 	tristate "Marvell 88PM860x touchscreen"
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index fa3d33b..c85aae2 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -6,7 +6,7 @@
 
 wm97xx-ts-y := wm97xx-core.o
 
-obj-$(CONFIG_OF_TOUCHSCREEN)		+= of_touchscreen.o
+obj-$(CONFIG_TOUCHSCREEN_PROPERTIES)	+= of_touchscreen.o
 obj-$(CONFIG_TOUCHSCREEN_88PM860X)	+= 88pm860x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_AD7877)	+= ad7877.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879)	+= ad7879.o
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 394b1de..8f8f319 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -1041,7 +1041,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 			     0, tsdata->num_y * 64 - 1, 0, 0);
 
 	if (!pdata)
-		touchscreen_parse_of_params(input, true);
+		touchscreen_parse_properties(input, true);
 
 	error = input_mt_init_slots(input, MAX_SUPPORT_POINTS, INPUT_MT_DIRECT);
 	if (error) {
diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
index 50bc0f2..bb6f2fe 100644
--- a/drivers/input/touchscreen/of_touchscreen.c
+++ b/drivers/input/touchscreen/of_touchscreen.c
@@ -9,12 +9,12 @@
  *
  */
 
-#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
 
-static bool touchscreen_get_prop_u32(struct device_node *np,
+static bool touchscreen_get_prop_u32(struct device *dev,
 				     const char *property,
 				     unsigned int default_value,
 				     unsigned int *value)
@@ -22,7 +22,7 @@ static bool touchscreen_get_prop_u32(struct device_node *np,
 	u32 val;
 	int error;
 
-	error = of_property_read_u32(np, property, &val);
+	error = device_property_read_u32(dev, property, &val);
 	if (error) {
 		*value = default_value;
 		return false;
@@ -51,54 +51,58 @@ static void touchscreen_set_params(struct input_dev *dev,
 }
 
 /**
- * touchscreen_parse_of_params - parse common touchscreen DT properties
- * @dev: device that should be parsed
+ * touchscreen_parse_properties - parse common touchscreen DT properties
+ * @input: input device that should be parsed
+ * @multitouch: specifies whether parsed properties should be applied to
+ *	single-touch or multi-touch axes
  *
  * This function parses common DT properties for touchscreens and setups the
- * input device accordingly. The function keeps previously setuped default
+ * input device accordingly. The function keeps previously set up default
  * values if no value is specified via DT.
  */
-void touchscreen_parse_of_params(struct input_dev *dev, bool multitouch)
+void touchscreen_parse_properties(struct input_dev *input, bool multitouch)
 {
-	struct device_node *np = dev->dev.parent->of_node;
+	struct device *dev = input->dev.parent;
 	unsigned int axis;
 	unsigned int maximum, fuzz;
 	bool data_present;
 
-	input_alloc_absinfo(dev);
-	if (!dev->absinfo)
+	input_alloc_absinfo(input);
+	if (!input->absinfo)
 		return;
 
 	axis = multitouch ? ABS_MT_POSITION_X : ABS_X;
-	data_present = touchscreen_get_prop_u32(np, "touchscreen-size-x",
-						input_abs_get_max(dev,
+	data_present = touchscreen_get_prop_u32(dev, "touchscreen-size-x",
+						input_abs_get_max(input,
 								  axis) + 1,
 						&maximum) |
-		       touchscreen_get_prop_u32(np, "touchscreen-fuzz-x",
-						input_abs_get_fuzz(dev, axis),
+		       touchscreen_get_prop_u32(dev, "touchscreen-fuzz-x",
+						input_abs_get_fuzz(input, axis),
 						&fuzz);
 	if (data_present)
-		touchscreen_set_params(dev, axis, maximum - 1, fuzz);
+		touchscreen_set_params(input, axis, maximum - 1, fuzz);
 
 	axis = multitouch ? ABS_MT_POSITION_Y : ABS_Y;
-	data_present = touchscreen_get_prop_u32(np, "touchscreen-size-y",
-						input_abs_get_max(dev,
+	data_present = touchscreen_get_prop_u32(dev, "touchscreen-size-y",
+						input_abs_get_max(input,
 								  axis) + 1,
 						&maximum) |
-		       touchscreen_get_prop_u32(np, "touchscreen-fuzz-y",
-						input_abs_get_fuzz(dev, axis),
+		       touchscreen_get_prop_u32(dev, "touchscreen-fuzz-y",
+						input_abs_get_fuzz(input, axis),
 						&fuzz);
 	if (data_present)
-		touchscreen_set_params(dev, axis, maximum - 1, fuzz);
+		touchscreen_set_params(input, axis, maximum - 1, fuzz);
 
 	axis = multitouch ? ABS_MT_PRESSURE : ABS_PRESSURE;
-	data_present = touchscreen_get_prop_u32(np, "touchscreen-max-pressure",
-						input_abs_get_max(dev, axis),
+	data_present = touchscreen_get_prop_u32(dev,
+						"touchscreen-max-pressure",
+						input_abs_get_max(input, axis),
 						&maximum) |
-		       touchscreen_get_prop_u32(np, "touchscreen-fuzz-pressure",
-						input_abs_get_fuzz(dev, axis),
+		       touchscreen_get_prop_u32(dev,
+						"touchscreen-fuzz-pressure",
+						input_abs_get_fuzz(input, axis),
 						&fuzz);
 	if (data_present)
-		touchscreen_set_params(dev, axis, maximum, fuzz);
+		touchscreen_set_params(input, axis, maximum, fuzz);
 }
-EXPORT_SYMBOL(touchscreen_parse_of_params);
+EXPORT_SYMBOL(touchscreen_parse_properties);
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index d8c025b..aaf94752 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -709,7 +709,7 @@ static int tsc2005_probe(struct spi_device *spi)
 	input_set_abs_params(input_dev, ABS_PRESSURE, 0, max_p, fudge_p, 0);
 
 	if (np)
-		touchscreen_parse_of_params(input_dev, false);
+		touchscreen_parse_properties(input_dev, false);
 
 	input_dev->open = tsc2005_open;
 	input_dev->close = tsc2005_close;
diff --git a/include/linux/input/touchscreen.h b/include/linux/input/touchscreen.h
index eecc9ea..c91e137 100644
--- a/include/linux/input/touchscreen.h
+++ b/include/linux/input/touchscreen.h
@@ -9,15 +9,8 @@
 #ifndef _TOUCHSCREEN_H
 #define _TOUCHSCREEN_H
 
-#include <linux/input.h>
+struct input_dev;
 
-#ifdef CONFIG_OF
-void touchscreen_parse_of_params(struct input_dev *dev, bool multitouch);
-#else
-static inline void touchscreen_parse_of_params(struct input_dev *dev,
-					       bool multitouch)
-{
-}
-#endif
+void touchscreen_parse_properties(struct input_dev *dev, bool multitouch);
 
 #endif
-- 
2.4.3.573.g4eafbef

