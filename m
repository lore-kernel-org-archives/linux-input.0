From: Mohamed-Ikbel Boulabiar <medikbel@lii-enac.fr>
Subject: [PATCH] input: mt: Add ABS_MT_* Events reporting to evtest
Date: Wed, 17 Jun 2009 08:22:18 +0100
Message-ID: <1245223338.22157.23.camel@linux-85bv>
References: <1245222242.22157.6.camel@linux-85bv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-LQWuKOibPmbQ8DlGxoGG"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 89-230.252-81.static-ip.oleane.fr ([81.252.230.89]:42786 "EHLO
	smtp.lii-enac.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbZFQGXr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Jun 2009 02:23:47 -0400
In-Reply-To: <1245222242.22157.6.camel@linux-85bv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, vojtech@suse.cz, chatty@enac.fr, rydberg@euromail.se, boulabiar@gmail.com


--=-LQWuKOibPmbQ8DlGxoGG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch adds new multitouch events reporting capabilities to evtest
tool.
New multi-touch events (ABS_MT_*) were added by Henrik Rydberg in the
kernel-2.6.30

From: Mohamed-Ikbel Boulabiar <medikbel@lii-enac.fr>
Tested-by: St=C3=A9phane Chatty <chatty@enac.fr>

diff -rupN a/utils/evtest.c b/utils/evtest.c=20
--- a/utils/evtest.c	2009-05-20 00:12:14.000000000 +0100
+++ b/utils/evtest.c	2009-06-17 08:16:15.000000000 +0100
@@ -2,7 +2,7 @@
  * $Id$
  *
  *  Copyright (c) 1999-2000 Vojtech Pavlik
- *
+ *  		  2009 Mohamed-Ikbel Boulabiar
  *  Event device test program
  */
=20
@@ -252,6 +252,16 @@ char *absolutes[ABS_MAX + 1] =3D {
 	[ABS_DISTANCE] =3D "Distance",	[ABS_TILT_X] =3D "XTilt",
 	[ABS_TILT_Y] =3D "YTilt",		[ABS_TOOL_WIDTH] =3D "Tool Width",
 	[ABS_VOLUME] =3D "Volume",	[ABS_MISC] =3D "Misc",
+	[ABS_MT_TOUCH_MAJOR] =3D "MT Touch Major",
+	[ABS_MT_TOUCH_MINOR] =3D "MT Touch Minor",
+	[ABS_MT_WIDTH_MAJOR] =3D "MT Width Major",
+	[ABS_MT_WIDTH_MINOR] =3D "MT Width Minor",
+	[ABS_MT_POSITION_X] =3D "MT Position X",=09
+	[ABS_MT_POSITION_Y] =3D "MT Position Y",
+	[ABS_MT_TOOL_TYPE] =3D "MT Tool Type",=09
+	[ABS_MT_BLOB_ID] =3D "MT Blob ID",
+	[ABS_MT_ORIENTATION] =3D "MT Orientation",
+	[ABS_MT_TRACKING_ID] =3D "MT Tracking ID",
 };
=20
 char *misc[MSC_MAX + 1] =3D {


--=-LQWuKOibPmbQ8DlGxoGG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Ceci est une partie de message
 =?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAko4maoACgkQAD1+XQxLfcQGXACgkntLa5LIwDRO79T6HdA3kwap
tjsAn3Jw4V5sQt11ey5cSopfHnV0Jynf
=n0jU
-----END PGP SIGNATURE-----

--=-LQWuKOibPmbQ8DlGxoGG--

