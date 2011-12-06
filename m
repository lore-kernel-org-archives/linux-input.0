From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] input: add support for TI Touchscreen controller.
Date: Mon, 5 Dec 2011 22:44:35 -0800
Message-ID: <20111206064434.GC21617@core.coreip.homeip.net>
References: <1321963947-17057-1-git-send-email-rachna@ti.com>
 <4CE347531D4CA947960AF71FF095B932016FA9@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:35221 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab1LFGon (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Dec 2011 01:44:43 -0500
Received: by yenm1 with SMTP id m1so2548617yen.19
        for <linux-input@vger.kernel.org>; Mon, 05 Dec 2011 22:44:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE347531D4CA947960AF71FF095B932016FA9@DBDE01.ent.ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Patil, Rachna" <rachna@ti.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Rachna,

On Wed, Nov 23, 2011 at 11:42:34AM +0000, Patil, Rachna wrote:
> Hi Dmitry,
> 
> 
> On Tue, Nov 22, 2011 at 17:42:27, Patil, Rachna wrote:
> > From: Rachna Patil <rachna@ti.com>
> > 
> > This patch adds support for TI's touchscreen controller for a 4/5/8 wire resistive panel that is directly fed to the ADC.
> > 
> > This touchscreen controller will be part of AM335x TI SoC. The TRM can be found at:
> > http://www.ti.com/lit/ug/spruh73a/spruh73a.pdf
> > 
> > Signed-off-by: Patil, Rachna <rachna@ti.com>
> > ---
> > There was an earlier version of this driver submitted.
> > As the patch has evolved tremendously, I am not submitting this patch as v2.
> > 
> 
> I had submitted this patch to the Linux input community, however it does not appear in the
> archive. Did you receive a copy of this?
>  

Yes, I did, it was in my TODO queue.

Actaully on July 31 I gave you my freedback to the previous version of
the patch and send I new version of the patch correctig several issues.
It looks like you have missed it as these issues are still present in
this version.

Also a cuple of comments below.

> >  drivers/input/touchscreen/Kconfig     |   12 +
> >  drivers/input/touchscreen/Makefile    |    1 +
> >  drivers/input/touchscreen/ti_tscadc.c |  491 +++++++++++++++++++++++++++++++++
> >  include/linux/input/ti_tscadc.h       |   12 +
> >  4 files changed, 516 insertions(+), 0 deletions(-)  create mode 100644 drivers/input/touchscreen/ti_tscadc.c
> >  create mode 100644 include/linux/input/ti_tscadc.h
> > 
> > diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> > index cabd9e5..de4ee06 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -407,6 +407,18 @@ config TOUCHSCREEN_TOUCHWIN
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called touchwin.
> >  
> > +config TOUCHSCREEN_TI_TSCADC
> > +	tristate "TI Touchscreen Interface"
> > +	depends on ARCH_OMAP2PLUS
> > +	help
> > +	  Say Y here if you have 4/5/8 wire touchscreen controller
> > +	  to be connected to the ADC controller on your TI AM335x SoC.
> > +
> > +	  If unsure, say N.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called ti_tscadc.
> > +
> >  config TOUCHSCREEN_ATMEL_TSADCC
> >  	tristate "Atmel Touchscreen Interface"
> >  	depends on ARCH_AT91SAM9RL || ARCH_AT91SAM9G45 diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> > index 282d6f7..e353bcb 100644
> > --- a/drivers/input/touchscreen/Makefile
> > +++ b/drivers/input/touchscreen/Makefile
> > @@ -42,6 +42,7 @@ obj-$(CONFIG_TOUCHSCREEN_PENMOUNT)	+= penmount.o
> >  obj-$(CONFIG_TOUCHSCREEN_S3C2410)	+= s3c2410_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_ST1232)	+= st1232.o
> >  obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
> > +obj-$(CONFIG_TOUCHSCREEN_TI_TSCADC)	+= ti_tscadc.o
> >  obj-$(CONFIG_TOUCHSCREEN_TNETV107X)	+= tnetv107x-ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
> >  obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
> > diff --git a/drivers/input/touchscreen/ti_tscadc.c b/drivers/input/touchscreen/ti_tscadc.c
> > new file mode 100644
> > index 0000000..937dea2
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/ti_tscadc.c
> > @@ -0,0 +1,491 @@
> > +/*
> > + * TI Touch Screen driver
> > + *
> > + * Copyright (C) 2011 Texas Instruments Incorporated - 
> > +http://www.ti.com/
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License as
> > + * published by the Free Software Foundation version 2.
> > + *
> > + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> > + * kind, whether express or implied; without even the implied warranty
> > + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/err.h>
> > +#include <linux/module.h>
> > +#include <linux/input.h>
> > +#include <linux/slab.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/clk.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/io.h>
> > +#include <linux/input/ti_tscadc.h>
> > +#include <linux/delay.h>
> > +
> > +#define REG_IRQEOI		0x020
> > +#define REG_RAWIRQSTATUS	0x024
> > +#define REG_IRQSTATUS		0x028
> > +#define REG_IRQENABLE		0x02C
> > +#define REG_IRQWAKEUP		0x034
> > +#define REG_CTRL		0x040
> > +#define REG_ADCFSM		0x044
> > +#define REG_CLKDIV		0x04C
> > +#define REG_SE			0x054
> > +#define REG_IDLECONFIG		0x058
> > +#define REG_CHARGECONFIG	0x05C
> > +#define REG_CHARGEDELAY		0x060
> > +#define REG_STEPCONFIG(n)	(0x64 + ((n - 1) * 8))
> > +#define REG_STEPDELAY(n)	(0x68 + ((n - 1) * 8))
> > +#define REG_STEPCONFIG13	0x0C4
> > +#define REG_STEPDELAY13		0x0C8
> > +#define REG_STEPCONFIG14	0x0CC
> > +#define REG_STEPDELAY14		0x0D0
> > +#define REG_FIFO0CNT		0xE4
> > +#define REG_FIFO1THR		0xF4
> > +#define REG_FIFO0		0x100
> > +#define REG_FIFO1		0x200
> > +
> > +/*	Register Bitfields	*/
> > +#define IRQWKUP_ENB		BIT(0)
> > +#define STPENB_STEPENB		0x7FFF
> > +#define IRQENB_FIFO1THRES	BIT(5)
> > +#define IRQENB_PENUP		BIT(9)
> > +#define STEPCONFIG_MODE_HWSYNC	0x2
> > +#define STEPCONFIG_SAMPLES_AVG	(1 << 4)
> > +#define STEPCONFIG_XPP		(1 << 5)
> > +#define STEPCONFIG_XNN		(1 << 6)
> > +#define STEPCONFIG_YPP		(1 << 7)
> > +#define STEPCONFIG_YNN		(1 << 8)
> > +#define STEPCONFIG_XNP		(1 << 9)
> > +#define STEPCONFIG_YPN		(1 << 10)
> > +#define STEPCONFIG_INM		(1 << 18)
> > +#define STEPCONFIG_INP		(1 << 20)
> > +#define STEPCONFIG_INP_5	(1 << 21)
> > +#define STEPCONFIG_FIFO1	(1 << 26)
> > +#define STEPCONFIG_OPENDLY	0x90
> > +#define STEPCONFIG_Z1		(3 << 19)
> > +#define STEPIDLE_INP		(1 << 22)
> > +#define STEPCHARGE_RFP		(1 << 12)
> > +#define STEPCHARGE_INM		(1 << 15)
> > +#define STEPCHARGE_INP		(1 << 19)
> > +#define STEPCHARGE_RFM		(1 << 23)
> > +#define STEPCHARGE_DELAY	0x1
> > +#define CNTRLREG_TSCSSENB	(1 << 0)
> > +#define CNTRLREG_STEPID		(1 << 1)
> > +#define CNTRLREG_STEPCONFIGWRT	(1 << 2)
> > +#define CNTRLREG_4WIRE		(1 << 5)
> > +#define CNTRLREG_5WIRE		(1 << 6)
> > +#define CNTRLREG_8WIRE		(3 << 5)
> > +#define CNTRLREG_TSCENB		(1 << 7)
> > +#define ADCFSM_STEPID		0x10
> > +
> > +#define SEQ_SETTLE		315
> > +#define ADC_CLK			3000000
> > +#define MAX_12BIT		((1 << 12) - 1)
> > +
> > +struct tscadc {
> > +	struct input_dev	*input;
> > +	int			wires;
> > +	int			x_plate_resistance;
> > +	struct clk		*tsc_ick;
> > +	int			irq;
> > +	void __iomem		*tsc_base;
> > +};
> > +
> > +int pen = 1;
> > +unsigned int bckup_x = 0, bckup_y = 0;

