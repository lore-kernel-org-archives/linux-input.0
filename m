From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/3] tty/vt/keyboard: define LED triggers for VT LED states
Date: Mon,  8 Jun 2015 14:43:09 -0700
Message-ID: <1433799790-31873-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34595 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753564AbbFHVn2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 17:43:28 -0400
In-Reply-To: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

Now that input core allows controlling keyboards LEDs via standard LED
subsystem triggers let's switch VT keyboard code to make use of this
feature. We will define the following standard triggers: "kbd-scrollock",
"kbd-numlock", "kbd-capslock", and "kbd-kanalock" which are default
triggers for respective LEDs on keyboards.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/tty/vt/keyboard.c | 141 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 117 insertions(+), 24 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 8a89f6e..cff193e 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -33,6 +33,7 @@
 #include <linux/string.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/leds.h>
 
 #include <linux/kbd_kern.h>
 #include <linux/kbd_diacr.h>
@@ -961,6 +962,110 @@ static void k_brl(struct vc_data *vc, unsigned char value, char up_flag)
 	}
 }
 
+#if IS_ENABLED(CONFIG_INPUT_LEDS)
+
+struct kbd_led_trigger {
+	struct led_trigger trigger;
+	unsigned int mask;
+};
+
+static void kbd_led_trigger_activate(struct led_classdev *cdev)
+{
+	struct kbd_led_trigger *trigger =
+		container_of(cdev->trigger, struct kbd_led_trigger, trigger);
+
+	tasklet_disable(&keyboard_tasklet);
+	if (ledstate != 0xff)
+		led_trigger_event(&trigger->trigger,
+				  ledstate & trigger->mask ?
+					LED_FULL : LED_OFF);
+	tasklet_enable(&keyboard_tasklet);
+}
+
+#define KBD_LED_TRIGGER(_led_bit, _name) {			\
+		.trigger = {					\
+			.name = _name,				\
+			.activate = kbd_led_trigger_activate,	\
+		},						\
+		.mask	= BIT(_led_bit),			\
+	}
+
+static struct kbd_led_trigger kbd_led_triggers[] = {
+	KBD_LED_TRIGGER(VC_SCROLLOCK, "kbd-scrollock"),
+	KBD_LED_TRIGGER(VC_NUMLOCK,   "kbd-numlock"),
+	KBD_LED_TRIGGER(VC_CAPSLOCK,  "kbd-capslock"),
+	KBD_LED_TRIGGER(VC_KANALOCK,  "kbd-kanalock"),
+};
+
+static void kbd_propagate_led_state(unsigned int old_state,
+				    unsigned int new_state)
+{
+	struct kbd_led_trigger *trigger;
+	unsigned int changed = old_state ^ new_state;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(kbd_led_triggers); i++) {
+		trigger = &kbd_led_triggers[i];
+
+		if (changed & trigger->mask)
+			led_trigger_event(&trigger->trigger,
+					  new_state & trigger->mask ?
+						LED_FULL : LED_OFF);
+	}
+}
+
+static int kbd_update_leds_helper(struct input_handle *handle, void *data)
+{
+	unsigned int led_state = *(unsigned int *)data;
+
+	if (test_bit(EV_LED, handle->dev->evbit))
+		kbd_propagate_led_state(~led_state, led_state);
+
+	return 0;
+}
+
+static void kbd_init_leds(void)
+{
+	int error;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(kbd_led_triggers); i++) {
+		error = led_trigger_register(&kbd_led_triggers[i].trigger);
+		if (error)
+			pr_err("error %d while registering trigger %s\n",
+			       error, kbd_led_triggers[i].trigger.name);
+	}
+}
+
+#else
+
+static int kbd_update_leds_helper(struct input_handle *handle, void *data)
+{
+	unsigned int leds = *(unsigned int *)data;
+
+	if (test_bit(EV_LED, handle->dev->evbit)) {
+		input_inject_event(handle, EV_LED, LED_SCROLLL, !!(leds & 0x01));
+		input_inject_event(handle, EV_LED, LED_NUML,    !!(leds & 0x02));
+		input_inject_event(handle, EV_LED, LED_CAPSL,   !!(leds & 0x04));
+		input_inject_event(handle, EV_SYN, SYN_REPORT, 0);
+	}
+
+	return 0;
+}
+
+static void kbd_propagate_led_state(unsigned int old_state,
+				    unsigned int new_state)
+{
+	input_handler_for_each_handle(&kbd_handler, &new_state,
+				      kbd_update_leds_helper);
+}
+
+static void kbd_init_leds(void)
+{
+}
+
+#endif
+
 /*
  * The leds display either (i) the status of NumLock, CapsLock, ScrollLock,
  * or (ii) whatever pattern of lights people want to show using KDSETLED,
@@ -995,20 +1100,6 @@ static inline unsigned char getleds(void)
 	return kb->ledflagstate;
 }
 
-static int kbd_update_leds_helper(struct input_handle *handle, void *data)
-{
-	unsigned char leds = *(unsigned char *)data;
-
-	if (test_bit(EV_LED, handle->dev->evbit)) {
-		input_inject_event(handle, EV_LED, LED_SCROLLL, !!(leds & 0x01));
-		input_inject_event(handle, EV_LED, LED_NUML,    !!(leds & 0x02));
-		input_inject_event(handle, EV_LED, LED_CAPSL,   !!(leds & 0x04));
-		input_inject_event(handle, EV_SYN, SYN_REPORT, 0);
-	}
-
-	return 0;
-}
-
 /**
  *	vt_get_leds	-	helper for braille console
  *	@console: console to read
@@ -1085,24 +1176,22 @@ void vt_kbd_con_stop(int console)
 }
 
 /*
- * This is the tasklet that updates LED state on all keyboards
- * attached to the box. The reason we use tasklet is that we
- * need to handle the scenario when keyboard handler is not
- * registered yet but we already getting updates from the VT to
- * update led state.
+ * This is the tasklet that updates LED state of LEDs using standard
+ * keyboard triggers. The reason we use tasklet is that we need to
+ * handle the scenario when keyboard handler is not registered yet
+ * but we already getting updates from the VT to update led state.
  */
 static void kbd_bh(unsigned long dummy)
 {
 	unsigned char leds;
 	unsigned long flags;
-	
+
 	spin_lock_irqsave(&led_lock, flags);
 	leds = getleds();
 	spin_unlock_irqrestore(&led_lock, flags);
 
 	if (leds != ledstate) {
-		input_handler_for_each_handle(&kbd_handler, &leds,
-					      kbd_update_leds_helper);
+		kbd_propagate_led_state(ledstate, leds);
 		ledstate = leds;
 	}
 }
@@ -1450,8 +1539,10 @@ static void kbd_start(struct input_handle *handle)
 {
 	tasklet_disable(&keyboard_tasklet);
 
-	if (ledstate != 0xff)
-		kbd_update_leds_helper(handle, &ledstate);
+	if (ledstate != 0xff) {
+		unsigned int state = ledstate;
+		kbd_update_leds_helper(handle, &state);
+	}
 
 	tasklet_enable(&keyboard_tasklet);
 }
@@ -1497,6 +1588,8 @@ int __init kbd_init(void)
 		kbd_table[i].kbdmode = default_utf8 ? VC_UNICODE : VC_XLATE;
 	}
 
+	kbd_init_leds();
+
 	error = input_register_handler(&kbd_handler);
 	if (error)
 		return error;
-- 
2.2.0.rc0.207.ga3a616c

