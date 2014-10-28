From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 10/15] ARM: pxa: poodle: use new LoCoMo driver
Date: Tue, 28 Oct 2014 03:02:03 +0300
Message-ID: <1414454528-24240-11-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
Cc: Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org

Convert poodle to use new mfd-based LoCoMo driver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/arm/mach-pxa/Kconfig               |  1 -
 arch/arm/mach-pxa/include/mach/poodle.h | 14 +++++++++-----
 arch/arm/mach-pxa/poodle.c              | 19 +++++++++++++++----
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index e6690a4..1da3e8f 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -473,7 +473,6 @@ config MACH_POODLE
 	bool "Enable Sharp SL-5600 (Poodle) Support"
 	depends on PXA_SHARPSL
 	select PXA25x
-	select SHARP_LOCOMO
 
 config MACH_CORGI
 	bool "Enable Sharp SL-C700 (Corgi) Support"
diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
index b56b193..e8eb51e 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -81,11 +81,15 @@
 #define POODLE_GPIO_L_LCLK	(POODLE_SCOOP_GPIO_BASE + 10)
 #define POODLE_GPIO_HS_OUT	(POODLE_SCOOP_GPIO_BASE + 11)
 
-#define POODLE_LOCOMO_GPIO_AMP_ON      LOCOMO_GPIO(8)
-#define POODLE_LOCOMO_GPIO_MUTE_L      LOCOMO_GPIO(10)
-#define POODLE_LOCOMO_GPIO_MUTE_R      LOCOMO_GPIO(11)
-#define POODLE_LOCOMO_GPIO_232VCC_ON   LOCOMO_GPIO(12)
-#define POODLE_LOCOMO_GPIO_JK_B        LOCOMO_GPIO(13)
+#define POODLE_LOCOMO_GPIO_BASE	(PXA_NR_BUILTIN_GPIO + 12)
+#define POODLE_GPIO_LCD_VSHA_ON	(POODLE_LOCOMO_GPIO_BASE + 4)
+#define POODLE_GPIO_LCD_VSHD_ON	(POODLE_LOCOMO_GPIO_BASE + 5)
+#define POODLE_GPIO_LCD_VEE_ON	(POODLE_LOCOMO_GPIO_BASE + 6)
+#define POODLE_GPIO_LCD_MOD	(POODLE_LOCOMO_GPIO_BASE + 7)
+#define POODLE_GPIO_AMP_ON	(POODLE_LOCOMO_GPIO_BASE + 8)
+#define POODLE_GPIO_FL_VR	(POODLE_LOCOMO_GPIO_BASE + 9)
+#define POODLE_GPIO_MUTE_L	(POODLE_LOCOMO_GPIO_BASE + 10)
+#define POODLE_GPIO_MUTE_R	(POODLE_LOCOMO_GPIO_BASE + 11)
 
 #define POODLE_NR_IRQS		(IRQ_BOARD_START + 4)	/* 4 for LoCoMo */
 
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 1319916..3041d83 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -30,6 +30,7 @@
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/memblock.h>
+#include <linux/mfd/locomo.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -48,7 +49,6 @@
 #include <linux/platform_data/video-pxafb.h>
 
 #include <asm/hardware/scoop.h>
-#include <asm/hardware/locomo.h>
 #include <asm/mach/sharpsl_param.h>
 
 #include "generic.h"
@@ -178,7 +178,17 @@ static struct resource locomo_resources[] = {
 };
 
 static struct locomo_platform_data locomo_info = {
-	.irq_base	= IRQ_BOARD_START,
+	.gpio_data = {
+		.gpio_base = POODLE_LOCOMO_GPIO_BASE,
+	},
+	.bl_data = {
+		.comadj	          = 118,
+		.gpio_lcd_vsha_on = POODLE_GPIO_LCD_VSHA_ON,
+		.gpio_lcd_vshd_on = POODLE_GPIO_LCD_VSHD_ON,
+		.gpio_lcd_vee_on  = POODLE_GPIO_LCD_VEE_ON,
+		.gpio_lcd_mod     = POODLE_GPIO_LCD_MOD,
+		.gpio_fl_vr       = POODLE_GPIO_FL_VR,
+	},
 };
 
 struct platform_device poodle_locomo_device = {
@@ -191,8 +201,6 @@ struct platform_device poodle_locomo_device = {
 	},
 };
 
-EXPORT_SYMBOL(poodle_locomo_device);
-
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
 static struct pxa2xx_spi_master poodle_spi_info = {
 	.num_chipselect	= 1,
@@ -444,6 +452,9 @@ static void __init poodle_init(void)
 
 	platform_scoop_config = &poodle_pcmcia_config;
 
+	if (sharpsl_param.comadj != -1)
+		locomo_info.bl_data.comadj = sharpsl_param.comadj;
+
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret)
 		pr_warning("poodle: Unable to register LoCoMo device\n");
-- 
2.1.1

