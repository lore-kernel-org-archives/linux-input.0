From: jsgood.yang@samsung.com
Subject: [PATCH 4/4] [ARM][S3C] Add support keypad platform data
Date: Wed,  9 Sep 2009 20:11:44 +0900
Message-ID: <1252494704-17895-1-git-send-email-jsgood.yang@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ganesha.gnumonks.org ([213.95.27.120]:40177 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbZIILRf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 07:17:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, ben-linux@fluff.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jinsung Yang <jsgood.yang@samsung.com>, Kyeongil Kim <ki0351.kim@samsung.com>

From: Jinsung Yang <jsgood.yang@samsung.com>

This patch contains smdk6410 keypad platform data which includes
smdk6410 evalutation QWERTY keyboard map and gpio configuration
function.

Signed-off-by: Jinsung Yang <jsgood.yang@samsung.com>
Signed-off-by: Kyeongil Kim <ki0351.kim@samsung.com>
---
 arch/arm/mach-s3c6410/mach-smdk6410.c |   50 +++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c6410/mach-smdk6410.c b/arch/arm/mach-s3c6410/mach-smdk6410.c
index bc9a7de..8fb3116 100644
--- a/arch/arm/mach-s3c6410/mach-smdk6410.c
+++ b/arch/arm/mach-s3c6410/mach-smdk6410.c
@@ -25,6 +25,7 @@
 #include <linux/gpio.h>
 #include <linux/delay.h>
 #include <linux/smsc911x.h>
+#include <linux/input.h>
 
 #ifdef CONFIG_SMDK6410_WM1190_EV1
 #include <linux/mfd/wm8350/core.h>
@@ -50,6 +51,7 @@
 #include <plat/regs-sys.h>
 #include <plat/iic.h>
 #include <plat/fb.h>
+#include <plat/keypad.h>
 #include <plat/gpio-cfg.h>
 
 #include <plat/s3c6410.h>
@@ -184,6 +186,7 @@ static struct platform_device *smdk6410_devices[] __initdata = {
 	&s3c_device_fb,
 	&s3c_device_usb,
 	&s3c_device_usb_hsotg,
+	&s3c_device_keypad,
 	&smdk6410_lcd_powerdev,
 
 	&smdk6410_smsc911x,
@@ -337,6 +340,50 @@ static struct i2c_board_info i2c_devs1[] __initdata = {
 	{ I2C_BOARD_INFO("24c128", 0x57), },	/* Samsung S524AD0XD1 */
 };
 
+static unsigned short smdk6410_keycode[] = {
+	KEY_RESERVED, KEY_RESERVED, KEY_1, KEY_Q, KEY_A, KEY_RESERVED,
+	KEY_RESERVED, KEY_LEFT, KEY_RESERVED, KEY_RESERVED, KEY_2, KEY_W,
+	KEY_S, KEY_Z, KEY_RIGHT, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED,
+	KEY_3, KEY_E, KEY_D, KEY_X, KEY_RESERVED, KEY_UP, KEY_RESERVED,
+	KEY_RESERVED, KEY_4, KEY_R, KEY_F, KEY_C, KEY_RESERVED, KEY_RESERVED,
+	KEY_RESERVED, KEY_O, KEY_5, KEY_T, KEY_G, KEY_V, KEY_DOWN,
+	KEY_BACKSPACE, KEY_P, KEY_0, KEY_6, KEY_Y, KEY_H, KEY_SPACE,
+	KEY_RESERVED, KEY_RESERVED, KEY_M, KEY_L, KEY_7, KEY_U, KEY_J, KEY_N,
+	KEY_RESERVED, KEY_ENTER, KEY_LEFTSHIFT, KEY_9, KEY_8, KEY_I, KEY_K,
+	KEY_B, KEY_RESERVED, KEY_COMMA,
+};
+
+static struct s3c_platform_keypad keypad_data __initdata = {
+	.nr_rows = 8,
+	.nr_cols = 8,
+	.max_keys = 64,
+	.max_masks = 32,
+	.delay = 50,
+	.keymap = smdk6410_keycode,
+};
+
+static void s3c_keypad_cfg_gpio(int rows, int columns)
+{
+	unsigned int gpio;
+	unsigned int end;
+
+	end = S3C64XX_GPK(8 + rows);
+
+	/* Set all the necessary GPK pins to special-function 0 */
+	for (gpio = S3C64XX_GPK(8); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+
+	end = S3C64XX_GPL(0 + columns);
+
+	/* Set all the necessary GPK pins to special-function 0 */
+	for (gpio = S3C64XX_GPL(0); gpio < end; gpio++) {
+		s3c_gpio_cfgpin(gpio, S3C_GPIO_SFN(3));
+		s3c_gpio_setpull(gpio, S3C_GPIO_PULL_NONE);
+	}
+}
+
 static void __init smdk6410_map_io(void)
 {
 	u32 tmp;
@@ -371,6 +418,9 @@ static void __init smdk6410_machine_init(void)
 	i2c_register_board_info(0, i2c_devs0, ARRAY_SIZE(i2c_devs0));
 	i2c_register_board_info(1, i2c_devs1, ARRAY_SIZE(i2c_devs1));
 
+	s3c_keypad_set_platdata(&keypad_data);
+	s3c_keypad_cfg_gpio(keypad_data.nr_rows, keypad_data.nr_cols);
+
 	platform_add_devices(smdk6410_devices, ARRAY_SIZE(smdk6410_devices));
 }
 
-- 
1.6.2.5

