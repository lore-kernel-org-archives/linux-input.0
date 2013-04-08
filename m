From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2 1/2] input: st1232: Add reset pin handling
Date: Mon, 08 Apr 2013 16:17:20 +0200
Message-ID: <2096590.pSU6Gke5Ke@avalon>
References: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-input@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-input@vger.kernel.org

Hi Bastian,

Thanks for the patch.

On Monday 08 April 2013 14:52:26 Bastian Hecht wrote:
> We add the possiblity to hand over a GPIO number for the reset pin.
> This way we can remove existing board code that takes care of it and
> group this information properly in the platform data or in the device
> tree confguration.
> 
> The implementation is analogous to the cy8ctmg110 driver, thanks.
> 
> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2:
> 
> - using a gpio phandle now in the DT code
> - rename from reset_pin to reset_gpio
> - gpio number 0 is allowed now and the absence of the reset gpio is marked
> with an error code
> - using devm_request_gpio instead of plain request_gpio to simplify things
> 
>  .../bindings/input/touchscreen/sitronix-st1232.txt |   24 ++++++++++++
>  drivers/input/touchscreen/st1232.c                 |   41 ++++++++++++++++-
>  include/linux/input/st1232_pdata.h                 |   13 +++++++
>  3 files changed, 76 insertions(+), 2 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> create mode 100644 include/linux/input/st1232_pdata.h
> 
> diff --git
> a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> new file mode 100644
> index 0000000..64ad48b
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
> +- gpios: a phandle to the reset GPIO
> +
> +Example:
> +
> +	i2c@00000000 {
> +		/* ... */
> +
> +		touchscreen@55 {
> +			compatible = "sitronix,st1232";
> +			reg = <0x55>;
> +			interrupts = <2 0>;
> +			gpios = <&gpio1 166 0>;
> +		};
> +
> +		/* ... */
> +	};
> diff --git a/drivers/input/touchscreen/st1232.c
> b/drivers/input/touchscreen/st1232.c index d9d05e2..498d18b 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -19,13 +19,16 @@
>   */
> 
>  #include <linux/delay.h>
> +#include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
> +#include <linux/of_gpio.h>
>  #include <linux/pm_qos.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> +#include <linux/input/st1232_pdata.h>
> 
>  #define ST1232_TS_NAME	"st1232-ts"
> 
> @@ -48,6 +51,7 @@ struct st1232_ts_data {
>  	struct input_dev *input_dev;
>  	struct st1232_ts_finger finger[MAX_FINGERS];
>  	struct dev_pm_qos_request low_latency_req;
> +	int reset_gpio;
>  };
> 
>  static int st1232_ts_read_data(struct st1232_ts_data *ts)
> @@ -139,10 +143,17 @@ end:
>  	return IRQ_HANDLED;
>  }
> 
> +static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
> +{
> +	if (ts->reset_gpio >= 0)
> +		gpio_direction_output(ts->reset_gpio, poweron);
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
> @@ -167,6 +178,25 @@ static int st1232_ts_probe(struct i2c_client *client,
>  	ts->client = client;
>  	ts->input_dev = input_dev;
> 
> +	if (client->dev.of_node)
> +		ts->reset_gpio = of_get_gpio(client->dev.of_node, 0);
> +	else if (pdata)
> +		ts->reset_gpio = pdata->reset_gpio;
> +	else
> +		ts->reset_gpio = -ENODEV;
> +
> +	if (ts->reset_gpio >= 0) {
> +		error = devm_gpio_request(&client->dev, ts->reset_gpio, NULL);
> +		if (error) {
> +			dev_err(&client->dev,
> +				"Unable to request GPIO pin %d.\n",
> +				ts->reset_gpio);
> +				goto err_free_mem;
> +		}
> +	}
> +
> +	st1232_ts_power(ts, true);
> +
>  	input_dev->name = "st1232-touchscreen";
>  	input_dev->id.bustype = BUS_I2C;
>  	input_dev->dev.parent = &client->dev;
> @@ -210,6 +240,7 @@ static int st1232_ts_remove(struct i2c_client *client)
>  {
>  	struct st1232_ts_data *ts = i2c_get_clientdata(client);
> 
> +	st1232_ts_power(ts, false);
>  	device_init_wakeup(&client->dev, 0);
>  	free_irq(client->irq, ts);
>  	input_unregister_device(ts->input_dev);
> @@ -222,11 +253,14 @@ static int st1232_ts_remove(struct i2c_client *client)
> static int st1232_ts_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct st1232_ts_data *ts = i2c_get_clientdata(client);
> 
>  	if (device_may_wakeup(&client->dev))
>  		enable_irq_wake(client->irq);
> -	else
> +	else {
>  		disable_irq(client->irq);
> +		st1232_ts_power(ts, false);
> +	}
> 
>  	return 0;
>  }
> @@ -234,11 +268,14 @@ static int st1232_ts_suspend(struct device *dev)
>  static int st1232_ts_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> +	struct st1232_ts_data *ts = i2c_get_clientdata(client);
> 
>  	if (device_may_wakeup(&client->dev))
>  		disable_irq_wake(client->irq);
> -	else
> +	else {
> +		st1232_ts_power(ts, true);
>  		enable_irq(client->irq);
> +	}
> 
>  	return 0;
>  }
> diff --git a/include/linux/input/st1232_pdata.h
> b/include/linux/input/st1232_pdata.h new file mode 100644
> index 0000000..cac3e7b
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
> +	int reset_gpio;
> +};
> +
> +#endif
-- 
Regards,

Laurent Pinchart

