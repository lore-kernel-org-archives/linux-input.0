From: "Patil, Rachna" <rachna@ti.com>
Subject: RE: [PATCH] input: add support for TI Touchscreen controller.
Date: Fri, 8 Jul 2011 19:30:44 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D9B58D3@dbde02.ent.ti.com>
References: <1309956213-27477-1-git-send-email-rachna@ti.com>
 <20110707143703.GI7658@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37413 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750Ab1GHOAv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2011 10:00:51 -0400
In-Reply-To: <20110707143703.GI7658@core.coreip.homeip.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,

From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
Sent: Thursday, July 07, 2011 8:07 PM

> On Wed, Jul 06, 2011 at 06:13:33PM +0530, Patil, Rachna wrote:
> > This patch adds support for TI's touchscreen
> > controller for a 4/5/8 wire resistive panel
> > that is directly fed to the ADC.
> >
> > This touchscreen controller will be part of
> > an upcoming TI SoC and has been tested on
> > an emulation platform.
> >
> > Signed-off-by: Patil, Rachna <rachna@ti.com>
>
> Looks mostly good, please find a few comments below.
>
> > ---
> >  drivers/input/touchscreen/Kconfig     |   11 +
> >  drivers/input/touchscreen/Makefile    |    1 +
> >  drivers/input/touchscreen/ti_tscadc.c |  417
> +++++++++++++++++++++++++++++++++
> >  include/linux/input/ti_tsc.h          |    7 +
>
> Maybe we should call it ti_tscadc.h to match the .c file?

Ok. I will change this to ti_tscadc.h.

>
> >  4 files changed, 436 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/input/touchscreen/ti_tscadc.c
> >  create mode 100644 include/linux/input/ti_tsc.h
> >
> > diff --git a/drivers/input/touchscreen/Kconfig
> b/drivers/input/touchscreen/Kconfig
> > index 44589f5..9d5d3ba 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -704,4 +704,15 @@ config TOUCHSCREEN_TPS6507X
> >       To compile this driver as a module, choose M here: the
> >       module will be called tps6507x_ts.
> >
> > +config TOUCHSCREEN_TI_TSCADC
> > +   tristate "TI Touchscreen Interface"
> > +   help
> > +     Say Y here if you have 4/5/8 wire touchscreen controller
> > +     to be connected to the ADC controller on your TI SoC.
> > +
> > +     If unsure, say N.
> > +
> > +     To compile this driver as a module, choose M here: the
> > +     module will be called ti_tscadc.
> > +
> >  endif
> > diff --git a/drivers/input/touchscreen/Makefile
> b/drivers/input/touchscreen/Makefile
> > index 51b08b0..82d3098 100644
> > --- a/drivers/input/touchscreen/Makefile
> > +++ b/drivers/input/touchscreen/Makefile
> > @@ -58,3 +58,4 @@ obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)        +=
> mainstone-wm97xx.o
> >  obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)  += zylonite-wm97xx.o
> >  obj-$(CONFIG_TOUCHSCREEN_W90X900)  += w90p910_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_TPS6507X) += tps6507x-ts.o
> > +obj-$(CONFIG_TOUCHSCREEN_TI_TSCADC)        += ti_tscadc.o
>
> Please try keeping Kconfig and Makefile sorted alphabetically.

I will rearrange this.

