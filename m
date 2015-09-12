From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/6] Input: edt-ft5x06 - remove support for platform data
Date: Sat, 12 Sep 2015 10:45:48 -0700
Message-ID: <0b648019602e53913f48e81c7879d714e41ef465.1442079408.git.dmitry.torokhov@gmail.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
In-Reply-To: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-input@vger.kernel.org

We do not have any users of platform data in the tree and all newer
platforms are either DT or ACPI, so let's drop handling of platform data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/edt-ft5x06.c | 41 ++++------------------------------
 include/linux/input/edt-ft5x06.h       | 21 -----------------
 2 files changed, 4 insertions(+), 58 deletions(-)
 delete mode 100644 include/linux/input/edt-ft5x06.h

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index df76f19..134c66c 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -37,7 +37,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/input/mt.h>
 #include <linux/input/touchscreen.h>
-#include <linux/input/edt-ft5x06.h>
 
 #define MAX_SUPPORT_POINTS		5
 
@@ -809,21 +808,14 @@ static int edt_ft5x06_ts_identify(struct i2c_client *client,
 	return 0;
 }
 
-#define EDT_ATTR_CHECKSET(name, reg) \
-do {								\
-	if (pdata->name >= edt_ft5x06_attr_##name.limit_low &&		\
-	    pdata->name <= edt_ft5x06_attr_##name.limit_high)		\
-		edt_ft5x06_register_write(tsdata, reg, pdata->name);	\
-} while (0)
-
 #define EDT_GET_PROP(name, reg) {				\
 	u32 val;						\
 	if (of_property_read_u32(np, #name, &val) == 0)		\
 		edt_ft5x06_register_write(tsdata, reg, val);	\
 }
 
-static void edt_ft5x06_ts_get_dt_defaults(struct device_node *np,
-					struct edt_ft5x06_ts_data *tsdata)
+static void edt_ft5x06_ts_get_defaults(struct device_node *np,
+				       struct edt_ft5x06_ts_data *tsdata)
 {
 	struct edt_reg_addr *reg_addr = &tsdata->reg_addr;
 
@@ -833,23 +825,6 @@ static void edt_ft5x06_ts_get_dt_defaults(struct device_node *np,
 }
 
 static void
-edt_ft5x06_ts_get_defaults(struct edt_ft5x06_ts_data *tsdata,
-			   const struct edt_ft5x06_platform_data *pdata)
-{
-	struct edt_reg_addr *reg_addr = &tsdata->reg_addr;
-
-	if (!pdata->use_parameters)
-		return;
-
-	/* pick up defaults from the platform data */
-	EDT_ATTR_CHECKSET(threshold, reg_addr->reg_threshold);
-	EDT_ATTR_CHECKSET(gain, reg_addr->reg_gain);
-	EDT_ATTR_CHECKSET(offset, reg_addr->reg_offset);
-	if (reg_addr->reg_report_rate != NO_REGISTER)
-		EDT_ATTR_CHECKSET(report_rate, reg_addr->reg_report_rate);
-}
-
-static void
 edt_ft5x06_ts_get_parameters(struct edt_ft5x06_ts_data *tsdata)
 {
 	struct edt_reg_addr *reg_addr = &tsdata->reg_addr;
@@ -893,8 +868,6 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
 static int edt_ft5x06_ts_probe(struct i2c_client *client,
 					 const struct i2c_device_id *id)
 {
-	const struct edt_ft5x06_platform_data *pdata =
-						dev_get_platdata(&client->dev);
 	struct edt_ft5x06_ts_data *tsdata;
 	struct input_dev *input;
 	int error;
@@ -955,12 +928,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	}
 
 	edt_ft5x06_ts_set_regs(tsdata);
-
-	if (!pdata)
-		edt_ft5x06_ts_get_dt_defaults(client->dev.of_node, tsdata);
-	else
-		edt_ft5x06_ts_get_defaults(tsdata, pdata);
-
+	edt_ft5x06_ts_get_defaults(client->dev.of_node, tsdata);
 	edt_ft5x06_ts_get_parameters(tsdata);
 
 	dev_dbg(&client->dev,
@@ -976,8 +944,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	input_set_abs_params(input, ABS_MT_POSITION_Y,
 			     0, tsdata->num_y * 64 - 1, 0, 0);
 
-	if (!pdata)
-		touchscreen_parse_properties(input, true);
+	touchscreen_parse_properties(input, true);
 
 	error = input_mt_init_slots(input, MAX_SUPPORT_POINTS, INPUT_MT_DIRECT);
 	if (error) {
diff --git a/include/linux/input/edt-ft5x06.h b/include/linux/input/edt-ft5x06.h
deleted file mode 100644
index 5ca5b4c..0000000
--- a/include/linux/input/edt-ft5x06.h
+++ /dev/null
@@ -1,21 +0,0 @@
-#ifndef _EDT_FT5X06_H
-#define _EDT_FT5X06_H
-
-/*
- * Copyright (c) 2012 Simon Budig, <simon.budig@kernelconcepts.de>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- */
-
-struct edt_ft5x06_platform_data {
-	/* startup defaults for operational parameters */
-	bool use_parameters;
-	u8 gain;
-	u8 threshold;
-	u8 offset;
-	u8 report_rate;
-};
-
-#endif /* _EDT_FT5X06_H */
-- 
2.6.0.rc0.131.gf624c3d
