From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V1 5/6] watchdog: da9062: DA9062 watchdog driver
Date: Sat, 18 Apr 2015 08:52:58 -0700
Message-ID: <55327DDA.4080003@roeck-us.net>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com> <2afd9f55c71553186e99bfe386312f0c7d7501ed.1429280614.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33034 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbbDRPx1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Apr 2015 11:53:27 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YjV3e-002wJE-8f
	for linux-input@vger.kernel.org; Sat, 18 Apr 2015 15:53:26 +0000
In-Reply-To: <2afd9f55c71553186e99bfe386312f0c7d7501ed.1429280614.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: S Twiss <stwiss.opensource@diasemi.com>, LINUXKERNEL <linux-kernel@vger.kernel.org>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>
Cc: Alessandro Zummo <a.zummo@towertech.it>, DEVICETREE <devicetree@vger.kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>

On 04/17/2015 07:23 AM, S Twiss wrote:
> From: S Twiss <stwiss.opensource@diasemi.com>
>
> Add watchdog driver support for DA9062
>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>
Hi Steve,

Key question here is if the da9062 is really so much different to the da9062
that you can not use the same driver. I am especially concerned about
the added da9062_reset_watchdog_timer(), given the delay it introduces.

Comments below.

Thanks,
Guenter

> ---
>
> This patch applies against linux-next and v4.0
>
>
>
>   drivers/watchdog/Kconfig      |   9 ++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/da9062_wdt.c | 249 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 259 insertions(+)
>   create mode 100644 drivers/watchdog/da9062_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 16f2023..62232d7 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -96,6 +96,15 @@ config DA9063_WATCHDOG
>
>   	  This driver can be built as a module. The module name is da9063_wdt.
>
> +config DA9062_WATCHDOG
> +	tristate "Dialog DA9062 Watchdog"
> +	depends on MFD_DA9062
> +	select WATCHDOG_CORE
> +	help
> +	  Support for the watchdog in the DA9062 PMIC.
> +
> +	  This driver can be built as a module. The module name is da9062_wdt.
> +
>   config GPIO_WATCHDOG
>   	tristate "Watchdog device controlled through GPIO-line"
>   	depends on OF_GPIO
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 5c19294..57ba815 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -179,6 +179,7 @@ obj-$(CONFIG_XEN_WDT) += xen_wdt.o
>   # Architecture Independent
>   obj-$(CONFIG_DA9052_WATCHDOG) += da9052_wdt.o
>   obj-$(CONFIG_DA9055_WATCHDOG) += da9055_wdt.o
> +obj-$(CONFIG_DA9062_WATCHDOG) += da9062_wdt.o
>   obj-$(CONFIG_DA9063_WATCHDOG) += da9063_wdt.o
>   obj-$(CONFIG_GPIO_WATCHDOG)	+= gpio_wdt.o
>   obj-$(CONFIG_WM831X_WATCHDOG) += wm831x_wdt.o
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> new file mode 100644
> index 0000000..ac4c255
> --- /dev/null
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -0,0 +1,249 @@
> +/*
> + * da9062_wdt.c - WDT device driver for DA9062
> + * Copyright (C) 2015  Dialog Semiconductor Ltd.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/watchdog.h>
> +#include <linux/platform_device.h>
> +#include <linux/uaccess.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/da9062/registers.h>
> +#include <linux/mfd/da9062/core.h>
> +#include <linux/regmap.h>
> +#include <linux/of.h>
> +
> +static const unsigned int wdt_timeout[] = { 0, 2, 4, 8, 16, 32, 65, 131 };
> +#define DA9062_TWDSCALE_DISABLE		0
> +#define DA9062_TWDSCALE_MIN		1
> +#define DA9062_TWDSCALE_MAX		(ARRAY_SIZE(wdt_timeout) - 1)
> +#define DA9062_WDT_MIN_TIMEOUT		wdt_timeout[DA9062_TWDSCALE_MIN]
> +#define DA9062_WDT_MAX_TIMEOUT		wdt_timeout[DA9062_TWDSCALE_MAX]
> +#define DA9062_WDG_DEFAULT_TIMEOUT	wdt_timeout[DA9062_TWDSCALE_MAX-1]
> +
> +struct da9062_watchdog {
> +	struct da9062 *hw;
> +	struct watchdog_device wdtdev;
> +};
> +
> +static unsigned int da9062_wdt_timeout_to_sel(unsigned int secs)
> +{
> +	unsigned int i;
> +
> +	for (i = DA9062_TWDSCALE_MIN; i <= DA9062_TWDSCALE_MAX; i++) {
> +		if (wdt_timeout[i] >= secs)
> +			return i;
> +	}
> +
> +	return DA9062_TWDSCALE_MAX;
> +}
> +
> +static int da9062_reset_watchdog_timer(struct da9062 *hw)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(hw->regmap,
> +			   DA9062AA_CONTROL_F,
> +			   DA9062AA_WATCHDOG_MASK,
> +			   DA9062AA_WATCHDOG_MASK);
> +
> +	mdelay(300);

Really ? That seems to be excessive, especially given how often
this function is called (for each ping!).

> +
> +	return ret;
> +}
> +
> +static int da9062_wdt_update_timeout_register(struct da9062 *chip,
> +					      unsigned int regval)
> +{
> +	int ret;
> +
> +	ret = da9062_reset_watchdog_timer(chip);
> +	if (ret)
> +		dev_err(chip->dev, "Failed to ping the watchdog (err = %d)\n",
> +			ret);
> +
And no impact, so this doesn't really matter ?

> +	return regmap_update_bits(chip->regmap,
> +				  DA9062AA_CONTROL_D,
> +				  DA9062AA_TWDSCALE_MASK,
> +				  regval);
> +}
> +
> +static int da9062_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
> +	unsigned int selector;
> +	int ret;
> +
> +	selector = da9062_wdt_timeout_to_sel(wdt->wdtdev.timeout);
> +	ret = da9062_wdt_update_timeout_register(wdt->hw, selector);
> +	if (ret)
> +		dev_err(wdt->hw->dev, "Watchdog failed to start (err = %d)\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +static int da9062_wdt_stop(struct watchdog_device *wdd)
> +{
> +	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	ret = da9062_reset_watchdog_timer(wdt->hw);
> +	if (ret)
> +		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err = %d)\n",
> +			ret);
> +
ping or reset ? And no impact, ie you just ignore the error ?

> +	ret = regmap_update_bits(wdt->hw->regmap,
> +				 DA9062AA_CONTROL_D,
> +				 DA9062AA_TWDSCALE_MASK,
> +				 DA9062_TWDSCALE_DISABLE);
> +	if (ret)
> +		dev_alert(wdt->hw->dev, "Watchdog failed to stop (err = %d)\n",
> +			  ret);
> +
> +	return ret;
> +}
> +
> +static int da9062_wdt_ping(struct watchdog_device *wdd)
> +{
> +	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
> +	int ret;
> +
> +	dev_dbg(wdt->hw->dev, "watchdog ping\n");
> +
> +	ret = da9062_reset_watchdog_timer(wdt->hw);
> +	if (ret)
> +		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err = %d)\n",
> +			ret);
> +
> +	return ret;
> +}
> +
> +static int da9062_wdt_set_timeout(struct watchdog_device *wdd,
> +				  unsigned int timeout)
> +{
> +	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
> +	unsigned int selector;
> +	int ret;
> +
> +	selector = da9062_wdt_timeout_to_sel(timeout);
> +	ret = da9062_wdt_update_timeout_register(wdt->hw, selector);
> +	if (ret)
> +		dev_err(wdt->hw->dev, "Failed to set watchdog timeout (err = %d)\n",
> +			ret);
> +	else
> +		wdd->timeout = wdt_timeout[selector];
> +
> +	return ret;
> +}
> +
> +/* E_WDG_WARN interrupt handler */
> +static irqreturn_t da9062_wdt_wdg_warn_irq_handler(int irq, void *data)
> +{
> +	struct da9062_watchdog *wdt = data;
> +
> +	dev_notice(wdt->hw->dev, "Watchdog timeout warning trigger.\n");
> +	return IRQ_HANDLED;
> +}
> +
> +static const struct watchdog_info da9062_watchdog_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.identity = "DA9062 WDT",
> +};
> +
> +static const struct watchdog_ops da9062_watchdog_ops = {
> +	.owner = THIS_MODULE,
> +	.start = da9062_wdt_start,
> +	.stop = da9062_wdt_stop,
> +	.ping = da9062_wdt_ping,
> +	.set_timeout = da9062_wdt_set_timeout,
> +};
> +
> +static int da9062_wdt_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct da9062 *chip;
> +	struct da9062_watchdog *wdt;
> +	int irq;
> +
> +	chip = dev_get_drvdata(pdev->dev.parent);
> +	if (!chip)
> +		return -EINVAL;
> +
> +	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt)
> +		return -ENOMEM;
> +
> +	wdt->hw = chip;
> +
> +	wdt->wdtdev.info = &da9062_watchdog_info;
> +	wdt->wdtdev.ops = &da9062_watchdog_ops;
> +	wdt->wdtdev.min_timeout = DA9062_WDT_MIN_TIMEOUT;
> +	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
> +	wdt->wdtdev.timeout = DA9062_WDG_DEFAULT_TIMEOUT;
> +	wdt->wdtdev.status = WATCHDOG_NOWAYOUT_INIT_STATUS;
> +
> +	watchdog_set_drvdata(&wdt->wdtdev, wdt);
> +	dev_set_drvdata(&pdev->dev, wdt);
> +
> +	irq = platform_get_irq_byname(pdev, "WDG_WARN");
> +	if (irq < 0)
> +		dev_err(wdt->hw->dev, "Failed to get IRQ.\n");

