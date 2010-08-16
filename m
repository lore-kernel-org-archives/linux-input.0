From: wellsk40@gmail.com
Subject: [PATCH] input/touch: Introduce the LPC32xx touchscreen controller driver (v2)
Date: Mon, 16 Aug 2010 14:21:01 -0700
Message-ID: <1281993661-21097-2-git-send-email-wellsk40@gmail.com>
References: <1281993661-21097-1-git-send-email-wellsk40@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:56008 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756432Ab0HPVWM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Aug 2010 17:22:12 -0400
Received: by mail-vw0-f46.google.com with SMTP id 3so3820734vws.19
        for <linux-input@vger.kernel.org>; Mon, 16 Aug 2010 14:22:12 -0700 (PDT)
In-Reply-To: <1281993661-21097-1-git-send-email-wellsk40@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Kevin Wells <wellsk40@gmail.com>, Durgesh Pattamatta <durgesh.pattamatta@nxp.com>

From: Kevin Wells <wellsk40@gmail.com>

This patch set introduces support for the LPC32xx touchscreen
controller driver. The LPC32xx touchscreen controller supports
automated event detection and X/Y data conversion for resistive
touchscreens.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
Signed-off-by: Durgesh Pattamatta <durgesh.pattamatta@nxp.com>
---
 drivers/input/touchscreen/Kconfig      |   10 +
 drivers/input/touchscreen/Makefile     |    1 +
 drivers/input/touchscreen/lpc32xx_ts.c |  404 ++++++++++++++++++++++++++++++++
 3 files changed, 415 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/lpc32xx_ts.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 0069d97..400c99d 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -214,6 +214,16 @@ config TOUCHSCREEN_WACOM_W8001
 	  To compile this driver as a module, choose M here: the
 	  module will be called wacom_w8001.
 
+config TOUCHSCREEN_LPC32XX
+	tristate "LPC32XX touchscreen controller"
+	depends on ARCH_LPC32XX
+	help
+	  Say Y here if you have a LPC32XX device and want
+	  to support the built-in touchscreen.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called lpc32xx_ts.
+
 config TOUCHSCREEN_MCS5000
 	tristate "MELFAS MCS-5000 touchscreen"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 28217e1..22e2d59 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_TOUCHSCREEN_EETI)		+= eeti_ts.o
 obj-$(CONFIG_TOUCHSCREEN_ELO)		+= elo.o
 obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
 obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+= inexio.o
