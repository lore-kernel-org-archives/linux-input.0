From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/7] input: alps: Fix name, product and version of dev2
 input device
Date: Sun, 11 Jan 2015 16:30:39 -0800
Message-ID: <20150112003039.GB31862@dtor-ws>
References: <1415993906-13307-1-git-send-email-pali.rohar@gmail.com>
 <1415993906-13307-6-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:39880 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043AbbALAao (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Jan 2015 19:30:44 -0500
Content-Disposition: inline
In-Reply-To: <1415993906-13307-6-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Vadim Klishko <vadim@cirque.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 14, 2014 at 08:38:24PM +0100, Pali Roh=E1r wrote:
> This patch fix name, product and version of dev2 input device based o=
n format
> used in function psmouse_switch_protocol() in file psmouse-base.c.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/alps.c |   18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 0176425..2b7b74d 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -2407,14 +2407,24 @@ int alps_init(struct psmouse *psmouse)
>  		dev1->keybit[BIT_WORD(BTN_MIDDLE)] |=3D BIT_MASK(BTN_MIDDLE);
>  	}
> =20
> +	if (priv->flags & ALPS_DUALPOINT) {
> +		/*
> +		 * format of input device name is: "protocol vendor name"
> +		 * see function psmouse_switch_protocol() in psmouse-base.c
> +		 */
> +		dev2->name =3D "AlpsPS/2 ALPS DualPoint Stick";
> +		dev2->id.product =3D PSMOUSE_ALPS;
> +		dev2->id.version =3D priv->proto_version;
> +	} else {
> +		dev2->name =3D "PS/2 ALPS Mouse";
> +		dev2->id.product =3D PSMOUSE_PS2;
> +		dev2->id.version =3D 0x0000;
> +	}
> +
>  	snprintf(priv->phys, sizeof(priv->phys), "%s/input1", psmouse->ps2d=
ev.serio->phys);
>  	dev2->phys =3D priv->phys;
> -	dev2->name =3D (priv->flags & ALPS_DUALPOINT) ?
> -		     "DualPoint Stick" : "ALPS PS/2 Device";
>  	dev2->id.bustype =3D BUS_I8042;
>  	dev2->id.vendor  =3D 0x0002;
> -	dev2->id.product =3D PSMOUSE_ALPS;
> -	dev2->id.version =3D 0x0000;
>  	dev2->dev.parent =3D &psmouse->ps2dev.serio->dev;
> =20
>  	dev2->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
> --=20
> 1.7.9.5
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
