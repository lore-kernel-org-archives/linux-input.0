From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
Subject: Re: [PATCH] input: alps: Add support for the touchpad of the Toshiba
 Tecra A11-11L
Date: Tue, 09 Mar 2010 20:17:02 +0100
Message-ID: <4B969EAE.3030903@archlinux.org>
References: <1268160967-21403-1-git-send-email-thomas@archlinux.org> <20100309190135.GB28000@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig7CFC4229EF549D9C9995FB99"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gerolde.archlinux.org ([66.211.214.132]:45611 "EHLO
	archlinux.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751194Ab0CITRH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Mar 2010 14:17:07 -0500
In-Reply-To: <20100309190135.GB28000@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7CFC4229EF549D9C9995FB99
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 09.03.2010 20:01, schrieb Dmitry Torokhov:
> Hi Thomas,
>=20
> On Tue, Mar 09, 2010 at 07:56:07PM +0100, Thomas B=E4chler wrote:
>>
>> Signed-off-by: Thomas B=E4chler <thomas@archlinux.org>
>> ---
>> This patch was made by trial-and-error, I copied the byte0 and
>> mask0 value from another model, tried different flags settings
>> and it seems to work. I have no idea if there might be side-
>> effects due to incorrect settings. Please tell me if I can do
>> anything to verify or correct these values.
>>
>>  drivers/input/mouse/alps.c |    2 ++
>>  1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
>> index f93c2c0..f6dad83 100644
>> --- a/drivers/input/mouse/alps.c
>> +++ b/drivers/input/mouse/alps.c
>> @@ -63,6 +63,8 @@ static const struct alps_model_info alps_model_data[=
] =3D {
>>  	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
>>  		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
>>  	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell V=
ostro 1400 */
>> +	{ { 0x52, 0x01, 0x14 }, 0xff, 0xff,
>> +		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },	  /* Toshiba T=
ecra A11-11L */
>>  };
>> =20
>=20
> Looking at the picture it appears to have a touchpad only, not a
> touchpad/trackpoint combo. So I am wondering if ALPS_DUALPOINT and
> ALPS_PS2_INTERLEAVED flags are needed here. What happens if you remove
> them? Also, does it have external PS/2 post?

The model I have here does have a trackpoint, thus I put ALPS_DUALPOINT
in. Also, I had problems without ALPS_PS2_INTERLEAVED ([...] lost sync
at byte 1). I did not try without ALPS_PASS though, only with.

The device does not seem to have an external PS/2 port, but there is a
connector for a docking station (which I don't own).

I am more concerned about the two 0xff values here, because they are
actually guesses.

Thanks for the quick response.


--------------enig7CFC4229EF549D9C9995FB99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEAREIAAYFAkuWnq4ACgkQEda5KzHP/VAfOQCfVudxjdZEyZS7nz75tvE5kOKx
NOQAoICCRSPliTSxbtof3QsS+8QYOai2
=s7/E
-----END PGP SIGNATURE-----

--------------enig7CFC4229EF549D9C9995FB99--
