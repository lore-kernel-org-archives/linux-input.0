From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH v5 1/3] ARM: SAMSUNG: Add keypad device support
Date: Mon, 21 Jun 2010 20:21:20 +0900
Message-ID: <4C1F4B30.3020006@samsung.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
 <AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:63992 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab0FULVU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 07:21:20 -0400
In-reply-to: <AANLkTil1aiJ1gu6jRrO4LeB0fYltOq4A3wXJJB1ZOa8q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-samsung-soc@vger.kernel.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 6/21/2010 6:05 PM, Eric Miao wrote:
> On Mon, Jun 21, 2010 at 2:26 PM, Joonyoung Shim <jy0922.shim@samsung.com> wrote:
>> This patch adds samsung keypad device definition for samsung cpus.
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>>  arch/arm/plat-samsung/Kconfig                    |    5 ++
>>  arch/arm/plat-samsung/Makefile                   |    1 +
>>  arch/arm/plat-samsung/dev-keypad.c               |   58 +++++++++++++++++++++
> 
> Why need an individual file for a simple device?  In the end, these files
> will flood over the plat-samsung/ directory. And now think this - in your
> new SoC design ,the keypad IP is replaced with a completely new one, does
> that mean a new dev-keypad-new1.c, dev-keypad-new2.c?
> 
> I personally prefer a single devices.c for all the devices, if you
> orgnize well, shouldn't take up much code size in that single file.
> 

I know, but will need more effort of other device as well as keypad to
do it.

>>  arch/arm/plat-samsung/include/plat/devs.h        |    2 +
>>  arch/arm/plat-samsung/include/plat/keypad.h      |   59 ++++++++++++++++++++++
>>  arch/arm/plat-samsung/include/plat/regs-keypad.h |   49 ++++++++++++++++++
> 
> Will these registers be used elsewhere except within the keypad driver?
> If no, they might be better moved to the keypad driver itself, it makes
> the driver more self-contained and avoid the registers being accessed
> anywhere.
> 

Right, these registers are used only in the keypad driver. I think it's 
possible.

