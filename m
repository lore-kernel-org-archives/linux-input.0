From: Siebren Vroegindeweij <siebren.vroegindeweij@gmail.com>
Subject: [PATCH v1] Add support for the ektf2127 touchscreencontroller
Date: Mon,  4 Jul 2016 11:29:05 +0200
Message-ID: <1467624545-3455-2-git-send-email-siebren.vroegindeweij@gmail.com>
References: <1467624545-3455-1-git-send-email-siebren.vroegindeweij@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36377 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbcGDJ3Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2016 05:29:24 -0400
In-Reply-To: <1467624545-3455-1-git-send-email-siebren.vroegindeweij@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Michel Verlaan <michel.verl@gmail.com>, Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>

From: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>

The ELAN eKTF2127 driver is written for the ELAN series of
touchscreencontrollers. This version is especially written for the
eKTF2127 controller. The driver communicates to the controller over i2c.
The additional screen specifications can be read from the devicetree file.
The driver has also the ability to read the screen height and width from
the controller. When the screen is pressed, a interrupt is generated.
The interrupt wil be handled by a function that request a data string from
the controller. This string is then modified so that the right number of touches
and their x and y coordinates are available and given to userspace through
the input subsystem.

Signed-off-by: Michel Verlaan <michel.verl@gmail.com>
Signed-off-by: Siebren Vroegindeweij <siebren.vroegindeweij@hotmail.com>
---
 .../bindings/input/touchscreen/ektf2127.txt        |  40 +++
 drivers/input/touchscreen/Kconfig                  |  11 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/ektf2127.c               | 351 +++++++++++++++++++++
 4 files changed, 403 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
 create mode 100644 drivers/input/touchscreen/ektf2127.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt b/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
new file mode 100644
index 0000000..a774336
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
@@ -0,0 +1,40 @@
+* Elan eKTF2127 I2C touchscreen controller
+
+Required properties:
+ - compatible		  : "elan,ektf2127"
+ - reg			  : I2C slave address of the chip (0x40)
+ - interrupt-parent	  : a phandle pointing to the interrupt controller
+			    serving the interrupt for this chip
+ - interrupts		  : interrupt specification for the eKTF2127 interrupt
+ - wake-gpios		  : GPIO specification for the WAKE input
+
+Optional properties:
+ - touchscreen-size-x	  : horizontal resolution of touchscreen (in pixels)
+ - touchscreen-size-y	  : vertical resolution of touchscreen (in pixels)
+ - touchscreen-fuzz-x	  : horizontal noise value of the absolute input
+			    device (in pixels)
+ - touchscreen-fuzz-y	  : vertical noise value of the absolute input
+			    device (in pixels)
+ - touchscreen-inverted-x : X axis is inverted (boolean)
+ - touchscreen-inverted-y : Y axis is inverted (boolean)
+ - touchscreen-swapped-x-y	  : X and Y axis are swapped (boolean)
+			    Swapping is done after inverting the axis
+
+Example:
+
+i2c@00000000 {
+
+	ektf2127: touchscreen@40 {
+		compatible = "elan,ektf2127";
+		reg = <0x40>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>
+		/* pinctrl-names = "default";
+		pinctrl-0 = <&ts_wake_pin_p66>; */
+		power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>;
+		touchscreen-inverted-x;
+		touchscreen-swapped-x-y;
+	};
+
+};
+
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 66c6264..28fd425 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1133,4 +1133,15 @@ config TOUCHSCREEN_ROHM_BU21023
 	  To compile this driver as a module, choose M here: the
 	  module will be called bu21023_ts.
 
+config TOUCHSCREEN_EKTF2127
+	tristate "ektf2127 I2C touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have a touchscreen using ektf2127.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ektf2127.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 968ff12..bc0db43 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -93,3 +93,4 @@ obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
 obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
