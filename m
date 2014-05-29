From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: wacom - Don't declare ABS_X/Y for multitouch
Date: Thu, 29 May 2014 00:08:05 -0700
Message-ID: <20140529070805.GB11817@core.coreip.homeip.net>
References: <1401232687-9738-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:34107 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932464AbaE2HII (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 03:08:08 -0400
Received: by mail-pb0-f41.google.com with SMTP id uo5so12510559pbc.14
        for <linux-input@vger.kernel.org>; Thu, 29 May 2014 00:08:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1401232687-9738-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On Tue, May 27, 2014 at 04:18:07PM -0700, Ping Cheng wrote:
> We use ABS_MT_POSITION_X/Y for multitouch (touch_max > 1) events now.
> No need to declare ABS_X/Y for touch_max == 2 any more.

This will make legacy clients, such as GPM on text console, very sad.

Thanks.

> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Reviewed-by: Jason Gerecke <killertofu@gmail.com>
> Tested-by: Jason Gerecke <killertofu@gmail.com>
> ---
>  drivers/input/tablet/wacom_wac.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
> index c98e51c..0eb9960 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1217,8 +1217,8 @@ static void wacom_bpt3_touch_msg(struct wacom_wac *wacom, unsigned char *data)
>  			 * a=(pi*r^2)/C.
>  			 */
>  			int a = data[5];
> -			int x_res  = input_abs_get_res(input, ABS_X);
> -			int y_res  = input_abs_get_res(input, ABS_Y);
> +			int x_res  = input_abs_get_res(input, ABS_MT_POSITION_X);
> +			int y_res  = input_abs_get_res(input, ABS_MT_POSITION_Y);
>  			width  = 2 * int_sqrt(a * WACOM_CONTACT_AREA_SCALE);
>  			height = width * y_res / x_res;
>  		}
> @@ -1587,7 +1587,7 @@ static void wacom_abs_set_axis(struct input_dev *input_dev,
>  		input_abs_set_res(input_dev, ABS_X, features->x_resolution);
>  		input_abs_set_res(input_dev, ABS_Y, features->y_resolution);
>  	} else {
> -		if (features->touch_max <= 2) {
> +		if (features->touch_max == 1) {
>  			input_set_abs_params(input_dev, ABS_X, 0,
>  				features->x_max, features->x_fuzz, 0);
>  			input_set_abs_params(input_dev, ABS_Y, 0,
> -- 
> 1.9.1
> 

-- 
Dmitry
