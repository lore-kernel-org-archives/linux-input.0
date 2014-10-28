From: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 08/15] ARM: sa1100: make collie use new locomo drivers
Date: Tue, 28 Oct 2014 03:02:01 +0300
Message-ID: <1414454528-24240-9-git-send-email-dbaryshkov@gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414454528-24240-1-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Switch collie to new mfd-based locomo driver.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-sa1100/Kconfig               |   1 -
 arch/arm/mach-sa1100/collie.c              | 112 +++++++++++++++--------------
 arch/arm/mach-sa1100/include/mach/collie.h |  25 ++++++-
 3 files changed, 79 insertions(+), 59 deletions(-)

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index c6f6ed1..37af126 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -48,7 +48,6 @@ endchoice
 config SA1100_COLLIE
 	bool "Sharp Zaurus SL5500"
 	# FIXME: select ARM_SA11x0_CPUFREQ
-	select SHARP_LOCOMO
 	select SHARP_PARAM
 	select SHARP_SCOOP
 	help
diff --git a/arch/arm/mach-sa1100/collie.c b/arch/arm/mach-sa1100/collie.c
index 108939f..43d3291 100644
--- a/arch/arm/mach-sa1100/collie.c
+++ b/arch/arm/mach-sa1100/collie.c
@@ -24,6 +24,7 @@
 #include <linux/platform_data/sa11x0-serial.h>
 #include <linux/platform_device.h>
 #include <linux/mfd/ucb1x00.h>
+#include <linux/mfd/locomo.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/timer.h>
@@ -47,7 +48,6 @@
 
 #include <asm/hardware/scoop.h>
 #include <asm/mach/sharpsl_param.h>
-#include <asm/hardware/locomo.h>
 #include <linux/platform_data/mfd-mcp-sa11x0.h>
 #include <mach/irqs.h>
 
@@ -189,36 +189,54 @@ static struct platform_device collie_power_device = {
 	.num_resources		= ARRAY_SIZE(collie_power_resource),
 };
 
-#ifdef CONFIG_SHARP_LOCOMO
 /*
  * low-level UART features.
  */
