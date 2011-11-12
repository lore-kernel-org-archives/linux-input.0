From: Zhang Jiejing <jiejing.zhang@freescale.com>
Subject: [PATCH V4] input: add EETI eGalax I2C capacitive multi touch driver.
Date: Sat, 12 Nov 2011 14:12:37 +0800
Message-ID: <1321078357-19317-1-git-send-email-jiejing.zhang@freescale.com>
References: <20111110183819.GB18002@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from tx2ehsobe003.messaging.microsoft.com ([65.55.88.13]:23413 "EHLO
	TX2EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab1KLGQL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Nov 2011 01:16:11 -0500
In-Reply-To: <20111110183819.GB18002@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org

This patch adds the EETI eGalax serial multi touch controller driver.

EETI eGalax serial touch screen controller is a I2C based multiple
capacitive touch screen controller, it can support 5 touch events maximum.

Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>

---
V1 changes:
* use mt protocol B for report pointer.
* get the pressure value from pointer.
* use macro to define X,Y max value.

V2 changes:
* change MODE_SINGLE to a meanful name MODE_MOUSE
* add some comment on each mode to avoid misunderstand

V3 changes:
* some typo fix
* remove MODE_MOUSE, since it can't support both mode 100% well.
 also use this chip as MODE_MOUSE is very rare case.

V4 changes:
* fix some typo
* don't let i2c_master_recv spin indefinitely
* clean up the bit set of probe function
* clean up egalax_ts_remove  input_unregister_device order
---
 drivers/input/touchscreen/Kconfig     |   10 ++
 drivers/input/touchscreen/Makefile    |    1 +
 drivers/input/touchscreen/egalax_ts.c |  286 +++++++++++++++++++++++++++++++++
 3 files changed, 297 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/egalax_ts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index cabd9e5..92f02b0 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -177,6 +177,16 @@ config TOUCHSCREEN_EETI
 	  To compile this driver as a module, choose M here: the
 	  module will be called eeti_ts.
 
+config TOUCHSCREEN_EGALAX
+	tristate "EETI eGalax multi-touch panel support"
+	depends on I2C
+	help
+	  Say Y here to enable support for I2C connected EETI
+	  eGalax multi-touch panels.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called egalax_ts.
+
 config TOUCHSCREEN_FUJITSU
 	tristate "Fujitsu serial touchscreen"
 	select SERIO
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 282d6f7..a787ebc 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_TOUCHSCREEN_HAMPSHIRE)	+= hampshire.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
 obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
+obj-$(CONFIG_TOUCHSCREEN_EGALAX)	+= egalax_ts.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+= inexio.o
 obj-$(CONFIG_TOUCHSCREEN_INTEL_MID)	+= intel-mid-touch.o
diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
new file mode 100644
index 0000000..f694535
--- /dev/null
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -0,0 +1,286 @@
+/*
+ * Driver for EETI eGalax Multiple Touch Controller
+ *
+ * Copyright (C) 2011 Freescale Semiconductor, Inc.
+ *
+ * based on max11801_ts.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* EETI eGalax serial touch screen controller is a I2C based multiple
+ * touch screen controller, it supports 5 point multiple touch. */
+
+/* TODO:
+  - auto idle mode support
+*/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/irq.h>
+#include <linux/gpio.h>
+#include <linux/delay.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/input/mt.h>
+
+/* Mouse Mode: some panel may configure the controller to mouse mode,
+ * which can only report one point at a given time.
+ * This driver will ignore events in this mode.
+ */
+#define REPORT_MODE_MOUSE		0x1
+/* Vendor Mode: this mode is used to transfer some vendor specific
+ * messages.
+ * This driver will ignore events in this mode.
+ */
+#define REPORT_MODE_VENDOR		0x3
+/* Multiple Touch Mode */
+#define REPORT_MODE_MTTOUCH		0x4
+
+#define MAX_SUPPORT_POINTS		5
+
+#define EVENT_VALID_OFFSET	7
+#define EVENT_VALID_MASK	(0x1 << EVENT_VALID_OFFSET)
+#define EVENT_ID_OFFSET		2
+#define EVENT_ID_MASK		(0xf << EVENT_ID_OFFSET)
+#define EVENT_IN_RANGE		(0x1 << 1)
+#define EVENT_DOWN_UP		(0X1 << 0)
+
+#define MAX_I2C_DATA_LEN	10
+
+#define EGALAX_MAX_X	32760
+#define EGALAX_MAX_Y	32760
+#define EGALAX_MAX_TRIES 100
+
+struct egalax_ts {
+	struct i2c_client		*client;
+	struct input_dev		*input_dev;
+};
+
+static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
+{
+	struct egalax_ts *data = dev_id;
+	struct input_dev *input_dev = data->input_dev;
+	struct i2c_client *client = data->client;
+	u8 buf[MAX_I2C_DATA_LEN];
+	int id, ret, x, y, z;
+	int tries = 0;
+	bool down, valid;
+	u8 state;
+
+	do {
+		ret = i2c_master_recv(client, buf, MAX_I2C_DATA_LEN);
+	} while (ret == -EAGAIN && tries++ < EGALAX_MAX_TRIES);
+
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	if (buf[0] != REPORT_MODE_MTTOUCH) {
+		/* ignore mouse events and vendor events */
+		return IRQ_HANDLED;
+	}
+
+	state = buf[1];
+	x = (buf[3] << 8) | buf[2];
+	y = (buf[5] << 8) | buf[4];
+	z = (buf[7] << 8) | buf[6];
+
+	valid = state & EVENT_VALID_MASK;
+	id = (state & EVENT_ID_MASK) >> EVENT_ID_OFFSET;
+	down = state & EVENT_DOWN_UP;
+
+	if (!valid || id > MAX_SUPPORT_POINTS) {
+		dev_dbg(&client->dev, "point invalid\n");
+		return IRQ_HANDLED;
+	}
+
+	input_mt_slot(input_dev, id);
+	input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, down);
+
+	dev_dbg(&client->dev, "%s id:%d x:%d y:%d z:%d",
+		(down ? "down" : "up"), id, x, y, z);
+
+	if (down) {
+		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
+		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
+		input_report_abs(input_dev, ABS_MT_PRESSURE, z);
+	}
+
+	input_mt_report_pointer_emulation(input_dev, true);
+	input_sync(input_dev);
+	return IRQ_HANDLED;
+}
+
+/* wake up controller by an falling edge of interrupt gpio.  */
+static int egalax_wake_up_device(struct i2c_client *client)
+{
+	int gpio = irq_to_gpio(client->irq);
+	int ret;
+
+	ret = gpio_request(gpio, "egalax_irq");
+	if (ret < 0) {
+		dev_err(&client->dev, "request gpio failed,"
+			"cannot wake up controller:%d\n", ret);
+		return ret;
+	}
+	/* wake up controller via an falling edge on IRQ gpio. */
+	gpio_direction_output(gpio, 0);
+	gpio_set_value(gpio, 1);
+	/* controller should be waken up, return irq.  */
+	gpio_direction_input(gpio);
+	gpio_free(gpio);
+	return 0;
+}
+
+static int egalax_firmware_version(struct i2c_client *client)
+{
+	static const u8 cmd[MAX_I2C_DATA_LEN] = { 0x03, 0x03, 0xa, 0x01, 0x41 };
+	int ret;
+	ret = i2c_master_send(client, cmd, MAX_I2C_DATA_LEN);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+static int __devinit egalax_ts_probe(struct i2c_client *client,
+				       const struct i2c_device_id *id)
+{
+	struct egalax_ts *data;
+	struct input_dev *input_dev;
+	int ret;
+
+	data = kzalloc(sizeof(struct egalax_ts), GFP_KERNEL);
+	if (!data) {
+		dev_err(&client->dev, "Failed to allocate memory\n");
+		return -ENOMEM;
+	}
+
+	input_dev = input_allocate_device();
+	if (!input_dev) {
+		dev_err(&client->dev, "Failed to allocate memory\n");
+		ret = -ENOMEM;
+		goto err_free_data;
+	}
+
+	data->client = client;
+	data->input_dev = input_dev;
+	/* controller may be in sleep, wake it up. */
+	egalax_wake_up_device(client);
+	ret = egalax_firmware_version(client);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"egalax_ts: failed to read firmware version\n");
+		ret = -EIO;
+		goto err_free_dev;
+	}
+
+	input_dev->name = "EETI eGalax Touch Screen";
+	input_dev->id.bustype = BUS_I2C;
+	input_dev->dev.parent = &client->dev;
+
+	__set_bit(EV_ABS, input_dev->evbit);
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(BTN_TOUCH, input_dev->keybit);
+
+	input_set_abs_params(input_dev, ABS_X, 0, EGALAX_MAX_X, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, EGALAX_MAX_Y, 0, 0);
+	input_set_abs_params(input_dev,
+			     ABS_MT_POSITION_X, 0, EGALAX_MAX_X, 0, 0);
+	input_set_abs_params(input_dev,
+			     ABS_MT_POSITION_X, 0, EGALAX_MAX_Y, 0, 0);
+	input_mt_init_slots(input_dev, MAX_SUPPORT_POINTS);
+
+	input_set_drvdata(input_dev, data);
+
+	ret = request_threaded_irq(client->irq, NULL, egalax_ts_interrupt,
+				   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+				   "egalax_ts", data);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to register interrupt\n");
+		goto err_free_dev;
+	}
+
+	ret = input_register_device(data->input_dev);
+	if (ret < 0)
+		goto err_free_irq;
+	i2c_set_clientdata(client, data);
+	return 0;
+
+err_free_irq:
+	free_irq(client->irq, data);
+err_free_dev:
+	input_free_device(input_dev);
+err_free_data:
+	kfree(data);
+
+	return ret;
+}
+
+static __devexit int egalax_ts_remove(struct i2c_client *client)
+{
+	struct egalax_ts *data = i2c_get_clientdata(client);
+
+	free_irq(client->irq, data);
+	input_free_device(data->input_dev);
+	input_unregister_device(data->input_dev);
+	kfree(data);
+
+	return 0;
+}
+
+static const struct i2c_device_id egalax_ts_id[] = {
+	{"egalax_ts", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, egalax_ts_id);
+
+#ifdef CONFIG_PM_SLEEP
+static int egalax_ts_suspend(struct device *dev)
+{
+	int ret;
+	u8 suspend_cmd[MAX_I2C_DATA_LEN] = {0x3, 0x6, 0xa, 0x3, 0x36,
+					    0x3f, 0x2, 0, 0, 0};
+	struct i2c_client *client = to_i2c_client(dev);
+	ret = i2c_master_send(client, suspend_cmd, MAX_I2C_DATA_LEN);
+	return ret > 0 ? 0 : ret;
+}
+
+static int egalax_ts_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	return egalax_wake_up_device(client);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(egalax_ts_pm_ops, egalax_ts_suspend, egalax_ts_resume);
+static struct i2c_driver egalax_ts_driver = {
+	.driver = {
+		.name = "egalax_ts",
+		.pm	= &egalax_ts_pm_ops,
+	},
+	.id_table	= egalax_ts_id,
+	.probe		= egalax_ts_probe,
+	.remove		= __devexit_p(egalax_ts_remove),
+};
+
+static int __init egalax_ts_init(void)
+{
+	return i2c_add_driver(&egalax_ts_driver);
+}
+
+static void __exit egalax_ts_exit(void)
+{
+	i2c_del_driver(&egalax_ts_driver);
+}
+
+module_init(egalax_ts_init);
+module_exit(egalax_ts_exit);
+
+MODULE_AUTHOR("Freescale Semiconductor, Inc.");
+MODULE_DESCRIPTION("Touchscreen driver for EETI eGalax touch controller");
+MODULE_LICENSE("GPL");
-- 
1.7.1


