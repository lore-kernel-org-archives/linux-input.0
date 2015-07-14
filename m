From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: [PATCH] Input - elantech: force a resolution of 31 u/mm
Date: Tue, 14 Jul 2015 19:59:47 +0200
Message-ID: <CANq1E4S0esqdku=SuVqV=78qWMEt66U3Lia7CdPeCUgHX8UXwQ@mail.gmail.com>
References: <20150710003244.GA25437@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:34795 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752781AbbGNR7t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jul 2015 13:59:49 -0400
In-Reply-To: <20150710003244.GA25437@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Duson Lin <dusonlin@emc.com.tw>

Hi

On Fri, Jul 10, 2015 at 2:32 AM, Peter Hutterer
<peter.hutterer@who-t.net> wrote:
> All Elantech touchpads pre-v4 with dynamic resolution queries have a fixed
> resolution of 800dpi -> 31.49 units/mm. Set this statically, so userspace does
> not have to guess.
>
> Cc: Duson Lin <dusonlin@emc.com.tw>
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> ---
>  drivers/input/mouse/elantech.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

I think this is much nicer than having to work around this in
user-space. Much appreciated!

Reviewed-by: David Herrmann <dh.herrmann@gmail.com>

Thanks
David

> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index ce3d400..22b9ca9 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1167,7 +1167,7 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>         struct input_dev *dev = psmouse->dev;
>         struct elantech_data *etd = psmouse->private;
>         unsigned int x_min = 0, y_min = 0, x_max = 0, y_max = 0, width = 0;
> -       unsigned int x_res = 0, y_res = 0;
> +       unsigned int x_res = 31, y_res = 31;
>
>         if (elantech_set_range(psmouse, &x_min, &y_min, &x_max, &y_max, &width))
>                 return -1;
> @@ -1232,8 +1232,6 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>                 /* For X to recognize me as touchpad. */
>                 input_set_abs_params(dev, ABS_X, x_min, x_max, 0, 0);
>                 input_set_abs_params(dev, ABS_Y, y_min, y_max, 0, 0);
> -               input_abs_set_res(dev, ABS_X, x_res);
> -               input_abs_set_res(dev, ABS_Y, y_res);
>                 /*
>                  * range of pressure and width is the same as v2,
>                  * report ABS_PRESSURE, ABS_TOOL_WIDTH for compatibility.
> @@ -1246,8 +1244,6 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>                 input_mt_init_slots(dev, ETP_MAX_FINGERS, 0);
>                 input_set_abs_params(dev, ABS_MT_POSITION_X, x_min, x_max, 0, 0);
>                 input_set_abs_params(dev, ABS_MT_POSITION_Y, y_min, y_max, 0, 0);
> -               input_abs_set_res(dev, ABS_MT_POSITION_X, x_res);
> -               input_abs_set_res(dev, ABS_MT_POSITION_Y, y_res);
>                 input_set_abs_params(dev, ABS_MT_PRESSURE, ETP_PMIN_V2,
>                                      ETP_PMAX_V2, 0, 0);
>                 /*
> @@ -1259,6 +1255,13 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>                 break;
>         }
>
> +       input_abs_set_res(dev, ABS_X, x_res);
> +       input_abs_set_res(dev, ABS_Y, y_res);
> +       if (etd->hw_version > 1) {
> +               input_abs_set_res(dev, ABS_MT_POSITION_X, x_res);
> +               input_abs_set_res(dev, ABS_MT_POSITION_Y, y_res);
> +       }
> +
>         etd->y_max = y_max;
>         etd->width = width;
>
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
