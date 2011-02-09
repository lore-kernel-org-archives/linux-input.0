From: riyer@nvidia.com
Subject: [PATCH v3] input: tegra-kbc: Add Function keymap.
Date: Wed,  9 Feb 2011 11:44:40 -0800
Message-ID: <1297280680-7555-1-git-send-email-riyer@nvidia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:1510 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab1BIToi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Feb 2011 14:44:38 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, olofj@chromium.org, achew@nvidia.com, Rakesh Iyer <riyer@nvidia.com>

From: Rakesh Iyer <riyer@nvidia.com>

Add Fn keymap support to allow for internal processing of Fn keys.

Signed-off-by: Rakesh Iyer <riyer@nvidia.com>
---
Modified mapping from KEY_SLASH to KEY_KPSLASH.

 arch/arm/mach-tegra/include/mach/kbc.h |    1 +
 drivers/input/keyboard/tegra-kbc.c     |   50 ++++++++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/kbc.h b/arch/arm/mach-tegra/include/mach/kbc.h
index 66ad276..04c7798 100644
--- a/arch/arm/mach-tegra/include/mach/kbc.h
+++ b/arch/arm/mach-tegra/include/mach/kbc.h
@@ -57,5 +57,6 @@ struct tegra_kbc_platform_data {
 	const struct matrix_keymap_data *keymap_data;
 
 	bool wakeup;
+	bool use_fn_map;
 };
 #endif
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index ac471b7..840463d 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -60,7 +60,7 @@
 #define KBC_KP_ENT1_0	0x34
 #define KBC_ROW0_MASK_0	0x38
 
