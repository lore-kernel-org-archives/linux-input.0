From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: psmouse: Use same format for secondary devices as
 for primary
Date: Sat, 18 Jun 2016 10:10:02 -0700
Message-ID: <20160618171002.GA15429@dtor-ws>
References: <1466268164-19264-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35863 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbcFRRKH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jun 2016 13:10:07 -0400
Content-Disposition: inline
In-Reply-To: <1466268164-19264-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jun 18, 2016 at 06:42:44PM +0200, Pali Roh=E1r wrote:
> This patch changes name of secondary psmouse devices to mach format o=
f
> primary device. Format of primary device is "protocol vendor name" an=
d is
> set by function psmouse_switch_protocol() in file psmouse-base.c.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>

Applied, thank you.

> ---
>  drivers/input/mouse/elantech.c |    2 +-
>  drivers/input/mouse/lifebook.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index 78f93cf..e0fbd42 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1714,7 +1714,7 @@ int elantech_init(struct psmouse *psmouse)
>  		snprintf(etd->tp_phys, sizeof(etd->tp_phys), "%s/input1",
>  			psmouse->ps2dev.serio->phys);
>  		tp_dev->phys =3D etd->tp_phys;
> -		tp_dev->name =3D "Elantech PS/2 TrackPoint";
> +		tp_dev->name =3D "ETPS/2 Elantech TrackPoint";
>  		tp_dev->id.bustype =3D BUS_I8042;
>  		tp_dev->id.vendor  =3D 0x0002;
>  		tp_dev->id.product =3D PSMOUSE_ELANTECH;
> diff --git a/drivers/input/mouse/lifebook.c b/drivers/input/mouse/lif=
ebook.c
> index e5ed216..13d324c 100644
> --- a/drivers/input/mouse/lifebook.c
> +++ b/drivers/input/mouse/lifebook.c
> @@ -287,7 +287,7 @@ static int lifebook_create_relative_device(struct=
 psmouse *psmouse)
>  		 "%s/input1", psmouse->ps2dev.serio->phys);
> =20
>  	dev2->phys =3D priv->phys;
> -	dev2->name =3D "PS/2 Touchpad";
> +	dev2->name =3D "LBPS/2 Fujitsu Lifebook Touchpad";
>  	dev2->id.bustype =3D BUS_I8042;
>  	dev2->id.vendor  =3D 0x0002;
>  	dev2->id.product =3D PSMOUSE_LIFEBOOK;
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
