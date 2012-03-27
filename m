From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH V2] input: keyboard: lm8333: add driver
Date: Tue, 27 Mar 2012 14:57:11 +0200
Message-ID: <1332853031-22600-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54836 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621Ab2C0M5T (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Mar 2012 08:57:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <w.sang@pengutronix.de>

This driver adds support for the keypad part of the LM8333 and is prepared for
possible GPIO/PWM drivers. Note that this is not a MFD device beause you cannot
disable the keypad functionality which, thus, has to be handled by the core
anyhow.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

Changes since V1:

* dropped devm_* usage since it caused more pain than gain
* reworked mechanism for repeated reads, so Dmitry will still understand it when
  being drunk at 2am :D
* dropped EXPORT_SYMBOL for now
* don't free device after it has been unregistered

Tested with 3.3 kernel on a custom board.

 drivers/input/keyboard/Kconfig  |   10 ++
 drivers/input/keyboard/Makefile |    1 +
 drivers/input/keyboard/lm8333.c |  230 +++++++++++++++++++++++++++++++++++++++
 include/linux/input/lm8333.h    |   24 ++++
 4 files changed, 265 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/lm8333.c
 create mode 100644 include/linux/input/lm8333.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index cdc385b..0294147 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -309,6 +309,16 @@ config KEYBOARD_LM8323
 	  To compile this driver as a module, choose M here: the
 	  module will be called lm8323.
 
+config KEYBOARD_LM8333
+	tristate "LM8333 keypad chip"
+	depends on I2C
+	help
+	  If you say yes here you get support for the National Semiconductor
+	  LM8333 keypad controller.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called lm8333.
+
 config KEYBOARD_LOCOMO
 	tristate "LoCoMo Keyboard Support"
 	depends on SHARP_LOCOMO
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index df7061f..b03b024 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_KEYBOARD_HP6XX)		+= jornada680_kbd.o
 obj-$(CONFIG_KEYBOARD_HP7XX)		+= jornada720_kbd.o
 obj-$(CONFIG_KEYBOARD_LKKBD)		+= lkkbd.o
 obj-$(CONFIG_KEYBOARD_LM8323)		+= lm8323.o
+obj-$(CONFIG_KEYBOARD_LM8333)		+= lm8333.o
 obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
