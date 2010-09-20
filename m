From: Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH v3 3/5] davinci: add keypad config for tnetv107x evm board
Date: Mon, 20 Sep 2010 11:07:30 -0400
Message-ID: <1284995252-23337-4-git-send-email-cyril@ti.com>
References: <1284995252-23337-1-git-send-email-cyril@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44989 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008Ab0ITPHm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Sep 2010 11:07:42 -0400
In-Reply-To: <1284995252-23337-1-git-send-email-cyril@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: shubhrajyoti@ti.com, dmitry.torokhov@gmail.com, khilman@deeprootsystems.com, Cyril Chemparathy <cyril@ti.com>

This patch adds evm board specific keymap definitions and controller
configuration data for on-chip keypad controller on tnetv107x silicon.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   56 +++++++++++++++++++++++++++
 1 files changed, 56 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index fe2a9d9..5afa8fc 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -23,6 +23,9 @@
 #include <linux/ratelimit.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/input.h>
+#include <linux/input/matrix_keypad.h>
+
 #include <asm/mach/arch.h>
 #include <asm/mach-types.h>
 
@@ -141,10 +144,63 @@ static struct davinci_uart_config serial_config __initconst = {
 	.enabled_uarts	= BIT(1),
 };
 
+static const uint32_t keymap[] = {
+	KEY(0, 0, KEY_NUMERIC_1),
+	KEY(0, 1, KEY_NUMERIC_2),
+	KEY(0, 2, KEY_NUMERIC_3),
+	KEY(0, 3, KEY_FN_F1),
+	KEY(0, 4, KEY_MENU),
+
+	KEY(1, 0, KEY_NUMERIC_4),
+	KEY(1, 1, KEY_NUMERIC_5),
+	KEY(1, 2, KEY_NUMERIC_6),
+	KEY(1, 3, KEY_UP),
+	KEY(1, 4, KEY_FN_F2),
+
+	KEY(2, 0, KEY_NUMERIC_7),
+	KEY(2, 1, KEY_NUMERIC_8),
+	KEY(2, 2, KEY_NUMERIC_9),
+	KEY(2, 3, KEY_LEFT),
+	KEY(2, 4, KEY_ENTER),
+
+	KEY(3, 0, KEY_NUMERIC_STAR),
+	KEY(3, 1, KEY_NUMERIC_0),
+	KEY(3, 2, KEY_NUMERIC_POUND),
+	KEY(3, 3, KEY_DOWN),
+	KEY(3, 4, KEY_RIGHT),
+
+	KEY(4, 0, KEY_FN_F3),
+	KEY(4, 1, KEY_FN_F4),
+	KEY(4, 2, KEY_MUTE),
+	KEY(4, 3, KEY_HOME),
+	KEY(4, 4, KEY_BACK),
+
+	KEY(5, 0, KEY_VOLUMEDOWN),
+	KEY(5, 1, KEY_VOLUMEUP),
+	KEY(5, 2, KEY_F1),
+	KEY(5, 3, KEY_F2),
+	KEY(5, 4, KEY_F3),
+};
+
+static const struct matrix_keymap_data keymap_data = {
+	.keymap		= keymap,
+	.keymap_size	= ARRAY_SIZE(keymap),
+};
+
+static struct matrix_keypad_platform_data keypad_config = {
+	.keymap_data	= &keymap_data,
+	.num_row_gpios	= 6,
+	.num_col_gpios	= 5,
+	.debounce_ms	= 0, /* minimum */
+	.active_low	= 0, /* pull up realization */
+	.no_autorepeat	= 0,
+};
+
 static struct tnetv107x_device_info evm_device_info __initconst = {
 	.serial_config		= &serial_config,
 	.mmc_config[1]		= &mmc_config,	/* controller 1 */
 	.nand_config[0]		= &nand_config,	/* chip select 0 */
+	.keypad_config		= &keypad_config,
 };
 
 static __init void tnetv107x_evm_board_init(void)
-- 
1.7.0.4

