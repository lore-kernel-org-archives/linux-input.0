From: Jelle van der Waa <jelle@vdwaa.nl>
Subject: [PATCH] input: touchscreen: add driver for Zeitec ZET6223
Date: Fri,  9 Sep 2016 20:58:36 +0200
Message-ID: <20160909185836.2708-1-jelle@vdwaa.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34572 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754674AbcIITBL (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 9 Sep 2016 15:01:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id w12so3966199wmf.1
        for <linux-input@vger.kernel.org>; Fri, 09 Sep 2016 12:01:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org
Cc: Jelle van der Waa <jelle@vdwaa.nl>

This is a basic driver for the Zeitec ZET6223 I2C touchscreen controllers.
The driver does not support firmware loading, which is not required for
all tablets which contain this chip.

Signed-off-by: Jelle van der Waa <jelle@vdwaa.nl>
---
 .../bindings/input/touchscreen/zet6223.txt         |  33 ++++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/input/touchscreen/Kconfig                  |  11 ++
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/zet6223.c                | 190 +++++++++++++++++++++
 5 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
 create mode 100644 drivers/input/touchscreen/zet6223.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt b/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
new file mode 100644
index 0000000..bdb2c55
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
@@ -0,0 +1,33 @@
+* Zeitec ZET6223 I2C touchscreen controller
+
+Required properties:
+ - compatible		  : "zeitec,zet6223"
+ - reg			  : I2C slave address of the chip (0x76)
+ - interrupt-parent	  : a phandle pointing to the interrupt controller
+			    serving the interrupt for this chip
+ - interrupts		  : interrupt specification for the zet6223 interrupt
+ - power-gpios		  : Specification for the pin connected to the gsl1680's
+			    shutdown input. This needs to be driven high to take the
+			    gsl1680 out of its low power state
+
+Optional properties:
+
+- touchscreen-size-x	  : See touchscreen.txt
+- touchscreen-size-y	  : See touchscreen.txt
+- touchscreen-inverted-x  : See touchscreen.txt
+- touchscreen-inverted-y  : See touchscreen.txt
+- touchscreen-swapped-x-y : See touchscreen.txt
+
+Example:
+
+i2c@00000000 {
+
+	zet6223: touchscreen@76 {
+		compatible = "zeitec,zet6223";
+		reg = <0x76>;
+		interrupt-parent = <&pio>;
+		interrupts = <6 11 IRQ_TYPE_EDGE_FALLING>
+		power-gpios = <&pio 1 3 GPIO_ACTIVE_HIGH>;
+	};
+
+};
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 1992aa9..1c2cf45 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -295,5 +295,6 @@ xillybus	Xillybus Ltd.
 xlnx	Xilinx
 zyxel	ZyXEL Communications Corp.
 zarlink	Zarlink Semiconductor
+zeitec  ZEITEC Semiconductor Co., LTD.
 zii	Zodiac Inflight Innovations
 zte	ZTE Corp.
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 2fb1f43..1fa4671 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1206,4 +1206,15 @@ config TOUCHSCREEN_ROHM_BU21023
 	  To compile this driver as a module, choose M here: the
 	  module will be called bu21023_ts.
 
+config TOUCHSCREEN_ZET6223
+	tristate "Zeitec ZET6223 touchscreen driver"
+	depends on I2C
+	help
+	  Say Y here if you have a touchscreen using Zeitec ZET6223
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called zet6223.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index b4373d6..af4608d 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -99,3 +99,4 @@ obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ZFORCE)	+= zforce_ts.o
 obj-$(CONFIG_TOUCHSCREEN_COLIBRI_VF50)	+= colibri-vf50-ts.o
 obj-$(CONFIG_TOUCHSCREEN_ROHM_BU21023)	+= rohm_bu21023.o
