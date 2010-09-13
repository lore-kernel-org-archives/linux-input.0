From: Cyril Chemparathy <cyril@ti.com>
Subject: [PATCH 4/7] davinci: add keypad config for tnetv107x evm board
Date: Mon, 13 Sep 2010 12:29:45 -0400
Message-ID: <1284395388-32687-5-git-send-email-cyril@ti.com>
References: <1284395388-32687-1-git-send-email-cyril@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42557 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752611Ab0IMQ3w (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Sep 2010 12:29:52 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8DGTqbi001285
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Mon, 13 Sep 2010 11:29:52 -0500
In-Reply-To: <1284395388-32687-1-git-send-email-cyril@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Cyril Chemparathy <cyril@ti.com>

This patch adds evm board specific keymap definitions and controller
configuration data for on-chip keypad controller on tnetv107x silicon.

Signed-off-by: Cyril Chemparathy <cyril@ti.com>
---
 arch/arm/mach-davinci/board-tnetv107x-evm.c |   42 +++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-davinci/board-tnetv107x-evm.c b/arch/arm/mach-davinci/board-tnetv107x-evm.c
index fe2a9d9..2fe7a3f 100644
--- a/arch/arm/mach-davinci/board-tnetv107x-evm.c
+++ b/arch/arm/mach-davinci/board-tnetv107x-evm.c
@@ -21,6 +21,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/ratelimit.h>
+#include <linux/input.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <asm/mach/arch.h>
@@ -141,10 +142,51 @@ static struct davinci_uart_config serial_config __initconst = {
 	.enabled_uarts	= BIT(1),
 };
 
+static int keymap[] = {
+	/* row 0 */
+	KEY_NUMERIC_1, KEY_NUMERIC_2, KEY_NUMERIC_3, KEY_FN_F1, KEY_MENU,
+	/* row 1 */
+	KEY_NUMERIC_4, KEY_NUMERIC_5, KEY_NUMERIC_6, KEY_UP, KEY_FN_F2,
+	/* row 2 */
+	KEY_NUMERIC_7, KEY_NUMERIC_8, KEY_NUMERIC_9, KEY_LEFT, KEY_ENTER,
+	/* row 3 */
+	KEY_NUMERIC_STAR, KEY_NUMERIC_0, KEY_NUMERIC_POUND, KEY_DOWN, KEY_RIGHT,
+	/* row 4 */
+	KEY_FN_F3, KEY_FN_F4, KEY_MUTE, KEY_HOME, KEY_BACK,
+	/* row 5 */
+	KEY_VOLUMEDOWN, KEY_VOLUMEUP, KEY_F1, KEY_F2, KEY_F3,
+};
+
+static const char *keynames[] = {
+	/* row 0 */
+	"1", "2", "3", "S1 (FN_F1)", "MENU",
+	/* row 1 */
+	"4", "5", "6", "UP", "S2 (FN_F2)",
+	/* row 2 */
+	"7", "8", "9", "LEFT", "ENTER",
+	/* row 3 */
+	"*", "0", "#", "DOWN", "RIGHT",
+	/* row 4 */
+	"SPEAKER (FN_F3)", "HEADSET (FN_F4)", "MUTE", "HOME", "BACK",
+	/* row 5 */
+	"VOL_DOWN", "VOL_UP", "F1", "F2", "F3",
+};
+
+static struct tnetv107x_keypad_data keypad_config = {
+	.keynames	= keynames,
+	.keymap		= keymap,
+	.keymap_size	= ARRAY_SIZE(keymap),
+	.rows		= 6,
+	.cols		= 5,
+	.debounce	= 0x400,
+	.stable		= 0x3,
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

