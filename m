From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [PATCH 2/2] Input: elantech - add resolution query support for v4 hardware
Date: Fri, 18 Nov 2011 16:08:53 +0800
Message-ID: <CAGS+omCnQGyw3j=B7JxTwtsu0Vn+_iT1+y8tN72_zxo4Z09=bQ@mail.gmail.com>
References: <1321524994-5513-1-git-send-email-jj_ding@emc.com.tw> <1321524994-5513-3-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:46903 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab1KRIJP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 18 Nov 2011 03:09:15 -0500
Received: by iage36 with SMTP id e36so3286073iag.19
        for <linux-input@vger.kernel.org>; Fri, 18 Nov 2011 00:09:14 -0800 (PST)
In-Reply-To: <1321524994-5513-3-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>, linux-input@vger.kernel.org

Hi JJ,

On Thu, Nov 17, 2011 at 6:16 PM, JJ Ding <jj_ding@emc.com.tw> wrote:
> It turns out that v4's firmware provides a command so we can query
> the resolution. Let's use it.
>
> Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
> ---
>  drivers/input/mouse/elantech.c |   32 ++++++++++++++++++++++++++++++++
>  drivers/input/mouse/elantech.h |    1 +
>  2 files changed, 33 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index dae020c..7c00c1a 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -931,6 +931,30 @@ static int elantech_set_range(struct psmouse *psmouse,
>  }
>
>  /*
> + * (value from firmware) * 10 + 790 = dpi
> + * we also have to convert dpi to dots/mm (*10/254 to avoid floating point)
> + */
> +static inline unsigned int convert_res(unsigned int val)
> +{
> +       return (val * 10 + 790) * 10 / 254;
> +}
> +
> +static int set_resolution_v4(struct psmouse *psmouse,
> +                            unsigned int *x_res,
> +                            unsigned int *y_res)
> +{
> +       unsigned char param[3];
> +
> +       if (elantech_send_cmd(psmouse, ETP_RESOLUTION_QUERY, param))
> +               return -1;
> +
> +       *x_res = convert_res(param[1] & 0x0f);
> +       *y_res = convert_res((param[1] & 0xf0) >> 4);
> +
> +       return 0;
> +}
> +
> +/*
>  * Set the appropriate event bits for the input subsystem
>  */
>  static int elantech_set_input_params(struct psmouse *psmouse)
> @@ -938,6 +962,7 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>        struct input_dev *dev = psmouse->dev;
>        struct elantech_data *etd = psmouse->private;
>        unsigned int x_min = 0, y_min = 0, x_max = 0, y_max = 0, width = 0;
> +       unsigned int x_res = 0, y_res = 0;
>
>        if (elantech_set_range(psmouse, &x_min, &y_min, &x_max, &y_max, &width))
>                return -1;
> @@ -985,10 +1010,15 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>                break;
>
>        case 4:
> +               if (set_resolution_v4(psmouse, &x_res, &y_res))
> +                       return -1;

You might consider allowing this command to fail, but just log a
warning message.
Then only do the input_abs_set_res() if x_res / y_res != 0.

Otherwise, for both patches in this set:

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> +
>                __set_bit(BTN_TOOL_QUADTAP, dev->keybit);
>                /* For X to recognize me as touchpad. */
>                input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);
>                input_set_abs_params(dev, ABS_Y, y_min, y_max, 0, 0);
> +               input_abs_set_res(dev, ABS_X, x_res);
> +               input_abs_set_res(dev, ABS_Y, y_res);
>                /*
>                 * range of pressure and width is the same as v2,
>                 * report ABS_PRESSURE, ABS_TOOL_WIDTH for compatibility.
> @@ -1001,6 +1031,8 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>                input_mt_init_slots(dev, ETP_MAX_FINGERS);
>                input_set_abs_params(dev, ABS_MT_POSITION_X, x_min, x_max, 0, 0);
>                input_set_abs_params(dev, ABS_MT_POSITION_Y, y_min, y_max, 0, 0);
> +               input_abs_set_res(dev, ABS_MT_POSITION_X, x_res);
> +               input_abs_set_res(dev, ABS_MT_POSITION_Y, y_res);
>                input_set_abs_params(dev, ABS_MT_PRESSURE, ETP_PMIN_V2,
>                                     ETP_PMAX_V2, 0, 0);
>                /*
> diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
> index 08d00bd..46db3be 100644
> --- a/drivers/input/mouse/elantech.h
> +++ b/drivers/input/mouse/elantech.h
> @@ -20,6 +20,7 @@
>  #define ETP_FW_VERSION_QUERY           0x01
>  #define ETP_CAPABILITIES_QUERY         0x02
>  #define ETP_SAMPLE_QUERY               0x03
> +#define ETP_RESOLUTION_QUERY           0x04
>
>  /*
>  * Command values for register reading or writing
> --
> 1.7.8-rc2
