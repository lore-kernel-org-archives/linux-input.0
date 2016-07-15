From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: wacom_w8001 - cleanup 2FG touch code
Date: Fri, 15 Jul 2016 14:10:28 -0700
Message-ID: <20160715211028.GC27847@dtor-ws>
References: <1468616445-6158-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36655 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbcGOVKc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jul 2016 17:10:32 -0400
Received: by mail-pf0-f196.google.com with SMTP id y134so2717993pfg.3
        for <linux-input@vger.kernel.org>; Fri, 15 Jul 2016 14:10:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1468616445-6158-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>, Peter Hutterer <peter.hutterer@who-t.net>

Hi Ping,

On Fri, Jul 15, 2016 at 02:00:45PM -0700, Ping Cheng wrote:
> input_mt_sync_frame is used by other wacom devices in wacom_wac.c
> to close the frame and emulate pointer events. Let's follow them.
> 
> Touch resolution was missing during touch setup. Newer apps won't
> be happy without that info.
> 
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
>  drivers/input/touchscreen/wacom_w8001.c | 19 +++++--------------
>  1 file changed, 5 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
> index fe983e7..a09dc65 100644
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
> @@ -508,14 +500,13 @@ static int w8001_setup_touch(struct w8001 *w8001, char *basename,
>  	case 5:
>  		w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
>  
> -		__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
> -		input_mt_init_slots(dev, 2, 0);
>  		input_set_abs_params(dev, ABS_MT_POSITION_X,
>  					0, touch.x, 0, 0);
>  		input_set_abs_params(dev, ABS_MT_POSITION_Y,
>  					0, touch.y, 0, 0);
> -		input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
> -					0, MT_TOOL_MAX, 0, 0);

There seem a few issues combined into 1 patch. Why are we dropping tool
type? And the chunk below deserves a separate commit (which we might
consider for stable).

Thanks.

> +		input_abs_set_res(dev, ABS_MT_POSITION_X, touch.panel_res);
> +		input_abs_set_res(dev, ABS_MT_POSITION_Y, touch.panel_res);
> +		input_mt_init_slots(dev, 2, 0);
>  
>  		strlcat(basename, " 2FG", basename_sz);
>  		if (w8001->max_pen_x && w8001->max_pen_y)
> -- 
> 1.8.3.1
> 

-- 
Dmitry
