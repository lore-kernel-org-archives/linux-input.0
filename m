From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH] HID: sony: Fix work queue issues.
Date: Wed, 19 Feb 2014 13:09:22 -0500
Message-ID: <1392833362-4218-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: stable@vger.kernel.org, dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>
List-Id: linux-input@vger.kernel.org

Don't initialize force-feedback for devices that don't support it to avoid calls
to schedule_work() with an uninitialized work_struct.

Move the cancel_work_sync() call out of sony_destroy_ff() since the state worker
is used for the LEDs even when force-feedback is disabled.

Remove sony_destroy_ff() to avoid a compiler warning since it is no longer used.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 This is a bugfix for 3.14.

 drivers/hid/hid-sony.c | 27 ++++++++++++---------------
 1 file changed, 12 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 1235405..2f19b15 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -42,6 +42,7 @@
 #define DUALSHOCK4_CONTROLLER_BT  BIT(6)
 
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER | DUALSHOCK4_CONTROLLER_USB)
+#define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER_USB | DUALSHOCK4_CONTROLLER_USB)
 
 #define MAX_LEDS 4
 
@@ -499,6 +500,7 @@ struct sony_sc {
 	__u8 right;
 #endif
 
+	__u8 worker_initialized;
 	__u8 led_state[MAX_LEDS];
 	__u8 led_count;
 };
@@ -993,22 +995,11 @@ static int sony_init_ff(struct hid_device *hdev)
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
-
-static void sony_destroy_ff(struct hid_device *hdev)
-{
-}
 #endif
 
 static int sony_set_output_report(struct sony_sc *sc, int req_id, int req_size)
@@ -1077,6 +1068,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
 		ret = sixaxis_set_operational_usb(hdev);
+
+		sc->worker_initialized = 1;
 		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
 	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
@@ -1087,6 +1080,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (ret < 0)
 			goto err_stop;
 
+		sc->worker_initialized = 1;
 		INIT_WORK(&sc->state_worker, dualshock4_state_worker);
 	} else {
 		ret = 0;
@@ -1101,9 +1095,11 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			goto err_stop;
 	}
 
-	ret = sony_init_ff(hdev);
-	if (ret < 0)
-		goto err_stop;
+	if (sc->quirks & SONY_FF_SUPPORT) {
+		ret = sony_init_ff(hdev);
+		if (ret < 0)
+			goto err_stop;
+	}
 
 	return 0;
 err_stop:
@@ -1120,7 +1116,8 @@ static void sony_remove(struct hid_device *hdev)
 	if (sc->quirks & SONY_LED_SUPPORT)
 		sony_leds_remove(hdev);
 
-	sony_destroy_ff(hdev);
+	if (sc->worker_initialized)
+		cancel_work_sync(&sc->state_worker);
 
 	hid_hw_stop(hdev);
 }
-- 
1.8.5.3
