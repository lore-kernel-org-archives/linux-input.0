From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH] HID: kye: Fix missing break in kye_report_fixup()
Date: Sat, 30 Nov 2013 19:12:27 +0000
Message-ID: <1385838747.2760.4.camel@deadeye.wl.decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-MA5Yx3fTYYxGo9fbBy0v"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:47073 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750915Ab3K3TMi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Nov 2013 14:12:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Adam Kulagowski <fidor@fidor.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org


--=-MA5Yx3fTYYxGo9fbBy0v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The change to support Genius Manticore Keyboard also changed behaviour
for Genius Gx Imperator Keyboard, as there is no break between the
cases.  This is presumably a mistake.

Reported by Coverity as CID 1134029.

Fixes: 4a2c94c9b6c0 ('HID: kye: Add report fixup for Genius Manticore Keybo=
ard')
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hid/hid-kye.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-kye.c b/drivers/hid/hid-kye.c
index ecb5ca6..e776963 100644
--- a/drivers/hid/hid-kye.c
+++ b/drivers/hid/hid-kye.c
@@ -341,6 +341,7 @@ static __u8 *kye_report_fixup(struct hid_device *hdev, =
__u8 *rdesc,
 	case USB_DEVICE_ID_GENIUS_GX_IMPERATOR:
 		rdesc =3D kye_consumer_control_fixup(hdev, rdesc, rsize, 83,
 					"Genius Gx Imperator Keyboard");
+		break;
 	case USB_DEVICE_ID_GENIUS_MANTICORE:
 		rdesc =3D kye_consumer_control_fixup(hdev, rdesc, rsize, 104,
 					"Genius Manticore Keyboard");

--=20
Ben Hutchings
Usenet is essentially a HUGE group of people passing notes in class.
                      - Rachel Kadel, `A Quick Guide to Newsgroup Etiquette=
'

--=-MA5Yx3fTYYxGo9fbBy0v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIVAwUAUpo4m+e/yOyVhhEJAQp2VQ/+MQ9M5y1j6yzciQh3GVAwj+how5zCIK4V
Pg+sfEJOHbxndCVyoFR33V8JBseEM/uPS4eR26oCZo2jxV53wkUK91QgXn7aS6OO
WJvlVDRiG03Pd297xYK8tTz4FNL4rRSLGSeIR5zBKbjf3I1IG9wsZUjdW6wOSCbq
Je1YQCN91ll7Dy81GDFfpa4e9Q3Gv5hV67NFiA+oGYCx2/O4QRIn68Hi54qNqBMn
ENooP/j/qNEmWRhQVW9GPVagR6Ea/kO6nhXGHkwhEu/oDRSxIHkuqNS2IDFTHEyg
oGfkGY5vrDIwr4m9uqtLTDAbRfAe2wl0ktwkiNwPAO0exssLBXhuTgTLv028FEQT
+ZEEgsXZBZqymnoHFbFFdkIO8AY7JUqp9wd82k6E9Z+fME2XqlhxRd3V9QIlkt9o
vAnvH6VPOttsl0mTGKin6vZxbwxz3TMnK7ARhyCDD5avpVTUqCBvW5fmkpKOa1HK
SBqZQztOURTmEPA1XvUd15cJMHVGlZJXbG1sA5Kh+X2iNCAOr9fTZHUmUKd18tkv
ap2nOt5RoeIRfeCwDEkrRYr0ja3WgT0yZvGMbZPfLsAbSAGj8+eE0Uzu0nU7qdCM
5v4jd3a/r5UpB2tiwPbGGE8J0Hg9reZgjuXTa+AzuPQ0BZmef/LiGDbmgMIT1agI
CHvosuNcByc=
=4mqB
-----END PGP SIGNATURE-----

--=-MA5Yx3fTYYxGo9fbBy0v--
