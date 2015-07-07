From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/6] Input: pixcir_i2c_ts - add RESET gpio
Date: Mon,  6 Jul 2015 17:30:09 -0700
Message-ID: <1436229011-29655-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1436229011-29655-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34753 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544AbbGGAaZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 20:30:25 -0400
In-Reply-To: <1436229011-29655-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Roger Quadros <rogerq@ti.com>
Cc: Jianchun Bian <jcbian@pixcir.com.cn>, linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

The controller has a RESET pin which is usually controlled over
a GPIO line. If such a GPIO is provided, perform a RESET
during probe.

Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |  3 +++
 drivers/input/touchscreen/pixcir_i2c_ts.c          | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
index 6e55109..8eb240a 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
@@ -8,6 +8,9 @@ Required properties:
 - touchscreen-size-x: horizontal resolution of touchscreen (in pixels)
 - touchscreen-size-y: vertical resolution of touchscreen (in pixels)
 
+Optional properties:
+- reset-gpio: GPIO connected to the RESET line of the chip
+
 Example:
 
 	i2c@00000000 {
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 8965d7c..9d9ac08 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -36,6 +36,7 @@ struct pixcir_i2c_ts_data {
 	struct i2c_client *client;
 	struct input_dev *input;
 	struct gpio_desc *gpio_attb;
+	struct gpio_desc *gpio_reset;
 	const struct pixcir_ts_platform_data *pdata;
 	bool running;
 	int max_fingers;	/* Max fingers supported in this instance */
@@ -189,6 +190,17 @@ static irqreturn_t pixcir_ts_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static void pixcir_reset(struct pixcir_i2c_ts_data *tsdata)
+{
+	if (!IS_ERR_OR_NULL(tsdata->gpio_reset)) {
+		gpiod_set_value_cansleep(tsdata->gpio_reset, 1);
+		ndelay(100);	/* datasheet section 1.2.3 says 80ns min. */
+		gpiod_set_value_cansleep(tsdata->gpio_reset, 0);
+		/* wait for controller ready. 100ms guess. */
+		msleep(100);
+	}
+}
+
 static int pixcir_set_power_mode(struct pixcir_i2c_ts_data *ts,
 				 enum pixcir_power_mode mode)
 {
@@ -529,6 +541,14 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	tsdata->gpio_reset = devm_gpiod_get_optional(dev, "reset",
+						     GPIOD_OUT_LOW);
+	if (IS_ERR(tsdata->gpio_reset)) {
+		error = PTR_ERR(tsdata->gpio_reset);
+		dev_err(dev, "Failed to request RESET gpio: %d\n", error);
+		return error;
+	}
+
 	error = devm_request_threaded_irq(dev, client->irq, NULL, pixcir_ts_isr,
 					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					  client->name, tsdata);
@@ -537,6 +557,8 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	pixcir_reset(tsdata);
+
 	/* Always be in IDLE mode to save power, device supports auto wake */
 	error = pixcir_set_power_mode(tsdata, PIXCIR_POWER_IDLE);
 	if (error) {
-- 
2.4.3.573.g4eafbef

