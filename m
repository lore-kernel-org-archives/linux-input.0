From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v2] Input: edt-ft5x06 - Switch to newer gpio framework
Date: Mon, 31 Aug 2015 18:25:41 -0500
Message-ID: <1441063541-11624-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59782 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751483AbbHaX0H (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 31 Aug 2015 19:26:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dmitry.torokhov@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>

The current/old gpio framework used doesn't properly listen to
ACTIVE_LOW and ACTIVE_HIGH flags. The newer gpio framework takes into
account these flags when setting gpio values.

Since the values being outputed were base on voltage and not logic the
values being outputted must change to refect this difference. Also use
gpiod_set_value_cansleep since wake and reset pins can be provided by
bus based io expanders.

Switch from msleep(5) to udelay_range(5000,6000) to avoid check patch
warning.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
---
Version 2 changes:

Change output value to properly reflect logic low and logic high signals of
/RST and WAKE.

Use usleep_range instead of msleep since it is not precise below 20 ms and
also generates a checkpatch error.

Remove edt_ft5x06_ts_reset since it really serves no purpose especially since
there are no failure error codes to return using the new gpio apis.

 .../bindings/input/touchscreen/edt-ft5x06.txt      |   4 +-
 drivers/input/touchscreen/edt-ft5x06.c             | 132 +++++++--------------
 include/linux/input/edt-ft5x06.h                   |   4 +-
 3 files changed, 47 insertions(+), 93 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
index 76db967..9330d4d 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
@@ -50,6 +50,6 @@ Example:
 		pinctrl-0 = <&edt_ft5x06_pins>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <5 0>;
-		reset-gpios = <&gpio2 6 1>;
-		wake-gpios = <&gpio4 9 0>;
+		reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
+		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
 	};
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 394b1de..d64d29a 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -91,9 +91,9 @@ struct edt_ft5x06_ts_data {
 	u16 num_x;
 	u16 num_y;
 
-	int reset_pin;
-	int irq_pin;
-	int wake_pin;
+	struct gpio_desc *reset_pin;
+	struct gpio_desc *wake_pin;
+	struct gpio_desc *irq_pin;
 
 #if defined(CONFIG_DEBUG_FS)
 	struct dentry *debug_dir;
@@ -752,45 +752,6 @@ edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
 
 #endif /* CONFIG_DEBUGFS */
 
-static int edt_ft5x06_ts_reset(struct i2c_client *client,
-			struct edt_ft5x06_ts_data *tsdata)
-{
-	int error;
-
-	if (gpio_is_valid(tsdata->wake_pin)) {
-		error = devm_gpio_request_one(&client->dev,
-					tsdata->wake_pin, GPIOF_OUT_INIT_LOW,
-					"edt-ft5x06 wake");
-		if (error) {
-			dev_err(&client->dev,
-				"Failed to request GPIO %d as wake pin, error %d\n",
-				tsdata->wake_pin, error);
-			return error;
-		}
-
-		msleep(5);
-		gpio_set_value(tsdata->wake_pin, 1);
-	}
-	if (gpio_is_valid(tsdata->reset_pin)) {
-		/* this pulls reset down, enabling the low active reset */
-		error = devm_gpio_request_one(&client->dev,
-					tsdata->reset_pin, GPIOF_OUT_INIT_LOW,
-					"edt-ft5x06 reset");
-		if (error) {
-			dev_err(&client->dev,
-				"Failed to request GPIO %d as reset pin, error %d\n",
-				tsdata->reset_pin, error);
-			return error;
-		}
-
-		msleep(5);
-		gpio_set_value(tsdata->reset_pin, 1);
-		msleep(300);
-	}
-
-	return 0;
-}
-
 static int edt_ft5x06_ts_identify(struct i2c_client *client,
 					struct edt_ft5x06_ts_data *tsdata,
 					char *fw_version)
@@ -931,30 +892,6 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
 	}
 }
 
