From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/3] Input: cyttsp - add device tree bindings
Date: Mon, 11 Jan 2016 10:30:03 -0800
Message-ID: <20160111183003.GA22646@dtor-ws>
References: <cover.1452447124.git.oreste.salerno@tomtom.com>
 <dd329fe3420fba4049c353a9a092ff9c45c5a252.1452447124.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <dd329fe3420fba4049c353a9a092ff9c45c5a252.1452447124.git.oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oreste Salerno <oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fery-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Oreste,

On Sun, Jan 10, 2016 at 06:36:08PM +0100, Oreste Salerno wrote:
> Signed-off-by: Oreste Salerno <oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/cyttsp.txt          |  82 +++++++++++++
>  drivers/input/touchscreen/cyttsp_core.c            | 134 +++++++++++++++++++--
>  include/linux/input/cyttsp.h                       |   3 +
>  3 files changed, 212 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt b/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> new file mode 100644
> index 0000000..2dc5c65
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/cyttsp.txt
> @@ -0,0 +1,82 @@
> +* Cypress cyttsp touchscreen controller
> +
> +Required properties:
> +- compatible		: must be "cypress,cyttsp-i2c" or "cypress,cyttsp-spi"
> +- reg			: Device I2C address or SPI chip select number
> +- spi-max-frequency 	: Maximum SPI clocking speed of the device (for cyttsp-spi)

Stray space before tab after spi-max-frequency.

> +- interrupt-parent	: the phandle for the gpio controller
> +			  (see interrupt binding[0]).
> +- interrupts		: (gpio) interrupt to which the chip is connected
> +			  (see interrupt binding[0]).
> +- reset-gpios		: the reset gpio the chip is connected to
> +			  (see GPIO binding[1] for more details).
> +- touchscreen-size-x	: horizontal resolution of touchscreen (in pixels)
> +- touchscreen-size-y	: vertical resolution of touchscreen (in pixels)

Let's direct users to common touchscreen properties.

