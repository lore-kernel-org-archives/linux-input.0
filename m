From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] Input: tsc2004/5 - switch to using generic device properties
Date: Fri, 10 Feb 2017 16:06:23 -0800
Message-ID: <20170211000623.33663-3-dmitry.torokhov@gmail.com>
References: <20170211000623.33663-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170211000623.33663-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Michael Welling <mwelling@ieee.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Instead of supporting legacy platform data (of which we have no mainline
users) and OF-based properties, let's switch to generic device properties.
This will still allow legacy boards to use the driver (by defining property
sets and attaching them to the drivers) and will simplify probe and make
driver usable on ACPI-based systems as well.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc200x-core.c | 93 +++++++++++---------------------
 include/linux/spi/tsc2005.h              | 34 ------------
 2 files changed, 30 insertions(+), 97 deletions(-)
 delete mode 100644 include/linux/spi/tsc2005.h

diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index 1c14a38e3748..88ea5e1b72ae 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -27,7 +27,6 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/of.h>
-#include <linux/spi/tsc2005.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regmap.h>
 #include <linux/gpio/consumer.h>
@@ -114,7 +113,6 @@ struct tsc200x {
 	struct regulator	*vio;
 
 	struct gpio_desc	*reset_gpio;
-	void			(*set_reset)(bool enable);
 	int			(*tsc200x_cmd)(struct device *dev, u8 cmd);
 	int			irq;
 };
@@ -227,12 +225,13 @@ static void tsc200x_stop_scan(struct tsc200x *ts)
 	ts->tsc200x_cmd(ts->dev, TSC200X_CMD_STOP);
 }
 
-static void tsc200x_set_reset(struct tsc200x *ts, bool enable)
+static void tsc200x_reset(struct tsc200x *ts)
 {
-	if (ts->reset_gpio)
-		gpiod_set_value_cansleep(ts->reset_gpio, enable);
-	else if (ts->set_reset)
-		ts->set_reset(enable);
+	if (ts->reset_gpio) {
+		gpiod_set_value_cansleep(ts->reset_gpio, 1);
+		usleep_range(100, 500); /* only 10us required */
+		gpiod_set_value_cansleep(ts->reset_gpio, 0);
+	}
 }
 
 /* must be called with ts->mutex held */
