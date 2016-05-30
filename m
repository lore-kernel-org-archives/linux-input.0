From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 4/4] input/alps: Set DualPoint flag for 74 03 28 devices
Date: Mon, 30 May 2016 11:11:00 +0200
Message-ID: <20160530091100.GP29844@pali>
References: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
 <1464436862-2649-5-git-send-email-ben@smart-cactus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34755 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200AbcE3JLD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 May 2016 05:11:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so20541784wmn.1
        for <linux-input@vger.kernel.org>; Mon, 30 May 2016 02:11:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1464436862-2649-5-git-send-email-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>

On Saturday 28 May 2016 14:01:02 Ben Gamari wrote:
> Here we introduce logic in alps_identify to set the ALPS_DUALPOINT fl=
ag
> for touchpad hardware responding to E7 report with 73 03 28, as is fo=
und
> in the Dell Latitude E7470.
> ---
>  drivers/input/mouse/alps.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 25d2cad..431bc26 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2776,6 +2776,7 @@ static int alps_identify(struct psmouse *psmous=
e, struct alps_data *priv)
>  	const struct alps_protocol_info *protocol;
>  	unsigned char e6[4], e7[4], ec[4];
>  	int error;
> +	int flags =3D 0;
> =20
>  	/*
>  	 * First try "E6 report".
> @@ -2817,6 +2818,10 @@ static int alps_identify(struct psmouse *psmou=
se, struct alps_data *priv)
>  		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 &&
>  			   e7[2] =3D=3D 0x14 && ec[1] =3D=3D 0x02) {
>  			protocol =3D &alps_v8_protocol_data;
> +		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 &&
> +			   e7[2] =3D=3D 0x28 && ec[1] =3D=3D 0x01) {
> +			protocol =3D &alps_v8_protocol_data;
> +			flags |=3D ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESSURE;
>  		} else {
>  			psmouse_dbg(psmouse,
>  				    "Likely not an ALPS touchpad: E7=3D%3ph, EC=3D%3ph\n", e7, e=
c);
> @@ -2830,6 +2835,7 @@ static int alps_identify(struct psmouse *psmous=
e, struct alps_data *priv)
>  		error =3D alps_set_protocol(psmouse, priv, protocol);
>  		if (error)
>  			return error;
> +		priv->flags |=3D flags;
>  	}
> =20
>  	return 0;

I would rather see setting flags in alps_set_protocol function. Where i=
t
is done for other protocols. But do not know if it is easily possible
without rewriting lot of code...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