>
> > diff --git a/drivers/input/touchscreen/ti_tscadc.c
> b/drivers/input/touchscreen/ti_tscadc.c
> > new file mode 100644
> > index 0000000..0308f71
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/ti_tscadc.c
> > @@ -0,0 +1,417 @@
> > +/*
> > + * TI Touch Screen driver
> > + *
> > + * Copyright (C) 2011 Texas Instruments Incorporated -
> http://www.ti.com/
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
> > +#include <linux/input/ti_tsc.h>
> > +
> > +#define TSCADC_REG_IRQEOI          0x020
> > +#define TSCADC_REG_IRQSTATUS               0x028
> > +#define TSCADC_REG_IRQENABLE               0x02C
> > +#define TSCADC_REG_IRQWAKEUP               0x034
> > +#define TSCADC_REG_CTRL                    0x040
> > +#define TSCADC_REG_ADCFSM          0x044
> > +#define TSCADC_REG_CLKDIV          0x04C
> > +#define TSCADC_REG_SE                      0x054
> > +#define TSCADC_REG_IDLECONFIG              0x058
> > +#define TSCADC_REG_CHARGECONFIG            0x05C
> > +#define TSCADC_REG_STEPCONFIG1             0x064
> > +#define TSCADC_REG_STEPDELAY1              0x068
> > +#define TSCADC_REG_STEPCONFIG2             0x06C
> > +#define TSCADC_REG_STEPDELAY2              0x070
> > +#define TSCADC_REG_FIFO0           0x100
> > +
> > +/* Register Bitfields      */
> > +#define TSCADC_IRQWKUP_ENB         BIT(0)
> > +#define TSCADC_STPENB_STEPENB              (7 << 0)
> > +#define TSCADC_IRQENB_IRQHWPEN             BIT(10)
> > +#define TSCADC_IRQENB_IRQEOS               BIT(1)
> > +#define TSCADC_IRQENB_FIFO_OVERFLOW        BIT(3)
> > +#define TSCADC_IRQENB_PENUP                BIT(9)
> > +#define TSCADC_STEPCONFIG_MODE_HWSYNC      0x3
> > +#define TSCADC_STEPCONFIG_2SAMPLES_AVG     BIT(2)
> > +#define TSCADC_STEPCONFIG_XPP              BIT(5)
> > +#define TSCADC_STEPCONFIG_XNN              BIT(6)
> > +#define TSCADC_STEPCONFIG_YPP              BIT(7)
> > +#define TSCADC_STEPCONFIG_YNN              BIT(8)
> > +#define TSCADC_STEPCONFIG_XNP              BIT(9)
> > +#define TSCADC_STEPCONFIG_YPN              BIT(10)
> > +#define TSCADC_STEPCONFIG_RFP_X            (1 << 12)
> > +#define TSCADC_STEPCONFIG_RFP_4_Y  (1 << 13)
> > +#define TSCADC_STEPCONFIG_RFP_5_Y  (1 << 12)
> > +#define TSCADC_STEPCONFIG_RFP_8_Y  (1 << 13)
> > +#define TSCADC_STEPCONFIG_INM              (1 << 18)
> > +#define TSCADC_STEPCONFIG_INP_4            (1 << 20)
> > +#define TSCADC_STEPCONFIG_INP_5            (1 << 21)
> > +#define TSCADC_STEPCONFIG_INP_8_X  (3 << 20)
> > +#define TSCADC_STEPCONFIG_INP_8_Y  (1 << 21)
> > +#define TSCADC_STEPCONFIG_RFM_4_X  (1 << 23)
> > +#define TSCADC_STEPCONFIG_RFM_5_X  (1 << 24)
> > +#define TSCADC_STEPCONFIG_RFM_8_X  (1 << 23)
> > +#define TSCADC_STEPCONFIG_RFM_Y            (1 << 24)
> > +#define TSCADC_STEPCONFIG_OPENDLY  (0xf << 0)
> > +#define TSCADC_STEPCONFIG_SAMPLEDLY        BIT(25)
> > +#define TSCADC_STEPCHARGE_INM              BIT(18)
> > +#define TSCADC_STEPCHARGE_RFM              (3 << 23)
> > +#define TSCADC_CNTRLREG_TSCSSENB   BIT(0)
> > +#define TSCADC_CNTRLREG_STEPID             BIT(1)
> > +#define TSCADC_CNTRLREG_STEPCONFIGWRT      BIT(2)
> > +#define TSCADC_CNTRLREG_TSCENB             BIT(7)
> > +#define TSCADC_CNTRLREG_4WIRE              (0x1 << 5)
> > +#define TSCADC_CNTRLREG_5WIRE              (0x1 << 6)
> > +#define TSCADC_CNTRLREG_8WIRE              (0x3 << 5)
> > +#define TSCADC_ADCFSM_STEPID               0x10
> > +#define TSCADC_ADCFSM_FSM          BIT(5)
> > +
> > +#define ADC_CLK                            3000000
> > +
> > +#define MAX_12BIT                       ((1 << 12) - 1)
> > +
> > +struct tscadc {
> > +   struct input_dev        *input;
> > +   int                     wires;
> > +   struct clk              *clk;
> > +   int                     irq;
> > +   void __iomem            *tsc_base;
> > +};
> > +
> > +static inline unsigned int tscadc_readl(struct tscadc *ts, unsigned int
> reg)
>
> Drop the 'inline', let compiler figure out what needs to be inlined.

Ok.

