From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH] [ARM] pxa/corgi: use GPIO matrix keypad driver
Date: Mon, 20 Jul 2009 19:41:55 +0800
Message-ID: <1248090115-20571-2-git-send-email-eric.y.miao@gmail.com>
References: <1248090115-20571-1-git-send-email-eric.y.miao@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f193.google.com ([209.85.216.193]:54764 "EHLO
	mail-px0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbZGTLmP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2009 07:42:15 -0400
Received: by mail-px0-f193.google.com with SMTP id 31so354365pxi.33
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2009 04:42:15 -0700 (PDT)
In-Reply-To: <1248090115-20571-1-git-send-email-eric.y.miao@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: Eric Miao <eric.y.miao@gmail.com>

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/corgi.c |  122 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 121 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 5363e1a..d8012c3 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -29,6 +29,7 @@
 #include <linux/spi/ads7846.h>
 #include <linux/spi/corgi_lcd.h>
 #include <linux/mtd/sharpsl.h>
+#include <linux/input/matrix_keypad.h>
 #include <video/w100fb.h>
 
 #include <asm/setup.h>
@@ -104,6 +105,28 @@ static unsigned long corgi_pin_config[] __initdata = {
 	GPIO6_MMC_CLK,
 	GPIO8_MMC_CS0,
 
+	/* GPIO Matrix Keypad */
+	GPIO66_GPIO,	/* column 0 */
+	GPIO67_GPIO,	/* column 1 */
+	GPIO68_GPIO,	/* column 2 */
+	GPIO69_GPIO,	/* column 3 */
+	GPIO70_GPIO,	/* column 4 */
+	GPIO71_GPIO,	/* column 5 */
+	GPIO72_GPIO,	/* column 6 */
+	GPIO73_GPIO,	/* column 7 */
+	GPIO74_GPIO,	/* column 8 */
+	GPIO75_GPIO,	/* column 9 */
+	GPIO76_GPIO,	/* column 10 */
+	GPIO77_GPIO,	/* column 11 */
+	GPIO58_GPIO,	/* row 0 */
+	GPIO59_GPIO,	/* row 1 */
+	GPIO60_GPIO,	/* row 2 */
+	GPIO61_GPIO,	/* row 3 */
+	GPIO62_GPIO,	/* row 4 */
+	GPIO63_GPIO,	/* row 5 */
+	GPIO64_GPIO,	/* row 6 */
+	GPIO65_GPIO,	/* row 7 */
+
 	/* GPIO */
 	GPIO9_GPIO,	/* CORGI_GPIO_nSD_DETECT */
 	GPIO7_GPIO,	/* CORGI_GPIO_nSD_WP */
@@ -267,9 +290,106 @@ static struct platform_device corgifb_device = {
 /*
  * Corgi Keyboard Device
  */
+#define CORGI_KEY_CALENDER	KEY_F1
+#define CORGI_KEY_ADDRESS	KEY_F2
+#define CORGI_KEY_FN		KEY_F3
+#define CORGI_KEY_CANCEL	KEY_F4
+#define CORGI_KEY_OFF		KEY_SUSPEND
+#define CORGI_KEY_EXOK		KEY_F5
+#define CORGI_KEY_EXCANCEL	KEY_F6
+#define CORGI_KEY_EXJOGDOWN	KEY_F7
+#define CORGI_KEY_EXJOGUP	KEY_F8
+#define CORGI_KEY_JAP1		KEY_LEFTCTRL
+#define CORGI_KEY_JAP2		KEY_LEFTALT
+#define CORGI_KEY_MAIL		KEY_F10
+#define CORGI_KEY_OK		KEY_F11
+#define CORGI_KEY_MENU		KEY_F12
+
+static const uint32_t corgikbd_keymap[] = {
+	KEY(0, 1, KEY_1),
+	KEY(0, 2, KEY_3),
+	KEY(0, 3, KEY_5),
+	KEY(0, 4, KEY_6),
+	KEY(0, 5, KEY_7),
+	KEY(0, 6, KEY_9),
+	KEY(0, 7, KEY_0),
+	KEY(0, 8, KEY_BACKSPACE),
+	KEY(1, 1, KEY_2),
+	KEY(1, 2, KEY_4),
+	KEY(1, 3, KEY_R),
+	KEY(1, 4, KEY_Y),
+	KEY(1, 5, KEY_8),
+	KEY(1, 6, KEY_I),
+	KEY(1, 7, KEY_O),
+	KEY(1, 8, KEY_P),
+	KEY(2, 0, KEY_TAB),
+	KEY(2, 1, KEY_Q),
+	KEY(2, 2, KEY_E),
+	KEY(2, 3, KEY_T),
+	KEY(2, 4, KEY_G),
+	KEY(2, 5, KEY_U),
+	KEY(2, 6, KEY_J),
+	KEY(2, 7, KEY_K),
+	KEY(3, 0, CORGI_KEY_CALENDER),
+	KEY(3, 1, KEY_W),
+	KEY(3, 2, KEY_S),
+	KEY(3, 3, KEY_F),
+	KEY(3, 4, KEY_V),
+	KEY(3, 5, KEY_H),
+	KEY(3, 6, KEY_M),
+	KEY(3, 7, KEY_L),
+	KEY(3, 9, KEY_RIGHTSHIFT),
+	KEY(4, 0, CORGI_KEY_ADDRESS),
+	KEY(4, 1, KEY_A),
+	KEY(4, 2, KEY_D),
+	KEY(4, 3, KEY_C),
+	KEY(4, 4, KEY_B),
+	KEY(4, 5, KEY_N),
+	KEY(4, 6, KEY_DOT),
+	KEY(4, 8, KEY_ENTER),
+	KEY(4, 10, KEY_LEFTSHIFT),
+	KEY(5, 0, CORGI_KEY_MAIL),
+	KEY(5, 1, KEY_Z),
+	KEY(5, 2, KEY_X),
+	KEY(5, 3, KEY_MINUS),
+	KEY(5, 4, KEY_SPACE),
+	KEY(5, 5, KEY_COMMA),
+	KEY(5, 7, KEY_UP),
+	KEY(5, 11, CORGI_KEY_FN),
+	KEY(6, 0, KEY_SYSRQ),
+	KEY(6, 1, CORGI_KEY_JAP1),
+	KEY(6, 2, CORGI_KEY_JAP2),
+	KEY(6, 3, CORGI_KEY_CANCEL),
+	KEY(6, 4, CORGI_KEY_OK),
+	KEY(6, 5, CORGI_KEY_MENU),
+	KEY(6, 6, KEY_LEFT),
+	KEY(6, 7, KEY_DOWN),
+	KEY(6, 8, KEY_RIGHT),
+	KEY(7, 0, CORGI_KEY_OFF),
+	KEY(7, 1, CORGI_KEY_EXOK),
+	KEY(7, 2, CORGI_KEY_EXCANCEL),
+	KEY(7, 3, CORGI_KEY_EXJOGDOWN),
+	KEY(7, 4, CORGI_KEY_EXJOGUP),
+};
+
+static struct matrix_keypad_platform_data corgikbd_pdata = {
+	.keymap		= corgikbd_keymap,
+	.keymap_size	= ARRAY_SIZE(corgikbd_keymap),
+	.row_gpios	= {58, 59, 60, 61, 62, 63, 64, 65, -1},
+	.col_gpios	= {66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, -1},
+	.num_row_gpios	= 8,
+	.num_col_gpios	= 12,
+	.col_scan_delay_us	= 10,
+	.debounce_ms		= 10,
+	.wakeup			= 1,
+};
+
 static struct platform_device corgikbd_device = {
-	.name		= "corgi-keyboard",
+	.name		= "matrix-keypad",
 	.id		= -1,
+	.dev		= {
+		.platform_data = &corgikbd_pdata,
+	},
 };
 
 /*
-- 
1.6.0.4

