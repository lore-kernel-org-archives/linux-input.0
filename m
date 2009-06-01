From: "Chris Verges" <chrisv@cyberswitching.com>
Subject: [PATCH 1/1] linux-2.6.29.3-tsc2008-v0.2.patch
Date: Mon, 1 Jun 2009 13:03:59 -0700
Message-ID: <68FBE0F3CE97264395875AC1C468F22C12E119@mail03.cyberswitching.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from p01c12o141.mxlogic.net ([208.65.145.64]:35674 "EHLO
	p01c12o141.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbZFAUEP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Jun 2009 16:04:15 -0400
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi all,

Here's an updated version of the Texas Instruments TSC2008 driver.  Many
thanks to Dmitry Torokhov for providing feedback!

This code successfully compiles both as built-in and as a module.  If
anyone has a hardware platform that can be used for testing, I welcome
any feedback.  Our hardware should arrive in early July, so I'll update
(v0.3?) based on testing after that.

Thanks,
Chris


linux-2.6.29.3-tsc2008-v0.2patch:
-------------------------------------------------------------------

Signed-off-by: Chris Verges <chrisv@cyberswitching.com>

Index: include/linux/spi/tsc2008.h
===================================================================
--- linux-2.6.29.3-orig/include/linux/spi/tsc2008.h	(revision 0)
+++ linux-2.6.29.3/include/linux/spi/tsc2008.h	(revision 32)
@@ -0,0 +1,22 @@
+#ifndef __LINUX_SPI_TSC2008_H
+#define __LINUX_SPI_TSC2008_H
+
+/* linux/spi/tsc2008.h */
+
+#define TSC2008_ADC_8BITS		(0x01)
+#define TSC2008_ADC_12BITS		(0x02)
+
+struct tsc2008_platform_data {
+	u16	model;				/* 2008. */
+	u16	x_plate_ohms;
+	u16	adc_bits;			/* TSC2008_ADC_12BITS
(default)
+						   or TSC2008_ADC_8BITS
*/
+	u16	irq;				/* GPIO to be used for
IRQ */
+
+	u8	pull_up;			/* 50 (default) or 90
ohms */
+	u8	mav;				/* 0 (enable) or 1
(bypass) */
+
+	int	(*get_pendown_state)(void);
+};
+
+#endif
Index: drivers/input/touchscreen/Kconfig
===================================================================
--- linux-2.6.29.3-orig/drivers/input/touchscreen/Kconfig
(revision 11)
+++ linux-2.6.29.3/drivers/input/touchscreen/Kconfig	(revision 32)
@@ -408,4 +408,17 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called tsc2007.
 
+config TOUCHSCREEN_TSC2008
+	tristate "TSC2008 based touchscreens"
+	depends on SPI_MASTER
+	help
+	  Say Y here if you have a touchscreen interface using the
+	  TSC2008 controller, and your board-specific setup code
+	  includes that in its table of SPI devices.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called tsc2008.
+
 endif
Index: drivers/input/touchscreen/tsc2008.c
===================================================================
--- linux-2.6.29.3-orig/drivers/input/touchscreen/tsc2008.c
(revision 0)
+++ linux-2.6.29.3/drivers/input/touchscreen/tsc2008.c	(revision 32)
@@ -0,0 +1,559 @@
+/*
+ * drivers/input/touchscreen/tsc2008.c
+ *
+ * Copyright (c) 2009 Cyber Switching, Inc.
+ * 	Chris Verges <chrisv@cyberswitching.com>
+ *
+ * Using code from:
+ *  - tsc2008_core.c, tsc2008.h, tsc2008_platform.c
+ *      Copyright (c) 2008 MindTree Limited
+ *  - tsc2007.c
+ *      Copyright (c) 2008 MtekVision Co., Ltd.
+ *  - ads7846.c
+ *	Copyright (c) 2005 David Brownell
+ *	Copyright (c) 2006 Nokia Corporation
+ *  - corgi_ts.c
+ *	Copyright (C) 2004-2005 Richard Purdie
+ *  - omap_ts.[hc], ads7846.h, ts_osk.c
+ *	Copyright (C) 2002 MontaVista Software
+ *	Copyright (C) 2004 Texas Instruments
+ *	Copyright (C) 2005 Dirk Behme
+ *
+ *  This program is free software; you can redistribute it and/or
modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/hrtimer.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/tsc2008.h>
+
+
+#define DRV_VERSION "0.2"
+
+#define TS_POLL_DELAY	(10 * 1000)	/* ns delay before the first
sample */
+#define TS_POLL_PERIOD	(5 * 1000)	/* ns delay between samples */
+
+#define TSC2008_MEASURE_Y		(0x1 << 4)
+#define TSC2008_SETUP			(0x2 << 4)
+#define TSC2008_MEASURE_Z1		(0x3 << 4)
+#define TSC2008_MEASURE_Z2		(0x4 << 4)
+#define TSC2008_MEASURE_X		(0x5 << 4)
+#define TSC2008_MEASURE_AUX		(0x6 << 4)
+#define TSC2008_MEASURE_TEMP2		(0x7 << 4)
+#define TSC2008_START			(0x8 << 4)
+
+#define TSC2008_12BIT			(0x0 << 3)
+#define TSC2008_8BIT			(0x1 << 3)
+
+#define TSC2008_REF_DIFF		(0x0 << 2)
+#define TSC2008_REF_SINGLE		(0x1 << 2)
+
+#define TSC2008_POWER_OFF_IRQ_EN	(0x0 << 0)
+#define TSC2008_ADC_ON_IRQ_DIS0		(0x1 << 0)
+#define TSC2008_ADC_OFF_IRQ_EN		(0x2 << 0)
+#define TSC2008_ADC_ON_IRQ_DIS1		(0x3 << 0)
+
+#define TSC2008_RESET			(0x1)
+
+#define TSC2008_PENIRQ_50_OHM		(0x0 << 3)
+#define TSC2008_PENIRQ_90_OHM		(0x1 << 3)
+
+#define TSC2008_MAV_ENABLE		(0x0 << 2)
+#define TSC2008_MAV_BYPASS		(0x1 << 2)
+
+#define TSC2008_SOFTWARE_RESET		\
+		(TSC2008_START | TSC2008_SETUP | TSC2008_RESET)
+
+static struct spi_driver tsc2008_driver;
+
+struct ts_event {
+	u16	x;
+	u16	y;
+	u16	z1, z2;
+};
+
+struct tsc2008 {
+	struct input_dev	*input;
+	char			phys[32];
+
+	struct spi_device	*spi;
+
+	u16			model;
+	u16			x_plate_ohms;
+	u8			adc_bits;
+	int			irq;
+
+	spinlock_t		lock;		/* protects timer, msg,
*/
+						/* xfer, and msg_idx
*/
+	unsigned		pendown;
+	struct ts_event		tc;
+
+	struct timer_list	timer;
+	struct spi_message	msg[6];
+	struct spi_transfer	xfer[12];
+
+	u8			read_x;
+	u8			read_y;
+	u8			read_z1;
+	u8			read_z2;
+
+	u16			x_pos;
+	u16			y_pos;
+	u16			z1_val;
+	u16			z2_val;
+
+	u8			msg_idx;
+
+	int			(*get_pendown_state)(void);
+};
+
+static void tsc2008_report(void *data)
+{
+	struct tsc2008		*ts = (struct tsc2008 *)data;
+	struct input_dev	*input = ts->input;
+	u16			tmp;
+	u16			pressure;
+
+	/* The X and Y coordinates read from the TSC2008 need to be
swapped
+	 * to work with the X window system.
+	 */
+	switch (ts->adc_bits) {
+	case TSC2008_ADC_12BITS:
+		/* TSC2008 transfers in big endian format (MSB to LSB)
as a
+		 * 12-bit number.  Need to convert endianness and
truncate.
+		 */
+		tmp = ts->x_pos;
+		ts->x_pos  = ((be16_to_cpu(ts->y_pos)  << 1) >> 4) &
0x0FFF;
+		ts->y_pos  = ((be16_to_cpu(tmp)        << 1) >> 4) &
0x0FFF;
+		ts->z1_val = ((be16_to_cpu(ts->z1_val) << 1) >> 4) &
0x0FFF;
+		ts->z2_val = ((be16_to_cpu(ts->z2_val) << 1) >> 4) &
0x0FFF;
+		break;
+	case TSC2008_ADC_8BITS:
+		tmp = ts->x_pos;
+		ts->x_pos  = (ts->y_pos  << 1) & 0x00FF;
+		ts->y_pos  = (tmp        << 1) & 0x00FF;
+		ts->z1_val = (ts->z1_val << 1) & 0x00FF;
+		ts->z2_val = (ts->z2_val << 1) & 0x00FF;
+		break;
+	}
+
+	/* Calculate the pressure according to Equation #1 on page 12
+	 * of the TSC2008 datasheet.
+	 */
+	pressure  = ts->z2_val / ts->z1_val;
+	pressure -= 1;
+	pressure *= ts->y_pos;
+	pressure *= ts->x_plate_ohms;
+	pressure /= 4096;
+
+	/* Report the values to the input subsystem */
+	input_report_abs(input, ABS_X, ts->x_pos);
+	input_report_abs(input, ABS_Y, ts->y_pos);
+	input_report_abs(input, ABS_PRESSURE, pressure);
+	input_report_abs(input, BTN_TOUCH, 1);
+
+	/* Reset the SPI message queue */
+	ts->msg_idx = 0;
+
+	/* Check for prolonged touches (i.e. drags and drawings) */
+	if (ts->get_pendown_state())
+		mod_timer(&ts->timer, jiffies + 2);
+	else {
+		input_report_abs(input, ABS_PRESSURE, 0);
+		input_report_abs(input, BTN_TOUCH, 0);
+		input_sync(input);
+		enable_irq(ts->irq);
+	}
+}
+
+static void tsc2008_spi_again_submit(void *data)
+{
+	struct tsc2008 *ts = data;
+	struct spi_message *m;
+	struct spi_transfer *t;
+
+	spin_lock_irqsave(&ts->lock);
+
+	m = &ts->msg[ts->msg_idx];
+	t = list_entry(m->transfers.prev, struct spi_transfer,
transfer_list);
+	ts->msg_idx++;
+
+	m = &ts->msg[ts->msg_idx];
+	spi_async(ts->spi, m);
+
+	spin_unlock_irqrestore(&ts->lock);
+}
+
+static void tsc2008_timer(unsigned long arg)
+{
+	struct tsc2008 *ts = (struct tsc2008 *)arg;
+	int stat;
+
+	spin_lock_irqsave(&ts->lock);
+
+	if (unlikely(!ts->get_pendown_state() && ts->pendown)) {
+		struct input_dev *input = ts->input;
+
+		dev_dbg(&ts->spi->dev, "pen is up\n");
+
+		input_report_key(input, BTN_TOUCH, 0);
+		input_report_abs(input, ABS_PRESSURE, 0);
+		input_sync(input);
+
+		ts->pendown = 0;
+		enable_irq(ts->irq);
+	} else {
+		/* pen is still down, continue with the measurement */
+		dev_dbg(&ts->spi->dev, "pen is still down\n");
+
+		ts->msg_idx = 0;
+		stat = spi_async(ts->spi, &ts->msg[0]);
+		if (stat)
+			dev_err(&ts->spi->dev, "spi_async----> %d\n",
stat);
+	}
+
+	spin_unlock_irqrestore(&ts->lock);
+}
+
+static irqreturn_t tsc2008_handle_penirq(int irq, void *handle)
+{
+	struct tsc2008 *ts = handle;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->lock, flags);
+
+	if (likely(ts->get_pendown_state())) {
+		disable_irq(ts->irq);
+		mod_timer(&ts->timer, jiffies + 3);
+	}
+
+	spin_unlock_irqrestore(&ts->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static void tsc2008_spi_setup(struct tsc2008 *ts)
+{
+	struct spi_message *m;
+	struct spi_transfer *t;
+	u16 rx_len;
+	u16 tx_delay;
+
+	switch (ts->adc_bits) {
+	case TSC2008_ADC_8BITS:
+		tx_delay = 50;
+		rx_len = 1;
+		break;
+	case TSC2008_ADC_12BITS:
+	default:
+		tx_delay = 100;
+		rx_len = 2;
+		break;
+	}
+
+	/* Setup the SPI message for reading X */
+	{
+		m = &ts->msg[0];
+		t = &ts->xfer[0];
+
+		/* Transmit the command */
+		spi_message_init(m);
+		memset(t, 0, sizeof(*t));
+		t->tx_buf = &ts->read_x;
+		t->len = 1;
+		t->delay_usecs = tx_delay;
+		spi_message_add_tail(t, m);
+
+		/* Receive the results */
+		t++;
+		memset(t, 0, sizeof(*t));
+		t->rx_buf = &ts->x_pos;
+		t->len = rx_len;
+		spi_message_add_tail(t, m);
+
+		m->complete = tsc2008_spi_again_submit;
+		m->context = ts;
+	}
+
+	/* Setup the SPI message for reading Y */
+	{
+		m++;
+		t++;
+
+		/* Transmit the command */
+		spi_message_init(m);
+		memset(t, 0, sizeof(*t));
+		t->tx_buf = &ts->read_y;
+		t->len = 1;
+		t->delay_usecs = tx_delay;
+		spi_message_add_tail(t, m);
+
+		/* Receive the results */
+		t++;
+		memset(t, 0, sizeof(*t));
+		t->rx_buf = &ts->y_pos;
+		t->len = rx_len;
+		spi_message_add_tail(t, m);
+
+		m->complete = tsc2008_spi_again_submit;
+		m->context = ts;
+	}
+
+	/* Setup the SPI message for reading Z1 */
+	{
+		m++;
+		t++;
+
+		/* Transmit the command */
+		spi_message_init(m);
+		memset(t, 0, sizeof(*t));
+		t->tx_buf = &ts->read_z1;
+		t->len = 1;
+		t->delay_usecs = tx_delay;
+		spi_message_add_tail(t, m);
+
+		/* Receive the results */
+		t++;
+		memset(t, 0, sizeof(*t));
+		t->rx_buf = &ts->z1_val;
+		t->len = rx_len;
+		spi_message_add_tail(t, m);
+
+		m->complete = tsc2008_spi_again_submit;
+		m->context = ts;
+	}
+
+	/* Setup the SPI message for reading Z2 */
+	{
+		m++;
+		t++;
+
+		/* Transmit the command */
+		spi_message_init(m);
+		memset(t, 0, sizeof(*t));
+		t->tx_buf = &ts->read_z2;
+		t->len = 1;
+		t->delay_usecs = tx_delay;
+		spi_message_add_tail(t, m);
+
+		/* Receive the results */
+		t++;
+		memset(t, 0, sizeof(*t));
+		t->rx_buf = &ts->z2_val;
+		t->len = rx_len;
+		spi_message_add_tail(t, m);
+
+		m->complete = tsc2008_report;
+		m->context = ts;
+	}
+}
+
+static int __devinit tsc2008_probe(struct spi_device *spi)
+{
+	struct tsc2008			*ts;
+	struct tsc2008_platform_data	*pdata;
+	struct input_dev		*input;
+	int				err;
+	u8				tx_buf;
+
+	pdata = spi->dev.platform_data;
+	if (!pdata) {
+		dev_err(&spi->dev, "no platform data?!\n");
+		return -ENODEV;
+	}
+
+	/* don't exceed the max specified sample rate */
+	if (spi->max_speed_hz > 25000000) {
+		dev_dbg(&spi->dev, "f(sample) %d KHz?\n",
+				(spi->max_speed_hz / 1000));
+		return -EINVAL;
+	}
+
+	/* While the TSC2008 may like 12-bit words, most SPI controller
+	 * drivers may not.  Stick with something portable.
+	 */
+	spi->bits_per_word = 8;
+	spi->mode = SPI_MODE_0;
+	err = spi_setup(spi);
+	if (err < 0)
+		return err;
+
+	/* Allocate the memory required for this driver */
+	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!ts || !input) {
+		err = -ENOMEM;
+		goto err_free_mem;
+	}
+
+	/* Initialize the TSC2008 driver data structure */
+	dev_set_drvdata(&spi->dev, ts);
+
+	init_timer(&ts->timer);
+	spin_lock_init(&ts->lock);
+
+	ts->spi			= spi;
+	ts->input		= input;
+	ts->timer.function	= tsc2008_timer;
+	ts->timer.data		= (unsigned long)ts;
+	ts->model		= pdata->model ? : 2008;
+	ts->x_plate_ohms	= pdata->x_plate_ohms ? : 400;
+	ts->adc_bits		= pdata->adc_bits ? :
TSC2008_ADC_12BITS;
+	ts->irq			= pdata->irq;
+	ts->get_pendown_state	= pdata->get_pendown_state;
+
+	snprintf(ts->phys, sizeof(ts->phys),
+		 "%s/input0", dev_name(&spi->dev));
+
+	/* Initialize the input driver */
+	input->name = "TSC2008 TouchScreen";
+	input->phys = ts->phys;
+	input->dev.parent = &spi->dev;
+	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
+	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+
+	/* Set the resolution mode that will be used -- 8 bits or 12
bits */
+	switch (ts->adc_bits) {
+	default:
+		/* If nothing valid is specified, assume 12 bits */
+		ts->adc_bits = TSC2008_ADC_12BITS;
+	case TSC2008_ADC_12BITS:
+		ts->read_x  = TSC2008_START | TSC2008_MEASURE_X
+				| TSC2008_12BIT | TSC2008_REF_DIFF
+				| TSC2008_ADC_ON_IRQ_DIS0;
+		ts->read_y  = TSC2008_START | TSC2008_MEASURE_Y
+				| TSC2008_12BIT | TSC2008_REF_DIFF
+			    | TSC2008_ADC_ON_IRQ_DIS0;
+		ts->read_z1 = TSC2008_START | TSC2008_MEASURE_Z1
+				| TSC2008_12BIT | TSC2008_REF_DIFF
+			    | TSC2008_ADC_ON_IRQ_DIS0;
+		ts->read_z2 = TSC2008_START | TSC2008_MEASURE_Z2
+				| TSC2008_12BIT | TSC2008_REF_DIFF
+			    | TSC2008_ADC_ON_IRQ_DIS0;
+
+		input_set_abs_params(input, ABS_X, 0, 4096, 0, 0);
+		input_set_abs_params(input, ABS_Y, 0, 4096, 0, 0);
+		input_set_abs_params(input, ABS_PRESSURE, 0, 4096, 0,
0);
+		break;
+	case TSC2008_ADC_8BITS:
+		ts->read_x  = TSC2008_START | TSC2008_MEASURE_X
+				| TSC2008_8BIT | TSC2008_REF_DIFF
+			    | TSC2008_ADC_ON_IRQ_DIS0;
+		ts->read_y  = TSC2008_START | TSC2008_MEASURE_Y
+				| TSC2008_8BIT | TSC2008_REF_DIFF
+			    | TSC2008_ADC_ON_IRQ_DIS0;
+		ts->read_z1 = TSC2008_START | TSC2008_MEASURE_Z1
+				| TSC2008_8BIT | TSC2008_REF_DIFF
+			    | TSC2008_ADC_ON_IRQ_DIS0;
+		ts->read_z2 = TSC2008_START | TSC2008_MEASURE_Z2
+				| TSC2008_8BIT | TSC2008_REF_DIFF
+			    | TSC2008_ADC_ON_IRQ_DIS0;
+
+		input_set_abs_params(input, ABS_X, 0, 256, 0, 0);
+		input_set_abs_params(input, ABS_Y, 0, 256, 0, 0);
+		input_set_abs_params(input, ABS_PRESSURE, 0, 256, 0, 0);
+		break;
+	}
+
+	/* Register the IRQ */
+	err = request_irq(ts->irq, tsc2008_handle_penirq,
IRQF_TRIGGER_FALLING,
+			spi->dev.driver->name, ts);
+	if (err < 0) {
+		dev_err(&spi->dev, "irq %d busy?\n", spi->irq);
+		goto err_free_mem;
+	}
+
+	/* Register the input driver */
+	err = input_register_device(input);
+	if (err)
+		goto err_free_irq;
+
+	/* Reset the controller */
+	tx_buf = TSC2008_SOFTWARE_RESET;
+	err = spi_write(spi, &tx_buf, 1);
+	if (err < 0)
+		goto err_free_irq;
+	udelay(200);
+
+	/* Initialize the controller */
+	tx_buf = TSC2008_START | TSC2008_SETUP;
+	switch (pdata->pull_up) {
+	case 50:
+		tx_buf |= TSC2008_PENIRQ_50_OHM;
+		break;
+	case 90:
+		tx_buf |= TSC2008_PENIRQ_90_OHM;
+		break;
+	}
+	switch (pdata->mav) {
+	case 0:
+		tx_buf |= TSC2008_MAV_ENABLE;
+		break;
+	case 1:
+		tx_buf |= TSC2008_MAV_BYPASS;
+		break;
+	}
+	err = spi_write(spi, &tx_buf, 1);
+	if (err < 0)
+		goto err_free_irq;
+	udelay(200);
+
+	/* Create the SPI message queue */
+	tsc2008_spi_setup(ts);
+
+	dev_info(&spi->dev, "touchscreen registered with irq (%d)\n",
spi->irq);
+
+	return 0;
+
+ err_free_irq:
+	free_irq(spi->irq, ts);
+ err_free_mem:
+	input_free_device(input);
+	kfree(ts);
+	return err;
+}
+
+static int __devexit tsc2008_remove(struct spi_device *spi)
+{
+	struct tsc2008 *ts = dev_get_drvdata(&spi->dev);
+
+	input_unregister_device(ts->input);
+	free_irq(ts->spi->irq, ts);
+	kfree(ts);
+
+	dev_dbg(&spi->dev, "unregistered touchscreen\n");
+	return 0;
+}
+
+static struct spi_driver tsc2008_driver = {
+	.driver	= {
+			.name	= "tsc2008",
+			.bus	= &spi_bus_type,
+			.owner	= THIS_MODULE,
+	},
+	.probe	= tsc2008_probe,
+	.remove	= __devexit_p(tsc2008_remove),
+};
+
+static int __init tsc2008_init(void)
+{
+	return spi_register_driver(&tsc2008_driver);
+}
+
+static void __exit tsc2008_exit(void)
+{
+	spi_unregister_driver(&tsc2008_driver);
+}
+
+MODULE_AUTHOR("Chris Verges <chrisv@cyberswitching.com>");
+MODULE_DESCRIPTION("Texas Instruments TSC2008 TouchScreen driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+module_init(tsc2008_init);
+module_exit(tsc2008_exit);
Index: drivers/input/touchscreen/Makefile
===================================================================
--- linux-2.6.29.3-orig/drivers/input/touchscreen/Makefile
(revision 11)
+++ linux-2.6.29.3/drivers/input/touchscreen/Makefile	(revision 32)
@@ -26,6 +26,7 @@
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHWIN)	+= touchwin.o
 obj-$(CONFIG_TOUCHSCREEN_TSC2007)	+= tsc2007.o
+obj-$(CONFIG_TOUCHSCREEN_TSC2008)	+= tsc2008.o
 obj-$(CONFIG_TOUCHSCREEN_UCB1400)	+= ucb1400_ts.o
 obj-$(CONFIG_TOUCHSCREEN_WACOM_W8001)	+= wacom_w8001.o
 obj-$(CONFIG_TOUCHSCREEN_WM97XX)	+= wm97xx-ts.o