>
> > +{
> > +   return readl(ts->tsc_base + reg);
> > +}
> > +
> > +static inline void tscadc_writel(struct tscadc *tsc, unsigned int reg,
> > +                                   unsigned int val)
> > +{
> > +   writel(val, tsc->tsc_base + reg);
> > +}
> > +
> > +void tsc_idle_config(struct tscadc *ts_config)
>
> Should be static.

Ok.

>
> > +{
> > +   /* Idle mode touch screen config */
> > +   unsigned int     idleconfig;
> > +
> > +   idleconfig = TSCADC_STEPCONFIG_YNN |
> > +                           TSCADC_STEPCONFIG_RFP_X |
> > +                           TSCADC_STEPCONFIG_INM ;
> > +
> > +   if (ts_config->wires == 4) {
>
>       switch (ts_config->wires) {
>       case 4:
>               ...
>       }

Will add switch cases accordingly through out
the code.

>
> > +           idleconfig |= TSCADC_STEPCONFIG_INP_4 |
> > +                           TSCADC_STEPCONFIG_RFM_4_X;
> > +
> > +   } else if (ts_config->wires == 5) {
> > +           idleconfig |= TSCADC_STEPCONFIG_INP_5 |
> > +                           TSCADC_STEPCONFIG_RFM_5_X;
> > +
> > +   } else {
> > +           idleconfig |= TSCADC_STEPCONFIG_INP_4 |
> > +                           TSCADC_STEPCONFIG_RFM_8_X;
> > +   }
> > +   tscadc_writel(ts_config, TSCADC_REG_IDLECONFIG, idleconfig);
> > +}
> > +
> > +static irqreturn_t tscadc_interrupt(int irq, void *dev)
> > +{
> > +   struct tscadc           *ts_dev = (struct tscadc *)dev;
> > +   struct input_dev        *input_dev = ts_dev->input;
> > +   unsigned int            status, store, cntrlreg, irqclr = 0;
> > +   int                     absx, absy;
> > +   int                     charge, fsm;
> > +
> > +   status = tscadc_readl(ts_dev, TSCADC_REG_IRQSTATUS);
> > +   tscadc_writel(ts_dev, TSCADC_REG_SE, 0x0);
> > +
> > +   /* Pen touch event */
> > +   if (status & TSCADC_IRQENB_IRQHWPEN)
> > +           irqclr = status & TSCADC_IRQENB_IRQHWPEN;
> > +
> > +   if (status & TSCADC_IRQENB_PENUP) {
> > +           /* Pen up event */
> > +           charge = TSCADC_STEPCHARGE_INM | TSCADC_STEPCHARGE_RFM;
> > +           tscadc_writel(ts_dev, TSCADC_REG_CHARGECONFIG, charge);
> > +           input_report_key(input_dev, BTN_TOUCH, 0);
>
>               input_sync(input_dev);

Will add this.

>
> > +           tsc_idle_config(ts_dev);
> > +           irqclr |= status & TSCADC_IRQENB_PENUP;
>
> You already know that TSCADC_IRQENB_PENUP in status is set, so can do
>
>       irqclr |= TSCADC_IRQENB_PENUP;
>
> But you do it several times. If you define a bitmask mask you can do
>
>       irqclr = status & TSCADC_IRQENB_MASK;
>
> once before writing it back to the device.

Will change it to irqclr |= TSCADC_IRQENB_PENUP;

>
> > +
> > +   }
> > +   if (status & TSCADC_IRQENB_IRQEOS) {
> > +           /* ADC is done with sampling, ready to read the data */
> > +           absx = tscadc_readl(ts_dev, TSCADC_REG_FIFO0);
> > +           absy = tscadc_readl(ts_dev, TSCADC_REG_FIFO0);
> > +
> > +           input_report_abs(input_dev, ABS_X, absx);
> > +           input_report_abs(input_dev, ABS_Y, absy);
> > +           input_report_key(input_dev, BTN_TOUCH, 1);
>
>               input_sync(input_dev);

I will add this.

>
> > +
> > +           irqclr |= status & TSCADC_IRQENB_IRQEOS;
> > +
> > +   }
> > +   if (status & TSCADC_IRQENB_FIFO_OVERFLOW) {
> > +           /* FIFO overflow condition */
> > +           cntrlreg = tscadc_readl(ts_dev, TSCADC_REG_CTRL);
> > +           cntrlreg &= ~TSCADC_CNTRLREG_TSCSSENB;
> > +           tscadc_writel(ts_dev, TSCADC_REG_CTRL, cntrlreg);
> > +
> > +           irqclr |= status & TSCADC_IRQENB_FIFO_OVERFLOW;
> > +   }
> > +
> > +   tscadc_writel(ts_dev, TSCADC_REG_IRQSTATUS, irqclr);
> > +   fsm = tscadc_readl(ts_dev, TSCADC_REG_ADCFSM);
> > +   if ((fsm & TSCADC_ADCFSM_FSM) &&
> > +                   (fsm & TSCADC_ADCFSM_STEPID)) {
> > +           store = tscadc_readl(ts_dev, TSCADC_REG_CTRL);
> > +           store |= TSCADC_CNTRLREG_TSCSSENB;
> > +           tscadc_writel(ts_dev, TSCADC_REG_CTRL, store);
> > +   }
> > +
> > +    /* check pending interrupts */
> > +   tscadc_writel(ts_dev, TSCADC_REG_IRQEOI, 0x0);
> > +
> > +   tscadc_writel(ts_dev, TSCADC_REG_SE, TSCADC_STPENB_STEPENB);
> > +   return IRQ_HANDLED;
> > +}
> > +
> > +/*
> > +* The functions for inserting/removing driver as a module.
> > +*/
> > +
> > +static     int __devinit tscadc_probe(struct platform_device *pdev)
> > +{
> > +   struct tscadc                   *ts_dev;
> > +   struct input_dev                *input_dev;
> > +   int                             err;
> > +   int                             clk_value;
> > +   int                             clock_rate, ctrl, irqenable;
> > +   struct  tsc_data                *pdata = pdev->dev.platform_data;
> > +   struct resource                 *res;
> > +   int                             stepconfig1, stepconfig2, delay;
> > +
> > +   res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +   if (!res) {
> > +           dev_err(&pdev->dev, "no memory resource defined.\n");
> > +           return -ENXIO;
>
> -EINVAL? We do expect the device to be set up properly.

Agree.

>
> > +   }
> > +
> > +   /* Allocate memory for device */
> > +   ts_dev = kzalloc(sizeof(struct tscadc), GFP_KERNEL);
> > +   if (!ts_dev) {
> > +           dev_err(&pdev->dev, "failed to allocate memory.\n");
> > +           return -ENOMEM;
> > +   }
> > +
> > +   input_dev = input_allocate_device();
> > +   if (!input_dev) {
> > +           dev_err(&pdev->dev, "failed to allocate input device.\n");
> > +           err = -EBUSY;
>
> -ENOMEM instead of -EBUSY.

Ok.

>
> > +           goto err_free_mem;
> > +   }
> > +   ts_dev->input = input_dev;
> > +
> > +   ts_dev->irq = platform_get_irq(pdev, 0);
> > +   if (ts_dev->irq < 0) {
> > +           dev_err(&pdev->dev, "no irq ID is specified.\n");
>
> Why don't you check if you have IRQ before allocating memory, like you
> did with the IO?

Will rearrange.

>
> > +           err = -ENODEV;
>
> Probably should be -EINVAL.

Ok.

>
> > +           goto err_free_dev;
> > +   }
> > +
> > +   ts_dev->tsc_base = ioremap(res->start, resource_size(res));
> > +   if (!(ts_dev->tsc_base)) {
>
> Drop extra parens.
>

Ok

> > +           dev_err(&pdev->dev, "failed to map registers.\n");
> > +           err = -ENOMEM;
> > +           goto err_release_mem;
> > +   }
> > +
> > +   err = request_irq(ts_dev->irq, tscadc_interrupt, IRQF_DISABLED,
> > +   pdev->dev.driver->name, ts_dev);
>
> Please indent this line more.
>

Ok.

> > +   if (err) {
> > +           dev_err(&pdev->dev, "failed to allocate irq.\n");
> > +           goto err_unmap_regs;
> > +   }
> > +
> > +   ts_dev->clk = clk_get(&pdev->dev, "tsc_clk");
> > +   if (IS_ERR(ts_dev->clk)) {
> > +           dev_err(&pdev->dev, "failed to get ts_clk\n");
> > +           err = PTR_ERR(ts_dev->clk);
> > +           goto err_free_irq;
> > +   }
> > +   clk_enable(ts_dev->clk);
> > +
> > +   clock_rate = clk_get_rate(ts_dev->clk);
> > +   clk_value = clock_rate / ADC_CLK;
> > +   if (clk_value < 7) {
> > +           dev_err(&pdev->dev, "clock input less than min clock
> requirement\n");
> > +           goto err_fail;
> > +   }
> > +   /* TSCADC_CLKDIV needs to be configured to the value minus 1 */
> > +   clk_value = clk_value - 1;
> > +   tscadc_writel(ts_dev, TSCADC_REG_CLKDIV, clk_value);
> > +
> > +    /* Enable wake-up of the SoC using touchscreen */
> > +   tscadc_writel(ts_dev, TSCADC_REG_IRQWAKEUP, TSCADC_IRQWKUP_ENB);
> > +
> > +   ts_dev->wires = pdata->wires;
> > +
> > +   /* Set the control register bits */
> > +   ctrl = TSCADC_CNTRLREG_STEPCONFIGWRT |
> > +                   TSCADC_CNTRLREG_TSCENB |
> > +                   TSCADC_CNTRLREG_STEPID;
> > +   if (ts_dev->wires == 4)
>
>       switch()
>
> > +           ctrl |= TSCADC_CNTRLREG_4WIRE;
> > +   else if (ts_dev->wires == 5)
> > +           ctrl |= TSCADC_CNTRLREG_5WIRE;
> > +   else
> > +           ctrl |= TSCADC_CNTRLREG_8WIRE;
> > +   tscadc_writel(ts_dev, TSCADC_REG_CTRL, ctrl);
> > +   tscadc_readl(ts_dev, TSCADC_REG_CTRL);
> > +
> > +   /* Set register bits for Idel Config Mode */
> > +   tsc_idle_config(ts_dev);
> > +
> > +   /* IRQ Enable */
> > +   irqenable = TSCADC_IRQENB_IRQHWPEN |
> > +                   TSCADC_IRQENB_IRQEOS |
> > +                   TSCADC_IRQENB_PENUP | TSCADC_IRQENB_FIFO_OVERFLOW;
> > +   tscadc_writel(ts_dev, TSCADC_REG_IRQENABLE, irqenable);
> > +   tscadc_readl(ts_dev, TSCADC_REG_IRQENABLE);
> > +
> > +   /* Configure the Step registers */
> > +   stepconfig1 = TSCADC_STEPCONFIG_MODE_HWSYNC |
> > +                   TSCADC_STEPCONFIG_2SAMPLES_AVG | TSCADC_STEPCONFIG_XPP |
> > +                   TSCADC_STEPCONFIG_XNN | TSCADC_STEPCONFIG_INM |
> > +                   TSCADC_STEPCONFIG_RFP_X;
> > +
> > +   stepconfig2 = TSCADC_STEPCONFIG_MODE_HWSYNC |
> > +                   TSCADC_STEPCONFIG_2SAMPLES_AVG | TSCADC_STEPCONFIG_YNN |
> > +                   TSCADC_STEPCONFIG_INM | TSCADC_STEPCONFIG_RFM_Y;
> > +   if (ts_dev->wires == 4) {
>
>       switch().
>
> > +           stepconfig1 |= TSCADC_STEPCONFIG_INP_4 |
> > +                                   TSCADC_STEPCONFIG_RFM_4_X;
> > +
> > +           stepconfig2 |= TSCADC_STEPCONFIG_YPP |
> > +                                   TSCADC_STEPCONFIG_RFP_4_Y;
> > +
> > +   } else if (ts_dev->wires == 5) {
> > +           stepconfig1 |= TSCADC_STEPCONFIG_YPP |
> > +                           TSCADC_STEPCONFIG_YNN |
> > +                           TSCADC_STEPCONFIG_INP_5 |
> > +                           TSCADC_STEPCONFIG_RFM_5_X;
> > +
> > +           stepconfig2 |= TSCADC_STEPCONFIG_XPP |
> > +                           TSCADC_STEPCONFIG_XNP |
> > +                           TSCADC_STEPCONFIG_YPN |
> > +                           TSCADC_STEPCONFIG_RFP_5_Y |
> > +                           TSCADC_STEPCONFIG_INP_5;
> > +   } else{
> > +           stepconfig1 |= TSCADC_STEPCONFIG_INP_8_X |
> > +                           TSCADC_STEPCONFIG_RFM_8_X;
> > +
> > +           stepconfig2 |= TSCADC_STEPCONFIG_YPP |
> > +                           TSCADC_STEPCONFIG_RFP_8_Y |
> > +                           TSCADC_STEPCONFIG_INP_8_Y;
> > +   }
> > +   delay = TSCADC_STEPCONFIG_OPENDLY | TSCADC_STEPCONFIG_SAMPLEDLY;
> > +
> > +   tscadc_writel(ts_dev, TSCADC_REG_STEPCONFIG1, stepconfig1);
> > +   tscadc_writel(ts_dev, TSCADC_REG_STEPDELAY1, delay);
> > +   tscadc_writel(ts_dev, TSCADC_REG_STEPCONFIG2, stepconfig2);
> > +   tscadc_writel(ts_dev, TSCADC_REG_STEPDELAY2, delay);
> > +
> > +   tscadc_writel(ts_dev, TSCADC_REG_SE, TSCADC_STPENB_STEPENB);
> > +
> > +   ctrl |= TSCADC_CNTRLREG_TSCSSENB;
> > +   tscadc_writel(ts_dev, TSCADC_REG_CTRL, ctrl);
> > +
>
> This chip programming could be split into a separate function.
>

Agree. I will add a function to do the chip programming.

> > +   input_dev->name = "ti-tsc-adcc";
> > +   input_dev->dev.parent = &pdev->dev;
>
>       input_dev->id.bustype = BUS_HOST?

Since this touchscreen is on the SoC, I omitted this.

>
> > +
> > +   input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > +   input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> > +
> > +   input_set_abs_params(input_dev, ABS_X, 0, MAX_12BIT, 0, 0);
> > +   input_set_abs_params(input_dev, ABS_Y, 0, MAX_12BIT, 0, 0);
> > +
> > +   /* register to the input system */
> > +   err = input_register_device(input_dev);
> > +   if (err)
> > +           goto err_fail;
> > +
> > +   return 0;
> > +
> > +err_fail:
> > +   clk_disable(ts_dev->clk);
> > +   clk_put(ts_dev->clk);
> > +err_free_irq:
> > +   free_irq(ts_dev->irq, ts_dev);
> > +err_unmap_regs:
> > +   iounmap(ts_dev->tsc_base);
> > +err_release_mem:
> > +   release_mem_region(res->start, resource_size(res));
> > +err_free_dev:
> > +   input_free_device(ts_dev->input);
> > +err_free_mem:
> > +   kfree(ts_dev);
> > +   return err;
> > +}
> > +
> > +static int __devexit tscadc_remove(struct platform_device *pdev)
> > +{
> > +   struct tscadc           *ts_dev = dev_get_drvdata(&pdev->dev);
> > +   struct resource         *res;
> > +
> > +   free_irq(ts_dev->irq, ts_dev);
> > +
> > +   input_unregister_device(ts_dev->input);
> > +
> > +   res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +   iounmap(ts_dev->tsc_base);
> > +   release_mem_region(res->start, resource_size(res));
> > +
> > +   clk_disable(ts_dev->clk);
> > +   clk_put(ts_dev->clk);
> > +
> > +   kfree(ts_dev);
> > +
> > +   return 0;
> > +}
> > +
> > +static struct platform_driver ti_tsc_driver = {
> > +   .probe    = tscadc_probe,
> > +   .remove  = __devexit_p(tscadc_remove),
> > +   .driver  = {
> > +           .name   = "tsc",
>
>               .owner = THIS_MODULE;
>
> No power management needed?
>

For now this is not handling.
I will add this in patches that will be
submitted in days to come.

> > +   },
> > +};
> > +
> > +static int __init ti_tsc_init(void)
> > +{
> > +   return platform_driver_register(&ti_tsc_driver);
> > +}
> > +
> > +static void __exit ti_tsc_exit(void)
> > +{
> > +   platform_driver_unregister(&ti_tsc_driver);
> > +}
> > +
> > +module_init(ti_tsc_init);
> > +module_exit(ti_tsc_exit);
> > diff --git a/include/linux/input/ti_tsc.h b/include/linux/input/ti_tsc.h
> > new file mode 100644
> > index 0000000..f499773
> > --- /dev/null
> > +++ b/include/linux/input/ti_tsc.h
> > @@ -0,0 +1,7 @@
> > +/* touch screen wire configuration */
> > +
> > +struct tsc_data {
> > +   int wires;      /* Wires refer to application modes
> > +                   i.e. 4/5/8 wire touchscreen support
> > +                   on the platform */
> > +};
> > --
> > 1.6.2.4
> >
>
> Thanks.
>
> --
> Dmitry


Thanks & Regards,
Rachna.