-struct platform_device collie_locomo_device;
+static struct gpio collie_uart_gpio[] = {
+	{ COLLIE_GPIO_CTS, GPIOF_IN, "CTS" },
+	{ COLLIE_GPIO_RTS, GPIOF_OUT_INIT_LOW, "RTS" },
+	{ COLLIE_GPIO_DTR, GPIOF_OUT_INIT_LOW, "DTR" },
+	{ COLLIE_GPIO_DSR, GPIOF_IN, "DSR" },
+};
+
+static bool collie_uart_gpio_ok;
 
 static void collie_uart_set_mctrl(struct uart_port *port, u_int mctrl)
 {
-	if (mctrl & TIOCM_RTS)
-		locomo_gpio_write(&collie_locomo_device.dev, LOCOMO_GPIO_RTS, 0);
-	else
-		locomo_gpio_write(&collie_locomo_device.dev, LOCOMO_GPIO_RTS, 1);
-
-	if (mctrl & TIOCM_DTR)
-		locomo_gpio_write(&collie_locomo_device.dev, LOCOMO_GPIO_DTR, 0);
-	else
-		locomo_gpio_write(&collie_locomo_device.dev, LOCOMO_GPIO_DTR, 1);
+	if (!collie_uart_gpio_ok) {
+		int rc = gpio_request_array(collie_uart_gpio,
+				ARRAY_SIZE(collie_uart_gpio));
+		if (rc)
+			pr_err("collie_uart_set_mctrl: gpio request %d\n", rc);
+		else
+			collie_uart_gpio_ok = true;
+	}
+
+	if (collie_uart_gpio_ok) {
+		gpio_set_value(COLLIE_GPIO_RTS, !(mctrl & TIOCM_RTS));
+		gpio_set_value(COLLIE_GPIO_DTR, !(mctrl & TIOCM_DTR));
+	}
 }
 
 static u_int collie_uart_get_mctrl(struct uart_port *port)
 {
 	int ret = TIOCM_CD;
-	unsigned int r;
 
-	r = locomo_gpio_read_output(&collie_locomo_device.dev, LOCOMO_GPIO_CTS & LOCOMO_GPIO_DSR);
-	if (r == -ENODEV)
+	if (!collie_uart_gpio_ok) {
+		int rc = gpio_request_array(collie_uart_gpio,
+				ARRAY_SIZE(collie_uart_gpio));
+		if (rc)
+			pr_err("collie_uart_get_mctrl: gpio request %d\n", rc);
+		else
+			collie_uart_gpio_ok = true;
+	}
+
+	if (!collie_uart_gpio_ok)
 		return ret;
-	if (r & LOCOMO_GPIO_CTS)
+
+	if (gpio_get_value(COLLIE_GPIO_CTS))
 		ret |= TIOCM_CTS;
-	if (r & LOCOMO_GPIO_DSR)
+	if (gpio_get_value(COLLIE_GPIO_DSR))
 		ret |= TIOCM_DSR;
 
 	return ret;
@@ -229,33 +247,6 @@ static struct sa1100_port_fns collie_port_fns __initdata = {
 	.get_mctrl	= collie_uart_get_mctrl,
 };
 
-static int collie_uart_probe(struct locomo_dev *dev)
-{
-	return 0;
-}
-
-static int collie_uart_remove(struct locomo_dev *dev)
-{
-	return 0;
-}
-
-static struct locomo_driver collie_uart_driver = {
-	.drv = {
-		.name = "collie_uart",
-	},
-	.devid	= LOCOMO_DEVID_UART,
-	.probe	= collie_uart_probe,
-	.remove	= collie_uart_remove,
-};
-
-static int __init collie_uart_init(void)
-{
-	return locomo_driver_register(&collie_uart_driver);
-}
-device_initcall(collie_uart_init);
-
-#endif
-
 
 static struct resource locomo_resources[] = {
 	[0] = DEFINE_RES_MEM(0x40000000, SZ_8K),
@@ -263,14 +254,28 @@ static struct resource locomo_resources[] = {
 };
 
 static struct locomo_platform_data locomo_info = {
-	.irq_base	= IRQ_BOARD_START,
+	.gpio_data = {
+		.gpio_base = COLLIE_LOCOMO_GPIO_BASE,
+	},
+	.lcd_data = {
+		.comadj	          = 128,
+		.gpio_lcd_vsha_on = COLLIE_GPIO_LCD_VSHA_ON,
+		.gpio_lcd_vshd_on = COLLIE_GPIO_LCD_VSHD_ON,
+		.gpio_lcd_vee_on  = COLLIE_GPIO_LCD_VEE_ON,
+		.gpio_lcd_mod     = COLLIE_GPIO_LCD_MOD,
+	},
+	.bl_data = {
+		.gpio_fl_vr       = COLLIE_GPIO_FL_VR,
+	},
+	.gpio_amp1_on	  = COLLIE_GPIO_AMP1_ON,
+	.gpio_amp2_on	  = COLLIE_GPIO_AMP2_ON,
 };
 
-struct platform_device collie_locomo_device = {
+static struct platform_device collie_locomo_device = {
 	.name		= "locomo",
 	.id		= 0,
 	.dev		= {
-		.platform_data	= &locomo_info,
+		.platform_data  = &locomo_info,
 	},
 	.num_resources	= ARRAY_SIZE(locomo_resources),
 	.resource	= locomo_resources,
@@ -385,10 +390,6 @@ static struct sa1100fb_mach_info collie_lcd_info = {
 
 	.lccr0		= LCCR0_Color | LCCR0_Sngl | LCCR0_Act,
 	.lccr3		= LCCR3_OutEnH | LCCR3_PixRsEdg | LCCR3_ACBsDiv(2),
-
-#ifdef CONFIG_BACKLIGHT_LOCOMO
-	.lcd_power	= locomolcd_power
-#endif
 };
 
 static void __init collie_init(void)
@@ -420,6 +421,8 @@ static void __init collie_init(void)
 
 	GPSR |= _COLLIE_GPIO_UCB1x00_RESET;
 
+	sharpsl_save_param();
+
 	collie_power_resource[0].start = gpio_to_irq(COLLIE_GPIO_AC_IN);
 	collie_power_resource[0].end = gpio_to_irq(COLLIE_GPIO_AC_IN);
 
@@ -428,6 +431,9 @@ static void __init collie_init(void)
 
 	platform_scoop_config = &collie_pcmcia_config;
 
+	if (sharpsl_param.comadj != -1)
+		locomo_info.lcd_data.comadj = sharpsl_param.comadj;
+
 	ret = platform_add_devices(devices, ARRAY_SIZE(devices));
 	if (ret) {
 		printk(KERN_WARNING "collie: Unable to register LoCoMo device\n");
@@ -438,8 +444,6 @@ static void __init collie_init(void)
 			    ARRAY_SIZE(collie_flash_resources));
 	sa11x0_register_mcp(&collie_mcp_data);
 	sa11x0_register_irda(&collie_ir_data);
-
-	sharpsl_save_param();
 }
 
 static struct map_desc collie_io_desc[] __initdata = {
@@ -461,9 +465,7 @@ static void __init collie_map_io(void)
 	sa1100_map_io();
 	iotable_init(collie_io_desc, ARRAY_SIZE(collie_io_desc));
 
-#ifdef CONFIG_SHARP_LOCOMO
 	sa1100_register_uart_fns(&collie_port_fns);
-#endif
 	sa1100_register_uart(0, 3);
 	sa1100_register_uart(1, 1);
 }
diff --git a/arch/arm/mach-sa1100/include/mach/collie.h b/arch/arm/mach-sa1100/include/mach/collie.h
index b478ca1..22a7c7e 100644
--- a/arch/arm/mach-sa1100/include/mach/collie.h
+++ b/arch/arm/mach-sa1100/include/mach/collie.h
@@ -24,12 +24,12 @@ extern void locomolcd_power(int on);
 #define COLLIE_SCP_MUTE_L	SCOOP_GPCR_PA14
 #define COLLIE_SCP_MUTE_R	SCOOP_GPCR_PA15
 #define COLLIE_SCP_5VON		SCOOP_GPCR_PA16
-#define COLLIE_SCP_AMP_ON	SCOOP_GPCR_PA17
+#define COLLIE_GPIO_AMP2_ON	(COLLIE_SCOOP_GPIO_BASE + 6)
 #define COLLIE_GPIO_VPEN	(COLLIE_SCOOP_GPIO_BASE + 7)
 #define COLLIE_SCP_LB_VOL_CHG	SCOOP_GPCR_PA19
 
 #define COLLIE_SCOOP_IO_DIR	(COLLIE_SCP_MUTE_L | COLLIE_SCP_MUTE_R | \
-				COLLIE_SCP_5VON | COLLIE_SCP_AMP_ON | \
+				COLLIE_SCP_5VON | \
 				COLLIE_SCP_LB_VOL_CHG)
 #define COLLIE_SCOOP_IO_OUT	(COLLIE_SCP_MUTE_L | COLLIE_SCP_MUTE_R)
 
@@ -81,7 +81,7 @@ extern void locomolcd_power(int on);
 #define COLLIE_TC35143_GPIO_TBL_CHK     UCB_IO_1
 #define COLLIE_TC35143_GPIO_VPEN_ON     UCB_IO_2
 #define COLLIE_GPIO_IR_ON		(COLLIE_TC35143_GPIO_BASE + 3)
-#define COLLIE_TC35143_GPIO_AMP_ON      UCB_IO_4
+#define COLLIE_GPIO_AMP1_ON		(COLLIE_TC35143_GPIO_BASE + 4)
 #define COLLIE_TC35143_GPIO_VERSION1    UCB_IO_5
 #define COLLIE_TC35143_GPIO_FS8KLPF     UCB_IO_5
 #define COLLIE_TC35143_GPIO_BUZZER_BIAS UCB_IO_6
@@ -92,4 +92,23 @@ extern void locomolcd_power(int on);
 #define COLLIE_TC35143_GPIO_OUT		(UCB_IO_1 | UCB_IO_3 | UCB_IO_4 \
 						| UCB_IO_6)
 
+/* GPIOs on LoCoMo GA */
+#define COLLIE_LOCOMO_GPIO_BASE		(GPIO_MAX + 23)
+#define COLLIE_GPIO_RTS			(COLLIE_LOCOMO_GPIO_BASE + 0)
+#define COLLIE_GPIO_CTS			(COLLIE_LOCOMO_GPIO_BASE + 1)
+#define COLLIE_GPIO_DSR			(COLLIE_LOCOMO_GPIO_BASE + 2)
+#define COLLIE_GPIO_DTR			(COLLIE_LOCOMO_GPIO_BASE + 3)
+#define COLLIE_GPIO_LCD_VSHA_ON		(COLLIE_LOCOMO_GPIO_BASE + 4)
+#define COLLIE_GPIO_LCD_VSHD_ON		(COLLIE_LOCOMO_GPIO_BASE + 5)
+#define COLLIE_GPIO_LCD_VEE_ON		(COLLIE_LOCOMO_GPIO_BASE + 6)
+#define COLLIE_GPIO_LCD_MOD		(COLLIE_LOCOMO_GPIO_BASE + 7)
+#define COLLIE_LOCOMO_GPIO_DAC_ON	LOCOMO_GPIO(8)
+#define COLLIE_GPIO_FL_VR		(COLLIE_LOCOMO_GPIO_BASE + 9)
+#define COLLIE_LOCOMO_GPIO_DAC_SDATA	LOCOMO_GPIO(10)
+#define COLLIE_LOCOMO_GPIO_DAC_SCK	LOCOMO_GPIO(11)
+#define COLLIE_LOCOMO_GPIO_DAC_SLOAD	LOCOMO_GPIO(12)
+#define COLLIE_LOCOMO_GPIO_CARD_DETECT	LOCOMO_GPIO(13)
+#define COLLIE_LOCOMO_GPIO_WRITE_PROT	LOCOMO_GPIO(14)
+#define COLLIE_LOCOMO_GPIO_CARD_POWER	LOCOMO_GPIO(15)
+
 #endif
-- 
2.1.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
