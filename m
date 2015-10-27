From: Michael Welling <mwelling@ieee.org>
Subject: [PATCH] Input: tsc2005 - Add support for tsc2004
Date: Tue, 27 Oct 2015 15:36:43 -0500
Message-ID: <1445978203-31264-1-git-send-email-mwelling@ieee.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34482 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202AbbJ0UhS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Oct 2015 16:37:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Felipe Balbi <balbi@ti.com>, Sebastian Reichel <sre@kernel.org>, Roger Quadros <rogerq@ti.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: Michael Welling <mwelling@ieee.org>

Adds support for the i2c based tsc2004. Support was added to the tsc2005 driver
due to the similarity of the devices.

Signed-off-by: Michael Welling <mwelling@ieee.org>
---
 .../bindings/input/touchscreen/tsc2004.txt         |  38 ++++
 drivers/input/touchscreen/Kconfig                  |   5 +-
 drivers/input/touchscreen/tsc2005.c                | 206 ++++++++++++++++-----
 3 files changed, 204 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/tsc2004.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/tsc2004.txt b/Documentation/devicetree/bindings/input/touchscreen/tsc2004.txt
new file mode 100644
index 0000000..14a37fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/tsc2004.txt
@@ -0,0 +1,38 @@
+* Texas Instruments tsc2004 touchscreen controller
+
+Required properties:
+ - compatible		      : "ti,tsc2004"
+ - interrupts		      : IRQ specifier
+ - vio-supply                 : Regulator specifier
+
+Optional properties:
+ - reset-gpios		      : GPIO specifier
+ - ti,x-plate-ohms	      : integer, resistance of the touchscreen's X plates
+				in ohm (defaults to 280)
+ - ti,esd-recovery-timeout-ms : integer, if the touchscreen does not respond after
+				the configured time (in milli seconds), the driver
+				will reset it. This is disabled by default.
+ - properties defined in touchscreen.txt
+
+Example:
+
+&i2c3 {
+	tsc2004@48 {
+		compatible = "ti,tsc2004";
+		reg = <0x48>;
+		vio-supply = <&vio>;
+
+		reset-gpios = <&gpio4 8 GPIO_ACTIVE_HIGH>;
+		interrupts-extended = <&gpio1 27 IRQ_TYPE_EDGE_RISING>;
+
+		touchscreen-fuzz-x = <4>;
+		touchscreen-fuzz-y = <7>;
+		touchscreen-fuzz-pressure = <2>;
+		touchscreen-size-x = <4096>;
+		touchscreen-size-y = <4096>;
+		touchscreen-max-pressure = <2048>;
+
+		ti,x-plate-ohms = <280>;
+		ti,esd-recovery-timeout-ms = <8000>;
+	};
+}
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 80cc698..7f311d7 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -940,9 +940,10 @@ config TOUCHSCREEN_TSC_SERIO
 	  module will be called tsc40.
 
 config TOUCHSCREEN_TSC2005
-	tristate "TSC2005 based touchscreens"
-	depends on SPI_MASTER
+	tristate "TSC2004/TSC2005 based touchscreens"
+	depends on SPI_MASTER || I2C
 	select REGMAP_SPI
+	select REGMAP_I2C
 	help
 	  Say Y here if you have a TSC2005 based touchscreen.
 
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 0f65d02..08decd4 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -30,6 +30,7 @@
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/of.h>
+#include <linux/i2c.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/tsc2005.h>
 #include <linux/regulator/consumer.h>
