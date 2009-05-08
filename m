From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add support for touch screen on W90P910 ARM platform
Date: Thu, 7 May 2009 20:41:51 -0700
Message-ID: <20090508034148.GF30616@dtor-d630.eng.vmware.com>
References: <e68bb3470904270803q5e69a5f4n74ff58848f397f28@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:56667 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752351AbZEHDmA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2009 23:42:00 -0400
Received: by rv-out-0506.google.com with SMTP id f9so925439rvb.1
        for <linux-input@vger.kernel.org>; Thu, 07 May 2009 20:42:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <e68bb3470904270803q5e69a5f4n74ff58848f397f28@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

On Mon, Apr 27, 2009 at 11:03:20PM +0800, Wan ZongShun wrote:
> Dear sirs,
> 
> The patch adds this  touch screen  driver to w90p910 ARM  platform.
> It is based on version of 2.6.30-rc3.
> would you please give me some advice about this patch?
> 

Thank you very much for your patch. Some comments below.

>  arch/arm/mach-w90x900/include/mach/regs-adc.h |   57 +++
>  drivers/input/touchscreen/Kconfig             |    6
>  drivers/input/touchscreen/Makefile            |    1
>  drivers/input/touchscreen/w90p910_ts.c        |  229 ++++++++++++++++
>  4 files changed, 293 insertions(+)
> ---
> Add this touch screen driver c file for W90P910 platform.
> It is only one part of patch,the other such as maping,
> device register will be submitted soon after.
> 
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> 
> diff -Npur linux-2.6.29/arch/arm/mach-w90x900/include/mach/regs-adc.h
> linux-2.6.30-rc3/arch/arm/mach-w90x900/include/mach/regs-adc.h
> --- linux-2.6.29/arch/arm/mach-w90x900/include/mach/regs-adc.h  1970-01-01
> 08:00:00.000000000 +0800
> +++ linux-2.6.30-rc3/arch/arm/mach-w90x900/include/mach/regs-adc.h
>  2009-04-27
> 20:53:57.000000000 +0800
> @@ -0,0 +1,57 @@
> +/*
> + * arch/arm/mach-w90x900/include/mach/regs-adc.h
> + *
> + * Copyright (c) 2008 Nuvoton technology corporation
> + * All rights reserved.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + */
> +
> +#ifndef __ASM_ARM_REGS_ADC_H
> +#define __ASM_ARM_REGS_ADC_H
> +
> +/* ADC Control Registers */
> +#define ADC_BA         W90X900_VA_ADC
> +#define REG_ADC_CON    (ADC_BA+0x00)
> +#define REG_ADC_TSC    (ADC_BA+0x04)
> +#define REG_ADC_DLY    (ADC_BA+0x08)
> +#define REG_ADC_XDATA  (ADC_BA+0x0C)
> +#define REG_ADC_YDATA  (ADC_BA+0x10)
> +#define REG_ADC_LV_CON (ADC_BA+0x14)
> +#define REG_ADC_LV_STS (ADC_BA+0x18)
> +#define ADC_INT                0x040000
> +#define WT_INT         0x100000
> +#define ADC_RESOULTION 1024
> +
> +#define ADC_WRITE(addr, val)   __raw_writel(val, addr)
> +#define ADC_READ(addr)         __raw_readl(addr)
> +#define DEV_NAME               "ADC"
> +
> +#define TSDEV_SCREEN_X         320
> +#define TSDEV_SCREEN_Y         240
> +
> +unsigned int  INTERVAL_TIME = 4;
> +unsigned int  pre_x, pre_y, STATE;
> +unsigned int  nRadioWidth1, nRadioWidth2, nRadioHeight1, nRadioHeight2;
> +int adc_get = 0, adc_block = 1;
> +
> +static struct input_dev *w90p910_dev;
> +static DECLARE_MUTEX(sem);
> +static DEFINE_SPINLOCK(w90x900_touch_lock);
> +static struct timer_list ts_timer1;
> +

All of this does not belong in a header file.

