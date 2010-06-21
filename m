From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH 2/4] ARM: S3C64XX: Add keypad device to the SMDK6410 board
Date: Tue, 22 Jun 2010 08:43:53 +0900
Message-ID: <1277163835-12439-3-git-send-email-kgene.kim@samsung.com>
References: <1277163835-12439-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1277163835-12439-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org
Cc: ben-linux@fluff.org, dmitry.torokhov@gmail.com, Naveen Krishna Ch <ch.naveen@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch is to support keypad device to the SMDK6410 board.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/Kconfig            |    7 ++++++
 arch/arm/mach-s3c64xx/Makefile           |    1 +
 arch/arm/mach-s3c64xx/clock.c            |    6 +++++
 arch/arm/mach-s3c64xx/include/mach/map.h |    2 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c    |   24 +++++++++++++++++++++
 arch/arm/mach-s3c64xx/setup-keypad.c     |   34 ++++++++++++++++++++++++++++++
 6 files changed, 74 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/setup-keypad.c

diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index f5a5972..08fdb7f 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -62,6 +62,11 @@ config S3C64XX_SETUP_FB_24BPP
 	help
 	  Common setup code for S3C64XX with an 24bpp RGB display helper.
 
+config S3C64XX_SETUP_KEYPAD
+	bool
+	help
+	  Common setup code for S3C64XX KEYPAD GPIO configurations
+
 config S3C64XX_SETUP_SDHCI_GPIO
 	bool
 	help
@@ -100,10 +105,12 @@ config MACH_SMDK6410
 	select S3C_DEV_USB_HOST
 	select S3C_DEV_USB_HSOTG
 	select S3C_DEV_WDT
+	select SAMSUNG_DEV_KEYPAD
 	select HAVE_S3C2410_WATCHDOG
 	select S3C64XX_SETUP_SDHCI
 	select S3C64XX_SETUP_I2C1
 	select S3C64XX_SETUP_FB_24BPP
+	select S3C64XX_SETUP_KEYPAD
 	help
 	  Machine support for the Samsung SMDK6410
 
diff --git a/arch/arm/mach-s3c64xx/Makefile b/arch/arm/mach-s3c64xx/Makefile
index 9d10069..b1b4d10 100644
--- a/arch/arm/mach-s3c64xx/Makefile
+++ b/arch/arm/mach-s3c64xx/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_S3C64XX_DMA)	+= dma.o
 
 obj-$(CONFIG_S3C64XX_SETUP_I2C0) += setup-i2c0.o
 obj-$(CONFIG_S3C64XX_SETUP_I2C1) += setup-i2c1.o
+obj-$(CONFIG_S3C64XX_SETUP_KEYPAD) += setup-keypad.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI) += setup-sdhci.o
 obj-$(CONFIG_S3C64XX_SETUP_FB_24BPP) += setup-fb-24bpp.o
 obj-$(CONFIG_S3C64XX_SETUP_SDHCI_GPIO) += setup-sdhci-gpio.o
