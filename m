From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] elantech: clean up hardware/firmware version check
Date: Mon, 4 Jul 2011 22:30:52 +0200
Message-ID: <20110704203052.GA22437@polaris.bitmath.org>
References: <4DCE24BE.70908@tudelft.nl>
 <20110516111552.GA10453@polaris.bitmath.org>
 <20110517054432.GA20428@core.coreip.homeip.net>
 <4DD6E8F4.5070101@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:55456 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab1GDU3F (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2011 16:29:05 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id D18B2EA8FB
	for <linux-input@vger.kernel.org>; Mon,  4 Jul 2011 22:29:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DD6E8F4.5070101@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Chris Bagwell <chris@cnpbagwell.com>, Florian Ragwitz <rafl@debian.org>

Hi =C9ric,

> Find below patch 2 rebased. Actually, as half of if is not useful
> anymore (we gave up on checking the data for version 2) and you had
> integrated the other half already, this doesn't contain a lot anymore=
=2E
> So it ends up being just a clean up patch, mostly putting all the
> version checks in the same place.

Did you get any response to this one?

> According to the protocol document, there are a couple of different
> versions of the hardware and firmware. Using the version number, it
> should be possible to distinguish between them, at least for the
> properties we care about. This moves all the version check together.
>=20
> Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
> ---
>  drivers/input/mouse/elantech.c |   28 ++++++++++++++--------------
>  1 files changed, 14 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index 3250356..0d9c547 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -757,15 +757,25 @@ int elantech_init(struct psmouse *psmouse)
>  		etd->hw_version =3D 2;
>  		/* For now show extra debug information */
>  		etd->debug =3D 1;
> -		/* Don't know how to do parity checking for version 2 */
> -		etd->paritycheck =3D 0;
> +		/* Version 2 doesn't contain control bits */
> +		etd->paritycheck =3D false;
> =20
>  		if (etd->fw_version >=3D 0x020800)
>  			etd->reports_pressure =3D true;
> -
> +	} else if ((etd->fw_version =3D=3D 0x020022) || (etd->fw_version =3D=
=3D 0x020600)) {
> +		/*
> +		 * This firmware suffers from misreporting coordinates when
> +		 * a touch action starts causing the mouse cursor or scrolled page
> +		 * to jump. Enable a workaround.
> +		 */
> +		pr_info("firmware version 2.0.34/2.6.0 detected, enabling jumpy cu=
rsor workaround\n");
> +		etd->jumpy_cursor =3D 1;
> +		etd->debug =3D 1;
> +		etd->hw_version =3D 1;
> +		etd->paritycheck =3D true;
>  	} else {
>  		etd->hw_version =3D 1;
> -		etd->paritycheck =3D 1;
> +		etd->paritycheck =3D true;
>  	}
> =20
>  	pr_info("assuming hardware version %d, firmware version %d.%d.%d\n"=
,
> @@ -779,16 +789,6 @@ int elantech_init(struct psmouse *psmouse)
>  		param[0], param[1], param[2]);
>  	etd->capabilities =3D param[0];
> =20
> -	/*
> -	 * This firmware suffers from misreporting coordinates when
> -	 * a touch action starts causing the mouse cursor or scrolled page
> -	 * to jump. Enable a workaround.
> -	 */
> -	if (etd->fw_version =3D=3D 0x020022 || etd->fw_version =3D=3D 0x020=
600) {
> -		pr_info("firmware version 2.0.34/2.6.0 detected, enabling jumpy cu=
rsor workaround\n");
> -		etd->jumpy_cursor =3D true;
> -	}
> -
>  	if (elantech_set_absolute_mode(psmouse)) {
>  		pr_err("failed to put touchpad into absolute mode.\n");
>  		goto init_fail;
> --=20
> 1.7.5.1
>=20

    Acked-by: Henrik Rydberg <rydberg@euromail.se>

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
