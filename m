From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH V3 7/9] watchdog: da9062/61: watchdog driver
Date: Mon, 31 Oct 2016 09:28:12 -0700
Message-ID: <67988f02-8021-5088-7100-3eb0722bb312@roeck-us.net>
References: <cover.1477929725.git.stwiss.opensource@diasemi.com>
 <45b99f01747a87dbee2529fa34e61883fceabcfc.1477929725.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <45b99f01747a87dbee2529fa34e61883fceabcfc.1477929725.git.stwiss.opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Wim Van Sebroeck <wim@iguana.be>
Cc: DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-input@vger.kernel.org

On 10/31/2016 09:02 AM, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
>
> The of_device_id match array is added to support "dlg,da9062-watchdog"
> as a valid .compatible string. A MODULE_DEVICE_TABLE() macro is added.
>
> This patch assumes the use of a DA9062 fallback compatible string for the
> DTS to pick up the DA9062 device driver for use with the DA9061 watchdog
> hardware
>
> Copyright header is updated to add DA9061 in its description and the module
> description macro is extended to include DA9061.
>
> Kconfig is updated to reflect support for DA9061/62.
>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

>
> ---
> This patch applies against linux-next and v4.8
>
> v2 -> v3
>  - Patch renamed from [PATCH V2 08/10] to [PATCH V3 7/9]
>  - Removal of match->data and of_match_node search. There is only one
>    compatible string now. and delete the .data = &da9062_watchdog_info
>    association in the struct of_device_id compatible table.
>  - Addition of MODULE_DEVICE_TABLE macro to allow modinfo additions:
>    da9062_wdt.ko platform:da9062_watchdog
>                  of:N*T*Cdlg,da9062_watchdogC*
>                  of:N*T*Cdlg,da9062_watchdog
>
> v1 -> v2
>  - Patch renamed from [PATCH V1 04/10] to [PATCH V2 08/10] -- these
>    changes were made to fix checkpatch warnings caused by the patch
>    set dependency order
>  - Removal of the DA9061 compatible entries for this device driver.
>  - Additional explanation in the patch description for the use of a
>    fall-back compatible DTS string
>
> Guenter,
>
> Alterations have been made in accordance with the previous e-mail thread
> on the use of compatible strings: https://lkml.org/lkml/2016/10/7/641
> This patch now assumes the use of a fallback compatible string in the DTS.
> Of the form: compatible = "dlg,da9061-watchdog", "dlg,da9062-watchdog";
>
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
>
>
>  drivers/watchdog/Kconfig      |  4 ++--
>  drivers/watchdog/da9062_wdt.c | 12 ++++++++++--
>  2 files changed, 12 insertions(+), 4 deletions(-)
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
>  	depends on MFD_DA9062
>  	select WATCHDOG_CORE
>  	help
> -	  Support for the watchdog in the DA9062 PMIC.
> +	  Support for the watchdog in the DA9062 and DA9061 PMICs.
>
>  	  This driver can be built as a module. The module name is da9062_wdt.
>
> diff --git a/drivers/watchdog/da9062_wdt.c b/drivers/watchdog/da9062_wdt.c
> index 7386111..a02cee6 100644
> --- a/drivers/watchdog/da9062_wdt.c
> +++ b/drivers/watchdog/da9062_wdt.c
> @@ -1,5 +1,5 @@
>  /*
> - * da9062_wdt.c - WDT device driver for DA9062
> + * Watchdog device driver for DA9062 and DA9061 PMICs
>   * Copyright (C) 2015  Dialog Semiconductor Ltd.
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -188,6 +188,13 @@ static const struct watchdog_ops da9062_watchdog_ops = {
>  	.set_timeout = da9062_wdt_set_timeout,
>  };
>
> +static const struct of_device_id da9062_compatible_id_table[] = {
> +	{ .compatible = "dlg,da9062-watchdog", },
> +	{ },
> +};
> +
> +MODULE_DEVICE_TABLE(of, da9062_compatible_id_table);
> +
>  static int da9062_wdt_probe(struct platform_device *pdev)
>  {
>  	int ret;
> @@ -244,11 +251,12 @@ static struct platform_driver da9062_wdt_driver = {
>  	.remove = da9062_wdt_remove,
>  	.driver = {
>  		.name = "da9062-watchdog",
> +		.of_match_table = da9062_compatible_id_table,
>  	},
>  };
>  module_platform_driver(da9062_wdt_driver);
>
>  MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
> -MODULE_DESCRIPTION("WDT device driver for Dialog DA9062");
> +MODULE_DESCRIPTION("WDT device driver for Dialog DA9062 and DA9061");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:da9062-watchdog");
>

