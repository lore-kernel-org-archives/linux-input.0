From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH] Input: tsc200x - Report proper input_dev name
Date: Tue, 19 Jul 2016 22:49:52 -0500
Message-ID: <1468986592-4973-1-git-send-email-mwelling@ieee.org>
References: <20160720014424.GI19250@dtor-ws>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34014 "EHLO
	mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbcGTDuj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jul 2016 23:50:39 -0400
In-Reply-To: <20160720014424.GI19250@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, pali.rohar@gmail.com, sre@kernel.org, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Michael Welling <mwelling@ieee.org>

Passes input_id struct to the the common probe function for the tsc200x drivers
instead of just the bustype.

This allows for the use of the product variable to set the input_dev->name
variable according to the type of touchscreen used.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 drivers/input/touchscreen/tsc2004.c      | 7 ++++++-
 drivers/input/touchscreen/tsc2005.c      | 7 ++++++-
 drivers/input/touchscreen/tsc200x-core.c | 7 ++++---
 drivers/input/touchscreen/tsc200x-core.h | 2 +-
 4 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2004.c b/drivers/input/touchscreen/tsc2004.c
index 7295c19..6fe55d5 100644
--- a/drivers/input/touchscreen/tsc2004.c
+++ b/drivers/input/touchscreen/tsc2004.c
@@ -22,6 +22,11 @@
 #include <linux/regmap.h>
 #include "tsc200x-core.h"
 
+static const struct input_id tsc2004_input_id = {
+	.bustype = BUS_I2C,
+	.product = 2004,
+};
+
 static int tsc2004_cmd(struct device *dev, u8 cmd)
 {
 	u8 tx = TSC200X_CMD | TSC200X_CMD_12BIT | cmd;
@@ -42,7 +47,7 @@ static int tsc2004_probe(struct i2c_client *i2c,
 			 const struct i2c_device_id *id)
 
 {
-	return tsc200x_probe(&i2c->dev, i2c->irq, BUS_I2C,
+	return tsc200x_probe(&i2c->dev, i2c->irq, &tsc2004_input_id,
 			     devm_regmap_init_i2c(i2c, &tsc200x_regmap_config),
 			     tsc2004_cmd);
 }
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index b9f593d..f2c5f0e 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -24,6 +24,11 @@
 #include <linux/regmap.h>
 #include "tsc200x-core.h"
 
+static const struct input_id tsc2005_input_id = {
+	.bustype = BUS_SPI,
+	.product = 2005,
+};
+
 static int tsc2005_cmd(struct device *dev, u8 cmd)
 {
 	u8 tx = TSC200X_CMD | TSC200X_CMD_12BIT | cmd;
@@ -62,7 +67,7 @@ static int tsc2005_probe(struct spi_device *spi)
 	if (error)
 		return error;
 
-	return tsc200x_probe(&spi->dev, spi->irq, BUS_SPI,
+	return tsc200x_probe(&spi->dev, spi->irq, &tsc2005_input_id,
 			     devm_regmap_init_spi(spi, &tsc200x_regmap_config),
 			     tsc2005_cmd);
 }
diff --git a/drivers/input/touchscreen/tsc200x-core.c b/drivers/input/touchscreen/tsc200x-core.c
index 26e81d1b..5e625c4 100644
--- a/drivers/input/touchscreen/tsc200x-core.c
+++ b/drivers/input/touchscreen/tsc200x-core.c
@@ -450,7 +450,7 @@ static void tsc200x_close(struct input_dev *input)
 	mutex_unlock(&ts->mutex);
 }
 
-int tsc200x_probe(struct device *dev, int irq, __u16 bustype,
+int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		  struct regmap *regmap,
 		  int (*tsc200x_cmd)(struct device *dev, u8 cmd))
 {
@@ -547,9 +547,10 @@ int tsc200x_probe(struct device *dev, int irq, __u16 bustype,
 	snprintf(ts->phys, sizeof(ts->phys),
 		 "%s/input-ts", dev_name(dev));
 
-	input_dev->name = "TSC200X touchscreen";
+	input_dev->name = devm_kasprintf(dev, GFP_KERNEL, "TSC%04d touchscreen",
+					tsc_id->product);
 	input_dev->phys = ts->phys;
-	input_dev->id.bustype = bustype;
+	input_dev->id = *tsc_id;
 	input_dev->dev.parent = dev;
 	input_dev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
diff --git a/drivers/input/touchscreen/tsc200x-core.h b/drivers/input/touchscreen/tsc200x-core.h
index 7a482d1..49a63a3 100644
--- a/drivers/input/touchscreen/tsc200x-core.h
+++ b/drivers/input/touchscreen/tsc200x-core.h
@@ -70,7 +70,7 @@
 extern const struct regmap_config tsc200x_regmap_config;
 extern const struct dev_pm_ops tsc200x_pm_ops;
 
-int tsc200x_probe(struct device *dev, int irq, __u16 bustype,
+int tsc200x_probe(struct device *dev, int irq, const struct input_id *tsc_id,
 		  struct regmap *regmap,
 		  int (*tsc200x_cmd)(struct device *dev, u8 cmd));
 int tsc200x_remove(struct device *dev);
-- 
2.1.4

