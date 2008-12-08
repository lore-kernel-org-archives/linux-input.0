From: "Kwangwoo Lee" <kwangwoo.lee@gmail.com>
Subject: Re: + input-add-tsc2007-based-touchscreen-driver.patch added to -mm tree
Date: Mon, 8 Dec 2008 14:35:59 +0900
Message-ID: <483a38b80812072135iefd5390q82ce022359401451@mail.gmail.com>
References: <200812070027.mB70R361001860@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.185]:3826 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbYLHFgD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Dec 2008 00:36:03 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1081882fkq.5
        for <linux-input@vger.kernel.org>; Sun, 07 Dec 2008 21:36:00 -0800 (PST)
In-Reply-To: <200812070027.mB70R361001860@imap1.linux-foundation.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org, linux-input@vger.kernel.org
Cc: mm-commits@vger.kernel.org, dtor@mail.ru, khali@linux-fr.org, David Brownell <david-b@pacbell.net>, felipe.balbi@nokia.com, Trilok Soni <soni.trilok@gmail.com>

>From d5258e21e38e38e4128112844f24621ffb1c1e86 Mon Sep 17 00:00:00 2001
From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Date: Mon, 8 Dec 2008 13:42:14 +0900
Subject: [PATCH] Add tsc2007 based touchscreen driver.

corrected some parts following in helpful comments:
Remove unnecessary headers and variables.
Use i2c_smbus_read_word_data() to prevent race condition.
Fix i2c_check_functionality() argument correctly.

Signed-off-by: Kwangwoo Lee <kwangwoo.lee@gmail.com>
---
 drivers/input/touchscreen/Kconfig   |    9 +
 drivers/input/touchscreen/Makefile  |    1 +
 drivers/input/touchscreen/tsc2007.c |  378 +++++++++++++++++++++++++++++++++++
 include/linux/i2c/tsc2007.h         |   17 ++
 4 files changed, 405 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/tsc2007.c
 create mode 100644 include/linux/i2c/tsc2007.h

diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
index 3d1ab8f..78abdfb 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -376,4 +376,13 @@ config TOUCHSCREEN_TOUCHIT213
 	  To compile this driver as a module, choose M here: the
 	  module will be called touchit213.

+config TOUCHSCREEN_TSC2007
+	tristate "TSC2007 based touchscreens"
+	depends on I2C
+	help
+	  Say Y here if you have a TSC2007 based touchscreens.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tsc2007.
+
 endif
