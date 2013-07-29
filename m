From: Mauro Carvalho Chehab <m.chehab@samsung.com>
Subject: [PATCH 5/5] atkbd: only enable SW_FNLOCK on keyboards that have FN LOCK key
Date: Mon, 29 Jul 2013 00:59:39 -0300
Message-ID: <1375070379-329-5-git-send-email-m.chehab@samsung.com>
References: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56928 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704Ab3G2EBJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jul 2013 00:01:09 -0400
In-Reply-To: <1375070379-329-1-git-send-email-m.chehab@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mauro Carvalho Chehab <m.chehab@samsung.com>

Instead of unconditionally enabling the switch, only make it available
where the key actually exists.

Signed-off-by: Mauro Carvalho Chehab <m.chehab@samsung.com>
---
 drivers/input/keyboard/atkbd.c | 58 ++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 7f88132..3ec7d67 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -240,6 +240,7 @@ struct atkbd {
 /*
  * System-specific keymap fixup routine
  */
+static bool atkbd_platform_has_fnlock;
 static void (*atkbd_platform_fixup)(struct atkbd *, const void *data);
 static void *atkbd_platform_fixup_data;
 static unsigned int (*atkbd_platform_scancode_fixup)(struct atkbd *, unsigned int);
@@ -454,26 +455,22 @@ static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
 	if (keycode != ATKBD_KEY_NULL)
 		input_event(dev, EV_MSC, MSC_SCAN, code);
 
-	/*
-	 * Handles special Fn Lock switch.
-	 *
-	 * This switch can't be merged with the next one, as we also want
-	 * to report those keycodes to userspace, via input_event, and
-	 * call input_sync().
-	 */
-	switch (keycode) {
-	case KEY_FNLOCK_OFF:
-		atkbd->fnlock_set = false;
-		input_report_switch(dev, SW_FNLOCK, atkbd->fnlock_set);
-		break;
-	case KEY_FNLOCK_ON:
-		atkbd->fnlock_set = true;
-		input_report_switch(dev, SW_FNLOCK, atkbd->fnlock_set);
-		break;
-	case KEY_FNLOCK_TOGGLE:
-		atkbd->fnlock_set = !atkbd->fnlock_set;
-		input_report_switch(dev, SW_FNLOCK, atkbd->fnlock_set);
-		break;
+	/* Handles special Fn Lock switch found on some notebooks */
+	if (test_bit(SW_FNLOCK, dev->swbit)) {
+		switch (keycode) {
+		case KEY_FNLOCK_OFF:
+			atkbd->fnlock_set = false;
+			input_report_switch(dev, SW_FNLOCK, atkbd->fnlock_set);
+			break;
+		case KEY_FNLOCK_ON:
+			atkbd->fnlock_set = true;
+			input_report_switch(dev, SW_FNLOCK, atkbd->fnlock_set);
+			break;
+		case KEY_FNLOCK_TOGGLE:
+			atkbd->fnlock_set = !atkbd->fnlock_set;
+			input_report_switch(dev, SW_FNLOCK, atkbd->fnlock_set);
+			break;
+		}
 	}
 
 	switch (keycode) {
@@ -1150,9 +1147,10 @@ static void atkbd_set_device_attrs(struct atkbd *atkbd)
 		}
 	}
 
-	/* FIXME: Unconditionqally sets FN LOCK switch */
-	__set_bit(SW_FNLOCK, atkbd->dev->swbit);
-	input_dev->evbit[0] |= BIT_MASK(EV_SW);
+	if (atkbd_platform_has_fnlock) {
+		__set_bit(SW_FNLOCK, atkbd->dev->swbit);
+		input_dev->evbit[0] |= BIT_MASK(EV_SW);
+	}
 }
 
 /*
@@ -1672,6 +1670,16 @@ static int __init atkbd_setup_forced_release(const struct dmi_system_id *id)
 	return 1;
 }
 
+static int __init
+atkbd_setup_forced_release_and_fnlock(const struct dmi_system_id *id)
+{
+	atkbd_platform_fixup = atkbd_apply_forced_release_keylist;
+	atkbd_platform_fixup_data = id->driver_data;
+	atkbd_platform_has_fnlock = true;
+
+	return 1;
+}
+
 static int __init atkbd_setup_scancode_fixup(const struct dmi_system_id *id)
 {
 	atkbd_platform_scancode_fixup = id->driver_data;
@@ -1778,7 +1786,7 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "530U3C"),
 		},
-		.callback = atkbd_setup_forced_release,
+		.callback = atkbd_setup_forced_release_and_fnlock,
 		.driver_data = atkbd_samsung_530u3c_forced_release_keys,
 	},
 	{
@@ -1787,7 +1795,7 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
 			DMI_MATCH(DMI_PRODUCT_NAME, "550P5C"),
 		},
-		.callback = atkbd_setup_forced_release,
+		.callback = atkbd_setup_forced_release_and_fnlock,
 		.driver_data = atkbd_samsung_550p5c_forced_release_keys,
 	},
 	{
-- 
1.8.3.1

