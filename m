From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: [PATCH v3 23/24] hid: Port hid-lg4ff to ff-memless-next
Date: Sat, 26 Apr 2014 15:50:54 +0200
Message-ID: <CADbOyBSZHLe3SwRD7fkPa-VCRwt4Vk_hzPKTyQ9GbALFoVwCBw@mail.gmail.com>
References: <1398513696-12626-1-git-send-email-madcatxster@devoid-pointer.net>
	<1398513696-12626-24-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f176.google.com ([209.85.220.176]:51121 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbaDZNuz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Apr 2014 09:50:55 -0400
In-Reply-To: <1398513696-12626-24-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Anssi Hannula <anssi.hannula@iki.fi>, Simon Wood <simon@mungewell.org>

On Sat, Apr 26, 2014 at 1:58 PM, Michal Mal=C3=BD
<madcatxster@devoid-pointer.net> wrote:
> Port hid-lg4ff to ff-memless-next
>
> Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
> ---
>  drivers/hid/Kconfig     |  2 +-
>  drivers/hid/hid-lg4ff.c | 93 ++++++++++++++++++++++++++++++---------=
----------
>  2 files changed, 59 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 5e70519..546ac4a 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -399,7 +399,7 @@ config LOGIG940_FF
>  config LOGIWHEELS_FF
>         bool "Logitech wheels configuration and force feedback suppor=
t"
>         depends on HID_LOGITECH
> -       select INPUT_FF_MEMLESS
> +       select INPUT_FF_MEMLESS_NEXT
>         default LOGITECH_FF
>         help
>           Say Y here if you want to enable force feedback and range s=
etting
> diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
> index 24883b4..d629093 100644
> --- a/drivers/hid/hid-lg4ff.c
> +++ b/drivers/hid/hid-lg4ff.c
> @@ -25,6 +25,7 @@
>
>
>  #include <linux/input.h>
> +#include <linux/input/ff-memless-next.h>
>  #include <linux/usb.h>
>  #include <linux/hid.h>
>
> @@ -45,6 +46,8 @@
>  #define G27_REV_MIN 0x38
>  #define G27_2_REV_MIN 0x39
>
> +#define FF_UPDATE_RATE 8
> +
>  #define to_hid_device(pdev) container_of(pdev, struct hid_device, de=
v)
>
>  static void hid_lg4ff_set_range_dfp(struct hid_device *hid, u16 rang=
e);
> @@ -69,6 +72,13 @@ struct lg4ff_device_entry {
>
>  static const signed short lg4ff_wheel_effects[] =3D {
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
> @@ -184,47 +194,60 @@ int lg4ff_adjust_input_event(struct hid_device =
*hid, struct hid_field *field,
>         }
>  }
>
> -static int hid_lg4ff_play(struct input_dev *dev, void *data, struct =
ff_effect *effect)
> +static int hid_lg4ff_start_combined(struct hid_device *hid, struct h=
id_report *report,
> +                                   const struct mlnx_simple_force *f=
orce)
> +{
> +       __s32 *value =3D report->field[0]->value;
> +       int scaled_x;
> +
> +       /* Scale down from MLNX range */
> +       scaled_x =3D 0x80 - (force->x * 0xff / 0xffff);
> +
> +       value[0] =3D 0x11;        /* Slot 1 */
> +       value[1] =3D 0x08;
> +       value[2] =3D scaled_x;
> +       value[3] =3D 0x80;
> +       value[4] =3D 0x00;
> +       value[5] =3D 0x00;
> +       value[6] =3D 0x00;
> +
> +       hid_hw_request(hid, report, HID_REQ_SET_REPORT);
> +       return 0;
> +}
> +
> +static int hid_lg4ff_stop_combined(struct hid_device *hid, struct hi=
d_report *report)
> +{
> +       __s32 *value =3D report->field[0]->value;
> +
> +       value[0] =3D 0x13;        /* Slot 1 */
> +       value[1] =3D 0x00;
> +       value[2] =3D 0x00;
> +       value[3] =3D 0x00;
> +       value[4] =3D 0x00;
> +       value[5] =3D 0x00;
> +       value[6] =3D 0x00;
> +
> +       hid_hw_request(hid, report, HID_REQ_SET_REPORT);
> +       return 0;
> +}
> +
> +static int hid_lg4ff_control(struct input_dev *dev, void *data, cons=
t struct mlnx_effect_command *command)
>  {
>         struct hid_device *hid =3D input_get_drvdata(dev);
>         struct list_head *report_list =3D &hid->report_enum[HID_OUTPU=
T_REPORT].report_list;
>         struct hid_report *report =3D list_entry(report_list->next, s=
truct hid_report, list);
> -       __s32 *value =3D report->field[0]->value;
> -       int x;
> -
> -#define CLAMP(x) do { if (x < 0) x =3D 0; else if (x > 0xff) x =3D 0=
xff; } while (0)
> -
> -       switch (effect->type) {
> -       case FF_CONSTANT:
> -               x =3D effect->u.ramp.start_level + 0x80;  /* 0x80 is =
no force */
> -               CLAMP(x);
> -
> -               if (x =3D=3D 0x80) {
> -                       /* De-activate force in slot-1*/
> -                       value[0] =3D 0x13;
> -                       value[1] =3D 0x00;
> -                       value[2] =3D 0x00;
> -                       value[3] =3D 0x00;
> -                       value[4] =3D 0x00;
> -                       value[5] =3D 0x00;
> -                       value[6] =3D 0x00;
> -
> -                       hid_hw_request(hid, report, HID_REQ_SET_REPOR=
T);
> -                       return 0;
> -               }
> -
> -               value[0] =3D 0x11;        /* Slot 1 */
> -               value[1] =3D 0x08;
> -               value[2] =3D x;
> -               value[3] =3D 0x80;
> -               value[4] =3D 0x00;
> -               value[5] =3D 0x00;
> -               value[6] =3D 0x00;
>
> -               hid_hw_request(hid, report, HID_REQ_SET_REPORT);
> +       switch (command->cmd) {
> +       case MLNX_START_COMBINED:
> +               return hid_lg4ff_start_combined(hid, report, &command=
->u.simple_force);
> +               break;
> +       case MLNX_STOP_COMBINED:
> +               return hid_lg4ff_stop_combined(hid, report);
>                 break;
> +       default:
> +               dbg_hid("Unsupported effect command");
> +               return -EINVAL;
>         }
> -       return 0;
>  }
>
>  /* Sends default autocentering command compatible with
> @@ -610,7 +633,7 @@ int lg4ff_init(struct hid_device *hid)
>         for (j =3D 0; lg4ff_devices[i].ff_effects[j] >=3D 0; j++)
>                 set_bit(lg4ff_devices[i].ff_effects[j], dev->ffbit);
>
> -       error =3D input_ff_create_memless(dev, NULL, hid_lg4ff_play);
> +       error =3D input_ff_create_mlnx(dev, (void *)NULL, hid_lg4ff_c=
ontrol, FF_UPDATE_RATE);
>
>         if (error)
>                 return error;
> --
> 1.9.2
>

You can add Tested-by: Elias Vanderstuyft <elias.vds@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
