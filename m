From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH 13/24] Port hid-lg3ff to ff-memless-next
Date: Mon, 21 Apr 2014 00:13:20 +0200
Message-ID: <CADbOyBR5FV+hfhfH1pf9d+HLOQ9WOvYvjvDz0PM23u8sjLpJwA@mail.gmail.com>
References: <1609685.QRL9N9sQvX@sigyn>
	<1950497.jofl5Si0qz@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:60779 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbaDTWNV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Apr 2014 18:13:21 -0400
In-Reply-To: <1950497.jofl5Si0qz@sigyn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 9, 2014 at 1:24 PM, Michal Mal=C3=BD
<madcatxster@devoid-pointer.net> wrote:
> Port hid-lg3ff to ff-memless-next
>
> Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
> ---
>  drivers/hid/Kconfig     |  2 +-
>  drivers/hid/hid-lg3ff.c | 56 +++++++++++++++++++++++++++++++--------=
----------
>  2 files changed, 37 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index c7794ae..6f2941a 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -382,7 +382,7 @@ config LOGIRUMBLEPAD2_FF
>  config LOGIG940_FF
>         bool "Logitech Flight System G940 force feedback support"
>         depends on HID_LOGITECH
> -       select INPUT_FF_MEMLESS
> +       select INPUT_FF_MEMLESS_NEXT
>         help
>           Say Y here if you want to enable force feedback support for=
 Logitech
>           Flight System G940 devices.
> diff --git a/drivers/hid/hid-lg3ff.c b/drivers/hid/hid-lg3ff.c
> index 8c2da18..a85f8e5 100644
> --- a/drivers/hid/hid-lg3ff.c
> +++ b/drivers/hid/hid-lg3ff.c
> @@ -23,9 +23,12 @@
>
>  #include <linux/input.h>
>  #include <linux/hid.h>
> +#include <linux/input/ff-memless-next.h>
>
>  #include "hid-lg.h"
>
> +#define FF_UPDATE_RATE 50
> +
>  /*
>   * G940 Theory of Operation (from experimentation)
>   *
> @@ -58,12 +61,11 @@ struct lg3ff_device {
>  };
>
>  static int hid_lg3ff_play(struct input_dev *dev, void *data,
> -                        struct ff_effect *effect)
> +                        const struct mlnx_effect_command *command)
>  {
>         struct hid_device *hid =3D input_get_drvdata(dev);
>         struct list_head *report_list =3D &hid->report_enum[HID_OUTPU=
T_REPORT].report_list;
>         struct hid_report *report =3D list_entry(report_list->next, s=
truct hid_report, list);
> -       int x, y;
>
>  /*
>   * Available values in the field should always be 63, but we only us=
e up to
> @@ -72,30 +74,37 @@ static int hid_lg3ff_play(struct input_dev *dev, =
void *data,
>         memset(report->field[0]->value, 0,
>                sizeof(__s32) * report->field[0]->report_count);
>
> -       switch (effect->type) {
> -       case FF_CONSTANT:
> -/*
> - * Already clamped in ff_memless
> - * 0 is center (different then other logitech)
> - */
> -               x =3D effect->u.ramp.start_level;
> -               y =3D effect->u.ramp.end_level;
> -
> -               /* send command byte */
> -               report->field[0]->value[0] =3D 0x51;
> +       /* send command byte */
> +       report->field[0]->value[0] =3D 0x51;
>
> -/*
> - * Sign backwards from other Force3d pro
> - * which get recast here in two's complement 8 bits
> - */
> +       switch (command->cmd) {
> +       case MLNX_START_COMBINED: {
> +               const struct mlnx_simple_force *simple_force =3D &com=
mand->u.simple_force;
> +               /* Scale down from MLNX range */
> +               const int x =3D 0x80 - (simple_force->x * 0xff / 0xff=
ff);
> +               const int y =3D simple_force->y * 0xff / 0xffff;

Similarly as in the lgff port, change previous two lines by:
        const int x =3D -(simple_force->x * 0xff / 0xffff);
        const int y =3D -(simple_force->y * 0xff / 0xffff);

> +
> +               /*
> +                * Sign backwards from other Force3d pro
> +                * which get recast here in two's complement 8 bits
> +               */
>                 report->field[0]->value[1] =3D (unsigned char)(-x);
>                 report->field[0]->value[31] =3D (unsigned char)(-y);
> -
> -               hid_hw_request(hid, report, HID_REQ_SET_REPORT);
>                 break;
> +               }
> +       case MLNX_STOP_COMBINED:
> +               report->field[0]->value[1] =3D 0;
> +               report->field[0]->value[31] =3D 0;
> +               break;
> +       default:
> +               return -EINVAL;
>         }
> +
> +       hid_hw_request(hid, report, HID_REQ_SET_REPORT);
> +
>         return 0;
>  }
> +
>  static void hid_lg3ff_set_autocenter(struct input_dev *dev, u16 magn=
itude)
>  {
>         struct hid_device *hid =3D input_get_drvdata(dev);
> @@ -123,6 +132,13 @@ static void hid_lg3ff_set_autocenter(struct inpu=
t_dev *dev, u16 magnitude)
>
>  static const signed short ff3_joystick_ac[] =3D {
>         FF_CONSTANT,
> +       FF_RAMP,
> +       FF_PERIODIC,
> +       FF_SQUARE,
> +       FF_TRIANGLE,
> +       FF_SINE,
> +       FF_SAW_UP,
> +       FF_SAW_DOWN,
>         FF_AUTOCENTER,
>         -1
>  };
> @@ -143,7 +159,7 @@ int lg3ff_init(struct hid_device *hid)
>         for (i =3D 0; ff_bits[i] >=3D 0; i++)
>                 set_bit(ff_bits[i], dev->ffbit);
>
> -       error =3D input_ff_create_memless(dev, NULL, hid_lg3ff_play);
> +       error =3D input_ff_create_mlnx(dev, NULL, hid_lg3ff_play, FF_=
UPDATE_RATE);
>         if (error)
>                 return error;
>
> --
> 1.9.1
>
>


Elias
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
