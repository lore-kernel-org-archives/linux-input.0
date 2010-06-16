From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH 1/2] input: mcs - Add MCS touchkey driver
Date: Wed, 16 Jun 2010 10:03:48 +0900
Message-ID: <1276650229-1322-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:21191 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458Ab0FPBDy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jun 2010 21:03:54 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L4300FKF1MFD490@mailout2.samsung.com> for
 linux-input@vger.kernel.org; Wed, 16 Jun 2010 10:03:51 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L4300L9F1MFFJ@mmp2.samsung.com> for
 linux-input@vger.kernel.org; Wed, 16 Jun 2010 10:03:51 +0900 (KST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, kyungmin.park@samsung.com

The MELPAS MCS5000 can use to touchkey controller but touchkey is
implemented to driver separated with original MCS5000 touchscreen
driver. This also supports MCS5080 touchkey.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/keyboard/Kconfig        |   12 ++
 drivers/input/keyboard/Makefile       |    1 +
 drivers/input/keyboard/mcs_touchkey.c |  245 +++++++++++++++++++++++++++++++++
 include/linux/i2c/mcs.h               |   36 +++++
 4 files changed, 294 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/mcs_touchkey.c
 create mode 100644 include/linux/i2c/mcs.h

diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index d8fa5d7..c748093 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -297,6 +297,18 @@ config KEYBOARD_MAX7359
 	  To compile this driver as a module, choose M here: the
 	  module will be called max7359_keypad.
 
+config KEYBOARD_MCS
+	tristate "MELFAS MCS Touchkey"
+	depends on I2C
+	help
+	  Say Y here if you have the MELFAS MCS5000/5080 touchkey controller
+	  chip in your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mcs_touchkey.
+
 config KEYBOARD_IMX
 	tristate "IMX keypad support"
 	depends on ARCH_MXC
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 4596d0c..0a16674 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_KEYBOARD_LOCOMO)		+= locomokbd.o
 obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
+obj-$(CONFIG_KEYBOARD_MCS)		+= mcs_touchkey.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
 obj-$(CONFIG_KEYBOARD_OPENCORES)	+= opencores-kbd.o
