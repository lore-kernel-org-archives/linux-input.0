From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 4/4] Input: atmel_mxt_ts - Convert to MT protocol B
Date: Thu, 10 Mar 2011 12:10:40 +0100
Message-ID: <20110310111040.GA2595@polaris.bitmath.org>
References: <1299488069-24291-1-git-send-email-jy0922.shim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:39274 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751312Ab1CJLH7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2011 06:07:59 -0500
Content-Disposition: inline
In-Reply-To: <1299488069-24291-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, iiro.valkonen@atmel.com, kyungmin.park@samsung.com

Hi Joonyoung,

> Atmel touchscreen chips can use MT protocol B because they can assign
> unique id to ABS_MT_TRACKING_ID from finger id provided by hardware.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>

Thanks for making this change. Please see comments inline.

> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c |   37 ++++++++++++++++++++---------
>  1 files changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index fd1fda5..7da71d9 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -203,6 +203,7 @@
>  
>  /* Touchscreen absolute values */
>  #define MXT_MAX_AREA		0xff
> +#define MXT_MAX_TRACKING_ID	0xff

Instead, include <linux/input/mt.h>

>  #define MXT_MAX_FINGER		10
>  
> @@ -238,6 +239,7 @@ struct mxt_finger {
>  	int x;
>  	int y;
>  	int area;
> +	int trkid;

The tracking id is now handled in the input core, so it can be dropped here.

>  };
>  
>  /* Each client has this additional data */
> @@ -504,19 +506,19 @@ static void mxt_input_report(struct mxt_data *data, int single_id)
>  		if (!finger[id].status)
>  			continue;
>  
> -		input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
> -				finger[id].status != MXT_RELEASE ?
> -				finger[id].area : 0);
> -		input_report_abs(input_dev, ABS_MT_POSITION_X,
> -				finger[id].x);
> -		input_report_abs(input_dev, ABS_MT_POSITION_Y,
> -				finger[id].y);
> -		input_mt_sync(input_dev);
> -
> -		if (finger[id].status == MXT_RELEASE)
> -			finger[id].status = 0;
> -		else
> +		input_mt_slot(input_dev, id);
> +		input_report_abs(input_dev, ABS_MT_TRACKING_ID,
> +				finger[id].trkid);

Replace the line above with (possibly using a temp variable instead)

input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, finger[id].status != MXT_RELEASE);


> +		if (finger[id].status != MXT_RELEASE) {

>  			finger_num++;
> +			input_report_abs(input_dev, ABS_MT_TOUCH_MAJOR,
> +					finger[id].area);
> +			input_report_abs(input_dev, ABS_MT_POSITION_X,
> +					finger[id].x);
> +			input_report_abs(input_dev, ABS_MT_POSITION_Y,
> +					finger[id].y);
> +		} else
> +			finger[id].status = 0;
>  	}
>  
>  	input_report_key(input_dev, BTN_TOUCH, finger_num > 0);
> @@ -538,6 +540,7 @@ static void mxt_input_touchevent(struct mxt_data *data,
>  	int x;
>  	int y;
>  	int area;
> +	static int trkid;

drop

>  
>  	/* Check the touch is present on the screen */
>  	if (!(status & MXT_DETECT)) {
> @@ -545,6 +548,7 @@ static void mxt_input_touchevent(struct mxt_data *data,
>  			dev_dbg(dev, "[%d] released\n", id);
>  
>  			finger[id].status = MXT_RELEASE;
> +			finger[id].trkid = -1;

drop

>  			mxt_input_report(data, id);
>  		}
>  		return;
> @@ -572,6 +576,8 @@ static void mxt_input_touchevent(struct mxt_data *data,
>  	finger[id].x = x;
>  	finger[id].y = y;
>  	finger[id].area = area;
> +	if (finger[id].trkid < 0)
> +		finger[id].trkid = trkid++ & MXT_MAX_TRACKING_ID;

drop

>  
>  	mxt_input_report(data, id);
>  }
> @@ -790,8 +796,12 @@ static int mxt_initialize(struct mxt_data *data)
>  	struct i2c_client *client = data->client;
>  	struct mxt_info *info = &data->info;
>  	int error;
> +	int i;

drop

>  	u8 val;
>  
> +	for (i = 0; i < MXT_MAX_FINGER; i++)
> +		data->finger[i].trkid = -1;
> +

drop

>  	error = mxt_get_info(data);
>  	if (error)
>  		return error;
> @@ -1091,6 +1101,9 @@ static int __devinit mxt_probe(struct i2c_client *client,
>  			     0, data->y_size, 0, 0);
>  
>  	/* For multi touch */
> +	input_mt_create_slots(input_dev, MXT_MAX_FINGER);
> +	input_set_abs_params(input_dev, ABS_MT_TRACKING_ID,
> +			     0, MXT_MAX_TRACKING_ID, 0, 0);

Replace with

input_mt_init_slots(input_dev, MXT_MAX_FINGER);

>  	input_set_abs_params(input_dev, ABS_MT_TOUCH_MAJOR,
>  			     0, MXT_MAX_AREA, 0, 0);
>  	input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> -- 
> 1.7.0.4

Thanks,
Henrik