@@ -253,7 +252,7 @@ static void __tsc200x_enable(struct tsc200x *ts)
 {
 	tsc200x_start_scan(ts);
 
-	if (ts->esd_timeout && (ts->set_reset || ts->reset_gpio)) {
+	if (ts->esd_timeout && ts->reset_gpio) {
 		ts->last_valid_interrupt = jiffies;
 		schedule_delayed_work(&ts->esd_work,
 				round_jiffies_relative(
@@ -310,9 +309,7 @@ static ssize_t tsc200x_selftest_show(struct device *dev,
 	}
 
 	/* hardware reset */
-	tsc200x_set_reset(ts, false);
-	usleep_range(100, 500); /* only 10us required */
-	tsc200x_set_reset(ts, true);
+	tsc200x_reset(ts);
 
 	if (!success)
 		goto out;
@@ -354,7 +351,7 @@ static umode_t tsc200x_attr_is_visible(struct kobject *kobj,
 	umode_t mode = attr->mode;
 
 	if (attr == &dev_attr_selftest.attr) {
-		if (!ts->set_reset && !ts->reset_gpio)
+		if (!ts->reset_gpio)
 			mode = 0;
 	}
 
@@ -404,9 +401,7 @@ static void tsc200x_esd_work(struct work_struct *work)
 
 	tsc200x_update_pen_state(ts, 0, 0, 0);
 
-	tsc200x_set_reset(ts, false);
-	usleep_range(100, 500); /* only 10us required */
-	tsc200x_set_reset(ts, true);
+	tsc200x_reset(ts);
 
 	enable_irq(ts->irq);
 	tsc200x_start_scan(ts);
@@ -454,26 +449,12 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		  struct regmap *regmap,
 		  int (*tsc200x_cmd)(struct device *dev, u8 cmd))
 {
-	const struct tsc2005_platform_data *pdata = dev_get_platdata(dev);
-	struct device_node *np = dev->of_node;
-
 	struct tsc200x *ts;
 	struct input_dev *input_dev;
-	unsigned int max_x = MAX_12BIT;
-	unsigned int max_y = MAX_12BIT;
-	unsigned int max_p = MAX_12BIT;
-	unsigned int fudge_x = TSC200X_DEF_X_FUZZ;
-	unsigned int fudge_y = TSC200X_DEF_Y_FUZZ;
-	unsigned int fudge_p = TSC200X_DEF_P_FUZZ;
-	unsigned int x_plate_ohm = TSC200X_DEF_RESISTOR;
-	unsigned int esd_timeout;
+	u32 x_plate_ohm;
+	u32 esd_timeout;
 	int error;
 
-	if (!np && !pdata) {
-		dev_err(dev, "no platform data\n");
-		return -ENODEV;
-	}
-
 	if (irq <= 0) {
 		dev_err(dev, "no irq\n");
 		return -ENODEV;
@@ -487,23 +468,6 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		return -ENODEV;
 	}
 
-	if (pdata) {
-		fudge_x	= pdata->ts_x_fudge;
-		fudge_y	= pdata->ts_y_fudge;
-		fudge_p	= pdata->ts_pressure_fudge;
-		max_x	= pdata->ts_x_max;
-		max_y	= pdata->ts_y_max;
-		max_p	= pdata->ts_pressure_max;
-		x_plate_ohm = pdata->ts_x_plate_ohm;
-		esd_timeout = pdata->esd_timeout_ms;
-	} else {
-		x_plate_ohm = TSC200X_DEF_RESISTOR;
-		of_property_read_u32(np, "ti,x-plate-ohms", &x_plate_ohm);
-		esd_timeout = 0;
-		of_property_read_u32(np, "ti,esd-recovery-timeout-ms",
-								&esd_timeout);
-	}
-
 	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
 	if (!ts)
 		return -ENOMEM;
@@ -517,8 +481,13 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 	ts->idev = input_dev;
 	ts->regmap = regmap;
 	ts->tsc200x_cmd = tsc200x_cmd;
-	ts->x_plate_ohm = x_plate_ohm;
-	ts->esd_timeout = esd_timeout;
+
+	error = device_property_read_u32(dev, "ti,x-plate-ohms", &x_plate_ohm);
+	ts->x_plate_ohm = error ? TSC200X_DEF_RESISTOR : x_plate_ohm;
+
+	error = device_property_read_u32(dev, "ti,esd-recovery-timeout-ms",
+					 &esd_timeout);
+	ts->esd_timeout = error ? 0 : esd_timeout;
 
 	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(ts->reset_gpio)) {
@@ -534,9 +503,6 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		return error;
 	}
 
-	if (!ts->reset_gpio && pdata)
-		ts->set_reset = pdata->set_reset;
-
 	mutex_init(&ts->mutex);
 
 	spin_lock_init(&ts->lock);
@@ -559,22 +525,23 @@ int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 
 	input_dev->phys = ts->phys;
 	input_dev->id = *tsc_id;
-	input_dev->dev.parent = dev;
-	input_dev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
-	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
-
-	input_set_abs_params(input_dev, ABS_X, 0, max_x, fudge_x, 0);
-	input_set_abs_params(input_dev, ABS_Y, 0, max_y, fudge_y, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE, 0, max_p, fudge_p, 0);
-
-	if (np)
-		touchscreen_parse_properties(input_dev, false, NULL);
 
 	input_dev->open = tsc200x_open;
 	input_dev->close = tsc200x_close;
 
 	input_set_drvdata(input_dev, ts);
 
+	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
+
+	input_set_abs_params(input_dev, ABS_X,
+			     0, MAX_12BIT, TSC200X_DEF_X_FUZZ, 0);
+	input_set_abs_params(input_dev, ABS_Y,
+			     0, MAX_12BIT, TSC200X_DEF_Y_FUZZ, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE,
+			     0, MAX_12BIT, TSC200X_DEF_P_FUZZ, 0);
+
+	touchscreen_parse_properties(input_dev, false, NULL);
+
 	/* Ensure the touchscreen is off */
 	tsc200x_stop_scan(ts);
 
diff --git a/include/linux/spi/tsc2005.h b/include/linux/spi/tsc2005.h
deleted file mode 100644
index 563b3b1799a8..000000000000
--- a/include/linux/spi/tsc2005.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * This file is part of TSC2005 touchscreen driver
- *
- * Copyright (C) 2009-2010 Nokia Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
-#ifndef _LINUX_SPI_TSC2005_H
-#define _LINUX_SPI_TSC2005_H
-
-#include <linux/types.h>
-
-struct tsc2005_platform_data {
-	int		ts_pressure_max;
-	int		ts_pressure_fudge;
-	int		ts_x_max;
-	int		ts_x_fudge;
-	int		ts_y_max;
-	int		ts_y_fudge;
-	int		ts_x_plate_ohm;
-	unsigned int	esd_timeout_ms;
-	void		(*set_reset)(bool enable);
-};
-
-#endif
-- 
2.11.0.483.g087da7b7c-goog
