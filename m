From: riyer@nvidia.com
Subject: [PATCH v1] input: tegra-kbc - add function keymap.
Date: Thu, 17 Feb 2011 10:53:16 -0800
Message-ID: <1297968796-561-1-git-send-email-riyer@nvidia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:1736 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757679Ab1BQSw7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Feb 2011 13:52:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, achew@nvidia.com, Rakesh Iyer <riyer@nvidia.com>

From: Rakesh Iyer <riyer@nvidia.com>

Add Fn keymap support to allow for internal processing of Fn keys.

Signed-off-by: Rakesh Iyer <riyer@nvidia.com>
---
Modified function keymap to use separate rows as suggested by Dmitry Torokhov.
Untie the use_fn_map variable from the platform keymap data.

 arch/arm/mach-tegra/include/mach/kbc.h |    1 +
 drivers/input/keyboard/tegra-kbc.c     |   63 ++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 3 deletions(-)

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
index ac471b7..b1035f1 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
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
@@ -178,6 +179,40 @@ static const u32 tegra_kbc_default_keymap[] = {
 	KEY(15, 5, KEY_F2),
 	KEY(15, 6, KEY_CAPSLOCK),
 	KEY(15, 7, KEY_F6),
+
+	/* Software Handled Function Keys */
+	KEY(20, 0, KEY_KP7),
+
+	KEY(21, 0, KEY_KP9),
+	KEY(21, 1, KEY_KP8),
+	KEY(21, 2, KEY_KP4),
+	KEY(21, 4, KEY_KP1),
+
+	KEY(22, 1, KEY_KPSLASH),
+	KEY(22, 2, KEY_KP6),
+	KEY(22, 3, KEY_KP5),
+	KEY(22, 4, KEY_KP3),
+	KEY(22, 5, KEY_KP2),
+	KEY(22, 7, KEY_KP0),
+
+	KEY(27, 1, KEY_KPASTERISK),
+	KEY(27, 3, KEY_KPMINUS),
+	KEY(27, 4, KEY_KPPLUS),
+	KEY(27, 5, KEY_KPDOT),
+
+	KEY(28, 5, KEY_VOLUMEUP),
+
+	KEY(29, 3, KEY_HOME),
+	KEY(29, 4, KEY_END),
+	KEY(29, 5, KEY_BRIGHTNESSDOWN),
+	KEY(29, 6, KEY_VOLUMEDOWN),
+	KEY(29, 7, KEY_BRIGHTNESSUP),
+
+	KEY(30, 0, KEY_NUMLOCK),
+	KEY(30, 1, KEY_SCROLLLOCK),
+	KEY(30, 2, KEY_MUTE),
+
+	KEY(31, 4, KEY_HELP),
 };
 
 static const struct matrix_keymap_data tegra_kbc_default_keymap_data = {
@@ -224,6 +259,7 @@ static void tegra_kbc_report_keys(struct tegra_kbc *kbc)
 	unsigned int i;
 	unsigned int num_down = 0;
 	unsigned long flags;
+	bool fn_keypress = false;
 
 	spin_lock_irqsave(&kbc->lock, flags);
 	for (i = 0; i < KBC_MAX_KPENT; i++) {
@@ -237,11 +273,28 @@ static void tegra_kbc_report_keys(struct tegra_kbc *kbc)
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
+	if (fn_keypress) {
+		for (i = 0; i < num_down; i++) {
+			scancodes[i] += KBC_MAX_KEY;
+			keycodes[i] = kbc->keycode[scancodes[i]];
+		}
+	}
+
 	spin_unlock_irqrestore(&kbc->lock, flags);
 
 	tegra_kbc_report_released_keys(kbc->idev,
@@ -594,8 +647,12 @@ static int __devinit tegra_kbc_probe(struct platform_device *pdev)
 
 	input_dev->keycode = kbc->keycode;
 	input_dev->keycodesize = sizeof(kbc->keycode[0]);
-	input_dev->keycodemax = ARRAY_SIZE(kbc->keycode);
+	input_dev->keycodemax = KBC_MAX_KEY;
+	if (pdata->use_fn_map)
+		input_dev->keycodemax *= 2;
 
+	kbc->use_fn_map = pdata->use_fn_map;
+	/* The driver keymap requires internal processing of Fn keys. */
 	keymap_data = pdata->keymap_data ?: &tegra_kbc_default_keymap_data;
 	matrix_keypad_build_keymap(keymap_data, KBC_ROW_SHIFT,
 				   input_dev->keycode, input_dev->keybit);
-- 
1.7.0.4


-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
