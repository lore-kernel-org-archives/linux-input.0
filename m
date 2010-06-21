From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH 1/4] ARM: S5PV210: Add keypad device to the SMDKV210 board
Date: Tue, 22 Jun 2010 08:43:52 +0900
Message-ID: <1277163835-12439-2-git-send-email-kgene.kim@samsung.com>
References: <1277163835-12439-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1277163835-12439-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org
Cc: ben-linux@fluff.org, dmitry.torokhov@gmail.com, Naveen Krishna Ch <ch.naveen@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-input@vger.kernel.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch is to support keypad device to the SMDKV210 board.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig         |    2 ++
 arch/arm/mach-s5pv210/mach-smdkv210.c |   23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 692d01c..4ae365d 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -77,8 +77,10 @@ config MACH_SMDKV210
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
 	select SAMSUNG_DEV_ADC
+	select SAMSUNG_DEV_KEYPAD
 	select SAMSUNG_DEV_TS
 	select S3C_DEV_WDT
+	select S5PV210_SETUP_KEYPAD
 	select HAVE_S3C2410_WATCHDOG
 	help
 	  Machine support for Samsung SMDKV210
diff --git a/arch/arm/mach-s5pv210/mach-smdkv210.c b/arch/arm/mach-s5pv210/mach-smdkv210.c
index 0d46279..43bc10a 100644
--- a/arch/arm/mach-s5pv210/mach-smdkv210.c
+++ b/arch/arm/mach-s5pv210/mach-smdkv210.c
@@ -27,6 +27,7 @@
 #include <plat/cpu.h>
 #include <plat/adc.h>
 #include <plat/ts.h>
+#include <plat/keypad.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -73,10 +74,30 @@ static struct s3c2410_uartcfg smdkv210_uartcfgs[] __initdata = {
 	},
 };
 
+static uint32_t smdkv210_keymap[] __initdata = {
+	/* KEY(row, col, keycode) */
+	KEY(0, 3, KEY_1), KEY(0, 4, KEY_2), KEY(0, 5, KEY_3),
+	KEY(0, 6, KEY_4), KEY(0, 7, KEY_5),
+	KEY(1, 3, KEY_A), KEY(1, 4, KEY_B), KEY(1, 5, KEY_C),
+	KEY(1, 6, KEY_D), KEY(1, 7, KEY_E)
+};
+
+static struct matrix_keymap_data smdkv210_keymap_data __initdata = {
+	.keymap		= smdkv210_keymap,
+	.keymap_size	= ARRAY_SIZE(smdkv210_keymap),
+};
+
+static struct samsung_keypad_platdata smdkv210_keypad_data __initdata = {
+	.keymap_data	= &smdkv210_keymap_data,
+	.rows		= 8,
+	.cols		= 8,
+};
+
 static struct platform_device *smdkv210_devices[] __initdata = {
 	&s5pv210_device_iis0,
 	&s5pv210_device_ac97,
 	&s3c_device_adc,
+	&samsung_device_keypad,
 	&s3c_device_ts,
 	&s3c_device_wdt,
 };
@@ -96,7 +117,9 @@ static void __init smdkv210_map_io(void)
 
 static void __init smdkv210_machine_init(void)
 {
+	samsung_keypad_set_platdata(&smdkv210_keypad_data);
 	s3c24xx_ts_set_platdata(&s3c_ts_platform);
+
 	platform_add_devices(smdkv210_devices, ARRAY_SIZE(smdkv210_devices));
 }
 
-- 
1.6.2.5
