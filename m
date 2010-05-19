From: Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH 1/8] ARM: SAMSUNG: Move mach/ts.h to plat/ts.h
Date: Wed, 19 May 2010 07:12:15 +0100
Message-ID: <1274249542-28795-2-git-send-email-ben-linux@fluff.org>
References: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from trinity.fluff.org ([89.16.178.74]:57026 "EHLO trinity.fluff.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab0ESGMd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 19 May 2010 02:12:33 -0400
In-Reply-To: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: kgene.kim@samsung.com, ch.naveen@samsubng.com, dmitry.torokhov@gmail.com, Maurus Cuelenaere <mcuelenaere@gmail.com>, Ben Dooks <ben-linux@fluff.org>

From: Maurus Cuelenaere <mcuelenaere@gmail.com>

This moves mach-s3c2410/include/mach/ts.h to plat-samsung/include/plat/ts.h in
order to prepare for s3c64xx support in the touchscreen driver.

Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s3c2410/include/mach/ts.h |   21 ---------------------
 arch/arm/mach-s3c2410/mach-h1940.c      |    2 +-
 arch/arm/plat-s3c24xx/devs.c            |    3 +--
 arch/arm/plat-samsung/include/plat/ts.h |   21 +++++++++++++++++++++
 drivers/input/touchscreen/s3c2410_ts.c  |    2 +-
 5 files changed, 24 insertions(+), 25 deletions(-)
 delete mode 100644 arch/arm/mach-s3c2410/include/mach/ts.h
 create mode 100644 arch/arm/plat-samsung/include/plat/ts.h

diff --git a/arch/arm/mach-s3c2410/include/mach/ts.h b/arch/arm/mach-s3c2410/include/mach/ts.h
deleted file mode 100644
index dc36170..0000000
--- a/arch/arm/mach-s3c2410/include/mach/ts.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* linux/include/asm/arch-s3c2410/ts.h
- *
- * Copyright (c) 2005 Arnaud Patard <arnaud.patard@rtp-net.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARM_TS_H
-#define __ASM_ARM_TS_H
-
-struct s3c2410_ts_mach_info {
-       int             delay;
-       int             presc;
-       int             oversampling_shift;
-};
-
-extern void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
-
-#endif /* __ASM_ARM_TS_H */
diff --git a/arch/arm/mach-s3c2410/mach-h1940.c b/arch/arm/mach-s3c2410/mach-h1940.c
index d2a2fad..b1f7dbb 100644
--- a/arch/arm/mach-s3c2410/mach-h1940.c
+++ b/arch/arm/mach-s3c2410/mach-h1940.c
@@ -46,7 +46,6 @@
 #include <mach/h1940.h>
 #include <mach/h1940-latch.h>
 #include <mach/fb.h>
-#include <mach/ts.h>
 #include <plat/udc.h>
 #include <plat/iic.h>
 
@@ -57,6 +56,7 @@
 #include <plat/pll.h>
 #include <plat/pm.h>
 #include <plat/mci.h>
+#include <plat/ts.h>
 
 static struct map_desc h1940_iodesc[] __initdata = {
 	[0] = {
diff --git a/arch/arm/plat-s3c24xx/devs.c b/arch/arm/plat-s3c24xx/devs.c
index cd5b41d..5858373 100644
--- a/arch/arm/plat-s3c24xx/devs.c
+++ b/arch/arm/plat-s3c24xx/devs.c
@@ -39,8 +39,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/regs-spi.h>
-
-#include <mach/ts.h>
+#include <plat/ts.h>
 
 /* Serial port registrations */
 
diff --git a/arch/arm/plat-samsung/include/plat/ts.h b/arch/arm/plat-samsung/include/plat/ts.h
new file mode 100644
index 0000000..8a51675
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/ts.h
@@ -0,0 +1,21 @@
+/* arch/arm/plat-samsung/include/plat/ts.h
+ *
+ * Copyright (c) 2005 Arnaud Patard <arnaud.patard@rtp-net.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARM_TS_H
+#define __ASM_ARM_TS_H
+
+struct s3c2410_ts_mach_info {
+       int             delay;
+       int             presc;
+       int             oversampling_shift;
+};
+
+extern void s3c24xx_ts_set_platdata(struct s3c2410_ts_mach_info *);
+
+#endif /* __ASM_ARM_TS_H */
diff --git a/drivers/input/touchscreen/s3c2410_ts.c b/drivers/input/touchscreen/s3c2410_ts.c
index 98a7d12..a2e1228 100644
--- a/drivers/input/touchscreen/s3c2410_ts.c
+++ b/drivers/input/touchscreen/s3c2410_ts.c
@@ -37,9 +37,9 @@
 
 #include <plat/adc.h>
 #include <plat/regs-adc.h>
+#include <plat/ts.h>
 
 #include <mach/regs-gpio.h>
-#include <mach/ts.h>
 
 #define TSC_SLEEP  (S3C2410_ADCTSC_PULL_UP_DISABLE | S3C2410_ADCTSC_XY_PST(0))
 
-- 
1.6.3.3

