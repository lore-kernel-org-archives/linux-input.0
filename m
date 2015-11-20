From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 4/7] touchscreen: pixcir_i2c: Add support for wake and
 enable gpios
Date: Fri, 20 Nov 2015 10:54:51 -0800
Message-ID: <20151120185451.GC26895@dtor-ws>
References: <1448025892-20899-1-git-send-email-hdegoede@redhat.com>
 <1448025892-20899-5-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33481 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760160AbbKTSyz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2015 13:54:55 -0500
Content-Disposition: inline
In-Reply-To: <1448025892-20899-5-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Sander Vermin <sander@vermin.nl>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>, linux-sunxi@googlegroups.com

On Fri, Nov 20, 2015 at 02:24:49PM +0100, Hans de Goede wrote:
> From: Sander Vermin <sander@vermin.nl>
> 
> On some devices the wake and enable pins of the pixcir touchscreen
> controller are connected to gpios and these must be controlled by the
> driver for the device to operate properly.
> 
> Signed-off-by: Sander Vermin <sander@vermin.nl>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2 (Hans de Goede):
> -Split the changes for dealing with inverted / swapped axis out into a
>  separate patch
> -Remove a bunch of dev_info calls to make the driver less chatty
> -Use devm_gpiod_get_optional as these new gpios are optional
> -Only msleep after setting enable high if we have an enable pin
> ---
>  .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |  2 +
>  drivers/input/touchscreen/pixcir_i2c_ts.c          | 46 ++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
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
> index 211408c..b75ef65 100644
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
> +		if (!IS_ERR_OR_NULL(ts->gpio_wake))
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
> +		if (!IS_ERR_OR_NULL(ts->gpio_wake))
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
> +	if (!IS_ERR_OR_NULL(ts->gpio_enable)) {
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
> +	if (!IS_ERR_OR_NULL(ts->gpio_enable))
> +		gpiod_set_value_cansleep(ts->gpio_enable, 0);
> +
>  	return 0;
>  }
>  
> @@ -534,6 +554,24 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
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
> +
>  	error = devm_request_threaded_irq(dev, client->irq, NULL, pixcir_ts_isr,
>  					  IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  					  client->name, tsdata);
> @@ -542,6 +580,14 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>  		return error;
>  	}
>  
> +	if (!IS_ERR_OR_NULL(tsdata->gpio_wake))
> +		gpiod_set_value_cansleep(tsdata->gpio_wake, 1);
> +
> +	if (!IS_ERR_OR_NULL(tsdata->gpio_enable)) {
> +		gpiod_set_value_cansleep(tsdata->gpio_enable, 1);
> +		msleep(100);
> +	}

Actually, another question: why do we need this calls to activate wake
and enable gpios here if we request them as active?

Thanks.

> +
>  	pixcir_reset(tsdata);
>  
>  	/* Always be in IDLE mode to save power, device supports auto wake */
> -- 
> 2.5.0
> 

-- 
Dmitry
