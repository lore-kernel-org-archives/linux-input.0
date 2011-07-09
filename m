From: =?utf-8?q?Philippe=20R=C3=A9tornaz?= <philippe.retornaz@epfl.ch>
Subject: [PATCH 3/3] mc13xxx: implicitly enable leds and buttons
Date: Sun, 10 Jul 2011 01:06:36 +0200
Message-ID: <1310252796-10596-4-git-send-email-philippe.retornaz@epfl.ch>
References: <1310252796-10596-1-git-send-email-philippe.retornaz@epfl.ch>
 <1310252796-10596-2-git-send-email-philippe.retornaz@epfl.ch>
 <1310252796-10596-3-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp0.epfl.ch ([128.178.224.219]:44269 "HELO smtp0.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754888Ab1GIWhe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 9 Jul 2011 18:37:34 -0400
In-Reply-To: <1310252796-10596-3-git-send-email-philippe.retornaz@epfl.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: s.hauer@pengutronix.de
Cc: linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, linux-input@vger.kernel.org, broonie@opensource.wolfsonmicro.com, u.kleine-koenig@pengutronix.de, philippe.retornaz@epfl.ch

The leds and buttons subdevices cannot be used without additional
platform data.

Use the presence of the platform data to enable the device instead
of an additional flag.

Signed-off-by: Philippe R=C3=A9tornaz <philippe.retornaz@epfl.ch>
---
 arch/arm/mach-imx/mach-mx31moboard.c |    2 +-
 drivers/mfd/mc13xxx-core.c           |    4 ++--
 include/linux/mfd/mc13783.h          |    1 -
 include/linux/mfd/mc13xxx.h          |    2 --
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-imx/mach-mx31moboard.c b/arch/arm/mach-imx/m=
ach-mx31moboard.c
index 447143b..c4cd6b8 100644
--- a/arch/arm/mach-imx/mach-mx31moboard.c
+++ b/arch/arm/mach-imx/mach-mx31moboard.c
@@ -279,7 +279,7 @@ static struct mc13xxx_platform_data moboard_pmic =3D=
 {
 	.leds =3D &moboard_leds,
 	.buttons =3D &moboard_buttons,
 	.flags =3D MC13XXX_USE_REGULATOR | MC13XXX_USE_RTC |
-		MC13XXX_USE_ADC | MC13XXX_USE_LED | MC13XXX_USE_BUTTON,
+		MC13XXX_USE_ADC,
 };
=20
 static struct spi_board_info moboard_spi_board_info[] __initdata =3D {
diff --git a/drivers/mfd/mc13xxx-core.c b/drivers/mfd/mc13xxx-core.c
index 44edf78..130781f 100644
--- a/drivers/mfd/mc13xxx-core.c
+++ b/drivers/mfd/mc13xxx-core.c
@@ -774,11 +774,11 @@ err_revision:
 	if (pdata->flags & MC13XXX_USE_TOUCHSCREEN)
 		mc13xxx_add_subdevice(mc13xxx, "%s-ts");
=20
-	if (pdata->flags & MC13XXX_USE_LED)
+	if (pdata->leds)
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-led",
 				pdata->leds, sizeof(*pdata->leds));
=20
-	if (pdata->flags & MC13XXX_USE_BUTTON)
+	if (pdata->buttons)
 		mc13xxx_add_subdevice_pdata(mc13xxx, "%s-pwrbutton",
 				pdata->buttons, sizeof(*pdata->buttons));
=20
diff --git a/include/linux/mfd/mc13783.h b/include/linux/mfd/mc13783.h
index bd4fbac..61dca4c 100644
--- a/include/linux/mfd/mc13783.h
+++ b/include/linux/mfd/mc13783.h
@@ -114,7 +114,6 @@ static inline int mc13783_irq_ack(struct mc13783 *m=
c13783, int irq)
 #define MC13783_USE_ADC		MC13XXX_USE_ADC
 #define MC13783_USE_RTC		MC13XXX_USE_RTC
 #define MC13783_USE_REGULATOR	MC13XXX_USE_REGULATOR
-#define MC13783_USE_LED		MC13XXX_USE_LED
=20
 #define MC13783_ADC_MODE_TS		1
 #define MC13783_ADC_MODE_SINGLE_CHAN	2
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index 22d8930..6c4b854 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -159,8 +159,6 @@ struct mc13xxx_platform_data {
 #define MC13XXX_USE_ADC		(1 << 2)
 #define MC13XXX_USE_RTC		(1 << 3)
 #define MC13XXX_USE_REGULATOR	(1 << 4)
-#define MC13XXX_USE_LED		(1 << 5)
-#define MC13XXX_USE_BUTTON	(1 << 6)
 	unsigned int flags;
=20
 	struct mc13xxx_regulator_platform_data regulators;
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
