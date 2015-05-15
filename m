From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH V2 3/4] watchdog: da9062: DA9062 watchdog driver
Date: Thu, 14 May 2015 19:13:13 -0700
Message-ID: <55555639.8090505@roeck-us.net>
References: <cover.1431621833.git.stwiss.opensource@diasemi.com> <6a51f163b99edfad9165ad29609abb072dbaa2b7.1431621833.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6a51f163b99edfad9165ad29609abb072dbaa2b7.1431621833.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, LINUXKERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUXWATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
Cc: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, David Dajun Chen <david.chen-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, LINUXINPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, RTCLINUX <rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 05/14/2015 09:43 AM, S Twiss wrote:
> From: S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>
> Add watchdog driver support for DA9062
>
>
> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>
> ---
>
> Changes in V2:
>   - Removed informational dev_info() 'installed watchdog' message
>   - Copyright headers GPL v2 (and later) match correct 'GPL' in MODULE_LICENSE
>   - Removed the explicit 300 msecs delay from the reset_watchdog_timer()
>     function and replaced it with a variable delay (depending on the
>     difference since the last ping). A debug message is used to catch the
>     multiple pings trying to break the 300 msecs protection barrier.
>   - Fix error paths for the functions da9062_wdt_update_timeout_register()
>     and da9062_wdt_stop()
>   - Add error paths in the probe() and correctly clean-up the registered
>     device if there is a problem after registration.
>
> This patch applies against linux-next and v4.1-rc3
>
>
>
>   drivers/watchdog/Kconfig      |   9 ++
>   drivers/watchdog/Makefile     |   1 +
>   drivers/watchdog/da9062_wdt.c | 288 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 298 insertions(+)
>   create mode 100644 drivers/watchdog/da9062_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index e5e7c55..dfdb6c6 100644
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
> index 0000000..9e6c93b
> --- /dev/null
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -0,0 +1,288 @@
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
> +#include <linux/jiffies.h>
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
> +#define DA9062_RESET_PROTECTION_MS	300
> +
> +struct da9062_watchdog {
> +	struct da9062 *hw;
> +	struct watchdog_device wdtdev;
> +	unsigned long j_time_stamp;
> +};
> +
> +static void da9062_set_window_start(struct da9062_watchdog *wdt)
> +{
> +	wdt->j_time_stamp = jiffies;
> +}
> +
> +static void da9062_apply_window_protection(struct da9062_watchdog *wdt)
> +{
> +	unsigned long delay = msecs_to_jiffies(DA9062_RESET_PROTECTION_MS);
> +	unsigned long timeout = wdt->j_time_stamp + delay;
> +	unsigned long now = jiffies;
> +	unsigned int diff_ms;
> +
> +	/* if time-limit has not elapsed then wait for remainder */
> +	if (time_before(now, timeout)) {
> +		diff_ms = jiffies_to_msecs(timeout-now);
> +		dev_dbg(wdt->hw->dev,
> +			"Kicked too quickly. Delaying %u msecs\n", diff_ms);
> +		msleep(diff_ms);
> +	}
> +
> +	return;

Unnecessary return statement.

> +}
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
> +static int da9062_reset_watchdog_timer(struct da9062_watchdog *wdt)
> +{
> +	int ret;
> +
> +	da9062_apply_window_protection(wdt);
> +
> +	ret = regmap_update_bits(wdt->hw->regmap,
> +			   DA9062AA_CONTROL_F,
> +			   DA9062AA_WATCHDOG_MASK,
> +			   DA9062AA_WATCHDOG_MASK);
> +
> +	da9062_set_window_start(wdt);
> +
> +	return ret;
> +}
> +
> +static int da9062_wdt_update_timeout_register(struct da9062_watchdog *wdt,
> +					      unsigned int regval)
> +{
> +	struct da9062 *chip = wdt->hw;
> +	int ret;
> +
> +	ret = da9062_reset_watchdog_timer(wdt);
> +	if (ret) {
> +		dev_err(chip->dev, "Failed to ping the watchdog (err = %d)\n",
> +			ret);

I am kind of torn about all this noisiness on error. Personally I would tend to ask
people to let user space handle it, and not be that noisy in the kernel.

Wim, any guidance ?

> +		return ret;
> +	}
> +
> +	return regmap_update_bits(chip->regmap,
> +				  DA9062AA_CONTROL_D,
> +				  DA9062AA_TWDSCALE_MASK,
> +				  regval);

... and it is inconsistent - no error message here.

> +}
> +
> +static int da9062_wdt_start(struct watchdog_device *wdd)
> +{
> +	struct da9062_watchdog *wdt = watchdog_get_drvdata(wdd);
> +	unsigned int selector;
> +	int ret;
> +
> +	selector = da9062_wdt_timeout_to_sel(wdt->wdtdev.timeout);
> +	ret = da9062_wdt_update_timeout_register(wdt, selector);
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
> +	ret = da9062_reset_watchdog_timer(wdt);
> +	if (ret) {
> +		dev_err(wdt->hw->dev, "Failed to ping the watchdog (err = %d)\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(wdt->hw->regmap,
> +				 DA9062AA_CONTROL_D,
> +				 DA9062AA_TWDSCALE_MASK,
> +				 DA9062_TWDSCALE_DISABLE);
> +	if (ret)
> +		dev_alert(wdt->hw->dev, "Watchdog failed to stop (err = %d)\n",
> +			  ret);

.. and now we have an alert. Hmm..

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

Is this really valuable enough to keep in the code ?

> +	ret = da9062_reset_watchdog_timer(wdt);
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
> +	ret = da9062_wdt_update_timeout_register(wdt, selector);
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
> +	if (irq < 0) {
> +		dev_err(wdt->hw->dev, "Failed to get IRQ.\n");
> +		ret = irq;
> +		goto error;

Just return; the label does not serve a useful purpose. Same for the other goto
statements below.

Also, is the interrupt mandatory ? All it does is to display a message.
Looks very optional to me.

> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +			   da9062_wdt_wdg_warn_irq_handler,
> +			    IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED,
> +			   "WDG_WARN", wdt);
> +	if (ret) {
> +		dev_err(wdt->hw->dev,
> +			"Failed to request watchdog device IRQ.\n");
> +		goto error;
> +	}
> +
> +	ret = watchdog_register_device(&wdt->wdtdev);
> +	if (ret < 0) {
> +		dev_err(wdt->hw->dev,
> +			"watchdog registration incomplete (%d)\n", ret);

incomplete ? Should that be "failed" ?

> +		goto error;
> +	}
> +
> +	da9062_set_window_start(wdt);
> +
> +	ret = da9062_wdt_ping(&wdt->wdtdev);
> +	if (ret < 0)
> +		watchdog_unregister_device(&wdt->wdtdev);
> +
> +error:
> +	return ret;
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
> +MODULE_AUTHOR("S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>");
> +MODULE_DESCRIPTION("WDT device driver for Dialog DA9062");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform: da9062-watchdog");
>
Normally I don't see a space between "platform" and the driver name.
Does this work ?

Thanks,
Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
