From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 2/3] mx31moboard: Add MC13783 power button support
Date: Sun, 10 Jul 2011 01:06:35 +0200
Message-ID: <1310252796-10596-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1310252796-10596-1-git-send-email-philippe.retornaz@epfl.ch>
 <1310252796-10596-2-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.219]:44260 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754986Ab1GIWhd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 9 Jul 2011 18:37:33 -0400
In-Reply-To: <1310252796-10596-2-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, philippe.retornaz@epfl.ch

Add the power-on button on mx31moboard using MC13783 PMIC.

Signed-off-by: Philippe R=C3=A9tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-imx/mach-mx31moboard.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/m=
ach-mx31moboard.c
index 12ee755..447143b 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/types.h>
 #include <linux/memblock.h>
+#include <linux/input.h>
=20
 #include <linux/usb/otg.h>
 #include <linux/usb/ulpi.h>
@@ -264,14 +265,21 @@ static struct mc13783_leds_platform_data moboard_=
leds =3D {
 	.tc2_period =3D MC13783_LED_PERIOD_10MS,
 };
=20
+static struct mc13783_buttons_platform_data moboard_buttons =3D {
+	.b1on_flags =3D MC13783_BUTTON_DBNC_750MS | MC13783_BUTTON_ENABLE |
+			MC13783_BUTTON_POL_INVERT,
+	.b1on_key =3D KEY_POWER,
+};
+
 static struct mc13xxx_platform_data moboard_pmic =3D {
 	.regulators =3D {
 		.regulators =3D moboard_regulators,
 		.num_regulators =3D ARRAY_SIZE(moboard_regulators),
 	},
 	.leds =3D &moboard_leds,
+	.buttons =3D &moboard_buttons,
 	.flags =3D MC13XXX_USE_REGULATOR | MC13XXX_USE_RTC |
-		MC13XXX_USE_ADC | MC13XXX_USE_LED,
+		MC13XXX_USE_ADC | MC13XXX_USE_LED | MC13XXX_USE_BUTTON,
 };
=20
 static struct spi_board_info moboard_spi_board_info[] __initdata =3D {
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
