From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3] input: wacom - Pass touch resolution to clients
 through input_absinfo
Date: Tue, 25 Jan 2011 11:00:56 -0800
Message-ID: <20110125190056.GH19701@core.coreip.homeip.net>
References: <1295980279-5610-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42565 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752478Ab1AYTBD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 14:01:03 -0500
Received: by qyj19 with SMTP id 19so4813980qyj.19
        for <linux-input@vger.kernel.org>; Tue, 25 Jan 2011 11:01:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1295980279-5610-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Tue, Jan 25, 2011 at 10:31:19AM -0800, Ping Cheng wrote:
> Fixed the workaround used for kernels older than 2.6.35.
> 
> This version added a funtion, wacom_touch_resolution, to calculate touch resolutions.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Reviewed-by: Henrik Rydberg <rydberg@euromail.se>
> ---
>  drivers/input/tablet/wacom_wac.c |   21 +++++++++++++++++++--
>  1 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index f44c822..57bac83 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1101,6 +1101,15 @@ void wacom_setup_device_quirks(struct wacom_features *features)
>  	}
>  }
>  
> +static int wacom_touch_resolution(struct wacom_features *features, int axe)
> +{
> +	/* touch physical size is in hundredths of a mm */
> +	if (!axe)
> +		return (100 * features->x_max / features->x_phy);
> +	else
> +		return (100 * features->y_max / features->y_phy);
> +}

Meh...

static unsigned int wacom_calculate_resolution(unsigned int logical_max,
					       unsigned int physical_max)
{
	/* Physical dimensions are in 100th of mm */
	return (logical_max * 100) / physical_max;
}


> +
>  void wacom_setup_input_capabilities(struct input_dev *input_dev,
>  				    struct wacom_wac *wacom_wac)
>  {
> @@ -1228,8 +1237,11 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
>  	case TABLETPC:
>  		if (features->device_type == BTN_TOOL_DOUBLETAP ||
>  		    features->device_type == BTN_TOOL_TRIPLETAP) {
> -			input_set_abs_params(input_dev, ABS_RX, 0, features->x_phy, 0, 0);
> -			input_set_abs_params(input_dev, ABS_RY, 0, features->y_phy, 0, 0);
> +			/* set touch resolution in points/mm */
> +			input_abs_set_res(input_dev, ABS_X,
> +					wacom_touch_resolution(features, 0));
> +			input_abs_set_res(input_dev, ABS_Y,
> +					wacom_touch_resolution(features, 1));
>  			__set_bit(BTN_TOOL_DOUBLETAP, input_dev->keybit);
>  		}
>  
> @@ -1272,6 +1284,11 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
>  			input_set_abs_params(input_dev, ABS_MT_PRESSURE,
>  					     0, features->pressure_max,
>  					     features->pressure_fuzz, 0);
> +			/* set touch resolution in points/mm */
> +			input_abs_set_res(input_dev, ABS_X,
> +					wacom_touch_resolution(features, 0));
> +			input_abs_set_res(input_dev, ABS_Y,
> +					wacom_touch_resolution(features, 0));

Should be wacom_touch_resolution(features, 1). Or rather:

			input_abs_set_res(input_dev, ABS_Y,
				wacom_calculate_resolution(features->y_max,
							   features->y_phy));
-- 
Dmitry
