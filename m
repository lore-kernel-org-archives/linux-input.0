From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4] input: keyboard: FSL MPR121 capacitive touch button.
Date: Tue, 3 May 2011 09:40:24 -0700
Message-ID: <20110503164024.GA27903@core.coreip.homeip.net>
References: <1302748933-25935-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:51692 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810Ab1ECQkc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 May 2011 12:40:32 -0400
Received: by pzk9 with SMTP id 9so107160pzk.19
        for <linux-input@vger.kernel.org>; Tue, 03 May 2011 09:40:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1302748933-25935-1-git-send-email-jiejing.zhang@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Zhang Jiejing <jiejing.zhang@freescale.com>
Cc: linux-input@vger.kernel.org, Christoph Fritz <chf.fritz@googlemail.com>

Hi Zhang,

On Thu, Apr 14, 2011 at 10:42:13AM +0800, Zhang Jiejing wrote:
> This patch adds basic support for Freescale MPR121 capacitive touch
> sensor.
> It's an i2c controller with up to 12 capacitance sensing inputs.
> 
> Product information (data sheet, application notes) can be found here:
> http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPR121
> 
> Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>

I reviewed the driver and it looks like my original suggestion of using
matrix keypad infrastructure does not really work for this driver as it
doers not use a matrix but simply has 12 discrete sensors. So I removed
that code and made couple of other adjustments. Could you please tell me
if the patch below still works on your hardware and if it does I'll
queue the dirver for 2.6.40.

Thanks!

-- 
Dmitry


Input: add driver FSL MPR121 capacitive touch sensor

From: Zhang Jiejing <jiejing.zhang@freescale.com>

This patch adds basic support for Freescale MPR121 capacitive touch
sensor.  It's an i2c controller with up to 12 capacitance sensing inputs.

Product information (data sheet, application notes) can be found here:
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=MPR121

Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/keyboard/Kconfig           |   12 +
 drivers/input/keyboard/Makefile          |    1 
 drivers/input/keyboard/mpr121_touchkey.c |  339 ++++++++++++++++++++++++++++++
 include/linux/i2c/mpr121_touchkey.h      |   20 ++
 4 files changed, 372 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/keyboard/mpr121_touchkey.c
 create mode 100644 include/linux/i2c/mpr121_touchkey.h


diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index ed43f38..ea9a821 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -325,6 +325,18 @@ config KEYBOARD_MCS
 	  To compile this driver as a module, choose M here: the
 	  module will be called mcs_touchkey.
 
+config KEYBOARD_MPR121
+	tristate "Freescale MPR121 Touchkey"
+	depends on I2C
+	help
+	  Say Y here if you have Freescale MPR121 touchkey controller
+	  chip in your system.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called mpr121_touchkey.
+
 config KEYBOARD_IMX
 	tristate "IMX keypad support"
 	depends on ARCH_MXC
diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
index 874bf52..883a0dd 100644
--- a/drivers/input/keyboard/Makefile
+++ b/drivers/input/keyboard/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_KEYBOARD_MAPLE)		+= maple_keyb.o
 obj-$(CONFIG_KEYBOARD_MATRIX)		+= matrix_keypad.o
 obj-$(CONFIG_KEYBOARD_MAX7359)		+= max7359_keypad.o
 obj-$(CONFIG_KEYBOARD_MCS)		+= mcs_touchkey.o
+obj-$(CONFIG_KEYBOARD_MPR121)		+= mpr121_touchkey.o
 obj-$(CONFIG_KEYBOARD_NEWTON)		+= newtonkbd.o
 obj-$(CONFIG_KEYBOARD_NOMADIK)		+= nomadik-ske-keypad.o
 obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