diff --git a/drivers/input/touchscreen/Makefile
b/drivers/input/touchscreen/Makefile
index 15cf290..824999c 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -31,3 +31,4 @@ wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9705)	+= wm9705.o
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9712)	+= wm9712.o
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9713)	+= wm9713.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
+obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
diff --git a/drivers/input/touchscreen/tsc2007.c
b/drivers/input/touchscreen/tsc2007.c
new file mode 100644
index 0000000..44b68c1
--- /dev/null
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -0,0 +1,378 @@
+/*
+ * drivers/input/touchscreen/tsc2007.c
+ *
+ * Copyright (c) 2008 MtekVision Co., Ltd.
+ * 	Kwangwoo Lee <kwlee@mtekvision.com>
+ *
+ * Using code from:
+ *  - ads7846.c
+ * 	Copyright (c) 2005 David Brownell
+ * 	Copyright (c) 2006 Nokia Corporation
+ *  - corgi_ts.c
+ *	Copyright (C) 2004-2005 Richard Purdie
+ *  - omap_ts.[hc], ads7846.h, ts_osk.c
+ *	Copyright (C) 2002 MontaVista Software
+ *	Copyright (C) 2004 Texas Instruments
+ *	Copyright (C) 2005 Dirk Behme
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/hrtimer.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/i2c/tsc2007.h>
+
+#define TS_POLL_DELAY	(10 * 1000)	/* ns delay before the first sample */
+#define TS_POLL_PERIOD	(5 * 1000)	/* ns delay between samples */
+
+#define TSC2007_MEASURE_TEMP0		(0x0 << 4)
+#define TSC2007_MEASURE_AUX		(0x2 << 4)
+#define TSC2007_MEASURE_TEMP1		(0x4 << 4)
+#define TSC2007_ACTIVATE_XN		(0x8 << 4)
+#define TSC2007_ACTIVATE_YN		(0x9 << 4)
+#define TSC2007_ACTIVATE_YP_XN		(0xa << 4)
+#define TSC2007_SETUP			(0xb << 4)
+#define TSC2007_MEASURE_X		(0xc << 4)
+#define TSC2007_MEASURE_Y		(0xd << 4)
+#define TSC2007_MEASURE_Z1		(0xe << 4)
+#define TSC2007_MEASURE_Z2		(0xf << 4)
+
+#define TSC2007_POWER_OFF_IRQ_EN	(0x0 << 2)
+#define TSC2007_ADC_ON_IRQ_DIS0		(0x1 << 2)
+#define TSC2007_ADC_OFF_IRQ_EN		(0x2 << 2)
+#define TSC2007_ADC_ON_IRQ_DIS1		(0x3 << 2)
+
+#define TSC2007_12BIT			(0x0 << 1)
+#define TSC2007_8BIT			(0x1 << 1)
+
+#define	MAX_12BIT			((1 << 12) - 1)
+
+#define ADC_ON_12BIT	(TSC2007_12BIT | TSC2007_ADC_ON_IRQ_DIS0)
+
+#define READ_Y		(ADC_ON_12BIT | TSC2007_MEASURE_Y)
+#define READ_Z1		(ADC_ON_12BIT | TSC2007_MEASURE_Z1)
+#define READ_Z2		(ADC_ON_12BIT | TSC2007_MEASURE_Z2)
+#define READ_X		(ADC_ON_12BIT | TSC2007_MEASURE_X)
+#define PWRDOWN		(TSC2007_12BIT | TSC2007_POWER_OFF_IRQ_EN)
+
+struct ts_event {
+	u16	x;
+	u16	y;
+	u16	z1, z2;
+};
+
+struct tsc2007 {
+	struct input_dev	*input;
+	char			phys[32];
+	struct hrtimer		timer;
+	struct ts_event		tc;
+
+	struct i2c_client	*client;
+
+	spinlock_t		lock;
+
+	u16			model;
+	u16			x_plate_ohms;
+
+	unsigned		pendown;
+	int			irq;
+
+	int			(*get_pendown_state)(void);
+	void			(*clear_penirq)(void);
+};
+
+static inline int tsc2007_xfer(struct tsc2007 *tsc, u8 cmd)
+{
+	s32 data;
+	u16 val;
+
+	data = i2c_smbus_read_word_data(tsc->client, cmd);
+	if (data < 0) {
+		dev_err(&tsc->client->dev, "i2c io error: %d\n", data);
+		return data;
+	}
+
+	/* The protocol and raw data format from i2c interface:
+	 * S Addr Wr [A] Comm [A] S Addr Rd [A] [DataLow] A [DataHigh] NA P
+	 * Where DataLow has [D11-D4], DataHigh has [D3-D0 << 4 | Dummy 4bit].
+	 */
+
+	val = (u16) (data & 0xFFFF);
+	val = be16_to_cpu(val) >> 4;
+
+	dev_dbg(&tsc->client->dev, "data: 0x%x, val: 0x%x\n", data, val);
+
+	return val;
+}
+
+static void tsc2007_send_event(void *tsc)
+{
+	struct tsc2007	*ts = tsc;
+	u32		rt;
+	u16		x, y, z1, z2;
+
+	x = ts->tc.x;
+	y = ts->tc.y;
+	z1 = ts->tc.z1;
+	z2 = ts->tc.z2;
+
+	/* range filtering */
+	if (x == MAX_12BIT)
+		x = 0;
+
+	if (likely(x && z1)) {
+		/* compute touch pressure resistance using equation #1 */
+		rt = z2;
+		rt -= z1;
+		rt *= x;
+		rt *= ts->x_plate_ohms;
+		rt /= z1;
+		rt = (rt + 2047) >> 12;
+	} else
+		rt = 0;
+
+	/* Sample found inconsistent by debouncing or pressure is beyond
+	 * the maximum. Don't report it to user space, repeat at least
+	 * once more the measurement
+	 */
+	if (rt > MAX_12BIT) {
+		dev_dbg(&ts->client->dev, "ignored pressure %d\n", rt);
+
+		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
+			      HRTIMER_MODE_REL);
+		return;
+	}
+
+	/* NOTE: We can't rely on the pressure to determine the pen down
+	 * state, even this controller has a pressure sensor.  The pressure
+	 * value can fluctuate for quite a while after lifting the pen and
+	 * in some cases may not even settle at the expected value.
+	 *
+	 * The only safe way to check for the pen up condition is in the
+	 * timer by reading the pen signal state (it's a GPIO _and_ IRQ).
+	 */
+	if (rt) {
+		struct input_dev *input = ts->input;
+
+		if (!ts->pendown) {
+			dev_dbg(&ts->client->dev, "DOWN\n");
+
+			input_report_key(input, BTN_TOUCH, 1);
+			ts->pendown = 1;
+		}
+
+		input_report_abs(input, ABS_X, x);
+		input_report_abs(input, ABS_Y, y);
+		input_report_abs(input, ABS_PRESSURE, rt);
+
+		input_sync(input);
+
+		dev_dbg(&ts->client->dev, "point(%4d,%4d), pressure (%4u)\n",
+			x, y, rt);
+	}
+
+	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
+			HRTIMER_MODE_REL);
+}
+
+static int tsc2007_read_values(struct tsc2007 *tsc)
+{
+	/* y- still on; turn on only y+ (and ADC) */
+	tsc->tc.y = tsc2007_xfer(tsc, READ_Y);
+
+	/* turn y- off, x+ on, then leave in lowpower */
+	tsc->tc.x = tsc2007_xfer(tsc, READ_X);
+
+	/* turn y+ off, x- on; we'll use formula #1 */
+	tsc->tc.z1 = tsc2007_xfer(tsc, READ_Z1);
+	tsc->tc.z2 = tsc2007_xfer(tsc, READ_Z2);
+
+	/* power down */
+	tsc2007_xfer(tsc, PWRDOWN);
+	return 0;
+}
+
+static enum hrtimer_restart tsc2007_timer(struct hrtimer *handle)
+{
+	struct tsc2007	*ts = container_of(handle, struct tsc2007, timer);
+
+	spin_lock_irq(&ts->lock);
+
+	if (unlikely(!ts->get_pendown_state() && ts->pendown)) {
+		struct input_dev *input = ts->input;
+
+		dev_dbg(&ts->client->dev, "UP\n");
+
+		input_report_key(input, BTN_TOUCH, 0);
+		input_report_abs(input, ABS_PRESSURE, 0);
+		input_sync(input);
+
+		ts->pendown = 0;
+		enable_irq(ts->irq);
+	} else {
+		/* pen is still down, continue with the measurement */
+		dev_dbg(&ts->client->dev, "pen is still down\n");
+
+		tsc2007_read_values(ts);
+		tsc2007_send_event(ts);
+	}
+
+	spin_unlock_irq(&ts->lock);
+	return HRTIMER_NORESTART;
+}
+
+static irqreturn_t tsc2007_irq(int irq, void *handle)
+{
+	struct tsc2007 *ts = handle;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+	if (likely(ts->get_pendown_state())) {
+		disable_irq(ts->irq);
+		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_DELAY),
+					HRTIMER_MODE_REL);
+	}
+
+	if (ts->clear_penirq)
+		ts->clear_penirq();
+
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static int tsc2007_probe(struct i2c_client *client,
+			const struct i2c_device_id *id)
+{
+	struct tsc2007		*ts;
+	struct tsc2007_platform_data *pdata;
+	struct input_dev	*input_dev;
+	int			err;
+
+	pdata = client->dev.platform_data;
+	if (pdata == NULL) {
+		dev_err(&client->dev, "platform data is required!\n");
+		return -EINVAL;
+	}
+
+	if (!i2c_check_functionality(client->adapter,
+		I2C_FUNC_SMBUS_READ_WORD_DATA))
+		return -EIO;
+
+	ts = kzalloc(sizeof(struct tsc2007), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ts || !input_dev) {
+		err = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	ts->client = client;
+	i2c_set_clientdata(client, ts);
+
+	ts->input = input_dev;
+
+	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	ts->timer.function = tsc2007_timer;
+
+	spin_lock_init(&ts->lock);
+
+	ts->model             = pdata->model;
+	ts->x_plate_ohms      = pdata->x_plate_ohms;
+	ts->get_pendown_state = pdata->get_pendown_state;
+	ts->clear_penirq      = pdata->clear_penirq;
+
+	pdata->init_platform_hw();
+
+	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", client->dev.bus_id);
+
+	input_dev->name = "TSC2007 Touchscreen";
+	input_dev->phys = ts->phys;
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT, 0, 0);
+
+	tsc2007_read_values(ts);
+
+	ts->irq = client->irq;
+	err = request_irq(ts->irq, tsc2007_irq, 0,
+			client->dev.driver->name, ts);
+	if (err < 0) {
+		dev_err(&client->dev, "irq %d busy?\n", ts->irq);
+		goto err_free_mem;
+	}
+
+	err = input_register_device(input_dev);
+	if (err)
+		goto err_free_irq;
+
+	dev_info(&client->dev, "registered with irq (%d)\n", ts->irq);
+
+	return 0;
+
+ err_free_irq:
+	free_irq(ts->irq, ts);
+ err_free_mem:
+	input_free_device(input_dev);
+	kfree(ts);
+	return err;
+}
+
+static int tsc2007_remove(struct i2c_client *client)
+{
+	struct tsc2007	*ts = i2c_get_clientdata(client);
+	struct tsc2007_platform_data *pdata;
+
+	pdata = client->dev.platform_data;
+	pdata->exit_platform_hw();
+
+	input_unregister_device(ts->input);
+	free_irq(ts->irq, ts);
+	kfree(ts);
+
+	dev_info(&client->dev, "unregistered\n");
+	return 0;
+}
+
+static struct i2c_device_id tsc2007_idtable[] = {
+	{ "tsc2007", 0 },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, tsc2007_idtable);
+
+static struct i2c_driver tsc2007_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "tsc2007"
+	},
+	.id_table	= tsc2007_idtable,
+	.probe		= tsc2007_probe,
+	.remove		= tsc2007_remove,
+};
+
+static int __init tsc2007_init(void)
+{
+	return i2c_add_driver(&tsc2007_driver);
+}
+
+static void __exit tsc2007_exit(void)
+{
+	i2c_del_driver(&tsc2007_driver);
+}
+
+module_init(tsc2007_init);
+module_exit(tsc2007_exit);
+
+MODULE_AUTHOR("Kwangwoo Lee <kwlee@mtekvision.com>");
+MODULE_DESCRIPTION("TSC2007 TouchScreen Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c/tsc2007.h b/include/linux/i2c/tsc2007.h
new file mode 100644
index 0000000..c6361fb
--- /dev/null
+++ b/include/linux/i2c/tsc2007.h
@@ -0,0 +1,17 @@
+#ifndef __LINUX_I2C_TSC2007_H
+#define __LINUX_I2C_TSC2007_H
+
+/* linux/i2c/tsc2007.h */
+
+struct tsc2007_platform_data {
+	u16	model;				/* 2007. */
+	u16	x_plate_ohms;
+
+	int	(*get_pendown_state)(void);
+	void	(*clear_penirq)(void);		/* If needed, clear 2nd level
+						   interrupt source */
+	int	(*init_platform_hw)(void);
+	void	(*exit_platform_hw)(void);
+};
+
+#endif
-- 
1.5.6.5
