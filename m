From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add support for touch screen on W90P910 ARM platform
Date: Sat, 9 May 2009 12:54:49 -0700
Message-ID: <20090509195446.GA1617@dtor-d630.eng.vmware.com>
References: <e68bb3470904270803q5e69a5f4n74ff58848f397f28@mail.gmail.com> <20090508034148.GF30616@dtor-d630.eng.vmware.com> <4A04DCA6.8070304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:35634 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbZEITzA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 9 May 2009 15:55:00 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1869560wfd.4
        for <linux-input@vger.kernel.org>; Sat, 09 May 2009 12:55:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A04DCA6.8070304@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Wan,

On Sat, May 09, 2009 at 09:30:14AM +0800, Wan ZongShun wrote:
> Dear Dmitry,
> 
> Thank you very much for your reviewing my patch.
> According to your advice,I have re-modified this
> ts driver and submitted it again.
> 
> I have run the patch through scripts/checkpatch.pl 
> and make sure it does not complain. Thanks!
> 

Thank you very much for addressing my comments, the driver looks much
better now. Still have a few more though ;)

> --
>  drivers/input/touchscreen/Kconfig      |    6 
>  drivers/input/touchscreen/Makefile     |    1 
>  drivers/input/touchscreen/w90p910_ts.c |  279 +++++++++++++++++++++++
>  3 files changed, 286 insertions(+)
> ---
> patch text:
> 
> Add touchscreen drivers for w90p910 platform.
> 
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> 
> diff -Npur linux-2.6.29/drivers/input/touchscreen/Kconfig linux-2.6.30/drivers/input/touchscreen/Kconfig
> --- linux-2.6.29/drivers/input/touchscreen/Kconfig	2009-05-05 18:32:26.000000000 +0800
> +++ linux-2.6.30/drivers/input/touchscreen/Kconfig	2009-05-09 07:33:32.000000000 +0800
> @@ -466,4 +466,10 @@ config TOUCHSCREEN_TSC2007
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called tsc2007.
>  
> +config TOUCHSCREEN_W90X900
> +	tristate "W90P910 touchscreens"
> +	depends on CPU_W90P910
> +	help
> +		Compile this driver to support W90P910 touchscreen.
> +

"To compile this driver as a module..."

>  endif
> diff -Npur linux-2.6.29/drivers/input/touchscreen/Makefile linux-2.6.30/drivers/input/touchscreen/Makefile
> --- linux-2.6.29/drivers/input/touchscreen/Makefile	2009-05-05 18:32:26.000000000 +0800
> +++ linux-2.6.30/drivers/input/touchscreen/Makefile	2009-05-09 07:34:12.000000000 +0800
> @@ -37,3 +37,4 @@ wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9712)	+
>  wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9713)	+= wm9713.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)	+= mainstone-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)	+= zylonite-wm97xx.o
> +obj-$(CONFIG_TOUCHSCREEN_W90X900)	+= w90p910_ts.o
> diff -Npur linux-2.6.29/drivers/input/touchscreen/w90p910_ts.c linux-2.6.30/drivers/input/touchscreen/w90p910_ts.c
> --- linux-2.6.29/drivers/input/touchscreen/w90p910_ts.c	1970-01-01 08:00:00.000000000 +0800
> +++ linux-2.6.30/drivers/input/touchscreen/w90p910_ts.c	2009-05-09 08:48:01.000000000 +0800
> @@ -0,0 +1,279 @@
> +/*
> + * linux/driver/input/w90x900_ts.c

We prefer not to have file paths in comments.

> + *
> + * Copyright (c) 2008 Nuvoton technology corporation.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation;version 2 of the License.
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/io.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +
> +#include <mach/hardware.h>
> +
> +/*adc state define*/
> +#define NO_PRESS	0
> +#define START_READX	1
> +#define START_READY	2

That could probably be made an enum...

