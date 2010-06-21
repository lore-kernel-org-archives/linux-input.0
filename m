From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v5 2/3] ARM: S5PV210: Add keypad device helpers
Date: Mon, 21 Jun 2010 15:26:44 +0900
Message-ID: <1277101605-2435-2-git-send-email-jy0922.shim@samsung.com>
References: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:40050 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770Ab0FUG1A (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 02:27:00 -0400
In-reply-to: <1277101605-2435-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, ben-linux@fluff.org, dmitry.torokhov@gmail.com, kyungmin.park@samsung.com, kgene.kim@samsung.com

This patch adds the keypad device platform helpers for S5PV210 cpu.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig                    |    5 +++
 arch/arm/mach-s5pv210/Makefile                   |    1 +
 arch/arm/mach-s5pv210/cpu.c                      |    4 ++
 arch/arm/mach-s5pv210/include/mach/map.h         |    3 ++
 arch/arm/mach-s5pv210/setup-keypad.c             |   34 ++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/keypad-core.h |   31 ++++++++++++++++++++
 6 files changed, 78 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-keypad.c
 create mode 100644 arch/arm/plat-samsung/include/plat/keypad-core.h

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 0761eac..692d01c 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -32,6 +32,11 @@ config S5PV210_SETUP_FB_24BPP
 	help
           Common setup code for S5PV210 with an 24bpp RGB display helper.
 
+config S5PV210_SETUP_KEYPAD
+	bool
+	help
+	  Common setup code for keypad.
+
 config S5PV210_SETUP_SDHCI
         bool
         select S5PV210_SETUP_SDHCI_GPIO
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index 30be9a6..aae592a 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -31,5 +31,6 @@ obj-$(CONFIG_S5PC110_DEV_ONENAND) += dev-onenand.o
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
 obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
+obj-$(CONFIG_S5PV210_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
 obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 411a4a9..94c632b 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -33,6 +33,7 @@
 #include <plat/clock.h>
 #include <plat/s5pv210.h>
 #include <plat/iic-core.h>
+#include <plat/keypad-core.h>
 #include <plat/sdhci.h>
 
 /* Initial IO mappings */
@@ -91,6 +92,9 @@ void __init s5pv210_map_io(void)
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
 	s3c_i2c2_setname("s3c2440-i2c");
+
+	/* Use s5pv210-keypad instead of samsung-keypad */
+	samsung_keypad_setname("s5pv210-keypad");
 }
 
 void __init s5pv210_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 34eb168..e2f6e2a 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -32,6 +32,8 @@
 #define S5PV210_PA_SPI0		0xE1300000
 #define S5PV210_PA_SPI1		0xE1400000
 
+#define S5PV210_PA_KEYPAD	(0xE1600000)
+
 #define S5PV210_PA_IIC0		(0xE1800000)
 #define S5PV210_PA_IIC1		(0xFAB00000)
 #define S5PV210_PA_IIC2		(0xE1A00000)
@@ -104,5 +106,6 @@
 #define S3C_PA_WDT		S5PV210_PA_WATCHDOG
 
 #define SAMSUNG_PA_ADC		S5PV210_PA_ADC
+#define SAMSUNG_PA_KEYPAD	S5PV210_PA_KEYPAD
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv210/setup-keypad.c b/arch/arm/mach-s5pv210/setup-keypad.c
new file mode 100644
index 0000000..37b2790
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-keypad.c
@@ -0,0 +1,34 @@
+/*
+ * linux/arch/arm/mach-s5pv210/setup-keypad.c
+ *
+ * Copyright (C) 2010 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#include <linux/gpio.h>
+#include <plat/gpio-cfg.h>
+
+void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
+{
+	unsigned int gpio, end;
+
+	/* Set all the necessary GPH3 pins to special-function 3: KP_ROW[x] */
+	end = S5PV210_GPH3(rows);
+	for (gpio = S5PV210_GPH3(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	/* Set all the necessary GPH2 pins to special-function 3: KP_COL[x] */
+	end = S5PV210_GPH2(cols);
+	for (gpio = S5PV210_GPH2(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+}
diff --git a/arch/arm/plat-samsung/include/plat/keypad-core.h b/arch/arm/plat-samsung/include/plat/keypad-core.h
new file mode 100644
index 0000000..d513e1b
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/keypad-core.h
@@ -0,0 +1,31 @@
+/*
+ * linux/arch/arm/plat-samsung/include/plat/keypad-core.h
+ *
+ * Copyright (C) 2010 Samsung Electronics Co.Ltd
+ * Author: Joonyoung Shim <jy0922.shim@samsung.com>
+ *
+ * Samsung keypad controller core function
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ */
+
+#ifndef __ASM_ARCH_KEYPAD_CORE_H
+#define __ASM_ARCH_KEYPAD_CORE_H
+
+/* These function are only for use with the core support code, such as
+ * the cpu specific initialisation code
+ */
+
+/* re-define device name depending on support. */
+static inline void samsung_keypad_setname(char *name)
+{
+#ifdef CONFIG_SAMSUNG_DEV_KEYPAD
+	samsung_device_keypad.name = name;
+#endif
+}
+
+#endif /* __ASM_ARCH_KEYPAD_CORE_H */
-- 
1.7.0.4

