From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 3/8] ARM: SAMSUNG: Implements cfg_gpio function for Samsung touchscreen
Date: Wed, 19 May 2010 07:12:17 +0100
Message-ID: <1274249542-28795-4-git-send-email-ben-linux@fluff.org>
References: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:56992 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab0ESGMZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 02:12:25 -0400
In-Reply-To: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: kgene.kim@samsung.com, ch.naveen@samsubng.com, dmitry.torokhov@gmail.com, Naveen Krishna <ch.naveen@samsung.com>, Ben Dooks <ben-linux@fluff.org>

From: Naveen Krishna <ch.naveen@samsung.com>

This patch implements cfg_gpio function for Samsung touchscreen.
And also modifies the H1940 machine respectively.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/Kconfig           |    1 +
 arch/arm/mach-s3c2410/mach-h1940.c      |    1 +
 arch/arm/plat-s3c24xx/Kconfig           |    5 ++++
 arch/arm/plat-s3c24xx/Makefile          |    1 +
 arch/arm/plat-s3c24xx/setup-ts.c        |   34 +++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/ts.h |    4 +++
 6 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s3c24xx/setup-ts.c

diff --git a/arch/arm/mach-s3c2410/Kconfig b/arch/arm/mach-s3c2410/Kconfig
index a4c0b3f..7245a55 100644
--- a/arch/arm/mach-s3c2410/Kconfig
+++ b/arch/arm/mach-s3c2410/Kconfig
@@ -77,6 +77,7 @@ config ARCH_H1940
 	select PM_H1940 if PM
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_NAND
+	select S3C2410_SETUP_TS
 	help
 	  Say Y here if you are using the HP IPAQ H1940
 
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index b1f7dbb..779b45b 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -146,6 +146,7 @@ static struct s3c2410_ts_mach_info h1940_ts_cfg __initdata = {
 		.delay = 10000,
 		.presc = 49,
 		.oversampling_shift = 2,
+		.cfg_gpio = s3c24xx_ts_cfg_gpio,
 };
 
 /**
diff --git a/arch/arm/plat-s3c24xx/Kconfig b/arch/arm/plat-s3c24xx/Kconfig
index 3ce8f01..984bf66 100644
--- a/arch/arm/plat-s3c24xx/Kconfig
+++ b/arch/arm/plat-s3c24xx/Kconfig
@@ -164,4 +164,9 @@ config S3C24XX_SIMTEC_AUDIO
 	help
 	  Add audio devices for common Simtec S3C24XX boards
 
+config S3C2410_SETUP_TS
+	bool
+	help
+	  Compile in platform device definition for Samsung TouchScreen.
+
 endif
diff --git a/arch/arm/plat-s3c24xx/Makefile b/arch/arm/plat-s3c24xx/Makefile
index 44aea88..c2064c3 100644
--- a/arch/arm/plat-s3c24xx/Makefile
+++ b/arch/arm/plat-s3c24xx/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_S3C2410_CPUFREQ_UTILS) += s3c2410-cpufreq-utils.o
 
 # device specific setup and/or initialisation
 obj-$(CONFIG_ARCH_S3C2410)	+= setup-i2c.o
+obj-$(CONFIG_S3C2410_SETUP_TS)	+= setup-ts.o
 
 # SPI gpio central GPIO functions
 
diff --git a/arch/arm/plat-s3c24xx/setup-ts.c b/arch/arm/plat-s3c24xx/setup-ts.c
new file mode 100644
index 0000000..ed26386
--- /dev/null
+++ b/arch/arm/plat-s3c24xx/setup-ts.c
@@ -0,0 +1,34 @@
+/* linux/arch/arm/plat-s3c24xx/setup-ts.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *                     http://www.samsung.com/
+ *
+ * Based on S3C24XX setup for i2c device
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/gpio.h>
+
+struct platform_device; /* don't need the contents */
+
+#include <mach/hardware.h>
+#include <mach/regs-gpio.h>
+
+/**
+ * s3c24xx_ts_cfg_gpio - configure gpio for s3c2410 systems
+ *
+ * Configure the GPIO for the S3C2410 system, where we have external FETs
+ * connected to the device (later systems such as the S3C2440 integrate
+ * these into the device).
+ */
+void s3c24xx_ts_cfg_gpio(struct platform_device *dev)
+{
+	s3c2410_gpio_cfgpin(S3C2410_GPG(12), S3C2410_GPG12_XMON);
+	s3c2410_gpio_cfgpin(S3C2410_GPG(13), S3C2410_GPG13_nXPON);
+	s3c2410_gpio_cfgpin(S3C2410_GPG(14), S3C2410_GPG14_YMON);
+	s3c2410_gpio_cfgpin(S3C2410_GPG(15), S3C2410_GPG15_nYPON);
+}
diff --git a/arch/arm/plat-samsung/include/plat/ts.h b/arch/arm/plat-samsung/include/plat/ts.h
index 8a51675..26fdb22 100644
--- a/arch/arm/plat-samsung/include/plat/ts.h
+++ b/arch/arm/plat-samsung/include/plat/ts.h
@@ -14,8 +14,12 @@ struct s3c2410_ts_mach_info {
        int             delay;
        int             presc;
        int             oversampling_shift;
+	void    (*cfg_gpio)(struct platform_device *dev);
 };
 
 extern void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
 
+/* defined by architecture to configure gpio */
+extern void s3c24xx_ts_cfg_gpio(struct platform_device *dev);
+
 #endif /* __ASM_ARM_TS_H */
-- 
1.6.3.3

