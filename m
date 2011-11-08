From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH] edt_ts: EDT Touchscreen driver
Date: Wed,  9 Nov 2011 00:34:39 +0100
Message-ID: <1320795279-2018-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38749 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753974Ab1KHXe7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2011 18:34:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com
Cc: Anatolij Gustshin <agust@denx.de>, Ilya Yanok <yanok@emcraft.com>

From: Anatolij Gustshin <agust@denx.de>

Driver for touchscreen controllers found on EDT Displays. Originally
developed by Anatolij Gustshin.

Cc: Anatolij Gustshin <agust@denx.de>
Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 drivers/input/touchscreen/Kconfig  |   11 ++
 drivers/input/touchscreen/Makefile |    1 +
 drivers/input/touchscreen/edt_ts.c |  340 ++++++++++++++++++++++++++++++++++++
 include/linux/i2c/edt_ts.h         |   20 ++
 4 files changed, 372 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/edt_ts.c
 create mode 100644 include/linux/i2c/edt_ts.h

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 3488ffe..934e6d3 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -738,4 +738,15 @@ config TOUCHSCREEN_TPS6507X
 	  To compile this driver as a module, choose M here: the
 	  module will be called tps6507x_ts.
 
+config TOUCHSCREEN_EDT
+	tristate "EDT touchscreen"
+	depends on I2C
+	help
+	  Say Y here to enable EDT touchscreen support.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called edt_ts.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index f957676..78ca164 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
 obj-$(CONFIG_TOUCHSCREEN_TPS6507X)	+= tps6507x-ts.o
