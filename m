From: Nick Dyer <nick@shmanahar.org>
Subject: Re: [PATCH] atmel_mxt_ts: Add support for reset line
Date: Thu, 29 Jun 2017 21:08:01 +0100
Message-ID: <20170629200801.GA4067@lava.h.shmanahar.org>
References: <20170627162438.10108-1-sebastian.reichel@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout05.plus.net ([84.93.230.250]:42725 "EHLO
        avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752638AbdF2UHo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Jun 2017 16:07:44 -0400
Content-Disposition: inline
In-Reply-To: <20170627162438.10108-1-sebastian.reichel@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Martyn Welch <martyn.welch@collabora.co.uk>

On Tue, Jun 27, 2017 at 06:24:38PM +0200, Sebastian Reichel wrote:
> At least some of the Atmel Maxtouch touchscreen controllers have a reset
> pin. If this is not driven correctly the device will be held in reset
> and will not respond.
> 
> Add support for driving the reset line via GPIO as is found in other
> such drivers.

Thanks for this useful improvement.

> Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
> [add reset cycle during probe, minor style fixes, add DT binding]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  .../devicetree/bindings/input/atmel,maxtouch.txt   |  2 ++
>  drivers/input/touchscreen/atmel_mxt_ts.c           | 27 +++++++++++++++++++++-
>  2 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> index 1852906517ab..23e3abc3fdef 100644
> --- a/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> +++ b/Documentation/devicetree/bindings/input/atmel,maxtouch.txt
> @@ -22,6 +22,8 @@ Optional properties for main touchpad device:
>      experiment to determine which bit corresponds to which input. Use
>      KEY_RESERVED for unused padding values.
>  
> +- reset-gpios: GPIO specifier for the touchscreen's reset pin (active low)
> +
>  Example:
>  
>  	touch@4b {
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index dd042a9b0aaa..b84bf973fe36 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -28,6 +28,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/of.h>
>  #include <linux/slab.h>
> +#include <linux/gpio/consumer.h>
>  #include <asm/unaligned.h>
>  #include <media/v4l2-device.h>
>  #include <media/v4l2-ioctl.h>
> @@ -300,6 +301,7 @@ struct mxt_data {
>  	u8 multitouch;
>  	struct t7_config t7_cfg;
>  	struct mxt_dbg dbg;
> +	struct gpio_desc *reset_gpio;
>  
>  	/* Cached parameters from object table */
>  	u16 T5_address;
> @@ -3135,12 +3137,26 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	init_completion(&data->reset_completion);
>  	init_completion(&data->crc_completion);
>  
> +	data->reset_gpio = gpiod_get_optional(&client->dev, "reset",
> +					      GPIOD_OUT_LOW);

Please could you use the devm_gpiod_get_optional, it reduces the code to
free it later.

> +	if (IS_ERR(data->reset_gpio)) {
> +		error = PTR_ERR(data->reset_gpio);
> +		dev_err(&client->dev, "Failed to get reset gpio: %d\n", error);
> +		goto err_free_mem;
> +	}
> +
> +	if (data->reset_gpio) {
> +		msleep(MXT_RESET_TIME);
> +		gpiod_set_value(data->reset_gpio, 1);
> +		msleep(MXT_RESET_TIME);
> +	}

This is alright, although the time for reset varies between maXTouch
parts. It would be better to wait for the CHG line to go low, for
example see the code at
https://github.com/atmel-maxtouch/linux/blob/for-upstream/drivers/input/touchscreen/atmel_mxt_ts.c#L2237

> +
>  	error = request_threaded_irq(client->irq, NULL, mxt_interrupt,
>  				     pdata->irqflags | IRQF_ONESHOT,
>  				     client->name, data);
>  	if (error) {
>  		dev_err(&client->dev, "Failed to register interrupt\n");
> -		goto err_free_mem;
> +		goto err_free_gpio;
>  	}
>  
>  	disable_irq(client->irq);
> @@ -3163,6 +3179,11 @@ static int mxt_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	mxt_free_object_table(data);
>  err_free_irq:
>  	free_irq(client->irq, data);
> +err_free_gpio:
> +	if (data->reset_gpio) {
> +		gpiod_set_value(data->reset_gpio, 0);
> +		gpiod_put(data->reset_gpio);
> +	}
>  err_free_mem:
>  	kfree(data);
>  	return error;
> @@ -3174,6 +3195,10 @@ static int mxt_remove(struct i2c_client *client)
>  
>  	sysfs_remove_group(&client->dev.kobj, &mxt_attr_group);
>  	free_irq(data->irq, data);
> +	if (data->reset_gpio) {
> +		gpiod_set_value(data->reset_gpio, 0);
> +		gpiod_put(data->reset_gpio);
> +	}
>  	mxt_free_input_device(data);
>  	mxt_free_object_table(data);
>  	kfree(data);
> -- 
> 2.11.0
> 
