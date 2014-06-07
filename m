From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: [patch] Input: edt-ft5x06 - fix an i2c write for M09 support
Date: Sun, 08 Jun 2014 01:53:48 +0200
Message-ID: <5393A60C.8040207@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="xtlSJbV10amoe3SfbmwQo92WsCOvhaL3A"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([212.60.202.196]:58522 "EHLO
	mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbaFHAaD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Jun 2014 20:30:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?Lothar_?= =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Fugang Duan <B38611@freescale.com>, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, =?ISO-8859-1?Q?Robert_W=F6rle?= <rwoerle@mibtec.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xtlSJbV10amoe3SfbmwQo92WsCOvhaL3A
Content-Type: multipart/mixed;
 boundary="------------030101020804060900070105"

This is a multi-part message in MIME format.
--------------030101020804060900070105
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi all.

I received notice from Robert W=F6rle who spotted a bug in the ft5x06
driver (M09 support) which can result in bogus values being written into
the configuration registers.

Paul wrote:
> I think i found the problem, as the driver sends 3 bytes instead of 2
> when accessing a register on the M09 firmware.
> Therefore , writing to gain seems to overflow into the offset register.=

>=20
> This seems to be even in the lastet upstream driver so i created a patc=
h
> for this driver  which you find attached.
>=20
> @Simon Budig
>=20
> Find attached a patch to fix this edt driver bug, feel free to comment =
,
> test and commit upstream ;-)

He is right, his fix is correct. Please include his patch into the
repository.

Acked-By: Simon Budig <simon.budig@kernelconcepts.de>

Thanks,
        Simon
--=20
       Simon Budig                        kernel concepts GmbH
       simon.budig@kernelconcepts.de      Sieghuetter Hauptweg 48
       +49-271-771091-17                  D-57072 Siegen


--------------030101020804060900070105
Content-Type: text/x-patch;
 name="0001-Input-edt-ft5x06-fix-i2c-writes-to-2-bytes-on-M09-fi.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename*0="0001-Input-edt-ft5x06-fix-i2c-writes-to-2-bytes-on-M09-fi.pa";
 filename*1="tch"

=46rom 36b9ac0e8206efefc8795c925b0f3b63ab29fd08 Mon Sep 17 00:00:00 2001
From: Robert Woerle <robert@linuxdevelopment.de>
Date: Wed, 28 May 2014 13:22:09 +0200
Subject: [PATCH] Input: edt-ft5x06 - fix i2c writes to 2 bytes on M09
 firmware

Signed-off-by: Robert Woerle <robert@linuxdevelopment.de>
---
 drivers/input/touchscreen/edt-ft5x06.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touch=
screen/edt-ft5x06.c
index f8815be..d4f3399 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -271,7 +271,7 @@ static int edt_ft5x06_register_write(struct edt_ft5x0=
6_ts_data *tsdata,
 		wrbuf[0] =3D addr;
 		wrbuf[1] =3D value;
=20
-		return edt_ft5x06_ts_readwrite(tsdata->client, 3,
+		return edt_ft5x06_ts_readwrite(tsdata->client, 2,
 					wrbuf, 0, NULL);
=20
 	default:
--=20
1.7.9.5


--------------030101020804060900070105--

--xtlSJbV10amoe3SfbmwQo92WsCOvhaL3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlOTpgwACgkQO2O/RXesiHC5nQCgqm6o35qTeLqcS+XQaLx1tjct
YOgAoIOauVOumDCnknHwiYJF921woYaG
=0JFk
-----END PGP SIGNATURE-----

--xtlSJbV10amoe3SfbmwQo92WsCOvhaL3A--
