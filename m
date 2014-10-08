From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: [PATCH] Input: Add Microchip AR1021 i2c touchscreen
Date: Wed,  8 Oct 2014 16:45:18 +0200
Message-ID: <1412779518-16712-1-git-send-email-christian.gmeiner@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:41486 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbaJHOpY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Oct 2014 10:45:24 -0400
Received: by mail-wi0-f175.google.com with SMTP id d1so10791854wiv.8
        for <linux-input@vger.kernel.org>; Wed, 08 Oct 2014 07:45:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Christian Gmeiner <christian.gmeiner@gmail.com>

This patch adds support for the ar1021 i2c based touchscreen.
The driver is quite simple and only supports the Touch
Reporting Protocol.

This is the final version for an RFC patch send a while ago.
http://www.spinics.net/lists/linux-input/msg29419.html

Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
---
 drivers/input/touchscreen/Kconfig      |  12 +++
 drivers/input/touchscreen/Makefile     |   1 +
 drivers/input/touchscreen/ar1021_i2c.c | 183 +++++++++++++++++++++++++++++++++
 3 files changed, 196 insertions(+)
 create mode 100644 drivers/input/touchscreen/ar1021_i2c.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 6bb9a7d..e1d8003 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -90,6 +90,18 @@ config TOUCHSCREEN_AD7879_SPI
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
+	  module will be called ar1021_i2c.
+
 config TOUCHSCREEN_ATMEL_MXT
 	tristate "Atmel mXT I2C Touchscreen"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 4be94fc..090e61c 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_TOUCHSCREEN_AD7879)	+= ad7879.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879_I2C)	+= ad7879-i2c.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879_SPI)	+= ad7879-spi.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
+obj-$(CONFIG_TOUCHSCREEN_AR1021_I2C)	+= ar1021_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+= atmel_mxt_ts.o
 obj-$(CONFIG_TOUCHSCREEN_AUO_PIXCIR)	+= auo-pixcir-ts.o
 obj-$(CONFIG_TOUCHSCREEN_BU21013)	+= bu21013_ts.o
diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
new file mode 100644
index 0000000..566014a
--- /dev/null
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -0,0 +1,183 @@
+/*
+ * Microchip AR1021 driver for I2C
+ *
+ * Author: Christian Gmeiner <christian.gmeiner@gmail.com>
+ *
+ * License: GPLv2 as published by the FSF.
+ */
+
+#include <linux/module.h>
+#include <linux/input.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#define AR1021_TOCUH_PKG_SIZE	5
+
+const int MAX_X = 4095;
+const int MAX_Y = 4095;
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
+	/* sync bit set ? */
+	if ((data[0] & 0x80) == 0)
+		goto out;
+
+	button = data[0] & BIT(0);
+	x = ((data[2] & 0x1f) << 7) | (data[1] & 0x7f);
+	y = ((data[4] & 0x1f) << 7) | (data[3] & 0x7f);
+
+	input_report_abs(input, ABS_X, x);
+	input_report_abs(input, ABS_Y, y);
+	input_report_key(input, BTN_TOUCH, button);
+	input_sync(input);
+
+out:
+	return IRQ_HANDLED;
+}
+
+static int ar1021_i2c_open(struct input_dev *dev)
+{
+	struct ar1021_i2c *ar1021 = input_get_drvdata(dev);
+	struct i2c_client *client = ar1021->client;
+
+	enable_irq(client->irq);
+
+	return 0;
+}
+
+static void ar1021_i2c_close(struct input_dev *dev)
+{
+	struct ar1021_i2c *ar1021 = input_get_drvdata(dev);
+	struct i2c_client *client = ar1021->client;
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
+	ar1021 = devm_kzalloc(&client->dev, sizeof(*ar1021), GFP_KERNEL);
+
+	input = devm_input_allocate_device(&client->dev);
+	if (!ar1021 || !input)
+		return -ENOMEM;
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
+	__set_bit(BTN_TOUCH, input->keybit);
+
+	input_set_abs_params(input, ABS_X, 0, MAX_X, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, MAX_Y, 0, 0);
+
+	input_set_drvdata(input, ar1021);
+
+	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+			ar1021_i2c_irq, IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+			"ar1021_i2c", ar1021);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to enable IRQ, error: %d\n", error);
+		return error;
+	}
+
+	/* Disable the IRQ, we'll enable it in ar1021_i2c_open() */
+	disable_irq(client->irq);
+
+	error = input_register_device(ar1021->input);
+	if (error) {
+		dev_err(&client->dev,
+			"Failed to register input device, error: %d\n", error);
+		return error;
+	}
+
+	i2c_set_clientdata(client, ar1021);
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
+static struct of_device_id ar1021_i2c_of_match[] = {
+	{ .compatible = "microchip,ar1021-i2c", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ar1021_i2c_of_match);
+
+static struct i2c_driver ar1021_i2c_driver = {
+	.driver	= {
+		.name	= "ar1021_i2c",
+		.owner	= THIS_MODULE,
+		.pm	= &ar1021_i2c_pm,
+		.of_match_table = ar1021_i2c_of_match,
+	},
+
+	.probe		= ar1021_i2c_probe,
+	.id_table	= ar1021_i2c_id,
+};
+module_i2c_driver(ar1021_i2c_driver);
+
+MODULE_AUTHOR("Christian Gmeiner <christian.gmeiner@gmail.com>");
+MODULE_DESCRIPTION("Microchip AR1021 I2C Driver");
+MODULE_LICENSE("GPL");
-- 
1.9.3

