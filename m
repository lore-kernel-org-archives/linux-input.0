From: Ahmet Inan <inan@distec.de>
Subject: [PATCH] Input: Add I2C attached EETI EXC3000 multi touch driver
Date: Wed, 20 Sep 2017 15:51:29 +0200
Message-ID: <20170920135129.10283-1-inan@distec.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.datadisplay.de ([87.191.35.243]:33828 "EHLO
        mail.datadisplay.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdITN5l (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 20 Sep 2017 09:57:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ahmet Inan <xdsopl@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ahmet Inan <inan@distec.de>

The 3000 series have a new protocol which allows to report up to 5 points
in a single 66 byte frame. One must always read in 66 byte frames.
To support up to 10 points, two consecutive frames need to be read:
The first frame says how many points until sync.
The second frame must say zero points or be discarded.

To be able to work with the higher 400KHz I2C bus rate, one must
successfully send a special package prior _each_ read or the controller
will refuse to cooperate.

It is important not to rely on the i2c_master_recv return value:
Ignoring failed transfers sometimes causes hanging touch events, as the
controller thinks that the transfer succeeded and won't resend the event.

This is a minimal implementation based on egalax_i2c.c (which can be found
on the internet) and egalax_ts.c but without the vendor interface and no
power management support.

Signed-off-by: Ahmet Inan <inan@distec.de>
---
 .../bindings/input/touchscreen/exc3000.txt         |  18 +++
 drivers/input/touchscreen/Kconfig                  |  10 ++
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/exc3000.c                | 154 +++++++++++++++++++++
 4 files changed, 183 insertions(+)
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
index 0bf78ff1ae88..9ea2d9287b38 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -314,6 +314,16 @@ config TOUCHSCREEN_EGALAX_SERIAL
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
index f720bc30ada9..48118379fee7 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_TOUCHSCREEN_ELAN)		+= elants_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
 obj-$(CONFIG_TOUCHSCREEN_EGALAX_SERIAL)	+= egalax_ts_serial.o
+obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix.o
 obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
diff --git a/drivers/input/touchscreen/exc3000.c b/drivers/input/touchscreen/exc3000.c
new file mode 100644
index 000000000000..c8a1a8b04bf2
--- /dev/null
+++ b/drivers/input/touchscreen/exc3000.c
@@ -0,0 +1,154 @@
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
+
+#define NUM_SLOTS 10
+#define PER_FRAME 5
+#define LEN_FRAME 66
+#define LEN_POINT 10
+
+struct exc3000_data {
+	struct i2c_client *client;
+	struct input_dev *input;
+	unsigned char buf[2 * LEN_FRAME];
+};
+
+static void exc3000_process(struct input_dev *input,
+		unsigned char *buf, int num)
+{
+	while (num--) {
+		int dn, id, x, y;
+
+		dn = buf[0] & 1;
+		id = buf[1];
+		x = (buf[3] << 8) | buf[2];
+		y = (buf[5] << 8) | buf[4];
+		buf += LEN_POINT;
+		if (id >= NUM_SLOTS)
+			continue;
+		input_mt_slot(input, id);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, dn);
+		if (dn) {
+			input_report_abs(input, ABS_MT_POSITION_X, x);
+			input_report_abs(input, ABS_MT_POSITION_Y, y);
+		}
+	}
+}
+
+static int exc3000_read(struct i2c_client *client, unsigned char *buf)
+{
+	if (i2c_master_send(client, "'", 2) != 2)
+		return 1;
+	memset(buf, 0, LEN_FRAME);
+	i2c_master_recv(client, buf, LEN_FRAME);
+	return buf[0] != 0x42 || buf[1] != 0x00 || buf[2] != 0x06;
+}
+
+static irqreturn_t exc3000_interrupt(int irq, void *dev_id)
+{
+	struct exc3000_data *data = (struct exc3000_data *)dev_id;
+	struct i2c_client *client = data->client;
+	struct input_dev *input = data->input;
+	unsigned char *buf = data->buf;
+
+	if (exc3000_read(client, buf) || !buf[3] || buf[3] > NUM_SLOTS)
+		return IRQ_HANDLED;
+	if (buf[3] <= PER_FRAME) {
+		exc3000_process(input, buf + 4, buf[3]);
+	} else {
+		if (exc3000_read(client, buf + LEN_FRAME) || buf[LEN_FRAME + 3])
+			return IRQ_HANDLED;
+		exc3000_process(input, buf + 4, PER_FRAME);
+		exc3000_process(input, buf + LEN_FRAME + 4, buf[3] - PER_FRAME);
+	}
+	input_mt_report_pointer_emulation(input, true);
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
+	data = (struct exc3000_data *)devm_kzalloc(&client->dev,
+			sizeof(struct exc3000_data), GFP_KERNEL);
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
+	__set_bit(EV_ABS, input->evbit);
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(BTN_TOUCH, input->keybit);
+	input_set_abs_params(input, ABS_X, 0, 4096, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, 4096, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, 4096, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 4096, 0, 0);
+	input_mt_init_slots(input, NUM_SLOTS, 0);
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
+			exc3000_interrupt, IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+			client->name, data);
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
+static const struct of_device_id exc3000_dt_ids[] = {
+	{ .compatible = "eeti,exc3000" },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, exc3000_id);
+
+static struct i2c_driver exc3000_driver = {
+	.driver = {
+		.name	= "exc3000",
+		.of_match_table = exc3000_dt_ids,
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