new file mode 100644
index 0000000..0a9e811
--- /dev/null
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -0,0 +1,339 @@
+/*
+ * Touchkey driver for Freescale MPR121 Controllor
+ *
+ * Copyright (C) 2011 Freescale Semiconductor, Inc.
+ * Author: Zhang Jiejing <jiejing.zhang@freescale.com>
+ *
+ * Based on mcs_touchkey.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/i2c/mpr121_touchkey.h>
+
+/* Register definitions */
+#define ELE_TOUCH_STATUS_0_ADDR	0x0
+#define ELE_TOUCH_STATUS_1_ADDR	0X1
+#define MHD_RISING_ADDR		0x2b
+#define NHD_RISING_ADDR		0x2c
+#define NCL_RISING_ADDR		0x2d
+#define FDL_RISING_ADDR		0x2e
+#define MHD_FALLING_ADDR	0x2f
+#define NHD_FALLING_ADDR	0x30
+#define NCL_FALLING_ADDR	0x31
+#define FDL_FALLING_ADDR	0x32
+#define ELE0_TOUCH_THRESHOLD_ADDR	0x41
+#define ELE0_RELEASE_THRESHOLD_ADDR	0x42
+#define AFE_CONF_ADDR			0x5c
+#define FILTER_CONF_ADDR		0x5d
+
+/*
+ * ELECTRODE_CONF_ADDR: This register configures the number of
+ * enabled capacitance sensing inputs and its run/suspend mode.
+ */
+#define ELECTRODE_CONF_ADDR		0x5e
+#define AUTO_CONFIG_CTRL_ADDR		0x7b
+#define AUTO_CONFIG_USL_ADDR		0x7d
+#define AUTO_CONFIG_LSL_ADDR		0x7e
+#define AUTO_CONFIG_TL_ADDR		0x7f
+
+/* Threshold of touch/release trigger */
+#define TOUCH_THRESHOLD			0x0f
+#define RELEASE_THRESHOLD		0x0a
+/* Masks for touch and release triggers */
+#define TOUCH_STATUS_MASK		0xfff
+/* MPR121 has 12 keys */
+#define MPR121_MAX_KEY_COUNT		12
+
+struct mpr121_touchkey {
+	struct i2c_client	*client;
+	struct input_dev	*input_dev;
+	unsigned int		key_val;
+	unsigned int		statusbits;
+	unsigned int		keycount;
+	u16			keycodes[MPR121_MAX_KEY_COUNT];
+};
+
+struct mpr121_init_register {
+	int addr;
+	u8 val;
+};
+
+static const struct mpr121_init_register init_reg_table[] __devinitconst = {
+	{ MHD_RISING_ADDR,	0x1 },
+	{ NHD_RISING_ADDR,	0x1 },
+	{ MHD_FALLING_ADDR,	0x1 },
+	{ NHD_FALLING_ADDR,	0x1 },
+	{ NCL_FALLING_ADDR,	0xff },
+	{ FDL_FALLING_ADDR,	0x02 },
+	{ FILTER_CONF_ADDR,	0x04 },
+	{ AFE_CONF_ADDR,	0x0b },
+	{ AUTO_CONFIG_CTRL_ADDR, 0x0b },
+};
+
+static irqreturn_t mpr_touchkey_interrupt(int irq, void *dev_id)
+{
+	struct mpr121_touchkey *mpr121 = dev_id;
+	struct i2c_client *client = mpr121->client;
+	struct input_dev *input = mpr121->input_dev;
+	unsigned int key_num, key_val, pressed;
+	int reg;
+
+	reg = i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS_1_ADDR);
+	if (reg < 0) {
+		dev_err(&client->dev, "i2c read error [%d]\n", reg);
+		goto out;
+	}
+
+	reg <<= 8;
+	reg |= i2c_smbus_read_byte_data(client, ELE_TOUCH_STATUS_0_ADDR);
+	if (reg < 0) {
+		dev_err(&client->dev, "i2c read error [%d]\n", reg);
+		goto out;
+	}
+
+	reg &= TOUCH_STATUS_MASK;
+	/* use old press bit to figure out which bit changed */
+	key_num = ffs(reg ^ mpr121->statusbits) - 1;
+	pressed = reg & (1 << key_num);
+	mpr121->statusbits = reg;
+
+	key_val = mpr121->keycodes[key_num];
+
+	input_event(input, EV_MSC, MSC_SCAN, key_num);
+	input_report_key(input, key_val, pressed);
+	input_sync(input);
+
+	dev_dbg(&client->dev, "key %d %d %s\n", key_num, key_val,
+		pressed ? "pressed" : "released");
+
+out:
+	return IRQ_HANDLED;
+}
+
+static int __devinit mpr121_phys_init(const struct mpr121_platform_data *pdata,
+				      struct mpr121_touchkey *mpr121,
+				      struct i2c_client *client)
+{
+	const struct mpr121_init_register *reg;
+	unsigned char usl, lsl, tl;
+	int i, t, vdd, ret;
+
+	/* Set up touch/release threshold for ele0-ele11 */
+	for (i = 0; i <= MPR121_MAX_KEY_COUNT; i++) {
+		t = ELE0_TOUCH_THRESHOLD_ADDR + (i * 2);
+		ret = i2c_smbus_write_byte_data(client, t, TOUCH_THRESHOLD);
+		if (ret < 0)
+			goto err_i2c_write;
+		ret = i2c_smbus_write_byte_data(client, t + 1,
+						RELEASE_THRESHOLD);
+		if (ret < 0)
+			goto err_i2c_write;
+	}
+
+	/* Set up init register */
+	for (i = 0; i < ARRAY_SIZE(init_reg_table); i++) {
+		reg = &init_reg_table[i];
+		ret = i2c_smbus_write_byte_data(client, reg->addr, reg->val);
+		if (ret < 0)
+			goto err_i2c_write;
+	}
+
+
+	/*
+	 * Capacitance on sensing input varies and needs to be compensated.
+	 * The internal MPR121-auto-configuration can do this if it's
+	 * registers are set properly (based on pdata->vdd_uv).
+	 */
+	vdd = pdata->vdd_uv / 1000;
+	usl = ((vdd - 700) * 256) / vdd;
+	lsl = (usl * 65) / 100;
+	tl = (usl * 90) / 100;
+	ret = i2c_smbus_write_byte_data(client, AUTO_CONFIG_USL_ADDR, usl);
+	ret |= i2c_smbus_write_byte_data(client, AUTO_CONFIG_LSL_ADDR, lsl);
+	ret |= i2c_smbus_write_byte_data(client, AUTO_CONFIG_TL_ADDR, tl);
+	ret |= i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR,
+					 mpr121->keycount);
+	if (ret != 0)
+		goto err_i2c_write;
+
+	dev_dbg(&client->dev, "set up with %x keys.\n", mpr121->keycount);
+
+	return 0;
+
+err_i2c_write:
+	dev_err(&client->dev, "i2c write error: %d\n", ret);
+	return ret;
+}
+
+static int __devinit mpr_touchkey_probe(struct i2c_client *client,
+					const struct i2c_device_id *id)
+{
+	const struct mpr121_platform_data *pdata = client->dev.platform_data;
+	struct mpr121_touchkey *mpr121;
+	struct input_dev *input_dev;
+	int error;
+	int i;
+
+	if (!pdata) {
+		dev_err(&client->dev, "no platform data defined\n");
+		return -EINVAL;
+	}
+
+	if (!pdata->keymap || !pdata->keymap_size) {
+		dev_err(&client->dev, "missing keymap data\n");
+		return -EINVAL;
+	}
+
+	if (pdata->keymap_size > MPR121_MAX_KEY_COUNT) {
+		dev_err(&client->dev, "too many keys defined\n");
+		return -EINVAL;
+	}
+
+	if (!client->irq) {
+		dev_err(&client->dev, "irq number should not be zero\n");
+		return -EINVAL;
+	}
+
+	mpr121 = kzalloc(sizeof(struct mpr121_touchkey), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!mpr121 || !input_dev) {
+		dev_err(&client->dev, "Failed to allocate memory\n");
+		error = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	mpr121->client = client;
+	mpr121->input_dev = input_dev;
+	mpr121->keycount = pdata->keymap_size;
+
+	input_dev->name = "Freescale MPR121 Touchkey";
+	input_dev->id.bustype = BUS_I2C;
+	input_dev->dev.parent = &client->dev;
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
+
+	input_dev->keycode = mpr121->keycodes;
+	input_dev->keycodesize = sizeof(mpr121->keycodes[0]);
+	input_dev->keycodemax = mpr121->keycount;
+
+	for (i = 0; i < pdata->keymap_size; i++) {
+		input_set_capability(input_dev, EV_KEY, pdata->keymap[i]);
+		mpr121->keycodes[i] = pdata->keymap[i];
+	}
+
+	error = mpr121_phys_init(pdata, mpr121, client);
+	if (error) {
+		dev_err(&client->dev, "Failed to init register\n");
+		goto err_free_mem;
+	}
+
+	error = request_threaded_irq(client->irq, NULL,
+				     mpr_touchkey_interrupt,
+				     IRQF_TRIGGER_FALLING,
+				     client->dev.driver->name, mpr121);
+	if (error) {
+		dev_err(&client->dev, "Failed to register interrupt\n");
+		goto err_free_mem;
+	}
+
+	error = input_register_device(input_dev);
+	if (error)
+		goto err_free_irq;
+
+	i2c_set_clientdata(client, mpr121);
+	device_init_wakeup(&client->dev, pdata->wakeup);
+
+	return 0;
+
+err_free_irq:
+	free_irq(client->irq, mpr121);
+err_free_mem:
+	input_free_device(input_dev);
+	kfree(mpr121);
+	return error;
+}
+
+static int __devexit mpr_touchkey_remove(struct i2c_client *client)
+{
+	struct mpr121_touchkey *mpr121 = i2c_get_clientdata(client);
+
+	free_irq(client->irq, mpr121);
+	input_unregister_device(mpr121->input_dev);
+	kfree(mpr121);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int mpr_suspend(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+
+	if (device_may_wakeup(&client->dev))
+		enable_irq_wake(client->irq);
+
+	i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, 0x00);
+
+	return 0;
+}
+
+static int mpr_resume(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct mpr121_touchkey *mpr121 = i2c_get_clientdata(client);
+
+	if (device_may_wakeup(&client->dev))
+		disable_irq_wake(client->irq);
+
+	i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR,
+				  mpr121->keycount);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(mpr121_touchkey_pm_ops, mpr_suspend, mpr_resume);
+
+static const struct i2c_device_id mpr121_id[] = {
+	{ "mpr121_touchkey", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, mpr121_id);
+
+static struct i2c_driver mpr_touchkey_driver = {
+	.driver = {
+		.name	= "mpr121",
+		.owner	= THIS_MODULE,
+		.pm	= &mpr121_touchkey_pm_ops,
+	},
+	.id_table	= mpr121_id,
+	.probe		= mpr_touchkey_probe,
+	.remove		= __devexit_p(mpr_touchkey_remove),
+};
+
+static int __init mpr_touchkey_init(void)
+{
+	return i2c_add_driver(&mpr_touchkey_driver);
+}
+module_init(mpr_touchkey_init);
+
+static void __exit mpr_touchkey_exit(void)
+{
+	i2c_del_driver(&mpr_touchkey_driver);
+}
+module_exit(mpr_touchkey_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Zhang Jiejing <jiejing.zhang@freescale.com>");
+MODULE_DESCRIPTION("Touch Key driver for Freescale MPR121 Chip");
diff --git a/include/linux/i2c/mpr121_touchkey.h b/include/linux/i2c/mpr121_touchkey.h
new file mode 100644
index 0000000..f0bcc38
--- /dev/null
+++ b/include/linux/i2c/mpr121_touchkey.h
@@ -0,0 +1,20 @@
+/* Header file for Freescale MPR121 Capacitive Touch Sensor */
+
+#ifndef _MPR121_TOUCHKEY_H
+#define _MPR121_TOUCHKEY_H
+
+/**
+ * struct mpr121_platform_data - platform data for mpr121 sensor
+ * @keymap: pointer to array of KEY_* values representing keymap
+ * @keymap_size: size of the keymap
+ * @wakeup: configure the button as a wake-up source
+ * @vdd_uv: VDD voltage in uV
+ */
+struct mpr121_platform_data {
+	const unsigned short *keymap;
+	unsigned int keymap_size;
+	bool wakeup;
+	int vdd_uv;
+};
+
+#endif /* _MPR121_TOUCHKEY_H */
