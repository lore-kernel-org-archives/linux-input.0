From: Frank Praznik <frank.praznik@gmail.com>
Subject: [PATCH 2/3] hid: sony: Defer the initial USB Sixaxis output report
Date: Thu, 22 Sep 2016 20:18:09 -0400
Message-ID: <1474589890-7141-3-git-send-email-frank.praznik@gmail.com>
References: <1474589890-7141-1-git-send-email-frank.praznik@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35928 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933315AbcIWASi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Sep 2016 20:18:38 -0400
Received: by mail-qk0-f193.google.com with SMTP id z143so6193588qka.3
        for <linux-input@vger.kernel.org>; Thu, 22 Sep 2016 17:18:37 -0700 (PDT)
In-Reply-To: <1474589890-7141-1-git-send-email-frank.praznik@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, Frank Praznik <frank.praznik@gmail.com>

When initially connected via USB the Sixaxis isn't fully initialized
until the PS logo button is pressed and won't send any input reports
nor will any state set by output reports be retained.

This adds a 'defer_initialization' flag to the sony_sc struct which,
when set, will delay sending any output reports until the first input
report has arrived. This flag is used with the USB Sixaxis to ensure
that any state sent will persist since, until the PS button is pushed,
any changes sent to the controller via an output report will be lost
after a couple of seconds.

The initial state of the controller is still configured at the time
of the initial connection and won't be internally modified after that,
so any state set by the user between that time and the recepit of the
first input report won't be lost.

Signed-off-by: Frank Praznik <frank.praznik@gmail.com>
---

 - A variant of this patch has been in the SteamOS kernel for some
   time, so it's well-tested at this point.

 drivers/hid/hid-sony.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 92f27b7..9b96f95 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1050,6 +1050,7 @@ struct sony_sc {
 
 	u8 mac_address[6];
 	u8 worker_initialized;
+	u8 defer_initialization;
 	u8 cable_state;
 	u8 battery_charging;
 	u8 battery_capacity;
@@ -1060,6 +1061,12 @@ struct sony_sc {
 	u8 led_count;
 };
 
+static inline void sony_schedule_work(struct sony_sc *sc)
+{
+	if (!sc->defer_initialization)
+		schedule_work(&sc->state_worker);
+}
+
 static u8 *sixaxis_fixup(struct hid_device *hdev, u8 *rdesc,
 			     unsigned int *rsize)
 {
@@ -1319,6 +1326,11 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		dualshock4_parse_report(sc, rd, size);
 	}
 
+	if (sc->defer_initialization) {
+		sc->defer_initialization = 0;
+		sony_schedule_work(sc);
+	}
+
 	return 0;
 }
 
@@ -1556,7 +1568,7 @@ static void buzz_set_leds(struct sony_sc *sc)
 static void sony_set_leds(struct sony_sc *sc)
 {
 	if (!(sc->quirks & BUZZ_CONTROLLER))
-		schedule_work(&sc->state_worker);
+		sony_schedule_work(sc);
 	else
 		buzz_set_leds(sc);
 }
@@ -1667,7 +1679,7 @@ static int sony_led_blink_set(struct led_classdev *led, unsigned long *delay_on,
 		new_off != drv_data->led_delay_off[n]) {
 		drv_data->led_delay_on[n] = new_on;
 		drv_data->led_delay_off[n] = new_off;
-		schedule_work(&drv_data->state_worker);
+		sony_schedule_work(drv_data);
 	}
 
 	return 0;
@@ -1978,7 +1990,7 @@ static int sony_play_effect(struct input_dev *dev, void *data,
 	sc->left = effect->u.rumble.strong_magnitude / 256;
 	sc->right = effect->u.rumble.weak_magnitude / 256;
 
-	schedule_work(&sc->state_worker);
+	sony_schedule_work(sc);
 	return 0;
 }
 
@@ -2365,9 +2377,16 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 * the Sixaxis does not want the report_id as part of the data
 		 * packet, so we have to discard buf[0] when sending the actual
 		 * control message, even for numbered reports, humpf!
+		 *
+		 * Additionally, the Sixaxis on USB isn't properly initialized
+		 * until the PS logo button is pressed and as such won't retain
+		 * any state set by an output report, so the initial
+		 * configuration report is deferred until the first input
+		 * report arrives.
 		 */
 		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
 		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
+		sc->defer_initialization = 1;
 		ret = sixaxis_set_operational_usb(hdev);
 		sony_init_output_report(sc, sixaxis_send_output_report);
 	} else if ((sc->quirks & SIXAXIS_CONTROLLER_BT) ||
@@ -2510,8 +2529,10 @@ static int sony_resume(struct hid_device *hdev)
 		 * reinitialized on resume or they won't behave properly.
 		 */
 		if ((sc->quirks & SIXAXIS_CONTROLLER_USB) ||
-			(sc->quirks & NAVIGATION_CONTROLLER_USB))
+			(sc->quirks & NAVIGATION_CONTROLLER_USB)) {
 			sixaxis_set_operational_usb(sc->hdev);
+			sc->defer_initialization = 1;
+		}
 
 		sony_set_leds(sc);
 	}
-- 
2.7.4