Drivers should not use globals variables, especially ones with scope
exceeding module.

> > +
> > +static unsigned int tscadc_readl(struct tscadc *ts, unsigned int reg) {
> > +	return readl(ts->tsc_base + reg);
> > +}
> > +
> > +static void tscadc_writel(struct tscadc *tsc, unsigned int reg,
> > +					unsigned int val)
> > +{
> > +	writel(val, tsc->tsc_base + reg);
> > +}
> > +
> > +static void tsc_step_config(struct tscadc *ts_dev) {
> > +	unsigned int	config;
> > +	int i;
> > +
> > +	/* Configure the Step registers */
> > +
> > +	config = STEPCONFIG_MODE_HWSYNC |
> > +			STEPCONFIG_SAMPLES_AVG | STEPCONFIG_XPP;
> > +	switch (ts_dev->wires) {
> > +	case 4:
> > +		config |= STEPCONFIG_INP |
> > +				STEPCONFIG_XNN;
> > +		break;
> > +	case 5:
> > +		config |= STEPCONFIG_YNN |
> > +				STEPCONFIG_INP_5 | STEPCONFIG_XNN |
> > +				STEPCONFIG_YPP;
> > +		break;
> > +	case 8:
> > +		config |= STEPCONFIG_INP |
> > +				STEPCONFIG_XNN;
> > +		break;
> > +	}
> > +	for (i = 1; i < 7; i++) {
> > +		tscadc_writel(ts_dev, REG_STEPCONFIG(i), config);
> > +		tscadc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
> > +	}
> > +
> > +	config = 0;
> > +	config = STEPCONFIG_MODE_HWSYNC |
> > +			STEPCONFIG_SAMPLES_AVG | STEPCONFIG_YNN |
> > +			STEPCONFIG_INM | STEPCONFIG_FIFO1;
> > +	switch (ts_dev->wires) {
> > +	case 4:
> > +		config |= STEPCONFIG_YPP;
> > +		break;
> > +	case 5:
> > +		config |= STEPCONFIG_XPP | STEPCONFIG_INP_5 |
> > +				STEPCONFIG_XNP | STEPCONFIG_YPN;
> > +		break;
> > +	case 8:
> > +		config |= STEPCONFIG_YPP;
> > +		break;
> > +	}
> > +	for (i = 7; i < 13; i++) {
> > +		tscadc_writel(ts_dev, REG_STEPCONFIG(i), config);
> > +		tscadc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
> > +	}
> > +
> > +	config = 0;
> > +	/* Charge step configuration */
> > +	config = STEPCONFIG_XPP | STEPCONFIG_YNN |
> > +			STEPCHARGE_RFP | STEPCHARGE_RFM |
> > +			STEPCHARGE_INM | STEPCHARGE_INP;
> > +
> > +	tscadc_writel(ts_dev, REG_CHARGECONFIG, config);
> > +	tscadc_writel(ts_dev, REG_CHARGEDELAY, STEPCHARGE_DELAY);
> > +
> > +	config = 0;
> > +	/* Configure to calculate pressure */
> > +	config = STEPCONFIG_MODE_HWSYNC |
> > +			STEPCONFIG_SAMPLES_AVG | STEPCONFIG_YPP |
> > +			STEPCONFIG_XNN | STEPCONFIG_INM;
> > +	tscadc_writel(ts_dev, REG_STEPCONFIG13, config);
> > +	tscadc_writel(ts_dev, REG_STEPDELAY13, STEPCONFIG_OPENDLY);
> > +
> > +	config |= STEPCONFIG_Z1 | STEPCONFIG_FIFO1;
> > +	tscadc_writel(ts_dev, REG_STEPCONFIG14, config);
> > +	tscadc_writel(ts_dev, REG_STEPDELAY14, STEPCONFIG_OPENDLY);
> > +
> > +	tscadc_writel(ts_dev, REG_SE, STPENB_STEPENB); }
> > +
> > +static void tsc_idle_config(struct tscadc *ts_config) {
> > +	unsigned int	 idleconfig;
> > +
> > +	idleconfig = STEPCONFIG_YNN |
> > +			STEPCONFIG_INM |
> > +			STEPCONFIG_YPN | STEPIDLE_INP;
> > +	tscadc_writel(ts_config, REG_IDLECONFIG, idleconfig); }
> > +
> > +static irqreturn_t interrupt(int irq, void *dev) {
> > +	struct tscadc		*ts_dev = (struct tscadc *)dev;
> > +	struct input_dev	*input_dev = ts_dev->input;
> > +	unsigned int		status, irqclr = 0;
> > +	int			i, fsm, fifocount;
> > +	unsigned int		read, diff;
> > +	unsigned int		prev_val_x = ~0, prev_val_y = ~0;
> > +	unsigned int		prev_diff_x = ~0, prev_diff_y = ~0;
> > +	unsigned int		val_x = 0, val_y = 0, diffx = 0, diffy = 0;
> > +	unsigned int		z1 = 0, z2 = 0, z = 0;
> > +
> > +	status = tscadc_readl(ts_dev, REG_IRQSTATUS);
> > +	if (status & IRQENB_FIFO1THRES) {
> > +		fifocount = tscadc_readl(ts_dev, REG_FIFO0CNT);
> > +
> > +		/* Comparing 2 consecutive X/Y co-ordinates
> > +		 * to discard random unwanted samples from ADC.
> > +		 */
> > +		for (i = 0; i < (fifocount-1); i++) {
> > +			read = ((tscadc_readl(ts_dev, REG_FIFO0)) & 0xfff);
> > +			diff = abs(read - prev_val_x);
> > +			if (diff < prev_diff_x) {
> > +				prev_diff_x = diff;
> > +				val_x = read;
> > +			}
> > +			prev_val_x = read;
> > +
> > +			read = 0;
> > +			read = ((tscadc_readl(ts_dev, REG_FIFO1)) & 0xfff);
> > +			diff = abs(read - prev_val_y);
> > +			if (diff < prev_diff_y) {
> > +				prev_diff_y = diff;
> > +				val_y = read;
> > +			}
> > +			prev_val_y = read;
> > +		}
> > +
> > +		diffx = abs(val_x - bckup_x);
> > +		diffy = abs(val_y - bckup_y);
> > +		bckup_x = val_x;
> > +		bckup_y = val_y;
> > +
> > +		z1 = ((tscadc_readl(ts_dev, REG_FIFO0)) & 0xfff);
> > +		z2 = ((tscadc_readl(ts_dev, REG_FIFO1)) & 0xfff);
> > +
> > +		if (pen == 0) {
> > +			if ((z1 != 0) && (z2 != 0)) {
> > +				/* cal pressure using formula
> > +				 * Resistance(touch) = x plate resistance *
> > +				 * x postion/4096 * ((z2 / z1) - 1)
> > +				 */
> > +				z = z2 - z1;
> > +				z *= val_x;
> > +				z *= ts_dev->x_plate_resistance;
> > +				z /= z1;
> > +				z = (z + 2047) >> 12;
> > +
> > +				 /*
> > +				  * Sample found inconsistent by debouncing
> > +				  * or pressure is beyond the maximum.
> > +				  * Don't report it to user space.
> > +				  */
> > +				if ((diffx < 15) && (diffy < 15)

If you set up 'fuzz' on appropriate axis input core will do filtering
for you, there is not need to reimplement this in your driver.

> > +						&& (z <= MAX_12BIT)) {
> > +					input_report_abs(input_dev,
> > +							ABS_X, val_x);
> > +					input_report_abs(input_dev,
> > +							ABS_Y, val_y);
> > +					input_report_abs(input_dev,
> > +							ABS_PRESSURE, z);
> > +					input_report_key(input_dev,
> > +							BTN_TOUCH, 1);
> > +					input_sync(input_dev);
> > +				}
> > +			}
> > +		}
> > +		irqclr |= IRQENB_FIFO1THRES;
> > +	}
> > +
> > +	/*
> > +	 * Time for sequencer to settle,
> > +	 * So that correct state of the
> > +	 * sequencer can be read.
> > +	 */
> > +	udelay(SEQ_SETTLE);
> > +
> > +	status = tscadc_readl(ts_dev, REG_RAWIRQSTATUS);
> > +	if (status & IRQENB_PENUP) {
> > +		/* Pen up event */
> > +		fsm = tscadc_readl(ts_dev, REG_ADCFSM);
> > +		if (fsm == ADCFSM_STEPID) {
> > +			pen = 1;
> > +			bckup_x = 0;
> > +			bckup_y = 0;
> > +			input_report_key(input_dev, BTN_TOUCH, 0);
> > +			input_report_abs(input_dev, ABS_PRESSURE, 0);
> > +			input_sync(input_dev);
> > +		} else {
> > +			pen = 0;
> > +		}
> > +		irqclr |= IRQENB_PENUP;
> > +	}
> > +
> > +	tscadc_writel(ts_dev, REG_IRQSTATUS, irqclr);
> > +	/* check pending interrupts */
> > +	tscadc_writel(ts_dev, REG_IRQEOI, 0x0);
> > +
> > +	tscadc_writel(ts_dev, REG_SE, STPENB_STEPENB);
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/*
> > +* The functions for inserting/removing driver as a module.
> > +*/
> > +
> > +static	int __devinit tscadc_probe(struct platform_device *pdev)
> > +{
> > +	struct tscadc			*ts_dev;
> > +	struct input_dev		*input_dev;
> > +	int				err;
> > +	int				clk_value, ctrl;
> > +	struct	tsc_data		*pdata = pdev->dev.platform_data;
> > +	struct resource			*res;
> > +	struct clk			*clk;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "no memory resource defined.\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Allocate memory for device */
> > +	ts_dev = kzalloc(sizeof(struct tscadc), GFP_KERNEL);
> > +	if (!ts_dev) {
> > +		dev_err(&pdev->dev, "failed to allocate memory.\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	ts_dev->irq = platform_get_irq(pdev, 0);
> > +	if (ts_dev->irq < 0) {
> > +		dev_err(&pdev->dev, "no irq ID is specified.\n");
> > +		err = -ENODEV;
> > +		goto err_free_mem;
> > +	}
> > +
> > +	input_dev = input_allocate_device();
> > +	if (!input_dev) {
> > +		dev_err(&pdev->dev, "failed to allocate input device.\n");
> > +		err = -ENOMEM;
> > +		goto err_free_mem;
> > +	}
> > +	ts_dev->input = input_dev;
> > +
> > +	ts_dev->tsc_base = ioremap(res->start, resource_size(res));
> > +	if (!ts_dev->tsc_base) {
> > +		dev_err(&pdev->dev, "failed to map registers.\n");
> > +		err = -ENOMEM;
> > +		goto err_release_mem;
> > +	}
> > +
> > +	err = request_irq(ts_dev->irq, interrupt, IRQF_DISABLED,
> > +			pdev->dev.driver->name, ts_dev);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "failed to allocate irq.\n");
> > +		goto err_unmap_regs;
> > +	}
> > +
> > +	ts_dev->tsc_ick = clk_get(&pdev->dev, "adc_tsc_ick");
> > +	if (IS_ERR(ts_dev->tsc_ick)) {
> > +		dev_err(&pdev->dev, "failed to get TSC ick\n");
> > +		goto err_free_irq;
> > +	}
> > +	clk_enable(ts_dev->tsc_ick);
> > +
> > +	clk = clk_get(&pdev->dev, "adc_tsc_fck");
> > +	if (IS_ERR(clk)) {
> > +		dev_err(&pdev->dev, "failed to get TSC fck\n");
> > +		err = PTR_ERR(clk);
> > +		goto err_fail;
> > +	}
> > +
> > +	clk_value = clk_get_rate(clk) / ADC_CLK;
> > +	if (clk_value < 7) {
> > +		dev_err(&pdev->dev, "clock input less than min clock requirement\n");
> > +		goto err_fail;
> > +	}
> > +	/* CLKDIV needs to be configured to the value minus 1 */
> > +	clk_value = clk_value - 1;
> > +	tscadc_writel(ts_dev, REG_CLKDIV, clk_value);
> > +
> > +	 /* Enable wake-up of the SoC using touchscreen */
> > +	tscadc_writel(ts_dev, REG_IRQWAKEUP, IRQWKUP_ENB);
> > +
> > +	ts_dev->wires = pdata->wires;
> > +	ts_dev->x_plate_resistance = pdata->x_plate_resistance;
> > +
> > +	ctrl = CNTRLREG_STEPCONFIGWRT |
> > +			CNTRLREG_TSCENB |
> > +			CNTRLREG_STEPID;
> > +	switch (ts_dev->wires) {
> > +	case 4:
> > +		ctrl |= CNTRLREG_4WIRE;
> > +		break;
> > +	case 5:
> > +		ctrl |= CNTRLREG_5WIRE;
> > +		break;
> > +	case 8:
> > +		ctrl |= CNTRLREG_8WIRE;
> > +		break;
> > +	}
> > +	tscadc_writel(ts_dev, REG_CTRL, ctrl);
> > +
> > +	tsc_idle_config(ts_dev);
> > +	tscadc_writel(ts_dev, REG_IRQENABLE, IRQENB_FIFO1THRES);
> > +	tsc_step_config(ts_dev);
> > +	tscadc_writel(ts_dev, REG_FIFO1THR, 6);
> > +
> > +	ctrl |= CNTRLREG_TSCSSENB;
> > +	tscadc_writel(ts_dev, REG_CTRL, ctrl);
> > +
> > +	input_dev->name = "ti-tsc-adc";
> > +	input_dev->dev.parent = &pdev->dev;
> > +
> > +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > +	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> > +
> > +	input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
> > +	input_set_abs_params(input_dev, ABS_PRESSURE, 0, MAX_12BIT, 0, 0);
> > +
> > +	/* register to the input system */
> > +	err = input_register_device(input_dev);
> > +	if (err)
> > +		goto err_fail;
> > +
> > +	return 0;
> > +
> > +err_fail:
> > +	clk_disable(ts_dev->tsc_ick);
> > +	clk_put(ts_dev->tsc_ick);
> > +err_free_irq:
> > +	free_irq(ts_dev->irq, ts_dev);
> > +err_unmap_regs:
> > +	iounmap(ts_dev->tsc_base);
> > +err_release_mem:
> > +	release_mem_region(res->start, resource_size(res));
> > +	input_free_device(ts_dev->input);
> > +err_free_mem:
> > +	kfree(ts_dev);
> > +	return err;
> > +}
> > +
> > +static int __devexit tscadc_remove(struct platform_device *pdev) {
> > +	struct tscadc		*ts_dev = dev_get_drvdata(&pdev->dev);
> > +	struct resource		*res;
> > +
> > +	free_irq(ts_dev->irq, ts_dev);
> > +
> > +	input_unregister_device(ts_dev->input);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	iounmap(ts_dev->tsc_base);
> > +	release_mem_region(res->start, resource_size(res));
> > +
> > +	clk_disable(ts_dev->tsc_ick);
> > +	clk_put(ts_dev->tsc_ick);
> > +
> > +	kfree(ts_dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver ti_tsc_driver = {
> > +	.probe	= tscadc_probe,
> > +	.remove	= __devexit_p(tscadc_remove),
> > +	.driver	= {
> > +			.name   = "tsc",
> > +	},
> > +};
> > +
> > +static int __init ti_tsc_init(void)
> > +{
> > +	return platform_driver_register(&ti_tsc_driver);
> > +}
> > +
> > +static void __exit ti_tsc_exit(void)
> > +{
> > +	platform_driver_unregister(&ti_tsc_driver);
> > +}
> > +
> > +module_init(ti_tsc_init);
> > +module_exit(ti_tsc_exit);
> > diff --git a/include/linux/input/ti_tscadc.h b/include/linux/input/ti_tscadc.h new file mode 100644 index 0000000..b315baa
> > --- /dev/null
> > +++ b/include/linux/input/ti_tscadc.h
> > @@ -0,0 +1,12 @@
> > +/**
> > + * struct tsc_data	Touchscreen wire configuration
> > + * @wires:		Wires refer to application modes
> > + *			i.e. 4/5/8 wire touchscreen support
> > + *			on the platform.
> > + * @x_plate_resistance:	X plate resistance.
> > + */
> > +
> > +struct tsc_data {
> > +	int wires;
> > +	int x_plate_resistance;
> > +};
> > --
> > 1.7.1
> > 
> > 
> 
> Regards,
> Rachna.

Thanks.

-- 
Dmitry
