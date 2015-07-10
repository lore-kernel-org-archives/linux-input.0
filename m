From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input - elantech: force a resolution of 31 u/mm
Date: Fri, 10 Jul 2015 08:57:55 +0200
Message-ID: <559F6CF3.4050709@redhat.com>
References: <20150710003244.GA25437@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42923 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbbGJG6B (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 10 Jul 2015 02:58:01 -0400
In-Reply-To: <20150710003244.GA25437@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Duson Lin <dusonlin@emc.com.tw>

Hi,

On 10-07-15 02:32, Peter Hutterer wrote:
> All Elantech touchpads pre-v4 with dynamic resolution queries have a fixed
> resolution of 800dpi -> 31.49 units/mm. Set this statically, so userspace does
> not have to guess.
>
> Cc: Duson Lin <dusonlin@emc.com.tw>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>

Ah I was planning on writing the same patch today, looks like you've
beat me to it :)

Patch looks good:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/input/mouse/elantech.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index ce3d400..22b9ca9 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1167,7 +1167,7 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>   	struct input_dev *dev = psmouse->dev;
>   	struct elantech_data *etd = psmouse->private;
>   	unsigned int x_min = 0, y_min = 0, x_max = 0, y_max = 0, width = 0;
> -	unsigned int x_res = 0, y_res = 0;
> +	unsigned int x_res = 31, y_res = 31;
>
>   	if (elantech_set_range(psmouse, &x_min, &y_min, &x_max, &y_max, &width))
>   		return -1;
> @@ -1232,8 +1232,6 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>   		/* For X to recognize me as touchpad. */
>   		input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);
>   		input_set_abs_params(dev, ABS_Y, y_min, y_max, 0, 0);
> -		input_abs_set_res(dev, ABS_X, x_res);
> -		input_abs_set_res(dev, ABS_Y, y_res);
>   		/*
>   		 * range of pressure and width is the same as v2,
>   		 * report ABS_PRESSURE, ABS_TOOL_WIDTH for compatibility.
> @@ -1246,8 +1244,6 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>   		input_mt_init_slots(dev, ETP_MAX_FINGERS, 0);
>   		input_set_abs_params(dev, ABS_MT_POSITION_X, x_min, x_max, 0, 0);
>   		input_set_abs_params(dev, ABS_MT_POSITION_Y, y_min, y_max, 0, 0);
> -		input_abs_set_res(dev, ABS_MT_POSITION_X, x_res);
> -		input_abs_set_res(dev, ABS_MT_POSITION_Y, y_res);
>   		input_set_abs_params(dev, ABS_MT_PRESSURE, ETP_PMIN_V2,
>   				     ETP_PMAX_V2, 0, 0);
>   		/*
> @@ -1259,6 +1255,13 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>   		break;
>   	}
>
> +	input_abs_set_res(dev, ABS_X, x_res);
> +	input_abs_set_res(dev, ABS_Y, y_res);
> +	if (etd->hw_version > 1) {
> +		input_abs_set_res(dev, ABS_MT_POSITION_X, x_res);
> +		input_abs_set_res(dev, ABS_MT_POSITION_Y, y_res);
> +	}
> +
>   	etd->y_max = y_max;
>   	etd->width = width;
>
>
