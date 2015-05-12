From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: keyboad: imx: add snvs power key driver
Date: Tue, 12 May 2015 11:43:28 -0700
Message-ID: <20150512184328.GC20725@dtor-ws>
References: <1431449438-19460-1-git-send-email-Frank.Li@freescale.com>
 <1431449438-19460-2-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:37857 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933203AbbELSnd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 May 2015 14:43:33 -0400
Received: by igbsb11 with SMTP id sb11so23332838igb.0
        for <linux-input@vger.kernel.org>; Tue, 12 May 2015 11:43:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1431449438-19460-2-git-send-email-Frank.Li@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Frank.Li@freescale.com
Cc: lznuaa@gmail.com, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Robin Gong <b38343@freescale.com>

Hi Robin,

On Wed, May 13, 2015 at 12:50:37AM +0800, Frank.Li@freescale.com wrote:
> From: Robin Gong <b38343@freescale.com>
> 
> add snvs power key driver.
> It work in imx chips after i.mx6sx
> 
> Signed-off-by: Robin Gong <b38343@freescale.com>
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> ---
>  drivers/input/keyboard/Kconfig       |   7 ++
>  drivers/input/keyboard/Makefile      |   1 +
>  drivers/input/keyboard/snvs_pwrkey.c | 226 +++++++++++++++++++++++++++++++++++
>  3 files changed, 234 insertions(+)
>  create mode 100644 drivers/input/keyboard/snvs_pwrkey.c
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 106fbac..33c9bed 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -400,6 +400,13 @@ config KEYBOARD_MPR121
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mpr121_touchkey.
>  
> +config KEYBOARD_SNVS_PWRKEY
> +	tristate "IMX6SX SNVS Power Key Driver"
> +	depends on SOC_IMX6SX

Does SOC_IMX6SX depend on OF? Maybe have explicit dependency here?

> +	help
> +	  This is the snvs powerkey driver for the Freescale i.MX6SX application
> +	  processors.

"To compile this driver as a module..."

> +
>  config KEYBOARD_IMX
>  	tristate "IMX keypad support"
>  	depends on ARCH_MXC
> diff --git a/drivers/input/keyboard/Makefile b/drivers/input/keyboard/Makefile
> index df28d55..1d416dd 100644
> --- a/drivers/input/keyboard/Makefile
> +++ b/drivers/input/keyboard/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_KEYBOARD_QT1070)           += qt1070.o
>  obj-$(CONFIG_KEYBOARD_QT2160)		+= qt2160.o
>  obj-$(CONFIG_KEYBOARD_SAMSUNG)		+= samsung-keypad.o
>  obj-$(CONFIG_KEYBOARD_SH_KEYSC)		+= sh_keysc.o
> +obj-$(CONFIG_KEYBOARD_SNVS_PWRKEY)	+= snvs_pwrkey.o
>  obj-$(CONFIG_KEYBOARD_SPEAR)		+= spear-keyboard.o
>  obj-$(CONFIG_KEYBOARD_STMPE)		+= stmpe-keypad.o
>  obj-$(CONFIG_KEYBOARD_STOWAWAY)		+= stowaway.o
> diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
> new file mode 100644
> index 0000000..24abbb4
> --- /dev/null
> +++ b/drivers/input/keyboard/snvs_pwrkey.c
> @@ -0,0 +1,226 @@
> +/*
> + * Copyright (C) 2011-2014 Freescale Semiconductor, Inc. All Rights Reserved.

2015?

> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/input.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +
> +#define SNVS_LPSR_REG	0x4C	/* LP Status Register */
> +#define SNVS_LPCR_REG	0x38	/* LP Control Register */
> +#define SNVS_HPSR_REG   0x14
> +#define SNVS_HPSR_BTN	(0x1 << 6)
BIT(6)?

> +#define SNVS_LPSR_SPO	(0x1 << 18)

BIT(18)

> +#define SNVS_LPCR_DEP_EN (0x1 << 5)

