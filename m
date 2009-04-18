From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH, v2] input/imx2x: generic keypad handler for i.MX SoCs
Date: Sat, 18 Apr 2009 16:27:39 +0200
Message-ID: <20090418142739.GC21747@pengutronix.de>
References: <200904171640.14294.hs4233@mail.mn-solutions.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55042 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756075AbZDRO1l (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Apr 2009 10:27:41 -0400
Content-Disposition: inline
In-Reply-To: <200904171640.14294.hs4233@mail.mn-solutions.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Holger Schurig <hs4233@mail.mn-solutions.de>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

Hi Holger,

On Fri, Apr 17, 2009 at 04:40:14PM +0200, Holger Schurig wrote:
> The i.MX21 SoC has a built-in keypad controller, which this driver
> utilizes. As the keypad usually doesn't connect to a standard PC
> keyboard, but to the keyboard of a PDA-like device, I wrote the
> driver in a keyboard-layout agnostic way.
> 
> Instead, the driver reports each row/column key press and release
> via a platform-data supplied function. Board-specific code can than
> decode the input events from this and submit them.
> 
> See the comments at the top of drivers/input/keyboard/mxc_keypad.c
> 
> Signed-off-by: Holger Schurig <hs4233@mail.mn-solutions.de>

Can you please split the mxc specific changes into a second patch? These
are likely leading to merge conflicts if they go via another tree.

Thanks
  Sascha


> 
> ---
> Changes from v1:
> * call release_mem_region() in error path
> * no IRQF_SAMPLE_RANDOM, input.c does it
> * removed input_free_device() after unregister_device()
> * added device_init_wakeup(&pdev->dev, 0) in remove path
>   (Thanks Trilok Soni)
> * added release_mem_region() to mxc_keypad_remove()
> * removed debugging call to mxc_keypad_open()
> 
> Changes from v2:
> * fixed clkdev name back, as input-devices don't register with a
>   stable device name
> 
> --- linux.orig/arch/arm/mach-mx2/devices.c
> +++ linux/arch/arm/mach-mx2/devices.c
> @@ -36,6 +36,7 @@
>  #include <mach/hardware.h>
>  #include <mach/common.h>
>  #include <mach/mmc.h>
> +#include <mach/mxc_keypad.h>
>  
>  #include "devices.h"
>  
> @@ -446,3 +447,31 @@
>  {
>  	return mxc_gpio_init(imx_gpio_ports, ARRAY_SIZE(imx_gpio_ports));
>  }
> +
> +#ifdef CONFIG_KEYBOARD_MXC
> +static struct resource mxc_resource_keypad[] = {
> +	[0] = {
> +		.start  = 0x10008000,
> +		.end    = 0x10008014,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start  = MXC_INT_KPP,
> +		.end    = MXC_INT_KPP,
> +		.flags  = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device mxc_device_keypad = {
> +	.name           = "mxc-keypad",
> +	.id             = -1,
> +	.resource       = mxc_resource_keypad,
> +	.num_resources  = ARRAY_SIZE(mxc_resource_keypad),
> +};
> +
> +struct mxc_keypad_platform_data;
> +void __init mxc_set_keypad_info(struct mxc_keypad_platform_data *info)
> +{
> +	mxc_register_device(&mxc_device_keypad, info);
> +}
> +#endif
> --- linux.orig/arch/arm/mach-mx2/devices.h
> +++ linux/arch/arm/mach-mx2/devices.h
> @@ -20,3 +20,4 @@
>  extern struct platform_device mxc_i2c_device1;
>  extern struct platform_device mxc_sdhc_device0;
>  extern struct platform_device mxc_sdhc_device1;
> +extern struct platform_device mxc_keypad;
> --- /dev/null
> +++ linux/arch/arm/plat-mxc/include/mach/mxc_keypad.h
> @@ -0,0 +1,20 @@
> +#ifndef __MACH_MXC_KEYPAD_H
> +#define __MACH_MXC_KEYPAD_H
> +
> +#include <linux/input.h>
> +
> +#define MAX_MATRIX_KEY_ROWS	(8)
> +#define MAX_MATRIX_KEY_COLS	(8)
> +
> +struct input_dev;
> +struct mxc_keypad_platform_data {
> +	u16 output_pins;
> +	u16 input_pins;
> +	void (*init)(struct input_dev *idev, struct platform_device *pdev);
> +	void (*exit)(struct platform_device *pdev);
> +	void (*handle_key)(struct input_dev *, int col, int row, int down);
> +};
> +
> +extern void mxc_set_keypad_info(struct mxc_keypad_platform_data *info);
> +
> +#endif
> --- linux.orig/drivers/input/keyboard/Kconfig
> +++ linux/drivers/input/keyboard/Kconfig
> @@ -250,6 +250,16 @@
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called jornada720_kbd.
>  
> +config KEYBOARD_MXC
> +	tristate "Freescale MXC/IMX keypad support"
> +	depends on ARCH_MXC
> +	help
> +	  Say Y here if you have a keypad connected to your MXC/i.MX
> +	  SoC. Note that you also need board-support for this.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called mxc_keypad.
> +
>  config KEYBOARD_OMAP
>  	tristate "TI OMAP keypad support"
>  	depends on (ARCH_OMAP1 || ARCH_OMAP2)
> --- linux.orig/drivers/input/keyboard/Makefile
> +++ linux/drivers/input/keyboard/Makefile
> @@ -18,6 +18,7 @@
>  obj-$(CONFIG_KEYBOARD_TOSA)		+= tosakbd.o
>  obj-$(CONFIG_KEYBOARD_HIL)		+= hil_kbd.o
>  obj-$(CONFIG_KEYBOARD_HIL_OLD)		+= hilkbd.o
> +obj-$(CONFIG_KEYBOARD_MXC)		+= mxc_keypad.o
>  obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-keypad.o
>  obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keypad.o
>  obj-$(CONFIG_KEYBOARD_PXA930_ROTARY)	+= pxa930_rotary.o
> --- /dev/null
> +++ linux/drivers/input/keyboard/mxc_keypad.c
> @@ -0,0 +1,395 @@
> +/*
> + * Driver for the i.MX/MXC matrix keyboard controller.
> + *
> + * Copyright (c) 2009 by Holger Schurig <hs4233@mail.mn-solutions.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +/*
> +
> +This driver is just a "generic" framework, it cannot produce input events on
> +it's own. That's because diverse board/devices have very different
> +keyboards (numeric, alphanumeric, cell phone like etc).
> +
> +Therefore, you'll do the actual scancode -> input event code conversion
> +in a function that you'll provide in your platform data:
> +
> +static struct mxc_keypad_platform_data tt8000_keypad_data = {
> +	.output_pins = 0x0f00,
> +	.input_pins  = 0x001f,
> +	.init        = tt8000_keypad_init,
> +	.exit        = tt8000_keypad_exit,
> +	.handle_key  = tt8000_keypad_key,
> +};
> +
> +static void tt8000_keypad_init(struct input_dev *input_dev,
> +	struct platform_device *pdev);
> +
> +This function is called before the input device registers, it can setup
> +primary/alternate GPIO functions and modify it, e.g. by setting
> +the propriate bits in input_dev->keybit.
> +
> +static void tt8000_keypad_exit(struct platform_device *pdev);
> +
> +The opposite function.
> +
> +static void tt8000_keypad_key(struct input_dev *input_dev,
> +	int row, int col, int down);
> +
> +Called for each key press or release event. Should determine
> +the input event code and sent it via input_report_key().
> +
> +*/
> +
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/input.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +
> +#include <asm/mach/arch.h>
> +#include <asm/mach/map.h>
> +
> +#include <mach/hardware.h>
> +#include <mach/mxc_keypad.h>
> +
> +#define KPCR		0x00
> +
> +#define KPSR		0x02
> +#define KPSR_KPP_EN	(1 << 10)
> +#define KPSR_KRIE	(1 << 9)
> +#define KPSR_KDIE	(1 << 8)
> +#define KPSR_KRSS	(1 << 3)
> +#define KPSR_KDSC	(1 << 2)
> +#define KPSR_KPKR	(1 << 1)
> +#define KPSR_KPKD	(1 << 0)
> +#define KPSR_INT_MASK	(KPSR_KRIE|KPSR_KDIE)
> +
> +#define KDDR		0x04
> +
> +#define KPDR		0x06
> +
> +
> +#define MAX_INPUTS	8
> +#define MAX_OUTPUTS	8
> +
> +
> +struct mxc_keypad {
> +	struct mxc_keypad_platform_data *pdata;
> +	struct resource *res;
> +	int irq;
> +	void __iomem *base;
> +
> +	struct clk *clk;
> +	struct input_dev *input_dev;
> +
> +	u16 keystate_prev[MAX_INPUTS];
> +};
> +
> +
> +static void mxc_keypad_scan(unsigned long data)
> +{
> +	struct mxc_keypad *kp = (struct mxc_keypad *)data;
> +	u16 col_bit, reg;
> +	int i, j;
> +	int snum = 0;
> +	u16 keystate_cur[MAX_INPUTS];
> +	u16 keystate_xor[MAX_INPUTS];
> +
> +	/* write ones to KPDR8:15, setting columns data */
> +	__raw_writew(kp->pdata->output_pins, kp->base + KPDR);
> +
> +	/* Quick-discharge by setting to totem-pole, */
> +	/* then turn back to open-drain */
> +	__raw_writew(kp->pdata->output_pins, kp->base + KPCR);
> +	wmb();
> +	udelay(2);
> +	__raw_writew(kp->pdata->output_pins |
> +		kp->pdata->input_pins, kp->base + KPCR);
> +
> +	col_bit = 1;
> +	while (col_bit) {
> +		if (col_bit & kp->pdata->output_pins) {
> +			__raw_writew(~col_bit, kp->base + KPDR);
> +			wmb();
> +			udelay(2);
> +			reg = ~__raw_readw(kp->base + KPDR);
> +			keystate_cur[snum] = reg & kp->pdata->input_pins;
> +
> +			if (snum++ >= MAX_INPUTS)
> +				break;
> +		}
> +		col_bit <<= 1;
> +	}
> +	for (i = 0; i < snum; i++) {
> +		keystate_xor[i] = kp->keystate_prev[i] ^ keystate_cur[i];
> +		for (j = 0; j < MAX_OUTPUTS; j++) {
> +			if (keystate_xor[i] & (1 << j)) {
> +				int down = !!(keystate_cur[i] & (1 << j));
> +				pr_debug("i,j: %d,%d, down %d\n", i, j, down);
> +				kp->pdata->handle_key(kp->input_dev,
> +					i, j, down);
> +			}
> +		}
> +		kp->keystate_prev[i] = keystate_cur[i];
> +	}
> +
> +	/* set columns back to 0 */
> +	__raw_writew(0, kp->base + KPDR);
> +
> +	/*
> +	 * Clear KPKD and KPKR status bit(s) by writing to a "1",
> +	 * set the KPKR synchronizer chain by writing "1" to KRSS register,
> +	 * clear the KPKD synchronizer chain by writing "1" to KDSC register
> +	 */
> +	reg = __raw_readw(kp->base + KPSR);
> +	reg |= KPSR_KPKD | KPSR_KPKR | KPSR_KRSS | KPSR_KDSC;
> +	__raw_writew(reg, kp->base + KPSR);
> +}
> +
> +
> +static irqreturn_t mxc_keypad_irq_handler(int irq, void *data)
> +{
> +	struct mxc_keypad *kp = data;
> +	u16 stat;
> +
> +	stat = __raw_readw(kp->base + KPSR);
> +	/* Toggle between depress- and release-interrupt */
> +	stat ^= KPSR_INT_MASK;
> +	/* clear interrupt status */
> +	stat |= KPSR_KPKD;
> +	stat |= KPSR_KPKR;
> +	__raw_writew(stat | KPSR_KPKD | KPSR_KPKR, kp->base + KPSR);
> +
> +	mxc_keypad_scan((unsigned long)kp);
> +
> +	pr_debug("KPCR: %04x (0f1f)\n", readw(kp->base + KPCR));
> +	pr_debug("KPSR: %04x (0502)\n", readw(kp->base + KPSR));
> +	pr_debug("KDDR: %04x (0f00)\n", readw(kp->base + KDDR));
> +	pr_debug("KPDR: %04x (705f)\n", readw(kp->base + KPDR));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +#if 0
> +static int mxc_keypad_open(struct input_dev *dev)
> +{
> +	struct mxc_keypad *kp = input_get_drvdata(dev);
> +	struct clk *clk;
> +
> +	/* Enable unit clock */
> +	clk = clk_get(&pdev->dev, "kpp");
> +	if (IS_ERR(clk))
> +		return -ENODEV;
> +	clk_enable(clk);
> +
> +	/* configure keypad */
> +	__raw_writew(kp->pdata->output_pins |
> +		kp->pdata->input_pins, kp->base + KPCR);
> +	__raw_writew(0, kp->base + KPDR);
> +	__raw_writew(kp->pdata->output_pins, kp->base + KDDR);
> +	__raw_writew(KPSR_KPP_EN | KPSR_KDIE |
> +		KPSR_KPKD | KPSR_KRSS | KPSR_KDSC, kp->base + KPSR);
> +
> +	return 0;
> +}
> +
> +static void mxc_keypad_close(struct input_dev *dev)
> +{
> +	struct mxc_keypad *kp = input_get_drvdata(dev);
> +	u16 stat;
> +	struct clk *clk;
> +
> +	/* Mask interrupts */
> +	stat = __raw_readw(kp->base + KPSR);
> +	stat &= ~KPSR_INT_MASK;
> +	__raw_writew(stat | KPSR_KPKD | KPSR_KPKR, kp->base + KPSR);
> +
> +	clk = clk_get(&dev->dev, "kpp");
> +	if (clk)
> +		clk_disable(clk);
> +}
> +#endif
> +
> +static int __devinit mxc_keypad_probe(struct platform_device *pdev)
> +{
> +	struct mxc_keypad *kp;
> +	struct input_dev *input_dev;
> +	struct mxc_keypad_platform_data *pdata;
> +	struct resource *res;
> +	struct clk *clk;
> +	int irq, error;
> +
> +	pdata = pdev->dev.platform_data;
> +	if (!pdata || !pdata->handle_key)
> +		return -EINVAL;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	irq = platform_get_irq(pdev, 0);
> +	if (!res || !irq)
> +		return -ENXIO;
> +
> +	res = request_mem_region(res->start, resource_size(res), pdev->name);
> +	if (!res)
> +		return -EBUSY;
> +
> +	kp = kzalloc(sizeof(struct mxc_keypad), GFP_KERNEL);
> +	if (!kp) {
> +		error = -ENOMEM;
> +		goto failed_release;
> +	}
> +
> +	kp->res = res;
> +	kp->pdata = pdata;
> +
> +	/* Create and register the input driver. */
> +	input_dev = kp->input_dev = input_allocate_device();
> +	if (!input_dev) {
> +		dev_err(&pdev->dev, "input_allocate_device\n");
> +		error = -ENOMEM;
> +		goto failed_put_clk;
> +	}
> +
> +	kp->base = ioremap(res->start, resource_size(res));
> +	if (!kp->base) {
> +		dev_err(&pdev->dev, "ioremap\n");
> +		error = -ENOMEM;
> +		goto failed_free_dev;
> +	}
> +
> +	clk = clk_get(&pdev->dev, "kpp");
> +	if (IS_ERR(clk)) {
> +		error = -ENODEV;
> +		goto failed_unmap;
> +	}
> +
> +	input_dev->name = pdev->name;
> +	input_dev->dev.parent = &pdev->dev;
> +	input_dev->id.bustype = BUS_HOST;
> +	input_dev->id.vendor = 0x0001;
> +	input_dev->id.product = 0x0001;
> +	input_dev->id.version = 0x0100;
> +	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REP);
> +	input_set_drvdata(input_dev, kp);
> +
> +	platform_set_drvdata(pdev, kp);
> +
> +	/* should call input_set_capability(input_dev, EV_KEY, code); */
> +	if (kp->pdata->init)
> +		kp->pdata->init(input_dev, pdev);
> +
> +	error = request_irq(irq, mxc_keypad_irq_handler,
> +		IRQF_DISABLED, pdev->name, kp);
> +	if (error) {
> +		dev_err(&pdev->dev, "request_irq\n");
> +		goto failed_clk_put;
> +	}
> +
> +	kp->irq = irq;
> +
> +	/* Register the input device */
> +	error = input_register_device(input_dev);
> +	if (error) {
> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		goto failed_free_irq;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	/* configure keypad */
> +	clk_enable(clk);
> +	__raw_writew(kp->pdata->output_pins |
> +		kp->pdata->input_pins, kp->base + KPCR);
> +	__raw_writew(0, kp->base + KPDR);
> +	__raw_writew(kp->pdata->output_pins, kp->base + KDDR);
> +	__raw_writew(KPSR_KPP_EN | KPSR_KDIE |
> +		KPSR_KPKD | KPSR_KRSS | KPSR_KDSC, kp->base + KPSR);
> +
> +	return 0;
> +
> +failed_free_irq:
> +	free_irq(irq, pdev);
> +	platform_set_drvdata(pdev, NULL);
> +failed_clk_put:
> +	clk_disable(clk);
> +	clk_put(clk);
> +failed_unmap:
> +	iounmap(kp->base);
> +failed_free_dev:
> +	input_free_device(input_dev);
> +failed_put_clk:
> +	kfree(kp);
> +failed_release:
> +	release_mem_region(res->start, resource_size(res));
> +	return error;
> +}
> +
> +static int __devexit mxc_keypad_remove(struct platform_device *pdev)
> +{
> +	struct mxc_keypad *kp = platform_get_drvdata(pdev);
> +
> +	device_init_wakeup(&pdev->dev, 0);
> +
> +	if (kp) {
> +		/* Mask interrupts */
> +		u16 stat = __raw_readw(kp->base + KPSR);
> +		stat &= ~KPSR_INT_MASK;
> +		__raw_writew(stat | KPSR_KPKD | KPSR_KPKR, kp->base + KPSR);
> +
> +		free_irq(kp->irq, pdev);
> +
> +		if (kp->pdata->exit)
> +			kp->pdata->exit(pdev);
> +
> +		if (kp->base)
> +			iounmap(kp->base);
> +
> +		clk_disable(kp->clk);
> +		clk_put(kp->clk);
> +
> +		input_unregister_device(kp->input_dev);
> +		release_mem_region(kp->res->start, resource_size(kp->res));
> +	}
> +
> +	platform_set_drvdata(pdev, NULL);
> +	kfree(kp);
> +	return 0;
> +}
> +
> +/* work with hotplug and coldplug */
> +MODULE_ALIAS("platform:mxc-keypad");
> +
> +static struct platform_driver mxc_keypad_driver = {
> +	.probe		= mxc_keypad_probe,
> +	.remove		= __devexit_p(mxc_keypad_remove),
> +	.driver		= {
> +		.name	= "mxc-keypad",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init mxc_keypad_init(void)
> +{
> +	return platform_driver_register(&mxc_keypad_driver);
> +}
> +
> +static void __exit mxc_keypad_exit(void)
> +{
> +	platform_driver_unregister(&mxc_keypad_driver);
> +}
> +
> +module_init(mxc_keypad_init);
> +module_exit(mxc_keypad_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("i.MX Keypad Driver");
> +MODULE_AUTHOR("Holger Schurig <hs4233@@mail.mn-solutions.de>");
> --- linux.orig/arch/arm/mach-mx2/clock_imx21.c
> +++ linux/arch/arm/mach-mx2/clock_imx21.c
> @@ -932,7 +932,7 @@
>  	_REGISTER_CLOCK("imx-wdt.0", NULL, wdog_clk)
>  	_REGISTER_CLOCK(NULL, "gpio", gpio_clk)
>  	_REGISTER_CLOCK(NULL, "i2c", i2c_clk)
> -	_REGISTER_CLOCK("mxc-keypad", NULL, kpp_clk)
> +	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)
>  	_REGISTER_CLOCK(NULL, "owire", owire_clk)
>  	_REGISTER_CLOCK(NULL, "rtc", rtc_clk)
>  };
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
