From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/9] Input: goodix - Add vcc-supply
 regulator support
Date: Mon, 3 Dec 2018 11:13:24 -0800
Message-ID: <20181203191324.GA257010@dtor-ws>
References: <20181203101547.16835-1-jagan@amarulasolutions.com>
 <20181203101547.16835-6-jagan@amarulasolutions.com>
Reply-To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBDP6N55ZUYDRBWMAS3QAKGQEQO74IPY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20181203101547.16835-6-jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Dec 03, 2018 at 03:45:44PM +0530, Jagan Teki wrote:
> vcc-supply property is need for some Goodix CTP controller like GT5663
> where 3.3V external pull-up regulator connected via controller VCC pin.
> 
> So, enable the regulator for those it attached the vcc-supply.
> 
> Signed-off-by: Jagan Teki <jagan-dyjBcgdgk7Pe9wHmmfpqLFaTQe2KTcn/@public.gmane.org>
> ---
>  drivers/input/touchscreen/goodix.c | 39 ++++++++++++++++++++++++++----
>  1 file changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index f2d9c2c41885..7adcf1491609 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -27,6 +27,7 @@
>  #include <linux/delay.h>
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
>  #include <linux/of.h>
> @@ -47,6 +48,7 @@ struct goodix_ts_data {
>  	struct touchscreen_properties prop;
>  	unsigned int max_touch_num;
>  	unsigned int int_trigger_type;
> +	struct regulator *vcc;
>  	struct gpio_desc *gpiod_int;
>  	struct gpio_desc *gpiod_rst;
>  	u16 id;
> @@ -58,6 +60,7 @@ struct goodix_ts_data {
>  
>  #define GOODIX_GPIO_INT_NAME		"irq"
>  #define GOODIX_GPIO_RST_NAME		"reset"
> +#define GOODIX_VCC_CTP_NAME		"vcc"
>  
>  #define GOODIX_MAX_HEIGHT		4096
>  #define GOODIX_MAX_WIDTH		4096
> @@ -525,12 +528,24 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
>  {
>  	int error;
>  	struct device *dev;
> +	struct regulator *regulator;
>  	struct gpio_desc *gpiod;
>  
>  	if (!ts->client)
>  		return -EINVAL;
>  	dev = &ts->client->dev;
>  
> +	regulator = devm_regulator_get(dev, GOODIX_VCC_CTP_NAME);
> +	if (IS_ERR(regulator)) {
> +		error = PTR_ERR(regulator);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get vcc regulator: %d\n",
> +				error);
> +		return error;
> +	}
> +
> +	ts->vcc = regulator;
> +
>  	/* Get the interrupt GPIO pin number */
>  	gpiod = devm_gpiod_get_optional(dev, GOODIX_GPIO_INT_NAME, GPIOD_IN);
>  	if (IS_ERR(gpiod)) {
> @@ -786,25 +801,34 @@ static int goodix_ts_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> +	/* power the controller */
> +	if (ts->vcc) {

ts->vcc is never NULL.

> +		error = regulator_enable(ts->vcc);
> +		if (error) {
> +			dev_err(&client->dev, "Controller fail to enable vcc\n");
> +			return error;
> +		}
> +	}
> +
>  	if (ts->gpiod_int && ts->gpiod_rst) {
>  		/* reset the controller */
>  		error = goodix_reset(ts);
>  		if (error) {
>  			dev_err(&client->dev, "Controller reset failed.\n");
> -			return error;
> +			goto error;
>  		}
>  	}
>  
>  	error = goodix_i2c_test(client);
>  	if (error) {
>  		dev_err(&client->dev, "I2C communication failure: %d\n", error);
> -		return error;
> +		goto error;
>  	}
>  
>  	error = goodix_read_version(ts);
>  	if (error) {
>  		dev_err(&client->dev, "Read version failed.\n");
> -		return error;
> +		goto error;
>  	}
>  
>  	ts->chip = goodix_get_chip_data(ts->id);
> @@ -823,17 +847,22 @@ static int goodix_ts_probe(struct i2c_client *client,
>  			dev_err(&client->dev,
>  				"Failed to invoke firmware loader: %d\n",
>  				error);
> -			return error;
> +			goto error;
>  		}
>  
>  		return 0;
>  	} else {
>  		error = goodix_configure_dev(ts);
>  		if (error)
> -			return error;
> +			goto error;
>  	}
>  
>  	return 0;
> +
> +error:
> +	if (ts->vcc)
> +		regulator_disable(ts->vcc);

Same here.

> +	return error;
>  }
>  
>  static int goodix_ts_remove(struct i2c_client *client)

You need to disable regulator on removal as well.

Thanks.

-- 
Dmitry
