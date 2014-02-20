From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 2/5] HID: sony: Fix work queue issues
Date: Thu, 20 Feb 2014 11:36:01 -0500
Message-ID: <1392914164-31899-3-git-send-email-frank.praznik@oh.rr.com>
References: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:59700 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755397AbaBTQgN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Feb 2014 11:36:13 -0500
In-Reply-To: <1392914164-31899-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Only initialize force feedback for devices that actually support it (Sixaxis and
Dualshock 4) to prevent calls to schedule_work() with an uninitialized work
queue.

Move the cancel_work_sync() call out of sony_destroy_ff() since the state worker
is used for the LEDs even when force-feedback is disabled.

Remove the sony_destroy_ff() function since it is no longer used.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 This is functionally the same as the 3.14 fix but updated for the 3.15 codebase

 drivers/hid/hid-sony.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 26992e1..a51a9c0 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -51,6 +51,7 @@
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER | BUZZ_CONTROLLER |\
 				DUALSHOCK4_CONTROLLER)
 #define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
+#define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
 
 #define MAX_LEDS 4
 
@@ -729,6 +730,7 @@ struct sony_sc {
 	__u8 right;
 #endif
 
+	__u8 worker_initialized;
 	__u8 cable_state;
 	__u8 battery_charging;
 	__u8 battery_capacity;
@@ -1367,22 +1369,12 @@ static int sony_init_ff(struct hid_device *hdev)
 	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
 }
 
-static void sony_destroy_ff(struct hid_device *hdev)
-{
-	struct sony_sc *sc = hid_get_drvdata(hdev);
-
-	cancel_work_sync(&sc->state_worker);
-}
-
 #else
 static int sony_init_ff(struct hid_device *hdev)
 {
 	return 0;
 }
 
-static void sony_destroy_ff(struct hid_device *hdev)
-{
-}
 #endif
 
 static int sony_battery_get_property(struct power_supply *psy,
@@ -1535,9 +1527,11 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
 		ret = sixaxis_set_operational_usb(hdev);
+		sc->worker_initialized = 1;
 		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_BT) {
 		ret = sixaxis_set_operational_bt(hdev);
+		sc->worker_initialized = 1;
 		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
 		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
@@ -1555,6 +1549,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (ret < 0)
 			goto err_stop;
 
+		sc->worker_initialized = 1;
 		INIT_WORK(&sc->state_worker, dualshock4_state_worker);
 	} else {
 		ret = 0;
@@ -1582,9 +1577,11 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		}
 	}
 
-	ret = sony_init_ff(hdev);
-	if (ret < 0)
-		goto err_close;
+	if (sc->quirks & SONY_FF_SUPPORT) {
+		ret = sony_init_ff(hdev);
+		if (ret < 0)
+			goto err_close;
+	}
 
 	return 0;
 err_close:
@@ -1594,6 +1591,8 @@ err_stop:
 		sony_leds_remove(hdev);
 	if (sc->quirks & SONY_BATTERY_SUPPORT)
 		sony_battery_remove(sc);
+	if (sc->worker_initialized)
+		cancel_work_sync(&sc->state_worker);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -1610,7 +1609,8 @@ static void sony_remove(struct hid_device *hdev)
 		sony_battery_remove(sc);
 	}
 
-	sony_destroy_ff(hdev);
+	if (sc->worker_initialized)
+		cancel_work_sync(&sc->state_worker);
 
 	hid_hw_stop(hdev);
 }
-- 
1.8.5.3

