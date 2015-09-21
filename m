From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/6] Input: edt-ft5x06 - switch to newer gpio framework
Date: Mon, 21 Sep 2015 15:55:33 -0700
Message-ID: <20150921225533.GA20559@dtor-ws>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35844 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932422AbbIUWzh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Sep 2015 18:55:37 -0400
Content-Disposition: inline
In-Reply-To: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>

On Sat, Sep 12, 2015 at 10:45:46AM -0700, Dmitry Torokhov wrote:
> From: Franklin S Cooper Jr <fcooper@ti.com>
> 
> The current/old gpio framework used doesn't properly listen to
> ACTIVE_LOW and ACTIVE_HIGH flags. The newer gpio framework takes into
> account these flags when setting gpio values.
> 
> Since the values being output were based on voltage and not logic they
> change to reflect this difference. Also use gpiod_set_value_cansleep since
> wake and reset pins can be provided by bus based io expanders.
> 
> Switch from msleep(5) to udelay_range(5000,6000) to avoid check patch
> warning.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Franklin, could you please give this series a spin so I can queue it for
the next merge window?

Thanks!

> ---
>  .../bindings/input/touchscreen/edt-ft5x06.txt      |   4 +-
>  drivers/input/touchscreen/edt-ft5x06.c             | 129 ++++++---------------
>  include/linux/input/edt-ft5x06.h                   |   3 -
>  3 files changed, 40 insertions(+), 96 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> index 76db967..9330d4d 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> @@ -50,6 +50,6 @@ Example:
>  		pinctrl-0 = <&edt_ft5x06_pins>;
>  		interrupt-parent = <&gpio2>;
>  		interrupts = <5 0>;
> -		reset-gpios = <&gpio2 6 1>;
> -		wake-gpios = <&gpio4 9 0>;
> +		reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
> +		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
>  	};
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 48de1e8..5738722 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -34,8 +34,7 @@
>  #include <linux/delay.h>
>  #include <linux/debugfs.h>
>  #include <linux/slab.h>
> -#include <linux/gpio.h>
> -#include <linux/of_gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/input/mt.h>
>  #include <linux/input/touchscreen.h>
>  #include <linux/input/edt-ft5x06.h>
> @@ -91,9 +90,9 @@ struct edt_ft5x06_ts_data {
>  	u16 num_x;
>  	u16 num_y;
>  
> -	int reset_pin;
> -	int irq_pin;
> -	int wake_pin;
> +	struct gpio_desc *reset_gpio;
> +	struct gpio_desc *wake_gpio;
> +	struct gpio_desc *irq_gpio;
>  
>  #if defined(CONFIG_DEBUG_FS)
>  	struct dentry *debug_dir;
> @@ -752,45 +751,6 @@ edt_ft5x06_ts_teardown_debugfs(struct edt_ft5x06_ts_data *tsdata)
>  
>  #endif /* CONFIG_DEBUGFS */
>  
> -static int edt_ft5x06_ts_reset(struct i2c_client *client,
> -			struct edt_ft5x06_ts_data *tsdata)
> -{
> -	int error;
> -
> -	if (gpio_is_valid(tsdata->wake_pin)) {
> -		error = devm_gpio_request_one(&client->dev,
> -					tsdata->wake_pin, GPIOF_OUT_INIT_LOW,
> -					"edt-ft5x06 wake");
> -		if (error) {
> -			dev_err(&client->dev,
> -				"Failed to request GPIO %d as wake pin, error %d\n",
> -				tsdata->wake_pin, error);
> -			return error;
> -		}
> -
> -		msleep(5);
> -		gpio_set_value(tsdata->wake_pin, 1);
> -	}
> -	if (gpio_is_valid(tsdata->reset_pin)) {
> -		/* this pulls reset down, enabling the low active reset */
> -		error = devm_gpio_request_one(&client->dev,
> -					tsdata->reset_pin, GPIOF_OUT_INIT_LOW,
> -					"edt-ft5x06 reset");
> -		if (error) {
> -			dev_err(&client->dev,
> -				"Failed to request GPIO %d as reset pin, error %d\n",
> -				tsdata->reset_pin, error);
> -			return error;
> -		}
> -
> -		msleep(5);
> -		gpio_set_value(tsdata->reset_pin, 1);
> -		msleep(300);
> -	}
> -
> -	return 0;
> -}
> -
>  static int edt_ft5x06_ts_identify(struct i2c_client *client,
>  					struct edt_ft5x06_ts_data *tsdata,
>  					char *fw_version)
> @@ -931,30 +891,6 @@ edt_ft5x06_ts_set_regs(struct edt_ft5x06_ts_data *tsdata)
>  	}
>  }
>  
> -#ifdef CONFIG_OF
> -static int edt_ft5x06_i2c_ts_probe_dt(struct device *dev,
> -				struct edt_ft5x06_ts_data *tsdata)
> -{
> -	struct device_node *np = dev->of_node;
> -
> -	/*
> -	 * irq_pin is not needed for DT setup.
> -	 * irq is associated via 'interrupts' property in DT
> -	 */
> -	tsdata->irq_pin = -EINVAL;
> -	tsdata->reset_pin = of_get_named_gpio(np, "reset-gpios", 0);
> -	tsdata->wake_pin = of_get_named_gpio(np, "wake-gpios", 0);
> -
> -	return 0;
> -}
> -#else
> -static inline int edt_ft5x06_i2c_ts_probe_dt(struct device *dev,
> -					struct edt_ft5x06_ts_data *tsdata)
> -{
> -	return -ENODEV;
> -}
> -#endif
> -
>  static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  					 const struct i2c_device_id *id)
>  {
> @@ -973,32 +909,42 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  	}
>  
> -	if (!pdata) {
> -		error = edt_ft5x06_i2c_ts_probe_dt(&client->dev, tsdata);
> -		if (error) {
> -			dev_err(&client->dev,
> -				"DT probe failed and no platform data present\n");
> -			return error;
> -		}
> -	} else {
> -		tsdata->reset_pin = pdata->reset_pin;
> -		tsdata->irq_pin = pdata->irq_pin;
> -		tsdata->wake_pin = -EINVAL;
> +	tsdata->reset_gpio = devm_gpiod_get_optional(&client->dev,
> +						     "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(tsdata->reset_gpio)) {
> +		error = PTR_ERR(tsdata->reset_gpio);
> +		dev_err(&client->dev,
> +			"Failed to request GPIO reset pin, error %d\n", error);
> +		return error;
>  	}
>  
> -	error = edt_ft5x06_ts_reset(client, tsdata);
> -	if (error)
> +	tsdata->wake_gpio = devm_gpiod_get_optional(&client->dev,
> +						    "wake", GPIOD_OUT_LOW);
> +	if (IS_ERR(tsdata->wake_gpio)) {
> +		error = PTR_ERR(tsdata->wake_gpio);
> +		dev_err(&client->dev,
> +			"Failed to request GPIO wake pin, error %d\n", error);
>  		return error;
> +	}
>  
> -	if (gpio_is_valid(tsdata->irq_pin)) {
> -		error = devm_gpio_request_one(&client->dev, tsdata->irq_pin,
> -					GPIOF_IN, "edt-ft5x06 irq");
> -		if (error) {
> -			dev_err(&client->dev,
> -				"Failed to request GPIO %d, error %d\n",
> -				tsdata->irq_pin, error);
> -			return error;
> -		}
> +	tsdata->irq_gpio = devm_gpiod_get_optional(&client->dev,
> +						   "irq", GPIOD_IN);
> +	if (IS_ERR(tsdata->irq_gpio)) {
> +		error = PTR_ERR(tsdata->irq_gpio);
> +		dev_err(&client->dev,
> +			"Failed to request GPIO irq pin, error %d\n", error);
> +		return error;
> +	}
> +
> +	if (tsdata->wake_gpio) {
> +		usleep_range(5000, 6000);
> +		gpiod_set_value_cansleep(tsdata->wake_gpio, 1);
> +	}
> +
> +	if (tsdata->reset_gpio) {
> +		usleep_range(5000, 6000);
> +		gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
> +		msleep(300);
>  	}
>  
>  	input = devm_input_allocate_device(&client->dev);
> @@ -1074,7 +1020,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  
>  	dev_dbg(&client->dev,
>  		"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
> -		client->irq, tsdata->wake_pin, tsdata->reset_pin);
> +		client->irq, desc_to_gpio(tsdata->wake_gpio),
> +		desc_to_gpio(tsdata->reset_gpio));
>  
>  	return 0;
>  
> diff --git a/include/linux/input/edt-ft5x06.h b/include/linux/input/edt-ft5x06.h
> index 8a1e0d1..5ca5b4c 100644
> --- a/include/linux/input/edt-ft5x06.h
> +++ b/include/linux/input/edt-ft5x06.h
> @@ -10,9 +10,6 @@
>   */
>  
>  struct edt_ft5x06_platform_data {
> -	int irq_pin;
> -	int reset_pin;
> -
>  	/* startup defaults for operational parameters */
>  	bool use_parameters;
>  	u8 gain;
> -- 
> 2.6.0.rc0.131.gf624c3d
> 

-- 
Dmitry
