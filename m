From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH 4/4] input: mc13783: Add MC13892 support
Date: Mon, 10 Feb 2014 08:22:28 +0400
Message-ID: <1392006148-10417-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp32.i.mail.ru ([94.100.177.92]:35107 "EHLO smtp32.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbaBJEWg (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 9 Feb 2014 23:22:36 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Alexander Shiyan <shc_work@mail.ru>

This patch adds support for MC13892 PMIC to mc13783-pwrbutton driver.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/input/misc/Kconfig             | 4 ++--
 drivers/input/misc/mc13783-pwrbutton.c | 8 ++++++++
 include/linux/mfd/mc13892.h            | 4 ++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 7904ab0..3d91660 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -167,10 +167,10 @@ config INPUT_MAX8997_HAPTIC
 	  module will be called max8997-haptic.
 
 config INPUT_MC13783_PWRBUTTON
-	tristate "MC13783 ON buttons"
+	tristate "MC13783/MC13892 ON buttons"
 	depends on MFD_MC13XXX
 	help
-	  Support the ON buttons of MC13783 PMIC as an input device
+	  Support the ON buttons of MC13783/MC13892 PMIC as an input device
 	  reporting power button status.
 
 	  To compile this driver as a module, choose M here: the module
diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/misc/mc13783-pwrbutton.c
index f9e2bfb..03308b0 100644
--- a/drivers/input/misc/mc13783-pwrbutton.c
+++ b/drivers/input/misc/mc13783-pwrbutton.c
@@ -25,6 +25,7 @@
 #include <linux/input.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/mc13783.h>
+#include <linux/mfd/mc13892.h>
 
 struct mc13xxx_button_def {
 	unsigned int	irq;
@@ -175,8 +176,15 @@ static const struct mc13xxx_pwrb_devtype mc13783_pwrb_devtype = {
 	.btn_def[2] = { MC13783_IRQ_ONOFD3, BIT(5), },
 };
 
+static const struct mc13xxx_pwrb_devtype mc13892_pwrb_devtype = {
+	.btn_def[0] = { MC13892_IRQ_ONOFD1, BIT(3), },
+	.btn_def[1] = { MC13892_IRQ_ONOFD2, BIT(4), },
+	.btn_def[2] = { MC13892_IRQ_ONOFD3, BIT(2), },
+};
+
 static const struct platform_device_id mc13xxx_pwrbutton_id_table[] = {
 	{ "mc13783-pwrbutton", (kernel_ulong_t)&mc13783_pwrb_devtype },
+	{ "mc13892-pwrbutton", (kernel_ulong_t)&mc13892_pwrb_devtype },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, mc13xxx_pwrbutton_id_table);
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
1.8.3.2

