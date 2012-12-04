From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH 1/2] input: wacom - Prepare for syncing with input-mt
 changes
Date: Tue, 4 Dec 2012 17:10:21 +0100
Message-ID: <20121204161021.GA1427@polaris.bitmath.org>
References: <1354570740-2313-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-b22.telenor.se ([195.54.99.213]:39545 "EHLO
	smtprelay-b22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab2LDQIi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 4 Dec 2012 11:08:38 -0500
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b22.telenor.se (Postfix) with ESMTP id 59618EB9EB
	for <linux-input@vger.kernel.org>; Tue,  4 Dec 2012 17:08:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1354570740-2313-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Ping Cheng <pingc@wacom.com>, linux-input@vger.kernel.org

Hi Ping,

> Henrik added new MT routines in release 3.7. This patch is to prepare
> for the use of new MT routines.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  drivers/input/tablet/wacom_wac.c |   85 ++++++++++++++++++++------------------
>  1 file changed, 45 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index c0f3e91..097b559 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1444,39 +1444,64 @@ static unsigned int wacom_calculate_touch_res(unsigned int logical_max,
>         return (logical_max * 100) / physical_max;
>  }
>  
> -int wacom_setup_input_capabilities(struct input_dev *input_dev,
> -				   struct wacom_wac *wacom_wac)
> +static void wacom_abs_set_axis(struct input_dev *input_dev,
> +			       struct wacom_wac *wacom_wac)
>  {
>  	struct wacom_features *features = &wacom_wac->features;
> -	int i;
> -
> -	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> -
> -	__set_bit(BTN_TOUCH, input_dev->keybit);
> -
> -	input_set_abs_params(input_dev, ABS_X, 0, features->x_max,
> -			     features->x_fuzz, 0);
> -	input_set_abs_params(input_dev, ABS_Y, 0, features->y_max,
> -			     features->y_fuzz, 0);
>  
>  	if (features->device_type == BTN_TOOL_PEN) {
> -		input_set_abs_params(input_dev, ABS_PRESSURE, 0, features->pressure_max,
> -			     features->pressure_fuzz, 0);
> +		input_set_abs_params(input_dev, ABS_X, 0, features->x_max,
> +				     features->x_fuzz, 0);
> +		input_set_abs_params(input_dev, ABS_Y, 0, features->y_max,
> +				     features->y_fuzz, 0);
> +		input_set_abs_params(input_dev, ABS_PRESSURE, 0,
> +			features->pressure_max, features->pressure_fuzz, 0);
>  
>  		/* penabled devices have fixed resolution for each model */
>  		input_abs_set_res(input_dev, ABS_X, features->x_resolution);
>  		input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
>  	} else {
> -		input_abs_set_res(input_dev, ABS_X,
> -			wacom_calculate_touch_res(features->x_max,
> -						features->x_phy));
> -		input_abs_set_res(input_dev, ABS_Y,
> -			wacom_calculate_touch_res(features->y_max,
> -						features->y_phy));
> +		if (features->touch_max <= 2) {
> +			input_set_abs_params(input_dev, ABS_X, 0,
> +				features->x_max, features->x_fuzz, 0);
> +			input_set_abs_params(input_dev, ABS_Y, 0,
> +				features->y_max, features->y_fuzz, 0);
> +			input_abs_set_res(input_dev, ABS_X,
> +				wacom_calculate_touch_res(features->x_max,
> +							features->x_phy));
> +			input_abs_set_res(input_dev, ABS_Y,
> +				wacom_calculate_touch_res(features->y_max,
> +							features->y_phy));
> +		}
> +
> +		if (features->touch_max > 1) {
> +			input_set_abs_params(input_dev, ABS_MT_POSITION_X, 0,
> +				features->x_max, features->x_fuzz, 0);
> +			input_set_abs_params(input_dev, ABS_MT_POSITION_Y, 0,
> +				features->y_max, features->y_fuzz, 0);
> +			input_abs_set_res(input_dev, ABS_MT_POSITION_X,
> +				wacom_calculate_touch_res(features->x_max,
> +							features->x_phy));
> +			input_abs_set_res(input_dev, ABS_MT_POSITION_Y,
> +				wacom_calculate_touch_res(features->y_max,
> +							features->y_phy));
> +		}

So the (touch_max > 1) logic replaces the branching on features and device type?

>  	}
> +}
>  
> +int wacom_setup_input_capabilities(struct input_dev *input_dev,
> +				   struct wacom_wac *wacom_wac)
> +{
> +	struct wacom_features *features = &wacom_wac->features;
> +	int i;
> +
> +	input_dev->evbit[0] |= BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> +
> +	__set_bit(BTN_TOUCH, input_dev->keybit);
>  	__set_bit(ABS_MISC, input_dev->absbit);
>  
> +	wacom_abs_set_axis(input_dev, wacom_wac);
> +
>  	switch (wacom_wac->features.type) {
>  	case WACOM_MO:
>  		input_set_abs_params(input_dev, ABS_WHEEL, 0, 71, 0, 0);
> @@ -1625,13 +1650,6 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
>  			                     0, features->x_max, 0, 0);
>  			input_set_abs_params(input_dev, ABS_MT_TOUCH_MINOR,
>  			                     0, features->y_max, 0, 0);
> -
> -			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> -					     0, features->x_max,
> -					     features->x_fuzz, 0);
> -			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> -					     0, features->y_max,
> -					     features->y_fuzz, 0);
>  		}
>  		break;
>  
> @@ -1677,12 +1695,6 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
>  	case TABLETPC2FG:
>  		if (features->device_type == BTN_TOOL_FINGER) {
>  			input_mt_init_slots(input_dev, features->touch_max, 0);
> -			input_set_abs_params(input_dev, ABS_MT_TOOL_TYPE,
> -					0, MT_TOOL_MAX, 0, 0);
> -			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> -					0, features->x_max, 0, 0);
> -			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> -					0, features->y_max, 0, 0);
>  		}
>  		/* fall through */
>  
> @@ -1747,13 +1759,6 @@ int wacom_setup_input_capabilities(struct input_dev *input_dev,
>  						     ABS_MT_TOUCH_MINOR,
>  						     0, features->y_max, 0, 0);
>  			}
> -
> -			input_set_abs_params(input_dev, ABS_MT_POSITION_X,
> -					     0, features->x_max,
> -					     features->x_fuzz, 0);
> -			input_set_abs_params(input_dev, ABS_MT_POSITION_Y,
> -					     0, features->y_max,
> -					     features->y_fuzz, 0);
>  		} else if (features->device_type == BTN_TOOL_PEN) {
>  			__set_bit(BTN_TOOL_RUBBER, input_dev->keybit);
>  			__set_bit(BTN_TOOL_PEN, input_dev->keybit);
> -- 
> 1.7.10.4
> 

Thanks,
Henrik
