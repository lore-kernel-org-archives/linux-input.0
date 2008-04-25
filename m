From: Justin Waters <justin.waters@timesys.com>
Subject: [PATCH 1/2] atmel_tsadcc: Device driver for AT91SAM9RL Touchscreen
Date: Fri, 25 Apr 2008 14:56:37 -0400
Message-ID: <1209149798-20418-2-git-send-email-justin.waters@timesys.com>
References: <>
 <1209149798-20418-1-git-send-email-justin.waters@timesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1209149798-20418-1-git-send-email-justin.waters@timesys.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: dmitry.torokhov@gmail.com, linux@maxim.org.za
List-Id: linux-input@vger.kernel.org

The atmel tsadcc is a touchscreen/adc controller found on the AT91SAM9RL SoC.
This driver provides basic support for this controller for use as a
touchscreen.  Some future improvements include suspend/resume capabilities and
debugfs support.

Signed-off-by: Justin Waters <justin.waters@timesys.com>
---
 drivers/input/touchscreen/Kconfig        |   11 +
 drivers/input/touchscreen/Makefile       |    1 +
 drivers/input/touchscreen/atmel_tsadcc.c |  375 ++++++++++++++++++++++++++++++
 include/linux/atmel_tsadcc.h             |   89 +++++++
 4 files changed, 476 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/atmel_tsadcc.c
 create mode 100644 include/linux/atmel_tsadcc.h

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 90e8e92..6e76eff 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -170,6 +170,17 @@ config TOUCHSCREEN_TOUCHWIN
 	  To compile this driver as a module, choose M here: the
 	  module will be called touchwin.
 
+config TOUCHSCREEN_ATMEL_TSADCC
+	tristate "Atmel Touchscreen Interface"
+	help
+	  Say Y here if you have a 4-wire touchscreen connected to the
+          ADC Controller on your Atmel SoC (such as the AT91SAM9RL).
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called atmel_tsadcc.
+
 config TOUCHSCREEN_UCB1400
 	tristate "Philips UCB1400 touchscreen"
 	select AC97_BUS
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 35d4097..3302e27 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -18,4 +18,5 @@ obj-$(CONFIG_TOUCHSCREEN_USB_COMPOSITE)	+= usbtouchscreen.o
 obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
+obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
diff --git a/drivers/input/touchscreen/atmel_tsadcc.c b/drivers/input/touchscreen/atmel_tsadcc.c
new file mode 100644
index 0000000..b8a0984
--- /dev/null
+++ b/drivers/input/touchscreen/atmel_tsadcc.c
@@ -0,0 +1,375 @@
+/*
+ * Atmel TSADCC touchscreen sensor driver
+ *
+ * Copyright (c) 2008 TimeSys Corporation
+ * Copyright (c) 2008 Justin Waters
+ *
+ * Based on touchscreen code from Atmel Corporation
+ * and on the ads7846 driver by David Brownell.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+#include <linux/hwmon.h>
+#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/delay.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/slab.h>
+#include <linux/platform_device.h>
+#include <asm/irq.h>
+#include <linux/atmel_tsadcc.h>
+
+/*
+ * This code has been heavily tested on the Atmel at91sam9rl-ek 
+ */
+
+/* These values are dependent upon the performance of the ADC.  Ideally,
+ * These should be as close to the startup time and debounce time as
+ * possible (without going over).  These assume an optimally setup ADC as
+ * per the electrical characteristics of the AT91SAM9RL tsadcc module
+ */
+#define TS_POLL_DELAY   (1 * 1000000)   /* ns delay before the first sample */
+#define TS_POLL_PERIOD  (5 * 1000000)   /* ns delay between samples */
+
+/*--------------------------------------------------------------------------*/
+
+static inline void atmel_tsadcc_getevent(struct atmel_tsadcc *ts)
+{
+	unsigned int regbuf;
+
+	/*
+ 	 * Calculate the X Coordinates
+ 	 * x = (ATMEL_TSADCC_CDR3 * 1024) /  ATMEL_TSADCC_CDR2
+ 	 */
+	regbuf = atmel_tsadcc_readreg(ATMEL_TSADCC_CDR2);
+	if (regbuf)
+		regbuf = atmel_tsadcc_readreg(ATMEL_TSADCC_CDR3) * 1024 / regbuf;
+	ts->event.x = regbuf;
+
+	/*
+	 * Calculate the Y Coordinates
+	 * y = (ATMEL_TSADCC_CDR1 * 1024) / ATMEL_TSADCC_CDR0
+	 */
+	regbuf = atmel_tsadcc_readreg(ATMEL_TSADCC_CDR0);
+	if (regbuf)
+		regbuf = atmel_tsadcc_readreg(ATMEL_TSADCC_CDR1) * 1024 / regbuf;
+	ts->event.y = regbuf;
+
+	dev_dbg (&ts->pdev->dev, "X=%08X Y=%08X\n", ts->event.x, ts->event.y);
+
+	return;
+}
+
+/*--------------------------------------------------------------------------*/
+/*
+ * Touchscreen Interrupts
+ *
+ * The TSADCC Touchscreen provides a number of hardware interrupts.  For this
+ * driver, we enable the PENCNT and NOCNT interrupts, which signal an interrupt
+ * when the pen either makes or breaks contact with the screen.  When the pen
+ * is detected, we enable a timer that triggers the ADC periodically and polls
+ * the results.  The timer resets itself only as long as the pen is making
+ * contact.  Once the pen is lifted, the timer is no longer refreshed and the
+ * button and pressure is reduced to zero.
+ */
+static enum hrtimer_restart atmel_tsadcc_timer(struct hrtimer *handle)
+{
+	struct atmel_tsadcc *ts = container_of(handle, struct atmel_tsadcc, timer);
+	unsigned long flags;
+	unsigned int status;
+
+	spin_lock_irqsave(&ts->lock, flags);
+
+	/* Read the status register */
+	status = atmel_tsadcc_readreg(ATMEL_TSADCC_SR);
+
+	/* If the data is ready, read it! */
+	if(status & 0xF)
+	{
+		/* Read the LCDR Register to clear the DRDY bit */
+		atmel_tsadcc_readreg(ATMEL_TSADCC_LCDR);
+
+		dev_dbg (&ts->pdev->dev,"Status=0x%08X\n",status);
+
+		/* Pen remains down */
+		atmel_tsadcc_getevent(ts);
+
+		input_report_abs(ts->input, ABS_X, ts->event.x);
+		input_report_abs(ts->input, ABS_Y, ts->event.y);
+		input_report_abs(ts->input, ABS_PRESSURE, 7500);
+
+		input_sync(ts->input);
+
+		if(ts->pendown) {
+			/* Make ADC perform another conversion */
+			atmel_tsadcc_writereg(ATMEL_TSADCC_CR,2);
+	
+			hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
+				HRTIMER_MODE_REL);
+		}
+	}
+
+	spin_unlock_irq(&ts->lock);
+	return HRTIMER_NORESTART;
+}
+
+static irqreturn_t atmel_tsadcc_irq(int irq, void *handle)
+{
+	struct atmel_tsadcc *ts = handle;
+	unsigned long flags;
+	unsigned int status;
+
+	spin_lock_irqsave(&ts->lock, flags);
+
+	/* Read the status register */
+	status = atmel_tsadcc_readreg(ATMEL_TSADCC_SR);
+
+	/* Read the LCDR Register to clear the DRDY bit */
+	atmel_tsadcc_readreg(ATMEL_TSADCC_LCDR);
+
+	dev_dbg (&ts->pdev->dev,"Status=0x%08X\n",status);
+
+	if (ts->pendown) {
+		if (status & (1 << 21)) { /* Pen Up Event */
+			dev_dbg (&ts->pdev->dev, "Pen up\n");
+
+			ts->pendown = 0;
+
+			atmel_tsadcc_getevent(ts);
+
+			input_report_key(ts->input, BTN_TOUCH, 0);
+			input_report_abs(ts->input, ABS_PRESSURE, 0);
+			input_sync(ts->input);
+		}
+	} else if (status & (1 << 20)) { /* Pen first down */
+		dev_dbg (&ts->pdev->dev, "Pen down\n");
+
+		ts->pendown = 1;
+
+		atmel_tsadcc_getevent(ts);
+
+		input_report_key(ts->input, BTN_TOUCH, 1);
+		input_report_abs(ts->input, ABS_X, ts->event.x);
+		input_report_abs(ts->input, ABS_Y, ts->event.y);
+		input_report_abs(ts->input, ABS_PRESSURE, 1);
+
+		input_sync(ts->input);
+
+		/* Set up polling timer */
+		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_DELAY),
+				HRTIMER_MODE_REL);
+	} 
+
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+/*--------------------------------------------------------------------------*/
+/* TODO: Create power save features */
+static int atmel_tsadcc_suspend(struct platform_device *pdev, pm_message_t message)
+{
+	return 0;
+}
+
+static int atmel_tsadcc_resume(struct platform_device *pdev)
+{
+	return 0;
+}
+
+/*--------------------------------------------------------------------------*/
+
+static int __devinit atmel_tsadcc_probe(struct platform_device *pdev)
+{
+	struct atmel_tsadcc		*ts;
+	struct input_dev	*input_dev;
+	struct atmel_tsadcc_platform_data    *pdata = pdev->dev.platform_data;
+	int			err;
+	struct resource 	*res;
+	unsigned int		regbuf;
+
+	dev_dbg(&pdev->dev,"Begin probe\n");
+
+	/* Check Resources */
+	if (pdev->num_resources != 2) {
+		dev_err(&pdev->dev, "resources improperly configured\n");
+		return -ENODEV;
+	}
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data\n");
+		return -ENODEV;
+	}
+
+	/* Allocate memory for device */
+	ts = kzalloc(sizeof(struct atmel_tsadcc), GFP_KERNEL);
+	input_dev = input_allocate_device();
+	if (!ts || !input_dev) {
+		err = -ENOMEM;
+		goto err_free_mem;
+	}
+	platform_set_drvdata(pdev, ts);
+
+	/* Set up polling timer */
+	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	ts->timer.function = atmel_tsadcc_timer;
+
+	/* Touchscreen Information */
+        ts->pdev = pdev;
+        ts->input = input_dev;
+	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", pdev->dev.bus_id);
+	ts->reg_name = "Atmel TSADCC Regs";
+	ts->pendown = 0;
+
+	/* Input Device Information */
+	input_dev->name = "Atmel Touchscreen ADC Controller";
+	input_dev->phys = ts->phys;
+	input_dev->dev.parent = &pdev->dev;
+
+	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	input_set_abs_params(input_dev, ABS_X, 0, 0x3FF, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 0, 0x3FF, 0, 0);
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0, 15000, 0, 0);
+
+	/* Remap Register Memory */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ts->reg_start = res->start;
+	ts->reg_length = res->end - res->start +1;
+
+	if (!request_mem_region(ts->reg_start, ts->reg_length, ts->reg_name)) {
+		dev_err(&pdev->dev, "resources unavailable\n");
+		err = -EBUSY;
+		goto err_free_mem;
+	}
+
+	ts->reg = ioremap(ts->reg_start, ts->reg_length);
+	if (!ts->reg){
+		dev_err(&pdev->dev, "unable to remap register memory\n");
+		err = -ENOMEM;
+		goto err_release_mem;
+	}
+
+	/* Setup Clock */
+	ts->tsc_clk = clk_get(&pdev->dev,"tsc_clk");
+	if (IS_ERR(ts->tsc_clk)) {
+		dev_err(&pdev->dev, "unable to get clock\n");
+		err = PTR_ERR(ts->tsc_clk);
+		goto err_iounmap;
+        }
+	clk_enable(ts->tsc_clk);
+
+	regbuf = clk_get_rate(ts->tsc_clk);
+	dev_dbg (&pdev->dev,"Master clock is set at: %d Hz\n",regbuf);
+
+	/* Setup IRQ */
+	ts->irq = platform_get_irq(pdev, 0);
+	if (ts->irq < 0) {
+		dev_err(&pdev->dev, "unable to get IRQ\n");
+		err = -EBUSY;
+		goto err_clk_put;
+        }
+
+	/* Fill in initial Register Data */
+	ATMEL_TSADCC_RESET;
+	regbuf = (0x01 & 0x3) |				/* TSAMOD	*/
+		((0x0 & 0x1) << 5) |			/* SLEEP	*/
+		((0x1 & 0x1) << 6) |			/* PENDET	*/
+		((pdata->prescaler & 0x3F) << 8) |	/* PRESCAL	*/
+		((pdata->startup & 0x7F) << 16) |	/* STARTUP	*/
+		((pdata->debounce & 0x0F) << 28);	/* PENDBC	*/
+	atmel_tsadcc_writereg(ATMEL_TSADCC_MR,regbuf);
+
+	regbuf = (0x4 & 0x7) |				/* TRGMOD	*/
+		((0xFFFF & 0xFFFF) << 16);		/* TRGPER	*/
+	atmel_tsadcc_writereg(ATMEL_TSADCC_TRGR,regbuf);
+
+	regbuf = ((pdata->tsshtim & 0xF) << 24);	/* TSSHTIM	*/
+	atmel_tsadcc_writereg(ATMEL_TSADCC_TSR,regbuf);
+
+	regbuf = atmel_tsadcc_readreg(ATMEL_TSADCC_IMR);
+	dev_dbg (&pdev->dev, "Initial IMR = %X\n", regbuf);
+
+	/* Register and enable IRQ */
+	if (request_irq(ts->irq, atmel_tsadcc_irq, IRQF_TRIGGER_LOW,
+		pdev->dev.driver->name, ts)) {
+		dev_dbg(&pdev->dev, "IRQ %d busy!\n", ts->irq);
+		err = -EBUSY;
+		goto err_iounmap;
+        }
+	regbuf =	((0x1 & 0x1) << 20) |		/* PENCNT	*/
+			((0x1 & 0x1) << 21);		/* NOCNT	*/
+	atmel_tsadcc_writereg(ATMEL_TSADCC_IER,regbuf);
+
+	regbuf = atmel_tsadcc_readreg(ATMEL_TSADCC_IMR);
+	dev_dbg (&pdev->dev, "Post-Enable IMR = %X\n", regbuf);
+
+	/* Register Input Device */
+	err = input_register_device(input_dev);
+	if (err)
+		goto err_free_irq;
+
+	return 0;
+
+ err_free_irq:
+	free_irq(ts->irq, ts);
+ err_clk_put:
+	clk_put(ts->tsc_clk);
+ err_iounmap:
+	iounmap(ts->reg);
+ err_release_mem:
+	release_mem_region(ts->reg_start, ts->reg_length);
+ err_free_mem:
+	dev_dbg(&pdev->dev, "Error occurred: Freeing Memory!\n");
+	input_free_device(input_dev);
+	kfree(ts);
+	return err;
+}
+
+static int __devexit atmel_tsadcc_remove(struct platform_device *pdev)
+{
+	struct atmel_tsadcc *ts = dev_get_drvdata(&pdev->dev);
+
+	input_unregister_device(ts->input);
+
+	free_irq(ts->irq, ts);
+
+	/* Free Memory */
+	iounmap(ts->reg);
+	release_mem_region(ts->reg_start, ts->reg_length);
+	kfree(ts);
+
+	dev_dbg(&pdev->dev, "unregistered touchscreen\n");
+
+	return 0;
+}
+
+static struct platform_driver atmel_tsadcc_driver = {
+	.driver = {
+		.name	= "atmel_tsadcc",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= atmel_tsadcc_probe,
+	.remove		= __devexit_p(atmel_tsadcc_remove),
+	.suspend	= atmel_tsadcc_suspend,
+	.resume		= atmel_tsadcc_resume,
+};
+
+static int __init atmel_tsadcc_init(void)
+{
+	return platform_driver_register(&atmel_tsadcc_driver);
+}
+module_init(atmel_tsadcc_init);
+
+static void __exit atmel_tsadcc_exit(void)
+{
+	platform_driver_unregister(&atmel_tsadcc_driver);
+}
+module_exit(atmel_tsadcc_exit);
+
+MODULE_DESCRIPTION("Atmel TSADCC Touchscreen Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/atmel_tsadcc.h b/include/linux/atmel_tsadcc.h
new file mode 100644
index 0000000..3199622
--- /dev/null
+++ b/include/linux/atmel_tsadcc.h
@@ -0,0 +1,89 @@
+/*
+ * Atmel TSADCC touchscreen sensor driver
+ *
+ * Copyright (c) 2008 TimeSys Corporation
+ * Copyright (c) 2008 Justin Waters
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#ifndef _ATMEL_TSADCC_H
+#define _ATMEL_TSADCC_H
+
+/*--------------------------------------------------------------------------
+ * Register Locations 
+ *
+ * From AT91SAM9RL64 User Guide, 15-Jan-08, Table 43-2
+ *--------------------------------------------------------------------------*/
+#define ATMEL_TSADCC_CR		0x00	/* Control (wo) 		*/
+#define ATMEL_TSADCC_MR		0x04	/* Mode (rw)			*/
+#define ATMEL_TSADCC_TRGR	0x08	/* Trigger (rw)			*/
+#define ATMEL_TSADCC_TSR	0x0C	/* Touch Screen (rw)		*/
+#define ATMEL_TSADCC_CHER	0x10	/* Channel Enable (wo)		*/
+#define ATMEL_TSADCC_CHDR	0x14	/* Channel Disable (wo)		*/
+#define ATMEL_TSADCC_CHSR	0x18	/* Channel Status (ro)		*/
+#define ATMEL_TSADCC_SR		0x1C	/* Status (ro)			*/
+#define ATMEL_TSADCC_LCDR	0x20	/* Last Converted Data (ro)	*/
+#define ATMEL_TSADCC_IER	0x24	/* Interrupt Enable (wo)	*/
+#define ATMEL_TSADCC_IDR	0x28	/* Interrupt Disable (wo)	*/
+#define ATMEL_TSADCC_IMR	0x2C	/* Interrupt Mask (ro)		*/
+#define ATMEL_TSADCC_CDR0	0x30	/* Channel Data 0 (ro)		*/
+#define ATMEL_TSADCC_CDR1	0x34	/* Channel Data 1 (ro)		*/
+#define ATMEL_TSADCC_CDR2	0x38	/* Channel Data 2 (ro)		*/
+#define ATMEL_TSADCC_CDR3	0x3C	/* Channel Data 3 (ro)		*/
+#define ATMEL_TSADCC_CDR4	0x40	/* Channel Data 4 (ro)		*/
+#define ATMEL_TSADCC_CDR5	0x44	/* Channel Data 5 (ro)		*/
+
+/*--------------------------------------------------------------------------
+ * I/O Macros
+ *--------------------------------------------------------------------------*/
+#define atmel_tsadcc_readreg(a)	ioread32(ts->reg + a)
+#define atmel_tsadcc_writereg(a,v)	iowrite32(v,ts->reg + a)
+
+
+/*--------------------------------------------------------------------------
+ * Miscellaneous Macros
+ *--------------------------------------------------------------------------*/
+#define ATMEL_TSADCC_RESET	atmel_tsadcc_writereg(ATMEL_TSADCC_CR,0x00000001)
+
+/*--------------------------------------------------------------------------
+ * Touchscreen Structs
+ *--------------------------------------------------------------------------*/
+
+struct ts_event {
+	unsigned int x;
+	unsigned int y;
+};
+
+struct atmel_tsadcc_platform_data {
+	unsigned int	prescaler:6;	/* ADC Clock Prescaler */
+	unsigned int	debounce:4;	/* Pen Debounce Period */
+	unsigned int	tsshtim:4;	/* Touchscreen Sample and Hold Time */
+	unsigned int	startup:7;	/* Startup time	*/
+};
+
+struct atmel_tsadcc {
+	struct input_dev	*input;
+	char			phys[32];
+	struct platform_device	*pdev;
+	int			irq;
+
+	void __iomem 		*reg;
+	const char		*reg_name;	
+	unsigned long		reg_start;
+	unsigned long		reg_length;
+
+	spinlock_t              lock;
+
+	struct clk		*tsc_clk;
+	struct hrtimer          timer;
+	struct ts_event		event;
+
+	unsigned int		pendown;
+};
+
+/*--------------------------------------------------------------------------*/
+
+#endif /* _ATMEL_TSADCC_H */
-- 
1.5.4.3


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