> +struct _pointmap{
> +       int x;
> +       int y;
> +       int status;
> +};
> +
> +struct _pointmap point;
> +
> +#endif/*__ASM_ARM_REGS_ADC_H*/
> diff -Npur linux-2.6.29/drivers/input/touchscreen/Kconfig
> linux-2.6.30-rc3/drivers/input/touchscreen/Kconfig
> --- linux-2.6.29/drivers/input/touchscreen/Kconfig      2009-04-27
> 14:10:36.000000000 +0800
> +++ linux-2.6.30-rc3/drivers/input/touchscreen/Kconfig  2009-04-27
> 19:50:36.000000000 +0800
> @@ -466,4 +466,10 @@ config TOUCHSCREEN_TSC2007
>          To compile this driver as a module, choose M here: the
>          module will be called tsc2007.
> 
> +config TOUCHSCREEN_W90X900
> +       tristate "W90P910 touchscreens"
> +       depends on CPU_W90P910
> +       help
> +               Compile this driver to support W90P910 touchscreen.
> +
>  endif
> diff -Npur linux-2.6.29/drivers/input/touchscreen/Makefile
> linux-2.6.30-rc3/drivers/input/touchscreen/Makefile
> --- linux-2.6.29/drivers/input/touchscreen/Makefile     2009-04-27
> 14:10:36.000000000 +0800
> +++ linux-2.6.30-rc3/drivers/input/touchscreen/Makefile 2009-04-27
> 19:50:49.000000000 +0800
> @@ -37,3 +37,4 @@ wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9712)        +
>  wm97xx-ts-$(CONFIG_TOUCHSCREEN_WM9713) += wm9713.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_MAINSTONE)     += mainstone-wm97xx.o
>  obj-$(CONFIG_TOUCHSCREEN_WM97XX_ZYLONITE)      += zylonite-wm97xx.o
> +obj-$(CONFIG_TOUCHSCREEN_W90X900)      += w90p910_ts.o
> diff -Npur linux-2.6.29/drivers/input/touchscreen/w90p910_ts.c
> linux-2.6.30-rc3/drivers/input/touchscreen/w90p910_ts.c
> --- linux-2.6.29/drivers/input/touchscreen/w90p910_ts.c 1970-01-01
> 08:00:00.000000000 +0800
> +++ linux-2.6.30-rc3/drivers/input/touchscreen/w90p910_ts.c     2009-04-27
> 20:55:21.000000000 +0800
> @@ -0,0 +1,229 @@
> +/*
> + * linux/driver/input/w90x900_ts.c
> + *
> + * Copyright (c) 2008 Nuvoton technology corporation
> + * All rights reserved.
> + *
> + * Wan ZongShun <mcuos.com@gmail.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
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
> +#include <mach/regs-clock.h>
> +#include <mach/regs-adc.h>
> +
> +short ADCDataIn(void)

No camel-case in the kernel, please.

> +{
> +       pre_x = ((ADC_READ(REG_ADC_XDATA)*TSDEV_SCREEN_X)/ADC_RESOULTION);
> +       pre_y = ((ADC_READ(REG_ADC_YDATA)*TSDEV_SCREEN_Y)/ADC_RESOULTION);

Why do we need to scale?

> +
> +       input_report_key(w90p910_dev, BTN_TOUCH, 1);
> +       input_report_abs(w90p910_dev, ABS_X, pre_x);
> +       input_report_abs(w90p910_dev, ABS_Y, pre_y);
> +       input_report_abs(w90p910_dev, ABS_PRESSURE, 1000);

If your device does not provide true pressure readings to not fake them.

> +       input_sync(w90p910_dev);
> +       return 0;
> +}
> +
> +static void wb_sensitivity(unsigned long  sensi)
> +{
> +       unsigned long flags;
> +       down_interruptible(&sem);
> +       spin_lock_irqsave(&w90x900_touch_lock, flags);
> +
> +       if ((ADC_READ(REG_ADC_TSC)&0x1) == 0x1) {
> +
> +               ADC_WRITE(REG_ADC_TSC, 0x0);
> +               ADC_WRITE(REG_ADC_CON, (ADC_READ(REG_ADC_CON)|
> +                                               0x00206000)&0xFF7F7FFF);
> +               STATE = 1;
> +       } else{
> +               input_sync(w90p910_dev);

You should report events, then issue EV_SYN, not the other way around.

> +               input_report_key(w90p910_dev, BTN_TOUCH, 0);
> +               input_report_abs(w90p910_dev, ABS_PRESSURE, 0);
> +               ADC_WRITE(REG_ADC_CON, (ADC_READ(REG_ADC_CON)|
> +                                               0x0080C000)&0xFFCBFFFF);
> +               STATE = 0;
> +               point.status = 0;
> +       }
> +       up(&sem);
> +       spin_unlock_irqrestore(&w90x900_touch_lock, flags);
> +}
> +
> +static irqreturn_t wb_adc_irq(int irq, void *dev_id)
> +{
> +       unsigned long flags;
> +
> +       down_interruptible(&sem);

Down_interruptible in an IRQ context? That is... interesting...

> +       spin_lock_irqsave(&w90x900_touch_lock, flags);
> +       adc_get = 1;
> +
> +       if (((ADC_READ(REG_ADC_CON)&WT_INT)>>20) == 1 && STATE == 0) {
> +               STATE = 1;
> +               ADC_WRITE(REG_ADC_TSC, 0x0);
> +               ADC_WRITE(REG_ADC_CON, (ADC_READ(REG_ADC_CON)|
> +                                               0x00206000)&0xFF6F7FFF);

Magic values... Can we have proper #defines here?

> +       }
> +
> +       if (((ADC_READ(REG_ADC_CON)&ADC_INT)>>18) == 1 && STATE == 1) {
> +               STATE = 2;
> +               ADC_WRITE(REG_ADC_TSC, 0x100);
> +               ADC_WRITE(REG_ADC_CON, (ADC_READ(REG_ADC_CON)|
> +                                               0x00206000)&0xFF7B7FFF);
> +       }
> +
> +       if (((ADC_READ(REG_ADC_CON)&ADC_INT)>>18) == 1 && STATE == 2) {
> +               ADCDataIn();
> +               point.status = 1;
> +               ADC_WRITE(REG_ADC_CON, (ADC_READ(REG_ADC_CON)|
> +                                               0x0000C000)&0xFF5BFFFF);
> +
> +               del_timer(&ts_timer1);
> +               ts_timer1.expires = jiffies+INTERVAL_TIME;
> +               ts_timer1.data = 0UL;
> +               add_timer(&ts_timer1);

This can be exprerssed as mod_timer().

> +
> +       }
> +       up(&sem);
> +       spin_unlock_irqrestore(&w90x900_touch_lock, flags);
> +       return IRQ_HANDLED;
> +}
> +
> +static int wb_adc_open(struct input_dev *dev)
> +{
> +
> +       adc_block = 1;
> +       adc_get = 1;
> +       init_timer(&ts_timer1);
> +       ts_timer1.function = wb_sensitivity;
> +       /* reset */
> +       ADC_WRITE(REG_ADC_CON, 0x00010000);
> +       udelay(1000);
> +       ADC_WRITE(REG_ADC_CON, 0x00000000);
> +       udelay(1000);
> +       /* ADC setting */
> +       /* set delay and screen type */
> +       ADC_WRITE(REG_ADC_TSC, ADC_READ(REG_CLKSEL) & 0xFFFFFFF9);
> +       ADC_WRITE(REG_ADC_DLY, 0xF00);
> +       /* waitting for trigger mode */
> +       ADC_WRITE(REG_ADC_CON, (ADC_READ(REG_ADC_CON)|
> +                                       0x0082C008) & 0xFFEBFF09);
> +       STATE = 0;
> +       pre_x = pre_y = 0;
> +       return 0;
> +}
> +
> +static void  wb_adc_close(struct input_dev *dev)
> +{
> +       free_irq(IRQ_ADC, NULL);

Uh-oh... What will happen if we try to open the device again? Don't free
IRQ here, do that in w90x900ts_remove().

> +}
> +
> +static int __init w90x900ts_probe(struct platform_device *pdev)

