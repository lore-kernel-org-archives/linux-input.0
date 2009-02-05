From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH] input: let's remove the now deprecated corgi_ts.c
Date: Thu, 5 Feb 2009 18:26:46 +0800
Message-ID: <f17812d70902050226g1780ca58m4d271b55ba3d3166@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:42737 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbZBEK0s (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2009 05:26:48 -0500
Received: by rv-out-0506.google.com with SMTP id g9so2391367rvb.5
        for <linux-input@vger.kernel.org>; Thu, 05 Feb 2009 02:26:46 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-input@vger.kernel.org

Let's move to the generic SPI based ADS7846 touchscreen driver.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---

Richard, any concern on this move?

 drivers/input/touchscreen/Kconfig    |   17 --
 drivers/input/touchscreen/Makefile   |    1 -
 drivers/input/touchscreen/corgi_ts.c |  385 ----------------------------------
 3 files changed, 0 insertions(+), 403 deletions(-)
 delete mode 100644 drivers/input/touchscreen/corgi_ts.c

diff --git a/drivers/input/touchscreen/Kconfig
b/drivers/input/touchscreen/Kconfig
index bb6486a..b513845 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -41,23 +41,6 @@ config TOUCHSCREEN_BITSY
 	  To compile this driver as a module, choose M here: the
 	  module will be called h3600_ts_input.

-config TOUCHSCREEN_CORGI
-	tristate "SharpSL (Corgi and Spitz series) touchscreen driver (DEPRECATED)"
-	depends on PXA_SHARPSL
-	select CORGI_SSP_DEPRECATED
-	default y
-	help
-	  Say Y here to enable the driver for the touchscreen on the
-	  Sharp SL-C7xx and SL-Cxx00 series of PDAs.
-
-	  If unsure, say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called corgi_ts.
-
-	  NOTE: this driver is deprecated, try enable SPI and generic
-	  ADS7846-based touchscreen driver.
-
 config TOUCHSCREEN_DA9034
 	tristate "Touchscreen support for Dialog Semiconductor DA9034"
 	depends on PMIC_DA903X
diff --git a/drivers/input/touchscreen/Makefile
b/drivers/input/touchscreen/Makefile
index d3375af..f7e6d2d 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -9,7 +9,6 @@ wm97xx-ts-y := wm97xx-core.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
-obj-$(CONFIG_TOUCHSCREEN_CORGI)		+= corgi_ts.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
diff --git a/drivers/input/touchscreen/corgi_ts.c
b/drivers/input/touchscreen/corgi_ts.c
deleted file mode 100644
index 65202c9..0000000
--- a/drivers/input/touchscreen/corgi_ts.c
+++ /dev/null
@@ -1,385 +0,0 @@
-/*
- *  Touchscreen driver for Sharp SL-C7xx and SL-Cxx00 models
- *
- *  Copyright (c) 2004-2005 Richard Purdie
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- *
- */
-
-
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/init.h>
-#include <linux/input.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/irq.h>
-
-#include <mach/sharpsl.h>
-#include <mach/hardware.h>
-#include <mach/pxa-regs.h>
-#include <mach/pxa2xx-gpio.h>
-
-
-#define PWR_MODE_ACTIVE		0
-#define PWR_MODE_SUSPEND	1
-
-#define X_AXIS_MAX		3830
-#define X_AXIS_MIN		150
-#define Y_AXIS_MAX		3830
-#define Y_AXIS_MIN		190
-#define PRESSURE_MIN		0
-#define PRESSURE_MAX		15000
-
-struct ts_event {
-	short pressure;
-	short x;
-	short y;
-};
-
-struct corgi_ts {
-	struct input_dev *input;
-	struct timer_list timer;
-	struct ts_event tc;
-	int pendown;
-	int power_mode;
-	int irq_gpio;
-	struct corgits_machinfo *machinfo;
-};
-
-#ifdef CONFIG_PXA25x
-#define CCNT(a)		asm volatile ("mrc p14, 0, %0, C1, C0, 0" : "=r"(a))
-#define PMNC_GET(x)	asm volatile ("mrc p14, 0, %0, C0, C0, 0" : "=r"(x))
-#define PMNC_SET(x)	asm volatile ("mcr p14, 0, %0, C0, C0, 0" : : "r"(x))
-#endif
-#ifdef CONFIG_PXA27x
-#define CCNT(a)		asm volatile ("mrc p14, 0, %0, C1, C1, 0" : "=r"(a))
-#define PMNC_GET(x)	asm volatile ("mrc p14, 0, %0, C0, C1, 0" : "=r"(x))
-#define PMNC_SET(x)	asm volatile ("mcr p14, 0, %0, C0, C1, 0" : : "r"(x))
-#endif
-
-/* ADS7846 Touch Screen Controller bit definitions */
-#define ADSCTRL_PD0		(1u << 0)	/* PD0 */
-#define ADSCTRL_PD1		(1u << 1)	/* PD1 */
-#define ADSCTRL_DFR		(1u << 2)	/* SER/DFR */
-#define ADSCTRL_MOD		(1u << 3)	/* Mode */
-#define ADSCTRL_ADR_SH	4	/* Address setting */
-#define ADSCTRL_STS		(1u << 7)	/* Start Bit */
-
-/* External Functions */
-extern unsigned int get_clk_frequency_khz(int info);
-
-static unsigned long calc_waittime(struct corgi_ts *corgi_ts)
-{
-	unsigned long hsync_invperiod = corgi_ts->machinfo->get_hsync_invperiod();
-
-	if (hsync_invperiod)
-		return get_clk_frequency_khz(0)*1000/hsync_invperiod;
-	else
-		return 0;
-}
-
-static int sync_receive_data_send_cmd(struct corgi_ts *corgi_ts, int
doRecive, int doSend,
-		unsigned int address, unsigned long wait_time)
-{
-	unsigned long timer1 = 0, timer2, pmnc = 0;
-	int pos = 0;
-
-	if (wait_time && doSend) {
-		PMNC_GET(pmnc);
-		if (!(pmnc & 0x01))
-			PMNC_SET(0x01);
-
-		/* polling HSync */
-		corgi_ts->machinfo->wait_hsync();
-		/* get CCNT */
-		CCNT(timer1);
-	}
-
-	if (doRecive)
-		pos = corgi_ssp_ads7846_get();
-
-	if (doSend) {
-		int cmd = ADSCTRL_PD0 | ADSCTRL_PD1 | (address << ADSCTRL_ADR_SH) |
ADSCTRL_STS;
-		/* dummy command */
-		corgi_ssp_ads7846_put(cmd);
-		corgi_ssp_ads7846_get();
-
-		if (wait_time) {
-			/* Wait after HSync */
-			CCNT(timer2);
-			if (timer2-timer1 > wait_time) {
-				/* too slow - timeout, try again */
-				corgi_ts->machinfo->wait_hsync();
-				/* get CCNT */
-				CCNT(timer1);
-				/* Wait after HSync */
-				CCNT(timer2);
-			}
-			while (timer2 - timer1 < wait_time)
-				CCNT(timer2);
-		}
-		corgi_ssp_ads7846_put(cmd);
-		if (wait_time && !(pmnc & 0x01))
-			PMNC_SET(pmnc);
-	}
-	return pos;
-}
-
-static int read_xydata(struct corgi_ts *corgi_ts)
-{
-	unsigned int x, y, z1, z2;
-	unsigned long flags, wait_time;
-
-	/* critical section */
-	local_irq_save(flags);
-	corgi_ssp_ads7846_lock();
-	wait_time = calc_waittime(corgi_ts);
-
-	/* Y-axis */
-	sync_receive_data_send_cmd(corgi_ts, 0, 1, 1u, wait_time);
-
-	/* Y-axis */
-	sync_receive_data_send_cmd(corgi_ts, 1, 1, 1u, wait_time);
-
-	/* X-axis */
-	y = sync_receive_data_send_cmd(corgi_ts, 1, 1, 5u, wait_time);
-
-	/* Z1 */
-	x = sync_receive_data_send_cmd(corgi_ts, 1, 1, 3u, wait_time);
-
-	/* Z2 */
-	z1 = sync_receive_data_send_cmd(corgi_ts, 1, 1, 4u, wait_time);
-	z2 = sync_receive_data_send_cmd(corgi_ts, 1, 0, 4u, wait_time);
-
-	/* Power-Down Enable */
-	corgi_ssp_ads7846_put((1u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
-	corgi_ssp_ads7846_get();
-
-	corgi_ssp_ads7846_unlock();
-	local_irq_restore(flags);
-
-	if (x== 0 || y == 0 || z1 == 0 || (x * (z2 - z1) / z1) >= 15000) {
-		corgi_ts->tc.pressure = 0;
-		return 0;
-	}
-
-	corgi_ts->tc.x = x;
-	corgi_ts->tc.y = y;
-	corgi_ts->tc.pressure = (x * (z2 - z1)) / z1;
-	return 1;
-}
-
-static void new_data(struct corgi_ts *corgi_ts)
-{
-	struct input_dev *dev = corgi_ts->input;
-
-	if (corgi_ts->power_mode != PWR_MODE_ACTIVE)
-		return;
-
-	if (!corgi_ts->tc.pressure && corgi_ts->pendown == 0)
-		return;
-
-	input_report_abs(dev, ABS_X, corgi_ts->tc.x);
-	input_report_abs(dev, ABS_Y, corgi_ts->tc.y);
-	input_report_abs(dev, ABS_PRESSURE, corgi_ts->tc.pressure);
-	input_report_key(dev, BTN_TOUCH, corgi_ts->pendown);
-	input_sync(dev);
-}
-
-static void ts_interrupt_main(struct corgi_ts *corgi_ts, int isTimer)
-{
-	if ((GPLR(IRQ_TO_GPIO(corgi_ts->irq_gpio)) &
GPIO_bit(IRQ_TO_GPIO(corgi_ts->irq_gpio))) == 0) {
-		/* Disable Interrupt */
-		set_irq_type(corgi_ts->irq_gpio, IRQ_TYPE_NONE);
-		if (read_xydata(corgi_ts)) {
-			corgi_ts->pendown = 1;
-			new_data(corgi_ts);
-		}
-		mod_timer(&corgi_ts->timer, jiffies + HZ / 100);
-	} else {
-		if (corgi_ts->pendown == 1 || corgi_ts->pendown == 2) {
-			mod_timer(&corgi_ts->timer, jiffies + HZ / 100);
-			corgi_ts->pendown++;
-			return;
-		}
-
-		if (corgi_ts->pendown) {
-			corgi_ts->tc.pressure = 0;
-			new_data(corgi_ts);
-		}
-
-		/* Enable Falling Edge */
-		set_irq_type(corgi_ts->irq_gpio, IRQ_TYPE_EDGE_FALLING);
-		corgi_ts->pendown = 0;
-	}
-}
-
-static void corgi_ts_timer(unsigned long data)
-{
-	struct corgi_ts *corgits_data = (struct corgi_ts *) data;
-
-	ts_interrupt_main(corgits_data, 1);
-}
-
-static irqreturn_t ts_interrupt(int irq, void *dev_id)
-{
-	struct corgi_ts *corgits_data = dev_id;
-
-	ts_interrupt_main(corgits_data, 0);
-	return IRQ_HANDLED;
-}
-
-#ifdef CONFIG_PM
-static int corgits_suspend(struct platform_device *dev, pm_message_t state)
-{
-	struct corgi_ts *corgi_ts = platform_get_drvdata(dev);
-
-	if (corgi_ts->pendown) {
-		del_timer_sync(&corgi_ts->timer);
-		corgi_ts->tc.pressure = 0;
-		new_data(corgi_ts);
-		corgi_ts->pendown = 0;
-	}
-	corgi_ts->power_mode = PWR_MODE_SUSPEND;
-
-	corgi_ssp_ads7846_putget((1u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
-
-	return 0;
-}
-
-static int corgits_resume(struct platform_device *dev)
-{
-	struct corgi_ts *corgi_ts = platform_get_drvdata(dev);
-
-	corgi_ssp_ads7846_putget((4u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
-	/* Enable Falling Edge */
-	set_irq_type(corgi_ts->irq_gpio, IRQ_TYPE_EDGE_FALLING);
-	corgi_ts->power_mode = PWR_MODE_ACTIVE;
-
-	return 0;
-}
-#else
-#define corgits_suspend		NULL
-#define corgits_resume		NULL
-#endif
-
-static int __init corgits_probe(struct platform_device *pdev)
-{
-	struct corgi_ts *corgi_ts;
-	struct input_dev *input_dev;
-	int err = -ENOMEM;
-
-	corgi_ts = kzalloc(sizeof(struct corgi_ts), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!corgi_ts || !input_dev)
-		goto fail1;
-
-	platform_set_drvdata(pdev, corgi_ts);
-
-	corgi_ts->machinfo = pdev->dev.platform_data;
-	corgi_ts->irq_gpio = platform_get_irq(pdev, 0);
-
-	if (corgi_ts->irq_gpio < 0) {
-		err = -ENODEV;
-		goto fail1;
-	}
-
-	corgi_ts->input = input_dev;
-
-	init_timer(&corgi_ts->timer);
-	corgi_ts->timer.data = (unsigned long) corgi_ts;
-	corgi_ts->timer.function = corgi_ts_timer;
-
-	input_dev->name = "Corgi Touchscreen";
-	input_dev->phys = "corgits/input0";
-	input_dev->id.bustype = BUS_HOST;
-	input_dev->id.vendor = 0x0001;
-	input_dev->id.product = 0x0002;
-	input_dev->id.version = 0x0100;
-	input_dev->dev.parent = &pdev->dev;
-
-	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
-	input_set_abs_params(input_dev, ABS_X, X_AXIS_MIN, X_AXIS_MAX, 0, 0);
-	input_set_abs_params(input_dev, ABS_Y, Y_AXIS_MIN, Y_AXIS_MAX, 0, 0);
-	input_set_abs_params(input_dev, ABS_PRESSURE, PRESSURE_MIN,
PRESSURE_MAX, 0, 0);
-
-	pxa_gpio_mode(IRQ_TO_GPIO(corgi_ts->irq_gpio) | GPIO_IN);
-
-	/* Initiaize ADS7846 Difference Reference mode */
-	corgi_ssp_ads7846_putget((1u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
-	mdelay(5);
-	corgi_ssp_ads7846_putget((3u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
-	mdelay(5);
-	corgi_ssp_ads7846_putget((4u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
-	mdelay(5);
-	corgi_ssp_ads7846_putget((5u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
-	mdelay(5);
-
-	if (request_irq(corgi_ts->irq_gpio, ts_interrupt, IRQF_DISABLED,
"ts", corgi_ts)) {
-		err = -EBUSY;
-		goto fail1;
-	}
-
-	err = input_register_device(corgi_ts->input);
-	if (err)
-		goto fail2;
-
-	corgi_ts->power_mode = PWR_MODE_ACTIVE;
-
-	/* Enable Falling Edge */
-	set_irq_type(corgi_ts->irq_gpio, IRQ_TYPE_EDGE_FALLING);
-
-	return 0;
-
- fail2:	free_irq(corgi_ts->irq_gpio, corgi_ts);
- fail1:	input_free_device(input_dev);
-	kfree(corgi_ts);
-	return err;
-}
-
-static int corgits_remove(struct platform_device *pdev)
-{
-	struct corgi_ts *corgi_ts = platform_get_drvdata(pdev);
-
-	free_irq(corgi_ts->irq_gpio, corgi_ts);
-	del_timer_sync(&corgi_ts->timer);
-	corgi_ts->machinfo->put_hsync();
-	input_unregister_device(corgi_ts->input);
-	kfree(corgi_ts);
-	return 0;
-}
-
-static struct platform_driver corgits_driver = {
-	.probe		= corgits_probe,
-	.remove		= corgits_remove,
-	.suspend	= corgits_suspend,
-	.resume		= corgits_resume,
-	.driver		= {
-		.name	= "corgi-ts",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __devinit corgits_init(void)
-{
-	return platform_driver_register(&corgits_driver);
-}
-
-static void __exit corgits_exit(void)
-{
-	platform_driver_unregister(&corgits_driver);
-}
-
-module_init(corgits_init);
-module_exit(corgits_exit);
-
-MODULE_AUTHOR("Richard Purdie <rpurdie@rpsys.net>");
-MODULE_DESCRIPTION("Corgi TouchScreen Driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:corgi-ts");
-- 
1.6.0.4
