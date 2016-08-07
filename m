From: Philippe PITTOLI <karchnu@karchnu.fr>
Subject: [PATCH] joystick: xpad.c, new xbox controller ID (Hori Real Arcade
 Pro.V)
Date: Sun, 7 Aug 2016 23:58:00 +0200
Message-ID: <20160807215800.GA27360@the.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from the.karchnu.fr ([89.234.141.3]:60511 "EHLO the.karchnu.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485AbcHGWEC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Aug 2016 18:04:02 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I added a controller ID to the xbox driver for the Real Aracade Pro V
controller from Hori.

It's my first patch, and I followed the guidances from the
kernelnewbies.org website, I hope it'll be ok.

Thanks,

---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 83af17a..ec5a670 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -190,6 +190,7 @@ static const struct xpad_device {
 	{ 0x0f0d, 0x000a, "Hori Co. DOA4 FightStick", 0, XTYPE_XBOX360 },
 	{ 0x0f0d, 0x000d, "Hori Fighting Stick EX2", MAP_TRIGGERS_TO_BUTTONS, XTY=
PE_XBOX360 },
 	{ 0x0f0d, 0x0016, "Hori Real Arcade Pro.EX", MAP_TRIGGERS_TO_BUTTONS, XTY=
PE_XBOX360 },
+	{ 0x0f0d, 0x0063, "Hori Real Arcade Pro.V", 0, XTYPE_XBOXONE },
 	{ 0x0f0d, 0x0067, "HORIPAD ONE", 0, XTYPE_XBOXONE },
 	{ 0x0f30, 0x0202, "Joytech Advanced Controller", 0, XTYPE_XBOX },
 	{ 0x0f30, 0x8888, "BigBen XBMiniPad Controller", 0, XTYPE_XBOX },
--=20
2.5.0

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXp67oAAoJEKhcQk7EXZxN0nwP/0VdOyd2miZnOln5iNdG7vBo
Gabx+gQMSJCejK/oO1AZAfxOABKCwtc2Qegp9YtBSaH1f/ZuthCpzXNFFcZ1p8RD
loZm2SblrYTzEDVg+jULW4571bOfhbKscCM2NxvlZ4V8TPNcTx2UtcHUQXKwKQD3
3OmgcoeZoODs3mjdOhN2rInC9rjGRt0eyaTJqt7oNRdu+gZTfVczaYa581Xku88y
yHcNU0ArOZpSpFuUUeYCbW+rp4zJH2mWm1pVi9K0PXfNmj3pNikX/aCwPtQRNcD0
EJvRSb6lA5jPDN2Fo+RQmagb5LYRTaoyqXbdRg45+IZQrgqpKfU72JM1RoQroBFs
3dpNmVS10kZmIgFlJMWHhqsKPMn3ELnWgAw3asxHXrEHEEIy3DxUxBKHoyEadkU0
DnmbCo9atoYdiO44n6adCthLqZKF3fDhqbQ8cXVXuWqvKcmDRQUj7SNaWa5GLRys
J6oIlgV5gcJZO33ECBlqkcncNfqklbuSO9GGz788b3/Ibgx/LehROxM/bIxwS76I
0vvtUKqJFY69u5LbX2zd252oz1aWEFpI8ypiPylagEQhPI9vVchss7XOPs30tYfa
ixLYMg2Puh+33GOj0IIXRmyyTQGQR7yhFUGKkWmy7M3jdLtk1Y4e/xNKyoGdv15B
Hy8cINKqtxPFf3vONIqg
=eaYy
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