__devinit.

> +{
> +       int irq, result, err;
> +       unsigned int tmp32;
> +       struct resource *res;

Blank line after declarations.

> +       irq = platform_get_irq(pdev, 0);
> +       if (irq < 0) {
> +               dev_err(&pdev->dev, "no irq for device\n");
> +               return -ENOENT;
> +       }
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -ENXIO;
> +
> +       if (!request_mem_region(res->start, res->end - res->start + 1,
> +                               pdev->name)) {
> +               dev_err(&pdev->dev, "Memory region busy\n");
> +               err = -EBUSY;
> +               goto fail;
> +       }
> +
> +       /* enable the ADC clock */
> +       tmp32 = ADC_READ(REG_CLKEN);
> +       tmp32 = tmp32 | 0x10000000;
> +       ADC_WRITE(REG_CLKEN, tmp32);
> +
> +       w90p910_dev = input_allocate_device();
> +
> +       if (!w90p910_dev) {
> +               printk(KERN_ERR "w90p910_dev: not enough memory\n");
> +               err = -ENOMEM;
> +               goto fail;

'fail' does not free the memory region you requested though...

> +       }
> +
> +       w90p910_dev->name = "W90P910 TouchScreen";
> +       w90p910_dev->phys = "input/event0";

Umm, not specific enough for 'phys'... "w90p910_ts/input0" maybe?

> +       w90p910_dev->id.bustype = BUS_HOST;
> +       w90p910_dev->id.vendor  = 0x0005;
> +       w90p910_dev->id.product = 0x0001;
> +       w90p910_dev->id.version = 0x0100;

w90p910_dev->dev.parent = &pdev->dev;

> +
> +       w90p910_dev->open  = wb_adc_open;
> +       w90p910_dev->close = wb_adc_close;
> +
> +       w90p910_dev->evbit[0] = BIT_MASK(EV_KEY)|
> +                               BIT_MASK(EV_ABS) | BIT_MASK(EV_SYN);
> +       w90p910_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> +
> +       input_set_abs_params(w90p910_dev, ABS_X, 0, 0x400, 0, 0);
> +       input_set_abs_params(w90p910_dev, ABS_Y, 0, 0x400, 0, 0);
> +       input_set_abs_params(w90p910_dev, ABS_PRESSURE, 0, 1000, 0, 0);
> +
> +       result = request_irq(irq, wb_adc_irq, IRQF_DISABLED, DEV_NAME, NULL);
> +       if (result != 0)
> +               printk(KERN_ERR"register the wb_adc_irq failed!\n");

And..? Do we really want to continue?

> +
> +       input_register_device(w90p910_dev);

Error handling please.

> +       return 0;
> +
> +fail:
> +       input_free_device(w90p910_dev);
> +       return err;
> +}
> +
> +static int w90x900ts_remove(struct platform_device *pdev)

__devexit

> +{
> +

Extra blank line

> +       input_unregister_device(w90p910_dev);
> +       return 0;
> +}
> +
> +static struct platform_driver w90x900ts_driver = {
> +       .probe          = w90x900ts_probe,
> +       .remove         = w90x900ts_remove,

__devexit_p()

> +       .driver         = {
> +               .name   = "w90x900-ts",
> +               .owner  = THIS_MODULE,
> +       },
> +};
> +
> +int __init w90x900ts_init(void)

static

> +{
> +       return platform_driver_register(&w90x900ts_driver);
> +}
> +
> +static void __exit w90x900ts_exit(void)
> +{
> +       platform_driver_unregister(&w90x900ts_driver);
> +}
> +
> +module_init(w90x900ts_init);
> +module_exit(w90x900ts_exit);
> +
> +MODULE_AUTHOR("PT50 zswan <mcuos.com@gmail.com>");
> +MODULE_DESCRIPTION("w90p910 touch screen driver!");
> +MODULE_LICENSE("GPL");
> 

Also, please run the patch through scripts/checkpatch.pl and make sure
it does not complain. Thanks!

-- 
Dmitry