> +
> +/*adc controller bit define*/
> +#define ADC_DELAY	0xf00
> +#define ADC_DOWN	0x01
> +#define ADC_TSC_Y	(0x01<<8)
> +#define ADC_TSC_X	(0x00<<8)

Could we plerase have spaces around operations (like '0x01 << 8') - it
makes it easier to read. I thought checkpatch.pl warned about this, I
must be mistaken...

> +#define TSC_FOURWIRE	(~(0x03<<1))
> +#define ADC_CLK_EN	(0x01<<28)/*adc clock*/
> +#define ADC_READ_CON	(0x01<<12)
> +#define ADC_CONV	(0x01<<13)
> +#define ADC_SEMIAUTO	(0x01<<14)
> +#define ADC_WAITTRIG	(0x03<<14)
> +#define ADC_RST1	(0x01<<16)
> +#define ADC_RST0	(0x00<<16)
> +#define ADC_EN		(0x01<<17)
> +#define ADC_INT		(0x01<<18)
> +#define WT_INT		(0x01<<20)
> +#define ADC_INT_EN	(0x01<<21)
> +#define LVD_INT_EN	(0x01<<22)
> +#define WT_INT_EN	(0x01<<23)
> +#define ADC_DIV		(0x04<<1)/*div=6*/
> +
> +static DEFINE_SPINLOCK(touch_lock);

Since you have driver-specific structure this spinlock should go there
as well.

> +
> +struct ts_event {
> +	short pressure;

Not used anymore. Probably the whole structure is not needed anymore,
just move x and y into w90p910drv_ts.

> +	short x;
> +	short y;
> +};
> +
> +struct w90p910drv_ts {
> +	struct input_dev *input;
> +	struct timer_list timer;
> +	struct ts_event tc;
> +	unsigned int ts_state;
> +	int irq_num;
> +	int pendown;
> +	int clocken;
> +	void __iomem *ts_reg;
> +};
> +
> +static void new_data(struct w90p910drv_ts *w90p910_ts)

This should be called w90p910_report_event(). But I must say, I don't
see anything modifying tc.x and tc.y anywhere...

> +{
> +	struct input_dev *dev = w90p910_ts->input;
> +
> +	input_report_abs(dev, ABS_X, w90p910_ts->tc.x);
> +	input_report_abs(dev, ABS_Y, w90p910_ts->tc.y);
> +	input_report_key(dev, BTN_TOUCH, w90p910_ts->pendown);
> +	input_sync(dev);
> +}
> +
> +static void w90p910_ts_interrupt(struct w90p910drv_ts *w90p910_ts, int isTimer)

I don't see anything using isTimer flag.

