From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] Input: atkbd - add LED triggers for keyboard state
Date: Tue, 14 Jul 2015 00:45:54 +0200
Message-ID: <1436827554-2186-1-git-send-email-Jason@zx2c4.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
List-Id: linux-input@vger.kernel.org

Many new laptop keyboards aren't shipping with LEDs in the keys for
caps lock, num lock, and scroll lock. They do, however, ship with many LEDs
for specialized functions that mostly go non-utilized by any current
Linux drivers. Having a caps lock LED is very helpful in early boot full
disk encryption, where a fancy GUI is not available to show that caps
lock is activated.

This patch wires in the caps, num, and scroll lock states of the
keyboard into the generic LED trigger subsystem, so that integrators can
have different LEDs activated on caps/num/scroll lock state changes.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/input/keyboard/atkbd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index ec876b5..d01f83c 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -28,6 +28,7 @@
 #include <linux/libps2.h>
 #include <linux/mutex.h>
 #include <linux/dmi.h>
+#include <linux/leds.h>
 
 #define DRIVER_DESC	"AT and PS/2 keyboard driver"
 
@@ -308,6 +309,12 @@ static const unsigned int xl_table[] = {
 	ATKBD_RET_NAK, ATKBD_RET_HANJA, ATKBD_RET_HANGEUL,
 };
 
+#ifdef CONFIG_LEDS_TRIGGERS
+struct led_trigger *capsl_led_trigger = 0;
+struct led_trigger *numl_led_trigger = 0;
+struct led_trigger *scrolll_led_trigger = 0;
+#endif
+
 /*
  * Checks if we should mangle the scancode to extract 'release' bit
  * in translated mode.
@@ -567,6 +574,12 @@ static int atkbd_set_leds(struct atkbd *atkbd)
 	if (ps2_command(&atkbd->ps2dev, param, ATKBD_CMD_SETLEDS))
 		return -1;
 
+#ifdef CONFIG_LEDS_TRIGGERS
+	led_trigger_event(capsl_led_trigger, test_bit(LED_CAPSL, dev->led) ? LED_FULL : LED_OFF);
+	led_trigger_event(numl_led_trigger, test_bit(LED_NUML, dev->led) ? LED_FULL : LED_OFF);
+	led_trigger_event(scrolll_led_trigger, test_bit(LED_SCROLLL, dev->led) ? LED_FULL : LED_OFF);
+#endif
+
 	if (atkbd->extra) {
 		param[0] = 0;
 		param[1] = (test_bit(LED_COMPOSE, dev->led) ? 0x01 : 0)
@@ -1808,12 +1821,25 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 static int __init atkbd_init(void)
 {
 	dmi_check_system(atkbd_dmi_quirk_table);
+#ifdef CONFIG_LEDS_TRIGGERS
+	led_trigger_register_simple("caps-lock", &capsl_led_trigger);
+	led_trigger_register_simple("num-lock", &numl_led_trigger);
+	led_trigger_register_simple("scroll-lock", &scrolll_led_trigger);
+#endif
 
 	return serio_register_driver(&atkbd_drv);
 }
 
 static void __exit atkbd_exit(void)
 {
+#ifdef CONFIG_LEDS_TRIGGERS
+	led_trigger_unregister_simple(capsl_led_trigger);
+	capsl_led_trigger = 0;
+	led_trigger_unregister_simple(numl_led_trigger);
+	numl_led_trigger = 0;
+	led_trigger_unregister_simple(scrolll_led_trigger);
+	scrolll_led_trigger = 0;
+#endif
 	serio_unregister_driver(&atkbd_drv);
 }
 
-- 
2.4.5