-#ifdef CONFIG_OF
-static int edt_ft5x06_i2c_ts_probe_dt(struct device *dev,
-				struct edt_ft5x06_ts_data *tsdata)
-{
-	struct device_node *np = dev->of_node;
-
-	/*
-	 * irq_pin is not needed for DT setup.
-	 * irq is associated via 'interrupts' property in DT
-	 */
-	tsdata->irq_pin = -EINVAL;
-	tsdata->reset_pin = of_get_named_gpio(np, "reset-gpios", 0);
-	tsdata->wake_pin = of_get_named_gpio(np, "wake-gpios", 0);
-
-	return 0;
-}
-#else
-static inline int edt_ft5x06_i2c_ts_probe_dt(struct device *dev,
-					struct edt_ft5x06_ts_data *tsdata)
-{
-	return -ENODEV;
-}
-#endif
-
 static int edt_ft5x06_ts_probe(struct i2c_client *client,
 					 const struct i2c_device_id *id)
 {
@@ -964,6 +901,7 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 	struct input_dev *input;
 	int error;
 	char fw_version[EDT_NAME_LEN];
+	struct gpio_desc *gpio;
 
 	dev_dbg(&client->dev, "probing for EDT FT5x06 I2C\n");
 
@@ -973,32 +911,47 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 		return -ENOMEM;
 	}
 
-	if (!pdata) {
-		error = edt_ft5x06_i2c_ts_probe_dt(&client->dev, tsdata);
-		if (error) {
-			dev_err(&client->dev,
-				"DT probe failed and no platform data present\n");
-			return error;
-		}
-	} else {
-		tsdata->reset_pin = pdata->reset_pin;
-		tsdata->irq_pin = pdata->irq_pin;
-		tsdata->wake_pin = -EINVAL;
+	gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpio)) {
+		error = PTR_ERR(gpio);
+		dev_err(&client->dev,
+			"Failed to request GPIO reset pin, error %d\n", error);
+		return error;
 	}
 
-	error = edt_ft5x06_ts_reset(client, tsdata);
-	if (error)
+	tsdata->reset_pin = gpio;
+
+	gpio = devm_gpiod_get_optional(&client->dev, "wake", GPIOD_OUT_LOW);
+
+	if (IS_ERR(gpio)) {
+		error = PTR_ERR(gpio);
+		dev_err(&client->dev,
+			"Failed to request GPIO wake pin, error %d\n", error);
 		return error;
+	}
 
-	if (gpio_is_valid(tsdata->irq_pin)) {
-		error = devm_gpio_request_one(&client->dev, tsdata->irq_pin,
-					GPIOF_IN, "edt-ft5x06 irq");
-		if (error) {
-			dev_err(&client->dev,
-				"Failed to request GPIO %d, error %d\n",
-				tsdata->irq_pin, error);
-			return error;
-		}
+	tsdata->wake_pin = gpio;
+
+	gpio = devm_gpiod_get_optional(&client->dev, "irq", GPIOD_IN);
+
+	if (IS_ERR(gpio)) {
+		error = PTR_ERR(gpio);
+		dev_err(&client->dev,
+			"Failed to request GPIO irq pin, error %d\n", error);
+		return error;
+	}
+
+	tsdata->irq_pin = gpio;
+
+	if (tsdata->wake_pin) {
+		usleep_range(5000, 6000);
+		gpiod_set_value_cansleep(tsdata->wake_pin, 1);
+	}
+
+	if (tsdata->reset_pin) {
+		usleep_range(5000, 6000);
+		gpiod_set_value_cansleep(tsdata->reset_pin, 0);
+		msleep(300);
 	}
 
 	input = devm_input_allocate_device(&client->dev);
@@ -1074,7 +1027,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
 
 	dev_dbg(&client->dev,
 		"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
-		client->irq, tsdata->wake_pin, tsdata->reset_pin);
+		client->irq, desc_to_gpio(tsdata->wake_pin),
+		desc_to_gpio(tsdata->reset_pin));
 
 	return 0;
 
diff --git a/include/linux/input/edt-ft5x06.h b/include/linux/input/edt-ft5x06.h
index 8a1e0d1..058473a 100644
--- a/include/linux/input/edt-ft5x06.h
+++ b/include/linux/input/edt-ft5x06.h
@@ -10,8 +10,8 @@
  */
 
 struct edt_ft5x06_platform_data {
-	int irq_pin;
-	int reset_pin;
+	int irq_gpio;
+	int reset_gpio;
 
 	/* startup defaults for operational parameters */
 	bool use_parameters;
-- 
2.1.4

