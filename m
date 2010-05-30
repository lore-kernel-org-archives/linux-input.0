From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v2 2/5] ARM: S5PV210: Add keypad device helpers
Date: Sun, 30 May 2010 12:06:21 +0900
Message-ID: <1275188784-23395-2-git-send-email-jy0922.shim@samsung.com>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, kyungmin.park@samsung.com, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

This patch adds the keypad device platform helpers for S5PV210 cpu.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig            |    5 ++++
 arch/arm/mach-s5pv210/Makefile           |    1 +
 arch/arm/mach-s5pv210/include/mach/map.h |    3 ++
 arch/arm/mach-s5pv210/setup-keypad.c     |   34 ++++++++++++++++++++++++++++++
 4 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-keypad.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 7e2e1eb..04d3992 100644
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
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 9f4c368..17687f0 100644
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
index 0000000..f51bf8d
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
+	/* Set all the necessary GPH3 pins to special-function 3 */
+	end = S5PV210_GPH3(rows);
+	for (gpio = S5PV210_GPH3(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	/* Set all the necessary GPH2 pins to special-function 3 */
+	end = S5PV210_GPH2(cols);
+	for (gpio = S5PV210_GPH2(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+}
-- 
1.7.0.4
