From: Ahmet Inan <inan@distec.de>
Subject: [PATCH] Input: Add I2C attached EETI EXC3000 multi touch driver
Date: Fri, 22 Sep 2017 14:30:42 +0200
Message-ID: <20170922123042.20401-1-inan@distec.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.datadisplay.de ([87.191.35.243]:35103 "EHLO
        mail.datadisplay.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752125AbdIVMdf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 22 Sep 2017 08:33:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ahmet Inan <xdsopl@gmail.com>, linux-input@vger.kernel.org, Ahmet Inan <inan@distec.de>

The 3000 series have a new protocol which allows to report up to 5 points
in a single 66 byte frame. One must always read in 66 byte frames.
To support up to 10 points, two consecutive frames need to be read:
The first frame says how many points until sync.
The second frame must say zero points or both frames must be discarded.

To be able to work with the higher 400KHz I2C bus rate, one must
successfully send a special package prior _each_ read or the controller
will refuse to cooperate.

This is a minimal implementation based on egalax_i2c.c (which can be found
on the internet) and egalax_ts.c but without the vendor interface and no
power management support.

Signed-off-by: Ahmet Inan <inan@distec.de>
---
 .../bindings/input/touchscreen/exc3000.txt         |  18 +++
 drivers/input/touchscreen/Kconfig                  |  10 ++
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/exc3000.c                | 152 +++++++++++++++++++++
 4 files changed, 181 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
 create mode 100644 drivers/input/touchscreen/exc3000.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/exc3000.txt b/Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
new file mode 100644
index 000000000000..9b6f0919abd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
@@ -0,0 +1,18 @@
+* EETI EXC3000 Multiple Touch Controller
+
+Required properties:
+- compatible: must be "eeti,exc3000"
+- reg: i2c slave address
+- interrupt-parent: the phandle for the interrupt controller
+- interrupts: touch controller interrupt
+- irq-gpios: the gpio pin to be used as irq pin
+
+Example:
+
+	exc3000@2a {
+		compatible = "eeti,exc3000";
+		reg = <0x2a>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 2>;
+		irq-gpios = <&gpio1 9 0>;
+	};
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 64b30fe273fd..dcf192c07122 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -316,6 +316,16 @@ config TOUCHSCREEN_EGALAX_SERIAL
 	  To compile this driver as a module, choose M here: the
 	  module will be called egalax_ts_serial.
 
+config TOUCHSCREEN_EXC3000
+	tristate "EETI EXC3000 multi-touch panel support"
+	depends on I2C
+	help
+	  Say Y here to enable support for I2C connected EETI
+	  EXC3000 multi-touch panels.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called exc3000.
+
 config TOUCHSCREEN_FUJITSU
 	tristate "Fujitsu serial touchscreen"
 	select SERIO
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 6badce87037b..a129df6b2300 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_TOUCHSCREEN_ELAN)		+= elants_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
+obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
new file mode 100644
index 000000000000..8899a6fae004
--- /dev/null
+++ b/drivers/input/touchscreen/exc3000.c
@@ -0,0 +1,152 @@
+/*
+ * Driver for I2C connected EETI EXC3000 multiple touch controller
+ *
+ * Copyright (C) 2017 Ahmet Inan <inan@distec.de>
+ *
+ * minimal implementation based on egalax_ts.c and egalax_i2c.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/irq.h>
+#include <linux/input/mt.h>
+#include <asm/unaligned.h>
+
+#define EXC3000_NUM_SLOTS	10
+#define EXC3000_SLOTS_PER_FRAME	5
+#define EXC3000_LEN_FRAME	66
+#define EXC3000_LEN_POINT	10
+#define EXC3000_MT_EVENT	6
+
+struct exc3000_data {
+	struct i2c_client *client;
+	struct input_dev *input;
+	u8 buf[2 * EXC3000_LEN_FRAME];
+};
+
+static void exc3000_process(struct input_dev *input, u8 *buf, int num)
+{
+	for (; num--; buf += EXC3000_LEN_POINT) {
+		input_mt_slot(input, buf[1]);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, buf[0] & 1);
+		if (buf[0] & 1) {
+			input_report_abs(input, ABS_MT_POSITION_X,
+					get_unaligned_le16(buf + 2));
+			input_report_abs(input, ABS_MT_POSITION_Y,
+					get_unaligned_le16(buf + 4));
+		}
+	}
+}
+
+static int exc3000_read(struct i2c_client *client, u8 *buf)
+{
+	return i2c_master_send(client, "'", 2) != 2 ||
+		i2c_master_recv(client, buf,
+		EXC3000_LEN_FRAME) != EXC3000_LEN_FRAME ||
+		get_unaligned_le16(buf) != EXC3000_LEN_FRAME ||
+		buf[2] != EXC3000_MT_EVENT;
+}
+
+static irqreturn_t exc3000_interrupt(int irq, void *dev_id)
+{
+	struct exc3000_data *data = dev_id;
+	struct i2c_client *client = data->client;
+	struct input_dev *input = data->input;
+	u8 *buf = data->buf;
+
+	if (exc3000_read(client, buf) || !buf[3] || buf[3] > EXC3000_NUM_SLOTS)
+		return IRQ_HANDLED;
+	if (buf[3] <= EXC3000_SLOTS_PER_FRAME) {
+		exc3000_process(input, buf + 4, buf[3]);
+	} else {
+		if (exc3000_read(client, buf + EXC3000_LEN_FRAME) ||
+				buf[EXC3000_LEN_FRAME + 3])
+			return IRQ_HANDLED;
+		exc3000_process(input, buf + 4, EXC3000_SLOTS_PER_FRAME);
+		exc3000_process(input, buf + EXC3000_LEN_FRAME + 4,
+				buf[3] - EXC3000_SLOTS_PER_FRAME);
+	}
+	input_mt_sync_frame(input);
+	input_sync(input);
+	return IRQ_HANDLED;
+}
+
+static int exc3000_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	struct exc3000_data *data;
+	struct input_dev *input;
+	int error;
+
+	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	input = devm_input_allocate_device(&client->dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->name = "EETI EXC3000 Touch Screen";
+	input->id.bustype = BUS_I2C;
+
+	input_set_abs_params(input, ABS_X, 0, 4095, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, 4095, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, 4095, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 4095, 0, 0);
+	input_set_capability(input, EV_KEY, BTN_TOUCH);
+
+	error = input_mt_init_slots(input, EXC3000_NUM_SLOTS,
+			INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (error)
+		return error;
+
+	error = input_register_device(input);
+	if (error)
+		return error;
+
+	data->input = input;
+	data->client = client;
+	i2c_set_clientdata(client, data);
+
+	error = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+			exc3000_interrupt, IRQF_ONESHOT, client->name, data);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static const struct i2c_device_id exc3000_id[] = {
+	{ "exc3000", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, exc3000_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id exc3000_of_match[] = {
+	{ .compatible = "eeti,exc3000" },
+	{ }
+};
+#endif
+
+static struct i2c_driver exc3000_driver = {
+	.driver = {
+		.name	= "exc3000",
+		.of_match_table = of_match_ptr(exc3000_of_match),
+	},
+	.id_table	= exc3000_id,
+	.probe		= exc3000_probe,
+};
+
+module_i2c_driver(exc3000_driver);
+
+MODULE_AUTHOR("Ahmet Inan <inan@distec.de>");
+MODULE_DESCRIPTION("I2C connected EETI EXC3000 multiple touch controller driver");
+MODULE_LICENSE("GPL");
-- 
2.11.0

