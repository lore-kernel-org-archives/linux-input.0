From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] input: st1232.c: Add devicetree attributes
Date: Mon, 16 Nov 2015 09:40:44 -0600
Message-ID: <20151116154044.GA18208@rob-hp-laptop>
References: <1447604447-8932-1-git-send-email-sander@vermin.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48813 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751606AbbKPPkv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Nov 2015 10:40:51 -0500
Content-Disposition: inline
In-Reply-To: <1447604447-8932-1-git-send-email-sander@vermin.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sander Vermin <sander@vermin.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

On Sun, Nov 15, 2015 at 05:20:47PM +0100, Sander Vermin wrote:
> Add support for rotating and inverted axis for the Sitronix ST1232 touchscreen controller.
> 
> For the rotation of the touchscreen the devicetree resolution propteries are requierd. For this purpose the following devicetree mappings are implemented:

Fix the line wrap.

> - touchscreen-size-x
> - touchscreen-size-y
> - touchscreen-inverted-x
> - touchscreen-inverted-y
> - touchscreen-swapped-x-y
> 
> Signed-off-by: Sander Vermin <sander@vermin.nl>
> ---
>  .../bindings/input/touchscreen/sitronix-st1232.txt |  18 +-
>  drivers/input/touchscreen/st1232.c                 | 362 +++++++++++++++------
>  2 files changed, 272 insertions(+), 108 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> index 64ad48b..1dcd1b6 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> @@ -1,12 +1,18 @@
>  * Sitronix st1232 touchscreen controller
>  
>  Required properties:
> -- compatible: must be "sitronix,st1232"
> -- reg: I2C address of the chip
> -- interrupts: interrupt to which the chip is connected
> +- compatible		: must be "sitronix,st1232"
> +- reg			: I2C address of the chip
> +- interrupts		: interrupt to which the chip is connected
> +- touchscreen-size-x	: horizontal resolution of touchscreen (in pixels)
> +- touchscreen-size-y	: vertical resolution of touchscreen (in pixels)
> +

Reformatting in a separate patch please.


