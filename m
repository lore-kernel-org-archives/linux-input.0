From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: sirfsoc_pwrc: add onkey input driver for CSR
 SiRFprimaII PWRC
Date: Thu, 23 May 2013 09:26:57 -0700
Message-ID: <20130523162657.GA15494@core.coreip.homeip.net>
References: <1369239198-11059-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:58112 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752403Ab3EWQ1A (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 May 2013 12:27:00 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so3116152pbc.17
        for <linux-input@vger.kernel.org>; Thu, 23 May 2013 09:27:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1369239198-11059-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-input@vger.kernel.org, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Binghua Duan <Binghua.Duan@csr.com>, Xianglong Du <Xianglong.Du@csr.com>, Barry Song <Baohua.Song@csr.com>

Hi Barry,

Looks very good, just a few nits below.

On Thu, May 23, 2013 at 12:13:18AM +0800, Barry Song wrote:
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index d7fc17f..1d66f03 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
>  obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
>  obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)	+= xen-kbdfront.o
>  obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
> +obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)	+= sirfsoc_onkey.o

Please try keeping it sorted.

> diff --git a/drivers/input/misc/sirfsoc_onkey.c b/drivers/input/misc/sirfsoc_onkey.c
> new file mode 100644
> index 0000000..3e48db9
> --- /dev/null
> +++ b/drivers/input/misc/sirfsoc_onkey.c
> @@ -0,0 +1,176 @@
> +/*
> + * Power key driver for SiRF PrimaII
> + *
> + * Copyright (c) 2013 Cambridge Silicon Radio Limited, a CSR plc group company.
> + *
> + * Licensed under GPLv2 or later.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/platform_device.h>
> +#include <linux/input.h>
> +#include <linux/rtc/sirfsoc_rtciobrg.h>
> +#include <linux/of.h>
> +
> +struct sirfsoc_pwrc_drvdata {
> +	u32			pwrc_base;
> +	int			irq;

Since you are using devm_ interfaces you don't really need to store irq
in the structure as far as I can see.

> +	struct input_dev	*input;
> +};
> +
> +#define PWRC_ON_KEY_BIT			(1 << 0)
> +
> +#define PWRC_INT_STATUS			0xc
> +#define PWRC_INT_MASK			0x10
> +
> +static irqreturn_t sirfsoc_pwrc_isr(int irq, void *dev_id)
> +{
> +	struct sirfsoc_pwrc_drvdata *pwrcdrv =
> +			(struct sirfsoc_pwrc_drvdata *)dev_id;
> +	u32 int_status;
> +	int_status = sirfsoc_rtc_iobrg_readl(
> +			pwrcdrv->pwrc_base + PWRC_INT_STATUS);
> +	sirfsoc_rtc_iobrg_writel(int_status & (~PWRC_ON_KEY_BIT),
> +			pwrcdrv->pwrc_base + PWRC_INT_STATUS);
> +
> +	/*
> +	 * For a typical Linux system, we report KEY_SUSPEND to trigger apm-power.c
> +	 * to queue a SUSPEND APM event
> +	 */
> +	input_event(pwrcdrv->input, EV_PWR, KEY_SUSPEND, 1);
> +	input_sync(pwrcdrv->input);
> +
> +	/*
> +	 * Todo: report KEY_POWER event for Android platforms, Android PowerManager
> +	 * will handle the suspend and powerdown/hibernation
> +	 */
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct of_device_id sirfsoc_pwrc_of_match[] = {
> +	{ .compatible = "sirf,prima2-pwrc" },
> +	{},
> +}
> +MODULE_DEVICE_TABLE(of, sirfsoc_pwrc_of_match);
> +
> +static int sirfsoc_pwrc_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct sirfsoc_pwrc_drvdata *pwrcdrv = NULL;
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	pwrcdrv = devm_kzalloc(&pdev->dev,
> +		sizeof(struct sirfsoc_pwrc_drvdata), GFP_KERNEL);
> +	if (!pwrcdrv) {
> +		dev_info(&pdev->dev, "kzalloc fail!\n");
> +		return -ENOMEM;
> +	}
> +
> +	/*
> +	 * we can't use of_iomap because pwrc is not mapped in memory, the so-called base
> +	 * address is only offset in rtciobrg
> +	 */
> +	ret = of_property_read_u32(np, "reg", &pwrcdrv->pwrc_base);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to find base address of pwrc node in dtb\n");
> +		return ret;
> +	}
> +
> +	pwrcdrv->input = devm_input_allocate_device(&pdev->dev);
> +	if (!pwrcdrv->input)
> +		return -ENOMEM;
> +
> +	pwrcdrv->input->name = "sirfsoc pwrckey";
> +	pwrcdrv->input->phys = "pwrc/input0";
> +
> +	platform_set_drvdata(pdev, pwrcdrv);
> +
> +	pwrcdrv->irq = platform_get_irq(pdev, 0);
> +	ret = devm_request_irq(&pdev->dev, pwrcdrv->irq,
> +			sirfsoc_pwrc_isr, IRQF_SHARED,
> +			"sirfsoc_pwrc_int", pwrcdrv);
> +
> +	sirfsoc_rtc_iobrg_writel(
> +		sirfsoc_rtc_iobrg_readl(pwrcdrv->pwrc_base + PWRC_INT_MASK)
> +		| PWRC_ON_KEY_BIT, pwrcdrv->pwrc_base + PWRC_INT_MASK);
> +	if (ret) {

Why do we check only after fiddling with registers?

> +		dev_err(&pdev->dev, "pwrc: Unable to claim irq %d; error %d\n",
> +			pwrcdrv->irq, ret);
> +		return ret;
> +	}
> +
> +	pwrcdrv->input->evbit[0] = BIT_MASK(EV_PWR) | BIT_MASK(EV_KEY);
> +	set_bit(KEY_POWER, pwrcdrv->input->keybit);
> +
> +	ret = input_register_device(pwrcdrv->input);
> +	if (ret) {
> +		dev_err(&pdev->dev,
> +			"pwrc: Unable to register input device,error: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	device_init_wakeup(&pdev->dev, 1);
> +
> +	return 0;
> +}
> +
> +static int sirfsoc_pwrc_remove(struct platform_device *pdev)
> +{
> +	device_init_wakeup(&pdev->dev, 0);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM

I think it should be CONFIG_PM_SLEEP as it resuyme handling does not
appear to make sense for runtime PM.

> +static int pwrc_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int pwrc_resume(struct device *dev)
> +{
> +	struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(dev);
> +
> +	/* 

Trailing whitespace.

> +	 * Do not mask pwrc interrupt as we want pwrc work as a wakeup source
> +	 * if users touch X_ONKEY_B, see arch/arm/mach-prima2/pm.c
> +	 */
> +	sirfsoc_rtc_iobrg_writel(
> +		sirfsoc_rtc_iobrg_readl(
> +		pwrcdrv->pwrc_base + PWRC_INT_MASK) | PWRC_ON_KEY_BIT,
> +		pwrcdrv->pwrc_base + PWRC_INT_MASK);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops sirfsoc_pwrc_pm_ops = {
> +	.suspend = pwrc_suspend,
> +	.resume	= pwrc_resume,
> +};
> +#endif
> +

just say

static SIMPLE_DEV_PM_OPS(sirfsoc_pwrc_pm_ops, NULL, pwrc_resume);

> +static struct platform_driver sirfsoc_pwrc_driver = {
> +	.probe		= sirfsoc_pwrc_probe,
> +	.remove		= sirfsoc_pwrc_remove,
> +	.driver		= {
> +		.name	= "sirfsoc-pwrc",
> +		.owner	= THIS_MODULE,
> +#ifdef CONFIG_PM
> +		.pm	= &sirfsoc_pwrc_pm_ops,
> +#endif

and you do not need ifdef guard here.

> +		.of_match_table = of_match_ptr(sirfsoc_pwrc_of_match),
> +	}
> +};
> +
> +module_platform_driver(sirfsoc_pwrc_driver);
> +
> +MODULE_LICENSE("GPLv2");
> +MODULE_AUTHOR("Binghua Duan <Binghua.Duan@csr.com>, "
> +		"Xianglong Du <Xianglong.Du@csr.com>");
> +MODULE_DESCRIPTION("CSR Prima2 PWRC Driver");
> +MODULE_ALIAS("platform:sirfsoc-pwrc");


Thanks.

-- 
Dmitry