> +- bootloader-key	: the 8-byte bootloader key that is required to switch
> +			  the chip from bootloader mode (default mode) to
> +			  application mode.
> +			  This property has to be specified as an array of 8
> +			  '/bits/ 8' values.
> +
> +Optional properties:
> +- active-distance	: the distance in pixels beyond which a touch must move
> +			  before movement is detected and reported by the device.
> +			  Valid values: 0-15.
> +- active-interval-ms	: the minimum period in ms between consecutive
> +			  scanning/processing cycles when the chip is in active mode.
> +			  Valid values: 0-255.
> +- lowpower-interval-ms	: the minimum period in ms between consecutive
> +			  scanning/processing cycles when the chip is in low-power mode.
> +			  Valid values: 0-2550
> +- touch-timeout-ms	: minimum time in ms spent in the active power state while no
> +			  touches are detected before entering low-power mode.
> +			  Valid values: 0-2550
> +
> +[0]: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> +[1]: Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Example:
> +	&i2c1 {
> +		/* ... */
> +		cyttsp@a {
> +			compatible = "cypress,cyttsp-i2c";
> +			reg = <0xa>;
> +			interrupt-parent = <&msm_gpio>;
> +			interrupts = <13 0x2008>;
> +			reset-gpios = <&msm_gpio 12 0x00>;
> +
> +			touchscreen-size-x = <800>;
> +			touchscreen-size-y = <480>;
> +			bootloader-key = /bits/ 8 <0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08>;
> +
> +			active-distance = <8>;
> +			active-interval-ms = <0>;
> +			lowpower-interval-ms = <200>;
> +			touch-timeout-ms = <100>;
> +		};
> +
> +		/* ... */
> +	};
> +
> +	&mcspi1 {
> +		/* ... */
> +		cyttsp@0 {
> +			compatible = "cypress,cyttsp-spi";
> +			spi-max-frequency = <6000000>;
> +			reg = <0>;
> +			interrupt-parent = <&msm_gpio>;
> +			interrupts = <13 0x2008>;
> +			reset-gpios = <&msm_gpio 12 0x00>;
> +
> +			touchscreen-size-x = <800>;
> +			touchscreen-size-y = <480>;
> +			bootloader-key = /bits/ 8 <0x01 0x02 0x03 0x04 0x05 0x06 0x07 0x08>;
> +
> +			active-distance = <8>;
> +			active-interval-ms = <0>;
> +			lowpower-interval-ms = <200>;
> +			touch-timeout-ms = <100>;
> +		};
> +
> +		/* ... */
> +	};
> diff --git a/drivers/input/touchscreen/cyttsp_core.c b/drivers/input/touchscreen/cyttsp_core.c
> index 5b74e8b..5dc6bf6 100644
> --- a/drivers/input/touchscreen/cyttsp_core.c
> +++ b/drivers/input/touchscreen/cyttsp_core.c
> @@ -33,6 +33,8 @@
>  #include <linux/gpio.h>
>  #include <linux/interrupt.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/gpio/consumer.h>
>  
>  #include "cyttsp_core.h"
>  
> @@ -57,6 +59,7 @@
>  #define CY_DELAY_DFLT			20 /* ms */
>  #define CY_DELAY_MAX			500
>  #define CY_ACT_DIST_DFLT		0xF8
> +#define CY_ACT_DIST_MASK		0x0F
>  #define CY_HNDSHK_BIT			0x80
>  /* device mode bits */
>  #define CY_OPERATE_MODE			0x00
> @@ -528,18 +531,136 @@ static void cyttsp_close(struct input_dev *dev)
>  		cyttsp_disable(ts);
>  }
>  
> +#ifdef CONFIG_OF
> +static const struct cyttsp_platform_data *cyttsp_parse_dt(struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct cyttsp_platform_data *pdata;
> +	u32 dt_value;
> +	int ret;
> +	static const char err_msg[] =
> +		"property not provided in the device tree";
> +
> +	if (!np)
> +		return ERR_PTR(-ENOENT);
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pdata->bl_keys = devm_kzalloc(dev, CY_NUM_BL_KEYS, GFP_KERNEL);
> +	if (!pdata->bl_keys)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Set some default values */
> +	pdata->act_dist = CY_ACT_DIST_DFLT;
> +	pdata->act_intrvl = CY_ACT_INTRVL_DFLT;
> +	pdata->tch_tmout = CY_TCH_TMOUT_DFLT;
> +	pdata->lp_intrvl = CY_LP_INTRVL_DFLT;
> +	pdata->name = "cyttsp";
> +
> +	ret = of_property_read_u32(np, "touchscreen-size-x", &pdata->maxx);
> +	if (ret) {
> +		dev_err(dev, "touchscreen-size-x %s\n", err_msg);
> +		return ERR_PTR(ret);
> +	}
> +
> +	ret = of_property_read_u32(np, "touchscreen-size-y", &pdata->maxy);
> +	if (ret) {
> +		dev_err(dev, "touchscreen-size-y %s\n", err_msg);
> +		return ERR_PTR(ret);
> +	}

I'd rather we called touchscreen_parse_properties() in common code when
setting up the input device. It should work for variety of platform
providers (OF, ACPI, etc).

> +
> +	pdata->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(pdata->reset_gpio)) {
> +		ret = PTR_ERR(pdata->reset_gpio);
> +		dev_err(dev, "error acquiring reset gpio: %d\n", ret);
> +		return ERR_PTR(ret);
> +	}

Please call it directly in probe(). Again, it should work fine not only
on OF, but on all other platforms, so 

