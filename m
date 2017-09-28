From: Ahmet Inan <inan@distec.de>
Subject: [PATCH] Input: Add I2C attached EETI EXC3000 multi touch driver
Date: Thu, 28 Sep 2017 17:23:17 +0200
Message-ID: <20170928152317.19098-1-inan@distec.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.datadisplay.de ([87.191.35.243]:61383 "EHLO
        mail.datadisplay.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752387AbdI1PXk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 28 Sep 2017 11:23:40 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ahmet Inan <xdsopl@gmail.com>, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Ahmet Inan <inan@distec.de>

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
 .../bindings/input/touchscreen/exc3000.txt         |  27 ++++
 drivers/input/touchscreen/Kconfig                  |  10 ++
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/exc3000.c                | 173 +++++++++++++++++++++
 4 files changed, 211 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
 create mode 100644 drivers/input/touchscreen/exc3000.c

diff --git a/Documentation/devicetree/bindings/input/touchscreen/exc3000.txt b/Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
new file mode 100644
index 000000000000..d2a78e83e921
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/exc3000.txt
@@ -0,0 +1,27 @@
+* EETI EXC3000 Multiple Touch Controller
+
+Required properties:
+- compatible: must be "eeti,exc3000"
+- reg: i2c slave address
+- interrupt-parent: the phandle for the interrupt controller
+- interrupts: touch controller interrupt
+- touchscreen-size-x: See touchscreen.txt
+- touchscreen-size-y: See touchscreen.txt
+
+Optional properties:
+- touchscreen-inverted-x: See touchscreen.txt
+- touchscreen-inverted-y: See touchscreen.txt
+- touchscreen-swapped-x-y: See touchscreen.txt
+
+Example:
+
+	exc3000@2a {
+		compatible = "eeti,exc3000";
+		reg = <0x2a>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <9 8>; // active low level-sensitive
+		touchscreen-size-x = <4096>;
+		touchscreen-size-y = <4096>;
+		touchscreen-inverted-x;
+		touchscreen-swapped-x-y;
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
index 000000000000..b822e064a17b
--- /dev/null
+++ b/drivers/input/touchscreen/exc3000.c
@@ -0,0 +1,173 @@
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
+#include <linux/input/touchscreen.h>
+#include <asm/unaligned.h>
+
+#define EXC3000_NUM_SLOTS	10
+#define EXC3000_SLOTS_PER_FRAME	5
+#define EXC3000_LEN_FRAME	66
+#define EXC3000_LEN_POINT	10
+#define EXC3000_MT_EVENT	6
+#define EXC3000_TIMEOUT		msecs_to_jiffies(100)
+
+struct exc3000_data {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct touchscreen_properties prop;
+	struct timer_list timer;
+	u8 buf[2 * EXC3000_LEN_FRAME];
+};
+
+static void exc3000_process(struct input_dev *input,
+		struct touchscreen_properties *prop, u8 *buf, int num)
+{
+	for (; num--; buf += EXC3000_LEN_POINT) {
+		if (buf[0] & 1) {
+			input_mt_slot(input, buf[1]);
+			input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
+			touchscreen_report_pos(input, prop,
+					get_unaligned_le16(buf + 2),
+					get_unaligned_le16(buf + 4), true);
+		}
+	}
+}
+
+static int exc3000_read(struct i2c_client *client, u8 *buf)
+{
+	return i2c_master_send(client, "'", 2) != 2 ||
+		i2c_master_recv(client, buf,
+				EXC3000_LEN_FRAME) != EXC3000_LEN_FRAME ||
+		get_unaligned_le16(buf) != EXC3000_LEN_FRAME ||
+		buf[2] != EXC3000_MT_EVENT;
+}
+
+static void exc3000_timer(unsigned long data)
+{
+	struct input_dev *input = (void *)data;
+
+	input_mt_sync_frame(input);
+	input_sync(input);
+}
+
+static irqreturn_t exc3000_interrupt(int irq, void *dev_id)
+{
+	struct exc3000_data *data = dev_id;
+	struct i2c_client *client = data->client;
+	struct input_dev *input = data->input;
+	struct touchscreen_properties *prop = &data->prop;
+	struct timer_list *timer = &data->timer;
+	u8 *buf = data->buf;
+
+	if (exc3000_read(client, buf) ||
+			!buf[3] || buf[3] > EXC3000_NUM_SLOTS) {
+		mod_timer(timer, jiffies + EXC3000_TIMEOUT);
+		return IRQ_HANDLED;
+	}
+	if (buf[3] <= EXC3000_SLOTS_PER_FRAME) {
+		del_timer_sync(timer);
+		exc3000_process(input, prop, buf + 4, buf[3]);
+	} else {
+		if (exc3000_read(client, buf + EXC3000_LEN_FRAME) ||
+				buf[EXC3000_LEN_FRAME + 3]) {
+			mod_timer(timer, jiffies + EXC3000_TIMEOUT);
+			return IRQ_HANDLED;
+		}
+		del_timer_sync(timer);
+		exc3000_process(input, prop, buf + 4, EXC3000_SLOTS_PER_FRAME);
+		exc3000_process(input, prop, buf + EXC3000_LEN_FRAME + 4,
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
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, 4095, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 4095, 0, 0);
+	touchscreen_parse_properties(input, true, &data->prop);
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
+	setup_timer(&data->timer, exc3000_timer, (unsigned long)input);
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

