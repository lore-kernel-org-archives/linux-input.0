From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: [PATCH v2 3/5] ARM: S5PV210: Add keypad device to the GONI board
Date: Sun, 30 May 2010 12:06:22 +0900
Message-ID: <1275188784-23395-3-git-send-email-jy0922.shim@samsung.com>
References: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:44415 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab0E3DJZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 May 2010 23:09:25 -0400
In-reply-to: <1275188784-23395-1-git-send-email-jy0922.shim@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ben-linux@fluff.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, kyungmin.park@samsung.com, dmitry.torokhov@gmail.com

This patch is to support keypad device to the GONI board.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig     |    2 ++
 arch/arm/mach-s5pv210/mach-goni.c |   26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 04d3992..6f41b2d 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -64,7 +64,9 @@ config MACH_GONI
 	bool "GONI"
 	select CPU_S5PV210
 	select ARCH_SPARSEMEM_ENABLE
+	select S5PV210_SETUP_KEYPAD
 	select S5PC110_DEV_ONENAND
+	select SAMSUNG_DEV_KEYPAD
 	help
 	  Machine support for Samsung GONI board
 	  S5PC110(MCP) is one of package option of S5PV210
diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index bea812f..cb46d21 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -25,6 +25,7 @@
 #include <plat/s5pv210.h>
 #include <plat/devs.h>
 #include <plat/cpu.h>
+#include <plat/keypad.h>
 
 /* Following are default values for UCON, ULCON and UFCON UART registers */
 #define S5PV210_UCON_DEFAULT	(S3C2410_UCON_TXILEVEL |	\
@@ -71,8 +72,30 @@ static struct s3c2410_uartcfg goni_uartcfgs[] __initdata = {
 	},
 };
 
+/* KEYPAD */
+static uint32_t keymap[] __initdata = {
+	/* KEY(row, col, keycode) */
+	KEY(0, 1, KEY_MENU),		/* Send */
+	KEY(0, 2, KEY_BACK),		/* End */
+	KEY(1, 1, KEY_CONFIG),		/* Half shot */
+	KEY(1, 2, KEY_VOLUMEUP),
+	KEY(2, 1, KEY_CAMERA),		/* Full shot */
+	KEY(2, 2, KEY_VOLUMEDOWN),
+};
+
+static struct matrix_keymap_data keymap_data __initdata = {
+	.keymap		= keymap,
+	.keymap_size	= ARRAY_SIZE(keymap),
+};
+
+static struct samsung_kp_platdata keypad_data __initdata = {
+	.keymap_data	= &keymap_data,
+	.rows		= 3,
+	.cols		= 3,
+};
 static struct platform_device *goni_devices[] __initdata = {
 	&s5pc110_device_onenand,
+	&samsung_device_keypad,
 };
 
 static void __init goni_map_io(void)
@@ -84,6 +107,9 @@ static void __init goni_map_io(void)
 
 static void __init goni_machine_init(void)
 {
+	/* KEYPAD */
+	samsung_kp_set_platdata(&keypad_data);
+
 	platform_add_devices(goni_devices, ARRAY_SIZE(goni_devices));
 }
 
-- 
1.7.0.4

