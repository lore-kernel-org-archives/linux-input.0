From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 3/3] Input: goodix - use generic
 touchscreen_properties
Date: Fri, 26 Jan 2018 10:44:45 +0100
Message-ID: <1516959885.2592.0.camel@hadess.net>
References: <20180125190829.8968-1-m.niestroj@grinn-global.com>
         <20180125190829.8968-4-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43017 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752942AbeAZJot (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 26 Jan 2018 04:44:49 -0500
In-Reply-To: <20180125190829.8968-4-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org

On Thu, 2018-01-25 at 20:08 +0100, Marcin Niestroj wrote:
> Use touchscreen_properties structure instead of implementing all
> properties by our own. It allows us to reuse generic code for parsing
> device-tree properties (which was implemented manually in the driver
> for now). Additionally, it allows us to report events using generic
> touchscreen_report_pos(), which automatically handles inverted and
> swapped axes.
> 
> Developed and tested on custom DT-based device with gt1151 touch
> panel.
> 
> Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>

Reviewed-by: Bastien Nocera <hadess@hadess.net>

> ---
> Changes v2 -> v3 (suggested by Bastien):
>  - fix commit description
> 
> Changes v1 -> v2:
>  - rebased on patches 1 and 2 in series
>  - added description of test board in changelog (suggested by
> Bastien)
> 
>  drivers/input/touchscreen/goodix.c | 93 ++++++++++++++------------
> ------------
>  1 file changed, 33 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/goodix.c
> b/drivers/input/touchscreen/goodix.c
> index dc832890f6d3..f82101cd9c04 100644
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
> @@ -295,24 +292,10 @@ static void goodix_ts_report_touch(struct
> goodix_ts_data *ts, u8 *coor_data)
>  	int input_y = get_unaligned_le16(&coor_data[3]);
>  	int input_w = get_unaligned_le16(&coor_data[5]);
>  
> -	/* Inversions have to happen before axis swapping */
> -	if (!ts->swapped_x_y) {
> -		if (ts->inverted_x)
> -			input_x = ts->abs_x_max - input_x;
> -		if (ts->inverted_y)
> -			input_y = ts->abs_y_max - input_y;
> -	} else {
> -		if (ts->inverted_x)
> -			input_x = ts->abs_y_max - input_x;
> -		if (ts->inverted_y)
> -			input_y = ts->abs_x_max - input_y;
> -		swap(input_x, input_y);
> -	}
> -
>  	input_mt_slot(ts->input_dev, id);
>  	input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER,
> true);
> -	input_report_abs(ts->input_dev, ABS_MT_POSITION_X, input_x);
> -	input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, input_y);
> +	touchscreen_report_pos(ts->input_dev, &ts->prop, input_x,
> input_y,
> +			true);
>  	input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
> input_w);
>  	input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR,
> input_w);
>  }
> @@ -585,6 +568,7 @@ static int goodix_get_gpio_config(struct
> goodix_ts_data *ts)
>  static void goodix_read_config(struct goodix_ts_data *ts)
>  {
>  	u8 config[GOODIX_CONFIG_MAX_LENGTH];
> +	int x_max, y_max;
>  	int error;
>  
>  	error = goodix_i2c_read(ts->client, ts->chip->config_addr,
> @@ -593,37 +577,34 @@ static void goodix_read_config(struct
> goodix_ts_data *ts)
>  		dev_warn(&ts->client->dev,
>  			 "Error reading config (%d), using
> defaults\n",
>  			 error);
> -		ts->abs_x_max = GOODIX_MAX_WIDTH - 1;
> -		ts->abs_y_max = GOODIX_MAX_HEIGHT - 1;
> -		if (ts->swapped_x_y)
> -			swap(ts->abs_x_max, ts->abs_y_max);
> +		x_max = GOODIX_MAX_WIDTH;
> +		y_max = GOODIX_MAX_HEIGHT;
>  		ts->int_trigger_type = GOODIX_INT_TRIGGER;
>  		ts->max_touch_num = GOODIX_MAX_CONTACTS;
> -		return;
> +		goto input_set_params;
>  	}
>  
> -	ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC])
> - 1;
> -	ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC +
> 2]) - 1;
> -	if (ts->swapped_x_y)
> -		swap(ts->abs_x_max, ts->abs_y_max);
> +	x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
> +	y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
>  	ts->int_trigger_type = config[TRIGGER_LOC] & 0x03;
>  	ts->max_touch_num = config[MAX_CONTACTS_LOC] & 0x0f;
> -	if (!ts->abs_x_max || !ts->abs_y_max || !ts->max_touch_num)
> {
> +	if (!x_max || !y_max || !ts->max_touch_num) {
>  		dev_err(&ts->client->dev,
>  			"Invalid config, using defaults\n");
> -		ts->abs_x_max = GOODIX_MAX_WIDTH - 1;
> -		ts->abs_y_max = GOODIX_MAX_HEIGHT - 1;
> -		if (ts->swapped_x_y)
> -			swap(ts->abs_x_max, ts->abs_y_max);
> +		x_max = GOODIX_MAX_WIDTH;
> +		y_max = GOODIX_MAX_HEIGHT;
>  		ts->max_touch_num = GOODIX_MAX_CONTACTS;
>  	}
>  
> -	if (dmi_check_system(rotated_screen)) {
> -		ts->inverted_x = true;
> -		ts->inverted_y = true;
> -		dev_dbg(&ts->client->dev,
> -			 "Applying '180 degrees rotated screen'
> quirk\n");
> -	}
> +input_set_params:
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> +			0, x_max - 1, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> +			0, y_max - 1, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0,
> 255, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0,
> 255, 0, 0);
> +	input_mt_init_slots(ts->input_dev, ts->max_touch_num,
> +			INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
>  }
>  
>  /**
> @@ -698,16 +679,6 @@ static int goodix_request_input_dev(struct
> goodix_ts_data *ts)
>  		return -ENOMEM;
>  	}
>  
> -	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> -			     0, ts->abs_x_max, 0, 0);
> -	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> -			     0, ts->abs_y_max, 0, 0);
> -	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0,
> 255, 0, 0);
> -	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0,
> 255, 0, 0);
> -
> -	input_mt_init_slots(ts->input_dev, ts->max_touch_num,
> -			    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
> -
>  	ts->input_dev->name = "Goodix Capacitive TouchScreen";
>  	ts->input_dev->phys = "input/ts";
>  	ts->input_dev->id.bustype = BUS_I2C;
> @@ -742,19 +713,21 @@ static int goodix_configure_dev(struct
> goodix_ts_data *ts)
>  {
>  	int error;
>  
> -	ts->swapped_x_y = device_property_read_bool(&ts->client-
> >dev,
> -						    "touchscreen-
> swapped-x-y");
> -	ts->inverted_x = device_property_read_bool(&ts->client->dev,
> -						   "touchscreen-
> inverted-x");
> -	ts->inverted_y = device_property_read_bool(&ts->client->dev,
> -						   "touchscreen-
> inverted-y");
> -
> -	goodix_read_config(ts);
> -
>  	error = goodix_request_input_dev(ts);
>  	if (error)
>  		return error;
>  
> +	goodix_read_config(ts);
> +
> +	touchscreen_parse_properties(ts->input_dev, true, &ts-
> >prop);
> +
> +	if (dmi_check_system(rotated_screen)) {
> +		ts->prop.invert_x = true;
> +		ts->prop.invert_y = true;
> +		dev_dbg(&ts->client->dev,
> +			"Applying '180 degrees rotated screen'
> quirk\n");
> +	}
> +
>  	ts->irq_flags = goodix_irq_flags[ts->int_trigger_type] |
> IRQF_ONESHOT;
>  	error = goodix_request_irq(ts);
>  	if (error) {
