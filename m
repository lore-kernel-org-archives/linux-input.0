From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6] input: drv260x: Add TI drv260x haptics driver
Date: Tue, 19 Aug 2014 12:24:01 -0700
Message-ID: <20140819192401.GA32080@core.coreip.homeip.net>
References: <1408117670-19750-1-git-send-email-dmurphy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408117670-19750-1-git-send-email-dmurphy-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Dan,

On Fri, Aug 15, 2014 at 10:47:50AM -0500, Dan Murphy wrote:
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index 2ff4425..99f6762 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -676,4 +676,13 @@ config INPUT_SOC_BUTTON_ARRAY
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called soc_button_array.
>  
> +config INPUT_DRV260X_HAPTICS
> +	tristate "TI DRV260X haptics support"
> +	depends on INPUT && I2C

This also needs "select REGMAP_I2C"

> +	help
> +	  Say Y to enable support for the TI DRV260X haptics driver.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called drv260x-haptics.
> +

[...]

> +#ifndef _LINUX_DRV260X_PDATA_H
> +#define _LINUX_DRV260X_PDATA_H
> +
> +struct drv260x_platform_data {
> +	int enable_gpio;

I do not see this used anywhere.

> +	u32 library_selection;
> +	u32 mode;
> +	u32 vib_rated_voltage;
> +	u32 vib_overdrive_voltage;
> +};
> +
> +#endif

I fixed up the above issues and did a few more formatting changes and applied
to my 'next' branch. Please take a peek and holler if you see something wrong.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
