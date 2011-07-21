From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 6/6] mx31moboard: Add MC13783 power button support
Date: Thu, 21 Jul 2011 20:04:23 +0200
Message-ID: <1311271463-4356-7-git-send-email-philippe.retornaz@epfl.ch>
References: <1311271463-4356-1-git-send-email-philippe.retornaz@epfl.ch>
 <1311271463-4356-2-git-send-email-philippe.retornaz@epfl.ch>
 <1311271463-4356-3-git-send-email-philippe.retornaz@epfl.ch>
 <1311271463-4356-4-git-send-email-philippe.retornaz@epfl.ch>
 <1311271463-4356-5-git-send-email-philippe.retornaz@epfl.ch>
 <1311271463-4356-6-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3.epfl.ch ([128.178.224.226]:36400 "HELO smtp3.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751949Ab1GUSEw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jul 2011 14:04:52 -0400
In-Reply-To: <1311271463-4356-6-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, amit.kucheria@canonical.com, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, philippe.retornaz@epfl.ch

Add the power-on button on mx31moboard using MC13783 PMIC.

Signed-off-by: Philippe R=C3=A9tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-imx/mach-mx31moboard.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/m=
ach-mx31moboard.c
index 579ca1f..2a43492 100644
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
@@ -264,12 +265,19 @@ static struct mc13783_leds_platform_data moboard_=
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
 	.flags =3D MC13XXX_USE_RTC | MC13XXX_USE_ADC,
 };
=20
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
