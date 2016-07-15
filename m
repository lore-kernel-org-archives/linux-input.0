From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2 v2] input: wacom_w8001 - cleanup 2FG touch code
Date: Fri, 15 Jul 2016 16:51:38 -0700
Message-ID: <20160715235138.GH27847@dtor-ws>
References: <1468625185-17820-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36747 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593AbcGOXvm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jul 2016 19:51:42 -0400
Received: by mail-pf0-f196.google.com with SMTP id y134so2899961pfg.3
        for <linux-input@vger.kernel.org>; Fri, 15 Jul 2016 16:51:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1468625185-17820-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>

On Fri, Jul 15, 2016 at 04:26:25PM -0700, Ping Cheng wrote:
> input_mt_sync_frame is used by other wacom devices in wacom_wac.c
> to close the frame and emulate pointer events. Let's follow them.
> 
> Touch events aren't multiplexed over the same device anymore, the
> use of ABS_MT_TOOL_TYPE is superfluous.

All of our touchscreen report the finger tool events, even if it is the
only "tool" that is being used. Does it cause problems?

> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
> v2: moved input_abs_set_res into a separate patch, as suggested by
> Dmitry.
> ---
>  drivers/input/touchscreen/wacom_w8001.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> index 7e807af..541a8df 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -170,16 +170,8 @@ static void parse_multi_touch(struct w8001 *w8001)
>  		}
>  	}
>  
> -	/* emulate single touch events when stylus is out of proximity.
> -	 * This is to make single touch backward support consistent
> -	 * across all Wacom single touch devices.
> -	 */
> -	if (w8001->type != BTN_TOOL_PEN &&
> -			    w8001->type != BTN_TOOL_RUBBER) {
> -		w8001->type = count == 1 ? BTN_TOOL_FINGER : KEY_RESERVED;
> -		input_mt_report_pointer_emulation(dev, true);
> -	}
> -
> +	w8001->type = KEY_RESERVED;
> +	input_mt_sync_frame(dev);
>  	input_sync(dev);
>  }
>  
> @@ -508,7 +500,6 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
>  	case 5:
>  		w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
>  
> -		__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);

Who is setting this bit then?

>  		error = input_mt_init_slots(dev, 2, 0);
>  		if (error) {
>  			pr_debug("w8001: failed to initialize MT slots: %d\n", error);
> @@ -519,8 +510,6 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
>  					0, touch.x, 0, 0);
>  		input_set_abs_params(dev, ABS_MT_POSITION_Y,
>  					0, touch.y, 0, 0);
> -		input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
> -					0, MT_TOOL_MAX, 0, 0);
>  		input_abs_set_res(dev, ABS_MT_POSITION_X, touch.panel_res);
>  		input_abs_set_res(dev, ABS_MT_POSITION_Y, touch.panel_res);
>  
> -- 
> 1.8.3.1
> 

Thanks.

-- 
Dmitry
