From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] Add resources description for s3c24xx ts driver
Date: Thu, 18 Feb 2010 16:01:14 +0200
Message-ID: <201002181601.20625.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12798691.DSCWBu8TmT";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:53376 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756734Ab0BROBn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Feb 2010 09:01:43 -0500
Received: by fg-out-1718.google.com with SMTP id 19so715128fgg.1
        for <linux-input@vger.kernel.org>; Thu, 18 Feb 2010 06:01:41 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org

--nextPart12798691.DSCWBu8TmT
Content-Type: multipart/mixed;
  boundary="Boundary-01=_rgUfLs2vEK8aYe5"
Content-Transfer-Encoding: 7bit


--Boundary-01=_rgUfLs2vEK8aYe5
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=46ollowing patch adds resource description for s3c24xx ts driver.
Without this patch driver fails to initialize with "no resource for interru=
pt"=20
message.

Anyway, even with this patch driver stops reporting events after few presse=
s,=20
I'll investigate on it later.

Btw, does this driver work at least for anyone?

Regards
Vasily

--Boundary-01=_rgUfLs2vEK8aYe5
Content-Type: text/x-patch;
  charset="us-ascii";
  name="0001-Add-resources-description-for-s3c24xx-ts-driver.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="0001-Add-resources-description-for-s3c24xx-ts-driver.patch"

=46rom e92886de877deefed647d4313d2e07fe1b5307d6 Mon Sep 17 00:00:00 2001
=46rom: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Thu, 18 Feb 2010 15:53:50 +0200
Subject: [PATCH] Add resources description for s3c24xx ts driver

Otherwise driver fails during initialization.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
=2D--
 arch/arm/plat-s3c24xx/devs.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index 7f686a3..83c1507 100644
=2D-- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -185,9 +185,27 @@ void __init s3c24xx_fb_set_platdata(struct s3c2410fb_m=
ach_info *pd)
 }
=20
 /* Touchscreen */
+
+static struct resource s3c_ts_resource[] =3D {
+	[0] =3D {
+		.start =3D S3C24XX_PA_ADC,
+		.end   =3D S3C24XX_PA_ADC + S3C24XX_SZ_ADC - 1,
+		.flags =3D IORESOURCE_MEM,
+	},
+	[1] =3D {
+		.start =3D IRQ_TC,
+		.end   =3D IRQ_TC,
+		.flags =3D IORESOURCE_IRQ,
+	},
+
+};
+
 struct platform_device s3c_device_ts =3D {
 	.name		  =3D "s3c2410-ts",
 	.id		  =3D -1,
+	.dev.parent	=3D &s3c_device_adc.dev,
+	.num_resources	  =3D ARRAY_SIZE(s3c_ts_resource),
+	.resource	  =3D s3c_ts_resource,
 };
 EXPORT_SYMBOL(s3c_device_ts);
=20
=2D-=20
1.7.0


--Boundary-01=_rgUfLs2vEK8aYe5--

--nextPart12798691.DSCWBu8TmT
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEABECAAYFAkt9SDAACgkQRM6pQpltKE6iQQCfcDEENyav7Zfn9rzU4j975jKy
odAAoOSw/8GeNqlnOvlHWPKKsdpiyRJU
=IRsf
-----END PGP SIGNATURE-----

--nextPart12798691.DSCWBu8TmT--