diff --git a/drivers/input/keyboard/mcs_touchkey.c b/drivers/input/keyboard/mcs_touchkey.c
new file mode 100644
index 0000000..d70e048
--- /dev/null
+++ b/drivers/input/keyboard/mcs_touchkey.c
@@ -0,0 +1,245 @@
+/*
+ * mcs_touchkey.c - Touchkey driver for MELFAS MCS5000/5080 controller
+ *
+ * Copyright (C) 2010 Samsung Electronics Co.Ltd
+ * Author: HeungJun Kim <riverful.kim@samsung.com>
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/i2c/mcs.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+
+/* MCS5000 Touchkey */
+#define MCS5000_TOUCHKEY_STATUS		0x04
+#define MCS5000_TOUCHKEY_STATUS_PRESS	7
+#define MCS5000_TOUCHKEY_FW		0x0a
+#define MCS5000_TOUCHKEY_BASE_VAL	0x61
+
+/* MCS5080 Touchkey */
+#define MCS5080_TOUCHKEY_STATUS		0x00
+#define MCS5080_TOUCHKEY_STATUS_PRESS	3
+#define MCS5080_TOUCHKEY_FW		0x01
+#define MCS5080_TOUCHKEY_BASE_VAL	0x1
+
+enum mcs_touchkey_type {
+	MCS5000_TOUCHKEY,
+	MCS5080_TOUCHKEY,
+};
+
+struct mcs_touchkey_chip {
+	unsigned int status_reg;
+	unsigned int pressbit;
+	unsigned int press_invert;
+	unsigned int baseval;
+};
+
+struct mcs_touchkey_data {
+	struct i2c_client *client;
+	struct input_dev *input_dev;
+	struct mcs_touchkey_chip chip;
+	unsigned short *keycodes;
+	unsigned int key_code;
+	unsigned int key_val;
+};
+
+static irqreturn_t mcs_touchkey_interrupt(int irq, void *dev_id)
+{
+	struct mcs_touchkey_data *data = dev_id;
+	struct mcs_touchkey_chip *chip = &data->chip;
+	struct i2c_client *client = data->client;
+	struct input_dev *input = data->input_dev;
+	unsigned int key_val;
+	unsigned int pressed;
+	int val;
+
+	val = i2c_smbus_read_byte_data(client, chip->status_reg);
+	if (val < 0) {
+		dev_err(&client->dev, "Failed to i2c read error[%d]\n", val);
+		goto out;
+	}
+
+	pressed = (val & (1 << chip->pressbit)) >> chip->pressbit;
+	if (chip->press_invert)
+		pressed ^= chip->press_invert;
+
+	/* key_val is 0 when releases, so we should use key_val of press. */
+	if (pressed) {
+		key_val = val & (0xff >> (8 - chip->pressbit));
+		if (!key_val)
+			goto out;
+		key_val -= chip->baseval;
+		data->key_code = data->keycodes[key_val];
+		data->key_val = key_val;
+	}
+
+	input_event(input, EV_MSC, MSC_SCAN, data->key_val);
+	input_report_key(input, data->key_code, pressed ? 1 : 0);
+	input_sync(input);
+
+	dev_dbg(&client->dev, "key %d %d %s\n", data->key_val, data->key_code,
+			pressed ? "pressed" : "released");
+
+ out:
+	return IRQ_HANDLED;
+}
+
+static int __devinit mcs_touchkey_probe(struct i2c_client *client,
+		const struct i2c_device_id *id)
+{
+	const struct mcs_platform_data *pdata;
+	struct mcs_touchkey_data *data;
+	struct input_dev *input_dev;
+	unsigned short *keycodes;
+	unsigned int fw_reg;
+	int ret;
+	int i;
+
+	pdata = client->dev.platform_data;
+	if (!pdata) {
+		dev_err(&client->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
+	data = kzalloc(sizeof(struct mcs_touchkey_data), GFP_KERNEL);
+	keycodes = kzalloc(sizeof(*keycodes) * (pdata->key_maxval + 1),
+			GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!data || !keycodes || !input_dev) {
+		dev_err(&client->dev, "Failed to allocate memory\n");
+		ret = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	data->client = client;
+	data->input_dev = input_dev;
+	data->keycodes = keycodes;
+
+	if (id->driver_data == MCS5000_TOUCHKEY) {
+		data->chip.status_reg = MCS5000_TOUCHKEY_STATUS;
+		data->chip.pressbit = MCS5000_TOUCHKEY_STATUS_PRESS;
+		data->chip.baseval = MCS5000_TOUCHKEY_BASE_VAL;
+		fw_reg = MCS5000_TOUCHKEY_FW;
+	} else {
+		data->chip.status_reg = MCS5080_TOUCHKEY_STATUS;
+		data->chip.pressbit = MCS5080_TOUCHKEY_STATUS_PRESS;
+		data->chip.press_invert = 1;
+		data->chip.baseval = MCS5080_TOUCHKEY_BASE_VAL;
+		fw_reg = MCS5080_TOUCHKEY_FW;
+	}
+
+	ret = i2c_smbus_read_byte_data(client, fw_reg);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to i2c read error[%d]\n", ret);
+		goto err_free_mem;
+	}
+	dev_info(&client->dev, "Firmware version: %d\n", ret);
+
+	input_dev->name = "MELPAS MCS Touchkey";
+	input_dev->id.bustype = BUS_I2C;
+	input_dev->dev.parent = &client->dev;
+	input_dev->evbit[0] = BIT_MASK(EV_KEY);
+	if (!pdata->no_autorepeat)
+		input_dev->evbit[0] |= BIT_MASK(EV_REP);
+	input_dev->keycode = keycodes;
+	input_dev->keycodesize = sizeof(*keycodes);
+	input_dev->keycodemax = pdata->key_maxval + 1;
+
+	for (i = 0; i < pdata->keymap_size; i++) {
+		int val;
+		int code;
+
+		val = MCS_KEY_VAL(pdata->keymap[i]);
+		code = MCS_KEY_CODE(pdata->keymap[i]);
+		keycodes[val] = code;
+		__set_bit(code, input_dev->keybit);
+	}
+
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+	input_set_drvdata(input_dev, data);
+
+	if (pdata->cfg_pin)
+		pdata->cfg_pin();
+
+	ret = request_threaded_irq(client->irq, NULL, mcs_touchkey_interrupt,
+			IRQF_TRIGGER_FALLING, client->dev.driver->name, data);
+
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to register interrupt\n");
+		goto err_free_mem;
+	}
+
+	ret = input_register_device(input_dev);
+	if (ret < 0)
+		goto err_free_irq;
+
+	i2c_set_clientdata(client, data);
+
+	return 0;
+
+err_free_irq:
+	free_irq(client->irq, data);
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(keycodes);
+	kfree(data);
+	return ret;
+}
+
+static int __devexit mcs_touchkey_remove(struct i2c_client *client)
+{
+	struct mcs_touchkey_data *data = i2c_get_clientdata(client);
+
+	free_irq(client->irq, data);
+	input_unregister_device(data->input_dev);
+	kfree(data->keycodes);
+	kfree(data);
+
+	return 0;
+}
+
+static const struct i2c_device_id mcs_touchkey_id[] = {
+	{ "mcs5000_touchkey", MCS5000_TOUCHKEY },
+	{ "mcs5080_touchkey", MCS5080_TOUCHKEY },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mcs_touchkey_id);
+
+static struct i2c_driver mcs_touchkey_driver = {
+	.probe		= mcs_touchkey_probe,
+	.remove		= __devexit_p(mcs_touchkey_remove),
+	.driver = {
+		.name = "mcs_touchkey",
+	},
+	.id_table	= mcs_touchkey_id,
+};
+
+static int __init mcs_touchkey_init(void)
+{
+	return i2c_add_driver(&mcs_touchkey_driver);
+}
+
+static void __exit mcs_touchkey_exit(void)
+{
+	i2c_del_driver(&mcs_touchkey_driver);
+}
+
+module_init(mcs_touchkey_init);
+module_exit(mcs_touchkey_exit);
+
+/* Module information */
+MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
+MODULE_AUTHOR("HeungJun Kim <riverful.kim@samsung.com>");
+MODULE_DESCRIPTION("Touchkey driver for MELFAS MCS5000/5080 controller");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/mcs.h b/include/linux/i2c/mcs.h
new file mode 100644
index 0000000..ae3225b
--- /dev/null
+++ b/include/linux/i2c/mcs.h
@@ -0,0 +1,36 @@
+/*
+ * mcs.h
+ *
+ * Copyright (C) 2009 - 2010 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ * Author: HeungJun Kim <riverful.kim@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __LINUX_MCS_H
+#define __LINUX_MCS_H
+
+#define MCS_KEY_MAP(v, c)	((((v) & 0xff) << 16) | ((c) & 0xffff))
+#define MCS_KEY_VAL(v)		(((v) >> 16) & 0xff)
+#define MCS_KEY_CODE(v)		((v) & 0xffff)
+
+struct mcs_platform_data {
+	void (*cfg_pin)(void);
+
+	/* touchscreen */
+	int x_size;
+	int y_size;
+
+	/* touchkey */
+	const uint32_t *keymap;
+	unsigned int keymap_size;
+	unsigned int key_maxval;
+	bool no_autorepeat;
+};
+
+#endif	/* __LINUX_MCS_H */
-- 
1.7.0.4

