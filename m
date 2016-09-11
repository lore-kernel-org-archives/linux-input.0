From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 5/5] input: touchscreen: Add support for Elan eKTF2127 touchscreen controller
Date: Sun, 11 Sep 2016 20:44:08 +0200
Message-ID: <20160911184408.11657-6-hdegoede@redhat.com>
References: <20160911184408.11657-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33584 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932190AbcIKSo0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 11 Sep 2016 14:44:26 -0400
In-Reply-To: <20160911184408.11657-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>, Michel Verlaan <michel.verl@gmail.com>, Hans de Goede <hdegoede@redhat.com>

From: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>

This adds a driver for the Elan eKTF2127 touchscreen controller,
which speaks an i2c protocol which is distinctly different from
the already supported eKTH controllers.

Signed-off-by: Michel Verlaan <michel.verl@gmail.com>
Signed-off-by: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
-Improve devicetree bindings document
-Use touchscreen_parse_properties and touchscreen_report_pos instead of DIY
-Remove a bunch of unused defines (copy and paste leftover from chipone driver)
-Some other minor cleanups and review comments addressed
-Add defines for some command / address hex-values
-Check packet header in interrupt handler
---
 .../bindings/input/touchscreen/ektf2127.txt        |  27 ++
 drivers/input/touchscreen/Kconfig                  |  12 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/ektf2127.c               | 333 +++++++++++++++++++++
 4 files changed, 373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
 create mode 100644 drivers/input/touchscreen/ektf2127.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt b/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
new file mode 100644
index 0000000..70a949b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
@@ -0,0 +1,27 @@
+* Elan eKTF2127 I2C touchscreen controller
+
+Required properties:
+ - compatible		  : "elan,ektf2127"
+ - reg			  : I2C slave address of the chip (0x40)
+ - interrupt-parent	  : a phandle pointing to the interrupt controller
+			    serving the interrupt for this chip
+ - interrupts		  : interrupt specification for the ektf2127 interrupt
+ - power-gpios		  : GPIO specification for the pin connected to the
+			    ektf2127's wake input. This needs to be driven high
+			    to take ektf2127 out of it's low power state
+
+For additional optional properties see: touchscreen.txt
+
+Example:
+
+i2c@00000000 {
+	ektf2127: touchscreen@15 {
+		compatible = "elan,ektf2127";
+		reg = <0x15>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>;
+		power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>;
+		touchscreen-inverted-x;
+		touchscreen-swapped-x-y;
+	};
+};
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 3b3d07a..880aa50 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -396,6 +396,18 @@ config TOUCHSCREEN_ELAN
 	  To compile this driver as a module, choose M here: the
 	  module will be called elants_i2c.
 
+config TOUCHSCREEN_EKTF2127
+	tristate "Elan eKTF2127 I2C touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have an Elan eKTF2127 touchscreen
+	  connected to your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ektf2127.
+
 config TOUCHSCREEN_ELO
 	tristate "Elo serial touchscreens"
 	select SERIO
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 33b2eb8..db876ef 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_TOUCHSCREEN_HAMPSHIRE)	+= hampshire.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
 obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ELAN)		+= elants_i2c.o
