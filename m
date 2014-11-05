From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: touchscreen: of: Register multitouch axes
Date: Wed, 5 Nov 2014 09:56:35 -0800
Message-ID: <20141105175635.GA22754@dtor-ws>
References: <1415200070-19346-1-git-send-email-maxime.ripard@free-electrons.com>
 <1415200070-19346-3-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:52738 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602AbaKER4k (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Nov 2014 12:56:40 -0500
Content-Disposition: inline
In-Reply-To: <1415200070-19346-3-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Nov 05, 2014 at 04:07:49PM +0100, Maxime Ripard wrote:
> So far, the DT parsing code was only setting up the regular input axes,
> completely ignoring their multitouch counter parts.
> 
> Fill them with the same parameters than the regular axes.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/input/touchscreen/of_touchscreen.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
> index 74d6b0eb50ac..cf2a753edd96 100644
> --- a/drivers/input/touchscreen/of_touchscreen.c
> +++ b/drivers/input/touchscreen/of_touchscreen.c
> @@ -42,17 +42,23 @@ void touchscreen_parse_of_params(struct input_dev *dev)
>  
>  	maximum = of_get_optional_u32(np, "touchscreen-size-x");
>  	fuzz = of_get_optional_u32(np, "touchscreen-fuzz-x");
> -	if (maximum || fuzz)
> +	if (maximum || fuzz) {
>  		input_set_abs_params(dev, ABS_X, 0, maximum, fuzz, 0);
> +		input_set_abs_params(dev, ABS_MT_POSITION_X, 0, maximum, fuzz, 0);

Not all devices are multitouch so you shoudl not be setting multitouch
bits unconditionally.

In I think we should rely on driver to set capability bits properly and
then here test them and apply the readings. Probably also issue a
warning if we see max/fuzz setting but neither ABS_<N>/ABS_MT_<N>
capabilities.

Thanks.

> +	}
>  
>  	maximum = of_get_optional_u32(np, "touchscreen-size-y");
>  	fuzz = of_get_optional_u32(np, "touchscreen-fuzz-y");
> -	if (maximum || fuzz)
> +	if (maximum || fuzz) {
>  		input_set_abs_params(dev, ABS_Y, 0, maximum, fuzz, 0);
> +		input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, maximum, fuzz, 0);
> +	}
>  
>  	maximum = of_get_optional_u32(np, "touchscreen-max-pressure");
>  	fuzz = of_get_optional_u32(np, "touchscreen-fuzz-pressure");
> -	if (maximum || fuzz)
> +	if (maximum || fuzz) {
>  		input_set_abs_params(dev, ABS_PRESSURE, 0, maximum, fuzz, 0);
> +		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, maximum, fuzz, 0);
> +	}
>  }
>  EXPORT_SYMBOL(touchscreen_parse_of_params);
> -- 
> 2.1.1
> 

-- 
Dmitry
