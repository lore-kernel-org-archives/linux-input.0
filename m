From: Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
Subject: Re: [PATCH] Input: mms114 - drop platform data and use generic APIs
Date: Thu, 28 Dec 2017 02:02:32 +1100
Message-ID: <20171227150232.GA31961@lineageos.org>
References: <20171226032511.17726-1-simon@lineageos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171226032511.17726-1-simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, Dec 26, 2017 at 02:25:11PM +1100, Simon Shields wrote:
> The MMS114 platform data has no in-tree users, so drop it,
> and make the driver depend on CONFIG_OF.
> 
> Switch to using the standard touchscreen properties via
> touchscreen_parse_properties(), and move the old DT parsing code
> to use device_property_*() APIs.
> 
> Finally, use touchscreen_report_pos to report x/y coordinates
> and drop the custom x/y inversion code.
> 
> Signed-off-by: Simon Shields <simon-WP75azK+jQYgsBAKwltoeQ@public.gmane.org>
> ---
>  .../bindings/input/touchscreen/mms114.txt          |  29 ++--
>  drivers/input/touchscreen/Kconfig                  |   1 +
>  drivers/input/touchscreen/mms114.c                 | 146 +++++++++------------
>  include/linux/platform_data/mms114.h               |  24 ----
>  4 files changed, 77 insertions(+), 123 deletions(-)
>  delete mode 100644 include/linux/platform_data/mms114.h
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/mms114.txt b/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
> index 89d4c56c5671..8f9f9f38eff4 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/mms114.txt
> @@ -4,14 +4,18 @@ Required properties:
>  - compatible: must be "melfas,mms114"
>  - reg: I2C address of the chip
>  - interrupts: interrupt to which the chip is connected
> -- x-size: horizontal resolution of touchscreen
> -- y-size: vertical resolution of touchscreen
> +- touchscreen-size-x: See [1]
> +- touchscreen-size-y: See [1]
>  
>  Optional properties:
> -- contact-threshold:
> -- moving-threshold:
> -- x-invert: invert X axis
> -- y-invert: invert Y axis
> +- touchscreen-fuzz-x: See [1]
> +- touchscreen-fuzz-y: See [1]
> +- touchscreen-fuzz-pressure: See [1]
> +- touchscreen-inverted-x: See [1]
> +- touchscreen-inverted-y: See [1]
> +- touchscreen-swapped-x-y: See [1]
> +
> +[1]: Documentation/devicetree/bindings/input/touchscreen/touchscreen.txt
>  
>  Example:
>  
> @@ -22,12 +26,13 @@ Example:
>  			compatible = "melfas,mms114";
>  			reg = <0x48>;
>  			interrupts = <39 0>;
> -			x-size = <720>;
> -			y-size = <1280>;
> -			contact-threshold = <10>;
> -			moving-threshold = <10>;
> -			x-invert;
> -			y-invert;
> +			touchscreen-size-x = <720>;
> +			touchscreen-size-y = <1280>;
> +			touchscreen-fuzz-x = <10>;
> +			touchscreen-fuzz-y = <10>;
> +			touchscreen-fuzz-pressure = <10>;
> +			touchscreen-inverted-x;
> +			touchscreen-inverted-y;
>  		};
>  
>  		/* ... */
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 38a226f9fcbd..f7ea5522ef91 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -524,6 +524,7 @@ config TOUCHSCREEN_MCS5000
>  config TOUCHSCREEN_MMS114
>  	tristate "MELFAS MMS114 touchscreen"
>  	depends on I2C
> +	depends on OF
>  	help
>  	  Say Y here if you have the MELFAS MMS114 touchscreen controller
>  	  chip in your system.
> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> index e5eeb6311f7d..2ca22faa10aa 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -12,8 +12,8 @@
>  #include <linux/of.h>
>  #include <linux/i2c.h>
>  #include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
>  #include <linux/interrupt.h>
> -#include <linux/platform_data/mms114.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  
> @@ -55,7 +55,9 @@ struct mms114_data {
>  	struct input_dev	*input_dev;
>  	struct regulator	*core_reg;
>  	struct regulator	*io_reg;
> -	const struct mms114_platform_data	*pdata;
> +	struct touchscreen_properties props;
> +	unsigned int contact_threshold;
> +	unsigned int moving_threshold;
>  
>  	/* Use cache data for mode control register(write only) */
>  	u8			cache_mode_control;
> @@ -143,7 +145,6 @@ static int mms114_write_reg(struct mms114_data *data, unsigned int reg,
>  
>  static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *touch)
>  {
> -	const struct mms114_platform_data *pdata = data->pdata;
>  	struct i2c_client *client = data->client;
>  	struct input_dev *input_dev = data->input_dev;
>  	unsigned int id;
> @@ -163,16 +164,6 @@ static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *tou
>  	id = touch->id - 1;
>  	x = touch->x_lo | touch->x_hi << 8;
>  	y = touch->y_lo | touch->y_hi << 8;
> -	if (x > pdata->x_size || y > pdata->y_size) {
> -		dev_dbg(&client->dev,
> -			"Wrong touch coordinates (%d, %d)\n", x, y);
> -		return;
> -	}
> -
> -	if (pdata->x_invert)
> -		x = pdata->x_size - x;
> -	if (pdata->y_invert)
> -		y = pdata->y_size - y;
>  
>  	dev_dbg(&client->dev,
>  		"id: %d, type: %d, pressed: %d, x: %d, y: %d, width: %d, strength: %d\n",
> @@ -183,9 +174,8 @@ static void mms114_process_mt(struct mms114_data *data, struct mms114_touch *tou
>  	input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, touch->pressed);
>  
>  	if (touch->pressed) {
> +		touchscreen_report_pos(input_dev, &data->props, x, y, true);
>  		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, touch->width);
> -		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
> -		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
>  		input_report_abs(input_dev, ABS_MT_PRESSURE, touch->strength);
>  	}
>  }
> @@ -263,7 +253,7 @@ static int mms114_get_version(struct mms114_data *data)
>  
>  static int mms114_setup_regs(struct mms114_data *data)
>  {
> -	const struct mms114_platform_data *pdata = data->pdata;
> +	const struct touchscreen_properties *props = &data->props;
>  	int val;
>  	int error;
>  
> @@ -275,32 +265,32 @@ static int mms114_setup_regs(struct mms114_data *data)
>  	if (error < 0)
>  		return error;
>  
> -	val = (pdata->x_size >> 8) & 0xf;
> -	val |= ((pdata->y_size >> 8) & 0xf) << 4;
> +	val = (props->max_x >> 8) & 0xf;
> +	val |= ((props->max_y >> 8) & 0xf) << 4;
>  	error = mms114_write_reg(data, MMS114_XY_RESOLUTION_H, val);
>  	if (error < 0)
>  		return error;
>  
> -	val = pdata->x_size & 0xff;
> +	val = props->max_x & 0xff;
>  	error = mms114_write_reg(data, MMS114_X_RESOLUTION, val);
>  	if (error < 0)
>  		return error;
>  
> -	val = pdata->y_size & 0xff;
> +	val = props->max_x & 0xff;
>  	error = mms114_write_reg(data, MMS114_Y_RESOLUTION, val);
>  	if (error < 0)
>  		return error;
>  
> -	if (pdata->contact_threshold) {
> +	if (data->contact_threshold) {
>  		error = mms114_write_reg(data, MMS114_CONTACT_THRESHOLD,
> -				pdata->contact_threshold);
> +				data->contact_threshold);
>  		if (error < 0)
>  			return error;
>  	}
>  
> -	if (pdata->moving_threshold) {
> +	if (data->moving_threshold) {
>  		error = mms114_write_reg(data, MMS114_MOVING_THRESHOLD,
> -				pdata->moving_threshold);
> +				data->moving_threshold);
>  		if (error < 0)
>  			return error;
>  	}
> @@ -335,9 +325,6 @@ static int mms114_start(struct mms114_data *data)
>  		return error;
>  	}
>  
> -	if (data->pdata->cfg_pin)
> -		data->pdata->cfg_pin(true);
> -
>  	enable_irq(client->irq);
>  
>  	return 0;
> @@ -350,9 +337,6 @@ static void mms114_stop(struct mms114_data *data)
>  
>  	disable_irq(client->irq);
>  
> -	if (data->pdata->cfg_pin)
> -		data->pdata->cfg_pin(false);
> -
>  	error = regulator_disable(data->io_reg);
>  	if (error)
>  		dev_warn(&client->dev, "Failed to disable vdd: %d\n", error);
> @@ -376,67 +360,43 @@ static void mms114_input_close(struct input_dev *dev)
>  	mms114_stop(data);
>  }
>  
> -#ifdef CONFIG_OF
> -static struct mms114_platform_data *mms114_parse_dt(struct device *dev)
> +static int mms114_parse_dt(struct mms114_data *data)
>  {
> -	struct mms114_platform_data *pdata;
> -	struct device_node *np = dev->of_node;
> -
> -	if (!np)
> -		return NULL;
> +	struct device *dev = &data->client->dev;
> +	struct touchscreen_properties *props = &data->props;
>  
> -	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata) {
> -		dev_err(dev, "failed to allocate platform data\n");
> -		return NULL;
> +	if (device_property_read_u32(dev, "x-size", &props->max_x)) {
> +		dev_dbg(dev, "failed to get legacy x-size property\n");
> +		return -EINVAL;
>  	}
>  
> -	if (of_property_read_u32(np, "x-size", &pdata->x_size)) {
> -		dev_err(dev, "failed to get x-size property\n");
> -		return NULL;
> +	if (device_property_read_u32(dev, "y-size", &props->max_y)) {
> +		dev_dbg(dev, "failed to get legacy y-size property\n");
> +		return -EINVAL;
>  	}
>  
> -	if (of_property_read_u32(np, "y-size", &pdata->y_size)) {
> -		dev_err(dev, "failed to get y-size property\n");
> -		return NULL;
> -	}
> +	device_property_read_u32(dev, "contact-threshold",
> +				&data->contact_threshold);
> +	device_property_read_u32(dev, "moving-threshold",
> +				&data->moving_threshold);
>  
> -	of_property_read_u32(np, "contact-threshold",
> -				&pdata->contact_threshold);
> -	of_property_read_u32(np, "moving-threshold",
> -				&pdata->moving_threshold);
> +	if (device_property_read_bool(dev, "x-invert"))
> +		props->invert_x = true;
> +	if (device_property_read_bool(dev, "y-invert"))
> +		props->invert_y = true;
>  
> -	if (of_find_property(np, "x-invert", NULL))
> -		pdata->x_invert = true;
> -	if (of_find_property(np, "y-invert", NULL))
> -		pdata->y_invert = true;
> +	props->swap_x_y = false;
>  
> -	return pdata;
> -}
> -#else
> -static inline struct mms114_platform_data *mms114_parse_dt(struct device *dev)
> -{
> -	return NULL;
> +	return 0;
>  }
> -#endif
>  
>  static int mms114_probe(struct i2c_client *client,
>  				  const struct i2c_device_id *id)
>  {
> -	const struct mms114_platform_data *pdata;
>  	struct mms114_data *data;
>  	struct input_dev *input_dev;
>  	int error;
>  
> -	pdata = dev_get_platdata(&client->dev);
> -	if (!pdata)
> -		pdata = mms114_parse_dt(&client->dev);
> -
> -	if (!pdata) {
> -		dev_err(&client->dev, "Need platform data\n");
> -		return -EINVAL;
> -	}
> -
>  	if (!i2c_check_functionality(client->adapter,
>  				I2C_FUNC_PROTOCOL_MANGLING)) {
>  		dev_err(&client->dev,
> @@ -453,8 +413,33 @@ static int mms114_probe(struct i2c_client *client,
>  	}
>  
>  	data->client = client;
> +
> +	input_set_capability(input_dev, EV_KEY, BTN_TOUCH);
> +	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_X);
> +	input_set_capability(input_dev, EV_ABS, ABS_MT_POSITION_Y);
> +	input_set_capability(input_dev, EV_ABS, ABS_MT_PRESSURE);
> +	input_set_capability(input_dev, EV_ABS, ABS_MT_TOUCH_MAJOR);
> +
> +	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
> +
> +	if (mms114_parse_dt(data) < 0) {
> +		/* No valid legacy binding found, try the common one */
> +		touchscreen_parse_properties(input_dev, true, &data->props);
> +
> +		/* The firmware handles movement and pressure fuzz, so
> +		 * don't duplicate that in software.
> +		 */
> +		data->moving_threshold =
> +			input_dev->absinfo[ABS_MT_POSITION_X].fuzz;
> +		data->contact_threshold =
> +			input_dev->absinfo[ABS_MT_PRESSURE].fuzz;
> +
> +		input_dev->absinfo[ABS_MT_POSITION_X].fuzz = 0;
> +		input_dev->absinfo[ABS_MT_POSITION_Y].fuzz = 0;
> +		input_dev->absinfo[ABS_MT_PRESSURE].fuzz = 0;
> +	}
> +
>  	data->input_dev = input_dev;
> -	data->pdata = pdata;
>  
>  	input_dev->name = "MELFAS MMS114 Touchscreen";
>  	input_dev->id.bustype = BUS_I2C;
> @@ -462,21 +447,10 @@ static int mms114_probe(struct i2c_client *client,
>  	input_dev->open = mms114_input_open;
>  	input_dev->close = mms114_input_close;
>  
> -	__set_bit(EV_ABS, input_dev->evbit);
> -	__set_bit(EV_KEY, input_dev->evbit);
> -	__set_bit(BTN_TOUCH, input_dev->keybit);
> -	input_set_abs_params(input_dev, ABS_X, 0, data->pdata->x_size, 0, 0);
> -	input_set_abs_params(input_dev, ABS_Y, 0, data->pdata->y_size, 0, 0);
> -
>  	/* For multi touch */
>  	input_mt_init_slots(input_dev, MMS114_MAX_TOUCH, 0);
>  	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
>  			     0, MMS114_MAX_AREA, 0, 0);
> -	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> -			     0, data->pdata->x_size, 0, 0);
> -	input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> -			     0, data->pdata->y_size, 0, 0);

This shouldn't be dropped, it's needed for compatability with the old DTS. I
will send a v2 shortly.

> -	input_set_abs_params(input_dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
>  
>  	input_set_drvdata(input_dev, data);
>  	i2c_set_clientdata(client, data);
> @@ -567,13 +541,11 @@ static const struct i2c_device_id mms114_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, mms114_id);
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id mms114_dt_match[] = {
>  	{ .compatible = "melfas,mms114" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, mms114_dt_match);
> -#endif
>  
>  static struct i2c_driver mms114_driver = {
>  	.driver = {
> diff --git a/include/linux/platform_data/mms114.h b/include/linux/platform_data/mms114.h
> deleted file mode 100644
> index 5722ebfb2738..000000000000
> --- a/include/linux/platform_data/mms114.h
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -/*
> - * Copyright (C) 2012 Samsung Electronics Co.Ltd
> - * Author: Joonyoung Shim <jy0922.shim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundationr
> - */
> -
> -#ifndef __LINUX_MMS114_H
> -#define __LINUX_MMS114_H
> -
> -struct mms114_platform_data {
> -	unsigned int x_size;
> -	unsigned int y_size;
> -	unsigned int contact_threshold;
> -	unsigned int moving_threshold;
> -	bool x_invert;
> -	bool y_invert;
> -
> -	void (*cfg_pin)(bool);
> -};
> -
> -#endif	/* __LINUX_MMS114_H */
> -- 
> 2.15.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
