From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 3/6] mc13xxx: remove obsolete leds and regualtors flags
Date: Thu, 21 Jul 2011 20:04:20 +0200
Message-ID: <1311271463-4356-4-git-send-email-philippe.retornaz@epfl.ch>
References: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch>
 <1311271463-4356-2-git-send-email-philippe.retornaz@epfl.ch>
 <1311271463-4356-3-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3.epfl.ch ([128.178.224.226]:36362 "HELO smtp3.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751949Ab1GUSEt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2011 14:04:49 -0400
In-Reply-To: <1311271463-4356-3-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, philippe.retornaz@epfl.ch

Signed-off-by: Philippe R=C3=A9tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-imx/mach-mx27_3ds.c    |    1 -
 arch/arm/mach-imx/mach-mx31_3ds.c    |    2 +-
 arch/arm/mach-imx/mach-mx31lite.c    |    3 +--
 arch/arm/mach-imx/mach-mx31moboard.c |    3 +--
 arch/arm/mach-imx/mach-pcm038.c      |    3 +--
 arch/arm/mach-mx5/mx51_efika.c       |    2 +-
 6 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx27_3ds.c b/arch/arm/mach-imx/mach=
-mx27_3ds.c
index 6e1accf..8cd507d 100644
--- a/arch/arm/mach-imx/mach-mx27_3ds.c
+++ b/arch/arm/mach-imx/mach-mx27_3ds.c
@@ -238,7 +238,6 @@ static struct mc13xxx_platform_data mc13783_pdata =3D=
 {
 		.num_regulators =3D ARRAY_SIZE(mx27_3ds_regulators),
=20
 	},
-	.flags  =3D MC13783_USE_REGULATOR,
 };
=20
 /* SPI */
diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach=
-mx31_3ds.c
index 9b98244..7978f58 100644
--- a/arch/arm/mach-imx/mach-mx31_3ds.c
+++ b/arch/arm/mach-imx/mach-mx31_3ds.c
@@ -496,7 +496,7 @@ static struct mc13xxx_platform_data mc13783_pdata =3D=
 {
 		.regulators =3D mx31_3ds_regulators,
 		.num_regulators =3D ARRAY_SIZE(mx31_3ds_regulators),
 	},
-	.flags  =3D MC13783_USE_REGULATOR | MC13783_USE_TOUCHSCREEN,
+	.flags  =3D MC13783_USE_TOUCHSCREEN,
 };
=20
 /* SPI */
diff --git a/arch/arm/mach-imx/mach-mx31lite.c b/arch/arm/mach-imx/mach=
-mx31lite.c
index ac9b4ca..ae99cae 100644
--- a/arch/arm/mach-imx/mach-mx31lite.c
+++ b/arch/arm/mach-imx/mach-mx31lite.c
@@ -112,8 +112,7 @@ static const struct spi_imx_master spi1_pdata __ini=
tconst =3D {
 };
=20
 static struct mc13xxx_platform_data mc13783_pdata __initdata =3D {
-	.flags  =3D MC13XXX_USE_RTC |
-		  MC13XXX_USE_REGULATOR,
+	.flags  =3D MC13XXX_USE_RTC,
 };
=20
 static struct spi_board_info mc13783_spi_dev __initdata =3D {
diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/m=
ach-mx31moboard.c
index 12ee755..579ca1f 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -270,8 +270,7 @@ static struct mc13xxx_platform_data moboard_pmic =3D=
 {
 		.num_regulators =3D ARRAY_SIZE(moboard_regulators),
 	},
 	.leds =3D &moboard_leds,
-	.flags =3D MC13XXX_USE_REGULATOR | MC13XXX_USE_RTC |
-		MC13XXX_USE_ADC | MC13XXX_USE_LED,
+	.flags =3D MC13XXX_USE_RTC | MC13XXX_USE_ADC,
 };
=20
 static struct spi_board_info moboard_spi_board_info[] __initdata =3D {
diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-p=
cm038.c
index 853bb87..70aaa7d 100644
--- a/arch/arm/mach-imx/mach-pcm038.c
+++ b/arch/arm/mach-imx/mach-pcm038.c
@@ -266,8 +266,7 @@ static struct mc13xxx_platform_data pcm038_pmic =3D=
 {
 		.regulators =3D pcm038_regulators,
 		.num_regulators =3D ARRAY_SIZE(pcm038_regulators),
 	},
-	.flags =3D MC13783_USE_ADC | MC13783_USE_REGULATOR |
-		 MC13783_USE_TOUCHSCREEN,
+	.flags =3D MC13783_USE_ADC | MC13783_USE_TOUCHSCREEN,
 };
=20
 static struct spi_board_info pcm038_spi_board_info[] __initdata =3D {
diff --git a/arch/arm/mach-mx5/mx51_efika.c b/arch/arm/mach-mx5/mx51_ef=
ika.c
index 1105ef3..e2e4096 100644
--- a/arch/arm/mach-mx5/mx51_efika.c
+++ b/arch/arm/mach-mx5/mx51_efika.c
@@ -567,7 +567,7 @@ static struct mc13xxx_regulator_init_data mx51_efik=
a_regulators[] =3D {
 };
=20
 static struct mc13xxx_platform_data mx51_efika_mc13892_data =3D {
-	.flags =3D MC13XXX_USE_RTC | MC13XXX_USE_REGULATOR,
+	.flags =3D MC13XXX_USE_RTC,
 	.regulators =3D {
 		.num_regulators =3D ARRAY_SIZE(mx51_efika_regulators),
 		.regulators =3D mx51_efika_regulators,
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
