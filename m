From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Re: [PATCH] Add support for touch screen on W90P910 ARM platform
Date: Mon, 11 May 2009 11:58:59 +0800
Message-ID: <4A07A283.5080804@gmail.com>
References: <e68bb3470904270803q5e69a5f4n74ff58848f397f28@mail.gmail.com> <20090509195446.GA1617@dtor-d630.eng.vmware.com> <4A06ADD4.8010601@gmail.com> <200905101315.45564.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:54393 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbZEKD7G (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 May 2009 23:59:06 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1990755rvb.1
        for <linux-input@vger.kernel.org>; Sun, 10 May 2009 20:59:06 -0700 (PDT)
In-Reply-To: <200905101315.45564.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, mcuos.com@gmail.com

Dear Dmitry,

Modifying the magic constants to use #defines form,but I forget to re-patch it in previous patch,
so i re-submit this patch again.

about you doubt:

	if ((__raw_readl(w90p910_ts->ts_reg)&ADC_INT) &&
					w90p910_ts->state == CAN_READY) {
		w90p910_report_event(w90p910_ts);
		__raw_writel((__raw_readl(w90p910_ts->ts_reg)|
			ADC_WAITTRIG)&(~ADC_INT|~WT_INT_EN|~ADC_INT_EN),
							 w90p910_ts->ts_reg);
		mod_timer(&w90p910_ts->timer, jiffies +
						msecs_to_jiffies(40));
	}

When changing to wait trigger mode(ADC_WAITTRIG),I have to close wait trigger(WT_INT) and ADC interrupt(ADC_INT), and start the timer to execute timer function,if pen still keep down,then opening the ADC interrupt again,so that it can continue to get values of X and
Y,but if pen keep up,opening wait trigger interrupt and closing ADC interrupt,so that we can wait the next pen in down.  

MY PATCH text:

Add touchscreen drivers for w90p910 platform.

Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>

diff -Npur linux-2.6.29/drivers/input/touchscreen/Kconfig linux-2.6.30/drivers/input/touchscreen/Kconfig
--- linux-2.6.29/drivers/input/touchscreen/Kconfig	2009-05-01 12:28:54.000000000 +0800
+++ linux-2.6.30/drivers/input/touchscreen/Kconfig	2009-05-10 14:47:07.000000000 +0800
@@ -466,4 +466,11 @@ config TOUCHSCREEN_TSC2007
 	  To compile this driver as a module, choose M here: the
 	  module will be called tsc2007.
 
+config TOUCHSCREEN_W90X900
+	tristate "W90P910 touchscreen driver"
+	depends on CPU_W90P910
+	help
+	  To compile this driver as a module, choose M here: the
+	  module will be called w90p910-ts.
+
 endif
diff -Npur linux-2.6.29/drivers/input/touchscreen/Makefile linux-2.6.30/drivers/input/touchscreen/Makefile
--- linux-2.6.29/drivers/input/touchscreen/Makefile	2009-05-01 12:28:54.000000000 +0800
+++ linux-2.6.30/drivers/input/touchscreen/Makefile	2009-05-09 07:34:12.000000000 +0800
@@ -37,3 +37,4 @@ wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9712)	+
 wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9713)	+= wm9713.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
+obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
diff -Npur linux-2.6.29/drivers/input/touchscreen/w90p910_ts.c linux-2.6.30/drivers/input/touchscreen/w90p910_ts.c
--- linux-2.6.29/drivers/input/touchscreen/w90p910_ts.c	1970-01-01 08:00:00.000000000 +0800
+++ linux-2.6.30/drivers/input/touchscreen/w90p910_ts.c	2009-05-11 11:12:48.000000000 +0800
@@ -0,0 +1,272 @@
+/*
+ * Copyright (c) 2008 Nuvoton technology corporation.
+ *
+ * Wan ZongShun <mcuos.com@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation;version 2 of the License.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+
+#include <mach/hardware.h>
+
+/*adc controller bit define*/
+#define ADC_DELAY	0xf00
+#define ADC_DOWN	0x01
+#define ADC_TSC_Y	(0x01 << 8)
+#define ADC_TSC_X	(0x00 << 8)
+#define TSC_FOURWIRE	(~(0x03 << 1))
+#define ADC_CLK_EN	(0x01 << 28)/*adc clock*/
+#define ADC_READ_CON	(0x01 << 12)
+#define ADC_CONV	(0x01 << 13)
+#define ADC_SEMIAUTO	(0x01 << 14)
+#define ADC_WAITTRIG	(0x03 << 14)
+#define ADC_RST1	(0x01 << 16)
+#define ADC_RST0	(0x00 << 16)
+#define ADC_EN		(0x01 << 17)
+#define ADC_INT		(0x01 << 18)/*adc int status*/
+#define WT_INT		(0x01 << 20)/*wait trig int status*/
+#define ADC_INT_EN	(0x01 << 21)/*enable ADC_INT irq*/
+#define LVD_INT_EN	(0x01 << 22)
+#define WT_INT_EN	(0x01 << 23)/*enable WT_INT irq*/
+#define ADC_DIV		(0x04 << 1)/*div=6*/
+
+/*adc state define*/
+enum ts_state { NO_PRESS, CAN_READX, CAN_READY };
+
+struct w90p910drv_ts {
+	struct input_dev *input;
+	struct timer_list timer;
+	int irq_num;
+	int pendown;
+	int clocken;
+	void __iomem *ts_reg;
+	short x;
+	short y;
+	spinlock_t lock;
+	enum ts_state state;
+};
+
+static void w90p910_report_event(struct w90p910drv_ts *w90p910_ts)
+{
+	struct input_dev *dev = w90p910_ts->input;
+
+	w90p910_ts->x = __raw_readl(w90p910_ts->ts_reg+0x0c);
+	w90p910_ts->y = __raw_readl(w90p910_ts->ts_reg+0x10);
+
+	input_report_abs(dev, ABS_X, w90p910_ts->x);
+	input_report_abs(dev, ABS_Y, w90p910_ts->y);
+	input_report_key(dev, BTN_TOUCH, w90p910_ts->pendown);
+	input_sync(dev);
+}
+
+static void w90p910_ts_interrupt(struct w90p910drv_ts *w90p910_ts)
+{
+	if ((__raw_readl(w90p910_ts->ts_reg)&WT_INT) &&
+					w90p910_ts->state == NO_PRESS) {
+		w90p910_ts->pendown = 1;
+		__raw_writel(ADC_TSC_X, w90p910_ts->ts_reg+0x04);
+		__raw_writel((__raw_readl(w90p910_ts->ts_reg)|
+			ADC_SEMIAUTO|ADC_INT_EN|ADC_CONV)&(~WT_INT|~WT_INT_EN),
+							w90p910_ts->ts_reg);
+		w90p910_ts->state = CAN_READX;
+	} else {
+		if (__raw_readl(w90p910_ts->ts_reg+0x04)&ADC_DOWN) {
+			__raw_writel(ADC_TSC_X, w90p910_ts->ts_reg+0x04);
+
+			__raw_writel((__raw_readl(w90p910_ts->ts_reg)|
+				ADC_SEMIAUTO|ADC_INT_EN|ADC_CONV)&(~WT_INT_EN),
+							w90p910_ts->ts_reg);
+			w90p910_ts->pendown = 1;
+			w90p910_ts->state = CAN_READX;
+		} else {
+			__raw_writel((__raw_readl(w90p910_ts->ts_reg)|
+				ADC_WAITTRIG|WT_INT_EN)&(~ADC_INT_EN|
+					~WT_INT|~ADC_INT), w90p910_ts->ts_reg);
+			w90p910_ts->pendown = 0;
+			w90p910_ts->state = NO_PRESS;
+		}
+	}
+
+	if ((__raw_readl(w90p910_ts->ts_reg)&ADC_INT) &&
+					w90p910_ts->state == CAN_READX) {
+		__raw_writel(ADC_TSC_Y, w90p910_ts->ts_reg+0x04);
+		__raw_writel((__raw_readl(w90p910_ts->ts_reg)|ADC_SEMIAUTO|
+				ADC_INT_EN|ADC_CONV)&(~ADC_INT|~WT_INT_EN),
+							w90p910_ts->ts_reg);
+		w90p910_ts->state = CAN_READY;
+	}
+
+	if ((__raw_readl(w90p910_ts->ts_reg)&ADC_INT) &&
+					w90p910_ts->state == CAN_READY) {
+		w90p910_report_event(w90p910_ts);
+		__raw_writel((__raw_readl(w90p910_ts->ts_reg)|
+			ADC_WAITTRIG)&(~ADC_INT|~WT_INT_EN|~ADC_INT_EN),
+							 w90p910_ts->ts_reg);
+		mod_timer(&w90p910_ts->timer, jiffies +
+						msecs_to_jiffies(40));
+	}
+}
+
+static void w90p910_ts_timer(unsigned long data)
+{
+	struct w90p910drv_ts *w90p910_data = (struct w90p910drv_ts *) data;
+	unsigned long flags;
+
+	spin_lock_irqsave(&w90p910_data->lock, flags);
+
+	w90p910_ts_interrupt(w90p910_data);
+
+	spin_unlock_irqrestore(&w90p910_data->lock, flags);
+}
+
+static irqreturn_t ts_interrupt(int irq, void *dev_id)
+{
+	struct w90p910drv_ts *w90p910_data = dev_id;
+
+	w90p910_ts_interrupt(w90p910_data);
+	return IRQ_HANDLED;
+}
+
+static int __devinit w90x900ts_probe(struct platform_device *pdev)
+{
+	struct w90p910drv_ts *w90p910_ts;
+	struct input_dev *input_dev;
+	int err = -ENOMEM;
+	struct resource *res;
+
+	w90p910_ts = kzalloc(sizeof(struct w90p910drv_ts), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!w90p910_ts || !input_dev)
+		goto fail1;
+
+	platform_set_drvdata(pdev, w90p910_ts);
+
+	w90p910_ts->input = input_dev;
+	w90p910_ts->state = NO_PRESS;
+	w90p910_ts->clocken = (int)W90X900_VA_CLKPWR;
+	spin_lock_init(&w90p910_ts->lock);
+	setup_timer(&w90p910_ts->timer, w90p910_ts_timer,
+						(unsigned long)w90p910_ts);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		err = -ENXIO;
+		goto fail1;
+	}
+
+	if (!request_mem_region(res->start, res->end - res->start + 1,
+				pdev->name)) {
+		err = -EBUSY;
+		goto fail1;
+	}
+
+	w90p910_ts->ts_reg = ioremap(res->start, res->end - res->start + 1);
+	if (!w90p910_ts->ts_reg) {
+		err = -ENOMEM;
+		goto fail2;
+	}
+
+	/* enable the ADC clock */
+	__raw_writel(__raw_readl(w90p910_ts->clocken)|ADC_CLK_EN,
+						w90p910_ts->clocken);
+
+	input_dev->name = "W90P910 TouchScreen";
+	input_dev->phys = "w90p910ts/event0";
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->id.vendor 	= 0x0005;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+	input_dev->dev.parent = &pdev->dev;
+	input_dev->evbit[0] = BIT_MASK(EV_KEY)|
+				BIT_MASK(EV_ABS) | BIT_MASK(EV_SYN);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	input_set_abs_params(input_dev, ABS_X, 0, 0x400, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, 0x400, 0, 0);
+
+	w90p910_ts->irq_num = platform_get_irq(pdev, 0);
+	if (request_irq(w90p910_ts->irq_num, ts_interrupt, IRQF_DISABLED,
+						"w90p910ts", w90p910_ts)) {
+		err = -EBUSY;
+		goto fail3;
+	}
+
+	err = input_register_device(w90p910_ts->input);
+	if (err)
+		goto fail4;
+
+	__raw_writel(ADC_RST1, w90p910_ts->ts_reg);
+	msleep(1);
+	__raw_writel(ADC_RST0, w90p910_ts->ts_reg);
+	msleep(1);
+
+	/* set delay and screen type */
+	__raw_writel(__raw_readl(w90p910_ts->ts_reg+0x04) & TSC_FOURWIRE,
+						(w90p910_ts->ts_reg+0x04));
+	__raw_writel(ADC_DELAY, (w90p910_ts->ts_reg+0x08));
+	/* waitting for trigger mode */
+	__raw_writel((__raw_readl(w90p910_ts->ts_reg)|
+		ADC_WAITTRIG|ADC_DIV|ADC_EN|WT_INT_EN), w90p910_ts->ts_reg);
+	return 0;
+
+fail4:	free_irq(w90p910_ts->irq_num, w90p910_ts);
+fail3:	iounmap(w90p910_ts->ts_reg);
+fail2:	release_mem_region(res->start, res->end - res->start + 1);
+fail1:	input_free_device(input_dev);
+	kfree(w90p910_ts);
+	return err;
+}
+
+static int __devexit w90x900ts_remove(struct platform_device *pdev)
+{
+	struct w90p910drv_ts *w90p910_ts = platform_get_drvdata(pdev);
+	struct resource *res;
+
+	free_irq(w90p910_ts->irq_num, w90p910_ts);
+	del_timer_sync(&w90p910_ts->timer);
+	iounmap(w90p910_ts->ts_reg);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	release_mem_region(res->start, res->end - res->start + 1);
+
+	input_unregister_device(w90p910_ts->input);
+	kfree(w90p910_ts);
+
+	return 0;
+}
+
+static struct platform_driver w90x900ts_driver = {
+	.probe		= w90x900ts_probe,
+	.remove		= __devexit_p(w90x900ts_remove),
+	.driver		= {
+		.name	= "w90x900-ts",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init w90x900ts_init(void)
+{
+	return platform_driver_register(&w90x900ts_driver);
+}
+
+static void __exit w90x900ts_exit(void)
+{
+	platform_driver_unregister(&w90x900ts_driver);
+}
+
+module_init(w90x900ts_init);
+module_exit(w90x900ts_exit);
+
+MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
+MODULE_DESCRIPTION("w90p910 touch screen driver!");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:w90p910-ts");
