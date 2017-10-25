From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] Input: goodix - use generic touchscreen_properties
Date: Wed, 25 Oct 2017 21:42:03 +0200
Message-ID: <1508960523.28409.31.camel@hadess.net>
References: <20171025113217.7814-1-m.niestroj@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:54130 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932285AbdJYTmG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Oct 2017 15:42:06 -0400
In-Reply-To: <20171025113217.7814-1-m.niestroj@grinn-global.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcin Niestroj <m.niestroj@grinn-global.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org

Hey Marcin,

On Wed, 2017-10-25 at 13:32 +0200, Marcin Niestroj wrote:
> Use touchscreen_properties structure instead of implementing all
> properties by our own. It allows to reuse generic code for parsing
> device-tree properties (which was implemented manually in the driver
> for now). Additionally, it allows us to report events using generic
> touchscreen_report_pos(), which automatically handles inverted and
> swapped axes.
> 
> There was also bug in driver in touch position calculation, when axes
> were configured as inverted and swapped in the same time. This is
> however fixed now, by using touchscreen_report_pos() function, which
> handles inversion+swapping correctly.
<snip>
> @@ -579,6 +568,7 @@ static int goodix_get_gpio_config(struct goodix_ts_data *ts)
>  static void goodix_read_config(struct goodix_ts_data *ts)
>  {
>  	u8 config[GOODIX_CONFIG_MAX_LENGTH];
> +	int x_max, y_max;
>  	int error;
>  
>  	error = goodix_i2c_read(ts->client, ts->chip->config_addr,
> @@ -587,37 +577,34 @@ static void goodix_read_config(struct goodix_ts_data *ts)
>  		dev_warn(&ts->client->dev,
>  			 "Error reading config (%d), using defaults\n",
>  			 error);
> -		ts->abs_x_max = GOODIX_MAX_WIDTH;
> -		ts->abs_y_max = GOODIX_MAX_HEIGHT;
> -		if (ts->swapped_x_y)
> -			swap(ts->abs_x_max, ts->abs_y_max);
> +		x_max = GOODIX_MAX_WIDTH;
> +		y_max = GOODIX_MAX_HEIGHT;

When do you swap those out if necessary?

>  		ts->int_trigger_type = GOODIX_INT_TRIGGER;
>  		ts->max_touch_num = GOODIX_MAX_CONTACTS;
> -		return;
> +		goto input_set_params;
>  	}
>  
> -	ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
> -	ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
> -	if (ts->swapped_x_y)
> -		swap(ts->abs_x_max, ts->abs_y_max);
> +	x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
> +	y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
>  	ts->int_trigger_type = config[TRIGGER_LOC] & 0x03;
>  	ts->max_touch_num = config[MAX_CONTACTS_LOC] & 0x0f;
> -	if (!ts->abs_x_max || !ts->abs_y_max || !ts->max_touch_num) {
> +	if (!x_max || !y_max || !ts->max_touch_num) {
>  		dev_err(&ts->client->dev,
>  			"Invalid config, using defaults\n");
> -		ts->abs_x_max = GOODIX_MAX_WIDTH;
> -		ts->abs_y_max = GOODIX_MAX_HEIGHT;
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
> -			 "Applying '180 degrees rotated screen' quirk\n");
> -	}
> +input_set_params:
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X,
> +			0, x_max - 1, 0, 0);
> +	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y,
> +			0, y_max - 1, 0, 0);

This is x_max - 1, and y_max - 1, when the original code used x_max and
y_max. Can you mention this fix in the changelog as well, or better,
split it off in a separate fix?

Looks good overall, but was this tested, and if so, on which device?
Could you add a reference to the hardware used for testing in the
commit log?

Cheers
