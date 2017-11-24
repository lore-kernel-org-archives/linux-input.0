From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5] ARM: imx: Use GPIO descriptors for gpio_keys
Date: Fri, 24 Nov 2017 10:30:45 +0100
Message-ID: <20171124093045.5961-6-linus.walleij@linaro.org>
References: <20171124093045.5961-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39691 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753004AbdKXJa7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Nov 2017 04:30:59 -0500
Received: by mail-lf0-f67.google.com with SMTP id x76so20102465lfb.6
        for <linux-input@vger.kernel.org>; Fri, 24 Nov 2017 01:30:58 -0800 (PST)
In-Reply-To: <20171124093045.5961-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Marc Reilly <marc@cpdesign.com.au>

This switches all relevant i.MX boards still using boardfiles to
using GPIO descriptors to look up the GPIO lines for gpio_keys.

Most conversions were straight-forward, I dropped comments on how
the offsets are looked up where appropriate.

The VPR200 board was seemingly incorrect. It assigned the members
of struct gpio_keys_button with the direct, non-C99 syntax
like so:

  #define VPR_KEY_DEBOUNCE       500
  static struct gpio_keys_button vpr200_gpio_keys_table[] = {
    {KEY_F2, GPIO_BUTTON1, 1, "vpr-keys: F2", 0, VPR_KEY_DEBOUNCE},
    {KEY_F3, GPIO_BUTTON2, 1, "vpr-keys: F3", 0, VPR_KEY_DEBOUNCE},
    (...)

This is confusing as it seems to have been wrong already when the
patch was merged. The members are assigned in order:

struct gpio_keys_button {
        unsigned int code;
        int gpio;
        int active_low;
        const char *desc;
        unsigned int type;
        int wakeup;
        int debounce_interval;
        bool can_disable;
(...)

Meaning KEY_XX, GPIO_BUTTON1, 1, "key name", type us right, then
comes wakeup capability and this should be 0 or 1, but is instead
assigned VPR_KEY_DEBOUNCE which is 500. I have corrected the code
to do what I think the author intended. I consider this a
non-critical fix because I bet it works (or the board is completely
unused), but add the fixing tag for reference.

Cc: Marc Reilly <marc@cpdesign.com.au>
Fixes: 00c89c1d1831 ("Introduce VPR200 board.")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-imx/mach-armadillo5x0.c       | 19 ++++--
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c | 26 ++++++--
 arch/arm/mach-imx/mach-pcm037_eet.c         | 52 +++++++++++----
 arch/arm/mach-imx/mach-vpr200.c             | 99 ++++++++++++++++++++++++-----
 4 files changed, 155 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-imx/mach-armadillo5x0.c b/arch/arm/mach-imx/mach-armadillo5x0.c
index 17a97ba2cecf..829a252eaa2a 100644
--- a/arch/arm/mach-imx/mach-armadillo5x0.c
+++ b/arch/arm/mach-imx/mach-armadillo5x0.c
@@ -28,6 +28,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -265,14 +266,10 @@ static struct i2c_board_info armadillo5x0_i2c_rtc = {
 static struct gpio_keys_button armadillo5x0_buttons[] = {
 	{
 		.code		= KEY_ENTER, /*28*/
-		.gpio		= IOMUX_TO_GPIO(MX31_PIN_SCLK0),
-		.active_low	= 1,
 		.desc		= "menu",
 		.wakeup		= 1,
 	}, {
 		.code		= KEY_BACK, /*158*/
-		.gpio		= IOMUX_TO_GPIO(MX31_PIN_SRST0),
-		.active_low	= 1,
 		.desc		= "back",
 		.wakeup		= 1,
 	}
@@ -284,6 +281,19 @@ static const struct gpio_keys_platform_data
 	.nbuttons	= ARRAY_SIZE(armadillo5x0_buttons),
 };
 
+static struct gpiod_lookup_table armadillo5x0_buttons_gpios_table = {
+	.dev_id = "gpio-keys",
+	.table = {
+		/*
+		 * These are GPIOs M31_PIN_SCLK0 and MX31_PIN_SRSR0,
+		 * global GPIO numbers 66 and 67, with 32 GPIOs per chip
+		 * these are chip 2 offsets 2 and 3
+		 */
+		GPIO_LOOKUP("imx31-gpio-2", 2, "menu", GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("imx31-gpio-2", 3, "back", GPIO_ACTIVE_LOW),
+	},
+};
+
 /*
  * NAND Flash
  */
@@ -525,6 +535,7 @@ static void __init armadillo5x0_late(void)
 		gpio_to_irq(IOMUX_TO_GPIO(MX31_PIN_GPIO1_0));
 	platform_add_devices(devices, ARRAY_SIZE(devices));
 
+	gpiod_add_lookup_table(&armadillo5x0_buttons_gpios_table);
 	imx_add_gpio_keys(&armadillo5x0_button_data);
 
 	/* SMSC9118 IRQ pin */
diff --git a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
index 5169dfba9718..97c6e163ef36 100644
--- a/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
+++ b/arch/arm/mach-imx/mach-imx27_visstrim_m10.c
@@ -29,6 +29,7 @@
 #include <linux/platform_data/pca953x.h>
 #include <linux/input.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/leds.h>
@@ -274,25 +275,19 @@ static struct gpio_keys_button visstrim_gpio_keys[] = {
 	{
 		.type	= EV_KEY,
 		.code	= KEY_RESTART,
-		.gpio	= (GPIO_PORTC + 15),
 		.desc	= "Default config",
-		.active_low = 0,
 		.wakeup = 1,
 	},
 	{
 		.type	= EV_KEY,
 		.code	= KEY_RECORD,
-		.gpio	= (GPIO_PORTF + 14),
 		.desc	= "Record",
-		.active_low = 0,
 		.wakeup = 1,
 	},
 	{
 		.type   = EV_KEY,
 		.code   = KEY_STOP,
-		.gpio   = (GPIO_PORTF + 13),
 		.desc   = "Stop",
-		.active_low = 0,
 		.wakeup = 1,
 	}
 };
@@ -303,6 +298,24 @@ static const struct gpio_keys_platform_data
 	.nbuttons	= ARRAY_SIZE(visstrim_gpio_keys),
 };
 
+static struct gpiod_lookup_table visstrim_gpio_keys_gpios_table = {
+	.dev_id = "gpio-keys",
+	.table = {
+		/*
+		 * These keys are on "PORT E" offset 15 and "PORT F"
+		 * offsets 14 and 13. This corresponds to imx21-gpio-4
+		 * and imx21-gpio-5, as this SoC has the i.MX21 GPIO
+		 * block.
+		 */
+		GPIO_LOOKUP("imx21-gpio-4", 15, "Default config",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx21-gpio-5", 14, "Record",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx21-gpio-5", 13, "Stop",
+			    GPIO_ACTIVE_HIGH),
+	},
+};
+
 /* led */
 static const struct gpio_led visstrim_m10_leds[] __initconst = {
 	{
@@ -563,6 +576,7 @@ static void __init visstrim_m10_late_init(void)
 	if (ret)
 		pr_err("Failed to request gpios (%d)\n", ret);
 
+	gpiod_add_lookup_table(&visstrim_gpio_keys_gpios_table);
 	imx_add_gpio_keys(&visstrim_gpio_keys_platform_data);
 
 	imx_add_platform_device("mx27vis", 0, NULL, 0, &snd_mx27vis_pdata,
diff --git a/arch/arm/mach-imx/mach-pcm037_eet.c b/arch/arm/mach-imx/mach-pcm037_eet.c
index 95bd97710494..9b3d0246ed63 100644
--- a/arch/arm/mach-imx/mach-pcm037_eet.c
+++ b/arch/arm/mach-imx/mach-pcm037_eet.c
@@ -7,6 +7,7 @@
  * published by the Free Software Foundation.
  */
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/input.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
@@ -68,85 +69,71 @@ static struct gpio_keys_button pcm037_gpio_keys[] = {
 	{
 		.type	= EV_KEY,
 		.code	= KEY_L,
-		.gpio	= 0,
 		.desc	= "Wheel Manual",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= KEY_A,
-		.gpio	= 1,
 		.desc	= "Wheel AF",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= KEY_V,
-		.gpio	= 2,
 		.desc	= "Wheel View",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= KEY_M,
-		.gpio	= 3,
 		.desc	= "Wheel Menu",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= KEY_UP,
-		.gpio	= 32,
 		.desc	= "Nav Pad Up",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= KEY_RIGHT,
-		.gpio	= 33,
 		.desc	= "Nav Pad Right",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= KEY_DOWN,
-		.gpio	= 34,
 		.desc	= "Nav Pad Down",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= KEY_LEFT,
-		.gpio	= 35,
 		.desc	= "Nav Pad Left",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= KEY_ENTER,
-		.gpio	= 38,
 		.desc	= "Nav Pad Ok",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= KEY_O,
-		.gpio	= 39,
 		.desc	= "Wheel Off",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= BTN_FORWARD,
-		.gpio	= 50,
 		.desc	= "Focus Forward",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= BTN_BACK,
-		.gpio	= 51,
 		.desc	= "Focus Backward",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= BTN_MIDDLE,
-		.gpio	= 52,
 		.desc	= "Release Half",
 		.wakeup	= 0,
 	}, {
 		.type	= EV_KEY,
 		.code	= BTN_EXTRA,
-		.gpio	= 53,
 		.desc	= "Release Full",
 		.wakeup	= 0,
 	},
@@ -159,6 +146,42 @@ static const struct gpio_keys_platform_data
 	.rep		= 0, /* No auto-repeat */
 };
 
+static struct gpiod_lookup_table pcm037_gpio_keys_gpios_table = {
+	.dev_id = "gpio-keys",
+	.table = {
+		/* These are on the first GPIO chip */
+		GPIO_LOOKUP("imx31-gpio-0", 0, "Wheel Manual",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx31-gpio-0", 1, "Wheel AF",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx31-gpio-0", 2, "Wheel View",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx31-gpio-0", 3, "Wheel Menu",
+			    GPIO_ACTIVE_HIGH),
+		/* GPIOs 32..62 are simply offsets 0..31 on chip 1 */
+		GPIO_LOOKUP("imx31-gpio-1", 0, "Nav Pad Up",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx31-gpio-1", 1, "Nav Pad Right",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx31-gpio-1", 2, "Nav Pad Down",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx31-gpio-1", 3, "Nav Pad Left",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx31-gpio-1", 6, "Nav Pad Ok",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx31-gpio-1", 7, "Wheel Off",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx31-gpio-1", 18, "Focus Forward",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx31-gpio-1", 19, "Focus Backward",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx31-gpio-1", 20, "Release Half",
+			    GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("imx31-gpio-1", 21, "Release Full",
+			    GPIO_ACTIVE_HIGH),
+	},
+};
+
 int __init pcm037_eet_init_devices(void)
 {
 	if (pcm037_variant() != PCM037_EET)
@@ -171,6 +194,7 @@ int __init pcm037_eet_init_devices(void)
 	spi_register_board_info(pcm037_spi_dev, ARRAY_SIZE(pcm037_spi_dev));
 	imx31_add_spi_imx0(&pcm037_spi1_pdata);
 
+	gpiod_add_lookup_table(&pcm037_gpio_keys_gpios_table);
 	imx_add_gpio_keys(&pcm037_gpio_keys_platform_data);
 
 	return 0;
diff --git a/arch/arm/mach-imx/mach-vpr200.c b/arch/arm/mach-imx/mach-vpr200.c
index 5ff154c9a086..e8ca1a7b55fc 100644
--- a/arch/arm/mach-imx/mach-vpr200.c
+++ b/arch/arm/mach-imx/mach-vpr200.c
@@ -23,6 +23,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/memory.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -41,15 +42,6 @@
 #define GPIO_LCDPWR	IMX_GPIO_NR(1, 2)
 #define GPIO_PMIC_INT	IMX_GPIO_NR(2, 0)
 
-#define GPIO_BUTTON1	IMX_GPIO_NR(1, 4)
-#define GPIO_BUTTON2	IMX_GPIO_NR(1, 5)
-#define GPIO_BUTTON3	IMX_GPIO_NR(1, 7)
-#define GPIO_BUTTON4	IMX_GPIO_NR(1, 8)
-#define GPIO_BUTTON5	IMX_GPIO_NR(1, 9)
-#define GPIO_BUTTON6	IMX_GPIO_NR(1, 10)
-#define GPIO_BUTTON7	IMX_GPIO_NR(1, 11)
-#define GPIO_BUTTON8	IMX_GPIO_NR(1, 12)
-
 static const struct fb_videomode fb_modedb[] = {
 	{
 		/* 800x480 @ 60 Hz */
@@ -119,16 +111,66 @@ static const struct mxc_nand_platform_data
 	.flash_bbt = 1,
 };
 
+#define GPIO_BUTTON1	IMX_GPIO_NR(1, 4)
+#define GPIO_BUTTON2	IMX_GPIO_NR(1, 5)
+#define GPIO_BUTTON3	IMX_GPIO_NR(1, 7)
+#define GPIO_BUTTON4	IMX_GPIO_NR(1, 8)
+#define GPIO_BUTTON5	IMX_GPIO_NR(1, 9)
+#define GPIO_BUTTON6	IMX_GPIO_NR(1, 10)
+#define GPIO_BUTTON7	IMX_GPIO_NR(1, 11)
+#define GPIO_BUTTON8	IMX_GPIO_NR(1, 12)
+
+
 #define VPR_KEY_DEBOUNCE	500
 static struct gpio_keys_button vpr200_gpio_keys_table[] = {
-	{KEY_F2, GPIO_BUTTON1, 1, "vpr-keys: F2", 0, VPR_KEY_DEBOUNCE},
-	{KEY_F3, GPIO_BUTTON2, 1, "vpr-keys: F3", 0, VPR_KEY_DEBOUNCE},
-	{KEY_F4, GPIO_BUTTON3, 1, "vpr-keys: F4", 0, VPR_KEY_DEBOUNCE},
-	{KEY_F5, GPIO_BUTTON4, 1, "vpr-keys: F5", 0, VPR_KEY_DEBOUNCE},
-	{KEY_F6, GPIO_BUTTON5, 1, "vpr-keys: F6", 0, VPR_KEY_DEBOUNCE},
-	{KEY_F7, GPIO_BUTTON6, 1, "vpr-keys: F7", 0, VPR_KEY_DEBOUNCE},
-	{KEY_F8, GPIO_BUTTON7, 1, "vpr-keys: F8", 1, VPR_KEY_DEBOUNCE},
-	{KEY_F9, GPIO_BUTTON8, 1, "vpr-keys: F9", 1, VPR_KEY_DEBOUNCE},
+	{
+		.code = KEY_F2,
+		.desc = "vpr-keys: F2",
+		.type = 0,
+		.debounce_interval = VPR_KEY_DEBOUNCE,
+	},
+	{
+		.code = KEY_F3,
+		.desc = "vpr-keys: F3",
+		.type = 0,
+		.debounce_interval = VPR_KEY_DEBOUNCE,
+	},
+	{
+		.code = KEY_F4,
+		.desc = "vpr-keys: F4",
+		.type = 0,
+		.debounce_interval = VPR_KEY_DEBOUNCE,
+	},
+	{
+		.code = KEY_F5,
+		.desc = "vpr-keys: F5",
+		.type = 0,
+		.debounce_interval = VPR_KEY_DEBOUNCE,
+	},
+	{
+		.code = KEY_F6,
+		.desc = "vpr-keys: F6",
+		.type = 0,
+		.debounce_interval = VPR_KEY_DEBOUNCE,
+	},
+	{
+		.code = KEY_F7,
+		.desc = "vpr-keys: F7",
+		.type = 0,
+		.debounce_interval = VPR_KEY_DEBOUNCE,
+	},
+	{
+		.code = KEY_F8,
+		.desc = "vpr-keys: F8",
+		.type = 1,
+		.debounce_interval = VPR_KEY_DEBOUNCE,
+	},
+	{
+		.code = KEY_F9,
+		.desc = "vpr-keys: F9",
+		.type = 1,
+		.debounce_interval = VPR_KEY_DEBOUNCE,
+	},
 };
 
 static const struct gpio_keys_platform_data
@@ -137,6 +179,28 @@ static const struct gpio_keys_platform_data
 	.nbuttons = ARRAY_SIZE(vpr200_gpio_keys_table),
 };
 
+static struct gpiod_lookup_table vpr200_gpio_keys_gpios_table = {
+	.dev_id = "gpio-keys",
+	.table = {
+		GPIO_LOOKUP("imx35-gpio-0", 4, "vpr-keys: F2",
+			    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("imx35-gpio-0", 5, "vpr-keys: F3",
+			    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("imx35-gpio-0", 7, "vpr-keys: F4",
+			    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("imx35-gpio-0", 8, "vpr-keys: F5",
+			    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("imx35-gpio-0", 9, "vpr-keys: F6",
+			    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("imx35-gpio-0", 10, "vpr-keys: F7",
+			    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("imx35-gpio-0", 11, "vpr-keys: F8",
+			    GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP("imx35-gpio-0", 12, "vpr-keys: F9",
+			    GPIO_ACTIVE_LOW),
+	},
+};
+
 static struct mc13xxx_platform_data vpr200_pmic = {
 	.flags = MC13XXX_USE_ADC | MC13XXX_USE_TOUCHSCREEN,
 };
@@ -284,6 +348,7 @@ static void __init vpr200_board_init(void)
 
 static void __init vpr200_late_init(void)
 {
+	gpiod_add_lookup_table(&vpr200_gpio_keys_gpios_table);
 	imx_add_gpio_keys(&vpr200_gpio_keys_data);
 
 	platform_add_devices(devices, ARRAY_SIZE(devices));
-- 
2.14.3

