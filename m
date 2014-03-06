From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 3/8] HID: sony: Use inliners for work queue initialization and cancellation
Date: Thu,  6 Mar 2014 17:32:51 -0500
Message-ID: <1394145176-24174-4-git-send-email-frank.praznik@oh.rr.com>
References: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:7064 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750829AbaCFWkL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Mar 2014 17:40:11 -0500
In-Reply-To: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Use inliners to make sure that the work queue initialization flag is always
checked and set correctly when initializing or cancelling the work queue.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 v2 doesn't set worker_initialized to 0 when cancelling work sync since
 cancel_work_sync doesn't deinitialize the work queue.

 drivers/hid/hid-sony.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 908de27..3df3306 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1578,6 +1578,20 @@ static int sony_check_add(struct sony_sc *sc)
 	return sony_check_add_dev_list(sc);
 }
 
+static inline void sony_init_work(struct sony_sc *sc,
+					void(*worker)(struct work_struct *))
+{
+	if (!sc->worker_initialized)
+		INIT_WORK(&sc->state_worker, worker);
+
+	sc->worker_initialized = 1;
+}
+
+static inline void sony_cancel_work_sync(struct sony_sc *sc)
+{
+	if (sc->worker_initialized)
+		cancel_work_sync(&sc->state_worker);
+}
 
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
@@ -1629,8 +1643,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
 		hdev->quirks |= HID_QUIRK_SKIP_OUTPUT_REPORT_ID;
 		ret = sixaxis_set_operational_usb(hdev);
-		sc->worker_initialized = 1;
-		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
+		sony_init_work(sc, sixaxis_state_worker);
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_BT) {
 		/*
 		 * The Sixaxis wants output reports sent on the ctrl endpoint
@@ -1638,8 +1651,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 */
 		hdev->quirks |= HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP;
 		ret = sixaxis_set_operational_bt(hdev);
-		sc->worker_initialized = 1;
-		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
+		sony_init_work(sc, sixaxis_state_worker);
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
 		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
 			/*
@@ -1661,8 +1673,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (ret < 0)
 			goto err_stop;
 
-		sc->worker_initialized = 1;
-		INIT_WORK(&sc->state_worker, dualshock4_state_worker);
+		sony_init_work(sc, dualshock4_state_worker);
 	} else {
 		ret = 0;
 	}
@@ -1707,8 +1718,7 @@ err_stop:
 		sony_leds_remove(hdev);
 	if (sc->quirks & SONY_BATTERY_SUPPORT)
 		sony_battery_remove(sc);
-	if (sc->worker_initialized)
-		cancel_work_sync(&sc->state_worker);
+	sony_cancel_work_sync(sc);
 	sony_remove_dev_list(sc);
 	hid_hw_stop(hdev);
 	return ret;
@@ -1726,8 +1736,7 @@ static void sony_remove(struct hid_device *hdev)
 		sony_battery_remove(sc);
 	}
 
-	if (sc->worker_initialized)
-		cancel_work_sync(&sc->state_worker);
+	sony_cancel_work_sync(sc);
 
 	sony_remove_dev_list(sc);
 
-- 
1.8.5.3

