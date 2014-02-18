From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 2/3] HID: sony: Force-feedback cleanup
Date: Tue, 18 Feb 2014 17:22:02 -0500
Message-ID: <1392762123-17725-3-git-send-email-frank.praznik@oh.rr.com>
References: <1392762123-17725-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:64423 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaBRWWM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Feb 2014 17:22:12 -0500
In-Reply-To: <1392762123-17725-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Only initialize force feedback for devices that actually support it (Sixaxis and
Dualshock 4).

Move the cancel_work_sync() call out of sony_destroy_ff() since the state worker
is used for the LEDs even when force-feedback is disabled.

Remove the sony_destroy_ff() function since it is no longer used.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 81917eb..ad1cebd 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -50,6 +50,7 @@
 #define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER | BUZZ_CONTROLLER |\
 				DUALSHOCK4_CONTROLLER)
 #define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
+#define SONY_FF_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
 
 #define MAX_LEDS 4
 
@@ -1354,22 +1355,12 @@ static int sony_init_ff(struct hid_device *hdev)
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
@@ -1567,9 +1558,11 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
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
@@ -1595,7 +1588,7 @@ static void sony_remove(struct hid_device *hdev)
 		sony_battery_remove(sc);
 	}
 
-	sony_destroy_ff(hdev);
+	cancel_work_sync(&sc->state_worker);
 
 	hid_hw_stop(hdev);
 }
-- 
1.8.5.3

