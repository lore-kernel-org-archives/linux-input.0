From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v2 4/5] ARM: S5PV210: Add keypad device to the Aquila board
Date: Sun, 30 May 2010 12:06:23 +0900
Message-ID: <1275188784-23395-4-git-send-email-jy0922.shim@samsung.com>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, kyungmin.park@samsung.com, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

This patch is to support keypad device to the Aquila board.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig       |    2 ++
 arch/arm/mach-s5pv210/mach-aquila.c |   25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 6f41b2d..25b9e96 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -55,8 +55,10 @@ config MACH_AQUILA
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
 	select S5PV210_SETUP_FB_24BPP
+	select S5PV210_SETUP_KEYPAD
 	select S3C_DEV_FB
 	select S5PC110_DEV_ONENAND
+	select SAMSUNG_DEV_KEYPAD
 	help
 	  Machine support for the Samsung Aquila target based on S5PC110 SoC
 
diff --git a/arch/arm/mach-s5pv210/mach-aquila.c b/arch/arm/mach-s5pv210/mach-aquila.c
index fb9dbb2..526fed8 100644
--- a/arch/arm/mach-s5pv210/mach-aquila.c
+++ b/arch/arm/mach-s5pv210/mach-aquila.c
@@ -28,6 +28,7 @@
 #include <plat/devs.h>
 #include <plat/cpu.h>
 #include <plat/fb.h>
+#include <plat/keypad.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -116,9 +117,30 @@ static struct s3c_fb_platdata aquila_lcd_pdata __initdata = {
 	.setup_gpio	= s5pv210_fb_gpio_setup_24bpp,
 };
 
+/* KEYPAD */
+static uint32_t keymap[] __initdata = {
+	/* KEY(row, col, keycode) */
+	KEY(0, 0, KEY_CAMERA),		/* Full Shot */
+	KEY(0, 1, KEY_VOLUMEUP),
+	KEY(1, 0, KEY_CONFIG),		/* Halt Shot */
+	KEY(1, 1, KEY_VOLUMEDOWN),
+};
+
+static struct matrix_keymap_data keymap_data __initdata = {
+	.keymap		= keymap,
+	.keymap_size	= ARRAY_SIZE(keymap),
+};
+
+static struct samsung_kp_platdata keypad_data __initdata = {
+	.keymap_data	= &keymap_data,
+	.rows		= 2,
+	.cols		= 3,
+};
+
 static struct platform_device *aquila_devices[] __initdata = {
 	&s3c_device_fb,
 	&s5pc110_device_onenand,
+	&samsung_device_keypad,
 };
 
 static void __init aquila_map_io(void)
@@ -133,6 +155,9 @@ static void __init aquila_machine_init(void)
 	/* FB */
 	s3c_fb_set_platdata(&aquila_lcd_pdata);
 
+	/* KEYPAD */
+	samsung_kp_set_platdata(&keypad_data);
+
 	platform_add_devices(aquila_devices, ARRAY_SIZE(aquila_devices));
 }
 
-- 
1.7.0.4
