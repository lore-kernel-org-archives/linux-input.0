From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Subject: Re: [PATCH] input: alps: Add support for the touchpad on Dell Latitude
 E6410
Date: Sat, 15 May 2010 16:05:55 +0200
Message-ID: <4BEEAA43.5030005@archlinux.org>
References: <1273931524-15654-1-git-send-email-thomas@archlinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig503B292DAF4EB36FA2F26448"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gerolde.archlinux.org ([66.211.214.132]:57249 "EHLO
	archlinux.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753509Ab0EOOF6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 May 2010 10:05:58 -0400
In-Reply-To: <1273931524-15654-1-git-send-email-thomas@archlinux.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, alessandro@molarulez.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig503B292DAF4EB36FA2F26448
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 15.05.2010 15:52, schrieb Thomas B=E4chler:
> ---
>  drivers/input/mouse/alps.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> index 99d5876..0c83070 100644
> --- a/drivers/input/mouse/alps.c
> +++ b/drivers/input/mouse/alps.c
> @@ -66,6 +66,8 @@ static const struct alps_model_info alps_model_data[]=
 =3D {
>  	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell Vo=
stro 1400 */
>  	{ { 0x52, 0x01, 0x14 }, 0xff, 0xff,
>  		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },	  /* Toshiba Te=
cra A11-11L */
> +	{ { 0x73, 0x02, 0x64 }, 0xff, 0xff,
> +		ALPS_PASS | ALPS_DUALPOINT },				  /* Dell Latitude E6410 */
>  };
> =20
>  /*

Okay, never mind, we were too quick in thinking everything was correct,
the parameters seem to be wrong. The touchpad is detected and seems to
work, but in 'synclient -m', you see that actually nothing happens.

Dmitry, do you know which parameters we need to tweak to fix this? Maybe
the 0xff, 0xff mask is wrong? Or the flags? Sorry, my knowledge ends here=
=2E


--------------enig503B292DAF4EB36FA2F26448
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEAREIAAYFAkvuqkMACgkQEda5KzHP/VCc7ACfca/E5IM2Gq1Cx34fBwOj2qR4
AVEAoJvyEcACVA4EdorEn2QYWxw4rcQV
=E6r5
-----END PGP SIGNATURE-----

--------------enig503B292DAF4EB36FA2F26448--
