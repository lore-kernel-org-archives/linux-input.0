From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 12/15] ARM: pxa: poodle: don't preallocate IRQ space for locomo
Date: Tue, 28 Oct 2014 03:02:05 +0300
Message-ID: <1414454528-24240-13-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

As new locomo driver supports SPARSE_IRQ, don't preallocate NR_IRQS
space for it on poodle.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-pxa/include/mach/poodle.h | 2 +-
 arch/arm/mach-pxa/poodle.c              | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/poodle.h b/arch/arm/mach-pxa/include/mach/poodle.h
index e8eb51e..105410a 100644
--- a/arch/arm/mach-pxa/include/mach/poodle.h
+++ b/arch/arm/mach-pxa/include/mach/poodle.h
@@ -91,7 +91,7 @@
 #define POODLE_GPIO_MUTE_L	(POODLE_LOCOMO_GPIO_BASE + 10)
 #define POODLE_GPIO_MUTE_R	(POODLE_LOCOMO_GPIO_BASE + 11)
 
-#define POODLE_NR_IRQS		(IRQ_BOARD_START + 4)	/* 4 for LoCoMo */
+#define POODLE_NR_IRQS		IRQ_BOARD_START
 
 extern struct platform_device poodle_locomo_device;
 
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index 3041d83..97eced9 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -181,14 +181,18 @@ static struct locomo_platform_data locomo_info = {
 	.gpio_data = {
 		.gpio_base = POODLE_LOCOMO_GPIO_BASE,
 	},
-	.bl_data = {
+	.lcd_data = {
 		.comadj	          = 118,
 		.gpio_lcd_vsha_on = POODLE_GPIO_LCD_VSHA_ON,
 		.gpio_lcd_vshd_on = POODLE_GPIO_LCD_VSHD_ON,
 		.gpio_lcd_vee_on  = POODLE_GPIO_LCD_VEE_ON,
 		.gpio_lcd_mod     = POODLE_GPIO_LCD_MOD,
+	},
+	.bl_data = {
 		.gpio_fl_vr       = POODLE_GPIO_FL_VR,
 	},
+	.gpio_amp1_on	= -1,
+	.gpio_amp2_on	= -1,
 };
 
 struct platform_device poodle_locomo_device = {
@@ -453,7 +457,7 @@ static void __init poodle_init(void)
 	platform_scoop_config = &poodle_pcmcia_config;
 
 	if (sharpsl_param.comadj != -1)
-		locomo_info.bl_data.comadj = sharpsl_param.comadj;
+		locomo_info.lcd_data.comadj = sharpsl_param.comadj;
 
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret)
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
