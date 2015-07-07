From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 2/3] Input: of_touchscreen - fix setting max values on
 X/Y axis
Date: Tue, 7 Jul 2015 12:37:31 +0300
Message-ID: <559B9DDB.6080606@ti.com>
References: <1436228849-29530-1-git-send-email-dmitry.torokhov@gmail.com> <1436228849-29530-2-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51462 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413AbbGGJhn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 7 Jul 2015 05:37:43 -0400
In-Reply-To: <1436228849-29530-2-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org

Hi Dmitry,

On 07/07/15 03:27, Dmitry Torokhov wrote:
> The binding specification says that "touchscreen-size-x" and "-y" specify
> horizontal and vertical resolution of the touchscreen and therefore maximum
> absolute coordinates should be reduced by 1 since we are starting with 0.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>   drivers/input/touchscreen/of_touchscreen.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
> index 759cf4b..50bc0f2 100644
> --- a/drivers/input/touchscreen/of_touchscreen.c
> +++ b/drivers/input/touchscreen/of_touchscreen.c
> @@ -71,23 +71,25 @@ void touchscreen_parse_of_params(struct input_dev *dev, bool multitouch)
>
>   	axis = multitouch ? ABS_MT_POSITION_X : ABS_X;
>   	data_present = touchscreen_get_prop_u32(np, "touchscreen-size-x",
> -						input_abs_get_max(dev, axis),
> +						input_abs_get_max(dev,
> +								  axis) + 1,

Why do we need to pass default_value to touchscreen_get_prop_u32()?
If the property doesn't exist we are not updating the parameter anyway 
right?

>   						&maximum) |
>   		       touchscreen_get_prop_u32(np, "touchscreen-fuzz-x",
>   						input_abs_get_fuzz(dev, axis),
>   						&fuzz);
>   	if (data_present)
> -		touchscreen_set_params(dev, axis, maximum, fuzz);
> +		touchscreen_set_params(dev, axis, maximum - 1, fuzz);
>
>   	axis = multitouch ? ABS_MT_POSITION_Y : ABS_Y;
>   	data_present = touchscreen_get_prop_u32(np, "touchscreen-size-y",
> -						input_abs_get_max(dev, axis),
> +						input_abs_get_max(dev,
> +								  axis) + 1,
>   						&maximum) |
>   		       touchscreen_get_prop_u32(np, "touchscreen-fuzz-y",
>   						input_abs_get_fuzz(dev, axis),
>   						&fuzz);
>   	if (data_present)
> -		touchscreen_set_params(dev, axis, maximum, fuzz);
> +		touchscreen_set_params(dev, axis, maximum - 1, fuzz);
>
>   	axis = multitouch ? ABS_MT_PRESSURE : ABS_PRESSURE;
>   	data_present = touchscreen_get_prop_u32(np, "touchscreen-max-pressure",
>

cheers,
-roger
