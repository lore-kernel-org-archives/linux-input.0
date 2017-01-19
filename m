From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] Input: tca8418 - switch to using generic device properties
Date: Thu, 19 Jan 2017 14:48:03 -0800
Message-ID: <20170119224803.10713-2-dmitry.torokhov@gmail.com>
References: <20170119224803.10713-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170119224803.10713-1-dmitry.torokhov@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Sylvain Lemieux <slemieux.tyco@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vladimir Zapolskiy <vz@mleia.com>
List-Id: linux-input@vger.kernel.org

Let's drop legacy platform data support (there are no users in mainline)
and switch to using generic device properties, which will make the driver
simpler (non-OF boards can use property sets to describe hardware).

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/tca8418_keypad.c | 90 ++++++++++-----------------------
 include/linux/input/tca8418_keypad.h    | 44 ----------------
 2 files changed, 26 insertions(+), 108 deletions(-)
 delete mode 100644 include/linux/input/tca8418_keypad.h

diff --git a/drivers/input/keyboard/tca8418_keypad.c b/drivers/input/keyboard/tca8418_keypad.c
index 7e49b14c8b02..cf3babce9e29 100644
--- a/drivers/input/keyboard/tca8418_keypad.c
+++ b/drivers/input/keyboard/tca8418_keypad.c
@@ -24,18 +24,17 @@
  * alternative licensing inquiries.
  */
 
-#include <linux/types.h>
-#include <linux/module.h>
-#include <linux/init.h>
 #include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/interrupt.h>
-#include <linux/workqueue.h>
-#include <linux/gpio.h>
 #include <linux/i2c.h>
+#include <linux/init.h>
 #include <linux/input.h>
-#include <linux/input/tca8418_keypad.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
 #include <linux/of.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+#include <linux/types.h>
 
 /* TCA8418 hardware limits */
 #define TCA8418_MAX_ROWS	8
@@ -264,43 +263,25 @@ static int tca8418_configure(struct tca8418_keypad *keypad_data,
 }
 
 static int tca8418_keypad_probe(struct i2c_client *client,
-					  const struct i2c_device_id *id)
+				const struct i2c_device_id *id)
 {
 	struct device *dev = &client->dev;
-	const struct tca8418_keypad_platform_data *pdata =
-						dev_get_platdata(dev);
 	struct tca8418_keypad *keypad_data;
 	struct input_dev *input;
-	const struct matrix_keymap_data *keymap_data = NULL;
 	u32 rows = 0, cols = 0;
-	bool rep = false;
-	bool irq_is_gpio = false;
-	int irq;
 	int error, row_shift, max_keys;
-	unsigned long trigger = 0;
 
-	/* Copy the platform data */
-	if (pdata) {
-		if (!pdata->keymap_data) {
-			dev_err(dev, "no keymap data defined\n");
-			return -EINVAL;
-		}
-		keymap_data = pdata->keymap_data;
-		rows = pdata->rows;
-		cols = pdata->cols;
-		rep  = pdata->rep;
-		irq_is_gpio = pdata->irq_is_gpio;
-		trigger = IRQF_TRIGGER_FALLING;
-	} else {
-		struct device_node *np = dev->of_node;
-		int err;
-
-		err = matrix_keypad_parse_properties(dev, &rows, &cols);
-		if (err)
-			return err;
-		rep = of_property_read_bool(np, "keypad,autorepeat");
+	/* Check i2c driver capabilities */
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE)) {
+		dev_err(dev, "%s adapter not supported\n",
+			dev_driver_string(&client->adapter->dev));
+		return -ENODEV;
 	}
 
+	error = matrix_keypad_parse_properties(dev, &rows, &cols);
+	if (error)
+		return error;
+
 	if (!rows || rows > TCA8418_MAX_ROWS) {
 		dev_err(dev, "invalid rows\n");
 		return -EINVAL;
@@ -311,13 +292,6 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	/* Check i2c driver capabilities */
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE)) {
-		dev_err(dev, "%s adapter not supported\n",
-			dev_driver_string(&client->adapter->dev));
-		return -ENODEV;
-	}
-
 	row_shift = get_count_order(cols);
 	max_keys = rows << row_shift;
 
