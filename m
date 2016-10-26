From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 07/10] Input: da9061: onkey driver
Date: Wed, 26 Oct 2016 15:50:05 -0700
Message-ID: <20161026225005.GA27930@dtor-ws>
References: <cover.1477501000.git.stwiss.opensource@diasemi.com>
 <29f73d4d4718cc5848c0414ea60f865ef39bd2cf.1477501000.git.stwiss.opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35393 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932584AbcJZWuJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Oct 2016 18:50:09 -0400
Content-Disposition: inline
In-Reply-To: <29f73d4d4718cc5848c0414ea60f865ef39bd2cf.1477501000.git.stwiss.opensource@diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, DEVICETREE <devicetree@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>

On Wed, Oct 26, 2016 at 05:56:39PM +0100, Steve Twiss wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> Copyright header is updated to add DA9061 in its description and the module
> description macro is extended to include DA9061.
> 
> Minor change to the code, alters dev_dbg() statements to report a generic
> "PMIC" instead of DA9063. This device driver is compatible with DA9061,
> DA9062 and DA9063.
> 
> Kconfig is updated to reflect support for DA9061/62/63.
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

Applied, thank you.

> 
> ---
> This patch applies against linux-next and v4.8
> 
> v1 -> v2
>  - Patch renamed from [PATCH V1 03/10] to [PATCH V2 07/10] -- these
>    changes were made to fix checkpatch warnings caused by the patch
>    set dependency order
>  - Revert changes for DA9061 specific compatible changes.
> 
> Dmitry,
> 
> Alterations made in accordance with previous e-mail thread on the use of
> compatible strings: https://lkml.org/lkml/2016/10/7/641
> Now assuming the use of a fallback compatible string in the DT.
> compatible = "dlg,da9061-onkey", "dlg,da9062-onkey";
> 
> Regards,
> Steve Twiss, Dialog Semiconductor Ltd.
> 
> 
>  drivers/input/misc/Kconfig        | 7 ++++---
>  drivers/input/misc/da9063_onkey.c | 8 ++++----
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index efb0ca8..57cc9c2 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -613,11 +613,12 @@ config INPUT_DA9055_ONKEY
>  	  will be called da9055_onkey.
>  
>  config INPUT_DA9063_ONKEY
> -	tristate "Dialog DA9062/63 OnKey"
> +	tristate "Dialog DA9063/62/61 OnKey"
>  	depends on MFD_DA9063 || MFD_DA9062
>  	help
> -	  Support the ONKEY of Dialog DA9063 and DA9062 Power Management ICs
> -	  as an input device capable of reporting the power button status.
> +	  Support the ONKEY of Dialog DA9063, DA9062 and DA9061 Power
> +	  Management ICs as an input device capable of reporting the
> +	  power button status.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called da9063_onkey.
> diff --git a/drivers/input/misc/da9063_onkey.c b/drivers/input/misc/da9063_onkey.c
> index bb863e0..dff6fe5 100644
> --- a/drivers/input/misc/da9063_onkey.c
> +++ b/drivers/input/misc/da9063_onkey.c
> @@ -1,5 +1,5 @@
>  /*
> - * OnKey device driver for DA9063 and DA9062 PMICs
> + * OnKey device driver for DA9063, DA9062 and DA9061 PMICs
>   * Copyright (C) 2015  Dialog Semiconductor Ltd.
>   *
>   * This program is free software; you can redistribute it and/or
> @@ -149,13 +149,13 @@ static void da9063_poll_on(struct work_struct *work)
>  			 * and then send shutdown command
>  			 */
>  			dev_dbg(&onkey->input->dev,
> -				"Sending SHUTDOWN to DA9063 ...\n");
> +				"Sending SHUTDOWN to PMIC ...\n");
>  			error = regmap_write(onkey->regmap,
>  					     config->onkey_shutdown,
>  					     config->onkey_shutdown_mask);
>  			if (error)
>  				dev_err(&onkey->input->dev,
> -					"Cannot SHUTDOWN DA9063: %d\n",
> +					"Cannot SHUTDOWN PMIC: %d\n",
>  					error);
>  		}
>  	}
> @@ -300,6 +300,6 @@ static struct platform_driver da9063_onkey_driver = {
>  module_platform_driver(da9063_onkey_driver);
>  
>  MODULE_AUTHOR("S Twiss <stwiss.opensource@diasemi.com>");
> -MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063 and DA9062");
> +MODULE_DESCRIPTION("Onkey device driver for Dialog DA9063, DA9062 and DA9061");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:" DA9063_DRVNAME_ONKEY);
> -- 
> end-of-patch for PATCH V2
> 

-- 
Dmitry
