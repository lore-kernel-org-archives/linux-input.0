From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down
Date: Fri, 19 Feb 2010 12:02:10 +0200
Message-ID: <201002191202.16384.anarsoul@gmail.com>
References: <1266510750-9846-1-git-send-email-anarsoul@gmail.com> <1266510750-9846-3-git-send-email-anarsoul@gmail.com> <20100219091755.GB2856@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart633305886.vjo6a6FFj1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:48408 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751333Ab0BSKCm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Feb 2010 05:02:42 -0500
Received: by fg-out-1718.google.com with SMTP id l26so239946fgb.1
        for <linux-input@vger.kernel.org>; Fri, 19 Feb 2010 02:02:40 -0800 (PST)
In-Reply-To: <20100219091755.GB2856@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, linux-input@vger.kernel.org

--nextPart633305886.vjo6a6FFj1
Content-Type: multipart/mixed;
  boundary="Boundary-01=_jGmfLo4gCpfcCJd"
Content-Transfer-Encoding: 7bit


--Boundary-01=_jGmfLo4gCpfcCJd
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Dmitry,

=D0=92 =D1=81=D0=BE=D0=BE=D0=B1=D1=89=D0=B5=D0=BD=D0=B8=D0=B8 =D0=BE=D1=82 =
19 =D1=84=D0=B5=D0=B2=D1=80=D0=B0=D0=BB=D1=8F 2010 11:17:55 =D0=B0=D0=B2=D1=
=82=D0=BE=D1=80 Dmitry Torokhov =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BB:

> I do not think this is right. Here you reset sampling data regardless
> of whether you got the right number of samples or not. You should repeat
> s3c_adc_start only if you got (1 << ts.shift) samples. But I think I see
> why touchpad may stop reporintg sometimes - if timer fires before you
> get the needed number of samples nothing will happen as timer is not
> gettign rearmed.

Problem is driver reports "stylus down" event when stylus is already up,=20
anyway I agree that samples should not be discarded.

> >  	} else {
> >  =09
> >  		ts.count =3D 0;
>=20
> I also think this branch is missing ts.xp =3D ts.yp =3D 0;

Ok.

=46ixed version is in attachment

Thanks for review.

--Boundary-01=_jGmfLo4gCpfcCJd
Content-Type: text/x-patch;
  charset="iso-8859-1";
  name="0002-s3c24xx_ts-report-touch-only-when-stylus-is-down.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="0002-s3c24xx_ts-report-touch-only-when-stylus-is-down.patch"

=46rom 3edbe60fdb0cd2c2d91046557fcd9ad4f8c3b69d Mon Sep 17 00:00:00 2001
=46rom: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Fri, 19 Feb 2010 11:48:56 +0200
Subject: [PATCH 2/4] s3c24xx_ts: report touch only when stylus is down

By default, driver reports touches when it gots (1 << ts.shift)
samples, even if stylus is up. This behavior looks wrong to me.
Patch makes driver to report touches only when stylus is down.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
=2D--
 drivers/input/touchscreen/s3c2410_ts.c |   30 ++++++++++++++++------------=
=2D-
 1 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchsc=
reen/s3c2410_ts.c
index 6386b44..14afa0e 100644
=2D-- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -128,27 +128,29 @@ static void touch_timer_fire(unsigned long data)
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
=2D		ts.xp =3D 0;
=2D		ts.yp =3D 0;
=2D		ts.count =3D 0;
=2D	}
+			ts.xp =3D 0;
+			ts.yp =3D 0;
+			ts.count =3D 0;
+		}
=20
=2D	if (down) {
 		s3c_adc_start(ts.client, 0, 1 << ts.shift);
 	} else {
+		ts.xp =3D 0;
+		ts.yp =3D 0;
 		ts.count =3D 0;
=20
 		input_report_key(ts.input, BTN_TOUCH, 0);
=2D-=20
1.7.0


--Boundary-01=_jGmfLo4gCpfcCJd--

--nextPart633305886.vjo6a6FFj1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkt+YagACgkQRM6pQpltKE6zqgCfclX/GX9vmmMO4hiyHuKhfECK
PtsAniDP/y9OX6GJ4tUEhCMopsr/zIF/
=BMM6
-----END PGP SIGNATURE-----

--nextPart633305886.vjo6a6FFj1--