>>  6 files changed, 174 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/plat-samsung/dev-keypad.c
>>  create mode 100644 arch/arm/plat-samsung/include/plat/keypad.h
>>  create mode 100644 arch/arm/plat-samsung/include/plat/regs-keypad.h
>>
>> diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
>> index 2753fb3..bd007e3 100644
>> --- a/arch/arm/plat-samsung/Kconfig
>> +++ b/arch/arm/plat-samsung/Kconfig
>> @@ -227,6 +227,11 @@ config SAMSUNG_DEV_TS
>>        help
>>            Common in platform device definitions for touchscreen device
>>
>> +config SAMSUNG_DEV_KEYPAD
>> +       bool
>> +       help
>> +         Compile in platform device definitions for keypad
>> +
>>  # DMA
>>
>>  config S3C_DMA
>> diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
>> index b1d82cc..8269d80 100644
>> --- a/arch/arm/plat-samsung/Makefile
>> +++ b/arch/arm/plat-samsung/Makefile
>> @@ -48,6 +48,7 @@ obj-$(CONFIG_S3C_DEV_RTC)     += dev-rtc.o
>>
>>  obj-$(CONFIG_SAMSUNG_DEV_ADC)  += dev-adc.o
>>  obj-$(CONFIG_SAMSUNG_DEV_TS)   += dev-ts.o
>> +obj-$(CONFIG_SAMSUNG_DEV_KEYPAD)       += dev-keypad.o
>>
>>  # DMA support
>>
>> diff --git a/arch/arm/plat-samsung/dev-keypad.c b/arch/arm/plat-samsung/dev-keypad.c
>> new file mode 100644
>> index 0000000..679b444
>> --- /dev/null
>> +++ b/arch/arm/plat-samsung/dev-keypad.c
>> @@ -0,0 +1,58 @@
>> +/*
>> + * linux/arch/arm/plat-samsung/dev-keypad.c
>> + *
>> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
>> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
>> + *
>> + *  This program is free software; you can redistribute  it and/or modify it
>> + *  under  the terms of  the GNU General  Public License as published by the
>> + *  Free Software Foundation;  either version 2 of the  License, or (at your
>> + *  option) any later version.
>> + *
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include <mach/irqs.h>
>> +#include <mach/map.h>
>> +#include <plat/cpu.h>
>> +#include <plat/devs.h>
>> +#include <plat/keypad.h>
>> +
>> +static struct resource samsung_keypad_resources[] = {
>> +       [0] = {
>> +               .start  = SAMSUNG_PA_KEYPAD,
>> +               .end    = SAMSUNG_PA_KEYPAD + 0x20 - 1,
>> +               .flags  = IORESOURCE_MEM,
>> +       },
>> +       [1] = {
>> +               .start  = IRQ_KEYPAD,
>> +               .end    = IRQ_KEYPAD,
>> +               .flags  = IORESOURCE_IRQ,
>> +       },
>> +};
>> +
>> +struct platform_device samsung_device_keypad = {
>> +       .name           = "samsung-keypad",
>> +       .id             = -1,
>> +       .num_resources  = ARRAY_SIZE(samsung_keypad_resources),
>> +       .resource       = samsung_keypad_resources,
>> +};
>> +
>> +void __init samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd)
>> +{
>> +       struct samsung_keypad_platdata *npd;
>> +
>> +       if (!pd) {
>> +               printk(KERN_ERR "%s: no platform data\n", __func__);
>> +               return;
>> +       }
>> +
>> +       npd = kmemdup(pd, sizeof(struct samsung_keypad_platdata), GFP_KERNEL);
>> +       if (!npd)
>> +               printk(KERN_ERR "%s: no memory for platform data\n", __func__);
> 
> This part of the code is actually duplicated again and again and again
> for each device, PXA and other legacy platforms are bad references for
> this. In arch/arm/mach-mmp/, it might be a bit cleaner, there are three
> major points:
> 

I know ben posted patches to remove duplicated codes such this.
http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg01474.html

>  1. A minimum 'struct pxa_device_desc' for a simple description of a
>     device (more than 90% of the devices can be described that way),
>     and avoid using a comparatively heavier weight platform_device,
>     which can be generated at run-time
> 
>  2. pxa_register_device() to allocate and register the platform_device
>     at run-time, along with the platform data
> 
>  3. pxa168_add_*() as a consistent/clearly named API, and with type
>     checking for the platform_data type (it's a bit difficult to check
>     type in pxa_register_device())
> 
> Just for your reference.
> 
>> +
>> +       if (!npd->cfg_gpio)
>> +               npd->cfg_gpio = samsung_keypad_cfg_gpio;
> 
> More and more platforms are moving their IO-mux to a static descriptive
> array and have some API to configure. E.g. PXA, Orion/Kirkwood, iMX....
> The idea basically is:
> 
>   1) IO-Mux and the internal peripheral controller are conceptually
>      separate entities (the extreme case is the internal peripheral
>      controller can function normally even without IO-mux being setup
>      correct, only that signals not proplery routed in/out)
> 
>   2) IO-mux should be configured before the peripheral drivers are
>      ready to go (there are cases that IO-mux will have to be changed
>      at run-time, so IO-mux API should be able to handle that, though
>      such cases are rare)
> 
>   3) Peripheral drivers should not be concerned with IO-mux config
> 
> Not sure though how the IO-mux is designed in S5P, so treat the above
> as reference only.
> 

Hmm... i think it don't care to go to above reference.
Ben, what do you think about this?

>> +
>> +       samsung_device_keypad.dev.platform_data = npd;
>> +}
>> diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
>> index e6144e4..6d9f01b 100644
>> --- a/arch/arm/plat-samsung/include/plat/devs.h
>> +++ b/arch/arm/plat-samsung/include/plat/devs.h
>> @@ -100,6 +100,8 @@ extern struct platform_device s5pc100_device_iis0;
>>  extern struct platform_device s5pc100_device_iis1;
>>  extern struct platform_device s5pc100_device_iis2;
>>
>> +extern struct platform_device samsung_device_keypad;
>> +
>>  /* s3c2440 specific devices */
>>
>>  #ifdef CONFIG_CPU_S3C2440
>> diff --git a/arch/arm/plat-samsung/include/plat/keypad.h b/arch/arm/plat-samsung/include/plat/keypad.h
>> new file mode 100644
>> index 0000000..6d139d6
>> --- /dev/null
>> +++ b/arch/arm/plat-samsung/include/plat/keypad.h
>> @@ -0,0 +1,59 @@
>> +/*
>> + * linux/arch/arm/plat-samsung/include/plat/keypad.h
>> + *
>> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
>> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
>> + *
>> + * Samsung Platform - Keypad platform data definitions
>> + *
>> + *  This program is free software; you can redistribute  it and/or modify it
>> + *  under  the terms of  the GNU General  Public License as published by the
>> + *  Free Software Foundation;  either version 2 of the  License, or (at your
>> + *  option) any later version.
>> + *
>> + */
>> +
>> +#ifndef __PLAT_SAMSUNG_KEYPAD_H
>> +#define __PLAT_SAMSUNG_KEYPAD_H
>> +
>> +#include <linux/input/matrix_keypad.h>
>> +
>> +#define SAMSUNG_MAX_ROWS       8
>> +#define SAMSUNG_MAX_COLS       8
>> +
>> +/**
>> + * struct samsung_keypad_platdata - Platform device data for Samsung Keypad.
>> + * @keymap_data: pointer to &matrix_keymap_data.
>> + * @rows: number of keypad row supported.
>> + * @cols: number of keypad col supported.
>> + * @no_autorepeat: disable key autorepeat.
>> + * @wakeup: controls whether the device should be set up as wakeup source.
>> + * @cfg_gpio: configure the GPIO.
>> + *
>> + * Initialisation data specific to either the machine or the platform
>> + * for the device driver to use or call-back when configuring gpio.
>> + */
>> +struct samsung_keypad_platdata {
>> +       const struct matrix_keymap_data *keymap_data;
>> +       unsigned int            rows;
>> +       unsigned int            cols;
>> +       bool                    no_autorepeat;
>> +       bool                    wakeup;
>> +
>> +       void    (*cfg_gpio)(unsigned int rows, unsigned int cols);
>> +};
> 
> Why are you calling everything samsung_this, samsung_that? Now think about:
> 
>   1. Is this keypad applicable to all Samsung silicon?
>   2. Samsung has a new IP for the keypad, now what? samsung_new_keypad_platdata?
> 
> s5p_keypad sounds more reasable to me if it's applicable to all the s5p
> series. Now I also doubt that's the case. So normally, we will name it
> after the first silicon where this IP appears, e.g.
> 
>   s5pc100_keypad
> 
> and now in s5pc200 code, you can also register/re-use the s5pc100_keypad
> device/driver, and everyone knows - OK, the IP on S5PC100 is now re-used
> here.
> 

