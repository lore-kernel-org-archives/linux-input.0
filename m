From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 12/12] pxa: add keypad support for littleton
Date: Wed, 23 Jan 2008 15:34:43 +0800
Message-ID: <f17812d70801222334l193bcc7dm9e48ac4c8d0cdeff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:9158 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379AbYAWHeq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 02:34:46 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4888583wah.23
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2008 23:34:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>From eb2afcf90ff3566519db18b8f502e750ef4a5c53 Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Wed, 23 Jan 2008 15:07:22 +0800
Subject: [PATCH] pxa: add keypad support for littleton

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/littleton.c |   65 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 0a4b54c..9020a79 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -37,6 +37,7 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/pxafb.h>
 #include <asm/arch/ssp.h>
+#include <asm/arch/pxa27x_keypad.h>
 #include <asm/arch/littleton.h>

 #include "generic.h"
@@ -76,6 +77,21 @@ static mfp_cfg_t littleton_mfp_cfg[] __initdata = {

 	/* Debug Ethernet */
 	GPIO90_GPIO,
+
+	/* Keypad */
+	GPIO107_KP_DKIN_0,
+	GPIO108_KP_DKIN_1,
+	GPIO115_KP_MKIN_0,
+	GPIO116_KP_MKIN_1,
+	GPIO117_KP_MKIN_2,
+	GPIO118_KP_MKIN_3,
+	GPIO119_KP_MKIN_4,
+	GPIO120_KP_MKIN_5,
+	GPIO121_KP_MKOUT_0,
+	GPIO122_KP_MKOUT_1,
+	GPIO123_KP_MKOUT_2,
+	GPIO124_KP_MKOUT_3,
+	GPIO125_KP_MKOUT_4,
 };

 static struct resource smc91x_resources[] = {
@@ -300,6 +316,54 @@ static void littleton_init_lcd(void)
 static inline void littleton_init_lcd(void) {};
 #endif /* CONFIG_FB_PXA || CONFIG_FB_PXA_MODULES */

+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULES)
+static unsigned int littleton_matrix_key_map[] = {
+	/* KEY(row, col, key_code) */
+	KEY(1, 3, KEY_0), KEY(0, 0, KEY_1), KEY(1, 0, KEY_2), KEY(2, 0, KEY_3),
+	KEY(0, 1, KEY_4), KEY(1, 1, KEY_5), KEY(2, 1, KEY_6), KEY(0, 2, KEY_7),
+	KEY(1, 2, KEY_8), KEY(2, 2, KEY_9),
+
+	KEY(0, 3, KEY_KPASTERISK), 	/* * */
+	KEY(2, 3, KEY_KPDOT), 		/* # */
+
+	KEY(5, 4, KEY_ENTER),
+
+	KEY(5, 0, KEY_UP),
+	KEY(5, 1, KEY_DOWN),
+	KEY(5, 2, KEY_LEFT),
+	KEY(5, 3, KEY_RIGHT),
+	KEY(3, 2, KEY_HOME),
+	KEY(4, 1, KEY_END),
+	KEY(3, 3, KEY_BACK),
+
+	KEY(4, 0, KEY_SEND),
+	KEY(4, 2, KEY_VOLUMEUP),
+	KEY(4, 3, KEY_VOLUMEDOWN),
+
+	KEY(3, 0, KEY_F22),	/* soft1 */
+	KEY(3, 1, KEY_F23),	/* soft2 */
+};
+
+static struct pxa27x_keypad_platform_data littleton_keypad_info = {
+	.matrix_key_rows	= 6,
+	.matrix_key_cols	= 5,
+	.matrix_key_map		= littleton_matrix_key_map,
+	.matrix_key_map_size	= ARRAY_SIZE(littleton_matrix_key_map),
+
+	.enable_rotary0		= 1,
+	.rotary0_up_key		= KEY_UP,
+	.rotary0_down_key	= KEY_DOWN,
+
+	.debounce_interval	= 30,
+};
+static void __init littleton_init_keypad(void)
+{
+	pxa_set_keypad_info(&littleton_keypad_info);
+}
+#else
+static inline void littleton_init_keypad(void) {}
+#endif
+
 static void __init littleton_init(void)
 {
 	/* initialize MFP configurations */
@@ -312,6 +376,7 @@ static void __init littleton_init(void)
 	platform_device_register(&smc91x_device);

 	littleton_init_lcd();
+	littleton_init_keypad();
 }

 MACHINE_START(LITTLETON, "Marvell Form Factor Development Platform
(aka Littleton)")
-- 
1.5.2.5.GIT



-- 
Cheers
- eric
