From: Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: Re: [PATCH v3 3/3] Input: goodix - use generic touchscreen_properties
Date: Mon, 29 Jan 2018 17:49:16 +0100
Message-ID: <62f8eb3c-d389-40da-7fab-53f18b61030b@grinn-global.com>
References: <20180125190829.8968-1-m.niestroj@grinn-global.com>
 <20180125190829.8968-4-m.niestroj@grinn-global.com>
 <20180126191945.q3sx2pcs7rvpil33@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.megiteam.pl ([31.186.83.105]:51490 "EHLO smtp.megiteam.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751204AbeA2QtT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Jan 2018 11:49:19 -0500
In-Reply-To: <20180126191945.q3sx2pcs7rvpil33@dtor-ws>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org

Hi Dmitry,

On 26.01.2018 20:19, Dmitry Torokhov wrote:
> Hi Marcin,
> 
> On Thu, Jan 25, 2018 at 08:08:29PM +0100, Marcin Niestroj wrote:
>> <...snip...>
> 
> You want to do reading of the config and parsing properties and applying
> them to the input device before input device is registered. Actually,
> you want to do that before you call input_mt_init_slots() to make sure
> multitouch and single-touch data is consistend (ABS_MT_POSITION_X/Y vs
> ABS_X/Y).
> 
> Can you please try the version below (note that I sqashed all your 3
> patches in one as, as I mentioed, I do not see why they need to be split
> in the first place).

I've tested code below and everything works great on my hardware.

Regards,
Marcin

> 
> Thanks.
> 
> -- 
> Dmitry
> 
> 
> Input: goodix - use generic touchscreen_properties
> 
> From: Marcin Niestroj <m.niestroj@grinn-global.com>
> 
> Use touchscreen_properties structure instead of implementing all
> properties by our own. It allows us to reuse generic code for parsing
> device-tree properties (which was implemented manually in the driver for
> now). Additionally, it allows us to report events using generic
> touchscreen_report_pos(), which automatically handles inverted and
> swapped axes.
> 
> This fixes the issue with the custom code incorrectly handling case where
> ts->inverted_x and ts->swapped_x_y were true, but ts->inverted_y was
> false. Assuming we have 720x1280 touch panel, ts->abs_x_max == 1279 and
> ts->abs_y_max == 719 (because we inverted that in goodix_read_config()).
> Now let's assume that we received event from (0:0) position (in touch
> panel original coordinates). In function goodix_ts_report_touch() we
> calculate input_x as 1279, but after swapping input_y takes that value
> (which is more that maximum 719 value reported during initialization).
> 
> Note that since touchscreen coordinates are 0-indexed, we now report
> touchscreen range as (0:size-1).
> 
> Developed and tested on custom DT-based device with gt1151 touch
> panel.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
> Patchwork-Id: 10184731
> [dtor: fix endianness annotation reported by sparse, handle errors when
>  initializing MT slots]
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/touchscreen/goodix.c |  141 +++++++++++++++---------------------
>  1 file changed, 58 insertions(+), 83 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index ecec8eb17f28b..9736c83dd418f 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -22,6 +22,7 @@
>  #include <linux/i2c.h>
>  #include <linux/input.h>
>  #include <linux/input/mt.h>
> +#include <linux/input/touchscreen.h>
>  #include <linux/module.h>
>  #include <linux/delay.h>
>  #include <linux/irq.h>
> @@ -43,11 +44,7 @@ struct goodix_ts_data {
>  	struct i2c_client *client;
>  	struct input_dev *input_dev;
>  	const struct goodix_chip_data *chip;
> -	int abs_x_max;
> -	int abs_y_max;
> -	bool swapped_x_y;
> -	bool inverted_x;
> -	bool inverted_y;
> +	struct touchscreen_properties prop;
>  	unsigned int max_touch_num;
>  	unsigned int int_trigger_type;
>  	struct gpio_desc *gpiod_int;
> @@ -160,7 +157,7 @@ static int goodix_i2c_read(struct i2c_client *client,
>  			   u16 reg, u8 *buf, int len)
>  {
>  	struct i2c_msg msgs[2];
> -	u16 wbuf = cpu_to_be16(reg);
> +	__be16 wbuf = cpu_to_be16(reg);
>  	int ret;
>  
>  	msgs[0].flags = 0;
> @@ -295,18 +292,10 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
>  	int input_y = get_unaligned_le16(&coor_data[3]);
>  	int input_w = get_unaligned_le16(&coor_data[5]);
>  
> -	/* Inversions have to happen before axis swapping */
> -	if (ts->inverted_x)
> -		input_x = ts->abs_x_max - input_x;
> -	if (ts->inverted_y)
> -		input_y = ts->abs_y_max - input_y;
> -	if (ts->swapped_x_y)
> -		swap(input_x, input_y);
> -
>  	input_mt_slot(ts->input_dev, id);
>  	input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
> -	input_report_abs(ts->input_dev, ABS_MT_POSITION_X, input_x);
> -	input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, input_y);
> +	touchscreen_report_pos(ts->input_dev, &ts->prop,
> +			       input_x, input_y, true);
>  	input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, input_w);
>  	input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, input_w);
>  }
> @@ -579,44 +568,27 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
>  static void goodix_read_config(struct goodix_ts_data *ts)
>  {
>  	u8 config[GOODIX_CONFIG_MAX_LENGTH];
> +	int x_max, y_max;
>  	int error;
>  
>  	error = goodix_i2c_read(ts->client, ts->chip->config_addr,
>  				config, ts->chip->config_len);
>  	if (error) {
> -		dev_warn(&ts->client->dev,
> -			 "Error reading config (%d), using defaults\n",
> +		dev_warn(&ts->client->dev, "Error reading config: %d\n",
>  			 error);
> -		ts->abs_x_max = GOODIX_MAX_WIDTH;
> -		ts->abs_y_max = GOODIX_MAX_HEIGHT;
> -		if (ts->swapped_x_y)
> -			swap(ts->abs_x_max, ts->abs_y_max);
>  		ts->int_trigger_type = GOODIX_INT_TRIGGER;
>  		ts->max_touch_num = GOODIX_MAX_CONTACTS;
>  		return;
>  	}
>  
> -	ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
> -	ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
> -	if (ts->swapped_x_y)
> -		swap(ts->abs_x_max, ts->abs_y_max);
>  	ts->int_trigger_type = config[TRIGGER_LOC] & 0x03;
>  	ts->max_touch_num = config[MAX_CONTACTS_LOC] & 0x0f;
> -	if (!ts->abs_x_max || !ts->abs_y_max || !ts->max_touch_num) {
> -		dev_err(&ts->client->dev,
> -			"Invalid config, using defaults\n");
> -		ts->abs_x_max = GOODIX_MAX_WIDTH;
> -		ts->abs_y_max = GOODIX_MAX_HEIGHT;
> -		if (ts->swapped_x_y)
> -			swap(ts->abs_x_max, ts->abs_y_max);
> -		ts->max_touch_num = GOODIX_MAX_CONTACTS;
> -	}
>  
> -	if (dmi_check_system(rotated_screen)) {
> -		ts->inverted_x = true;
> -		ts->inverted_y = true;
> -		dev_dbg(&ts->client->dev,
> -			 "Applying '180 degrees rotated screen' quirk\n");
> +	x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
> +	y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
> +	if (x_max && y_max) {
> +		input_abs_set_max(ts->input_dev, ABS_MT_POSITION_X, x_max - 1);
> +		input_abs_set_max(ts->input_dev, ABS_MT_POSITION_Y, y_max - 1);
>  	}
>  }
>  
> @@ -676,32 +648,28 @@ static int goodix_i2c_test(struct i2c_client *client)
>  }
>  
>  /**
> - * goodix_request_input_dev - Allocate, populate and register the input device
> + * goodix_configure_dev - Finish device initialization
>   *
>   * @ts: our goodix_ts_data pointer
>   *
> - * Must be called during probe
> + * Must be called from probe to finish initialization of the device.
> + * Contains the common initialization code for both devices that
> + * declare gpio pins and devices that do not. It is either called
> + * directly from probe or from request_firmware_wait callback.
>   */
> -static int goodix_request_input_dev(struct goodix_ts_data *ts)
> +static int goodix_configure_dev(struct goodix_ts_data *ts)
>  {
>  	int error;
>  
> +	ts->int_trigger_type = GOODIX_INT_TRIGGER;
> +	ts->max_touch_num = GOODIX_MAX_CONTACTS;
> +
>  	ts->input_dev = devm_input_allocate_device(&ts->client->dev);
>  	if (!ts->input_dev) {
>  		dev_err(&ts->client->dev, "Failed to allocate input device.");
>  		return -ENOMEM;
>  	}
>  
> -	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> -			     0, ts->abs_x_max, 0, 0);
> -	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> -			     0, ts->abs_y_max, 0, 0);
> -	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
> -	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
> -
> -	input_mt_init_slots(ts->input_dev, ts->max_touch_num,
> -			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> -
>  	ts->input_dev->name = "Goodix Capacitive TouchScreen";
>  	ts->input_dev->phys = "input/ts";
>  	ts->input_dev->id.bustype = BUS_I2C;
> @@ -712,42 +680,49 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
>  	/* Capacitive Windows/Home button on some devices */
>  	input_set_capability(ts->input_dev, EV_KEY, KEY_LEFTMETA);
>  
> -	error = input_register_device(ts->input_dev);
> -	if (error) {
> -		dev_err(&ts->client->dev,
> -			"Failed to register input device: %d", error);
> -		return error;
> -	}
> +	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_X);
> +	input_set_capability(ts->input_dev, EV_ABS, ABS_MT_POSITION_Y);
> +	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
>  
> -	return 0;
> -}
> +	/* Read configuration and apply touchscreen parameters */
> +	goodix_read_config(ts);
>  
> -/**
> - * goodix_configure_dev - Finish device initialization
> - *
> - * @ts: our goodix_ts_data pointer
> - *
> - * Must be called from probe to finish initialization of the device.
> - * Contains the common initialization code for both devices that
> - * declare gpio pins and devices that do not. It is either called
> - * directly from probe or from request_firmware_wait callback.
> - */
> -static int goodix_configure_dev(struct goodix_ts_data *ts)
> -{
> -	int error;
> +	/* Try overriding touchscreen parameters via device properties */
> +	touchscreen_parse_properties(ts->input_dev, true, &ts->prop);
>  
> -	ts->swapped_x_y = device_property_read_bool(&ts->client->dev,
> -						    "touchscreen-swapped-x-y");
> -	ts->inverted_x = device_property_read_bool(&ts->client->dev,
> -						   "touchscreen-inverted-x");
> -	ts->inverted_y = device_property_read_bool(&ts->client->dev,
> -						   "touchscreen-inverted-y");
> +	if (!ts->prop.max_x || !ts->prop.max_y || !ts->max_touch_num) {
> +		dev_err(&ts->client->dev, "Invalid config, using defaults\n");
> +		ts->prop.max_x = GOODIX_MAX_WIDTH - 1;
> +		ts->prop.max_y = GOODIX_MAX_HEIGHT - 1;
> +		ts->max_touch_num = GOODIX_MAX_CONTACTS;
> +		input_abs_set_max(ts->input_dev,
> +				  ABS_MT_POSITION_X, ts->prop.max_x);
> +		input_abs_set_max(ts->input_dev,
> +				  ABS_MT_POSITION_Y, ts->prop.max_y);
> +	}
>  
> -	goodix_read_config(ts);
> +	if (dmi_check_system(rotated_screen)) {
> +		ts->prop.invert_x = true;
> +		ts->prop.invert_y = true;
> +		dev_dbg(&ts->client->dev,
> +			"Applying '180 degrees rotated screen' quirk\n");
> +	}
>  
> -	error = goodix_request_input_dev(ts);
> -	if (error)
> +	error = input_mt_init_slots(ts->input_dev, ts->max_touch_num,
> +				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"Failed to initialize MT slots: %d", error);
> +		return error;
> +	}
> +
> +	error = input_register_device(ts->input_dev);
> +	if (error) {
> +		dev_err(&ts->client->dev,
> +			"Failed to register input device: %d", error);
>  		return error;
> +	}
>  
>  	ts->irq_flags = goodix_irq_flags[ts->int_trigger_type] | IRQF_ONESHOT;
>  	error = goodix_request_irq(ts);


-- 
Marcin Niestroj
