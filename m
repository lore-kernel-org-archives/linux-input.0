From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Change BTN_TOOL_FINGER falg when HOVER event
 trigger
Date: Tue, 29 Mar 2016 19:31:06 -0700
Message-ID: <20160330023106.GA40436@dtor-ws>
References: <002801d18a28$2a12dfe0$7e389fa0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <002801d18a28$2a12dfe0$7e389fa0$@emc.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
To: DusonLin <dusonlin@emc.com.tw>
Cc: Linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 'Charles Mooney' <charliemooney@google.com>, 'jeff' <jeff.chuang@emc.com.tw>, 'Phoenix' <phoenix@emc.com.tw>
List-Id: linux-input@vger.kernel.org

Hi Duson,

On Wed, Mar 30, 2016 at 10:02:02AM +0800, DusonLin wrote:
> Only ABS_DISTANCE is not enough for upper OS  to distiguish hover eve=
nt
> be triggered from object form faraway to and close touchpad surface o=
r from
> object prepare to leave the touchpad surface. We add BNT_TOOL_FINGER =
to help
> it.
>=20
>                  Object_at_faraway   object_at_hover_area  object_tou=
ch_touchpad
>       BTN_TOUCH         0                      0                    1
> BTN_TOOL_FINGER         0                      1                    1
>    ABS_DISTANCE         0                      1                    0
>=20
> Signed-off by: Duson Lin <dusonlin@emc.com.tw>
> ---
> drivers/input/mouse/elan_i2c_core.c |   14 +++++++++-----
> 1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mous=
e/elan_i2c_core.c
> index 2f58985..9392a8c 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -4,7 +4,7 @@
>   * Copyright (c) 2013 ELAN Microelectronics Corp.
>   *
>   * Author: =E6=9E=97=E6=94=BF=E7=B6=AD (Duson Lin) <dusonlin@emc.com=
=2Etw>
> - * Version: 1.6.0
> + * Version: 1.6.1
>   *
>   * Based on cyapa driver:
>   * copyright (c) 2011-2012 Cypress Semiconductor, Inc.
> @@ -845,23 +845,27 @@ static void elan_report_absolute(struct elan_tp=
_data *data, u8 *packet)
> {
>       struct input_dev *input =3D data->input;
>       u8 *finger_data =3D &packet[ETP_FINGER_DATA_OFFSET];
> -       int i;
> +      int i, valid_count =3D 0;

This appears all whitespace-damaged.

>       u8 tp_info =3D packet[ETP_TOUCH_INFO_OFFSET];
>       u8 hover_info =3D packet[ETP_HOVER_INFO_OFFSET];
>       bool contact_valid, hover_event;
>=20
> -       hover_event =3D hover_info & 0x40;
> +      hover_event =3D (hover_info & 0x40);

We do not need parentheses here.

>       for (i =3D 0; i < ETP_MAX_FINGERS; i++) {
>               contact_valid =3D tp_info & (1U << (3 + i));
>               elan_report_contact(data, i, contact_valid, finger_data=
);
>=20
> -               if (contact_valid)
> +              if (contact_valid) {
>                       finger_data +=3D ETP_FINGER_DATA_LEN;
> +                      valid_count++;
> +              }
>       }
>=20
>        input_report_key(input, BTN_LEFT, tp_info & 0x01);
> +      input_report_key(input, BTN_TOOL_FINGER,
> +                      ((hover_event !=3D 0) | (valid_count > 0)));

You do not want to use "bitwise or" here.

>       input_report_abs(input, ABS_DISTANCE, hover_event !=3D 0);
> -       input_mt_report_pointer_emulation(input, true);
> +      input_mt_report_pointer_emulation(input, false);

I wonder if we should teach input_mt_report_pointer_emulation() to
handle hover properly.

Thanks.

--=20
Dmitry
