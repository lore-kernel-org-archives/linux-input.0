From: Daniel Walker <dwalker@codeaurora.org>
Subject: [PATCH] msm: trout: add keypad support
Date: Wed,  8 Dec 2010 16:24:45 -0800
Message-ID: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:60381 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753767Ab0LIAZH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Dec 2010 19:25:07 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-arm-msm@vger.kernel.org
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tsoni@codeaurora.org, arve@android.com, Daniel Walker <dwalker@codeaurora.org>

This adds matrix keypad support, and gpio buttons support for
trout's various keys and buttons.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
---
 arch/arm/mach-msm/Makefile             |    2 +-
 arch/arm/mach-msm/board-trout-keypad.c |  342 ++++++++++++++++++++++++++++++++
 2 files changed, 343 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-msm/board-trout-keypad.c

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 3abe889..a11b4e9 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -20,7 +20,7 @@ obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
 obj-$(CONFIG_MSM_SMD) += last_radio_log.o
 
 obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o devices-msm7x00.o
-obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o board-trout-panel.o devices-msm7x00.o
+obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o board-trout-panel.o devices-msm7x00.o board-trout-keypad.o
 obj-$(CONFIG_MACH_HALIBUT) += board-halibut.o devices-msm7x00.o
 obj-$(CONFIG_ARCH_MSM7X30) += board-msm7x30.o devices-msm7x30.o
 obj-$(CONFIG_ARCH_QSD8X50) += board-qsd8x50.o devices-qsd8x50.o
