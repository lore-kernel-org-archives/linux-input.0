From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/6] Input: pixcir_i2c_ts - use standard OF touchscreen parsing code
Date: Mon,  6 Jul 2015 17:30:11 -0700
Message-ID: <1436229011-29655-6-git-send-email-dmitry.torokhov@gmail.com>
References: <1436229011-29655-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33948 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756495AbbGGAa3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 20:30:29 -0400
In-Reply-To: <1436229011-29655-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Roger Quadros <rogerq@ti.com>
Cc: Jianchun Bian <jcbian@pixcir.com.cn>, linux-kernel@vger.kernel.org

Let's switch to using standard touchscreen device properties parsing module
instead of doing it by hand in the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/pixcir_i2c_ts.c | 95 ++++++++++++++-----------------
 1 file changed, 44 insertions(+), 51 deletions(-)

diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 043d219..31f1c7d 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -24,9 +24,10 @@
 #include <linux/i2c.h>
 #include <linux/input.h>
 #include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of.h>
+/*#include <linux/of.h>*/
 #include <linux/of_device.h>
 #include <linux/platform_data/pixcir_i2c_ts.h>
 
@@ -37,9 +38,9 @@ struct pixcir_i2c_ts_data {
 	struct input_dev *input;
 	struct gpio_desc *gpio_attb;
 	struct gpio_desc *gpio_reset;
-	const struct pixcir_ts_platform_data *pdata;
-	bool running;
+	const struct pixcir_i2c_chip_data *chip;
 	int max_fingers;	/* Max fingers supported in this instance */
+	bool running;
 };
 
 struct pixcir_touch {
@@ -62,7 +63,7 @@ static void pixcir_ts_parse(struct pixcir_i2c_ts_data *tsdata,
 	u8 touch;
 	int ret, i;
 	int readsize;
-	const struct pixcir_i2c_chip_data *chip = &tsdata->pdata->chip;
+	const struct pixcir_i2c_chip_data *chip = tsdata->chip;
 
 	memset(report, 0, sizeof(struct pixcir_report_data));
 
@@ -115,13 +116,13 @@ static void pixcir_ts_report(struct pixcir_i2c_ts_data *ts,
 	struct pixcir_touch *touch;
 	int n, i, slot;
 	struct device *dev = &ts->client->dev;
-	const struct pixcir_i2c_chip_data *chip = &ts->pdata->chip;
+	const struct pixcir_i2c_chip_data *chip = ts->chip;
 
 	n = report->num_touches;
 	if (n > PIXCIR_MAX_SLOTS)
 		n = PIXCIR_MAX_SLOTS;
 
-	if (!chip->has_hw_ids) {
+	if (!ts->chip->has_hw_ids) {
 		for (i = 0; i < n; i++) {
 			touch = &report->touches[i];
 			pos[i].x = touch->x;
@@ -423,77 +424,59 @@ static SIMPLE_DEV_PM_OPS(pixcir_dev_pm_ops,
 #ifdef CONFIG_OF
 static const struct of_device_id pixcir_of_match[];
 
-static struct pixcir_ts_platform_data *pixcir_parse_dt(struct device *dev)
+static int pixcir_parse_dt(struct device *dev,
+			   struct pixcir_i2c_ts_data *tsdata)
 {
-	struct pixcir_ts_platform_data *pdata;
-	struct device_node *np = dev->of_node;
 	const struct of_device_id *match;
 
 	match = of_match_device(of_match_ptr(pixcir_of_match), dev);
 	if (!match)
-		return ERR_PTR(-EINVAL);
-
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
-	pdata->chip = *(const struct pixcir_i2c_chip_data *)match->data;
-
-	if (of_property_read_u32(np, "touchscreen-size-x", &pdata->x_max)) {
-		dev_err(dev, "Failed to get touchscreen-size-x property\n");
-		return ERR_PTR(-EINVAL);
-	}
-	pdata->x_max -= 1;
-
-	if (of_property_read_u32(np, "touchscreen-size-y", &pdata->y_max)) {
-		dev_err(dev, "Failed to get touchscreen-size-y property\n");
-		return ERR_PTR(-EINVAL);
-	}
-	pdata->y_max -= 1;
+		return -EINVAL;
 
-	dev_dbg(dev, "%s: x %d, y %d\n", __func__,
-		pdata->x_max + 1, pdata->y_max + 1);
+	tsdata->chip = (const struct pixcir_i2c_chip_data *)match->data;
+	if (!tsdata->chip)
+		return -EINVAL;
 
-	return pdata;
+	return 0;
 }
 #else
-static struct pixcir_ts_platform_data *pixcir_parse_dt(struct device *dev)
+static int pixcir_parse_dt(struct device *dev,
+			   struct pixcir_i2c_ts_data *tsdata)
 {
-	return ERR_PTR(-EINVAL);
+	return -EINVAL;
 }
 #endif
 
 static int pixcir_i2c_ts_probe(struct i2c_client *client,
-					 const struct i2c_device_id *id)
+			       const struct i2c_device_id *id)
 {
 	const struct pixcir_ts_platform_data *pdata =
 			dev_get_platdata(&client->dev);
 	struct device *dev = &client->dev;
-	struct device_node *np = dev->of_node;
 	struct pixcir_i2c_ts_data *tsdata;
 	struct input_dev *input;
 	int error;
 
-	if (np && !pdata) {
-		pdata = pixcir_parse_dt(dev);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-	}
+	tsdata = devm_kzalloc(dev, sizeof(*tsdata), GFP_KERNEL);
+	if (!tsdata)
+		return -ENOMEM;
 
-	if (!pdata) {
+	if (pdata) {
+		tsdata->chip = &pdata->chip;
+	} else if (dev->of_node) {
+		error = pixcir_parse_dt(dev, tsdata);
+		if (error)
+			return error;
+	} else {
 		dev_err(&client->dev, "platform data not defined\n");
 		return -EINVAL;
 	}
 
-	if (!pdata->chip.max_fingers) {
-		dev_err(dev, "Invalid max_fingers in pdata\n");
+	if (!tsdata->chip->max_fingers) {
+		dev_err(dev, "Invalid max_fingers in chip data\n");
 		return -EINVAL;
 	}
 
-	tsdata = devm_kzalloc(dev, sizeof(*tsdata), GFP_KERNEL);
-	if (!tsdata)
-		return -ENOMEM;
-
 	input = devm_input_allocate_device(dev);
 	if (!input) {
 		dev_err(dev, "Failed to allocate input device\n");
@@ -502,7 +485,6 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 
 	tsdata->client = client;
 	tsdata->input = input;
-	tsdata->pdata = pdata;
 
 	input->name = client->name;
 	input->id.bustype = BUS_I2C;
@@ -510,10 +492,21 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 	input->close = pixcir_input_close;
 	input->dev.parent = &client->dev;
 
-	input_set_abs_params(input, ABS_MT_POSITION_X, 0, pdata->x_max, 0, 0);
-	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, pdata->y_max, 0, 0);
+	if (pdata) {
+		input_set_abs_params(input, ABS_MT_POSITION_X, 0, pdata->x_max, 0, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, pdata->y_max, 0, 0);
+	} else {
+		input_set_capability(input, EV_ABS, ABS_MT_POSITION_X);
+		input_set_capability(input, EV_ABS, ABS_MT_POSITION_Y);
+		touchscreen_parse_properties(input, true);
+		if (!input_abs_get_max(input, ABS_MT_POSITION_X) ||
+		    !input_abs_get_max(input, ABS_MT_POSITION_Y)) {
+			dev_err(dev, "Touchscreen size is not specified\n");
+			return -EINVAL;
+		}
+	}
 
-	tsdata->max_fingers = tsdata->pdata->chip.max_fingers;
+	tsdata->max_fingers = tsdata->chip->max_fingers;
 	if (tsdata->max_fingers > PIXCIR_MAX_SLOTS) {
 		tsdata->max_fingers = PIXCIR_MAX_SLOTS;
 		dev_info(dev, "Limiting maximum fingers to %d\n",
-- 
2.4.3.573.g4eafbef