BIT(5)

> +
> +struct pwrkey_drv_data {
> +	void __iomem *ioaddr;
> +	int irq;
> +	int keycode;
> +	int keystate;  /* 1:pressed */
> +	int wakeup;
> +	struct timer_list check_timer;
> +	struct input_dev *input;
> +};
> +
> +static void imx_imx_snvs_check_for_events(unsigned long data)
> +{
> +	struct pwrkey_drv_data *pdata = (struct pwrkey_drv_data *) data;
> +	struct input_dev *input = pdata->input;
> +	void __iomem *ioaddr = pdata->ioaddr;
> +	u32 state;
> +
> +	state = ((readl_relaxed(ioaddr + SNVS_HPSR_REG) & SNVS_HPSR_BTN) ?
> +		1 : 0);
> +
> +	/* only report new event if status changed */
> +	if (state ^ pdata->keystate) {
> +		pdata->keystate = state;
> +		input_event(input, EV_KEY, pdata->keycode, state);
> +		input_sync(input);
> +		pm_relax(pdata->input->dev.parent);
> +	}
> +
> +	/* repeat check if pressed long */
> +	if (state) {
> +		mod_timer(&pdata->check_timer,
> +			  jiffies + msecs_to_jiffies(60));
> +	}
> +}
> +
> +static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void *dev_id)
> +{
> +	struct platform_device *pdev = dev_id;
> +	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +	void __iomem *ioaddr = pdata->ioaddr;
> +	u32 lp_status;
> +
> +	pm_wakeup_event(pdata->input->dev.parent, 0);
> +	lp_status = readl_relaxed(ioaddr + SNVS_LPSR_REG);
> +	if (lp_status & SNVS_LPSR_SPO)
> +		mod_timer(&pdata->check_timer, jiffies + msecs_to_jiffies(2));

Why 2 and not 1 or 0?

> +
> +	/* clear SPO status */
> +	writel_relaxed(lp_status, ioaddr + SNVS_LPSR_REG);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
> +{
> +	struct pwrkey_drv_data *pdata = NULL;
> +	struct input_dev *input = NULL;
> +	struct device_node *np;
> +	void __iomem *ioaddr;
> +	u32 val;
> +	int ret = 0;
> +
> +	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return -ENOMEM;
> +
> +	/* Get SNVS register Page */
> +	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sx-snvs-pwrkey");

Why such unorthodox way of getting node pointer? Why not use
pdev->dev.of_node?

> +	if (!np)
> +		return -ENODEV;
> +	pdata->ioaddr = of_iomap(np, 0);

I do not see you freeing this anywhere, not in error paths, nor in
remove().

> +	if (IS_ERR(pdata->ioaddr))
> +		return PTR_ERR(pdata->ioaddr);
> +
> +	if (of_property_read_u32(np, "fsl,keycode", &pdata->keycode)) {

I think this should be "linux,keycode"

> +		pdata->keycode = KEY_POWER;
> +		dev_warn(&pdev->dev, "KEY_POWER without setting in dts\n");
> +	}
> +
> +	pdata->wakeup = !!of_get_property(np, "fsl,wakeup", NULL);

Just use "wakeup" I guess.

> +
> +	pdata->irq = platform_get_irq(pdev, 0);
> +	if (pdata->irq < 0) {
> +		dev_err(&pdev->dev, "no irq defined in platform data\n");
> +		return -EINVAL;
> +	}
> +
> +	ioaddr = pdata->ioaddr;
> +	val = readl_relaxed(ioaddr + SNVS_LPCR_REG);
> +	val |= SNVS_LPCR_DEP_EN,
> +	writel_relaxed(val, ioaddr + SNVS_LPCR_REG);
> +	/* clear the unexpected interrupt before driver ready */
> +	val = readl_relaxed(ioaddr + SNVS_LPSR_REG);
> +	if (val & SNVS_LPSR_SPO)
> +		writel_relaxed(val | SNVS_LPSR_SPO, ioaddr + SNVS_LPSR_REG);
> +
> +	setup_timer(&pdata->check_timer,
> +		    imx_imx_snvs_check_for_events, (unsigned long) pdata);
> +
> +	if (pdata->irq >= 0) {

Why do we need this condition? You error out if irq < 0 above.

> +		ret = devm_request_irq(&pdev->dev, pdata->irq,
> +					imx_snvs_pwrkey_interrupt,
> +					IRQF_TRIGGER_HIGH | IRQF_NO_SUSPEND, pdev->name, pdev);

Why IRQF_NO_SUSPEND? Also should we not get trigger type from OF data?

> +		if (ret) {
> +			dev_err(&pdev->dev, "interrupt not available.\n");
> +			return ret;
> +		}
> +	}
> +
> +	input = devm_input_allocate_device(&pdev->dev);
> +	if (!input) {
> +		dev_err(&pdev->dev, "failed to allocate the input device\n");
> +		return -ENOMEM;
> +	}

This is too late. Interrupt may come before you allocate input device
and you will get kernel crash.

> +
> +	input->name = pdev->name;
> +	input->phys = "snvs-pwrkey/input0";
> +	input->id.bustype = BUS_HOST;
> +	input->evbit[0] = BIT_MASK(EV_KEY);
> +
> +	input_set_capability(input, EV_KEY, pdata->keycode);
> +
> +	ret = input_register_device(input);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "failed to register input device\n");
> +		input_free_device(input);
> +		return ret;
> +	}
> +
> +	pdata->input = input;
> +	platform_set_drvdata(pdev, pdata);
> +
> +	device_init_wakeup(&pdev->dev, pdata->wakeup);
> +
> +	dev_info(&pdev->dev, "i.MX snvs powerkey probed\n");
> +
> +	return 0;
> +}
> +
> +static int imx_snvs_pwrkey_remove(struct platform_device *pdev)
> +{
> +	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +
> +	input_unregister_device(pdata->input);
> +	del_timer_sync(&pdata->check_timer);

This is racy. You unregister input device (which is likely to free it)
and only then cancel timer and _then_ free IRQ. If timer or IRQ fire at
wrong time you'll get crash.

Consider using devm_input_allocate_device() and devm_add_action() to
schedule del_timer_sync() after freeing interrupt and before input
device is freed.

Alternatively, is it possible to disable the device? Then implement
open() and close() methods and call del_timer_sync() from close().

> +
> +	return 0;
> +}
> +
> +static int imx_snvs_pwrkey_suspend(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(&pdev->dev))
> +		enable_irq_wake(pdata->irq);
> +
> +	return 0;
> +}
> +
> +static int imx_snvs_pwrkey_resume(struct device *dev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +
> +	if (device_may_wakeup(&pdev->dev))
> +		disable_irq_wake(pdata->irq);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id imx_snvs_pwrkey_ids[] = {
> +	{ .compatible = "fsl,imx6sx-snvs-pwrkey" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_snvs_pwrkey_ids);
> +
> +static SIMPLE_DEV_PM_OPS(imx_snvs_pwrkey_pm_ops, imx_snvs_pwrkey_suspend,
> +				imx_snvs_pwrkey_resume);
> +
> +static struct platform_driver imx_snvs_pwrkey_driver = {
> +	.driver = {
> +		.name = "snvs_pwrkey",
> +		.owner	= THIS_MODULE,
> +		.pm     = &imx_snvs_pwrkey_pm_ops,
> +		.of_match_table = imx_snvs_pwrkey_ids,
> +	},
> +	.probe = imx_snvs_pwrkey_probe,
> +	.remove = imx_snvs_pwrkey_remove,
> +};
> +module_platform_driver(imx_snvs_pwrkey_driver);
> +
> +MODULE_AUTHOR("Freescale Semiconductor");
> +MODULE_DESCRIPTION("i.MX snvs power key Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