But you still request the negative irq.

> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +			   da9062_wdt_wdg_warn_irq_handler,
> +			    IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> +			   "WDG_WARN", wdt);
> +	if (ret) {
> +		dev_err(wdt->hw->dev,
> +			"Failed to request watchdog device IRQ.\n");

Either this is an error, or it isn't. If it is, I would expect the driver
to abort loading. If not, please don't use dev_err.

> +	}
> +
> +	ret = watchdog_register_device(&wdt->wdtdev);
> +	if (ret < 0)
> +		dev_err(wdt->hw->dev,
> +			"watchdog registration incomplete (%d)\n", ret);

incomplete ?

> +	else
> +		dev_info(wdt->hw->dev, "installed DA9062 watchdog\n");

Please rop this message.

> +
> +	da9062_wdt_ping(&wdt->wdtdev);
> +	if (ret < 0)
> +		dev_err(wdt->hw->dev,
> +			"failed to ping the watchdog (%d)\n", ret);
> +
That ping is asking for an explanation. Does it imply that the watchdog is known to be running
and can not be stopped ?

Also, the ping function already creates an error message. Please be less noisy with
your messages.

> +	return ret;

If the above ping fails, this will return an error without unregistering
the watchdog device.

> +}
> +
> +static int da9062_wdt_remove(struct platform_device *pdev)
> +{
> +	struct da9062_watchdog *wdt = dev_get_drvdata(&pdev->dev);
> +
> +	watchdog_unregister_device(&wdt->wdtdev);
> +	return 0;
> +}
> +
> +static struct platform_driver da9062_wdt_driver = {
> +	.probe = da9062_wdt_probe,
> +	.remove = da9062_wdt_remove,
> +	.driver = {
> +		.name = "da9062-watchdog",
> +	},
> +};
> +module_platform_driver(da9062_wdt_driver);
> +
> +MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
> +MODULE_DESCRIPTION("WDT device driver for Dialog DA9062");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform: da9062-watchdog");
>

