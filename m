From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] input: sirfsoc_pwrc: add onkey input driver for CSR
 SiRFprimaII PWRC
Date: Fri, 24 May 2013 00:17:54 +0800
Message-ID: <CAGsJ_4y6BwTpZpwYv0njvqYtp9Y0UU5qhVJhqG5X+8+Hy_LW8Q@mail.gmail.com>
References: <1369239198-11059-1-git-send-email-Baohua.Song@csr.com> <AAD401B65941D44692B7183E6577180803A11B7C@banasiexm01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qe0-f44.google.com ([209.85.128.44]:48079 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759388Ab3EWQSP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 May 2013 12:18:15 -0400
Received: by mail-qe0-f44.google.com with SMTP id 6so2018166qeb.31
        for <linux-input@vger.kernel.org>; Thu, 23 May 2013 09:18:14 -0700 (PDT)
In-Reply-To: <AAD401B65941D44692B7183E6577180803A11B7C@banasiexm01.ASIA.ROOT.PRI>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Madhvapathi Sriram <Madhvapathi.Sriram@csr.com>
Cc: "dtor@mail.ru" <dtor@mail.ru>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DL-SHA-WorkGroupLinux <Workgroup.Linux@csr.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Binghua Duan <Binghua.Duan@csr.com>, Xianglong Du <Xianglong.Du@csr.com>, Barry Song <Barry.Song@csr.com>

hi madhvapathi,
thanks for comments.

2013/5/23 Madhvapathi Sriram <Madhvapathi.Sriram@csr.com>:
> Comments inline.
> ________________________________________
> From: Barry Song [21cnbao@gmail.com]
> Sent: Wednesday, May 22, 2013 9:43 PM
> To: dtor@mail.ru; dmitry.torokhov@gmail.com
> Cc: linux-input@vger.kernel.org; DL-SHA-WorkGroupLinux; linux-arm-kernel@lists.infradead.org; Binghua Duan; Xianglong Du; Barry Song
> Subject: [PATCH] input: sirfsoc_pwrc: add onkey input driver for CSR SiRFprimaII PWRC
>
> From: Binghua Duan <Binghua.Duan@csr.com>
>
> there is an embedded PWRC(power controller) in SiRFprimaII and SiRFatlasVI,
> we have an ONKEY button which can generate interrupt to IRQ controller.
> in a typical user scenarios, at the runtime, if users touch the key, we put
> system to s2ram status.
>
> Signed-off-by: Binghua Duan <Binghua.Duan@csr.com>
> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  drivers/input/misc/Kconfig         |  10 +++
>  drivers/input/misc/Makefile        |   1 +
>  drivers/input/misc/sirfsoc_onkey.c | 176 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+)
>  create mode 100644 drivers/input/misc/sirfsoc_onkey.c
>
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index bb698e1..1d91d1b 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -637,4 +637,14 @@ config INPUT_XEN_KBDDEV_FRONTEND
>           To compile this driver as a module, choose M here: the
>           module will be called xen-kbdfront.
>
> +config INPUT_SIRFSOC_ONKEY
> +       bool "CSR SiRFSoC power on/off/suspend key support"
> +       depends on ARCH_SIRF
> +       default y
> +       help
> +         Say Y here if you want to support for the SiRFSoC power on/off/suspend key
> +         in Linux, after you press the onkey, system will suspend.
> +
> +         If unsure, say N.
> +
>  endif
> diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
> index d7fc17f..1d66f03 100644
> --- a/drivers/input/misc/Makefile
> +++ b/drivers/input/misc/Makefile
> @@ -60,3 +60,4 @@ obj-$(CONFIG_INPUT_WISTRON_BTNS)      += wistron_btns.o
>  obj-$(CONFIG_INPUT_WM831X_ON)          += wm831x-on.o
>  obj-$(CONFIG_INPUT_XEN_KBDDEV_FRONTEND)        += xen-kbdfront.o
>  obj-$(CONFIG_INPUT_YEALINK)            += yealink.o
> +obj-$(CONFIG_INPUT_SIRFSOC_ONKEY)      += sirfsoc_onkey.o
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
> +       u32                     pwrc_base;
> +       int                     irq;
> +       struct input_dev        *input;
> +};
> +
> +#define PWRC_ON_KEY_BIT                        (1 << 0)
> +
> +#define PWRC_INT_STATUS                        0xc
> +#define PWRC_INT_MASK                  0x10
> +
> +static irqreturn_t sirfsoc_pwrc_isr(int irq, void *dev_id)
> +{
> +       struct sirfsoc_pwrc_drvdata *pwrcdrv =
> +                       (struct sirfsoc_pwrc_drvdata *)dev_id;
> +       u32 int_status;
> +       int_status = sirfsoc_rtc_iobrg_readl(
> +                       pwrcdrv->pwrc_base + PWRC_INT_STATUS);
> +       sirfsoc_rtc_iobrg_writel(int_status & (~PWRC_ON_KEY_BIT),
> +                       pwrcdrv->pwrc_base + PWRC_INT_STATUS);
> +
> +       /*
> +        * For a typical Linux system, we report KEY_SUSPEND to trigger apm-power.c
> +        * to queue a SUSPEND APM event
> +        */
> +       input_event(pwrcdrv->input, EV_PWR, KEY_SUSPEND, 1);
> +       input_sync(pwrcdrv->input);
> +
> +       /*
> +        * Todo: report KEY_POWER event for Android platforms, Android PowerManager
> +        * will handle the suspend and powerdown/hibernation
> +        */
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static const struct of_device_id sirfsoc_pwrc_of_match[] = {
> +       { .compatible = "sirf,prima2-pwrc" },
> +       {},
> +}
> +MODULE_DEVICE_TABLE(of, sirfsoc_pwrc_of_match);
> +
> +static int sirfsoc_pwrc_probe(struct platform_device *pdev)
> +{
> +       int ret;
> +       struct sirfsoc_pwrc_drvdata *pwrcdrv = NULL;
> +       struct device_node *np = pdev->dev.of_node;
> +
> +       pwrcdrv = devm_kzalloc(&pdev->dev,
> +               sizeof(struct sirfsoc_pwrc_drvdata), GFP_KERNEL);
> +       if (!pwrcdrv) {
> +               dev_info(&pdev->dev, "kzalloc fail!\n");
> +               return -ENOMEM;
> +       }
> +
> +       /*
> +        * we can't use of_iomap because pwrc is not mapped in memory, the so-called base
> +        * address is only offset in rtciobrg
> +        */
> +       ret = of_property_read_u32(np, "reg", &pwrcdrv->pwrc_base);
>
> Possible mem leak here  - not freeing pwrcdrv

no. there is no mem leak here. devm_ means device management resources.

>
> +       if (ret) {
> +               dev_err(&pdev->dev, "unable to find base address of pwrc node in dtb\n");
> +               return ret;
> +       }
> +
> +       pwrcdrv->input = devm_input_allocate_device(&pdev->dev);
> +       if (!pwrcdrv->input)
> +               return -ENOMEM;
> +
> +       pwrcdrv->input->name = "sirfsoc pwrckey";
> +       pwrcdrv->input->phys = "pwrc/input0";
> +
> +       platform_set_drvdata(pdev, pwrcdrv);
> +
> +       pwrcdrv->irq = platform_get_irq(pdev, 0);
> +       ret = devm_request_irq(&pdev->dev, pwrcdrv->irq,
> +                       sirfsoc_pwrc_isr, IRQF_SHARED,
> +                       "sirfsoc_pwrc_int", pwrcdrv);
> +
> +       sirfsoc_rtc_iobrg_writel(
> +               sirfsoc_rtc_iobrg_readl(pwrcdrv->pwrc_base + PWRC_INT_MASK)
> +               | PWRC_ON_KEY_BIT, pwrcdrv->pwrc_base + PWRC_INT_MASK);
>
> Enabling the MASK for an interrupt should only come after it has been successfully claimed? Else we might be leaving and interrupt enabled without being able to handle it?

here moving ahead of request_irq and placing here both work. as there
is another gate in irq controller.

>
> Possible mem leak here not freeing any allocated devices/memory/irq.
> I suggest all the error handling be collated at the end of this function for various stages and error handling be done there.

and we don't need to free devm_irq and devm_mem as well.

> Please have a look at https://www.kernel.org/doc/Documentation/input/input-programming.txt
>
> +       if (ret) {
> +               dev_err(&pdev->dev, "pwrc: Unable to claim irq %d; error %d\n",
> +                       pwrcdrv->irq, ret);
> +               return ret;
> +       }
> +
> +       pwrcdrv->input->evbit[0] = BIT_MASK(EV_PWR) | BIT_MASK(EV_KEY);
> +       set_bit(KEY_POWER, pwrcdrv->input->keybit);
> +
> +       ret = input_register_device(pwrcdrv->input);
> +       if (ret) {
> +               dev_err(&pdev->dev,
> +                       "pwrc: Unable to register input device,error: %d\n",
> +                       ret);
> +               return ret;
> +       }
> +
> +       device_init_wakeup(&pdev->dev, 1);
> +
> +       return 0;
> +}
> +
> +static int sirfsoc_pwrc_remove(struct platform_device *pdev)
> +{
> +       device_init_wakeup(&pdev->dev, 0);
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int pwrc_suspend(struct device *dev)
> +{
> +       return 0;
> +}
> +
> +static int pwrc_resume(struct device *dev)
> +{
> +       struct sirfsoc_pwrc_drvdata *pwrcdrv = dev_get_drvdata(dev);
> +
>
> Typically, the wake up interrupts would be ensured to be active while going to sleep/suspend.
> However, here at resume the interrupt mask is being set. Is it because, there are some caveats here?

xianglong, pls explain.

>
> +       /*
> +        * Do not mask pwrc interrupt as we want pwrc work as a wakeup source
> +        * if users touch X_ONKEY_B, see arch/arm/mach-prima2/pm.c
> +        */
> +       sirfsoc_rtc_iobrg_writel(
> +               sirfsoc_rtc_iobrg_readl(
> +               pwrcdrv->pwrc_base + PWRC_INT_MASK) | PWRC_ON_KEY_BIT,
> +               pwrcdrv->pwrc_base + PWRC_INT_MASK);
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops sirfsoc_pwrc_pm_ops = {
> +       .suspend = pwrc_suspend,
> +       .resume = pwrc_resume,
> +};
> +#endif
> +
> +static struct platform_driver sirfsoc_pwrc_driver = {
> +       .probe          = sirfsoc_pwrc_probe,
> +       .remove         = sirfsoc_pwrc_remove,
> +       .driver         = {
> +               .name   = "sirfsoc-pwrc",
> +               .owner  = THIS_MODULE,
> +#ifdef CONFIG_PM
> +               .pm     = &sirfsoc_pwrc_pm_ops,
> +#endif
> +               .of_match_table = of_match_ptr(sirfsoc_pwrc_of_match),
> +       }
> +};
> +
> +module_platform_driver(sirfsoc_pwrc_driver);
> +
> +MODULE_LICENSE("GPLv2");
> +MODULE_AUTHOR("Binghua Duan <Binghua.Duan@csr.com>, "
> +               "Xianglong Du <Xianglong.Du@csr.com>");
> +MODULE_DESCRIPTION("CSR Prima2 PWRC Driver");
> +MODULE_ALIAS("platform:sirfsoc-pwrc");
> --
> 1.8.2.3

-barry