+obj-$(CONFIG_TOUCHSCREEN_EDT)		+= edt_ts.o
diff --git a/drivers/input/touchscreen/edt_ts.c b/drivers/input/touchscreen/edt_ts.c
new file mode 100644
index 0000000..2bf0adc
--- /dev/null
+++ b/drivers/input/touchscreen/edt_ts.c
@@ -0,0 +1,340 @@
+/*
+ * Touch Screen driver for EDT ET070003DM6 display
+ *
+ * Mostly derived from migor_ts driver,
+ * Copyright (c) 2008 Magnus Damm
+ * Copyright (c) 2007 Ujjwal Pande <ujjwal@kenati.com>
+ *
+ * Copyright (c) 2011 DENX Software Engineering,
+ * Anatolij Gustschin <agust@denx.de>
+ *
+ * This file is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU  General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ */
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/slab.h>
+#include <linux/gpio.h>
+#include <linux/i2c/edt_ts.h>
+
+#define EDT_EVENT_TOUCH_DOWN	0x0
+#define EDT_EVENT_TOUCH_UP	0x4
+#define EDT_EVENT_TOUCH_ON	0x8
+
+#define EDT_TS_PENUP_TIMEOUT_MS		40
+
+struct edt_ts_priv {
+	struct i2c_client *client;
+	struct timer_list timer;
+	struct input_dev *input;
+	struct delayed_work work;
+	unsigned int up_reported;
+	int irq;
+	unsigned irq_gpio;
+};
+
+void edt_ts_release_event(struct edt_ts_priv *priv)
+{
+	input_report_abs(priv->input, ABS_PRESSURE, 0);
+	input_report_key(priv->input, BTN_TOUCH, 0);
+	input_sync(priv->input);
+	priv->up_reported = 1;
+}
+
+static void edt_ts_read(struct work_struct *work)
+{
+	struct edt_ts_priv *priv;
+	unsigned short xpos[2];
+	unsigned short ypos[2];
+	unsigned char buf[26], sendbuf[1];
+	int event, touch_id;
+	int ret;
+
+	sendbuf[0] = 0xf9;
+
+	priv = container_of(work, struct edt_ts_priv, work.work);
+	memset(buf, 0, sizeof(buf));
+
+	/* skip reading touch data if gpio irq input is high */
+	if (gpio_get_value(priv->irq_gpio))
+		goto fixup_timer;
+
+	ret = i2c_master_send(priv->client, sendbuf, sizeof(sendbuf));
+	if (ret != sizeof(sendbuf)) {
+		dev_err(&priv->client->dev, "can't send 0xf9\n");
+		return;
+	}
+
+	ret = i2c_master_recv(priv->client, buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		dev_err(&priv->client->dev, "can't read pos. data\n");
+		return;
+	}
+
+	for (ret = 0; ret < sizeof(buf); ret++)
+		dev_dbg(&priv->client->dev, "%d: 0x%x\n", ret, buf[ret]);
+
+	event = (buf[5] & 0xf0) >> 4;
+	touch_id = (buf[7] & 0xf0) >> 4;
+
+	dev_dbg(&priv->client->dev, "Event %d, TouchID %d\n", event, touch_id);
+
+	xpos[0] = (((buf[5] & 0xf) << 8) | buf[6]) >> 1;
+	ypos[0] = (((buf[7] & 0xf) << 8) | buf[8]) >> 1;
+
+	if (touch_id == 0 && event & EDT_EVENT_TOUCH_UP) {
+		if (!priv->up_reported)
+			edt_ts_release_event(priv);
+		goto done;
+	}
+
+	if (touch_id == 0 && event & EDT_EVENT_TOUCH_ON) {
+		priv->up_reported = 0;
+		input_report_key(priv->input, BTN_TOUCH, 1);
+		input_report_abs(priv->input, ABS_X, xpos[0]);
+		input_report_abs(priv->input, ABS_Y, ypos[0]);
+		input_report_abs(priv->input, ABS_PRESSURE, 255);
+		input_sync(priv->input);
+	}
+
+fixup_timer:
+	mod_timer(&priv->timer,
+		  jiffies + msecs_to_jiffies(EDT_TS_PENUP_TIMEOUT_MS));
+done:
+	enable_irq(priv->irq);
+}
+
+static void edt_ts_penup_timer(unsigned long handle)
+{
+	struct edt_ts_priv *priv = (void *)handle;
+
+	edt_ts_release_event(priv);
+}
+
+static irqreturn_t edt_ts_isr(int irq, void *dev_id)
+{
+	struct edt_ts_priv *priv = dev_id;
+
+	/* the touch screen controller chip is hooked up to the cpu
+	 * using i2c and a single interrupt line. the interrupt line
+	 * is pulled low whenever someone taps the screen.
+	 *
+	 * we can't read touch data from interrupt context since the i2c
+	 * bus controller may sleep, so we just disable the interrupt
+	 * here and handle it using delayed work.
+	 */
+	disable_irq_nosync(irq);
+	schedule_delayed_work(&priv->work, 0);
+
+	return IRQ_HANDLED;
+}
+
+
+static int edt_ts_open(struct input_dev *dev)
+{
+	struct edt_ts_priv *priv = input_get_drvdata(dev);
+	int ret;
+	char buf[2];
+
+	/* check the controller access */
+	ret = i2c_master_recv(priv->client, buf, sizeof(buf));
+	if (ret != sizeof(buf)) {
+		dev_err(&priv->client->dev, "controller access failed\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void edt_ts_close(struct input_dev *dev)
+{
+	struct edt_ts_priv *priv = input_get_drvdata(dev);
+
+	disable_irq(priv->irq);
+
+	/* cancel pending work and wait for edt_ts_read() to finish */
+	if (cancel_delayed_work_sync(&priv->work)) {
+		/*
+		 * if edt_ts_read() was canceled we need to enable IRQ
+		 * here to balance disable done in edt_ts_isr().
+		 */
+		enable_irq(priv->irq);
+	}
+
+	if (del_timer_sync(&priv->timer))
+		edt_ts_release_event(priv);
+
+	enable_irq(priv->irq);
+}
+
+static int edt_ts_probe(struct i2c_client *client,
+			   const struct i2c_device_id *id)
+{
+	struct edt_ts_priv *priv;
+	struct input_dev *input;
+	struct edt_platform_data *pdata = client->dev.platform_data;
+	int error, irq;
+
+	if (!pdata) {
+		dev_err(&client->dev, "no platform data\n");
+		error = -ENODEV;
+		goto err0;
+	}
+
+	if (!gpio_is_valid(pdata->irq_gpio)) {
+		dev_err(&client->dev, "invalid IRQ GPIO number\n");
+		error = -EINVAL;
+		goto err0;
+	}
+
+	irq = gpio_to_irq(pdata->irq_gpio);
+	if (irq < 0) {
+		dev_err(&client->dev, "can't get IRQ for GPIO\n");
+		error = -EINVAL;
+		goto err0;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		dev_err(&client->dev, "can't allocate driver data\n");
+		error = -ENOMEM;
+		goto err0;
+	}
+
+	dev_set_drvdata(&client->dev, priv);
+
+	input = input_allocate_device();
+	if (!input) {
+		dev_err(&client->dev, "can't allocate input device.\n");
+		error = -ENOMEM;
+		goto err1;
+	}
+
+	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	input_set_abs_params(input, ABS_X, 0, 800, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, 480, 0, 0);
+	input_set_abs_params(input, ABS_PRESSURE, 0, 255, 0, 0);
+
+	input->name = client->name;
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = &client->dev;
+
+	input->open = edt_ts_open;
+	input->close = edt_ts_close;
+
+	input_set_drvdata(input, priv);
+
+	priv->client = client;
+	priv->input = input;
+	INIT_DELAYED_WORK(&priv->work, edt_ts_read);
+	priv->irq = irq;
+	priv->irq_gpio = pdata->irq_gpio;
+
+	error = input_register_device(input);
+	if (error)
+		goto err1;
+
+	error = request_irq(priv->irq, edt_ts_isr, IRQF_TRIGGER_FALLING,
+			    client->name, priv);
+	if (error) {
+		dev_err(&client->dev, "can't request IRQ.\n");
+		goto err2;
+	}
+
+	setup_timer(&priv->timer, edt_ts_penup_timer, (unsigned long)priv);
+
+	device_init_wakeup(&client->dev, 1);
+	return 0;
+
+err2:
+	input_unregister_device(input);
+	input = NULL; /* don't free, unregister is enough */
+err1:
+	input_free_device(input);
+	kfree(priv);
+err0:
+	dev_set_drvdata(&client->dev, NULL);
+	return error;
+}
+
+static int edt_ts_remove(struct i2c_client *client)
+{
+	struct edt_ts_priv *priv = dev_get_drvdata(&client->dev);
+
+	free_irq(priv->irq, priv);
+	input_unregister_device(priv->input);
+	kfree(priv);
+	dev_set_drvdata(&client->dev, NULL);
+	device_init_wakeup(&client->dev, 0);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int edt_ts_suspend(struct device *dev)
+{
+	struct edt_ts_priv *priv = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(priv->irq);
+
+	return 0;
+}
+
+static int edt_ts_resume(struct device *dev)
+{
+	struct edt_ts_priv *priv = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(priv->irq);
+
+	return 0;
+}
+
+static const struct dev_pm_ops edt_pm_ops = {
+	.suspend = edt_ts_suspend,
+	.resume = edt_ts_resume,
+};
+#endif
+
+static const struct i2c_device_id edt_ts_idtbl[] = {
+	{ "edt_ts", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, edt_ts_idtbl);
+
+static struct i2c_driver edt_ts_driver = {
+	.driver = {
+		.name = "edt_ts",
+		.owner = THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm = &edt_pm_ops,
+#endif
+	},
+	.probe = edt_ts_probe,
+	.remove = edt_ts_remove,
+	.id_table = edt_ts_idtbl,
+};
+
+static int __init edt_ts_init(void)
+{
+	return i2c_add_driver(&edt_ts_driver);
+}
+module_init(edt_ts_init);
+
+static void __exit edt_ts_exit(void)
+{
+	i2c_del_driver(&edt_ts_driver);
+}
+module_exit(edt_ts_exit);
+
+MODULE_DESCRIPTION("EDT Display Touchscreen driver");
+MODULE_AUTHOR("Anatolij Gustschin <agust@denx.de>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/edt_ts.h b/include/linux/i2c/edt_ts.h
new file mode 100644
index 0000000..87048e6
--- /dev/null
+++ b/include/linux/i2c/edt_ts.h
@@ -0,0 +1,20 @@
+/*
+ * EDT Touchscreen driver
+ *
+ * Copyright (C) 2011 Ilya Yanok, EmCraft Systems
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifndef __LINUX_I2C_EDT_TS_H
+#define __LINUX_I2C_EDT_TS_H
+
+/* The platform data for the EDT touchscreen driver */
+struct edt_platform_data {
+	unsigned irq_gpio;
+};
+
+#endif /* __LINUX_I2C_EDT_TS_H */
-- 
1.7.6.4