This is naming issue and i know it was not desided yet. 
This keypad driver can support s3c64xx, s5pc100, s5pc110, s5pv210. 

>> +
>> +/**
>> + * samsung_keypad_set_platdata - Set platform data for Samsung Keypad device.
>> + * @pd: Platform data to register to device.
>> + *
>> + * Register the given platform data for use with Samsung Keypad device.
>> + * The call will copy the platform data, so the board definitions can
>> + * make the structure itself __initdata.
>> + */
>> +extern void samsung_keypad_set_platdata(struct samsung_keypad_platdata *pd);
>> +
>> +/* defined by architecture to configure gpio. */
>> +extern void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols);
>> +
>> +#endif /* __PLAT_SAMSUNG_KEYPAD_H */
>> diff --git a/arch/arm/plat-samsung/include/plat/regs-keypad.h b/arch/arm/plat-samsung/include/plat/regs-keypad.h
>> new file mode 100644
>> index 0000000..e4688f0
>> --- /dev/null
>> +++ b/arch/arm/plat-samsung/include/plat/regs-keypad.h
>> @@ -0,0 +1,49 @@
>> +/*
>> + * linux/arch/arm/plat-samsung/include/plat/regs-keypad.h
>> + *
>> + * Copyright (C) 2010 Samsung Electronics Co.Ltd
>> + * Author: Joonyoung Shim <jy0922.shim@samsung.com>
>> + *
>> + *  This program is free software; you can redistribute  it and/or modify it
>> + *  under  the terms of  the GNU General  Public License as published by the
>> + *  Free Software Foundation;  either version 2 of the  License, or (at your
>> + *  option) any later version.
>> + *
>> + */
>> +
>> +#ifndef __SAMSUNG_KEYPAD_H__
>> +#define __SAMSUNG_KEYPAD_H__
>> +
>> +#define SAMSUNG_KEYIFCON                       0x00
>> +#define SAMSUNG_KEYIFSTSCLR                    0x04
>> +#define SAMSUNG_KEYIFCOL                       0x08
>> +#define SAMSUNG_KEYIFROW                       0x0c
>> +#define SAMSUNG_KEYIFFC                                0x10
>> +
>> +/* SAMSUNG_KEYIFCON */
>> +#define SAMSUNG_KEYIFCON_INT_F_EN              (1 << 0)
>> +#define SAMSUNG_KEYIFCON_INT_R_EN              (1 << 1)
>> +#define SAMSUNG_KEYIFCON_DF_EN                 (1 << 2)
>> +#define SAMSUNG_KEYIFCON_FC_EN                 (1 << 3)
>> +#define SAMSUNG_KEYIFCON_WAKEUPEN              (1 << 4)
>> +
>> +/* SAMSUNG_KEYIFSTSCLR */
>> +#define SAMSUNG_KEYIFSTSCLR_P_INT_MASK         (0xff << 0)
>> +#define SAMSUNG_KEYIFSTSCLR_R_INT_MASK         (0xff << 8)
>> +#define SAMSUNG_KEYIFSTSCLR_R_INT_OFFSET       8
>> +#define S5PV210_KEYIFSTSCLR_P_INT_MASK         (0x3fff << 0)
>> +#define S5PV210_KEYIFSTSCLR_R_INT_MASK         (0x3fff << 16)
>> +#define S5PV210_KEYIFSTSCLR_R_INT_OFFSET       16
>> +
>> +/* SAMSUNG_KEYIFCOL */
>> +#define SAMSUNG_KEYIFCOL_MASK                  (0xff << 0)
>> +#define S5PV210_KEYIFCOLEN_MASK                        (0xff << 8)
>> +
>> +/* SAMSUNG_KEYIFROW */
>> +#define SAMSUNG_KEYIFROW_MASK                  (0xff << 0)
>> +#define S5PV210_KEYIFROW_MASK                  (0x3fff << 0)
>> +
>> +/* SAMSUNG_KEYIFFC */
>> +#define SAMSUNG_KEYIFFC_MASK                   (0x3ff << 0)
>> +
>> +#endif /* __SAMSUNG_KEYPAD_H__ */
>> --
>> 1.7.0.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

