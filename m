From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Change the hover event from MT to ST
Date: Tue, 7 Jul 2015 11:06:24 -0700
Message-ID: <20150707180624.GD12491@dtor-ws>
References: <7389F224-E5E4-4DA0-A70F-4CBB70F53F2E@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38287 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932520AbbGGSG3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jul 2015 14:06:29 -0400
Content-Disposition: inline
In-Reply-To: <7389F224-E5E4-4DA0-A70F-4CBB70F53F2E@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: duson <dusonlin@emc.com.tw>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 07, 2015 at 01:37:14PM +0800, duson wrote:
> We want the hover event like BTN_LEFT, even no contract object,
> it still can be reported to upper OS system.
> 
> Signed-off by: Duson Lin <dusonlin@emc.com.tw>

Applied, thank you.

> ---
>  drivers/input/mouse/elan_i2c_core.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 62641f2..5b5f403 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -771,7 +771,7 @@ static const struct attribute_group *elan_sysfs_groups[] = {
>   */
>  static void elan_report_contact(struct elan_tp_data *data,
>  				int contact_num, bool contact_valid,
> -				bool hover_event, u8 *finger_data)
> +				u8 *finger_data)
>  {
>  	struct input_dev *input = data->input;
>  	unsigned int pos_x, pos_y;
> @@ -815,9 +815,7 @@ static void elan_report_contact(struct elan_tp_data *data,
>  		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
>  		input_report_abs(input, ABS_MT_POSITION_X, pos_x);
>  		input_report_abs(input, ABS_MT_POSITION_Y, data->max_y - pos_y);
> -		input_report_abs(input, ABS_MT_DISTANCE, hover_event);
> -		input_report_abs(input, ABS_MT_PRESSURE,
> -				 hover_event ? 0 : scaled_pressure);
> +		input_report_abs(input, ABS_MT_PRESSURE, scaled_pressure);
>  		input_report_abs(input, ABS_TOOL_WIDTH, mk_x);
>  		input_report_abs(input, ABS_MT_TOUCH_MAJOR, major);
>  		input_report_abs(input, ABS_MT_TOUCH_MINOR, minor);
> @@ -839,14 +837,14 @@ static void elan_report_absolute(struct elan_tp_data *data, u8 *packet)
>  	hover_event = hover_info & 0x40;
>  	for (i = 0; i < ETP_MAX_FINGERS; i++) {
>  		contact_valid = tp_info & (1U << (3 + i));
> -		elan_report_contact(data, i, contact_valid, hover_event,
> -				    finger_data);
> +		elan_report_contact(data, i, contact_valid, finger_data);
>  
>  		if (contact_valid)
>  			finger_data += ETP_FINGER_DATA_LEN;
>  	}
>  
>  	input_report_key(input, BTN_LEFT, tp_info & 0x01);
> +	input_report_abs(input, ABS_DISTANCE, hover_event != 0);
>  	input_mt_report_pointer_emulation(input, true);
>  	input_sync(input);
>  }
> @@ -922,6 +920,7 @@ static int elan_setup_input_device(struct elan_tp_data *data)
>  	input_abs_set_res(input, ABS_Y, data->y_res);
>  	input_set_abs_params(input, ABS_PRESSURE, 0, ETP_MAX_PRESSURE, 0, 0);
>  	input_set_abs_params(input, ABS_TOOL_WIDTH, 0, ETP_FINGER_WIDTH, 0, 0);
> +	input_set_abs_params(input, ABS_DISTANCE, 0, 1, 0, 0);
>  
>  	/* And MT parameters */
>  	input_set_abs_params(input, ABS_MT_POSITION_X, 0, data->max_x, 0, 0);
> @@ -934,7 +933,6 @@ static int elan_setup_input_device(struct elan_tp_data *data)
>  			     ETP_FINGER_WIDTH * max_width, 0, 0);
>  	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0,
>  			     ETP_FINGER_WIDTH * min_width, 0, 0);
> -	input_set_abs_params(input, ABS_MT_DISTANCE, 0, 1, 0, 0);
>  
>  	data->input = input;
> 
> 
> 
> 
> 

-- 
Dmitry
