From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3] touchscreen: pixcir_i2c: Add support for wake and enable gpios
Date: Sun, 22 Nov 2015 16:57:33 +0100
Message-ID: <1448207853-24256-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56880 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752188AbbKVP5n (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Nov 2015 10:57:43 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Sander Vermin <sander@vermin.nl>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>

From: Sander Vermin <sander@vermin.nl>

On some devices the wake and enable pins of the pixcir touchscreen
controller are connected to gpios and these must be controlled by the
driver for the device to operate properly.

Signed-off-by: Sander Vermin <sander@vermin.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2 (Hans de Goede):
-Split the changes for dealing with inverted / swapped axis out into a
 separate patch
-Remove a bunch of dev_info calls to make the driver less chatty
-Use devm_gpiod_get_optional as these new gpios are optional
-Only msleep after setting enable high if we have an enable pin
Changes in v3 (Hans de Goede):
-Use "if (ts->gpio_foo)" instead of "if (!IS_ERR_OR_NULL(ts->foo))"
-No need to set gpio-s to 1 after requesting them with GPIOD_OUT_HIGH
---
 .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |  2 ++
 drivers/input/touchscreen/pixcir_i2c_ts.c          | 40 ++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
index 8eb240a..72ca5ec 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
@@ -10,6 +10,8 @@ Required properties:
 
 Optional properties:
 - reset-gpio: GPIO connected to the RESET line of the chip
+- enable-gpios: GPIO connected to the ENABLE line of the chip
+- wake-gpios: GPIO connected to the WAKE line of the chip
 
 Example:
 
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index 211408c..22a67c6 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -38,6 +38,8 @@ struct pixcir_i2c_ts_data {
 	struct input_dev *input;
 	struct gpio_desc *gpio_attb;
 	struct gpio_desc *gpio_reset;
+	struct gpio_desc *gpio_enable;
+	struct gpio_desc *gpio_wake;
 	const struct pixcir_i2c_chip_data *chip;
 	int max_fingers;	/* Max fingers supported in this instance */
 	bool running;
@@ -208,6 +210,11 @@ static int pixcir_set_power_mode(struct pixcir_i2c_ts_data *ts,
 	struct device *dev = &ts->client->dev;
 	int ret;
 
+	if (mode == PIXCIR_POWER_ACTIVE || mode == PIXCIR_POWER_IDLE) {
+		if (ts->gpio_wake)
+			gpiod_set_value_cansleep(ts->gpio_wake, 1);
+	}
+
 	ret = i2c_smbus_read_byte_data(ts->client, PIXCIR_REG_POWER_MODE);
 	if (ret < 0) {
 		dev_err(dev, "%s: can't read reg 0x%x : %d\n",
@@ -228,6 +235,11 @@ static int pixcir_set_power_mode(struct pixcir_i2c_ts_data *ts,
 		return ret;
 	}
 
+	if (mode == PIXCIR_POWER_HALT) {
+		if (ts->gpio_wake)
+			gpiod_set_value_cansleep(ts->gpio_wake, 0);
+	}
+
 	return 0;
 }
 
@@ -302,6 +314,11 @@ static int pixcir_start(struct pixcir_i2c_ts_data *ts)
 	struct device *dev = &ts->client->dev;
 	int error;
 
+	if (ts->gpio_enable) {
+		gpiod_set_value_cansleep(ts->gpio_enable, 1);
+		msleep(100);
+	}
+
 	/* LEVEL_TOUCH interrupt with active low polarity */
 	error = pixcir_set_int_mode(ts, PIXCIR_INT_LEVEL_TOUCH, 0);
 	if (error) {
@@ -343,6 +360,9 @@ static int pixcir_stop(struct pixcir_i2c_ts_data *ts)
 	/* Wait till running ISR is complete */
 	synchronize_irq(ts->client->irq);
 
+	if (ts->gpio_enable)
+		gpiod_set_value_cansleep(ts->gpio_enable, 0);
+
 	return 0;
 }
 
@@ -534,6 +554,26 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
 		return error;
 	}
 
+	tsdata->gpio_wake = devm_gpiod_get_optional(dev, "wake",
+						    GPIOD_OUT_HIGH);
+	if (IS_ERR(tsdata->gpio_wake)) {
+		error = PTR_ERR(tsdata->gpio_wake);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get wake gpio: %d\n", error);
+		return error;
+	}
+
+	tsdata->gpio_enable = devm_gpiod_get_optional(dev, "enable",
+						      GPIOD_OUT_HIGH);
+	if (IS_ERR(tsdata->gpio_enable)) {
+		error = PTR_ERR(tsdata->gpio_enable);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get enable gpio: %d\n", error);
+		return error;
+	}
+  	if (tsdata->gpio_enable)
+		msleep(100);
+
 	error = devm_request_threaded_irq(dev, client->irq, NULL, pixcir_ts_isr,
 					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 					  client->name, tsdata);
-- 
2.5.0

