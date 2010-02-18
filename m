From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH] Add resources description for s3c24xx ts driver
Date: Thu, 18 Feb 2010 17:00:09 +0200
Message-ID: <201002181700.15340.anarsoul@gmail.com>
References: <201002181601.20625.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1685460.3krTF3Fk7m";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:20647 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754417Ab0BRPEN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2010 10:04:13 -0500
Received: by fg-out-1718.google.com with SMTP id 19so736103fgg.1
        for <linux-input@vger.kernel.org>; Thu, 18 Feb 2010 07:04:12 -0800 (PST)
In-Reply-To: <201002181601.20625.anarsoul@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org

--nextPart1685460.3krTF3Fk7m
Content-Type: multipart/mixed;
  boundary="Boundary-01=_5XVfLtiHht8oeoB"
Content-Transfer-Encoding: 7bit


--Boundary-01=_5XVfLtiHht8oeoB
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
18 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 16:01:14 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Vasily Khoruzhick =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BB:
> Following patch adds resource description for s3c24xx ts driver.
> Without this patch driver fails to initialize with "no resource for
> interrupt" message.
>=20
> Anyway, even with this patch driver stops reporting events after few
> presses, I'll investigate on it later.
>=20
> Btw, does this driver work at least for anyone?
>=20
> Regards
> Vasily

Ok, found problem: driver reports touches even if stylus is not down. Here'=
s=20
patch in attachment.

Regards
Vasily

--Boundary-01=_5XVfLtiHht8oeoB
Content-Type: text/x-patch;
  charset="iso-8859-15";
  name="0002-s3c24xx_ts-report-touch-only-when-stylus-is-down.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="0002-s3c24xx_ts-report-touch-only-when-stylus-is-down.patch"

=46rom 1cda754a3cc14c1576b5f6be1f68db03d707cb81 Mon Sep 17 00:00:00 2001
=46rom: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Thu, 18 Feb 2010 16:58:47 +0200
Subject: [PATCH 2/2] s3c24xx_ts: report touch only when stylus is down

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
=2D--
 drivers/input/touchscreen/s3c2410_ts.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchsc=
reen/s3c2410_ts.c
index 6386b44..e2fe2ed 100644
=2D-- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -128,25 +128,25 @@ static void touch_timer_fire(unsigned long data)
=20
 	down =3D get_down(data0, data1);
=20
=2D	if (ts.count =3D=3D (1 << ts.shift)) {
=2D		ts.xp >>=3D ts.shift;
=2D		ts.yp >>=3D ts.shift;
+	if (down) {
+		if (ts.count =3D=3D (1 << ts.shift)) {
+			ts.xp >>=3D ts.shift;
+			ts.yp >>=3D ts.shift;
=20
=2D		dev_dbg(ts.dev, "%s: X=3D%lu, Y=3D%lu, count=3D%d\n",
=2D			__func__, ts.xp, ts.yp, ts.count);
+			dev_dbg(ts.dev, "%s: X=3D%lu, Y=3D%lu, count=3D%d\n",
+				__func__, ts.xp, ts.yp, ts.count);
=20
=2D		input_report_abs(ts.input, ABS_X, ts.xp);
=2D		input_report_abs(ts.input, ABS_Y, ts.yp);
+			input_report_abs(ts.input, ABS_X, ts.xp);
+			input_report_abs(ts.input, ABS_Y, ts.yp);
=20
=2D		input_report_key(ts.input, BTN_TOUCH, 1);
=2D		input_sync(ts.input);
+			input_report_key(ts.input, BTN_TOUCH, 1);
+			input_sync(ts.input);
=20
+		}
 		ts.xp =3D 0;
 		ts.yp =3D 0;
 		ts.count =3D 0;
=2D	}
=20
=2D	if (down) {
 		s3c_adc_start(ts.client, 0, 1 << ts.shift);
 	} else {
 		ts.count =3D 0;
=2D-=20
1.7.0


--Boundary-01=_5XVfLtiHht8oeoB--

--nextPart1685460.3krTF3Fk7m
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkt9Vf8ACgkQRM6pQpltKE5dmACfY12t5c4akBSpP7BSbFdxtuv9
5tkAn0JX4lATIRHoEeLsUZxggxT55Uef
=R/9M
-----END PGP SIGNATURE-----

--nextPart1685460.3krTF3Fk7m--
