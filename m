From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH 12/24] Port hid-lgff to ff-memless-next
Date: Mon, 21 Apr 2014 00:00:24 +0200
Message-ID: <CADbOyBSNZ3QV7VRZELK3RH-4kVaPga0jrMufAk3P2bXjvqox6Q@mail.gmail.com>
References: <1609685.QRL9N9sQvX@sigyn>
	<1533887.5nzvy1GCXV@sigyn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:44981 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaDTWAZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Apr 2014 18:00:25 -0400
In-Reply-To: <1533887.5nzvy1GCXV@sigyn>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Apr 9, 2014 at 1:24 PM, Michal Mal=C3=BD
<madcatxster@devoid-pointer.net> wrote:
> Port hid-lgff to ff-memless-next
>
> Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
> ---
>  drivers/hid/Kconfig    |  2 +-
>  drivers/hid/hid-lgff.c | 63 ++++++++++++++++++++++++++++++++++------=
----------
>  2 files changed, 44 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index d1d4e77..c7794ae 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -356,7 +356,7 @@ config HID_LOGITECH_DJ
>  config LOGITECH_FF
>         bool "Logitech force feedback support"
>         depends on HID_LOGITECH
> -       select INPUT_FF_MEMLESS
> +       select INPUT_FF_MEMLESS_NEXT
>         help
>           Say Y here if you have one of these devices:
>           - Logitech WingMan Cordless RumblePad
> diff --git a/drivers/hid/hid-lgff.c b/drivers/hid/hid-lgff.c
> index e1394af..b929a3a 100644
> --- a/drivers/hid/hid-lgff.c
> +++ b/drivers/hid/hid-lgff.c
> @@ -31,9 +31,12 @@
>
>  #include <linux/input.h>
>  #include <linux/hid.h>
> +#include <linux/input/ff-memless-next.h>
>
>  #include "hid-lg.h"
>
> +#define FF_UPDATE_RATE 50
> +
>  struct dev_type {
>         u16 idVendor;
>         u16 idProduct;
> @@ -47,6 +50,13 @@ static const signed short ff_rumble[] =3D {
>
>  static const signed short ff_joystick[] =3D {
>         FF_CONSTANT,
> +       FF_RAMP,
> +       FF_PERIODIC,
> +       FF_SQUARE,
> +       FF_TRIANGLE,
> +       FF_SINE,
> +       FF_SAW_UP,
> +       FF_SAW_DOWN,
>         -1
>  };

Also do the same for the ff_joystick_ac[] array, as it also contains
the FF_CONSTANT capability.

>
> @@ -66,45 +76,58 @@ static const struct dev_type devices[] =3D {
>         { 0x046d, 0xc295, ff_joystick },
>  };
>
> -static int hid_lgff_play(struct input_dev *dev, void *data, struct f=
f_effect *effect)
> +static int hid_lgff_play(struct input_dev *dev, void *data,
> +                        const struct mlnx_effect_command *command)
>  {
>         struct hid_device *hid =3D input_get_drvdata(dev);
>         struct list_head *report_list =3D &hid->report_enum[HID_OUTPU=
T_REPORT].report_list;
>         struct hid_report *report =3D list_entry(report_list->next, s=
truct hid_report, list);
> -       int x, y;
> -       unsigned int left, right;
>
> -#define CLAMP(x) if (x < 0) x =3D 0; if (x > 0xff) x =3D 0xff
> +       switch (command->cmd) {
> +       case MLNX_START_COMBINED: {
> +               const struct mlnx_simple_force *simple_force =3D &com=
mand->u.simple_force;
> +               /* Scale down from MLNX range */
> +               const int x =3D 0x80 - (simple_force->x * 0xff / 0xff=
ff);
> +               const int y =3D simple_force->y * 0xff / 0xffff;

This should be concentrated about the center, which is 0x7f (see * in
next comment.)
Something like this:
        const int x =3D 0x7f - (simple_force->x * 0xff / 0xffff);
        const int y =3D 0x7f - (simple_force->y * 0xff / 0xffff);

>
> -       switch (effect->type) {
> -       case FF_CONSTANT:
> -               x =3D effect->u.ramp.start_level + 0x7f;  /* 0x7f is =
center */

* Here.

> -               y =3D effect->u.ramp.end_level + 0x7f;
> -               CLAMP(x);
> -               CLAMP(y);
>                 report->field[0]->value[0] =3D 0x51;
>                 report->field[0]->value[1] =3D 0x08;
>                 report->field[0]->value[2] =3D x;
>                 report->field[0]->value[3] =3D y;
>                 dbg_hid("(x, y)=3D(%04x, %04x)\n", x, y);
> -               hid_hw_request(hid, report, HID_REQ_SET_REPORT);
>                 break;
> +       }
> +       case MLNX_STOP_COMBINED:
> +               report->field[0]->value[0] =3D 0x51;
> +               report->field[0]->value[1] =3D 0x08;
> +               report->field[0]->value[2] =3D 0;
> +               report->field[0]->value[3] =3D 0;

Then this should become the center-position:
        report->field[0]->value[2] =3D 0x7f;
        report->field[0]->value[3] =3D 0x7f;

> +               break;
> +       case MLNX_START_RUMBLE: {
> +               const struct mlnx_rumble_force *rumble_force =3D &com=
mand->u.rumble_force;
> +               /* Scale down from MLNX range */
> +               const unsigned int right =3D rumble_force->weak * 0xf=
f / 0xffff;
> +               const unsigned int left =3D rumble_force->strong * 0x=
ff / 0xffff;
>
> -       case FF_RUMBLE:
> -               right =3D effect->u.rumble.strong_magnitude;
> -               left =3D effect->u.rumble.weak_magnitude;
> -               right =3D right * 0xff / 0xffff;
> -               left =3D left * 0xff / 0xffff;
> -               CLAMP(left);
> -               CLAMP(right);
>                 report->field[0]->value[0] =3D 0x42;
>                 report->field[0]->value[1] =3D 0x00;
>                 report->field[0]->value[2] =3D left;
>                 report->field[0]->value[3] =3D right;
>                 dbg_hid("(left, right)=3D(%04x, %04x)\n", left, right=
);
> -               hid_hw_request(hid, report, HID_REQ_SET_REPORT);
>                 break;
>         }
> +       case MLNX_STOP_RUMBLE:
> +               report->field[0]->value[0] =3D 0x42;
> +               report->field[0]->value[1] =3D 0x00;
> +               report->field[0]->value[2] =3D 0;
> +               report->field[0]->value[3] =3D 0;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       hid_hw_request(hid, report, HID_REQ_SET_REPORT);
> +
>         return 0;
>  }
>
> @@ -148,7 +171,7 @@ int lgff_init(struct hid_device* hid)
>         for (i =3D 0; ff_bits[i] >=3D 0; i++)
>                 set_bit(ff_bits[i], dev->ffbit);
>
> -       error =3D input_ff_create_memless(dev, NULL, hid_lgff_play);
> +       error =3D input_ff_create_mlnx(dev, NULL, hid_lgff_play, FF_U=
PDATE_RATE);
>         if (error)
>                 return error;
>
> --
> 1.9.1
>
>

These comments might fix the weird behaviour (when effects stopped
playing) Simon saw when testing the patchset with his Logitech Wingman
=46orce 3D.


Elias
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
