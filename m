From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 4/4] touchscreen: pixcir_ts: Add support for axis
 inversion / swapping
Date: Fri, 15 Jul 2016 14:45:16 -0700
Message-ID: <20160715214516.GE27847@dtor-ws>
References: <1468590491-10269-1-git-send-email-hdegoede@redhat.com>
 <1468590491-10269-5-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34558 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbcGOVpU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jul 2016 17:45:20 -0400
Received: by mail-pa0-f66.google.com with SMTP id hh10so6734725pac.1
        for <linux-input@vger.kernel.org>; Fri, 15 Jul 2016 14:45:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1468590491-10269-5-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org

On Fri, Jul 15, 2016 at 03:48:11PM +0200, Hans de Goede wrote:
> Add support for axis inversion / swapping using the new
> touchscreen_parse_properties and touchscreen_apply_prop_to_x_y
> functionality.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Add a fix which actually makes this patch compile, which accidentally ended
>  up in a later commit in my tree
> Changes in v3:
> -Use new touchscreen_set_mt_pos helper
> ---
>  drivers/input/touchscreen/pixcir_i2c_ts.c | 48 ++++++++++++-------------------
>  1 file changed, 18 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
> index f58784d..c696c5d 100644
> --- a/drivers/input/touchscreen/pixcir_i2c_ts.c
> +++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
> @@ -41,19 +41,15 @@ struct pixcir_i2c_ts_data {
>  	struct gpio_desc *gpio_enable;
>  	struct gpio_desc *gpio_wake;
>  	const struct pixcir_i2c_chip_data *chip;
> +	struct touchscreen_properties prop;
>  	int max_fingers;	/* Max fingers supported in this instance */
>  	bool running;
>  };
>  
> -struct pixcir_touch {
> -	int x;
> -	int y;
> -	int id;
> -};
> -
>  struct pixcir_report_data {
>  	int num_touches;
> -	struct pixcir_touch touches[PIXCIR_MAX_SLOTS];
> +	struct input_mt_pos pos[PIXCIR_MAX_SLOTS];
> +	int ids[PIXCIR_MAX_SLOTS];
>  };
>  
>  static void pixcir_ts_parse(struct pixcir_i2c_ts_data *tsdata,
> @@ -98,11 +94,11 @@ static void pixcir_ts_parse(struct pixcir_i2c_ts_data *tsdata,
>  	bufptr = &rdbuf[2];
>  
>  	for (i = 0; i < touch; i++) {
> -		report->touches[i].x = (bufptr[1] << 8) | bufptr[0];
> -		report->touches[i].y = (bufptr[3] << 8) | bufptr[2];
> -
> +		touchscreen_set_mt_pos(&report->pos[i], &tsdata->prop,
> +				       (bufptr[1] << 8) | bufptr[0],
> +				       (bufptr[3] << 8) | bufptr[2]);

I replaced this with calls to get_unaligned_le16() while we are at it.

>  		if (chip->has_hw_ids) {
> -			report->touches[i].id = bufptr[4];
> +			report->ids[i] = bufptr[4];
>  			bufptr = bufptr + 5;
>  		} else {
>  			bufptr = bufptr + 4;
> @@ -113,9 +109,7 @@ static void pixcir_ts_parse(struct pixcir_i2c_ts_data *tsdata,
>  static void pixcir_ts_report(struct pixcir_i2c_ts_data *ts,
>  			     struct pixcir_report_data *report)
>  {
> -	struct input_mt_pos pos[PIXCIR_MAX_SLOTS];
>  	int slots[PIXCIR_MAX_SLOTS];
> -	struct pixcir_touch *touch;
>  	int n, i, slot;
>  	struct device *dev = &ts->client->dev;
>  	const struct pixcir_i2c_chip_data *chip = ts->chip;
> @@ -124,24 +118,16 @@ static void pixcir_ts_report(struct pixcir_i2c_ts_data *ts,
>  	if (n > PIXCIR_MAX_SLOTS)
>  		n = PIXCIR_MAX_SLOTS;
>  
> -	if (!ts->chip->has_hw_ids) {
> -		for (i = 0; i < n; i++) {
> -			touch = &report->touches[i];
> -			pos[i].x = touch->x;
> -			pos[i].y = touch->y;
> -		}
> -
> -		input_mt_assign_slots(ts->input, slots, pos, n, 0);
> -	}
> +	if (!ts->chip->has_hw_ids)
> +		input_mt_assign_slots(ts->input, slots, report->pos, n, 0);
>  
>  	for (i = 0; i < n; i++) {
> -		touch = &report->touches[i];
> -
>  		if (chip->has_hw_ids) {
> -			slot = input_mt_get_slot_by_key(ts->input, touch->id);
> +			slot = input_mt_get_slot_by_key(ts->input,
> +							report->ids[i]);
>  			if (slot < 0) {
>  				dev_dbg(dev, "no free slot for id 0x%x\n",
> -					touch->id);
> +					report->ids[i]);
>  				continue;
>  			}
>  		} else {
> @@ -152,11 +138,13 @@ static void pixcir_ts_report(struct pixcir_i2c_ts_data *ts,
>  		input_mt_report_slot_state(ts->input,
>  					   MT_TOOL_FINGER, true);
>  
> -		input_event(ts->input, EV_ABS, ABS_MT_POSITION_X, touch->x);
> -		input_event(ts->input, EV_ABS, ABS_MT_POSITION_Y, touch->y);
> +		input_event(ts->input, EV_ABS, ABS_MT_POSITION_X,
> +			    report->pos[i].x);
> +		input_event(ts->input, EV_ABS, ABS_MT_POSITION_Y,
> +			    report->pos[i].y);

and this with input_report_abs().

>  
>  		dev_dbg(dev, "%d: slot %d, x %d, y %d\n",
> -			i, slot, touch->x, touch->y);
> +			i, slot, report->pos[i].x, report->pos[i].y);
>  	}
>  
>  	input_mt_sync_frame(ts->input);
> @@ -515,7 +503,7 @@ static int pixcir_i2c_ts_probe(struct i2c_client *client,
>  	} else {
>  		input_set_capability(input, EV_ABS, ABS_MT_POSITION_X);
>  		input_set_capability(input, EV_ABS, ABS_MT_POSITION_Y);
> -		touchscreen_parse_properties(input, true, NULL);
> +		touchscreen_parse_properties(input, true, &tsdata->prop);
>  		if (!input_abs_get_max(input, ABS_MT_POSITION_X) ||
>  		    !input_abs_get_max(input, ABS_MT_POSITION_Y)) {
>  			dev_err(dev, "Touchscreen size is not specified\n");
> -- 
> 2.7.4
> 

Applied, thank you.

-- 
Dmitry