@@ -347,25 +321,22 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 	input->id.product = 0x001;
 	input->id.version = 0x0001;
 
-	error = matrix_keypad_build_keymap(keymap_data, NULL, rows, cols,
-					   NULL, input);
+	error = matrix_keypad_build_keymap(NULL, NULL, rows, cols, NULL, input);
 	if (error) {
 		dev_err(dev, "Failed to build keymap\n");
 		return error;
 	}
 
-	if (rep)
+	if (device_property_read_bool(dev, "keypad,autorepeat"))
 		__set_bit(EV_REP, input->evbit);
+
 	input_set_capability(input, EV_MSC, MSC_SCAN);
 
 	input_set_drvdata(input, keypad_data);
 
-	irq = client->irq;
-	if (irq_is_gpio)
-		irq = gpio_to_irq(irq);
-
-	error = devm_request_threaded_irq(dev, irq, NULL, tca8418_irq_handler,
-					  trigger | IRQF_SHARED | IRQF_ONESHOT,
+	error = devm_request_threaded_irq(dev, client->irq,
+					  NULL, tca8418_irq_handler,
+					  IRQF_SHARED | IRQF_ONESHOT,
 					  client->name, keypad_data);
 	if (error) {
 		dev_err(dev, "Unable to claim irq %d; error %d\n",
@@ -384,30 +355,21 @@ static int tca8418_keypad_probe(struct i2c_client *client,
 }
 
 static const struct i2c_device_id tca8418_id[] = {
-	{ TCA8418_NAME, 8418, },
+	{ "tca8418", 8418, },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tca8418_id);
 
-#ifdef CONFIG_OF
 static const struct of_device_id tca8418_dt_ids[] = {
 	{ .compatible = "ti,tca8418", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, tca8418_dt_ids);
 
-/*
- * The device tree based i2c loader looks for
- * "i2c:" + second_component_of(property("compatible"))
- * and therefore we need an alias to be found.
- */
-MODULE_ALIAS("i2c:tca8418");
-#endif
-
 static struct i2c_driver tca8418_keypad_driver = {
 	.driver = {
-		.name	= TCA8418_NAME,
-		.of_match_table = of_match_ptr(tca8418_dt_ids),
+		.name	= "tca8418_keypad",
+		.of_match_table = tca8418_dt_ids,
 	},
 	.probe		= tca8418_keypad_probe,
 	.id_table	= tca8418_id,
diff --git a/include/linux/input/tca8418_keypad.h b/include/linux/input/tca8418_keypad.h
deleted file mode 100644
index e71a85dc2cbd..000000000000
--- a/include/linux/input/tca8418_keypad.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * TCA8418 keypad platform support
- *
- * Copyright (C) 2011 Fuel7, Inc.  All rights reserved.
- *
- * Author: Kyle Manna <kyle.manna@fuel7.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public
- * License v2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public
- * License along with this program; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 021110-1307, USA.
- *
- * If you can't comply with GPLv2, alternative licensing terms may be
- * arranged. Please contact Fuel7, Inc. (http://fuel7.com/) for proprietary
- * alternative licensing inquiries.
- */
-
-#ifndef _TCA8418_KEYPAD_H
-#define _TCA8418_KEYPAD_H
-
-#include <linux/types.h>
-#include <linux/input/matrix_keypad.h>
-
-#define TCA8418_I2C_ADDR	0x34
-#define	TCA8418_NAME		"tca8418_keypad"
-
-struct tca8418_keypad_platform_data {
-	const struct matrix_keymap_data *keymap_data;
-	unsigned rows;
-	unsigned cols;
-	bool rep;
-	bool irq_is_gpio;
-};
-
-#endif
-- 
2.11.0.483.g087da7b7c-goog
