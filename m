From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v2 2/3] input: mc13783: Add MC13892 support
Date: Sat, 13 Jul 2013 08:25:50 +0400
Message-ID: <1373689551-24375-2-git-send-email-shc_work@mail.ru>
References: <1373689551-24375-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp2.mail.ru ([94.100.176.130]:44357 "EHLO smtp2.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750771Ab3GME0U (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 13 Jul 2013 00:26:20 -0400
In-Reply-To: <1373689551-24375-1-git-send-email-shc_work@mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-input@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Sascha Hauer <kernel@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/input/misc/Kconfig             |  6 +++---
 drivers/input/misc/mc13783-pwrbutton.c | 10 +++++++++-
 include/linux/mfd/mc13892.h            |  4 ++++
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 0b541cd..0d83653 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -167,10 +167,10 @@ config INPUT_MAX8997_HAPTIC
 	  module will be called max8997-haptic.
 
 config INPUT_MC13783_PWRBUTTON
-	tristate "MC13783 ON buttons"
-	depends on MFD_MC13783
+	tristate "MC13783/MC13892 ON buttons"
+	depends on MFD_MC13XXX
 	help
-	  Support the ON buttons of MC13783 PMIC as an input device
+	  Support the ON buttons of MC13783/MC13892 PMIC as an input device
 	  reporting power button status.
 
 	  To compile this driver as a module, choose M here: the module
diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/misc/mc13783-pwrbutton.c
index 33613ca..855d576 100644
--- a/drivers/input/misc/mc13783-pwrbutton.c
+++ b/drivers/input/misc/mc13783-pwrbutton.c
@@ -26,6 +26,7 @@
 #include <linux/input.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/mc13783.h>
+#include <linux/mfd/mc13892.h>
 
 struct mc13xxx_button_def {
 	unsigned int	irq;
@@ -194,8 +195,15 @@ static const struct mc13xxx_pwrb_devtype mc13783_pwrb_devtype = {
 	.btn_def[2] = { MC13783_IRQ_ONOFD3, BIT(5) }
 };
 
+static const struct mc13xxx_pwrb_devtype mc13892_pwrb_devtype = {
+	.btn_def[0] = { MC13892_IRQ_ONOFD1, BIT(3) },
+	.btn_def[1] = { MC13892_IRQ_ONOFD2, BIT(4) },
+	.btn_def[2] = { MC13892_IRQ_ONOFD3, BIT(2) }
+};
+
 static const struct platform_device_id mc13xxx_pwrbutton_id_table[] = {
 	{ "mc13783-pwrbutton", (kernel_ulong_t)&mc13783_pwrb_devtype },
+	{ "mc13892-pwrbutton", (kernel_ulong_t)&mc13892_pwrb_devtype },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, mc13xxx_pwrbutton_id_table);
@@ -209,6 +217,6 @@ static struct platform_driver mc13xxx_pwrbutton_driver = {
 };
 module_platform_driver_probe(mc13xxx_pwrbutton_driver, mc13xxx_pwrbutton_probe);
 
-MODULE_DESCRIPTION("MC13783 Power Button");
+MODULE_DESCRIPTION("MC13XXX Power Button");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Philippe Retornaz");
diff --git a/include/linux/mfd/mc13892.h b/include/linux/mfd/mc13892.h
index a00f2be..bdc3baf 100644
--- a/include/linux/mfd/mc13892.h
+++ b/include/linux/mfd/mc13892.h
@@ -36,4 +36,8 @@
 #define MC13892_PWGT2SPI	22
 #define MC13892_VCOINCELL	23
 
+#define MC13892_IRQ_ONOFD3	26
+#define MC13892_IRQ_ONOFD1	27
+#define MC13892_IRQ_ONOFD2	28
+
 #endif
-- 
1.8.1.5