+obj-$(CONFIG_TOUCHSCREEN_ZET6223)	+= zet6223.o
diff --git a/drivers/input/touchscreen/zet6223.c b/drivers/input/touchscreen/zet6223.c
new file mode 100644
index 0000000..661ca0f
--- /dev/null
+++ b/drivers/input/touchscreen/zet6223.c
@@ -0,0 +1,190 @@
+/*
+ * Copyright (C) 2016, Jelle van der Waa <jelle@vdwaa.nl>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ *  more details.
+ */
+
+#include <asm/unaligned.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/module.h>
+
+#define ZET6223_CMD_INFO 0xB2
+#define ZET6223_CMD_INFO_LENGTH 17
+#define ZET6223_VALID_PACKET 0x3c
+
+struct zet6223_data {
+	struct gpio_desc *power_gpios;
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct touchscreen_properties prop;
+	u8 fingernum;
+};
+
+static int zet6223_start(struct input_dev *dev)
+{
+		struct zet6223_data *data = input_get_drvdata(dev);
+
+		enable_irq(data->client->irq);
+
+		return 0;
+}
+
+static void zet6223_stop(struct input_dev *dev)
+{
+		struct zet6223_data *data = input_get_drvdata(dev);
+
+		disable_irq(data->client->irq);
+}
+
+static irqreturn_t irqreturn_t_zet6223(int irq, void *dev_id)
+{
+	struct zet6223_data *data = dev_id;
+	// First 3 bytes are an identifier, two bytes of finger data.
+	// X, Y data per finger is 4 bytes.
+	u8 bufsize = 3 + 4 * data->fingernum;
+	u8 buf[bufsize];
+	u8 i;
+	int ret;
+
+	ret = i2c_master_recv(data->client, buf, bufsize);
+	if (ret != bufsize)
+		return IRQ_HANDLED;
+
+	if (buf[0] != ZET6223_VALID_PACKET)
+		return IRQ_HANDLED;
+
+	for (i = 0; i < data->fingernum; i++) {
+		if (!(buf[i / 8 + 1] & (0x80 >> (i % 8))))
+			continue;
+
+		input_mt_slot(data->input, i);
+		input_mt_report_slot_state(data->input, MT_TOOL_FINGER, true);
+		input_event(data->input, EV_ABS, ABS_MT_POSITION_X,
+				((buf[i + 3] >> 4) << 8) + buf[i + 4]);
+		input_event(data->input, EV_ABS, ABS_MT_POSITION_Y,
+				((buf[i + 3] & 0xF) << 8) + buf[i + 5]);
+	}
+
+	input_mt_sync_frame(data->input);
+	input_sync(data->input);
+
+	return IRQ_HANDLED;
+}
+
+static int zet6223_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct zet6223_data *data;
+	struct input_dev *input;
+	u8 buf[ZET6223_CMD_INFO_LENGTH];
+	u8 cmd = ZET6223_CMD_INFO;
+	int ret, error;
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
+	if (IS_ERR(data->power_gpios)) {
+		error = PTR_ERR(data->power_gpios);
+		if (error != -EPROBE_DEFER)
+			dev_err(dev, "Error getting power gpio: %d\n", error);
+		return error;
+	}
+
+	ret = i2c_master_send(client, &cmd, 1);
+	if (ret < 0) {
+		dev_err(dev, "touchpanel info cmd failed: %d\n", ret);
+		return -ENODEV;
+	}
+
+	ret = i2c_master_recv(client, buf, ZET6223_CMD_INFO_LENGTH);
+	if (ret < 0) {
+		dev_err(dev, "cannot retrieve touchpanel info:  %d\n", ret);
+		return -ENODEV;
+	}
+
+	data->fingernum = buf[15] & 0x7F;
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0,
+			get_unaligned_le16(&buf[8]), 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0,
+			get_unaligned_le16(&buf[10]), 0, 0);
+	touchscreen_parse_properties(input, true, &data->prop);
+
+	input->name = client->name;
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = dev;
+	input->open = zet6223_start;
+	input->close = zet6223_stop;
+
+	ret = input_mt_init_slots(input, data->fingernum,
+		INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK);
+	if (ret)
+		return ret;
+
+	data->client = client;
+	data->input = input;
+
+	input_set_drvdata(input, data);
+
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+			irqreturn_t_zet6223, IRQF_ONESHOT, client->name, data);
+	if (ret) {
+		dev_err(dev, "Error requesting irq: %d\n", ret);
+		return ret;
+	}
+
+	zet6223_stop(input);
+
+	ret = input_register_device(input);
+	if (ret)
+		return ret;
+
+	i2c_set_clientdata(client, data);
+
+	return 0;
+}
+
+static const struct i2c_device_id zet6223_id[] = {
+	{ "zet6223", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, zet6223_id);
+
+static struct i2c_driver zet6223_driver = {
+	.driver = {
+		.name = "zet6223",
+	},
+	.probe = zet6223_probe,
+	.id_table = zet6223_id
+};
+
+module_i2c_driver(zet6223_driver);
+
+MODULE_AUTHOR("Jelle van der Waa <jelle@vdwaa.nl>");
+MODULE_DESCRIPTION("ZEITEC zet622x I2C touchscreen driver");
+MODULE_LICENSE("GPL");
-- 
2.9.3