>  Optional properties:
> -- gpios: a phandle to the reset GPIO
> +- gpios			: a phandle to the reset GPIO
> +- touchscreen-inverted-x	: X axis is inverted (boolean)
> +- touchscreen-inverted-y	: Y axis is inverted (boolean)
> +- touchscreen-swapped-x-y	: X and Y axis are swapped (boolean)
>  
>  Example:
>  
> @@ -18,6 +24,10 @@ Example:
>  			reg = <0x55>;
>  			interrupts = <2 0>;
>  			gpios = <&gpio1 166 0>;
> +			touchscreen-size-y = <800>;
> +			touchscreen-size-x = <480>;
> +			touchscreen-inverted-y;
> +			touchscreen-swapped-x-y;
>  		};
>  
>  		/* ... */
> diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
> index e943678..0458a29 100644
> --- a/drivers/input/touchscreen/st1232.c
> +++ b/drivers/input/touchscreen/st1232.c
> @@ -1,6 +1,9 @@
>  /*
>   * ST1232 Touchscreen Controller Driver
>   *
> + * Copyright (C) 2015 Sander Vermin
> + *	Sander Vermin <sander@vermin.nl>
> + *
>   * Copyright (C) 2010 Renesas Solutions Corp.
>   *	Tony SIM <chinyeow.sim.xt@renesas.com>
>   *
> @@ -22,6 +25,7 @@
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/input.h>
> +#include <linux/input/mt.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -31,70 +35,89 @@
>  #include <linux/types.h>
>  #include <linux/platform_data/st1232_pdata.h>
>  
> -#define ST1232_TS_NAME	"st1232-ts"
> +#define ST1232_REG_STATUS	0x01
> +#define ST1232_REG_CONTROL	0x02
> +#define ST1232_REG_XY_RES	0x04
> +#define ST1232_REG_TOUCHDATA	0x10
> +
> +#define ST1232_POWER_DOWN	0x02
>  
> -#define MIN_X		0x00
> -#define MIN_Y		0x00
> -#define MAX_X		0x31f	/* (800 - 1) */
> -#define MAX_Y		0x1df	/* (480 - 1) */
> -#define MAX_AREA	0xff
> -#define MAX_FINGERS	2
> +#define ST1232_MAX_FINGERS	2
> +#define ST1232_MAX_RESOLUTION	800
> +#define ST1232_TS_NAME		"st1232-ts"
>  
>  struct st1232_ts_finger {
>  	u16 x;
>  	u16 y;
> -	u8 t;
> +	u8 z;
>  	bool is_valid;
>  };
>  
> -struct st1232_ts_data {
> +struct st1232_touch_data {
> +	__u8 softbutton;
> +	__u8 finger_count;
> +	struct st1232_ts_finger finger[ST1232_MAX_FINGERS];
> +};
> +
> +struct st1232_data {
>  	struct i2c_client *client;
>  	struct input_dev *input_dev;
> -	struct st1232_ts_finger finger[MAX_FINGERS];
>  	struct dev_pm_qos_request low_latency_req;
>  	int reset_gpio;
> +	u32 max_x;
> +	u32 max_y;
> +	bool invert_x;
> +	bool invert_y;
> +	bool swap_x_y;
>  };
>  
> -static int st1232_ts_read_data(struct st1232_ts_data *ts)
> +static int st1232_ts_read_data(struct i2c_client *client,
> +				   struct st1232_touch_data *touch_data)
>  {
> -	struct st1232_ts_finger *finger = ts->finger;
> -	struct i2c_client *client = ts->client;
> -	struct i2c_msg msg[2];
>  	int error;
> -	u8 start_reg;
> +	u8 start_reg = ST1232_REG_TOUCHDATA;
>  	u8 buf[10];
>  
> -	/* read touchscreen data from ST1232 */
> -	msg[0].addr = client->addr;
> -	msg[0].flags = 0;
> -	msg[0].len = 1;
> -	msg[0].buf = &start_reg;
> -	start_reg = 0x10;
> -
> -	msg[1].addr = ts->client->addr;
> -	msg[1].flags = I2C_M_RD;
> -	msg[1].len = sizeof(buf);
> -	msg[1].buf = buf;
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = client->addr,
> +			.len = 1,
> +			.buf = &start_reg
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.len = sizeof(buf),
> +			.buf = (u8 *)buf
> +		}
> +	};
>  
>  	error = i2c_transfer(client->adapter, msg, 2);
>  	if (error < 0)
>  		return error;
>  
> +	/* get number of fingers */
> +	touch_data->finger_count = buf[0] & 0x7;
> +
> +	/* get softkeys */
> +	touch_data->softbutton = buf[1];
> +
>  	/* get "valid" bits */
> -	finger[0].is_valid = buf[2] >> 7;
> -	finger[1].is_valid = buf[5] >> 7;
> -
> -	/* get xy coordinate */
> -	if (finger[0].is_valid) {
> -		finger[0].x = ((buf[2] & 0x0070) << 4) | buf[3];
> -		finger[0].y = ((buf[2] & 0x0007) << 8) | buf[4];
> -		finger[0].t = buf[8];
> +	touch_data->finger[0].is_valid = buf[2] >> 7;
> +	touch_data->finger[1].is_valid = buf[5] >> 7;
> +
> +	/* get coordinate finger 0 */
> +	if (touch_data->finger[0].is_valid) {
> +		touch_data->finger[0].x = ((buf[2] & 0x70) << 4) | buf[3];
> +		touch_data->finger[0].y = ((buf[2] & 0x07) << 8) | buf[4];
> +		touch_data->finger[0].z = buf[8];
>  	}
>  
> -	if (finger[1].is_valid) {
> -		finger[1].x = ((buf[5] & 0x0070) << 4) | buf[6];
> -		finger[1].y = ((buf[5] & 0x0007) << 8) | buf[7];
> -		finger[1].t = buf[9];
> +	/* get coordinate finger 1 */
> +	if (touch_data->finger[1].is_valid) {
> +		touch_data->finger[1].x = ((buf[5] & 0x70) << 4) | buf[6];
> +		touch_data->finger[1].y = ((buf[5] & 0x07) << 8) | buf[7];
> +		touch_data->finger[1].z = buf[9];
>  	}
>  
>  	return 0;
> @@ -102,59 +125,155 @@ static int st1232_ts_read_data(struct st1232_ts_data *ts)
>  
>  static irqreturn_t st1232_ts_irq_handler(int irq, void *dev_id)
>  {
> -	struct st1232_ts_data *ts = dev_id;
> -	struct st1232_ts_finger *finger = ts->finger;
> +	struct st1232_data *ts = dev_id;
>  	struct input_dev *input_dev = ts->input_dev;
> -	int count = 0;
> +	struct st1232_touch_data st_tdata;
>  	int i, ret;
>  
> -	ret = st1232_ts_read_data(ts);
> -	if (ret < 0)
> -		goto end;
> +	ret = st1232_ts_read_data(ts->client, &st_tdata);
> +	if (ret < 0) {
> +		dev_err(dev_id, "Error reading touch data: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (st_tdata.finger_count > ST1232_MAX_FINGERS) {
> +		dev_warn(dev_id, "Too many fingers %d > %d\n",
> +			 st_tdata.finger_count, ST1232_MAX_FINGERS);
> +		st_tdata.finger_count = ST1232_MAX_FINGERS;
> +	}
>  
>  	/* multi touch protocol */
> -	for (i = 0; i < MAX_FINGERS; i++) {
> -		if (!finger[i].is_valid)
> +	for (i = 0; i < ST1232_MAX_FINGERS; i++) {
> +		input_mt_slot(input_dev, i);
> +		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER,
> +						st_tdata.finger[i].is_valid);
> +		if (!st_tdata.finger[i].is_valid)
>  			continue;
>  
> -		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR, finger[i].t);
> -		input_report_abs(input_dev, ABS_MT_POSITION_X, finger[i].x);
> -		input_report_abs(input_dev, ABS_MT_POSITION_Y, finger[i].y);
> -		input_mt_sync(input_dev);
> -		count++;
> -	}
> -
> -	/* SYN_MT_REPORT only if no contact */
> -	if (!count) {
> -		input_mt_sync(input_dev);
> -		if (ts->low_latency_req.dev) {
> -			dev_pm_qos_remove_request(&ts->low_latency_req);
> -			ts->low_latency_req.dev = NULL;
> +		input_report_abs(input_dev, ABS_MT_PRESSURE,
> +					st_tdata.finger[i].z);
> +
> +		if (ts->invert_x)
> +			st_tdata.finger[i].x = ts->max_x - st_tdata.finger[i].x;
> +
> +		if (ts->invert_y)
> +			st_tdata.finger[i].y = ts->max_y - st_tdata.finger[i].y;
> +
> +		if (!ts->swap_x_y) {
> +			input_event(input_dev, EV_ABS, ABS_MT_POSITION_X,
> +					st_tdata.finger[i].x);
> +			input_event(input_dev, EV_ABS, ABS_MT_POSITION_Y,
> +					st_tdata.finger[i].y);
> +		} else {
> +			input_event(input_dev, EV_ABS, ABS_MT_POSITION_X,
> +					st_tdata.finger[i].y);
> +			input_event(input_dev, EV_ABS, ABS_MT_POSITION_Y,
> +					st_tdata.finger[i].x);
>  		}
> -	} else if (!ts->low_latency_req.dev) {
> -		/* First contact, request 100 us latency. */
> -		dev_pm_qos_add_ancestor_request(&ts->client->dev,
> -						&ts->low_latency_req,
> -						DEV_PM_QOS_RESUME_LATENCY, 100);
>  	}
>  
>  	/* SYN_REPORT */
> +	input_mt_sync_frame(input_dev);
>  	input_sync(input_dev);
>  
> -end:
>  	return IRQ_HANDLED;
>  }
>  
> -static void st1232_ts_power(struct st1232_ts_data *ts, bool poweron)
> +static void st1232_ts_power(struct st1232_data *ts, bool poweron)
>  {
> +	/* only operates reset-pin */
>  	if (gpio_is_valid(ts->reset_gpio))
>  		gpio_direction_output(ts->reset_gpio, poweron);
>  }
>  
> +static int st1232_start(struct input_dev *dev)
> +{
> +	struct st1232_data *data = input_get_drvdata(dev);
> +	struct st1232_touch_data touch_data;
> +	int error;
> +	int count;
> +
> +	u8 start_reg = ST1232_REG_XY_RES;
> +	u8 buf[3];
> +	/* set high nible of x and y resolution */
> +	buf[0] = ((data->max_x >> 8) << 4) | (data->max_y >> 8);
> +	/* set low byte of x resolution */
> +	buf[1] = data->max_x;
> +	/* set low byte of x resolution */
> +	buf[2] = data->max_y;
> +	struct i2c_msg msg[2] = {
> +		{
> +			.addr = data->client->addr,
> +			.len = 1,
> +			.buf = &start_reg
> +		},
> +		{
> +			.addr = data->client->addr,
> +			.flags = 0,
> +			.len = sizeof(buf),
> +			.buf = (u8 *)buf
> +		}
> +	};
> +
> +	/* set reset-pin high */
> +	st1232_ts_power(data, true);
> +
> +	/* read status register, check for erros */
> +	count = 0;
> +	while (i2c_smbus_read_byte_data(data->client, ST1232_REG_STATUS) != 0) {
> +		/* wait for the device to come up */
> +		msleep(20);
> +		count++;
> +		if (count > 10) {
> +			dev_err(&data->client->dev, "Device status Not OKE\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* write 0 for defaults, disable powerdown */
> +	i2c_smbus_write_byte_data(data->client, ST1232_REG_CONTROL, 0);
> +
> +	/* write settings to controller */
> +	error = i2c_transfer(data->client->adapter, msg, 2);
> +	if (error < 0)
> +		return error;
> +
> +	/* read touch data to disgard possible interrupt */
> +	error = st1232_ts_read_data(data->client, &touch_data);
> +	if (error < 0)
> +		return error;
> +
> +	/* enable interrupt */
> +	enable_irq(data->client->irq);
> +
> +	dev_info(&data->client->dev, "Touchscreen device started\n");
> +
> +	return 0;
> +}
> +
> +static void st1232_stop(struct input_dev *dev)
> +{
> +	struct st1232_data *data = input_get_drvdata(dev);
> +
> +	/* disable interrupt */
> +	disable_irq(data->client->irq);
> +
> +	/* write powerdown to touchscreen */
> +	i2c_smbus_write_byte_data(data->client, ST1232_REG_CONTROL,
> +					ST1232_POWER_DOWN);
> +
> +	/* set reset-pin low */
> +	st1232_ts_power(data, false);
> +
> +	dev_info(&data->client->dev, "Touchscreen device stopped\n");
> +}
> +
>  static int st1232_ts_probe(struct i2c_client *client,
>  					const struct i2c_device_id *id)
>  {
> -	struct st1232_ts_data *ts;
> +	struct st1232_data *ts;
> +	struct device *dev = &client->dev;
> +	struct device_node *np = dev->of_node;
>  	struct st1232_pdata *pdata = dev_get_platdata(&client->dev);
>  	struct input_dev *input_dev;
>  	int error;
> @@ -177,8 +296,25 @@ static int st1232_ts_probe(struct i2c_client *client,
>  	if (!input_dev)
>  		return -ENOMEM;
>  
> -	ts->client = client;
> -	ts->input_dev = input_dev;
> +	if (of_property_read_u32(np, "touchscreen-size-x", &ts->max_x) ||
> +	    of_property_read_u32(np, "touchscreen-size-y", &ts->max_y)) {
> +		dev_err(&client->dev,
> +			"Error touchscreen-size-x and/or -y missing\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ts->max_x > ST1232_MAX_RESOLUTION ||
> +			ts->max_y > ST1232_MAX_RESOLUTION) {
> +		dev_err(&client->dev,
> +			"Error touchscreen-size-x and/or -y exceding maximum of %d\n",
> +			ST1232_MAX_RESOLUTION);
> +		return -EINVAL;
> +	}
> +
> +	/* Optional device tree properties */
> +	ts->swap_x_y = of_property_read_bool(np, "touchscreen-swapped-x-y");
> +	ts->invert_x = of_property_read_bool(np, "touchscreen-inverted-x");
> +	ts->invert_y = of_property_read_bool(np, "touchscreen-inverted-y");
>  
>  	if (pdata)
>  		ts->reset_gpio = pdata->reset_gpio;
> @@ -197,30 +333,46 @@ static int st1232_ts_probe(struct i2c_client *client,
>  		}
>  	}
>  
> -	st1232_ts_power(ts, true);
> -
> -	input_dev->name = "st1232-touchscreen";
> +	input_dev->name = client->name;
>  	input_dev->id.bustype = BUS_I2C;
> -	input_dev->dev.parent = &client->dev;
> +	input_dev->open = st1232_start;
> +	input_dev->close = st1232_stop;
> +	input_dev->dev.parent = dev;
> +
> +	if (!ts->swap_x_y) {
> +		input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
> +				     ts->max_x, 0, 0);
> +		input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
> +				     ts->max_y, 0, 0);
> +	} else {
> +		input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
> +				     ts->max_y, 0, 0);
> +		input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
> +				     ts->max_x, 0, 0);
> +	}
>  
> -	__set_bit(EV_SYN, input_dev->evbit);
> -	__set_bit(EV_KEY, input_dev->evbit);
> -	__set_bit(EV_ABS, input_dev->evbit);
> +	error = input_mt_init_slots(input_dev, ST1232_MAX_FINGERS,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error)
> +		return error;
>  
> -	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR, 0, MAX_AREA, 0, 0);
> -	input_set_abs_params(input_dev, ABS_MT_POSITION_X, MIN_X, MAX_X, 0, 0);
> -	input_set_abs_params(input_dev, ABS_MT_POSITION_Y, MIN_Y, MAX_Y, 0, 0);
> +	ts->client = client;
> +	ts->input_dev = input_dev;
> +	input_set_drvdata(input_dev, ts);
>  
>  	error = devm_request_threaded_irq(&client->dev, client->irq,
>  					  NULL, st1232_ts_irq_handler,
>  					  IRQF_ONESHOT,
>  					  client->name, ts);
>  	if (error) {
> -		dev_err(&client->dev, "Failed to register interrupt\n");
> +		dev_err(&client->dev, "Error requesting irq: %d\n", error);
>  		return error;
>  	}
>  
> -	error = input_register_device(ts->input_dev);
> +	/* Stop device till opened */
> +	st1232_stop(ts->input_dev);
> +
> +	error = input_register_device(input_dev);
>  	if (error) {
>  		dev_err(&client->dev, "Unable to register %s input device\n",
>  			input_dev->name);
> @@ -228,6 +380,8 @@ static int st1232_ts_probe(struct i2c_client *client,
>  	}
>  
>  	i2c_set_clientdata(client, ts);
> +
> +	/* allow the device to wake */
>  	device_init_wakeup(&client->dev, 1);
>  
>  	return 0;
> @@ -235,43 +389,43 @@ static int st1232_ts_probe(struct i2c_client *client,
>  
>  static int st1232_ts_remove(struct i2c_client *client)
>  {
> -	struct st1232_ts_data *ts = i2c_get_clientdata(client);
> +	struct st1232_data *ts = i2c_get_clientdata(client);
>  
>  	device_init_wakeup(&client->dev, 0);
> +
> +	/* set reset-pin low */
>  	st1232_ts_power(ts, false);
>  
>  	return 0;
>  }
>  
> -static int __maybe_unused st1232_ts_suspend(struct device *dev)
> +#ifdef CONFIG_PM_SLEEP
> +static int st1232_ts_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> -	struct st1232_ts_data *ts = i2c_get_clientdata(client);
> +	struct st1232_data *data = i2c_get_clientdata(client);
>  
> -	if (device_may_wakeup(&client->dev)) {
> -		enable_irq_wake(client->irq);
> -	} else {
> -		disable_irq(client->irq);
> -		st1232_ts_power(ts, false);
> -	}
> +	mutex_lock(&data->input_dev->mutex);
> +	if (data->input_dev->users)
> +		st1232_stop(data->input_dev);
> +	mutex_unlock(&data->input_dev->mutex);
>  
>  	return 0;
>  }
>  
> -static int __maybe_unused st1232_ts_resume(struct device *dev)
> +static int st1232_ts_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
> -	struct st1232_ts_data *ts = i2c_get_clientdata(client);
> +	struct st1232_data *data = i2c_get_clientdata(client);
>  
> -	if (device_may_wakeup(&client->dev)) {
> -		disable_irq_wake(client->irq);
> -	} else {
> -		st1232_ts_power(ts, true);
> -		enable_irq(client->irq);
> -	}
> +	mutex_lock(&data->input_dev->mutex);
> +	if (data->input_dev->users)
> +		st1232_start(data->input_dev);
> +	mutex_unlock(&data->input_dev->mutex);
>  
>  	return 0;
>  }
> +#endif
>  
>  static SIMPLE_DEV_PM_OPS(st1232_ts_pm_ops,
>  			 st1232_ts_suspend, st1232_ts_resume);
> @@ -282,13 +436,12 @@ static const struct i2c_device_id st1232_ts_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, st1232_ts_id);
>  
> -#ifdef CONFIG_OF
> -static const struct of_device_id st1232_ts_dt_ids[] = {
> +static const struct of_device_id st1232_of_match[] = {
>  	{ .compatible = "sitronix,st1232", },
>  	{ }
>  };
> -MODULE_DEVICE_TABLE(of, st1232_ts_dt_ids);
> -#endif
> +MODULE_DEVICE_TABLE(of, st1232_of_match);
> +
>  
>  static struct i2c_driver st1232_ts_driver = {
>  	.probe		= st1232_ts_probe,
> @@ -296,13 +449,14 @@ static struct i2c_driver st1232_ts_driver = {
>  	.id_table	= st1232_ts_id,
>  	.driver = {
>  		.name	= ST1232_TS_NAME,
> -		.of_match_table = of_match_ptr(st1232_ts_dt_ids),
> +		.owner	= THIS_MODULE,
> +		.of_match_table = st1232_of_match,
>  		.pm	= &st1232_ts_pm_ops,
>  	},
>  };
>  
>  module_i2c_driver(st1232_ts_driver);
>  
> -MODULE_AUTHOR("Tony SIM <chinyeow.sim.xt@renesas.com>");
> +MODULE_AUTHOR("Tony SIM <chinyeow.sim.xt@renesas.com>, Sander Vermin <sander@vermin.nl>");
>  MODULE_DESCRIPTION("SITRONIX ST1232 Touchscreen Controller Driver");
>  MODULE_LICENSE("GPL");
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
