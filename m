From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 9/12] pxa: add partial keypad support for mainstone
Date: Wed, 23 Jan 2008 15:33:14 +0800
Message-ID: <f17812d70801222333n711bab14mdaaeba28712264b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.182]:5382 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753861AbYAWHeF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 02:34:05 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4888014wah.23
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2008 23:33:14 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>From da4639bc84a0d5f654015523d601b4ddac2f474c Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Wed, 23 Jan 2008 14:25:27 +0800
Subject: [PATCH] pxa: add partial keypad support for mainstone

This is partial because mainstone's keypad is really special, some of
the keys like '1', '2', ... are actually connected to two row/column
juntions, thus pressing '1' is equivalent to pressing 'A' & 'H'.

This is really brain damanged since it makes distinguishing between
pressing '1' and multiple keys pressing of 'A' & 'H' difficult.

So these special keys are not supported for the time being.

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/mainstone.c |   69 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 3faa817..5fbaafe 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -46,6 +46,7 @@
 #include <asm/arch/mmc.h>
 #include <asm/arch/irda.h>
 #include <asm/arch/ohci.h>
+#include <asm/arch/pxa27x_keypad.h>

 #include "generic.h"
 #include "devices.h"
@@ -462,6 +463,72 @@ static struct pxaohci_platform_data
mainstone_ohci_platform_data = {
 	.init		= mainstone_ohci_init,
 };

+#if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULES)
+static unsigned int mainstone_matrix_keys[] = {
+	KEY(0, 0, KEY_A), KEY(1, 0, KEY_B), KEY(2, 0, KEY_C),
+	KEY(3, 0, KEY_D), KEY(4, 0, KEY_E), KEY(5, 0, KEY_F),
+	KEY(0, 1, KEY_G), KEY(1, 1, KEY_H), KEY(2, 1, KEY_I),
+	KEY(3, 1, KEY_J), KEY(4, 1, KEY_K), KEY(5, 1, KEY_L),
+	KEY(0, 2, KEY_M), KEY(1, 2, KEY_N), KEY(2, 2, KEY_O),
+	KEY(3, 2, KEY_P), KEY(4, 2, KEY_Q), KEY(5, 2, KEY_R),
+	KEY(0, 3, KEY_S), KEY(1, 3, KEY_T), KEY(2, 3, KEY_U),
+	KEY(3, 3, KEY_V), KEY(4, 3, KEY_W), KEY(5, 3, KEY_X),
+	KEY(2, 4, KEY_Y), KEY(3, 4, KEY_Z),
+
+	KEY(0, 4, KEY_DOT),	/* . */
+	KEY(1, 4, KEY_CLOSE),	/* @ */
+	KEY(4, 4, KEY_SLASH),
+	KEY(5, 4, KEY_BACKSLASH),
+	KEY(0, 5, KEY_HOME),
+	KEY(1, 5, KEY_LEFTSHIFT),
+	KEY(2, 5, KEY_SPACE),
+	KEY(3, 5, KEY_SPACE),
+	KEY(4, 5, KEY_ENTER),
+	KEY(5, 5, KEY_BACKSPACE),
+
+	KEY(0, 6, KEY_UP),
+	KEY(1, 6, KEY_DOWN),
+	KEY(2, 6, KEY_LEFT),
+	KEY(3, 6, KEY_RIGHT),
+	KEY(4, 6, KEY_SELECT),
+};
+
+struct pxa27x_keypad_platform_data mainstone_keypad_info = {
+	.matrix_key_rows	= 6,
+	.matrix_key_cols	= 7,
+	.matrix_key_map		= mainstone_matrix_keys,
+	.matrix_key_map_size	= ARRAY_SIZE(mainstone_matrix_keys),
+
+	.enable_rotary0		= 1,
+	.rotary0_up_key		= KEY_UP,
+	.rotary0_down_key	= KEY_DOWN,
+
+	.debounce_interval	= 30,
+};
+
+static void __init mainstone_init_keypad(void)
+{
+	pxa_gpio_mode(100 | GPIO_ALT_FN_1_IN);  /* MKIN0 */
+	pxa_gpio_mode(101 | GPIO_ALT_FN_1_IN);  /* MKIN1 */
+	pxa_gpio_mode(102 | GPIO_ALT_FN_1_IN);  /* MKIN2 */
+	pxa_gpio_mode( 97 | GPIO_ALT_FN_3_IN);  /* MKIN3 */
+	pxa_gpio_mode( 98 | GPIO_ALT_FN_3_IN);  /* MKIN4 */
+	pxa_gpio_mode( 99 | GPIO_ALT_FN_3_IN);  /* MKIN5 */
+	pxa_gpio_mode(103 | GPIO_ALT_FN_2_OUT); /* MKOUT0 */
+	pxa_gpio_mode(104 | GPIO_ALT_FN_2_OUT); /* MKOUT1 */
+	pxa_gpio_mode(105 | GPIO_ALT_FN_2_OUT); /* MKOUT2 */
+	pxa_gpio_mode(106 | GPIO_ALT_FN_2_OUT); /* MKOUT3 */
+	pxa_gpio_mode(107 | GPIO_ALT_FN_2_OUT); /* MKOUT4 */
+	pxa_gpio_mode(108 | GPIO_ALT_FN_2_OUT); /* MKOUT5 */
+	pxa_gpio_mode( 93 | GPIO_ALT_FN_1_IN);	/* DKIN0 */
+	pxa_gpio_mode( 94 | GPIO_ALT_FN_1_IN);	/* DKIN1 */
+
+	pxa_set_keypad_info(&mainstone_keypad_info);
+}
+#else
+static inline void mainstone_init_keypad(void) { }
+#endif
+
 static void __init mainstone_init(void)
 {
 	int SW7 = 0;  /* FIXME: get from SCR (Mst doc section 3.2.1.1) */
@@ -522,6 +589,8 @@ static void __init mainstone_init(void)
 	pxa_set_mci_info(&mainstone_mci_platform_data);
 	pxa_set_ficp_info(&mainstone_ficp_platform_data);
 	pxa_set_ohci_info(&mainstone_ohci_platform_data);
+
+	mainstone_init_keypad();
 }


-- 
1.5.2.5.GIT



-- 
Cheers
- eric