diff --git a/arch/arm/mach-s3c64xx/clock.c b/arch/arm/mach-s3c64xx/clock.c
index fbd85a9..ec8f097 100644
--- a/arch/arm/mach-s3c64xx/clock.c
+++ b/arch/arm/mach-s3c64xx/clock.c
@@ -165,6 +165,12 @@ static struct clk init_clocks_disable[] = {
 		.ctrlbit	= S3C6410_CLKCON_PCLK_IIS2,
 	}, {
 #endif
+		.name		= "keypad",
+		.id		= -1,
+		.parent		= &clk_p,
+		.enable		= s3c64xx_pclk_ctrl,
+		.ctrlbit	= S3C_CLKCON_PCLK_KEYPAD,
+	}, {
 		.name		= "spi",
 		.id		= 0,
 		.parent		= &clk_p,
diff --git a/arch/arm/mach-s3c64xx/include/mach/map.h b/arch/arm/mach-s3c64xx/include/mach/map.h
index e1eab3c..f57ff08 100644
--- a/arch/arm/mach-s3c64xx/include/mach/map.h
+++ b/arch/arm/mach-s3c64xx/include/mach/map.h
@@ -67,6 +67,7 @@
 #define S3C64XX_PA_USB_HSOTG	(0x7C000000)
 #define S3C64XX_PA_WATCHDOG	(0x7E004000)
 #define S3C64XX_PA_RTC		(0x7E005000)
+#define S3C64XX_PA_KEYPAD	(0x7E00A000)
 #define S3C64XX_PA_ADC		(0x7E00B000)
 #define S3C64XX_PA_SYSCON	(0x7E00F000)
 #define S3C64XX_PA_AC97		(0x7F001000)
@@ -120,5 +121,6 @@
 #define S3C_PA_WDT		S3C64XX_PA_WATCHDOG
 
 #define SAMSUNG_PA_ADC		S3C64XX_PA_ADC
+#define SAMSUNG_PA_KEYPAD	S3C64XX_PA_KEYPAD
 
 #endif /* __ASM_ARCH_6400_MAP_H */
diff --git a/arch/arm/mach-s3c64xx/mach-smdk6410.c b/arch/arm/mach-s3c64xx/mach-smdk6410.c
index d9a0355..52dd17e 100644
--- a/arch/arm/mach-s3c64xx/mach-smdk6410.c
+++ b/arch/arm/mach-s3c64xx/mach-smdk6410.c
@@ -17,6 +17,7 @@
 #include <linux/list.h>
 #include <linux/timer.h>
 #include <linux/init.h>
+#include <linux/input.h>
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
@@ -66,6 +67,7 @@
 #include <plat/cpu.h>
 #include <plat/adc.h>
 #include <plat/ts.h>
+#include <plat/keypad.h>
 
 #define UCON S3C2410_UCON_DEFAULT | S3C2410_UCON_UCLK
 #define ULCON S3C2410_LCON_CS8 | S3C2410_LCON_PNONE | S3C2410_LCON_STOPB
@@ -242,6 +244,25 @@ static struct platform_device smdk6410_b_pwr_5v = {
 };
 #endif
 
+static uint32_t smdk6410_keymap[] __initdata = {
+	/* KEY(row, col, keycode) */
+	KEY(0, 3, KEY_1), KEY(0, 4, KEY_2), KEY(0, 5, KEY_3),
+	KEY(0, 6, KEY_4), KEY(0, 7, KEY_5),
+	KEY(1, 3, KEY_A), KEY(1, 4, KEY_B), KEY(1, 5, KEY_C),
+	KEY(1, 6, KEY_D), KEY(1, 7, KEY_E)
+};
+
+static struct matrix_keymap_data smdk6410_keymap_data __initdata = {
+	.keymap		= smdk6410_keymap,
+	.keymap_size	= ARRAY_SIZE(smdk6410_keymap),
+};
+
+static struct samsung_keypad_platdata smdk6410_keypad_data __initdata = {
+	.keymap_data	= &smdk6410_keymap_data,
+	.rows		= 2,
+	.cols		= 8,
+};
+
 static struct map_desc smdk6410_iodesc[] = {};
 
 static struct platform_device *smdk6410_devices[] __initdata = {
@@ -257,6 +278,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_ohci,
 	&s3c_device_usb_hsotg,
 	&s3c64xx_device_iisv4,
+	&samsung_device_keypad,
 
 #ifdef CONFIG_REGULATOR
 	&smdk6410_b_pwr_5v,
@@ -636,6 +658,8 @@ static void __init smdk6410_machine_init(void)
 	s3c_i2c1_set_platdata(NULL);
 	s3c_fb_set_platdata(&smdk6410_lcd_pdata);
 
+	samsung_keypad_set_platdata(&smdk6410_keypad_data);
+
 	s3c24xx_ts_set_platdata(&s3c_ts_platform);
 
 	/* configure nCS1 width to 16 bits */
diff --git a/arch/arm/mach-s3c64xx/setup-keypad.c b/arch/arm/mach-s3c64xx/setup-keypad.c
new file mode 100644
index 0000000..abc34e4
--- /dev/null
+++ b/arch/arm/mach-s3c64xx/setup-keypad.c
@@ -0,0 +1,34 @@
+/* linux/arch/arm/mach-s3c64xx/setup-keypad.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * GPIO configuration for S3C64XX KeyPad device
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
+	/* Set all the necessary GPK pins to special-function 3: KP_ROW[x] */
+	end = S3C64XX_GPK(8 + rows);
+	for (gpio = S3C64XX_GPK(8); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	/* Set all the necessary GPL pins to special-function 3: KP_COL[x] */
+	end = S3C64XX_GPL(0 + cols);
+	for (gpio = S3C64XX_GPL(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+}
-- 
1.6.2.5
