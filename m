From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2 v2] input: wacom_w8001 - resolution wasn't set for
 ABS_MT_POSITION_X/Y
Date: Tue, 19 Jul 2016 11:41:19 -0700
Message-ID: <20160719184119.GB19250@dtor-ws>
References: <1468625157-17766-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33347 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbcGSSlW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jul 2016 14:41:22 -0400
Received: by mail-pf0-f193.google.com with SMTP id i6so1846853pfe.0
        for <linux-input@vger.kernel.org>; Tue, 19 Jul 2016 11:41:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1468625157-17766-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>

On Fri, Jul 15, 2016 at 04:25:57PM -0700, Ping Cheng wrote:
> Also, process error handling for input_mt_init_slots before moving
> forward.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
> v2: splited from PATCH] input: wacom_w8001 - cleanup 2FG touch code,
> as suggested by Dmitry.

Split in 2 and applied.

> ---
>  drivers/input/touchscreen/wacom_w8001.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> index fe983e7..7e807af 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -509,13 +509,20 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
>  		w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
>  
>  		__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
> -		input_mt_init_slots(dev, 2, 0);
> +		error = input_mt_init_slots(dev, 2, 0);
> +		if (error) {
> +			pr_debug("w8001: failed to initialize MT slots: %d\n", error);

Changed to dev_err().

> +			return error;
> +		}
> +
>  		input_set_abs_params(dev, ABS_MT_POSITION_X,
>  					0, touch.x, 0, 0);
>  		input_set_abs_params(dev, ABS_MT_POSITION_Y,
>  					0, touch.y, 0, 0);
>  		input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
>  					0, MT_TOOL_MAX, 0, 0);
> +		input_abs_set_res(dev, ABS_MT_POSITION_X, touch.panel_res);
> +		input_abs_set_res(dev, ABS_MT_POSITION_Y, touch.panel_res);
>  
>  		strlcat(basename, " 2FG", basename_sz);
>  		if (w8001->max_pen_x && w8001->max_pen_y)
> -- 
> 1.8.3.1
> 

-- 
Dmitry
