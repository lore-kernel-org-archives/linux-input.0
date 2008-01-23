From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 11/12] pxa: add keypad support for zylonite
Date: Wed, 23 Jan 2008 15:33:45 +0800
Message-ID: <f17812d70801222333i70ce97acxc37dd1aca0a62a22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:5930 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753976AbYAWHeG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 02:34:06 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4888216wah.23
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2008 23:33:45 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>From 8065026932f4433551296a1d98499d8ccefd6cc6 Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Wed, 23 Jan 2008 14:25:50 +0800
Subject: [PATCH] pxa: add keypad support for zylonite

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/zylonite.c |   67 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index 7731d50..1b7886c 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -26,6 +26,7 @@
 #include <asm/arch/pxafb.h>
 #include <asm/arch/zylonite.h>
 #include <asm/arch/mmc.h>
+#include <asm/arch/pxa27x_keypad.h>

 #include "generic.h"

@@ -249,6 +250,71 @@ static void __init zylonite_init_mmc(void)
 static inline void zylonite_init_mmc(void) {}
 #endif

+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULES)
+static unsigned int zylonite_matrix_key_map[] = {
+	/* KEY(row, col, key_code) */
+	KEY(0, 0, KEY_A), KEY(0, 1, KEY_B), KEY(0, 2, KEY_C), KEY(0, 5, KEY_D),
+	KEY(1, 0, KEY_E), KEY(1, 1, KEY_F), KEY(1, 2, KEY_G), KEY(1, 5, KEY_H),
+	KEY(2, 0, KEY_I), KEY(2, 1, KEY_J), KEY(2, 2, KEY_K), KEY(2, 5, KEY_L),
+	KEY(3, 0, KEY_M), KEY(3, 1, KEY_N), KEY(3, 2, KEY_O), KEY(3, 5, KEY_P),
+	KEY(5, 0, KEY_Q), KEY(5, 1, KEY_R), KEY(5, 2, KEY_S), KEY(5, 5, KEY_T),
+	KEY(6, 0, KEY_U), KEY(6, 1, KEY_V), KEY(6, 2, KEY_W), KEY(6, 5, KEY_X),
+	KEY(7, 1, KEY_Y), KEY(7, 2, KEY_Z),
+
+	KEY(4, 4, KEY_0), KEY(1, 3, KEY_1), KEY(4, 1, KEY_2), KEY(1, 4, KEY_3),
+	KEY(2, 3, KEY_4), KEY(4, 2, KEY_5), KEY(2, 4, KEY_6), KEY(3, 3, KEY_7),
+	KEY(4, 3, KEY_8), KEY(3, 4, KEY_9),
+
+	KEY(4, 5, KEY_SPACE),
+	KEY(5, 3, KEY_KPASTERISK), 	/* * */
+	KEY(5, 4, KEY_KPDOT), 		/* #" */
+
+	KEY(0, 7, KEY_UP),
+	KEY(1, 7, KEY_DOWN),
+	KEY(2, 7, KEY_LEFT),
+	KEY(3, 7, KEY_RIGHT),
+	KEY(2, 6, KEY_HOME),
+	KEY(3, 6, KEY_END),
+	KEY(6, 4, KEY_DELETE),
+	KEY(6, 6, KEY_BACK),
+	KEY(6, 3, KEY_CAPSLOCK),	/* KEY_LEFTSHIFT), */
+
+	KEY(4, 6, KEY_ENTER),		/* scroll push */
+	KEY(5, 7, KEY_ENTER),		/* keypad action */
+
+	KEY(0, 4, KEY_EMAIL),
+	KEY(5, 6, KEY_SEND),
+	KEY(4, 0, KEY_CALENDAR),
+	KEY(7, 6, KEY_RECORD),
+	KEY(6, 7, KEY_VOLUMEUP),
+	KEY(7, 7, KEY_VOLUMEDOWN),
+
+	KEY(0, 6, KEY_F22),	/* soft1 */
+	KEY(1, 6, KEY_F23),	/* soft2 */
+	KEY(0, 3, KEY_AUX),	/* contact */
+};
+
+static struct pxa27x_keypad_platform_data zylonite_keypad_info = {
+	.matrix_key_rows	= 8,
+	.matrix_key_cols	= 8,
+	.matrix_key_map		= zylonite_matrix_key_map,
+	.matrix_key_map_size	= ARRAY_SIZE(zylonite_matrix_key_map),
+
+	.enable_rotary0		= 1,
+	.rotary0_up_key		= KEY_UP,
+	.rotary0_down_key	= KEY_DOWN,
+
+	.debounce_interval	= 30,
+};
+
+static void __init zylonite_init_keypad(void)
+{
+	pxa_set_keypad_info(&zylonite_keypad_info);
+}
+#else
+static inline void zylonite_init_keypad(void) {}
+#endif
+
 static void __init zylonite_init(void)
 {
 	/* board-processor specific initialization */
@@ -265,6 +331,7 @@ static void __init zylonite_init(void)

 	zylonite_init_lcd();
 	zylonite_init_mmc();
+	zylonite_init_keypad();
 }

 MACHINE_START(ZYLONITE, "PXA3xx Platform Development Kit (aka Zylonite)")
-- 
1.5.2.5.GIT



-- 
Cheers
- eric
