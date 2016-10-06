From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH V1 04/10] watchdog: da9061: watchdog driver
Date: Thu, 6 Oct 2016 06:28:21 -0700
Message-ID: <0590ec12-15ad-bb12-28db-c4c3ad7b5c01@roeck-us.net>
References: <cover.1475743411.git.stwiss.opensource@diasemi.com>
 <cb234a7d84a8a82d6da8ea7e80f48cdee02b9de2.1475743411.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cb234a7d84a8a82d6da8ea7e80f48cdee02b9de2.1475743411.git.stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, LINUX-KERNEL <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-WATCHDOG <linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wim Van Sebroeck <wim-IQzOog9fTRqzQB+pC5nmwQ@public.gmane.org>
Cc: DEVICETREE <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LINUX-INPUT <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LINUX-PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Support Opensource <support.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 10/06/2016 01:43 AM, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>
> Support for the DA9061 watchdog is added into the DA9062 watchdog driver.
>
> The of_device_id match array is expanded to support "dlg,da9061-watchdog"
> as a valid .compatible string. A new watchdog_info structure is added and
> linked to this device tree compatible string in the .data section. Extra
> code is added into the probe function to search-for and assign this match
> data.
>
> Copyright header is updated to add DA9061 in its description and the module
> description macro is extended to include DA9061.
>
> Kconfig is updated to reflect support for DA9061/62.
>
> Signed-off-by: Steve Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
>
> ---
> This patch applies against linux-next and v4.8
>
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
>
>
>  drivers/watchdog/Kconfig      |  4 ++--
>  drivers/watchdog/da9062_wdt.c | 24 +++++++++++++++++++++---
>  2 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 1bffe00..d6b4088 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -104,11 +104,11 @@ config DA9063_WATCHDOG
>  	  This driver can be built as a module. The module name is da9063_wdt.
>
>  config DA9062_WATCHDOG
> -	tristate "Dialog DA9062 Watchdog"
> +	tristate "Dialog DA9062/61 Watchdog"

Please keep this in numerical order, and use "DA9061/62" Watchdog.
Same everywhere else.

>  	depends on MFD_DA9062
>  	select WATCHDOG_CORE
>  	help
> -	  Support for the watchdog in the DA9062 PMIC.
> +	  Support for the watchdog in the DA9062 and DA9061 PMICs.
>
>  	  This driver can be built as a module. The module name is da9062_wdt.
>
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index 7386111..5b9d408 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -1,5 +1,5 @@
>  /*
> - * da9062_wdt.c - WDT device driver for DA9062
> + * Watchdog device driver for DA9062 and DA9061 PMICs
>   * Copyright (C) 2015  Dialog Semiconductor Ltd.
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -180,6 +180,11 @@ static const struct watchdog_info da9062_watchdog_info = {
>  	.identity = "DA9062 WDT",
>  };
>
> +static const struct watchdog_info da9061_watchdog_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING,
> +	.identity = "DA9061 WDT",

This adds a lot of complexity to the driver just to be able to display "DA9061".
Why not just change the existing identity to "DA9061/DA9062 WDT" ?

> +};
> +
>  static const struct watchdog_ops da9062_watchdog_ops = {
>  	.owner = THIS_MODULE,
>  	.start = da9062_wdt_start,
> @@ -188,23 +193,35 @@ static const struct watchdog_ops da9062_watchdog_ops = {
>  	.set_timeout = da9062_wdt_set_timeout,
>  };
>
> +static const struct of_device_id da9062_compatible_id_table[] = {
> +	{ .compatible = "dlg,da9062-watchdog", .data = &da9062_watchdog_info },
> +	{ .compatible = "dlg,da9061-watchdog", .data = &da9061_watchdog_info },
> +	{ },
> +};
> +
>  static int da9062_wdt_probe(struct platform_device *pdev)
>  {
>  	int ret;
>  	struct da9062 *chip;
>  	struct da9062_watchdog *wdt;
> +	const struct of_device_id *match;
>
>  	chip = dev_get_drvdata(pdev->dev.parent);
>  	if (!chip)
>  		return -EINVAL;
>
> +	match = of_match_node(da9062_compatible_id_table,
> +			      pdev->dev.of_node);
> +	if (!match)
> +		return -ENXIO;
> +
>  	wdt = devm_kzalloc(&pdev->dev, sizeof(*wdt), GFP_KERNEL);
>  	if (!wdt)
>  		return -ENOMEM;
>
>  	wdt->hw = chip;
>
> -	wdt->wdtdev.info = &da9062_watchdog_info;
> +	wdt->wdtdev.info = (const struct watchdog_info *)match->data;
>  	wdt->wdtdev.ops = &da9062_watchdog_ops;
>  	wdt->wdtdev.min_timeout = DA9062_WDT_MIN_TIMEOUT;
>  	wdt->wdtdev.max_timeout = DA9062_WDT_MAX_TIMEOUT;
> @@ -244,11 +261,12 @@ static struct platform_driver da9062_wdt_driver = {
>  	.remove = da9062_wdt_remove,
>  	.driver = {
>  		.name = "da9062-watchdog",
> +		.of_match_table = da9062_compatible_id_table,
>  	},
>  };
>  module_platform_driver(da9062_wdt_driver);
>
>  MODULE_AUTHOR("S Twiss <stwiss.opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>");
> -MODULE_DESCRIPTION("WDT device driver for Dialog DA9062");
> +MODULE_DESCRIPTION("WDT device driver for Dialog DA9062 and DA9061");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:da9062-watchdog");
>

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
