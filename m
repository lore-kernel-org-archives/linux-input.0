From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCHv5 4/6] mfd: da9052: make touchscreen registration optional
Date: Mon, 17 Jul 2017 15:34:44 +0100
Message-ID: <20170717143444.i5zlzwrbd76bhq4z@dell>
References: <20170703084003.31184-1-sebastian.reichel@collabora.co.uk>
 <20170703084003.31184-5-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-hwmon-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170703084003.31184-5-sebastian.reichel@collabora.co.uk>
Sender: linux-hwmon-owner@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Support Opensource <support.opensource@diasemi.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 03 Jul 2017, Sebastian Reichel wrote:

> If the touchscreen pins are used as general purpose analogue
> input, the touchscreen driver should not be used. The pins
> will be handled by the existing hwmon driver instead.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  drivers/mfd/da9052-core.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mfd/da9052-core.c b/drivers/mfd/da9052-core.c
> index 977418ca9117..a671c18381d7 100644
> --- a/drivers/mfd/da9052-core.c
> +++ b/drivers/mfd/da9052-core.c
> @@ -18,6 +18,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  
>  #include <linux/mfd/da9052/da9052.h>
>  #include <linux/mfd/da9052/pdata.h>
> @@ -521,9 +522,6 @@ static const struct mfd_cell da9052_subdev_info[] = {
>  		.name = "da9052-wled3",
>  	},
>  	{
> -		.name = "da9052-tsi",
> -	},
> -	{
>  		.name = "da9052-bat",
>  	},
>  	{
> @@ -531,6 +529,12 @@ static const struct mfd_cell da9052_subdev_info[] = {
>  	},
>  };
>  
> +static const struct mfd_cell da9052_tsi_subdev_info[] = {
> +	{
> +		.name = "da9052-tsi",
> +	},
> +};

I normally prefer these one a single line.

Once fixed:

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

>  const struct regmap_config da9052_regmap_config = {
>  	.reg_bits = 8,
>  	.val_bits = 8,
> @@ -621,9 +625,27 @@ int da9052_device_init(struct da9052 *da9052, u8 chip_id)
>  		goto err;
>  	}
>  
> +	/*
> +	 * Check if touchscreen pins are used are analogue input instead
> +	 * of having a touchscreen connected to them. The analogue input
> +	 * functionality will be provided by hwmon driver (if enabled).
> +	 */
> +	if (!device_property_read_bool(da9052->dev, "dlg,tsi-as-adc")) {
> +		ret = mfd_add_devices(da9052->dev, PLATFORM_DEVID_AUTO,
> +				      da9052_tsi_subdev_info,
> +				      ARRAY_SIZE(da9052_tsi_subdev_info),
> +				      NULL, 0, NULL);
> +		if (ret) {
> +			dev_err(da9052->dev, "failed to add TSI subdev: %d\n",
> +				ret);
> +			goto err;
> +		}
> +	}
> +
>  	return 0;
>  
>  err:
> +	mfd_remove_devices(da9052->dev);
>  	da9052_irq_exit(da9052);
>  
>  	return ret;

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
