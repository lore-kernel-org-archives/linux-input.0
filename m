From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v3 14/17] ARM: pxa: poodle: use new LoCoMo driver
Date: Sun, 17 May 2015 19:27:54 +0300
Message-ID: <1431880077-26321-15-git-send-email-dbaryshkov@gmail.com>
References: <1431880077-26321-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1431880077-26321-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: linux-input@vger.kernel.org

Convert poodle to use new mfd-based LoCoMo driver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-pxa/Kconfig               |  1 -
 arch/arm/mach-pxa/include/mach/poodle.h |  6 ----
 arch/arm/mach-pxa/poodle.c              | 58 ++++++++++++++++++++++++++++++---
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 8896e71..a2756b0 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -481,7 +481,6 @@ config MACH_POODLE
 	bool "Enable Sharp SL-5600 (Poodle) Support"
 	depends on PXA_SHARPSL
 	select PXA25x
-	select SHARP_LOCOMO
 
 config MACH_CORGI
 	bool "Enable Sharp SL-C700 (Corgi) Support"
diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
index b56b193..5905cf1 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -81,12 +81,6 @@
 #define POODLE_GPIO_L_LCLK	(POODLE_SCOOP_GPIO_BASE + 10)
 #define POODLE_GPIO_HS_OUT	(POODLE_SCOOP_GPIO_BASE + 11)
 
-#define POODLE_LOCOMO_GPIO_AMP_ON      LOCOMO_GPIO(8)
-#define POODLE_LOCOMO_GPIO_MUTE_L      LOCOMO_GPIO(10)
-#define POODLE_LOCOMO_GPIO_MUTE_R      LOCOMO_GPIO(11)
-#define POODLE_LOCOMO_GPIO_232VCC_ON   LOCOMO_GPIO(12)
-#define POODLE_LOCOMO_GPIO_JK_B        LOCOMO_GPIO(13)
-
 #define POODLE_NR_IRQS		(IRQ_BOARD_START + 4)	/* 4 for LoCoMo */
 
 extern struct platform_device poodle_locomo_device;
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 195b112..0236ee8 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/mtd/physmap.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/i2c.h>
 #include <linux/i2c/pxa-i2c.h>
 #include <linux/regulator/machine.h>
@@ -31,6 +32,8 @@
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/mtd/sharpsl.h>
 #include <linux/memblock.h>
+#include <linux/iio/machine.h>
+#include <linux/mfd/locomo.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -49,7 +52,6 @@
 #include <linux/platform_data/video-pxafb.h>
 
 #include <asm/hardware/scoop.h>
-#include <asm/hardware/locomo.h>
 #include <asm/mach/sharpsl_param.h>
 
 #include "generic.h"
@@ -179,7 +181,8 @@ static struct resource locomo_resources[] = {
 };
 
 static struct locomo_platform_data locomo_info = {
-	.irq_base	= IRQ_BOARD_START,
+	.gpio_base	  = -1,
+	.comadj	          = 118,
 };
 
 struct platform_device poodle_locomo_device = {
@@ -192,8 +195,6 @@ struct platform_device poodle_locomo_device = {
 	},
 };
 
-EXPORT_SYMBOL(poodle_locomo_device);
-
 #if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
 static struct pxa2xx_spi_master poodle_spi_info = {
 	.num_chipselect	= 1,
@@ -424,6 +425,47 @@ static struct i2c_board_info __initdata poodle_i2c_devices[] = {
 	{ I2C_BOARD_INFO("wm8731", 0x1b) },
 };
 
+static struct iio_map locomo_iio_map[] = {
+	{
+		.consumer_dev_name = "locomo-lcd.0",
+		.consumer_channel = "comadj",
+		.adc_channel_label = "CH0",
+	},
+	{ }
+};
+
+static struct i2c_board_info locomo_i2c_devs[] __initdata = {
+	{
+		I2C_BOARD_INFO("m62332", 0x4e),
+		.platform_data = locomo_iio_map,
+	},
+};
+
+static struct gpiod_lookup_table poodle_audio_gpios_table = {
+	.dev_id = "poodle-audio",
+	.table = {
+		GPIO_LOOKUP("locomo-gpio", 10, "mute-l", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("locomo-gpio", 11, "mute-r", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("locomo-gpio", 8, "amp-on", GPIO_ACTIVE_LOW),
+		{ },
+	},
+}, poodle_bl_gpios_table = {
+	.dev_id = "locomo-backlight.0",
+	.table = {
+		GPIO_LOOKUP("locomo-gpio", 9, "flvr", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+}, poodle_lcd_gpios_table = {
+	.dev_id = "locomo-lcd.0",
+	.table = {
+		GPIO_LOOKUP("locomo-gpio", 4, "VSHA", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("locomo-gpio", 5, "VSHD", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("locomo-gpio", 6, "Vee", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("locomo-gpio", 7, "MOD", GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static void poodle_poweroff(void)
 {
 	pxa_restart(REBOOT_HARD, NULL);
@@ -445,6 +487,13 @@ static void __init poodle_init(void)
 
 	platform_scoop_config = &poodle_pcmcia_config;
 
+	if (sharpsl_param.comadj != -1)
+		locomo_info.comadj = sharpsl_param.comadj;
+
+	gpiod_add_lookup_table(&poodle_audio_gpios_table);
+	gpiod_add_lookup_table(&poodle_bl_gpios_table);
+	gpiod_add_lookup_table(&poodle_lcd_gpios_table);
+
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret)
 		pr_warn("poodle: Unable to register LoCoMo device\n");
@@ -455,6 +504,7 @@ static void __init poodle_init(void)
 	pxa_set_ficp_info(&poodle_ficp_platform_data);
 	pxa_set_i2c_info(NULL);
 	i2c_register_board_info(0, ARRAY_AND_SIZE(poodle_i2c_devices));
+	i2c_register_board_info(1, ARRAY_AND_SIZE(locomo_i2c_devs));
 	poodle_init_spi();
 	regulator_has_full_constraints();
 }
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
