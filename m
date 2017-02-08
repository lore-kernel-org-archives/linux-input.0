From: Frank Praznik <frank.praznik@gmail.com>
Subject: [PATCH] HID: sony: Use LED_CORE_SUSPENDRESUME
Date: Wed,  8 Feb 2017 13:58:43 -0500
Message-ID: <20170208185843.5822-1-frank.praznik@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36730 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbdBHTJp (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 8 Feb 2017 14:09:45 -0500
Received: by mail-qt0-f196.google.com with SMTP id h53so24452720qth.3
        for <linux-input@vger.kernel.org>; Wed, 08 Feb 2017 11:08:19 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, roderick.colenbrander@sony.com, simon@mungewell.org, tim.bird@am.sony.com, dmitry.torokhov@gmail.com, Frank Praznik <frank.praznik@gmail.com>

The LED subsystem provides the LED_CORE_SUSPENDRESUME flag to handle
automatically turning off and restoring the state of device LEDs during
suspend/resume.  Use this flag instead of saving and restoring the state
locally.

Signed-off-by: Frank Praznik <frank.praznik@gmail.com>
---
 drivers/hid/hid-sony.c | 45 +++++++++++++++------------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f405b07..7e2bae3 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1095,7 +1095,6 @@ struct sony_sc {
 	u8 battery_charging;
 	u8 battery_capacity;
 	u8 led_state[MAX_LEDS];
-	u8 resume_led_state[MAX_LEDS];
 	u8 led_delay_on[MAX_LEDS];
 	u8 led_delay_off[MAX_LEDS];
 	u8 led_count;
@@ -1964,6 +1963,7 @@ static int sony_leds_init(struct sony_sc *sc)
 		led->name = name;
 		led->brightness = sc->led_state[n];
 		led->max_brightness = max_brightness[n];
+		led->flags = LED_CORE_SUSPENDRESUME;
 		led->brightness_get = sony_led_get_brightness;
 		led->brightness_set = sony_led_set_brightness;
 
@@ -2734,47 +2734,32 @@ static void sony_remove(struct hid_device *hdev)
 
 static int sony_suspend(struct hid_device *hdev, pm_message_t message)
 {
-	/*
-	 * On suspend save the current LED state,
-	 * stop running force-feedback and blank the LEDS.
-	 */
-	if (SONY_LED_SUPPORT || SONY_FF_SUPPORT) {
-		struct sony_sc *sc = hid_get_drvdata(hdev);
-
 #ifdef CONFIG_SONY_FF
-		sc->left = sc->right = 0;
-#endif
 
-		memcpy(sc->resume_led_state, sc->led_state,
-			sizeof(sc->resume_led_state));
-		memset(sc->led_state, 0, sizeof(sc->led_state));
+	/* On suspend stop any running force-feedback events */
+	if (SONY_FF_SUPPORT) {
+		struct sony_sc *sc = hid_get_drvdata(hdev);
 
+		sc->left = sc->right = 0;
 		sony_send_output_report(sc);
 	}
 
+#endif
 	return 0;
 }
 
 static int sony_resume(struct hid_device *hdev)
 {
-	/* Restore the state of controller LEDs on resume */
-	if (SONY_LED_SUPPORT) {
-		struct sony_sc *sc = hid_get_drvdata(hdev);
-
-		memcpy(sc->led_state, sc->resume_led_state,
-			sizeof(sc->led_state));
-
-		/*
-		 * The Sixaxis and navigation controllers on USB need to be
-		 * reinitialized on resume or they won't behave properly.
-		 */
-		if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
-			(sc->quirks & NAVIGATION_CONTROLLER_USB)) {
-			sixaxis_set_operational_usb(sc->hdev);
-			sc->defer_initialization = 1;
-		}
+	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-		sony_set_leds(sc);
+	/*
+	 * The Sixaxis and navigation controllers on USB need to be
+	 * reinitialized on resume or they won't behave properly.
+	 */
+	if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
+		(sc->quirks & NAVIGATION_CONTROLLER_USB)) {
+		sixaxis_set_operational_usb(sc->hdev);
+		sc->defer_initialization = 1;
 	}
 
 	return 0;
-- 
2.9.3

