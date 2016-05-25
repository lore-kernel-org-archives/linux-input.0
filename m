From: Ben Gamari <ben@smart-cactus.org>
Subject: Re: Dell Latitude E7470 touchpad status
Date: Wed, 25 May 2016 14:32:28 +0200
Message-ID: <877feijp2b.fsf@smart-cactus.org>
References: <87eg9j6zf7.fsf@smart-cactus.org> <23E0F704395E694FA4710C833FA087E50D40B8BF13@TPEX7ADC101.APAC.DELL.COM> <87bn45gr0e.fsf@smart-cactus.org> <20160517082309.GZ29844@pali> <877fet10a9.fsf@smart-cactus.org> <20160517131629.GE29844@pali> <23E0F704395E694FA4710C833FA087E50D40B8C592@TPEX7ADC101.APAC.DELL.COM> <20160517152239.GF29844@pali> <23E0F704395E694FA4710C833FA087E50D40D0723A@TPEX7ADC101.APAC.DELL.COM> <20160525073949.GY29844@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56173 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbcEYMcg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 May 2016 08:32:36 -0400
In-Reply-To: <20160525073949.GY29844@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>, Allen_Hung@Dell.com
Cc: Mario_Limonciello@Dell.com, linux-input@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:

> Hi Allen, thank you for confirmation.
>
> Ben, V8 protocol is supported by linux kernel since version 4.1. Do you
> have needed version? If yes and your touchpad does not work, please
> compile psmouse.ko in debug mode and send us dmesg output. Maybe there
> can be something interesting...
>
The first attached patch gets me partly there; I see multitouch events,
the pressure appears to reflect reality, and things generally work as
expected. That is, until I try to touch the touchstick, which causes the
pointer to jump around wildly.

The second attached patch makes things behave slightly better, but the
touchstick still does not work as expected. Settting
ALPS_PS2_INTERLEAVED as well doesn't appear to change anything.

Ideas?

Cheers,

=2D Ben



From=2073f99f86c77d39ff512f2064ca9f2002c6404dd9 Mon Sep 17 00:00:00 2001
From: Ben Gamari <ben@smart-cactus.org>
Date: Wed, 25 May 2016 14:19:53 +0200
Subject: [PATCH 1/2] alps: Add touchpad for Dell Latitude E7470

However, this still isn't quite right as the touchstick appears to
corrupt the event stream.
=2D--
 drivers/input/mouse/alps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 936f07a..a0c5dfe 100644
=2D-- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2767,6 +2767,9 @@ static int alps_identify(struct psmouse *psmouse, str=
uct alps_data *priv)
 		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 &&
 			   e7[2] =3D=3D 0x14 && ec[1] =3D=3D 0x02) {
 			protocol =3D &alps_v8_protocol_data;
+		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 &&
+               e7[2] =3D=3D 0x28 && ec[1] =3D=3D 0x01) {
+      protocol =3D &alps_v8_protocol_data;
 		} else {
 			psmouse_dbg(psmouse,
 				    "Likely not an ALPS touchpad: E7=3D%3ph, EC=3D%3ph\n", e7, ec);
=2D-=20
2.8.1



From=20ea668a46bfbc4165841368a75b197febb09c5b33 Mon Sep 17 00:00:00 2001
From: Ben Gamari <ben@smart-cactus.org>
Date: Wed, 25 May 2016 14:22:05 +0200
Subject: [PATCH 2/2] Try setting ALPS_DUALPOINT

=2D--
 drivers/input/mouse/alps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index a0c5dfe..a034933 100644
=2D-- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -138,6 +138,7 @@ static const struct alps_model_info alps_model_data[] =
=3D {
 	{ { 0x52, 0x01, 0x14 }, 0x00, { ALPS_PROTO_V2, 0xff, 0xff,
 		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED } },				/* Toshiba Tec=
ra A11-11L */
 	{ { 0x73, 0x02, 0x64 }, 0x8a, { ALPS_PROTO_V4, 0x8f, 0x8f, 0 } },
+	{ { 0x73, 0x03, 0x28 }, 0x00, { ALPS_PROTO_V8, 0x18, 0x18, ALPS_DUALPOINT=
 } }, /* Dell Latitude E7470 */
 };
=20
 static const struct alps_protocol_info alps_v3_protocol_data =3D {
@@ -2767,9 +2768,6 @@ static int alps_identify(struct psmouse *psmouse, str=
uct alps_data *priv)
 		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 &&
 			   e7[2] =3D=3D 0x14 && ec[1] =3D=3D 0x02) {
 			protocol =3D &alps_v8_protocol_data;
=2D		} else if (e7[0] =3D=3D 0x73 && e7[1] =3D=3D 0x03 &&
=2D               e7[2] =3D=3D 0x28 && ec[1] =3D=3D 0x01) {
=2D      protocol =3D &alps_v8_protocol_data;
 		} else {
 			psmouse_dbg(psmouse,
 				    "Likely not an ALPS touchpad: E7=3D%3ph, EC=3D%3ph\n", e7, ec);
=2D-=20
2.8.1


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRZtcAAoJEHPt6ejPuu8BQnsIAMDAmGMf6qkXZjs+4fYFjRKZ
uU1T20aHI16CPBSY2AhrVJVIxiGMDAyE8+HwICrAK7pNq7BcB5SxZZeB4+Ct5XpN
+SyuPstuaRTCr3syLhKfB6O+3R/zUmFTtEBzLHhpS3C3SS7Qmpf9EcD6TtRFfYmQ
uYE24z8iOYRuMdpgVYCEBMudR5q+1lVKMEzPAM295mfKj2nfh+Dlagr//0ESvEBF
+GFHrrqPLuY1NXCbsqwtovTplxi9EEdjHM+cJJH7NQ7EQkLrSMywQ+hH5pwq52Zv
nfra1e7cOhr54kUh7pN19M4yOyv3PACfMGJIDRRyt7UWmtQqr8gI2tgP1BGLIcM=
=UXUK
-----END PGP SIGNATURE-----
--=-=-=--
