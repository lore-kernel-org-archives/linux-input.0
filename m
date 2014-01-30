From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH RFC] Input: Add Microchip AR1021 i2c touchscreen
Date: Thu, 30 Jan 2014 10:29:45 +0100
Message-ID: <1391074185-26973-1-git-send-email-christian.gmeiner@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f170.google.com ([209.85.215.170]:34918 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbaA3J3x (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 04:29:53 -0500
Received: by mail-ea0-f170.google.com with SMTP id k10so1500776eaj.1
        for <linux-input@vger.kernel.org>; Thu, 30 Jan 2014 01:29:52 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Christian Gmeiner <christian.gmeiner@gmail.com>

This driver is quite simple and only supports the Touch
Reporting Protocol.

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/input/touchscreen/Kconfig      |   12 ++
 drivers/input/touchscreen/Makefile     |    1 +
 drivers/input/touchscreen/ar1021_i2c.c |  201 ++++++++++++++++++++++++++++++++
 3 files changed, 214 insertions(+)
 create mode 100644 drivers/input/touchscreen/ar1021_i2c.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 07e9e82..15cc9a1 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -86,6 +86,18 @@ config TOUCHSCREEN_AD7879_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7879-spi.
 
+config TOUCHSCREEN_AR1021_I2C
+	tristate "Microchip AR1021 i2c touchscreen"
+	depends on I2C && OF
+	help
+	  Say Y here if you have the Microchip AR1021 touchscreen controller
+	  chip in your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called microchip_ar1021_i2c.
+
 config TOUCHSCREEN_ATMEL_MXT
 	tristate "Atmel mXT I2C Touchscreen"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 62801f2..efaa328 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_TOUCHSCREEN_AD7879)	+= ad7879.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879_I2C)	+= ad7879-i2c.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879_SPI)	+= ad7879-spi.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
+obj-$(CONFIG_TOUCHSCREEN_AR1021_I2C)	+= ar1021_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+= atmel_mxt_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
 obj-$(CONFIG_TOUCHSCREEN_AUO_PIXCIR)	+= auo-pixcir-ts.o
diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
new file mode 100644
index 0000000..c77ce05
--- /dev/null
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -0,0 +1,201 @@
+/*
+ * Microchip AR1021 driver for I2C
+ *
+ * Author: Christian Gmeiner <christian.gmeiner@gmail.com>
+ *
+ * License: GPL as published by the FSF.
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/gpio.h>
+#include <asm/unaligned.h>
+
+#define AR1021_TOCUH_PKG_SIZE	5
+
+struct ar1021_i2c {
+	struct i2c_client *client;
+	struct input_dev *input;
+	u8 data[AR1021_TOCUH_PKG_SIZE];
+};
+
+static irqreturn_t ar1021_i2c_irq(int irq, void *dev_id)
+{
+	struct ar1021_i2c *ar1021 = dev_id;
+	struct input_dev *input = ar1021->input;
+	u8 *data = ar1021->data;
+	unsigned int x, y, button;
+	int error;
+
+	error = i2c_master_recv(ar1021->client,
+				ar1021->data, sizeof(ar1021->data));
+	if (error < 0)
+		goto out;
+
+	button = !(data[0] & BIT(0));
+	x = ((data[2] & 0x1f) << 7) | (data[1] & 0x7f);
+	y = ((data[4] & 0x1f) << 7) | (data[3] & 0x7f);
+
+	input_report_key(input, BTN_TOUCH, button);
+	input_report_abs(input, ABS_X, x);
+	input_report_abs(input, ABS_Y, y);
+	input_sync(input);
+
+out:
+	return IRQ_HANDLED;
+}
+
+static int ar1021_i2c_open(struct input_dev *dev)
+{
+	struct ar1021_i2c *wac_i2c = input_get_drvdata(dev);
+	struct i2c_client *client = wac_i2c->client;
+
+	enable_irq(client->irq);
+
+	return 0;
+}
+
+static void ar1021_i2c_close(struct input_dev *dev)
+{
+	struct ar1021_i2c *wac_i2c = input_get_drvdata(dev);
+	struct i2c_client *client = wac_i2c->client;
+
+	disable_irq(client->irq);
+}
+
+static int ar1021_i2c_probe(struct i2c_client *client,
+				     const struct i2c_device_id *id)
+{
+	struct ar1021_i2c *ar1021;
+	struct input_dev *input;
+	int error;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(&client->dev, "i2c_check_functionality error\n");
+		return -EIO;
+	}
+
+	ar1021 = devm_kzalloc(client->dev, sizeof(*ar1021), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!ar1021 || !input) {
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	ar1021->client = client;
+	ar1021->input = input;
+
+	input->name = "ar1021 I2C Touchscreen";
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = &client->dev;
+	input->open = ar1021_i2c_open;
+	input->close = ar1021_i2c_close;
+
+	input->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+
+	__set_bit(BTN_TOOL_PEN, input->keybit);
+
+	input_set_abs_params(input, ABS_X, 0, 4095, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, 4095, 0, 0);
+
+	input_set_drvdata(input, ar1021);
+
+	error = request_threaded_irq(client->irq, NULL, ar1021_i2c_irq,
+				     IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+				     "ar1021_i2c", ar1021);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to enable IRQ, error: %d\n", error);
+		goto err_free_mem;
+	}
+
+	/* Disable the IRQ, we'll enable it in wac_i2c_open() */
+	disable_irq(client->irq);
+
+	error = input_register_device(ar1021->input);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to register input device, error: %d\n", error);
+		goto err_free_irq;
+	}
+
+	i2c_set_clientdata(client, ar1021);
+	return 0;
+
+err_free_irq:
+	free_irq(client->irq, ar1021);
+err_free_mem:
+	input_free_device(input);
+
+	return error;
+}
+
+static int ar1021_i2c_remove(struct i2c_client *client)
+{
+	struct ar1021_i2c *ar1021 = i2c_get_clientdata(client);
+
+	free_irq(client->irq, ar1021);
+	input_unregister_device(ar1021->input);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int ar1021_i2c_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	disable_irq(client->irq);
+
+	return 0;
+}
+
+static int ar1021_i2c_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	enable_irq(client->irq);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(ar1021_i2c_pm, ar1021_i2c_suspend, ar1021_i2c_resume);
+
+static const struct i2c_device_id ar1021_i2c_id[] = {
+	{ "MICROCHIP_AR1021_I2C", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, ar1021_i2c_id);
+
+#ifdef CONFIG_OF
+static struct of_device_id ar1021_i2c_of_match[] = {
+	{ .compatible = "mc,ar1021-i2c", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ar1021_i2c_of_match);
+#endif
+
+static struct i2c_driver ar1021_i2c_driver = {
+	.driver	= {
+		.name	= "ar1021_i2c",
+		.owner	= THIS_MODULE,
+		.pm	= &ar1021_i2c_pm,
+		.of_match_table = of_match_ptr(ar1021_i2c_of_match),
+	},
+
+	.probe		= ar1021_i2c_probe,
+	.remove		= ar1021_i2c_remove,
+	.id_table	= ar1021_i2c_id,
+};
+module_i2c_driver(ar1021_i2c_driver);
+
+MODULE_AUTHOR("Christian Gmeiner <christian.gmeiner@gmail.com>");
+MODULE_DESCRIPTION("Microchip AR1021 I2C Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:ar1021_i2c");
-- 
1.7.10.4