> +{
> +	if ((__raw_readl(w90p910_ts->ts_reg)&WT_INT) && !w90p910_ts->ts_state) {
> +		w90p910_ts->pendown = 1;
> +		w90p910_ts->ts_state = START_READX;
> +		__raw_writel(ADC_TSC_X, w90p910_ts->ts_reg+0x04);
> +		__raw_writel((__raw_readl(w90p910_ts->ts_reg)|
> +			ADC_SEMIAUTO|ADC_INT_EN|ADC_CONV)&0xFF6F7FFF,

Still uses magic constants... what does 0xFF6F7FFF mean?

> +							w90p910_ts->ts_reg);
> +	} else {
> +		if (__raw_readl(w90p910_ts->ts_reg+0x04)&ADC_DOWN) {
> +			__raw_writel(ADC_TSC_X, w90p910_ts->ts_reg+0x04);
> +
> +			__raw_writel((__raw_readl(w90p910_ts->ts_reg)|
> +				ADC_SEMIAUTO|ADC_INT_EN|ADC_CONV)&0xFF7F7FFF,
> +							w90p910_ts->ts_reg);
> +			w90p910_ts->ts_state = START_READX;
> +			w90p910_ts->pendown = 1;
> +		} else {
> +			__raw_writel((__raw_readl(w90p910_ts->ts_reg)|
> +				ADC_WAITTRIG|WT_INT_EN)&0xFFCBFFFF,
> +							w90p910_ts->ts_reg);
> +			w90p910_ts->ts_state = NO_PRESS;
> +			w90p910_ts->pendown = 0;
> +		}
> +	}
> +
> +	if ((__raw_readl(w90p910_ts->ts_reg)&ADC_INT) &&
> +					w90p910_ts->ts_state == START_READX) {
> +		w90p910_ts->ts_state = START_READY;
> +		__raw_writel(ADC_TSC_Y, w90p910_ts->ts_reg+0x04);
> +		__raw_writel((__raw_readl(w90p910_ts->ts_reg)|
> +			ADC_SEMIAUTO|ADC_INT_EN|ADC_CONV)&0xFF7B7FFF,
> +							w90p910_ts->ts_reg);
> +	}
> +
> +	if ((__raw_readl(w90p910_ts->ts_reg)&ADC_INT) &&
> +					w90p910_ts->ts_state == START_READY) {
> +		new_data(w90p910_ts);

Hm, why do you wait till here to call new_data()? Why can't you do it
right where you set w90p910_ts->ts_state = START_READY? I guess I am
having hard tome figuring out how the device is supposed to work...

> +		__raw_writel((__raw_readl(w90p910_ts->ts_reg)|
> +				ADC_WAITTRIG)&0xFF5BFFFF, w90p910_ts->ts_reg);
> +		mod_timer(&w90p910_ts->timer, jiffies + 4*HZ / 100);

please use msecs_to_jiffies() here, otheriwse you won't get the delay
you expected if HZ value changes.


> +	}
> +}
> +
> +static void w90p910_ts_timer(unsigned long data)
> +{
> +	struct w90p910drv_ts *w90p910_data = (struct w90p910drv_ts *) data;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&touch_lock, flags);
> +
> +	w90p910_ts_interrupt(w90p910_data, 1);
> +
> +	spin_unlock_irqrestore(&touch_lock, flags);
> +}
> +
> +static irqreturn_t ts_interrupt(int irq, void *dev_id)
> +{
> +	struct w90p910drv_ts *w90p910_data = dev_id;
> +
> +	w90p910_ts_interrupt(w90p910_data, 0);
> +	return IRQ_HANDLED;
> +}
> +
> +static int __devinit w90x900ts_probe(struct platform_device *pdev)
> +{
> +	struct w90p910drv_ts *w90p910_ts;
> +	struct input_dev *input_dev;
> +	int err = -ENOMEM;
> +	struct resource *res;
> +
> +	w90p910_ts = kzalloc(sizeof(struct w90p910drv_ts), GFP_KERNEL);
> +	input_dev = input_allocate_device();
> +	if (!w90p910_ts || !input_dev)
> +		goto fail1;
> +
> +	platform_set_drvdata(pdev, w90p910_ts);
> +
> +	w90p910_ts->input = input_dev;
> +
> +	init_timer(&w90p910_ts->timer);
> +	w90p910_ts->timer.data = (unsigned long) w90p910_ts;
> +	w90p910_ts->timer.function = w90p910_ts_timer;

setup_timer().

> +
> +	w90p910_ts->ts_state = NO_PRESS;
> +	w90p910_ts->clocken = (int)W90X900_VA_CLKPWR;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		err = -ENXIO;
> +		goto fail1;
> +	}
> +
> +	if (!request_mem_region(res->start, res->end - res->start + 1,
> +				pdev->name)) {
> +		err = -EBUSY;
> +		goto fail1;
> +	}
> +
> +	w90p910_ts->ts_reg = ioremap(res->start, res->end - res->start + 1);
> +	if (!w90p910_ts->ts_reg) {
> +		err = -ENOMEM;
> +		goto fail2;
> +	}
> +
> +	/* enable the ADC clock */
> +	__raw_writel(__raw_readl(w90p910_ts->clocken)|ADC_CLK_EN,
> +						w90p910_ts->clocken);
> +
> +	input_dev->name = "W90P910 TouchScreen";
> +	input_dev->phys = "w90p910ts/event0";
> +	input_dev->id.bustype = BUS_HOST;
> +	input_dev->id.vendor 	= 0x0005;
> +	input_dev->id.product = 0x0001;
> +	input_dev->id.version = 0x0100;
> +	input_dev->dev.parent = &pdev->dev;
> +	input_dev->evbit[0] = BIT_MASK(EV_KEY)|
> +				BIT_MASK(EV_ABS) | BIT_MASK(EV_SYN);
> +	input_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> +
> +	input_set_abs_params(input_dev, ABS_X, 0, 0x400, 0, 0);
> +	input_set_abs_params(input_dev, ABS_Y, 0, 0x400, 0, 0);
> +
> +	w90p910_ts->irq_num = platform_get_irq(pdev, 0);
> +	if (request_irq(w90p910_ts->irq_num, ts_interrupt, IRQF_DISABLED,
> +						"w90p910ts", w90p910_ts)) {
> +		err = -EBUSY;
> +		goto fail3;
> +	}
> +
> +	err = input_register_device(w90p910_ts->input);
> +	if (err)
> +		goto fail4;
> +
> +	__raw_writel(ADC_RST1, w90p910_ts->ts_reg);
> +	udelay(1000);

