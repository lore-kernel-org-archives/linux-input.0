From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 3/3] tty/vt/keyboard: define LED triggers for VT keyboard lock states
Date: Mon,  8 Jun 2015 14:43:10 -0700
Message-ID: <1433799790-31873-4-git-send-email-dmitry.torokhov@gmail.com>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33750 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbbFHVna (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Jun 2015 17:43:30 -0400
In-Reply-To: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: Samuel Thibault <samuel.thibault@ens-lyon.org>

In addition to defining triggers for VT LED states, let's define triggers
for VT keyboard lock states, such as "kbd-shiftlock", "kbd-altgrlock", etc.

This permits to fix #7063 from userland by using a modifier to implement
proper CapsLock behavior and have the keyboard caps lock led show that
modifier state.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/tty/vt/keyboard.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index cff193e..1c420d9 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -130,7 +130,7 @@ static char rep;					/* flag telling character repeat */
 
 static int shift_state = 0;
 
-static unsigned char ledstate = 0xff;			/* undefined */
+static unsigned int ledstate = -1U;			/* undefined */
 static unsigned char ledioctl;
 
 /*
@@ -975,7 +975,7 @@ static void kbd_led_trigger_activate(struct led_classdev *cdev)
 		container_of(cdev->trigger, struct kbd_led_trigger, trigger);
 
 	tasklet_disable(&keyboard_tasklet);
-	if (ledstate != 0xff)
+	if (ledstate != -1U)
 		led_trigger_event(&trigger->trigger,
 				  ledstate & trigger->mask ?
 					LED_FULL : LED_OFF);
@@ -990,11 +990,23 @@ static void kbd_led_trigger_activate(struct led_classdev *cdev)
 		.mask	= BIT(_led_bit),			\
 	}
 
+#define KBD_LOCKSTATE_TRIGGER(_led_bit, _name)		\
+	KBD_LED_TRIGGER((_led_bit) + 8, _name)
+
 static struct kbd_led_trigger kbd_led_triggers[] = {
 	KBD_LED_TRIGGER(VC_SCROLLOCK, "kbd-scrollock"),
 	KBD_LED_TRIGGER(VC_NUMLOCK,   "kbd-numlock"),
 	KBD_LED_TRIGGER(VC_CAPSLOCK,  "kbd-capslock"),
 	KBD_LED_TRIGGER(VC_KANALOCK,  "kbd-kanalock"),
+
+	KBD_LOCKSTATE_TRIGGER(VC_SHIFTLOCK,  "kbd-shiftlock"),
+	KBD_LOCKSTATE_TRIGGER(VC_ALTGRLOCK,  "kbd-altgrlock"),
+	KBD_LOCKSTATE_TRIGGER(VC_CTRLLOCK,   "kbd-ctrllock"),
+	KBD_LOCKSTATE_TRIGGER(VC_ALTLOCK,    "kbd-altlock"),
+	KBD_LOCKSTATE_TRIGGER(VC_SHIFTLLOCK, "kbd-shiftllock"),
+	KBD_LOCKSTATE_TRIGGER(VC_SHIFTRLOCK, "kbd-shiftrlock"),
+	KBD_LOCKSTATE_TRIGGER(VC_CTRLLLOCK,  "kbd-ctrlllock"),
+	KBD_LOCKSTATE_TRIGGER(VC_CTRLRLOCK,  "kbd-ctrlrlock"),
 };
 
 static void kbd_propagate_led_state(unsigned int old_state,
@@ -1073,7 +1085,7 @@ static void kbd_init_leds(void)
  */
 static unsigned char getledstate(void)
 {
-	return ledstate;
+	return ledstate & 0xff;
 }
 
 void setledstate(struct kbd_struct *kb, unsigned int led)
@@ -1183,11 +1195,12 @@ void vt_kbd_con_stop(int console)
  */
 static void kbd_bh(unsigned long dummy)
 {
-	unsigned char leds;
+	unsigned int leds;
 	unsigned long flags;
 
 	spin_lock_irqsave(&led_lock, flags);
 	leds = getleds();
+	leds |= (unsigned int)kbd->lockstate << 8;
 	spin_unlock_irqrestore(&led_lock, flags);
 
 	if (leds != ledstate) {
@@ -1539,10 +1552,8 @@ static void kbd_start(struct input_handle *handle)
 {
 	tasklet_disable(&keyboard_tasklet);
 
-	if (ledstate != 0xff) {
-		unsigned int state = ledstate;
-		kbd_update_leds_helper(handle, &state);
-	}
+	if (ledstate != -1U)
+		kbd_update_leds_helper(handle, &ledstate);
 
 	tasklet_enable(&keyboard_tasklet);
 }
-- 
2.2.0.rc0.207.ga3a616c