+obj-$(CONFIG_TOUCHSCREEN_EKTF2127)	+= ektf2127.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
new file mode 100644
index 0000000..512a394
--- /dev/null
+++ b/drivers/input/touchscreen/ektf2127.c
@@ -0,0 +1,333 @@
+/*
+ * Driver for ELAN eKTF2127 i2c touchscreen controller
+ *
+ * For this driver the layout of the Chipone icn8318 i2c
+ * touchscreencontroller is used.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * Author:
+ * Michel Verlaan <michel.verl@gmail.com>
+ * Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
+ *
+ * Original chipone_icn8318 driver:
+ * Hans de Goede <hdegoede@redhat.com>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+
+/* Packet header defines (first byte of data send / received) */
+#define EKTF2127_NOISE			0x40
+#define EKTF2127_RESPONSE		0x52
+#define EKTF2127_REQUEST		0x53
+#define EKTF2127_HELLO			0x55
+#define EKTF2127_REPORT			0x5d
+#define EKTF2127_CALIB_DONE		0x66
+
+/* Register deines (second byte of data send / received) */
+#define EKTF2127_ENV_NOISY		0x41
+#define EKTF2127_HEIGHT			0x60
+#define EKTF2127_WIDTH			0x63
+
+/* 2 bytes header + 5 * 3 bytes coordinates + 3 bytes pressure info + footer */
+#define EKTF2127_TOUCH_REPORT_SIZE	21
+#define EKTF2127_MAX_TOUCHES		5
+
+struct ektf2127_data {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct gpio_desc *power_gpios;
+	struct touchscreen_properties prop;
+};
+
+static void retrieve_coordinates(struct input_mt_pos *touches,
+				int touch_count, char *buf)
+{
+	int index = 0;
+	int i = 0;
+
+	for (i = 0; i < touch_count; i++) {
+		index = 2 + i * 3;
+
+		touches[i].x = (buf[index] & 0x0f);
+		touches[i].x <<= 8;
+		touches[i].x |= buf[index + 2];
+
+		touches[i].y = (buf[index] & 0xf0);
+		touches[i].y <<= 4;
+		touches[i].y |= buf[index + 1];
+	}
+}
+
+static irqreturn_t ektf2127_irq(int irq, void *dev_id)
+{
+	struct ektf2127_data *data = dev_id;
+	struct device *dev = &data->client->dev;
+	struct input_mt_pos touches[EKTF2127_MAX_TOUCHES];
+	int touch_count;
+	int slots[EKTF2127_MAX_TOUCHES];
+	char buff[EKTF2127_TOUCH_REPORT_SIZE];
+	int i, ret;
+
+	ret = i2c_master_recv(data->client, buff, EKTF2127_TOUCH_REPORT_SIZE);
+	if (ret != EKTF2127_TOUCH_REPORT_SIZE) {
+		dev_err(dev, "Error reading touch data\n");
+		return IRQ_HANDLED;
+	}
+
+	switch (buff[0]) {
+	case EKTF2127_REPORT:
+		/* Handled below */
+		break;
+	case EKTF2127_NOISE:
+		if (buff[1] == EKTF2127_ENV_NOISY)
+			dev_dbg(dev, "Environment is electically noisy\n");
+		return IRQ_HANDLED;
+	case EKTF2127_HELLO:
+	case EKTF2127_CALIB_DONE:
+		return IRQ_HANDLED;
+	default:
+		dev_err(dev, "Unexpected packet header byte %02x\n", buff[0]);
+		return IRQ_HANDLED;
+	}
+
+	touch_count = buff[1] & 0x07;
+
+	if (touch_count > EKTF2127_MAX_TOUCHES) {
+		dev_err(dev, "Too many touches %d > %d\n",
+			touch_count, EKTF2127_MAX_TOUCHES);
+		touch_count = EKTF2127_MAX_TOUCHES;
+	}
+
+	retrieve_coordinates(touches, touch_count, buff);
+	input_mt_assign_slots(data->input, slots, touches,
+			      touch_count, 0);
+
+	for (i = 0; i < touch_count; i++) {
+		input_mt_slot(data->input, slots[i]);
+		input_mt_report_slot_state(data->input, MT_TOOL_FINGER, true);
+		touchscreen_report_pos(data->input, &data->prop, touches[i].x,
+			touches[i].y, true);
+	}
+
+	input_mt_sync_frame(data->input);
+	input_sync(data->input);
+
+	return IRQ_HANDLED;
+}
+
+static int ektf2127_start(struct input_dev *dev)
+{
+	struct ektf2127_data *data = input_get_drvdata(dev);
+
+	enable_irq(data->client->irq);
+	gpiod_set_value_cansleep(data->power_gpios, 1);
+
+	return 0;
+}
+
+static void ektf2127_stop(struct input_dev *dev)
+{
+	struct ektf2127_data *data = input_get_drvdata(dev);
+
+	disable_irq(data->client->irq);
+	gpiod_set_value_cansleep(data->power_gpios, 0);
+}
+
+static int ektf2127_suspend(struct device *dev)
+{
+	struct ektf2127_data *data = i2c_get_clientdata(to_i2c_client(dev));
+
+	mutex_lock(&data->input->mutex);
+	if (data->input->users)
+		ektf2127_stop(data->input);
+	mutex_unlock(&data->input->mutex);
+
+	return 0;
+}
+
+static int ektf2127_resume(struct device *dev)
+{
+	struct ektf2127_data *data = i2c_get_clientdata(to_i2c_client(dev));
+
+	mutex_lock(&data->input->mutex);
+	if (data->input->users)
+		ektf2127_start(data->input);
+	mutex_unlock(&data->input->mutex);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(ektf2127_pm_ops, ektf2127_suspend,
+			ektf2127_resume);
+
+static int ektf2127_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct ektf2127_data *data;
+	struct input_dev *input;
+	char buff[4];
+	int error, max_x, max_y, ret = 0;
+
+	if (!client->irq) {
+		dev_err(dev, "Error no irq specified\n");
+		return -EINVAL;
+	}
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	/* This requests the gpio *and* turns on the touchscreen controller */
+	data->power_gpios = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);
+	if (IS_ERR(data->power_gpios)) {
+		error = PTR_ERR(data->power_gpios);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev, "Error getting power gpio: %d\n", error);
+		return error;
+	}
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->name = client->name;
+	input->id.bustype = BUS_I2C;
+	input->open = ektf2127_start;
+	input->close = ektf2127_stop;
+
+	data->client = client;
+
+	/* Read hello (ignore result, depends on initial power state) */
+	msleep(20);
+	i2c_master_recv(data->client, buff, 4);
+
+	/* Read resolution from chip */
+
+	/* Request width */
+	buff[0] = EKTF2127_REQUEST;
+	buff[1] = EKTF2127_WIDTH;
+	buff[2] = 0x00;
+	buff[3] = 0x00;
+	ret = i2c_master_send(data->client, buff, 4);
+	if (ret != 4) {
+		dev_err(dev, "Error requesting width\n");
+		return ret < 0 ? ret : -EIO;
+	}
+
+	msleep(20);
+
+	/* Read response */
+	ret = i2c_master_recv(data->client, buff, 4);
+	if (ret != 4) {
+		dev_err(dev, "Error receiving width\n");
+		return ret < 0 ? ret : -EIO;
+	}
+
+	if ((buff[0] == EKTF2127_RESPONSE) && (buff[1] == EKTF2127_WIDTH)) {
+		max_x = (((buff[3] & 0xf0) << 4) | buff[2]) - 1;
+	} else {
+		dev_err(dev, "Error unexpected width data\n");
+		return -EIO;
+	}
+
+	/* Request height */
+	buff[0] = EKTF2127_REQUEST;
+	buff[1] = EKTF2127_HEIGHT;
+	buff[2] = 0x00;
+	buff[3] = 0x00;
+	ret = i2c_master_send(data->client, buff, 4);
+	if (ret != 4) {
+		dev_err(dev, "Error requesting height\n");
+		return ret < 0 ? ret : -EIO;
+	}
+
+	msleep(20);
+
+	/* Read response */
+	ret = i2c_master_recv(data->client, buff, 4);
+	if (ret != 4) {
+		dev_err(dev, "Error receiving height\n");
+		return ret < 0 ? ret : -EIO;
+	}
+
+	if ((buff[0] == EKTF2127_RESPONSE) && (buff[1] == EKTF2127_HEIGHT)) {
+		max_y = (((buff[3] & 0xf0) << 4) | buff[2]) - 1;
+	} else {
+		dev_err(dev, "Error unexpected height data\n");
+		return -EIO;
+	}
+
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, max_x, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, max_y, 0, 0);
+	touchscreen_parse_properties(input, true, &data->prop);
+
+	error = input_mt_init_slots(input, EKTF2127_MAX_TOUCHES,
+				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED
+				    | INPUT_MT_TRACK);
+	if (error)
+		return error;
+
+	data->input = input;
+	input_set_drvdata(input, data);
+
+	error = devm_request_threaded_irq(dev, client->irq, NULL, ektf2127_irq,
+					  IRQF_ONESHOT, client->name, data);
+	if (error) {
+		dev_err(dev, "Error requesting irq: %d\n", error);
+		return error;
+	}
+
+	/* Stop device till opened */
+	ektf2127_stop(data->input);
+
+	error = input_register_device(input);
+	if (error)
+		return error;
+
+	i2c_set_clientdata(client, data);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id ektf2127_of_match[] = {
+	{ .compatible = "elan,ektf2127" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ektf2127_of_match);
+#endif
+
+static const struct i2c_device_id ektf2127_i2c_id[] = {
+	{ "ektf2127", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ektf2127_i2c_id);
+
+static struct i2c_driver ektf2127_driver = {
+	.driver = {
+		.name	= "elan_ektf2127",
+		.pm	= &ektf2127_pm_ops,
+		.of_match_table = of_match_ptr(ektf2127_of_match),
+	},
+	.probe = ektf2127_probe,
+	.id_table = ektf2127_i2c_id,
+};
+
+module_i2c_driver(ektf2127_driver);
+
+MODULE_DESCRIPTION("ELAN eKTF2127 I2C Touchscreen Driver");
+MODULE_AUTHOR("Michel Verlaan, Siebren Vroegindeweij");
+MODULE_LICENSE("GPL");
-- 
2.9.3