msleep() instead?

> +	__raw_writel(ADC_RST0, w90p910_ts->ts_reg);
> +	udelay(1000);

Same here.

> +
> +	/* set delay and screen type */
> +	__raw_writel(__raw_readl(w90p910_ts->ts_reg+0x04) & TSC_FOURWIRE,
> +						(w90p910_ts->ts_reg+0x04));
> +	__raw_writel(ADC_DELAY, (w90p910_ts->ts_reg+0x08));
> +	/* waitting for trigger mode */
> +	__raw_writel((__raw_readl(w90p910_ts->ts_reg)|
> +		ADC_WAITTRIG|ADC_DIV|ADC_EN|WT_INT_EN) & 0xFFEBFF09,
> +							w90p910_ts->ts_reg);
> +	return 0;
> +
> +fail4:	free_irq(w90p910_ts->irq_num, w90p910_ts);
> +fail3:	iounmap(w90p910_ts->ts_reg);
> +fail2:	release_mem_region(res->start, res->end - res->start + 1);
> +fail1:	input_free_device(input_dev);
> +	kfree(w90p910_ts);
> +	return err;
> +}
> +
> +static int __devexit w90x900ts_remove(struct platform_device *pdev)
> +{
> +	struct w90p910drv_ts *w90p910_ts = platform_get_drvdata(pdev);
> +	struct resource *res;
> +
> +	free_irq(w90p910_ts->irq_num, w90p910_ts);
> +	del_timer_sync(&w90p910_ts->timer);
> +	iounmap(w90p910_ts->ts_reg);
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	release_mem_region(res->start, res->end - res->start + 1);
> +
> +	input_unregister_device(w90p910_ts->input);
> +	kfree(w90p910_ts);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver w90x900ts_driver = {
> +	.probe		= w90x900ts_probe,
> +	.remove		= __devexit_p(w90x900ts_remove),
> +	.driver		= {
> +		.name	= "w90x900-ts",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init w90x900ts_init(void)
> +{
> +	return platform_driver_register(&w90x900ts_driver);
> +}
> +
> +static void __exit w90x900ts_exit(void)
> +{
> +	platform_driver_unregister(&w90x900ts_driver);
> +}
> +
> +module_init(w90x900ts_init);
> +module_exit(w90x900ts_exit);
> +
> +MODULE_AUTHOR("Wan ZongShun <mcuos.com@gmail.com>");
> +MODULE_DESCRIPTION("w90p910 touch screen driver!");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:w90p910-ts");

Thanks!

-- 
Dmitry
