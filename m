From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 2/8] ARM: S3C64XX: Add touchscreen platform device definition
Date: Wed, 19 May 2010 07:12:16 +0100
Message-ID: <1274249542-28795-3-git-send-email-ben-linux@fluff.org>
References: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:57024 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400Ab0ESGMd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 02:12:33 -0400
In-Reply-To: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: kgene.kim@samsung.com, ch.naveen@samsubng.com, dmitry.torokhov@gmail.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, Ben Dooks <ben-linux@fluff.org>

From: Maurus Cuelenaere <mcuelenaere@gmail.com>

This patch adds the touchscreen platform device definition for S3C64XX boards.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c64xx/Makefile |    1 +
 arch/arm/mach-s3c64xx/dev-ts.c |   61 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/Kconfig  |    6 ++++
 3 files changed, 68 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/dev-ts.c

diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index d78c3dd..a10f1fc 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -58,3 +58,4 @@ obj-$(CONFIG_MACH_HMT)		+= mach-hmt.o
 obj-y				+= dev-uart.o
 obj-y				+= dev-audio.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
+obj-$(CONFIG_S3C64XX_DEV_TS)	+= dev-ts.o
diff --git a/arch/arm/mach-s3c64xx/dev-ts.c b/arch/arm/mach-s3c64xx/dev-ts.c
new file mode 100644
index 0000000..17cc793
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/dev-ts.c
@@ -0,0 +1,61 @@
+/* linux/arch/arm/mach-s3c64xx/dev-ts.c
+ *
+ * Copyright (c) 2008 Simtec Electronics
+ *	http://armlinux.simtec.co.uk/
+ *	Ben Dooks <ben@simtec.co.uk>, <ben-linux@fluff.org>
+ *
+ * Adapted by Maurus Cuelenaere for s3c64xx
+ *
+ * S3C64XX series device definition for touchscreen device
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/devs.h>
+#include <plat/ts.h>
+
+static struct resource s3c_ts_resource[] = {
+	[0] = {
+		.start = S3C64XX_PA_ADC,
+		.end   = S3C64XX_PA_ADC + SZ_256 - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_TC,
+		.end   = IRQ_TC,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_ts = {
+	.name		= "s3c64xx-ts",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(s3c_ts_resource),
+	.resource	= s3c_ts_resource,
+};
+
+void __init s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *pd)
+{
+	struct s3c2410_ts_mach_info *npd;
+
+	if (!pd) {
+		printk(KERN_ERR "%s: no platform data\n", __func__);
+		return;
+	}
+
+	npd = kmemdup(pd, sizeof(struct s3c2410_ts_mach_info), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+
+	s3c_device_ts.dev.platform_data = npd;
+}
+EXPORT_SYMBOL(s3c24xx_ts_set_platdata);
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 64ab53c..1ea9389 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -206,6 +206,12 @@ config S3C64XX_DEV_SPI
 	  Compile in platform device definitions for S3C64XX's type
 	  SPI controllers.
 
+config S3C64XX_DEV_TS
+	bool
+	help
+	    Common in platform device definitions for S3C64XX touchscreen
+	    device
+
 # DMA
 
 config S3C_DMA
-- 
1.6.3.3

