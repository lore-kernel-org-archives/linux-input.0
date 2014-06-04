From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] Input: wacom - cleanup multitouch code when touch_max is 2
Date: Wed, 4 Jun 2014 14:44:47 -0700
Message-ID: <CANRwn3Rdp-tf4j6OTmKys1Cb+eo8MbELpSmw8dZyn7NGEE0EEA@mail.gmail.com>
References: <1401393791-15614-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:35868 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752408AbaFDVot convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Jun 2014 17:44:49 -0400
Received: by mail-la0-f41.google.com with SMTP id e16so64398lan.14
        for <linux-input@vger.kernel.org>; Wed, 04 Jun 2014 14:44:48 -0700 (PDT)
In-Reply-To: <1401393791-15614-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ping Cheng <pingc@wacom.com>

On Thu, May 29, 2014 at 1:03 PM, Ping Cheng <pinglinux@gmail.com> wrote=
:
> Historically we dealt with touch_max equals to 2 differently from
> other MT devices. Now we use input_mt_*() to process all MT events,
> as long as touch_max is greater than 1. So, there is no need to
> take (touch_max =3D=3D 2) as a special case any more.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>  drivers/input/tablet/wacom_wac.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 977d05c..964db47 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1217,8 +1217,8 @@ static void wacom_bpt3_touch_msg(struct wacom_w=
ac *wacom, unsigned char *data)
>                          * a=3D(pi*r^2)/C.
>                          */
>                         int a =3D data[5];
> -                       int x_res  =3D input_abs_get_res(input, ABS_X=
);
> -                       int y_res  =3D input_abs_get_res(input, ABS_Y=
);
> +                       int x_res  =3D input_abs_get_res(input, ABS_M=
T_POSITION_X);
> +                       int y_res  =3D input_abs_get_res(input, ABS_M=
T_POSITION_Y);
>                         width  =3D 2 * int_sqrt(a * WACOM_CONTACT_ARE=
A_SCALE);
>                         height =3D width * y_res / x_res;
>                 }
> @@ -1587,7 +1587,7 @@ static void wacom_abs_set_axis(struct input_dev=
 *input_dev,
>                 input_abs_set_res(input_dev, ABS_X, features->x_resol=
ution);
>                 input_abs_set_res(input_dev, ABS_Y, features->y_resol=
ution);
>         } else {
> -               if (features->touch_max <=3D 2) {
> +               if (features->touch_max =3D=3D 1) {
>                         input_set_abs_params(input_dev, ABS_X, 0,
>                                 features->x_max, features->x_fuzz, 0)=
;
>                         input_set_abs_params(input_dev, ABS_Y, 0,
> @@ -1815,14 +1815,8 @@ int wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
>         case MTTPC:
>         case MTTPC_B:
>         case TABLETPC2FG:
> -               if (features->device_type =3D=3D BTN_TOOL_FINGER) {
> -                       unsigned int flags =3D INPUT_MT_DIRECT;
> -
> -                       if (wacom_wac->features.type =3D=3D TABLETPC2=
=46G)
> -                               flags =3D 0;
> -
> -                       input_mt_init_slots(input_dev, features->touc=
h_max, flags);
> -               }
> +               if ((features->device_type =3D=3D BTN_TOOL_FINGER) &&=
 features->touch_max > 1)
> +                       input_mt_init_slots(input_dev, features->touc=
h_max, INPUT_MT_DIRECT);
>                 /* fall through */
>
>         case TABLETPC:
> @@ -1883,10 +1877,6 @@ int wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
>                         __set_bit(BTN_RIGHT, input_dev->keybit);
>
>                         if (features->touch_max) {
> -                               /* touch interface */
> -                               unsigned int flags =3D INPUT_MT_POINT=
ER;
> -
> -                               __set_bit(INPUT_PROP_POINTER, input_d=
ev->propbit);
>                                 if (features->pktlen =3D=3D WACOM_PKG=
LEN_BBTOUCH3) {
>                                         input_set_abs_params(input_de=
v,
>                                                      ABS_MT_TOUCH_MAJ=
OR,
> @@ -1894,12 +1884,8 @@ int wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
>                                         input_set_abs_params(input_de=
v,
>                                                      ABS_MT_TOUCH_MIN=
OR,
>                                                      0, features->y_m=
ax, 0, 0);
> -                               } else {
> -                                       __set_bit(BTN_TOOL_FINGER, in=
put_dev->keybit);
> -                                       __set_bit(BTN_TOOL_DOUBLETAP,=
 input_dev->keybit);
> -                                       flags =3D 0;
>                                 }
> -                               input_mt_init_slots(input_dev, featur=
es->touch_max, flags);
> +                               input_mt_init_slots(input_dev, featur=
es->touch_max, INPUT_MT_POINTER);

I think you want to use 'input_mt_init_slots(input_dev,
features->touch_max + 1, INPUT_MT_POINTER)' instead. This is one more
slot than necessary, but the number of slots is used in deciding which
of the BTN_TOOL_*TAP buttons the kernel will advertise. Our protocol
has the driver sending one more TAP than expected to differentiate
touch and pad (e.g. single-touch device needs DOUBLETAP and two-finger
touch needs TRIPLETAP). Adding one to the number of slots ensures a
high enough TAP is advertised.

Aside from that... Reviewed-by: Jason Gerecke <killertofu@gmail.com>

Jason
---
Now instead of four in the eights place /
you=E2=80=99ve got three, =E2=80=98Cause you added one  /
(That is to say, eight) to the two,     /
But you can=E2=80=99t take seven from three,    /
So you look at the sixty-fours....

>                         } else {
>                                 /* buttons/keys only interface */
>                                 __clear_bit(ABS_X, input_dev->absbit)=
;
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