diff --git a/arch/arm/mach-msm/board-trout-keypad.c b/arch/arm/mach-msm/board-trout-keypad.c
new file mode 100644
index 0000000..ce0dfab
--- /dev/null
+++ b/arch/arm/mach-msm/board-trout-keypad.c
@@ -0,0 +1,342 @@
+/* arch/arm/mach-msm/board-trout-keypad.c
+ *
+ * Copyright (C) 2008 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful),
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/input/matrix_keypad.h>
+#include <linux/gpio_keys.h>
+#include <asm/mach-types.h>
+
+#include "board-trout.h"
+
+static char *keycaps = "--qwerty";
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "board_trout."
+module_param_named(keycaps, keycaps, charp, 0);
+
+
+static unsigned int trout_col_gpios[] = { 35, 34, 33, 32, 31, 23, 30, 78 };
+static unsigned int trout_row_gpios[] = { 42, 41, 40, 39, 38, 37, 36 };
+
+static const uint32_t trout_keymap[] = {
+	KEY(0, 0, KEY_BACK),
+	KEY(1, 0, KEY_HOME),
+	KEY(3, 0, KEY_BACKSPACE),
+	KEY(4, 0, KEY_ENTER),
+	KEY(5, 0, KEY_RIGHTALT),
+	KEY(6, 0, KEY_P),
+
+	KEY(0, 1, KEY_MENU),
+	KEY(1, 1, KEY_SEND),
+	KEY(2, 1, KEY_END),
+	KEY(3, 1, KEY_LEFTALT),
+	KEY(4, 1, KEY_A),
+	KEY(5, 1, KEY_LEFTSHIFT),
+	KEY(6, 1, KEY_Q),
+
+	KEY(0, 2, KEY_U),
+	KEY(1, 2, KEY_7),
+	KEY(2, 2, KEY_K),
+	KEY(3, 2, KEY_J),
+	KEY(4, 2, KEY_M),
+	KEY(5, 2, KEY_SLASH),
+	KEY(6, 2, KEY_8),
+
+	KEY(0, 3, KEY_5),
+	KEY(1, 3, KEY_6),
+	KEY(2, 3, KEY_B),
+	KEY(3, 3, KEY_H),
+	KEY(4, 3, KEY_N),
+	KEY(5, 3, KEY_SPACE),
+	KEY(6, 3, KEY_Y),
+
+	KEY(0, 4, KEY_4),
+	KEY(1, 4, KEY_R),
+	KEY(2, 4, KEY_V),
+	KEY(3, 4, KEY_G),
+	KEY(4, 4, KEY_C),
+	KEY(6, 4, KEY_T),
+
+	KEY(0, 5, KEY_2),
+	KEY(1, 5, KEY_W),
+	KEY(2, 5, KEY_COMPOSE),
+	KEY(3, 5, KEY_VOLUMEUP),
+	KEY(4, 5, KEY_S),
+	KEY(5, 5, KEY_Z),
+	KEY(6, 5, KEY_1),
+
+	KEY(0, 6, KEY_I),
+	KEY(1, 6, KEY_0),
+	KEY(2, 6, KEY_O),
+	KEY(3, 6, KEY_L),
+	KEY(4, 6, KEY_DOT),
+	KEY(5, 6, KEY_COMMA),
+	KEY(6, 6, KEY_9),
+
+	KEY(0, 7, KEY_3),
+	KEY(1, 7, KEY_E),
+	KEY(2, 7, KEY_EMAIL), /* @ */
+	KEY(3, 7, KEY_VOLUMEDOWN),
+	KEY(4, 7, KEY_X),
+	KEY(5, 7, KEY_F),
+	KEY(6, 7, KEY_D),
+};
+
+static unsigned int trout_col_gpios_evt2[] = { 35, 34, 33, 32, 31, 23, 30, 109 };
+static unsigned int trout_row_gpios_evt2[] = { 42, 41, 40, 39, 38, 37, 36 };
+
+static const uint32_t trout_keymap_evt2_1[] = {
+	KEY(0, 0, KEY_BACK),
+	KEY(1, 0, KEY_HOME),
+	KEY(3, 0, KEY_BACKSPACE),
+	KEY(4, 0, KEY_ENTER),
+	KEY(5, 0, KEY_RIGHTSHIFT),
+	KEY(6, 0, KEY_P),
+
+	KEY(0, 1, KEY_MENU),
+	KEY(1, 1, KEY_SEND),
+	KEY(3, 1, KEY_LEFTSHIFT),
+	KEY(4, 1, KEY_A),
+	KEY(5, 1, KEY_COMPOSE),
+	KEY(6, 1, KEY_Q),
+
+	KEY(0, 2, KEY_U),
+	KEY(1, 2, KEY_7),
+	KEY(2, 2, KEY_K),
+	KEY(3, 2, KEY_J),
+	KEY(4, 2, KEY_M),
+	KEY(5, 2, KEY_SLASH),
+	KEY(6, 2, KEY_8),
+
+	KEY(0, 3, KEY_5),
+	KEY(1, 3, KEY_6),
+	KEY(2, 3, KEY_B),
+	KEY(3, 3, KEY_H),
+	KEY(4, 3, KEY_N),
+	KEY(5, 3, KEY_SPACE),
+	KEY(6, 3, KEY_Y),
+
+	KEY(0, 4, KEY_4),
+	KEY(1, 4, KEY_R),
+	KEY(2, 4, KEY_V),
+	KEY(3, 4, KEY_G),
+	KEY(4, 4, KEY_C),
+	KEY(6, 4, KEY_T),
+
+	KEY(0, 5, KEY_2),
+	KEY(1, 5, KEY_W),
+	KEY(2, 5, KEY_LEFTALT),
+	KEY(3, 5, KEY_VOLUMEUP),
+	KEY(4, 5, KEY_S),
+	KEY(5, 5, KEY_Z),
+	KEY(6, 5, KEY_1),
+
+	KEY(0, 6, KEY_I),
+	KEY(1, 6, KEY_0),
+	KEY(2, 6, KEY_O),
+	KEY(3, 6, KEY_L),
+	KEY(4, 6, KEY_COMMA),
+	KEY(5, 6, KEY_DOT),
+	KEY(6, 6, KEY_9),
+
+	KEY(0, 7, KEY_3),
+	KEY(1, 7, KEY_E),
+	KEY(2, 7, KEY_EMAIL), /* @ */
+	KEY(3, 7, KEY_VOLUMEDOWN),
+	KEY(4, 7, KEY_X),
+	KEY(5, 7, KEY_F),
+	KEY(6, 7, KEY_D),
+};
+
+static const uint32_t trout_keymap_evt2_2[] = {
+	KEY(0, 0, KEY_BACK),
+	KEY(1, 0, KEY_HOME),
+	KEY(3, 0, KEY_BACKSPACE),
+	KEY(4, 0, KEY_ENTER),
+	KEY(5, 0, KEY_RIGHTSHIFT),
+	KEY(6, 0, KEY_P),
+
+	KEY(0, 1, KEY_MENU), /* external menu key */
+	KEY(1, 1, KEY_SEND),
+	KEY(3, 1, KEY_LEFTSHIFT),
+	KEY(4, 1, KEY_A),
+	KEY(5, 1, KEY_F1), /* qwerty menu key */
+	KEY(6, 1, KEY_Q),
+
+	KEY(0, 2, KEY_U),
+	KEY(1, 2, KEY_7),
+	KEY(2, 2, KEY_K),
+	KEY(3, 2, KEY_J),
+	KEY(4, 2, KEY_M),
+	KEY(5, 2, KEY_DOT),
+	KEY(6, 2, KEY_8),
+
+	KEY(0, 3, KEY_5),
+	KEY(1, 3, KEY_6),
+	KEY(2, 3, KEY_B),
+	KEY(3, 3, KEY_H),
+	KEY(4, 3, KEY_N),
+	KEY(5, 3, KEY_SPACE),
+	KEY(6, 3, KEY_Y),
+
+	KEY(0, 4, KEY_4),
+	KEY(1, 4, KEY_R),
+	KEY(2, 4, KEY_V),
+	KEY(3, 4, KEY_G),
+	KEY(4, 4, KEY_C),
+	KEY(5, 4, KEY_EMAIL), /* @ */
+	KEY(6, 4, KEY_T),
+
+	KEY(0, 5, KEY_2),
+	KEY(1, 5, KEY_W),
+	KEY(2, 5, KEY_LEFTALT),
+	KEY(3, 5, KEY_VOLUMEUP),
+	KEY(4, 5, KEY_S),
+	KEY(5, 5, KEY_Z),
+	KEY(6, 5, KEY_1),
+
+	KEY(0, 6, KEY_I),
+	KEY(1, 6, KEY_0),
+	KEY(2, 6, KEY_O),
+	KEY(3, 6, KEY_L),
+	KEY(4, 6, KEY_COMMA),
+	KEY(5, 6, KEY_RIGHTALT),
+	KEY(6, 6, KEY_9),
+
+	KEY(0, 7, KEY_3),
+	KEY(1, 7, KEY_E),
+	KEY(2, 7, KEY_COMPOSE),
+	KEY(3, 7, KEY_VOLUMEDOWN),
+	KEY(4, 7, KEY_X),
+	KEY(5, 7, KEY_F),
+	KEY(6, 7, KEY_D),
+};
+
+static struct matrix_keymap_data trout_keymap_data = {
+	.keymap		= trout_keymap,
+	.keymap_size	= ARRAY_SIZE(trout_keymap),
+};
+
+static struct matrix_keymap_data trout_keymap_data_2_1 = {
+	.keymap		= trout_keymap_evt2_1,
+	.keymap_size	= ARRAY_SIZE(trout_keymap_evt2_1),
+};
+
+static struct matrix_keymap_data trout_keymap_data_2_2 = {
+	.keymap		= trout_keymap_evt2_2,
+	.keymap_size	= ARRAY_SIZE(trout_keymap_evt2_2),
+};
+
+static struct matrix_keypad_platform_data trout_pdata = {
+	.keymap_data		= &trout_keymap_data,
+	.row_gpios		= trout_row_gpios,
+	.col_gpios		= trout_col_gpios,
+	.num_row_gpios		= ARRAY_SIZE(trout_row_gpios),
+	.num_col_gpios		= ARRAY_SIZE(trout_col_gpios),
+	.col_scan_delay_us	= 0,
+	.debounce_ms		= 20,
+	.wakeup			= 1,
+	.active_low		= 1,
+};
+
+static struct platform_device trout_device = {
+	.name		= "matrix-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &trout_pdata,
+	},
+};
+
+static struct gpio_keys_button trout_gpio_keys[] = {
+	{
+		.type	= EV_KEY,
+		.code	= KEY_POWER,
+		.gpio	= TROUT_POWER_KEY,
+		.desc	= "On Off",
+		.wakeup	= 1,
+	},
+	{
+		.type	= EV_KEY,
+		.code	= KEY_HP ,
+		.gpio	= TROUT_GPIO_CAM_BTN_STEP1_N,
+		.desc	= "Camera STEP1",
+	},
+	{
+		.type	= EV_KEY,
+		.code	= KEY_CAMERA,
+		.gpio	= TROUT_GPIO_CAM_BTN_STEP2_N,
+		.desc	= "Camera STEP2",
+	},
+	{
+		.type	= EV_SW,
+		.code	= 0,
+		.gpio	= TROUT_GPIO_SLIDING_DET,
+		.desc	= "Lid Closed",
+	},
+};
+
+static struct gpio_keys_platform_data trout_gpio_keys_platform_data = {
+	.buttons	= trout_gpio_keys,
+	.nbuttons	= ARRAY_SIZE(trout_gpio_keys),
+};
+
+static struct platform_device trout_gpio_keys_device = {
+	.name	= "gpio-keys",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &trout_gpio_keys_platform_data,
+	},
+};
+
+static int __init trout_init_keypad(void)
+{
+	int ret;
+
+	if (!machine_is_trout())
+		return 0;
+
+	switch (system_rev) {
+	case 0:
+		/* legacy default keylayout */
+		break;
+	case 1:
+		/* v1 has a new keyboard layout */
+		trout_pdata.keymap_data = &trout_keymap_data_2_1;
+		trout_pdata.col_gpios = trout_col_gpios_evt2;
+		trout_pdata.row_gpios = trout_row_gpios_evt2;
+
+		/* userspace needs to know about these changes as well */
+		break;
+	default: /* 2, 3, 4 currently */
+		/* v2 has a new keyboard layout */
+		trout_pdata.keymap_data = &trout_keymap_data_2_2;
+		trout_pdata.col_gpios = trout_col_gpios_evt2;
+		trout_pdata.row_gpios = trout_row_gpios_evt2;
+
+		/* userspace needs to know about these changes as well */
+		break;
+	}
+	ret = platform_device_register(&trout_device);
+	ret = platform_device_register(&trout_gpio_keys_device);
+
+	if (ret)
+		printk(KERN_ERR "TROUT: error registering platform devices.\n");
+
+	return ret;
+}
+
+device_initcall(trout_init_keypad);
+
-- 
1.7.1

