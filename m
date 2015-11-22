From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] touchscreen: pixcir_i2c: Add support for
 wake and enable gpios
Date: Sun, 22 Nov 2015 16:19:50 -0600
Message-ID: <20151122221950.GA16428@rob-hp-laptop>
References: <1448207853-24256-1-git-send-email-hdegoede@redhat.com>
Reply-To: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDJIP47K7MERBC77ZCZAKGQEFUBOZVY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448207853-24256-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Sander Vermin <sander-wENMetUwf8VmR6Xm/wNWPw@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Sun, Nov 22, 2015 at 04:57:33PM +0100, Hans de Goede wrote:
> From: Sander Vermin <sander-wENMetUwf8VmR6Xm/wNWPw@public.gmane.org>
> 
> On some devices the wake and enable pins of the pixcir touchscreen
> controller are connected to gpios and these must be controlled by the
> driver for the device to operate properly.
> 
> Signed-off-by: Sander Vermin <sander-wENMetUwf8VmR6Xm/wNWPw@public.gmane.org>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> Changes in v2 (Hans de Goede):
> -Split the changes for dealing with inverted / swapped axis out into a
>  separate patch
> -Remove a bunch of dev_info calls to make the driver less chatty
> -Use devm_gpiod_get_optional as these new gpios are optional
> -Only msleep after setting enable high if we have an enable pin
> Changes in v3 (Hans de Goede):
> -Use "if (ts->gpio_foo)" instead of "if (!IS_ERR_OR_NULL(ts->foo))"
> -No need to set gpio-s to 1 after requesting them with GPIOD_OUT_HIGH
> ---
>  .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |  2 ++

For the binding:

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

>  drivers/input/touchscreen/pixcir_i2c_ts.c          | 40 ++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> index 8eb240a..72ca5ec 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt
> @@ -10,6 +10,8 @@ Required properties:
>  
>  Optional properties:
>  - reset-gpio: GPIO connected to the RESET line of the chip
> +- enable-gpios: GPIO connected to the ENABLE line of the chip
> +- wake-gpios: GPIO connected to the WAKE line of the chip
>  
>  Example:
>  
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index 211408c..22a67c6 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -38,6 +38,8 @@ struct pixcir_i2c_ts_data {
>  	struct input_dev *input;
>  	struct gpio_desc *gpio_attb;
>  	struct gpio_desc *gpio_reset;
> +	struct gpio_desc *gpio_enable;
> +	struct gpio_desc *gpio_wake;
>  	const struct pixcir_i2c_chip_data *chip;
>  	int max_fingers;	/* Max fingers supported in this instance */
>  	bool running;
> @@ -208,6 +210,11 @@ static int pixcir_set_power_mode(struct pixcir_i2c_ts_data *ts,
>  	struct device *dev = &ts->client->dev;
>  	int ret;
>  
> +	if (mode == PIXCIR_POWER_ACTIVE || mode == PIXCIR_POWER_IDLE) {
> +		if (ts->gpio_wake)
> +			gpiod_set_value_cansleep(ts->gpio_wake, 1);
> +	}
> +
>  	ret = i2c_smbus_read_byte_data(ts->client, PIXCIR_REG_POWER_MODE);
>  	if (ret < 0) {
>  		dev_err(dev, "%s: can't read reg 0x%x : %d\n",
> @@ -228,6 +235,11 @@ static int pixcir_set_power_mode(struct pixcir_i2c_ts_data *ts,
>  		return ret;
>  	}
>  
> +	if (mode == PIXCIR_POWER_HALT) {
> +		if (ts->gpio_wake)
> +			gpiod_set_value_cansleep(ts->gpio_wake, 0);
> +	}
> +
>  	return 0;
>  }
>  
> @@ -302,6 +314,11 @@ static int pixcir_start(struct pixcir_i2c_ts_data *ts)
>  	struct device *dev = &ts->client->dev;
>  	int error;
>  
> +	if (ts->gpio_enable) {
> +		gpiod_set_value_cansleep(ts->gpio_enable, 1);
> +		msleep(100);
> +	}
> +
>  	/* LEVEL_TOUCH interrupt with active low polarity */
>  	error = pixcir_set_int_mode(ts, PIXCIR_INT_LEVEL_TOUCH, 0);
>  	if (error) {
> @@ -343,6 +360,9 @@ static int pixcir_stop(struct pixcir_i2c_ts_data *ts)
>  	/* Wait till running ISR is complete */
>  	synchronize_irq(ts->client->irq);
>  
> +	if (ts->gpio_enable)
> +		gpiod_set_value_cansleep(ts->gpio_enable, 0);
> +
>  	return 0;
>  }
>  
> @@ -534,6 +554,26 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> +	tsdata->gpio_wake = devm_gpiod_get_optional(dev, "wake",
> +						    GPIOD_OUT_HIGH);
> +	if (IS_ERR(tsdata->gpio_wake)) {
> +		error = PTR_ERR(tsdata->gpio_wake);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get wake gpio: %d\n", error);
> +		return error;
> +	}
> +
> +	tsdata->gpio_enable = devm_gpiod_get_optional(dev, "enable",
> +						      GPIOD_OUT_HIGH);
> +	if (IS_ERR(tsdata->gpio_enable)) {
> +		error = PTR_ERR(tsdata->gpio_enable);
> +		if (error != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get enable gpio: %d\n", error);
> +		return error;
> +	}
> +  	if (tsdata->gpio_enable)
> +		msleep(100);
> +
>  	error = devm_request_threaded_irq(dev, client->irq, NULL, pixcir_ts_isr,
>  					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  					  client->name, tsdata);
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