@@ -151,6 +152,8 @@ struct tsc2005_data {
 
 struct tsc2005 {
 	struct spi_device	*spi;
+	struct i2c_client	*i2c;
+	struct device		*dev;
 	struct regmap		*regmap;
 
 	struct input_dev	*idev;
@@ -182,9 +185,11 @@ struct tsc2005 {
 
 	struct gpio_desc	*reset_gpio;
 	void			(*set_reset)(bool enable);
+
+	int			irq;
 };
 
-static int tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
+static int tsc2005_cmd_spi(struct tsc2005 *ts, u8 cmd)
 {
 	u8 tx = TSC2005_CMD | TSC2005_CMD_12BIT | cmd;
 	struct spi_transfer xfer = {
@@ -200,7 +205,7 @@ static int tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
 
 	error = spi_sync(ts->spi, &msg);
 	if (error) {
-		dev_err(&ts->spi->dev, "%s: failed, command: %x, error: %d\n",
+		dev_err(ts->dev, "%s: failed, command: %x, spi error: %d\n",
 			__func__, cmd, error);
 		return error;
 	}
@@ -208,6 +213,32 @@ static int tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
 	return 0;
 }
 
+static int tsc2005_cmd_i2c(struct tsc2005 *ts, u8 cmd)
+{
+	u8 tx = TSC2005_CMD | TSC2005_CMD_12BIT | cmd;
+	s32 data;
+
+	data = i2c_smbus_write_byte(ts->i2c, tx);
+	if (data < 0) {
+		dev_err(&ts->dev, "%s: failed, command: %x i2c error: %d\n",
+			__func__, cmd, data);
+		return data;
+	}
+
+	return 0;
+}
+
+static int tsc2005_cmd(struct tsc2005 *ts, u8 cmd)
+{
+	if (ts->spi)
+		return tsc2005_cmd_spi(ts, cmd);
+
+	if (ts->i2c)
+		return tsc2005_cmd_i2c(ts, cmd);
+
+	return -ENODEV;
+}
+
 static void tsc2005_update_pen_state(struct tsc2005 *ts,
 				     int x, int y, int pressure)
 {
@@ -227,7 +258,7 @@ static void tsc2005_update_pen_state(struct tsc2005 *ts,
 		}
 	}
 	input_sync(ts->idev);
-	dev_dbg(&ts->spi->dev, "point(%4d,%4d), pressure (%4d)\n", x, y,
+	dev_dbg(ts->dev, "point(%4d,%4d), pressure (%4d)\n", x, y,
 		pressure);
 }
 
@@ -329,12 +360,12 @@ static void __tsc2005_disable(struct tsc2005 *ts)
 {
 	tsc2005_stop_scan(ts);
 
-	disable_irq(ts->spi->irq);
+	disable_irq(ts->irq);
 	del_timer_sync(&ts->penup_timer);
 
 	cancel_delayed_work_sync(&ts->esd_work);
 
-	enable_irq(ts->spi->irq);
+	enable_irq(ts->irq);
 }
 
 /* must be called with ts->mutex held */
@@ -487,9 +518,9 @@ static void tsc2005_esd_work(struct work_struct *work)
 	 * then we should reset the controller as if from power-up and start
 	 * scanning again.
 	 */
-	dev_info(&ts->spi->dev, "TSC2005 not responding - resetting\n");
+	dev_info(ts->dev, "TSC2005 not responding - resetting\n");
 
-	disable_irq(ts->spi->irq);
+	disable_irq(ts->irq);
 	del_timer_sync(&ts->penup_timer);
 
 	tsc2005_update_pen_state(ts, 0, 0, 0);
@@ -498,7 +529,7 @@ static void tsc2005_esd_work(struct work_struct *work)
 	usleep_range(100, 500); /* only 10us required */
 	tsc2005_set_reset(ts, true);
 
-	enable_irq(ts->spi->irq);
+	enable_irq(ts->irq);
 	tsc2005_start_scan(ts);
 
 out:
@@ -540,10 +571,10 @@ static void tsc2005_close(struct input_dev *input)
 	mutex_unlock(&ts->mutex);
 }
 
-static int tsc2005_probe(struct spi_device *spi)
+static int tsc200x_probe_common(struct device *dev, int irq, __u16 bustype)
 {
-	const struct tsc2005_platform_data *pdata = dev_get_platdata(&spi->dev);
-	struct device_node *np = spi->dev.of_node;
+	const struct tsc2005_platform_data *pdata = dev_get_platdata(dev);
+	struct device_node *np = dev->of_node;
 
 	struct tsc2005 *ts;
 	struct input_dev *input_dev;
@@ -558,12 +589,12 @@ static int tsc2005_probe(struct spi_device *spi)
 	int error;
 
 	if (!np && !pdata) {
-		dev_err(&spi->dev, "no platform data\n");
+		dev_err(dev, "no platform data\n");
 		return -ENODEV;
 	}
 
-	if (spi->irq <= 0) {
-		dev_err(&spi->dev, "no irq\n");
+	if (irq <= 0) {
+		dev_err(dev, "no irq\n");
 		return -ENODEV;
 	}
 
@@ -584,45 +615,46 @@ static int tsc2005_probe(struct spi_device *spi)
 								&esd_timeout);
 	}
 
-	spi->mode = SPI_MODE_0;
-	spi->bits_per_word = 8;
-	if (!spi->max_speed_hz)
-		spi->max_speed_hz = TSC2005_SPI_MAX_SPEED_HZ;
-
-	error = spi_setup(spi);
-	if (error)
-		return error;
-
-	ts = devm_kzalloc(&spi->dev, sizeof(*ts), GFP_KERNEL);
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
 	if (!ts)
 		return -ENOMEM;
 
-	input_dev = devm_input_allocate_device(&spi->dev);
+	input_dev = devm_input_allocate_device(dev);
 	if (!input_dev)
 		return -ENOMEM;
 
-	ts->spi = spi;
+	ts->irq = irq;
+	ts->dev = dev;
 	ts->idev = input_dev;
 
-	ts->regmap = devm_regmap_init_spi(spi, &tsc2005_regmap_config);
+	if (bustype == BUS_SPI) {
+		ts->spi = to_spi_device(dev);
+		ts->regmap = devm_regmap_init_spi(ts->spi,
+						  &tsc2005_regmap_config);
+	} else if (bustype == BUS_I2C) {
+		ts->i2c = to_i2c_client(dev);
+		ts->regmap = devm_regmap_init_i2c(ts->i2c,
+						  &tsc2005_regmap_config);
+	}
+
 	if (IS_ERR(ts->regmap))
 		return PTR_ERR(ts->regmap);
 
 	ts->x_plate_ohm = x_plate_ohm;
 	ts->esd_timeout = esd_timeout;
 
-	ts->reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
+	ts->reset_gpio = devm_gpiod_get_optional(dev, "reset",
 						 GPIOD_OUT_HIGH);
 	if (IS_ERR(ts->reset_gpio)) {
 		error = PTR_ERR(ts->reset_gpio);
-		dev_err(&spi->dev, "error acquiring reset gpio: %d\n", error);
+		dev_err(dev, "error acquiring reset gpio: %d\n", error);
 		return error;
 	}
 
-	ts->vio = devm_regulator_get_optional(&spi->dev, "vio");
+	ts->vio = devm_regulator_get_optional(dev, "vio");
 	if (IS_ERR(ts->vio)) {
 		error = PTR_ERR(ts->vio);
-		dev_err(&spi->dev, "vio regulator missing (%d)", error);
+		dev_err(dev, "vio regulator missing (%d)", error);
 		return error;
 	}
 
@@ -637,12 +669,12 @@ static int tsc2005_probe(struct spi_device *spi)
 	INIT_DELAYED_WORK(&ts->esd_work, tsc2005_esd_work);
 
 	snprintf(ts->phys, sizeof(ts->phys),
-		 "%s/input-ts", dev_name(&spi->dev));
+		 "%s/input-ts", dev_name(dev));
 
 	input_dev->name = "TSC2005 touchscreen";
 	input_dev->phys = ts->phys;
-	input_dev->id.bustype = BUS_SPI;
-	input_dev->dev.parent = &spi->dev;
+	input_dev->id.bustype = bustype;
+	input_dev->dev.parent = dev;
 	input_dev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
 	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
@@ -661,12 +693,12 @@ static int tsc2005_probe(struct spi_device *spi)
 	/* Ensure the touchscreen is off */
 	tsc2005_stop_scan(ts);
 
-	error = devm_request_threaded_irq(&spi->dev, spi->irq, NULL,
+	error = devm_request_threaded_irq(dev, irq, NULL,
 					  tsc2005_irq_thread,
 					  IRQF_TRIGGER_RISING | IRQF_ONESHOT,
 					  "tsc2005", ts);
 	if (error) {
-		dev_err(&spi->dev, "Failed to request irq, err: %d\n", error);
+		dev_err(dev, "Failed to request irq, err: %d\n", error);
 		return error;
 	}
 
@@ -677,32 +709,49 @@ static int tsc2005_probe(struct spi_device *spi)
 			return error;
 	}
 
-	dev_set_drvdata(&spi->dev, ts);
-	error = sysfs_create_group(&spi->dev.kobj, &tsc2005_attr_group);
+	dev_set_drvdata(dev, ts);
+	error = sysfs_create_group(&dev->kobj, &tsc2005_attr_group);
 	if (error) {
-		dev_err(&spi->dev,
+		dev_err(dev,
 			"Failed to create sysfs attributes, err: %d\n", error);
 		goto disable_regulator;
 	}
 
 	error = input_register_device(ts->idev);
 	if (error) {
-		dev_err(&spi->dev,
+		dev_err(dev,
 			"Failed to register input device, err: %d\n", error);
 		goto err_remove_sysfs;
 	}
 
-	irq_set_irq_wake(spi->irq, 1);
+	irq_set_irq_wake(irq, 1);
 	return 0;
 
 err_remove_sysfs:
-	sysfs_remove_group(&spi->dev.kobj, &tsc2005_attr_group);
+	sysfs_remove_group(&dev->kobj, &tsc2005_attr_group);
 disable_regulator:
 	if (ts->vio)
 		regulator_disable(ts->vio);
 	return error;
 }
 
+
+static int tsc2005_probe(struct spi_device *spi)
+{
+	int error;
+
+	spi->mode = SPI_MODE_0;
+	spi->bits_per_word = 8;
+	if (!spi->max_speed_hz)
+		spi->max_speed_hz = TSC2005_SPI_MAX_SPEED_HZ;
+
+	error = spi_setup(spi);
+	if (error)
+		return error;
+
+	return tsc200x_probe_common(&spi->dev, spi->irq, BUS_SPI);
+}
+
 static int tsc2005_remove(struct spi_device *spi)
 {
 	struct tsc2005 *ts = dev_get_drvdata(&spi->dev);
@@ -759,7 +808,78 @@ static struct spi_driver tsc2005_driver = {
 	.remove	= tsc2005_remove,
 };
 
-module_spi_driver(tsc2005_driver);
+static int tsc2004_probe(struct i2c_client *i2c,
+			 const struct i2c_device_id *id)
+
+{
+	return tsc200x_probe_common(&i2c->dev, i2c->irq, BUS_I2C);
+}
+
+static int tsc2004_remove(struct i2c_client *i2c)
+{
+	struct tsc2005 *ts = dev_get_drvdata(&i2c->dev);
+
+	sysfs_remove_group(&i2c->dev.kobj, &tsc2005_attr_group);
+
+	if (ts->vio)
+		regulator_disable(ts->vio);
+
+	return 0;
+}
+
+static const struct i2c_device_id tsc2004_idtable[] = {
+	{ "tsc2004", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, tsc2004_idtable);
+
+#ifdef CONFIG_OF
+static const struct of_device_id tsc2004_of_match[] = {
+	{ .compatible = "ti,tsc2004" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tsc2004_of_match);
+#endif
+
+static struct i2c_driver tsc2004_driver = {
+	.driver = {
+		.name	= "tsc2004",
+		.of_match_table = of_match_ptr(tsc2004_of_match),
+		.pm	= &tsc2005_pm_ops,
+	},
+	.id_table	= tsc2004_idtable,
+	.probe		= tsc2004_probe,
+	.remove		= tsc2004_remove,
+};
+
+static int __init tsc2005_modinit(void)
+{
+	int ret = 0;
+#if IS_ENABLED(CONFIG_I2C)
+	ret = i2c_add_driver(&tsc2004_driver);
+	if (ret != 0)
+		pr_err("Failed to register tsc2004 I2C driver: %d\n", ret);
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	ret = spi_register_driver(&tsc2005_driver);
+	if (ret != 0)
+		pr_err("Failed to register tsc2005 SPI driver: %d\n", ret);
+#endif
+	return ret;
+}
+module_init(tsc2005_modinit);
+
+static void __exit tsc2005_exit(void)
+{
+#if IS_ENABLED(CONFIG_I2C)
+	i2c_del_driver(&tsc2004_driver);
+#endif
+#if defined(CONFIG_SPI_MASTER)
+	spi_unregister_driver(&tsc2005_driver);
+#endif
+}
+module_exit(tsc2005_exit);
 
 MODULE_AUTHOR("Lauri Leukkunen <lauri.leukkunen@nokia.com>");
 MODULE_DESCRIPTION("TSC2005 Touchscreen Driver");
-- 
2.1.4

