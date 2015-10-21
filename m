From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: Regression since commit 92bac83
Date: Wed, 21 Oct 2015 10:19:36 +0200
Message-ID: <20151021081936.GB15219@pali>
References: <5624327B.7080906@lwfinger.net>
 <5624A503.7090609@redhat.com>
 <56251268.2060203@lwfinger.net>
 <562627D9.6020109@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33390 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753810AbbJUITk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2015 04:19:40 -0400
Content-Disposition: inline
In-Reply-To: <562627D9.6020109@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Masaki Ota <masaki.ota@jp.alps.com>, linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tuesday 20 October 2015 13:39:05 Hans de Goede wrote:
> From 5d21a8004260c3e6287bde81c2a9e8f80144e77c Mon Sep 17 00:00:00 200=
1
> From: Hans de Goede <hdegoede@redhat.com>
> Date: Tue, 20 Oct 2015 11:12:07 +0200
> Subject: [PATCH] alps: Only the Dell Latitude D420/430/620/630 have s=
eparate
>  stick button bits
>=20
> commit 92bac83dd79e ("Input: alps - non interleaved V2 dualpoint has
> separate stick button bits") assumes that all alps v2 non-interleaved
> dual point setups have the separate stick button bits.
>=20
> Later we limited this to Dell laptops only because of reports that th=
is
> broke things on non Dell laptops. Now it turns out that this breaks t=
hings
> on the Dell Latitude D600 too. So it seems that only the Dell Latitud=
e
> D420/430/620/630, which all share the same touchpad / stick combo,
> have these separate bits.
>=20
> This patch limits the checking of the separate bits to only these mod=
els
> fixing regressions with other models.
>=20
> Reported-and-tested-by: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: stable@vger.kernel.org
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/input/mouse/alps.c | 48 ++++++++++++++++++++++++++++++++++++=
++++------
>  1 file changed, 42 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 4d24686..41e6cb5 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -100,7 +100,7 @@ static const struct alps_nibble_commands alps_v6_=
nibble_commands[] =3D {
>  #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
>  #define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved =
with
>  					   6-byte ALPS packet */
> -#define ALPS_DELL		0x100	/* device is a Dell laptop */
> +#define ALPS_STICK_BITS		0x100	/* separate stick button bits */
>  #define ALPS_BUTTONPAD		0x200	/* device is a clickpad */
> =20
>  static const struct alps_model_info alps_model_data[] =3D {
> @@ -159,6 +159,43 @@ static const struct alps_protocol_info alps_v8_p=
rotocol_data =3D {
>  	ALPS_PROTO_V8, 0x18, 0x18, 0
>  };
> =20
> +/*
> + * Some v2 models report the stick buttons in separate bits
> + */
> +static const struct dmi_system_id alps_dmi_has_separate_stick_button=
s[] =3D {
> +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> +	{
> +		/* Extrapolated from other entries */
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D420"),
> +		},
> +	},
> +	{
> +		/* Reported-by: Hans de Bruin <jmdebruin@xmsnet.nl> */
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D430"),
> +		},
> +	},
> +	{
> +		/* Reported-by: Hans de Goede <hdegoede@redhat.com> */
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D620"),
> +		},
> +	},
> +	{
> +		/* Extrapolated from other entries */
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude D630"),
> +		},
> +	},
> +#endif
> +	{ }
> +};
> +

Hi! Are you sure that above machines do not have variants without
ALPS_DUALPOINT or without ALPS_PASS? Because if yes, then we could see
another break.

>  static void alps_set_abs_params_st(struct alps_data *priv,
>  				   struct input_dev *dev1);
>  static void alps_set_abs_params_semi_mt(struct alps_data *priv,
> @@ -253,9 +290,8 @@ static void alps_process_packet_v1_v2(struct psmo=
use *psmouse)
>  		return;
>  	}
> =20
> -	/* Dell non interleaved V2 dualpoint has separate stick button bits=
 */
> -	if (priv->proto_version =3D=3D ALPS_PROTO_V2 &&
> -	    priv->flags =3D=3D (ALPS_DELL | ALPS_PASS | ALPS_DUALPOINT)) {
> +	/* Some models have separate stick button bits */
> +	if (priv->flags & ALPS_STICK_BITS) {

Previous code checked at this place if device has also flags ALPS_PASS
and ALPS_DUALPOINT. Now ALPS_STICK_BITS is defined only if ALPS_PROTO_V=
2
and DMI has specific Dell machine.

>  		left |=3D packet[0] & 1;
>  		right |=3D packet[0] & 2;
>  		middle |=3D packet[0] & 4;
> @@ -2552,8 +2588,6 @@ static int alps_set_protocol(struct psmouse *ps=
mouse,
>  	priv->byte0 =3D protocol->byte0;
>  	priv->mask0 =3D protocol->mask0;
>  	priv->flags =3D protocol->flags;
> -	if (dmi_name_in_vendors("Dell"))
> -		priv->flags |=3D ALPS_DELL;
> =20
>  	priv->x_max =3D 2000;
>  	priv->y_max =3D 1400;
> @@ -2568,6 +2602,8 @@ static int alps_set_protocol(struct psmouse *ps=
mouse,
>  		priv->set_abs_params =3D alps_set_abs_params_st;
>  		priv->x_max =3D 1023;
>  		priv->y_max =3D 767;
> +		if (dmi_check_system(alps_dmi_has_separate_stick_buttons))
> +			priv->flags |=3D ALPS_STICK_BITS;
>  		break;
> =20
>  	case ALPS_PROTO_V3:

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