+obj-$(CONFIG_TOUCHSCREEN_LPC32XX)	+= lpc32xx_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MC13783)	+= mc13783_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MCS5000)	+= mcs5000_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MIGOR)		+= migor_ts.o
diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
new file mode 100644
index 0000000..e67ce41
--- /dev/null
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -0,0 +1,404 @@
+/*
+ * LPC32xx built-in touchscreen driver
+ *
+ * Copyright (C) 2010 NXP Semiconductors
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+/*
+ * Touchscreen controller register offsets
+ */
+#define LPC32XX_TSC_STAT			0x00
+#define LPC32XX_TSC_SEL				0x04
+#define LPC32XX_TSC_CON				0x08
+#define LPC32XX_TSC_FIFO			0x0C
+#define LPC32XX_TSC_DTR				0x10
+#define LPC32XX_TSC_RTR				0x14
+#define LPC32XX_TSC_UTR				0x18
+#define LPC32XX_TSC_TTR				0x1C
+#define LPC32XX_TSC_DXP				0x20
+#define LPC32XX_TSC_MIN_X			0x24
+#define LPC32XX_TSC_MAX_X			0x28
+#define LPC32XX_TSC_MIN_Y			0x2C
+#define LPC32XX_TSC_MAX_Y			0x30
+#define LPC32XX_TSC_AUX_UTR			0x34
+#define LPC32XX_TSC_AUX_MIN			0x38
+#define LPC32XX_TSC_AUX_MAX			0x3C
+
+#define LPC32XX_TSC_STAT_FIFO_OVRRN		(1 << 8)
+#define LPC32XX_TSC_STAT_FIFO_EMPTY		(1 << 7)
+
+#define LPC32XX_TSC_SEL_DEFVAL			0x0284
+
+#define LPC32XX_TSC_ADCCON_IRQ_TO_FIFO_4	(0x1 << 11)
+#define LPC32XX_TSC_ADCCON_X_SAMPLE_SIZE(s)	((10 - (s)) << 7)
+#define LPC32XX_TSC_ADCCON_Y_SAMPLE_SIZE(s)	((10 - (s)) << 4)
+#define LPC32XX_TSC_ADCCON_POWER_UP		(1 << 2)
+#define LPC32XX_TSC_ADCCON_AUTO_EN		(1 << 0)
+
+#define LPC32XX_TSC_FIFO_TS_P_LEVEL		(1 << 31)
+#define LPC32XX_TSC_FIFO_NORMALIZE_X_VAL(x)	(((x) & 0x03FF0000) >> 16)
+#define LPC32XX_TSC_FIFO_NORMALIZE_Y_VAL(y)	((y) & 0x000003FF)
+
+#define LPC32XX_TSC_ADCDAT_VALUE_MASK		0x000003FF
+
+#define LPC32XX_TSC_MIN_XY_VAL			0x0
+#define LPC32XX_TSC_MAX_XY_VAL			0x3FF
+
+#define MOD_NAME "ts-lpc32xx"
+
+#define tsc_readl(dev, reg) \
+	__raw_readl((dev)->tsc_base + (reg))
+#define tsc_writel(dev, reg, val) \
+	__raw_writel((val), (dev)->tsc_base + (reg))
+
+struct lpc32xx_tsc {
+	struct input_dev *dev;
+	void __iomem *tsc_base;
+	int irq;
+	struct clk *clk;
+};
+
+static void lpc32xx_fifo_clear(struct lpc32xx_tsc *tsc)
+{
+	while (!(tsc_readl(tsc, LPC32XX_TSC_STAT) &
+			   LPC32XX_TSC_STAT_FIFO_EMPTY))
+		tsc_readl(tsc, LPC32XX_TSC_FIFO);
+}
+
+static irqreturn_t lpc32xx_ts_interrupt(int irq, void *dev_id)
+{
+	u32 tmp, rv[4], xs[4], ys[4];
+	int idx;
+	struct lpc32xx_tsc *tsc = dev_id;
+	struct input_dev *input = tsc->dev;
+
+	tmp = tsc_readl(tsc, LPC32XX_TSC_STAT);
+
+	if (tmp & LPC32XX_TSC_STAT_FIFO_OVRRN) {
+		/* FIFO overflow - throw away samples */
+		lpc32xx_fifo_clear(tsc);
+		return IRQ_HANDLED;
+	}
+
+	/*
+	 * Gather and normalize 4 samples. Pen-up events may have less
+	 * than 4 samples, but its ok to pop 4 and let the last sample
+	 * pen status check drop the samples.
+	 */
+	idx = 0;
+	while ((idx < 4) &&
+		(!(tsc_readl(tsc, LPC32XX_TSC_STAT) &
+			     LPC32XX_TSC_STAT_FIFO_EMPTY))) {
+		tmp = tsc_readl(tsc, LPC32XX_TSC_FIFO);
+		xs[idx] = LPC32XX_TSC_ADCDAT_VALUE_MASK -
+			LPC32XX_TSC_FIFO_NORMALIZE_X_VAL(tmp);
+		ys[idx] = LPC32XX_TSC_ADCDAT_VALUE_MASK -
+			LPC32XX_TSC_FIFO_NORMALIZE_Y_VAL(tmp);
+		rv[idx] = tmp;
+		idx++;
+	}
+
+	/* Data is only valid if pen is still down in last sample */
+	if ((!(rv[3] & LPC32XX_TSC_FIFO_TS_P_LEVEL)) && (idx == 4)) {
+		/* Use average of 2nd and 3rd sample for position */
+		input_report_abs(input, ABS_X, ((xs[1] + xs[2]) / 2));
+		input_report_abs(input, ABS_Y, ((ys[1] + ys[2]) / 2));
+		input_report_key(input, BTN_TOUCH, 1);
+	} else {
+		input_report_key(input, BTN_TOUCH, 0);
+	}
+
+	input_sync(input);
+
+	return IRQ_HANDLED;
+}
+
+static void lpc32xx_stop_tsc(struct lpc32xx_tsc *tsc)
+{
+	/* Disable auto mode */
+	tsc_writel(tsc, LPC32XX_TSC_CON,
+		   tsc_readl(tsc, LPC32XX_TSC_CON) &
+			     ~LPC32XX_TSC_ADCCON_AUTO_EN);
+
+	clk_disable(tsc->clk);
+}
+
+static void lpc32xx_setup_tsc(struct lpc32xx_tsc *tsc)
+{
+	u32 tmp;
+
+	clk_enable(tsc->clk);
+
+	tmp = tsc_readl(tsc, LPC32XX_TSC_CON) & ~LPC32XX_TSC_ADCCON_POWER_UP;
+
+	/* Set the TSC FIFO depth to 4 samples @ 10-bits per sample (max) */
+	tmp = (LPC32XX_TSC_ADCCON_IRQ_TO_FIFO_4 |
+		LPC32XX_TSC_ADCCON_X_SAMPLE_SIZE(10) |
+		LPC32XX_TSC_ADCCON_Y_SAMPLE_SIZE(10));
+	tsc_writel(tsc, LPC32XX_TSC_CON, tmp);
+
+	/* These values are all preset */
+	tsc_writel(tsc, LPC32XX_TSC_SEL, LPC32XX_TSC_SEL_DEFVAL);
+	tsc_writel(tsc, LPC32XX_TSC_MIN_X, LPC32XX_TSC_MIN_XY_VAL);
+	tsc_writel(tsc, LPC32XX_TSC_MAX_X, LPC32XX_TSC_MAX_XY_VAL);
+	tsc_writel(tsc, LPC32XX_TSC_MIN_Y, LPC32XX_TSC_MIN_XY_VAL);
+	tsc_writel(tsc, LPC32XX_TSC_MAX_Y, LPC32XX_TSC_MAX_XY_VAL);
+
+	/* Aux support is not used */
+	tsc_writel(tsc, LPC32XX_TSC_AUX_UTR, 0);
+	tsc_writel(tsc, LPC32XX_TSC_AUX_MIN, 0);
+	tsc_writel(tsc, LPC32XX_TSC_AUX_MAX, 0);
+
+	/*
+	 * Set sample rate to about 240Hz per X/Y pair. A single measurement
+	 * consists of 4 pairs which gives about a 60Hz sample rate based on
+	 * a stable 32768Hz clock source. Values are in clocks.
+	 * Rate is (32768 / (RTR + XCONV + RTR + YCONV + DXP + TTR + UTR) / 4
+	 */
+	tsc_writel(tsc, LPC32XX_TSC_RTR, 0x2);
+	tsc_writel(tsc, LPC32XX_TSC_DTR, 0x2);
+	tsc_writel(tsc, LPC32XX_TSC_TTR, 0x10);
+	tsc_writel(tsc, LPC32XX_TSC_DXP, 0x4);
+	tsc_writel(tsc, LPC32XX_TSC_UTR, 88);
+
+	lpc32xx_fifo_clear(tsc);
+
+	/* Enable automatic ts event capture */
+	tsc_writel(tsc, LPC32XX_TSC_CON, tmp | LPC32XX_TSC_ADCCON_AUTO_EN);
+}
+
+static int lpc32xx_ts_open(struct input_dev *dev)
+{
+	struct lpc32xx_tsc *tsc = input_get_drvdata(dev);
+
+	lpc32xx_setup_tsc(tsc);
+
+	return 0;
+}
+
+static void lpc32xx_ts_close(struct input_dev *dev)
+{
+	struct lpc32xx_tsc *tsc = input_get_drvdata(dev);
+
+	lpc32xx_stop_tsc(tsc);
+}
+
+static int __devinit lpc32xx_ts_probe(struct platform_device *pdev)
+{
+	struct lpc32xx_tsc *tsc;
+	struct resource *res;
+	resource_size_t size;
+	int retval;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "Can't get memory resource\n");
+		return -ENOENT;
+	}
+
+	retval = platform_get_irq(pdev, 0);
+	if (retval < 0) {
+		dev_err(&pdev->dev, "Can't get interrupt resource\n");
+		return retval;
+	}
+
+	tsc = kzalloc(sizeof(*tsc), GFP_KERNEL);
+	if (unlikely(!tsc)) {
+		dev_err(&pdev->dev, "failed allocating memory\n");
+		return -ENOMEM;
+	}
+	tsc->irq = retval;
+
+	size = resource_size(res);
+
+	if (!request_mem_region(res->start, size, pdev->name)) {
+		dev_err(&pdev->dev, "TSC registers are not free\n");
+		retval = -EBUSY;
+		goto err_free_mem;
+	}
+
+	tsc->tsc_base = ioremap(res->start, size);
+	if (!tsc->tsc_base) {
+		dev_err(&pdev->dev, "Can't map memory\n");
+		retval = -ENOMEM;
+		goto err_release_mem;
+	}
+
+	tsc->dev = input_allocate_device();
+	if (!tsc->dev) {
+		dev_err(&pdev->dev, "failed allocating input device\n");
+		retval = -ENOMEM;
+		goto err_unmap;
+	}
+
+	tsc->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tsc->clk)) {
+		dev_err(&pdev->dev, "failed getting clock\n");
+		retval = -ENOENT;
+		goto err_dealloc_dev;
+	}
+
+	platform_set_drvdata(pdev, tsc);
+	input_set_drvdata(tsc->dev, tsc);
+
+	tsc->dev->name = MOD_NAME;
+	tsc->dev->phys = "lpc32xx/input0";
+	tsc->dev->id.bustype = BUS_HOST;
+	tsc->dev->id.vendor = 0x0001;
+	tsc->dev->id.product = 0x0002;
+	tsc->dev->id.version = 0x0100;
+	tsc->dev->dev.parent = &pdev->dev;
+	tsc->dev->open = lpc32xx_ts_open;
+	tsc->dev->close = lpc32xx_ts_close;
+
+	tsc->dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	tsc->dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_abs_params(tsc->dev, ABS_X, LPC32XX_TSC_MIN_XY_VAL,
+			     LPC32XX_TSC_MAX_XY_VAL, 0, 0);
+	input_set_abs_params(tsc->dev, ABS_Y, LPC32XX_TSC_MIN_XY_VAL,
+			     LPC32XX_TSC_MAX_XY_VAL, 0, 0);
+
+	retval = input_register_device(tsc->dev);
+	if (retval) {
+		dev_err(&pdev->dev, "failed registering input device\n");
+		goto err_stop_clock;
+	}
+
+	retval = request_irq(tsc->irq, lpc32xx_ts_interrupt,
+		IRQF_DISABLED, pdev->name, tsc);
+	if (retval < 0) {
+		dev_err(&pdev->dev, "failed requesting interrupt\n");
+		goto err_unreg_dev;
+	}
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	return 0;
+
+err_unreg_dev:
+	input_unregister_device(tsc->dev);
+	tsc->dev = NULL;
+err_stop_clock:
+	clk_put(tsc->clk);
+err_dealloc_dev:
+	input_free_device(tsc->dev);
+err_unmap:
+	iounmap(tsc->tsc_base);
+err_release_mem:
+	release_mem_region(res->start, size);
+err_free_mem:
+	kfree(tsc);
+
+	return retval;
+}
+
+static int __devexit lpc32xx_ts_remove(struct platform_device *pdev)
+{
+	struct lpc32xx_tsc *tsc = platform_get_drvdata(pdev);
+	struct resource *res;
+
+	device_init_wakeup(&pdev->dev, 0);
+	free_irq(tsc->irq, tsc);
+
+	input_unregister_device(tsc->dev);
+
+	clk_put(tsc->clk);
+
+	iounmap(tsc->tsc_base);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, resource_size(res));
+
+	kfree(tsc);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int lpc32xx_ts_suspend(struct device *dev)
+{
+	struct lpc32xx_tsc *tsc = dev_get_drvdata(dev);
+
+	/*
+	 * Suspend and resume can be called when the device hasn't been
+	 * enabled. If there are no users that have the device open, then
+	 * avoid calling the TSC stop and start functions as the TSC
+	 * isn't yet clocked.
+	 */
+	if (tsc->dev->users) {
+		if (device_may_wakeup(dev))
+			enable_irq_wake(tsc->irq);
+		else
+			lpc32xx_stop_tsc(tsc);
+	}
+
+	return 0;
+}
+
+static int lpc32xx_ts_resume(struct device *dev)
+{
+	struct lpc32xx_tsc *tsc = dev_get_drvdata(dev);
+
+	if (tsc->dev->users) {
+		if (device_may_wakeup(dev))
+			disable_irq_wake(tsc->irq);
+		else
+			lpc32xx_setup_tsc(tsc);
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops lpc32xx_ts_pm_ops = {
+	.suspend	= lpc32xx_ts_suspend,
+	.resume		= lpc32xx_ts_resume,
+};
+#define LPC32XX_TS_PM_OPS (&lpc32xx_ts_pm_ops)
+#else
+#define LPC32XX_TS_PM_OPS NULL
+#endif
+
+static struct platform_driver lpc32xx_ts_driver = {
+	.probe		= lpc32xx_ts_probe,
+	.remove		= __devexit_p(lpc32xx_ts_remove),
+	.driver		= {
+		.name	= MOD_NAME,
+		.owner	= THIS_MODULE,
+		.pm	= LPC32XX_TS_PM_OPS,
+	},
+};
+
+static int __init lpc32xx_ts_init(void)
+{
+	return platform_driver_register(&lpc32xx_ts_driver);
+}
+module_init(lpc32xx_ts_init);
+
+static void __exit lpc32xx_ts_exit(void)
+{
+	platform_driver_unregister(&lpc32xx_ts_driver);
+}
+module_exit(lpc32xx_ts_exit);
+
+MODULE_AUTHOR("Kevin Wells <kevin.wells@nxp.com");
+MODULE_DESCRIPTION("LPC32XX TSC Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:lpc32xx_ts");
-- 
1.7.1.1

