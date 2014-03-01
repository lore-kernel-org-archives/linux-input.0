From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 3/6] HID: sony: Use inliners for work queue initialization and cancellation
Date: Fri, 28 Feb 2014 22:58:58 -0500
Message-ID: <1393646341-16947-4-git-send-email-frank.praznik@oh.rr.com>
References: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:39195 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbaCAD70 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Feb 2014 22:59:26 -0500
In-Reply-To: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Use inliners to make sure that the work queue initialization flags are always
checked and set correctly when initializing or cancelling the work queue.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 233c094..dc6e6fa 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1617,6 +1617,22 @@ static int sony_check_add(struct sony_sc *sc)
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
+
+	sc->worker_initialized = 0;
+}
 
 static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
@@ -1657,12 +1673,10 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
 		ret = sixaxis_set_operational_usb(hdev);
-		sc->worker_initialized = 1;
-		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
+		sony_init_work(sc, sixaxis_state_worker);
 	} else if (sc->quirks & SIXAXIS_CONTROLLER_BT) {
 		ret = sixaxis_set_operational_bt(hdev);
-		sc->worker_initialized = 1;
-		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
+		sony_init_work(sc, sixaxis_state_worker);
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
 		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
 			ret = dualshock4_set_operational_bt(hdev);
@@ -1679,8 +1693,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		if (ret < 0)
 			goto err_stop;
 
-		sc->worker_initialized = 1;
-		INIT_WORK(&sc->state_worker, dualshock4_state_worker);
+		sony_init_work(sc, dualshock4_state_worker);
 	} else {
 		ret = 0;
 	}
@@ -1725,8 +1738,7 @@ err_stop:
 		sony_leds_remove(sc);
 	if (sc->quirks & SONY_BATTERY_SUPPORT)
 		sony_battery_remove(sc);
-	if (sc->worker_initialized)
-		cancel_work_sync(&sc->state_worker);
+	sony_cancel_work_sync(sc);
 	sony_remove_dev_list(sc);
 	hid_hw_stop(hdev);
 	return ret;
@@ -1744,8 +1756,7 @@ static void sony_remove(struct hid_device *hdev)
 		sony_battery_remove(sc);
 	}
 
-	if (sc->worker_initialized)
-		cancel_work_sync(&sc->state_worker);
+	sony_cancel_work_sync(sc);
 
 	sony_remove_dev_list(sc);
 
-- 
1.8.5.3

