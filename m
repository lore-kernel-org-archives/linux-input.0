From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH 4/4] ARM: S5PC100: Add keypad device to the SMDKC100 board
Date: Tue, 22 Jun 2010 08:43:55 +0900
Message-ID: <1277163835-12439-5-git-send-email-kgene.kim@samsung.com>
References: <1277163835-12439-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1277163835-12439-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org
Cc: ben-linux@fluff.org, dmitry.torokhov@gmail.com, Naveen Krishna Ch <ch.naveen@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch is to support keypad device to the SMDKC100 board.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pc100/Kconfig            |    7 ++++++
 arch/arm/mach-s5pc100/Makefile           |    1 +
 arch/arm/mach-s5pc100/include/mach/map.h |    3 +-
 arch/arm/mach-s5pc100/mach-smdkc100.c    |   24 +++++++++++++++++++++
 arch/arm/mach-s5pc100/setup-keypad.c     |   34 ++++++++++++++++++++++++++++++
 5 files changed, 68 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-s5pc100/setup-keypad.c

diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index b2a11df..a3f5695 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -25,6 +25,11 @@ config S5PC100_SETUP_I2C1
 	help
 	  Common setup code for i2c bus 1.
 
+config S5PC100_SETUP_KEYPAD
+	bool
+	help
+	  Common setup code for KEYPAD GPIO configurations.
+
 config S5PC100_SETUP_SDHCI
 	bool
 	select S5PC100_SETUP_SDHCI_GPIO
@@ -44,8 +49,10 @@ config MACH_SMDKC100
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC1
 	select S3C_DEV_HSMMC2
+	select SAMSUNG_DEV_KEYPAD
 	select S5PC100_SETUP_FB_24BPP
 	select S5PC100_SETUP_I2C1
+	select S5PC100_SETUP_KEYPAD
 	select S5PC100_SETUP_SDHCI
 	help
 	  Machine support for the Samsung SMDKC100
diff --git a/arch/arm/mach-s5pc100/Makefile b/arch/arm/mach-s5pc100/Makefile
index 543f3de..69cfd34 100644
--- a/arch/arm/mach-s5pc100/Makefile
+++ b/arch/arm/mach-s5pc100/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_CPU_S5PC100)	+= dma.o
 
 obj-$(CONFIG_S5PC100_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
 obj-$(CONFIG_S5PC100_SETUP_I2C1)	+= setup-i2c1.o
+obj-$(CONFIG_S5PC100_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_S5PC100_SETUP_SDHCI)	+= setup-sdhci.o
 obj-$(CONFIG_S5PC100_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
 
diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index cadae43..eb57d7f 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -129,10 +129,11 @@
 #define S3C_PA_HSMMC0		S5PC100_PA_HSMMC(0)
 #define S3C_PA_HSMMC1		S5PC100_PA_HSMMC(1)
 #define S3C_PA_HSMMC2		S5PC100_PA_HSMMC(2)
-#define S3C_PA_KEYPAD		S5PC100_PA_KEYPAD
 #define S3C_PA_TSADC		S5PC100_PA_TSADC
 #define S3C_PA_ONENAND		S5PC100_PA_ONENAND
 #define S3C_PA_ONENAND_BUF	S5PC100_PA_ONENAND_BUF
 #define S3C_SZ_ONENAND_BUF	S5PC100_SZ_ONENAND_BUF
 
+#define SAMSUNG_PA_KEYPAD	S5PC100_PA_KEYPAD
+
 #endif /* __ASM_ARCH_C100_MAP_H */
diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index af22f82..d006873 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -22,6 +22,7 @@
 #include <linux/i2c.h>
 #include <linux/fb.h>
 #include <linux/delay.h>
+#include <linux/input.h>
 
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
@@ -42,6 +43,7 @@
 #include <plat/s5pc100.h>
 #include <plat/fb.h>
 #include <plat/iic.h>
+#include <plat/keypad.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PC100_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -149,6 +151,25 @@ static struct s3c_fb_platdata smdkc100_lcd_pdata __initdata = {
 	.setup_gpio	= s5pc100_fb_gpio_setup_24bpp,
 };
 
+static uint32_t smdkc100_keymap[] __initdata = {
+	/* KEY(row, col, keycode) */
+	KEY(0, 3, KEY_1), KEY(0, 4, KEY_2), KEY(0, 5, KEY_3),
+	KEY(0, 6, KEY_4), KEY(0, 7, KEY_5),
+	KEY(1, 3, KEY_A), KEY(1, 4, KEY_B), KEY(1, 5, KEY_C),
+	KEY(1, 6, KEY_D), KEY(1, 7, KEY_E)
+};
+
+static struct matrix_keymap_data smdkc100_keymap_data __initdata = {
+	.keymap		= smdkc100_keymap,
+	.keymap_size	= ARRAY_SIZE(smdkc100_keymap),
+};
+
+static struct samsung_keypad_platdata smdkc100_keypad_data __initdata = {
+	.keymap_data	= &smdkc100_keymap_data,
+	.rows		= 2,
+	.cols		= 8,
+};
+
 static struct platform_device *smdkc100_devices[] __initdata = {
 	&s3c_device_i2c0,
 	&s3c_device_i2c1,
@@ -158,6 +179,7 @@ static struct platform_device *smdkc100_devices[] __initdata = {
 	&s3c_device_hsmmc2,
 	&smdkc100_lcd_powerdev,
 	&s5pc100_device_iis0,
+	&samsung_device_keypad,
 	&s5pc100_device_ac97,
 };
 
@@ -178,6 +200,8 @@ static void __init smdkc100_machine_init(void)
 
 	s3c_fb_set_platdata(&smdkc100_lcd_pdata);
 
+	samsung_keypad_set_platdata(&smdkc100_keypad_data);
+
 	/* LCD init */
 	gpio_request(S5PC100_GPD(0), "GPD");
 	gpio_request(S5PC100_GPH0(6), "GPH0");
diff --git a/arch/arm/mach-s5pc100/setup-keypad.c b/arch/arm/mach-s5pc100/setup-keypad.c
new file mode 100644
index 0000000..d0837a7
--- /dev/null
+++ b/arch/arm/mach-s5pc100/setup-keypad.c
@@ -0,0 +1,34 @@
+/* linux/arch/arm/mach-s5pc100/setup-keypad.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * GPIO configuration for S5PC100 KeyPad device
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/gpio.h>
+#include <plat/gpio-cfg.h>
+
+void samsung_keypad_cfg_gpio(unsigned int rows, unsigned int cols)
+{
+	unsigned int gpio;
+	unsigned int end;
+
+	/* Set all the necessary GPH3 pins to special-function 3: KP_ROW[x] */
+	end = S5PC100_GPH3(rows);
+	for (gpio = S5PC100_GPH3(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	/* Set all the necessary GPH2 pins to special-function 3: KP_COL[x] */
+	end = S5PC100_GPH2(cols);
+	for (gpio = S5PC100_GPH2(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+}
-- 
1.6.2.5
