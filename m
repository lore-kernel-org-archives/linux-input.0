From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH RFC V2 1/3] Input: goodix - add dt axis swapping and
 axis inversion support
Date: Tue, 13 Oct 2015 06:58:07 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0FE498@irsmsx105.ger.corp.intel.com>
References: <1444413352-24529-1-git-send-email-merker@debian.org>
 <1444413352-24529-2-git-send-email-merker@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:32290 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbbJMG6M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2015 02:58:12 -0400
In-Reply-To: <1444413352-24529-2-git-send-email-merker@debian.org>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Karsten Merker <merker@debian.org>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aleksei Mamlin <mamlinav@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>



> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Karsten Merker
> Sent: 09 October, 2015 20:56
> To: Bastien Nocera; Dmitry Torokhov; Tirdea, Irina; Aleksei Mamlin; linux-input@vger.kernel.org; Ian Campbell
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Chen-Yu Tsai; Karsten Merker
> Subject: [PATCH RFC V2 1/3] Input: goodix - add dt axis swapping and axis inversion support
> 
> Implement support for the following device-tree properties
> in the goodix touchscreen driver:
> 
>  - touchscreen-inverted-x:  X axis is inverted (boolean)
>  - touchscreen-inverted-y:  Y axis is inverted (boolean)
>  - touchscreen-swapped-x-y: X and Y axis are swapped (boolean)
> 
> These are necessary on tablets which have a display in portrait
> format while the touchscreen is in landscape format, such as e.g.
> the MSI Primo 81.
> 
> Signed-off-by: Karsten Merker <merker@debian.org>
> ---
>  drivers/input/touchscreen/goodix.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 22bfc4b..a05bdad 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -2,6 +2,7 @@
>   *  Driver for Goodix Touchscreens
>   *
>   *  Copyright (c) 2014 Red Hat Inc.
> + *  Copyright (c) 2015 K. Merker <merker@debian.org>
>   *
>   *  This code is based on gt9xx.c authored by andrew@goodix.com:
>   *
> @@ -53,6 +54,9 @@ struct goodix_ts_data {
>  	atomic_t open_count;
>  	/* Protects power management calls and access to suspended flag */
>  	struct mutex mutex;
> +	bool swapped_x_y;
> +	bool inverted_x;
> +	bool inverted_y;
>  };
> 
>  #define GOODIX_GPIO_INT_NAME		"irq"
> @@ -271,6 +275,14 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
>  		input_y = ts->abs_y_max - input_y;
>  	}
> 
> +	/* Inversions have to happen before axis swapping */
> +	if (ts->inverted_x)
> +		input_x = ts->abs_x_max - input_x;
> +	if (ts->inverted_y)
> +		input_y = ts->abs_y_max - input_y;
> +	if (ts->swapped_x_y)
> +		swap(input_x, input_y);
> +
>  	input_mt_slot(ts->input_dev, id);
>  	input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
>  	input_report_abs(ts->input_dev, ABS_MT_POSITION_X, input_x);
> @@ -666,6 +678,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
>  			 error);
>  		ts->abs_x_max = GOODIX_MAX_WIDTH;
>  		ts->abs_y_max = GOODIX_MAX_HEIGHT;
> +		if (ts->swapped_x_y)
> +			swap(ts->abs_x_max, ts->abs_y_max);
>  		ts->int_trigger_type = GOODIX_INT_TRIGGER;
>  		ts->max_touch_num = GOODIX_MAX_CONTACTS;
>  		return;
> @@ -673,6 +687,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
> 
>  	ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
>  	ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
> +	if (ts->swapped_x_y)
> +		swap(ts->abs_x_max, ts->abs_y_max);
>  	ts->int_trigger_type = config[TRIGGER_LOC] & 0x03;
>  	ts->max_touch_num = config[MAX_CONTACTS_LOC] & 0x0f;
>  	if (!ts->abs_x_max || !ts->abs_y_max || !ts->max_touch_num) {
> @@ -680,6 +696,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
>  			"Invalid config, using defaults\n");
>  		ts->abs_x_max = GOODIX_MAX_WIDTH;
>  		ts->abs_y_max = GOODIX_MAX_HEIGHT;
> +		if (ts->swapped_x_y)
> +			swap(ts->abs_x_max, ts->abs_y_max);
>  		ts->max_touch_num = GOODIX_MAX_CONTACTS;
>  	}
> 
> @@ -950,6 +968,15 @@ static int goodix_ts_probe(struct i2c_client *client,
>  		return 0;
>  	}
> 
> +#ifdef CONFIG_OF
> +	ts->swapped_x_y = of_property_read_bool(client->dev.of_node,
> +						"touchscreen-swapped-x-y");
> +	ts->inverted_x = of_property_read_bool(client->dev.of_node,
> +					       "touchscreen-inverted-x");
> +	ts->inverted_y = of_property_read_bool(client->dev.of_node,
> +					       "touchscreen-inverted-y");
> +#endif
> +

If interrupt and reset gpio pins are declared in the DT configuration, this code will not
be executed.  To make the properties available for all configurations (with/without
gpio pins declared), you should read the properties inside goodix_configure_dev().

You could also use device_property_read_bool() instead, so that these properties can
be used with ACPI 5.1. as well.

Thanks,
Irina

>  	return goodix_configure_dev(ts);
> 
>  err_free_cfg_name:
> --
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
