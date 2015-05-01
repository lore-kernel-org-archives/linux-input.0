From: Zakhar Semenov <mail@free5lot.com>
Subject: [PATCH 4.0.1] HID: apple: option to swap the 'FN' and 'Left Control'
 keys.
Date: Fri, 01 May 2015 20:56:00 +0600
Message-ID: <55439400.3010100@free5lot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from forward6l.mail.yandex.net ([84.201.143.139]:45852 "EHLO
	forward6l.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbbEAPHA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 May 2015 11:07:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This patch allows Apple users to swap the FN and left Control keys 
on Macbook Pro, external Apple keyboards and some other Apple devices. 
And it also allows to use EjectCD key as missing Delete key.
New hid-apple module params are swap_fn_leftctrl and ejectcd_as_delete.

Signed-off-by: Zakhar Semenov <mail@free5lot.com>
---
This patch was created because Apple keyboards on Macbook Pro and 
external keyboard models have an unusual placement of special keys 
and a lot of users want the FN key and left Control key to be swapped.
Similar patch for hid-apple but for other keys was accepted in 2013:
https://lkml.org/lkml/2013/12/6/246

This patch was tested on Macbook Pro of 2013/2014 and an external keyboard.
The same code style was used as in the original hid-apple.c,
Some additional information and discussion on github:
https://github.com/free5lot/hid-apple-patched

--- linux/drivers/hid/hid-apple.c.orig	2015-05-01 00:00:00.000000000 +0300
+++ linux/drivers/hid/hid-apple.c	2015-05-01 00:00:00.000000000 +0300
@@ -36,6 +36,9 @@
 
 #define APPLE_FLAG_FKEY		0x01
 
+/* The fn key on Apple keyboards */
+#define APPLE_KEY_FN		84
+
 static unsigned int fnmode = 1;
 module_param(fnmode, uint, 0644);
 MODULE_PARM_DESC(fnmode, "Mode of fn key on Apple keyboards (0 = disabled, "
@@ -52,6 +55,17 @@ MODULE_PARM_DESC(swap_opt_cmd, "Swap the
 		"(For people who want to keep Windows PC keyboard muscle memory. "
 		"[0] = as-is, Mac layout. 1 = swapped, Windows layout.)");
 
+static unsigned int swap_fn_leftctrl;
+module_param(swap_fn_leftctrl, uint, 0644);
+MODULE_PARM_DESC(swap_fn_leftctrl, "Swap the Fn and left Control keys. "
+		"(For people who want to keep PC keyboard muscle memory. "
+		"[0] = as-is, Mac layout, 1 = swapped, PC layout)");
+
+static unsigned int ejectcd_as_delete;
+module_param(ejectcd_as_delete, uint, 0644);
+MODULE_PARM_DESC(ejectcd_as_delete, "Use Eject-CD key as Delete key. "
+		"([0] = disabled, 1 = enabled)");
+
 struct apple_sc {
 	unsigned long quirks;
 	unsigned int fn_on;
@@ -164,6 +178,16 @@ static const struct apple_key_translatio
 	{ }
 };
 
+static const struct apple_key_translation swapped_fn_leftctrl_keys[] = {
+	{ APPLE_KEY_FN,	KEY_LEFTCTRL },
+	{ }
+};
+
+static const struct apple_key_translation ejectcd_as_delete_keys[] = {
+	{ KEY_EJECTCD,	KEY_DELETE },
+	{ }
+};
+
 static const struct apple_key_translation *apple_find_translation(
 		const struct apple_key_translation *table, u16 from)
 {
@@ -183,9 +207,11 @@ static int hidinput_apple_event(struct h
 	struct apple_sc *asc = hid_get_drvdata(hid);
 	const struct apple_key_translation *trans, *table;
 
-	if (usage->code == KEY_FN) {
+	u16 fn_keycode = (swap_fn_leftctrl) ? (KEY_LEFTCTRL) : (KEY_FN);
+
+	if (usage->code == fn_keycode) {
 		asc->fn_on = !!value;
-		input_event(input, usage->type, usage->code, value);
+		input_event(input, usage->type, KEY_FN, value);
 		return 1;
 	}
 
@@ -264,6 +290,22 @@ static int hidinput_apple_event(struct h
 		}
 	}
 
+	if (swap_fn_leftctrl) {
+		trans = apple_find_translation(swapped_fn_leftctrl_keys, usage->code);
+		if (trans) {
+			input_event(input, usage->type, trans->to, value);
+			return 1;
+		}
+	}
+
+	if (ejectcd_as_delete) {
+		trans = apple_find_translation(ejectcd_as_delete_keys, usage->code);
+		if (trans) {
+			input_event(input, usage->type, trans->to, value);
+			return 1;
+		}
+	}
+
 	return 0;
 }
 
@@ -327,6 +369,16 @@ static void apple_setup_input(struct inp
 
 	for (trans = apple_iso_keyboard; trans->from; trans++)
 		set_bit(trans->to, input->keybit);
+
+	if (swap_fn_leftctrl) {
+		for (trans = swapped_fn_leftctrl_keys; trans->from; trans++)
+			set_bit(trans->to, input->keybit);
+	}
+
+	if (ejectcd_as_delete) {
+		for (trans = ejectcd_as_delete_keys; trans->from; trans++)
+			set_bit(trans->to, input->keybit);
+	}
 }
 
 static int apple_input_mapping(struct hid_device *hdev, struct hid_input *hi,
@@ -335,8 +387,10 @@ static int apple_input_mapping(struct hi
 {
 	if (usage->hid == (HID_UP_CUSTOM | 0x0003)) {
 		/* The fn key on Apple USB keyboards */
+		u16 fn_keycode = (swap_fn_leftctrl) ? (KEY_LEFTCTRL) : (KEY_FN);
+
 		set_bit(EV_REP, hi->input->evbit);
-		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, KEY_FN);
+		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, fn_keycode);
 		apple_setup_input(hi->input);
 		return 1;
 	}