> +
> +	ret = of_property_read_u8_array(np, "bootloader-key",
> +			pdata->bl_keys, CY_NUM_BL_KEYS);
> +	if (ret) {
> +		dev_err(dev, "bootloader-key %s\n", err_msg);
> +		return ERR_PTR(ret);
> +	}
> +
> +	if (!of_property_read_u32(np, "active-distance", &dt_value)) {
> +		if (dt_value > 15) {
> +			dev_err(dev, "active-distance (%u) must be [0-15]\n",
> +				dt_value);
> +			return ERR_PTR(-EINVAL);
> +		}
> +		pdata->act_dist &= ~CY_ACT_DIST_MASK;
> +		pdata->act_dist |= (u8)dt_value;

I do not think you need to cast.

> +	}
> +
> +	if (!of_property_read_u32(np, "active-interval-ms", &dt_value)) {
> +		if (dt_value > 255) {
> +			dev_err(dev, "active-interval-ms (%u) must be [0-255]\n",
> +				dt_value);
> +			return ERR_PTR(-EINVAL);
> +		}
> +		pdata->act_intrvl = (u8)dt_value;

I do not think you need to cast.

> +	}
> +
> +	if (!of_property_read_u32(np, "lowpower-interval-ms", &dt_value)) {
> +		if (dt_value > 2550) {
> +			dev_err(dev, "lowpower-interval-ms (%u) must be [0-2550]\n",
> +				dt_value);
> +			return ERR_PTR(-EINVAL);
> +		}
> +		/* Register value is expressed in 0.01s / bit */
> +		pdata->lp_intrvl = (u8)(dt_value/10);

Spaces around operations please. Do we need explicit cast here?

> +	}
> +
> +	if (!of_property_read_u32(np, "touch-timeout-ms", &dt_value)) {
> +		if (dt_value > 2550) {
> +			dev_err(dev, "touch-timeout-ms (%u) must be [0-2550]\n",
> +				dt_value);
> +			return ERR_PTR(-EINVAL);
> +		}
> +		/* Register value is expressed in 0.01s / bit */
> +		pdata->tch_tmout = (u8)(dt_value/10);

Spaces around operations please. Do we need explicit cast here?

> +	}
> +
> +	return pdata;
> +}
> +#else
> +static const struct cyttsp_platform_data *cyttsp_parse_dt(struct device *dev)
> +{
> +	return ERR_PTR(-ENOENT);
> +}
> +#endif
> +
> +static const struct cyttsp_platform_data *
> +cyttsp_get_platform_data(struct device *dev)
> +{
> +	const struct cyttsp_platform_data *pdata;
> +
> +	pdata = dev_get_platdata(dev);
> +	if (pdata)
> +		return pdata;
> +
> +	pdata = cyttsp_parse_dt(dev);
> +	if (!IS_ERR(pdata) || PTR_ERR(pdata) != -ENOENT)
> +		return pdata;
> +
> +	dev_err(dev, "No platform data specified\n");
> +	return ERR_PTR(-EINVAL);
> +}
> +
>  struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
>  			    struct device *dev, int irq, size_t xfer_buf_size)
>  {
> -	const struct cyttsp_platform_data *pdata = dev_get_platdata(dev);
> +	const struct cyttsp_platform_data *pdata;
>  	struct cyttsp *ts;
>  	struct input_dev *input_dev;
>  	int error;
>  
> -	if (!pdata || !pdata->name || irq <= 0) {
> -		error = -EINVAL;
> -		goto err_out;
> -	}
> +	pdata = cyttsp_get_platform_data(dev);
> +	if (IS_ERR(pdata))
> +		return ERR_CAST(pdata);
>  
>  	ts = kzalloc(sizeof(*ts) + xfer_buf_size, GFP_KERNEL);
>  	input_dev = input_allocate_device();
> @@ -550,7 +671,7 @@ struct cyttsp *cyttsp_probe(const struct cyttsp_bus_ops *bus_ops,
>  
>  	ts->dev = dev;
>  	ts->input = input_dev;
> -	ts->pdata = dev_get_platdata(dev);
> +	ts->pdata = pdata;
>  	ts->bus_ops = bus_ops;
>  	ts->irq = irq;
>  
> @@ -618,7 +739,6 @@ err_platform_exit:
>  err_free_mem:
>  	input_free_device(input_dev);
>  	kfree(ts);
> -err_out:
>  	return ERR_PTR(error);
>  }
>  EXPORT_SYMBOL_GPL(cyttsp_probe);
> diff --git a/include/linux/input/cyttsp.h b/include/linux/input/cyttsp.h
> index d7c2520..92a9d52 100644
> --- a/include/linux/input/cyttsp.h
> +++ b/include/linux/input/cyttsp.h
> @@ -29,6 +29,8 @@
>  #ifndef _CYTTSP_H_
>  #define _CYTTSP_H_
>  
> +#include <linux/gpio/consumer.h>
> +
>  #define CY_SPI_NAME "cyttsp-spi"
>  #define CY_I2C_NAME "cyttsp-i2c"
>  /* Active Power state scanning/processing refresh interval */
> @@ -51,6 +53,7 @@ struct cyttsp_platform_data {
>  	int (*init)(void);
>  	void (*exit)(void);
>  	char *name;
> +	struct gpio_desc *reset_gpio;

No, we shoudl not be passing gpio descriptor in platform data. For
non-of non-ACPI system gpiod_* framework allows boards to specify lookup
tables so they can use that. Just drop it form here.

>  	u8 *bl_keys;
>  };
>  
> -- 
> 1.9.1
> 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
