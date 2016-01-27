From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] input: touchscreen: ad7879: add device tree support
Date: Wed, 27 Jan 2016 15:38:56 -0800
Message-ID: <20160127233856.GD28687@dtor-ws>
References: <1453777477-29706-1-git-send-email-stefan@agner.ch>
 <1453777477-29706-3-git-send-email-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1453777477-29706-3-git-send-email-stefan-XLVq0VzYD2Y@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Cc: michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, realmz6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Stefan,

On Mon, Jan 25, 2016 at 07:04:37PM -0800, Stefan Agner wrote:
> Add device tree support for the I2C variant of AD7879 (AD7879-1). This
> allows to specify the touchscreen controller as a I2C client node.
> Most of the options available as platform data are also available as
> device tree properties. Exporting the GPIO is currently not possible
> through device tree.
> 
> Signed-off-by: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/ad7879-i2c.txt      | 47 ++++++++++++++++
>  drivers/input/touchscreen/ad7879-i2c.c             | 63 +++++++++++++++++++++-
>  drivers/input/touchscreen/ad7879-spi.c             |  3 +-
>  drivers/input/touchscreen/ad7879.c                 |  2 +-
>  drivers/input/touchscreen/ad7879.h                 |  1 +
>  5 files changed, 113 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ad7879-i2c.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ad7879-i2c.txt b/Documentation/devicetree/bindings/input/touchscreen/ad7879-i2c.txt
> new file mode 100644
> index 0000000..bf169a2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/ad7879-i2c.txt
> @@ -0,0 +1,47 @@
> +* Analog Devices AD7879-1/AD7889-1 touchscreen interface (I2C)
> +
> +Required properties:
> +- compatible: must be "adi,ad7879-1"
> +- reg: i2c slave address
> +- interrupt-parent: the phandle for the interrupt controller
> +- interrupts: touch controller interrupt
> +- resistance-plate-x		: total resistance of X-plate (for pressure
> +				  calculation)
> +- touchscreen-max-pressure	: maximum reported pressure
> +- touchscreen-swapped-x-y	: X and Y axis are swapped (boolean)
> +				  Swapping is done after inverting the axis
> +Optional properties:
> +- first-conversion-delay	: 0-12 in 128us steps (starting with 128us)
> +				  13: 2.560ms
> +				  14: 3.584ms
> +				  15: 4.096ms
> +- acquisition-time		: 0: 2us
> +				  1: 4us
> +				  2: 8us
> +				  3: 16us
> +- median-filter-size		: 0: disabled
> +				  1: 4 measurements
> +				  2: 8 measurements
> +				  3: 16 measurements
> +- averaging			: 0: 2 middle values (1 if median disabled)
> +				  1: 4 middle values
> +				  2: 8 middle values
> +				  3: 16 values
> +- conversion-interval:		: 0: convert one time only
> +				  1-255: 515us + val * 35us (up to 9.440ms)
> +
> +Example:
> +
> +	ad7879@2c {
> +		compatible = "adi,ad7879-1";
> +		reg = <0x2c>;
> +		interrupt-parent = <&gpio1>;
> +		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
> +		resistance-plate-x = <120>;
> +		touchscreen-max-pressure = <4096>;
> +		first-conversion-delay = /bits/ 8 <3>;
> +		acquisition-time = /bits/ 8 <1>;
> +		median-filter-size = /bits/ 8 <2>;
> +		averaging = /bits/ 8 <1>;
> +		conversion-interval = /bits/ 8 <255>;
> +	};
> diff --git a/drivers/input/touchscreen/ad7879-i2c.c b/drivers/input/touchscreen/ad7879-i2c.c
> index d66962c..08a2c9a 100644
> --- a/drivers/input/touchscreen/ad7879-i2c.c
> +++ b/drivers/input/touchscreen/ad7879-i2c.c
> @@ -11,6 +11,7 @@
>  #include <linux/module.h>
>  #include <linux/types.h>
>  #include <linux/pm.h>
> +#include <linux/input/ad7879.h>
>  
>  #include "ad7879.h"
>  
> @@ -54,9 +55,50 @@ static const struct ad7879_bus_ops ad7879_i2c_bus_ops = {
>  	.write		= ad7879_i2c_write,
>  };
>  
> +static struct ad7879_platform_data *ad7879_parse_dt(struct device *dev)
> +{
> +	struct ad7879_platform_data *pdata;
> +	struct device_node *np = dev->of_node;
> +	int err;
> +	u32 tmp;
> +
> +	if (!np)
> +		return NULL;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	err = of_property_read_u32(np, "resistance-plate-x", &tmp);
> +	if (err) {
> +		dev_err(dev, "failed to get resistance-plate-x property\n");
> +		return ERR_PTR(err);
> +	}
> +	pdata->x_plate_ohms = (u16)tmp;
> +
> +	err = of_property_read_u32(np, "touchscreen-max-pressure", &tmp);
> +	if (err) {
> +		dev_err(dev, "failed to get touchscreen-max-pressure property\n");
> +		return ERR_PTR(err);
> +	}
> +	pdata->pressure_min = (u16)tmp;
> +
> +	of_property_read_u8(np, "first-conversion-delay", &pdata->first_conversion_delay);
> +	of_property_read_u8(np, "acquisition-time", &pdata->acquisition_time);
> +	of_property_read_u8(np, "median-filter-size", &pdata->median);
> +	of_property_read_u8(np, "averaging", &pdata->averaging);
> +	of_property_read_u8(np, "conversion-interval", &pdata->pen_down_acc_interval);
> +
> +	pdata->swap_xy = of_property_read_bool(np, "touchscreen-swapped-x-y");

I'd prefer if we used device_property_* API instead of of_property_*, so
that properties would work not only on OF, but also on other platforms
and even legacy boards could potentially be converted to properties.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