-#define KBC_ROW_SHIFT	3
+#define KBC_ROW_SHIFT	4
 
 struct tegra_kbc {
 	void __iomem *mmio;
@@ -71,8 +71,9 @@ struct tegra_kbc {
 	spinlock_t lock;
 	unsigned int repoll_dly;
 	unsigned long cp_dly_jiffies;
+	bool use_fn_map;
 	const struct tegra_kbc_platform_data *pdata;
-	unsigned short keycode[KBC_MAX_KEY];
+	unsigned short keycode[KBC_MAX_KEY * 2];
 	unsigned short current_keys[KBC_MAX_KPENT];
 	unsigned int num_pressed_keys;
 	struct timer_list timer;
@@ -107,6 +108,7 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(4, 5, KEY_V),
 	KEY(4, 6, KEY_C),
 	KEY(4, 7, KEY_SPACE),
+	KEY(4, 8, KEY_KP7),
 
 	KEY(5, 0, KEY_9),
 	KEY(5, 1, KEY_8),
@@ -116,6 +118,10 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(5, 5, KEY_N),
 	KEY(5, 6, KEY_B),
 	KEY(5, 7, KEY_BACKSLASH),
+	KEY(5, 8, KEY_KP9),
+	KEY(5, 9, KEY_KP8),
+	KEY(5, 10, KEY_KP4),
+	KEY(5, 12, KEY_KP1),
 
 	KEY(6, 0, KEY_MINUS),
 	KEY(6, 1, KEY_0),
@@ -125,6 +131,12 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(6, 5, KEY_K),
 	KEY(6, 6, KEY_COMMA),
 	KEY(6, 7, KEY_M),
+	KEY(6, 9, KEY_KPSLASH),
+	KEY(6, 10, KEY_KP6),
+	KEY(6, 11, KEY_KP5),
+	KEY(6, 12, KEY_KP3),
+	KEY(6, 13, KEY_KP2),
+	KEY(6, 15, KEY_KP0),
 
 	KEY(7, 1, KEY_EQUAL),
 	KEY(7, 2, KEY_RIGHTBRACE),
@@ -143,6 +155,10 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(11, 3, KEY_SEMICOLON),
 	KEY(11, 4, KEY_SLASH),
 	KEY(11, 5, KEY_DOT),
+	KEY(11, 9, KEY_KPASTERISK),
+	KEY(11, 11, KEY_KPMINUS),
+	KEY(11, 12, KEY_KPPLUS),
+	KEY(11, 13, KEY_KPDOT),
 
 	KEY(12, 0, KEY_F10),
 	KEY(12, 1, KEY_F9),
@@ -152,6 +168,7 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(12, 5, KEY_UP),
 	KEY(12, 6, KEY_PRINT),
 	KEY(12, 7, KEY_PAUSE),
+	KEY(12, 13, KEY_VOLUMEUP),
 
 	KEY(13, 0, KEY_INSERT),
 	KEY(13, 1, KEY_DELETE),
@@ -160,6 +177,11 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(13, 5, KEY_RIGHT),
 	KEY(13, 6, KEY_DOWN),
 	KEY(13, 7, KEY_LEFT),
+	KEY(13, 11, KEY_HOME),
+	KEY(13, 12, KEY_END),
+	KEY(13, 13, KEY_BRIGHTNESSDOWN),
+	KEY(13, 14, KEY_VOLUMEDOWN),
+	KEY(13, 15, KEY_BRIGHTNESSUP),
 
 	KEY(14, 0, KEY_F11),
 	KEY(14, 1, KEY_F12),
@@ -169,6 +191,9 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(14, 5, KEY_F3),
 	KEY(14, 6, KEY_1),
 	KEY(14, 7, KEY_F7),
+	KEY(14, 8, KEY_NUMLOCK),
+	KEY(14, 9, KEY_SCROLLLOCK),
+	KEY(14, 10, KEY_MUTE),
 
 	KEY(15, 0, KEY_ESC),
 	KEY(15, 1, KEY_GRAVE),
@@ -178,6 +203,7 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(15, 5, KEY_F2),
 	KEY(15, 6, KEY_CAPSLOCK),
 	KEY(15, 7, KEY_F6),
+	KEY(15, 12, KEY_QUESTION),
 };
 
 static const struct matrix_keymap_data tegra_kbc_default_keymap_data = {
@@ -224,6 +250,7 @@ static void tegra_kbc_report_keys(struct tegra_kbc *kbc)
 	unsigned int i;
 	unsigned int num_down = 0;
 	unsigned long flags;
+	bool fn_keypress = false;
 
 	spin_lock_irqsave(&kbc->lock, flags);
 	for (i = 0; i < KBC_MAX_KPENT; i++) {
@@ -237,11 +264,26 @@ static void tegra_kbc_report_keys(struct tegra_kbc *kbc)
 				MATRIX_SCAN_CODE(row, col, KBC_ROW_SHIFT);
 
 			scancodes[num_down] = scancode;
-			keycodes[num_down++] = kbc->keycode[scancode];
+			keycodes[num_down] = kbc->keycode[scancode];
+			/* If driver uses Fn map, do not report the Fn key. */
+			if ((keycodes[num_down] == KEY_FN) && kbc->use_fn_map)
+				fn_keypress = true;
+			else
+				num_down++;
 		}
 
 		val >>= 8;
 	}
+
+	/*
+	 * If the platform uses Fn keymaps, translate keys on a Fn keypress.
+	 * Function keycodes are KBC_MAX_COL apart from the plain keycodes.
+	 */
+	for (i = 0; (i < num_down) && fn_keypress; i++) {
+		scancodes[i] += KBC_MAX_COL;
+		keycodes[i] = kbc->keycode[scancodes[i]];
+	}
+
 	spin_unlock_irqrestore(&kbc->lock, flags);
 
 	tegra_kbc_report_released_keys(kbc->idev,
@@ -596,9 +638,11 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 	input_dev->keycodesize = sizeof(kbc->keycode[0]);
 	input_dev->keycodemax = ARRAY_SIZE(kbc->keycode);
 
+	/* The driver keymap requires internal processing of Fn keys. */
 	keymap_data = pdata->keymap_data ?: &tegra_kbc_default_keymap_data;
 	matrix_keypad_build_keymap(keymap_data, KBC_ROW_SHIFT,
 				   input_dev->keycode, input_dev->keybit);
+	kbc->use_fn_map = pdata->keymap_data ? pdata->use_fn_map : true;
 
 	err = request_irq(kbc->irq, tegra_kbc_isr, IRQF_TRIGGER_HIGH,
 			  pdev->name, kbc);
-- 
1.7.0.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