+obj-$(CONFIG_TOUCHSCREEN_EKTF2127)	+= ektf2127.o
diff --git a/drivers/input/touchscreen/ektf2127.c b/drivers/input/touchscreen/ektf2127.c
new file mode 100644
index 0000000..e57fbbd
--- /dev/null
+++ b/drivers/input/touchscreen/ektf2127.c
@@ -0,0 +1,351 @@
+/*
+ * Driver for ELAN eKTF2127 i2c touchscreen controller
+ *
+ * For this driver the layout of the Chipone icn8318 i2c
+ * touchscreencontroller is used.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 3 of the License, or
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
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+
+#define EKTF2127_REG_POWER		4
+#define EKTF2127_REG_TOUCHDATA		16
+
+#define EKTF2127_POWER_ACTIVE		0
+#define EKTF2127_POWER_MONITOR		1
+#define EKTF2127_POWER_HIBERNATE	2
+
+#define EKTF2127_MAX_TOUCHES		5
+
+/* The difference between 2 and 3 is unclear */
+#define EKTF2127_EVENT_NO_DATA	1 /* No finger seen yet since wakeup */
+#define EKTF2127_EVENT_UPDATE1	2 /* New or updated coordinates */
+#define EKTF2127_EVENT_UPDATE2	3 /* New or updated coordinates */
+#define EKTF2127_EVENT_END	4 /* Finger lifted */
+
+struct ektf2127_data {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct gpio_desc *power_gpios;
+	u32 max_x;
+	u32 max_y;
+	bool invert_x;
+	bool invert_y;
+	bool swap_x_y;
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
+	char buff[25];
+	int i, ret;
+
+	ret = i2c_master_recv(data->client, buff, 25);
+	if (ret != 25) {
+		dev_err(dev, "Error reading touch data");
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
+
+	for (i = 0; i < touch_count; i++) {
+
+		input_mt_assign_slots(data->input, slots, touches,
+			touch_count, 0);
+
+		input_mt_slot(data->input, slots[i]);
+		input_mt_report_slot_state(data->input, MT_TOOL_FINGER, true);
+
+		input_event(data->input, EV_ABS, ABS_MT_POSITION_X,
+			touches[i].x);
+		input_event(data->input, EV_ABS, ABS_MT_POSITION_Y,
+			touches[i].y);
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
+	struct device_node *np = dev->of_node;
+	struct ektf2127_data *data;
+	struct input_dev *input;
+
+	u32 fuzz_x = 0, fuzz_y = 0;
+	char buff[25];
+	int error, ret = 0;
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
+	data->power_gpios = devm_gpiod_get(dev, "power", GPIOD_OUT_HIGH);
+	msleep(20);
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
+	input->dev.parent = dev;
+
+	data->client = client;
+
+	/* read hello */
+	i2c_master_recv(data->client, buff, 4);
+
+	/* Read resolution from chip */
+
+	/* Request height */
+	buff[0] = 0x53; /* REQUEST */
+	buff[1] = 0x63; /* HEIGHT */
+	buff[2] = 0x00;
+	buff[3] = 0x00;
+	ret = i2c_master_send(data->client, buff, 4);
+	if (ret != 4) {
+		dev_err(dev, "Error requesting height");
+		return ret < 0 ? ret : -EIO;
+	}
+
+	msleep(20);
+
+	/* Read response */
+	ret = i2c_master_recv(data->client, buff, 4);
+	if (ret != 4) {
+		dev_err(dev, "Error receiving height");
+		return ret < 0 ? ret : -EIO;
+	}
+
+
+	if ((buff[0] == 0x52) && (buff[1] == 0x63)) {
+		data->max_y = ((buff[3] & 0xf0) << 4) | buff[2];
+	} else {
+		dev_err(dev, "Error receiving height data from"
+			" wrong register");
+		return ret < 0 ? ret : -EIO;
+	}
+
+	/* Request width */
+	buff[0] = 0x53; /* REQUEST */
+	buff[1] = 0x60; /* WIDTH */
+	buff[2] = 0x00;
+	buff[3] = 0x00;
+	ret = i2c_master_send(data->client, buff, 4);
+	if (ret != 4) {
+		dev_err(dev, "Error requesting width");
+		return ret < 0 ? ret : -EIO;
+	}
+
+	msleep(20);
+
+	/* Read response */
+	ret = i2c_master_recv(data->client, buff, 4);
+	if (ret != 4) {
+		dev_err(dev, "Error receiving width");
+		return ret < 0 ? ret : -EIO;
+	}
+
+
+	if ((buff[0] == 0x52) && (buff[1] == 0x60)) {
+		data->max_x = (((buff[3] & 0xf0) << 4) | buff[2]);
+	} else {
+		dev_err(dev, "Error receiving width data from"
+			" wrong register");
+		return ret < 0 ? ret : -EIO;
+	}
+
+
+	/* Touchscreen resolution can be overruled by devicetree*/
+	of_property_read_u32(np, "touchscreen-size-x", &data->max_x);
+	of_property_read_u32(np, "touchscreen-size-y", &data->max_y);
+
+	/* Optional */
+	of_property_read_u32(np, "touchscreen-fuzz-x", &fuzz_x);
+	of_property_read_u32(np, "touchscreen-fuzz-y", &fuzz_y);
+	data->invert_x = of_property_read_bool(np, "touchscreen-inverted-x");
+	data->invert_y = of_property_read_bool(np, "touchscreen-inverted-y");
+	data->swap_x_y = of_property_read_bool(np, "touchscreen-swapped-x-y");
+
+	if (!data->swap_x_y) {
+		input_set_abs_params(input, ABS_MT_POSITION_X, 0,
+				     data->max_x, fuzz_x, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
+				     data->max_y, fuzz_y, 0);
+	} else {
+		input_set_abs_params(input, ABS_MT_POSITION_X, 0,
+				     data->max_y, fuzz_y, 0);
+		input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
+				     data->max_x, fuzz_x, 0);
+	}
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
+static const struct of_device_id ektf2127_of_match[] = {
+	{ .compatible = "elan,ektf2127" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ektf2127_of_match);
+
+/* This is useless for OF-enabled devices,
+ * but it is needed by I2C subsystem
+ */
+static const struct i2c_device_id ektf2127_i2c_id[] = {
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, ektf2127_i2c_id);
+
+static struct i2c_driver ektf2127_driver = {
+	.driver = {
+		.name	= "elan_ektf2127",
+		.pm	= &ektf2127_pm_ops,
+		.of_match_table = ektf2127_of_match,
+	},
+	.probe = ektf2127_probe,
+	.id_table = ektf2127_i2c_id,
+};
+
+module_i2c_driver(ektf2127_driver);
+
+MODULE_DESCRIPTION("ELAN eKTF2127 I2C Touchscreen Driver");
+MODULE_AUTHOR("Michel Verlaan");
+MODULE_AUTHOR("Siebren Vroegindeweij");
+MODULE_LICENSE("GPL");
-- 
2.5.5