diff --git a/drivers/input/keyboard/lm8333.c b/drivers/input/keyboard/lm8333.c
new file mode 100644
index 0000000..a2d81ba
--- /dev/null
+++ b/drivers/input/keyboard/lm8333.c
@@ -0,0 +1,230 @@
+/*
+ * LM8333 keypad driver
+ * Copyright (C) 2012 Wolfram Sang, Pengutronix <w.sang@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License.
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/irq.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/input/lm8333.h>
+
+#define LM8333_FIFO_READ		0x20
+#define LM8333_DEBOUNCE			0x22
+#define LM8333_READ_INT			0xD0
+#define LM8333_ACTIVE			0xE4
+#define LM8333_READ_ERROR		0xF0
+
+#define LM8333_KEYPAD_IRQ		(1 << 0)
+#define LM8333_ERROR_IRQ		(1 << 3)
+
+#define LM8333_ERROR_KEYOVR		0x04
+#define LM8333_ERROR_FIFOOVR		0x40
+
+#define LM8333_FIFO_TRANSFER_SIZE	16
+
+#define LM8333_ROW_SHIFT	4
+#define LM8333_NUM_ROWS		8
+
+
+struct lm8333 {
+	struct i2c_client *client;
+	struct input_dev *input;
+	unsigned short keycodes[LM8333_NUM_ROWS << LM8333_ROW_SHIFT];
+};
+
+/* The accessors try twice because the first access may be needed for wakeup */
+#define LM8333_READ_RETRIES 2
+
+int lm8333_read8(struct lm8333 *lm8333, u8 cmd)
+{
+	int retries = 0, ret;
+
+	do {
+		ret = i2c_smbus_read_byte_data(lm8333->client, cmd);
+	} while (ret < 0 && retries++ < LM8333_READ_RETRIES);
+
+	return ret;
+}
+
+int lm8333_write8(struct lm8333 *lm8333, u8 cmd, u8 val)
+{
+	int retries = 0, ret;
+
+	do {
+		ret = i2c_smbus_write_byte_data(lm8333->client, cmd, val);
+	} while (ret < 0 && retries++ < LM8333_READ_RETRIES);
+
+	return ret;
+}
+
+int lm8333_read_block(struct lm8333 *lm8333, u8 cmd, u8 len, u8 *buf)
+{
+	int retries = 0, ret;
+
+	do {
+		ret = i2c_smbus_read_i2c_block_data(lm8333->client, cmd, len, buf);
+	} while (ret < 0 && retries++ < LM8333_READ_RETRIES);
+
+	return ret;
+}
+
+static void lm8333_key_handler(struct lm8333 *lm8333)
+{
+	u8 keys[LM8333_FIFO_TRANSFER_SIZE];
+	u8 code, pressed;
+	int i, ret;
+
+	ret = lm8333_read_block(lm8333, LM8333_FIFO_READ, LM8333_FIFO_TRANSFER_SIZE, keys);
+	if (ret != LM8333_FIFO_TRANSFER_SIZE) {
+		dev_err(&lm8333->client->dev, "Error %d while reading FIFO\n", ret);
+		return;
+	}
+
+	for (i = 0; keys[i] && i < LM8333_FIFO_TRANSFER_SIZE; i++) {
+		pressed = !!(keys[i] & 0x80);
+		code = keys[i] & 0x7f;
+
+		input_event(lm8333->input, EV_MSC, MSC_SCAN, code);
+		input_report_key(lm8333->input, lm8333->keycodes[code], pressed);
+	}
+
+	input_sync(lm8333->input);
+}
+
+static irqreturn_t lm8333_irq_thread(int irq, void *data)
+{
+	struct lm8333 *lm8333 = data;
+	u8 status = lm8333_read8(lm8333, LM8333_READ_INT);
+
+	if (!status)
+		return IRQ_NONE;
+
+	if (status & LM8333_ERROR_IRQ) {
+		u8 err = lm8333_read8(lm8333, LM8333_READ_ERROR);
+
+		if (err & (LM8333_ERROR_KEYOVR | LM8333_ERROR_FIFOOVR)) {
+			u8 dummy[LM8333_FIFO_TRANSFER_SIZE];
+
+			lm8333_read_block(lm8333, LM8333_FIFO_READ,
+					LM8333_FIFO_TRANSFER_SIZE, dummy);
+		}
+		dev_err(&lm8333->client->dev, "Got error %02x\n", err);
+	}
+
+	if (status & LM8333_KEYPAD_IRQ)
+		lm8333_key_handler(lm8333);
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit lm8333_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct lm8333_platform_data *pdata = client->dev.platform_data;
+	struct lm8333 *lm8333;
+	struct input_dev *input;
+	int err, active_time;
+
+	if (!pdata)
+		return -EINVAL;
+
+	active_time = pdata->active_time ?: 500;
+	if (active_time / 3 <= pdata->debounce_time / 3) {
+		dev_err(&client->dev, "Active time not big enough!\n");
+		return -EINVAL;
+	}
+
+	lm8333 = kzalloc(sizeof(*lm8333), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!lm8333 || !input) {
+		err = -ENOMEM;
+		goto free_mem;
+	}
+
+	input->name = client->name;
+	input->dev.parent = &client->dev;
+	input->id.bustype = BUS_I2C;
+
+	lm8333->client = client;
+	lm8333->input = input;
+
+	i2c_set_clientdata(client, lm8333);
+
+	input->keycode = lm8333->keycodes;
+	input->keycodesize = sizeof(lm8333->keycodes[0]);
+	input->keycodemax = ARRAY_SIZE(lm8333->keycodes);
+	input->evbit[0] = BIT_MASK(EV_KEY);
+	input_set_capability(input, EV_MSC, MSC_SCAN);
+
+	matrix_keypad_build_keymap(pdata->matrix_data, LM8333_ROW_SHIFT,
+			input->keycode, input->keybit);
+
+
+	if (pdata->debounce_time) {
+		err = lm8333_write8(lm8333, LM8333_DEBOUNCE, pdata->debounce_time / 3);
+		if (err)
+			dev_warn(&client->dev, "Unable to set debounce time\n");
+	}
+
+	if (pdata->active_time) {
+		err = lm8333_write8(lm8333, LM8333_ACTIVE, pdata->active_time / 3);
+		if (err)
+			dev_warn(&client->dev, "Unable to set active time\n");
+	}
+
+	err = request_threaded_irq(client->irq, NULL, lm8333_irq_thread,
+			IRQF_TRIGGER_FALLING | IRQF_ONESHOT, "lm8333", lm8333);
+	if (err)
+		goto free_mem;
+
+	err = input_register_device(input);
+	if (err)
+		goto free_irq;
+
+	return 0;
+
+ free_irq:
+	free_irq(client->irq, lm8333);
+ free_mem:
+	input_free_device(input);
+	kfree(lm8333);
+	return err;
+}
+
+static int __devexit lm8333_remove(struct i2c_client *client)
+{
+	struct lm8333 *lm8333 = i2c_get_clientdata(client);
+
+	free_irq(client->irq, lm8333);
+	input_unregister_device(lm8333->input);
+	kfree(lm8333);
+	return 0;
+}
+
+static const struct i2c_device_id lm8333_id[] = {
+	{ "lm8333", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lm8333_id);
+
+static struct i2c_driver lm8333_driver = {
+	.driver = {
+		.name		= "lm8333",
+		.owner		= THIS_MODULE,
+	},
+	.probe		= lm8333_probe,
+	.remove		= __devexit_p(lm8333_remove),
+	.id_table	= lm8333_id,
+};
+module_i2c_driver(lm8333_driver);
+
+MODULE_AUTHOR("Wolfram Sang <w.sang@pengutronix.de>");
+MODULE_DESCRIPTION("LM8333 keyboard driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/input/lm8333.h b/include/linux/input/lm8333.h
new file mode 100644
index 0000000..79f918c
--- /dev/null
+++ b/include/linux/input/lm8333.h
@@ -0,0 +1,24 @@
+/*
+ * public include for LM8333 keypad driver - same license as driver
+ * Copyright (C) 2012 Wolfram Sang, Pengutronix <w.sang@pengutronix.de>
+ */
+
+#ifndef _LM8333_H
+#define _LM8333_H
+
+struct lm8333;
+
+struct lm8333_platform_data {
+	/* Keymap data */
+	const struct matrix_keymap_data *matrix_data;
+	/* Active timeout before enter HALT mode in microseconds */
+	unsigned active_time;
+	/* Debounce interval in microseconds */
+	unsigned debounce_time;
+};
+
+extern int lm8333_read8(struct lm8333 *lm8333, u8 cmd);
+extern int lm8333_write8(struct lm8333 *lm8333, u8 cmd, u8 val);
+extern int lm8333_read_block(struct lm8333 *lm8333, u8 cmd, u8 len, u8 *buf);
+
+#endif /* _LM8333_H */
-- 
1.7.9.1

