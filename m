From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 1/2] input: st1232: Add reset pin handling
Date: Sun, 07 Apr 2013 08:40:57 +0200
Message-ID: <2964968.zUPa6PMQYi@avalon>
References: <1365254327-10408-1-git-send-email-hechtb+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1365254327-10408-1-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-input@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-input@vger.kernel.org

Hi Bastian,

Thanks for the patch.

On Saturday 06 April 2013 15:18:45 Bastian Hecht wrote:
> We add the possiblity to hand over a GPIO number for the reset pin.
> This way we can remove existing board code that takes care of it and
> group this information properly in the platform data or in the device
> tree confguration.
> 
> The implementation is analogous to the cy8ctmg110 driver, thanks.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> ---
>  .../bindings/input/touchscreen/sitronix-st1232.txt |   24 ++++++++++
>  drivers/input/touchscreen/st1232.c                 |   47 +++++++++++++++--
>  include/linux/input/st1232_pdata.h                 |   13 ++++++
>  3 files changed, 81 insertions(+), 3 deletions(-) 
>  create mode 100644
> Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> create mode 100644 include/linux/input/st1232_pdata.h
> 
> diff --git
> a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> new file mode 100644
> index 0000000..1936969
> --- /dev/null
> +++
> b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> @@ -0,0 +1,24 @@
> +* Sitronix st1232 touchscreen controller
> +
> +Required properties:
> +- compatible: must be "sitronix,st1232"
> +- reg: I2C address of the chip
> +- interrupts: interrupt to which the chip is connected
> +
> +Optional properties:
> +- sitronix,reset-pin: GPIO number of the reset pin

GPIO bindings use phandles, please see 
Documentation/devicetree/bindings/gpio/gpio.txt.

> +Example:
> +
> +	i2c@00000000 {
> +		/* ... */
> +
> +		touchscreen@55 {
> +			compatible = "sitronix,st1232";
> +			reg = <0x55>;
> +			interrupts = <2 0>;
> +			sitronix,reset-pin = <166>;
> +		};
> +
> +		/* ... */
> +	};
> diff --git a/drivers/input/touchscreen/st1232.c
> b/drivers/input/touchscreen/st1232.c index d9d05e2..6aa5038 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c

[snip]

> @@ -48,6 +50,7 @@ struct st1232_ts_data {
>  	struct input_dev *input_dev;
>  	struct st1232_ts_finger finger[MAX_FINGERS];
>  	struct dev_pm_qos_request low_latency_req;
> +	int reset_pin;

Nitpicking, I would call it reset_gpio.

>  };
> 
>  static int st1232_ts_read_data(struct st1232_ts_data *ts)
> @@ -139,10 +142,17 @@ end:
>  	return IRQ_HANDLED;
>  }
> 
> +static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
> +{
> +	if (ts->reset_pin)
> +		gpio_direction_output(ts->reset_pin, poweron);
> +}
> +
>  static int st1232_ts_probe(struct i2c_client *client,
>  					const struct i2c_device_id *id)
>  {
>  	struct st1232_ts_data *ts;
> +	struct st1232_pdata *pdata = client->dev.platform_data;
>  	struct input_dev *input_dev;
>  	int error;
> 
> @@ -167,6 +177,25 @@ static int st1232_ts_probe(struct i2c_client *client,
>  	ts->client = client;
>  	ts->input_dev = input_dev;
> 
> +	if (client->dev.of_node)
> +		of_property_read_u32(client->dev.of_node,
> +				"sitronix,reset-pin", &ts->reset_pin);
> +	else if (pdata)
> +		ts->reset_pin = pdata->reset_pin;
> +
> +
> +	if (ts->reset_pin) {
> +		error = gpio_request(ts->reset_pin, NULL);

You should use devm_gpio_request(), it will simplify the error path and the 
remove function.

> +		if (error) {
> +			dev_err(&client->dev,
> +				"Unable to request GPIO pin %d.\n",
> +				ts->reset_pin);
> +				goto err_free_mem;
> +		}
> +	}
> +
> +	st1232_ts_power(ts, true);
> +
>  	input_dev->name = "st1232-touchscreen";
>  	input_dev->id.bustype = BUS_I2C;
>  	input_dev->dev.parent = &client->dev;

[snip]

> diff --git a/include/linux/input/st1232_pdata.h
> b/include/linux/input/st1232_pdata.h new file mode 100644
> index 0000000..ef99354
> --- /dev/null
> +++ b/include/linux/input/st1232_pdata.h
> @@ -0,0 +1,13 @@
> +#ifndef _LINUX_ST1232_PDATA_H
> +#define _LINUX_ST1232_PDATA_H
> +
> +/*
> + * Optional platform data
> + *
> + * Use this if you want the driver to drive the reset pin.
> + */
> +struct st1232_pdata {
> +	int reset_pin;

I would call this reset_gpio as well.

> +};
> +
> +#endif
-- 
Regards,

Laurent Pinchart

