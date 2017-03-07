From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH v2 07/12] HID: sony: Support motion sensor calibration on dongle
Date: Tue,  7 Mar 2017 15:45:06 -0800
Message-ID: <20170307234511.30380-8-roderick@gaikai.com>
References: <20170307234511.30380-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35021 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933268AbdCGXqo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 18:46:44 -0500
Received: by mail-pf0-f170.google.com with SMTP id j5so6640039pfb.2
        for <linux-input@vger.kernel.org>; Tue, 07 Mar 2017 15:45:22 -0800 (PST)
In-Reply-To: <20170307234511.30380-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The DualShock 4 dongle isn't connected to a real DualShock 4 at
time of driver loading. When a DualShock 4 is plugged in, we
need to obtain calibration data (the dongle would have zeros).

This patch adds calibration logic, which we schedule on a hotplug
from sony_raw_event. In addition this patch adds dongle state
handling.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 89 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 19a4ca8..de74d5a 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -624,8 +624,16 @@ struct ds4_calibration_data {
 	int sens_denom;
 };
 
+enum ds4_dongle_state {
+	DONGLE_DISCONNECTED,
+	DONGLE_CALIBRATING,
+	DONGLE_CONNECTED,
+	DONGLE_DISABLED
+};
+
 enum sony_worker {
-	SONY_WORKER_STATE
+	SONY_WORKER_STATE,
+	SONY_WORKER_HOTPLUG
 };
 
 struct sony_sc {
@@ -636,6 +644,7 @@ struct sony_sc {
 	struct input_dev *sensor_dev;
 	struct led_classdev *leds[MAX_LEDS];
 	unsigned long quirks;
+	struct work_struct hotplug_worker;
 	struct work_struct state_worker;
 	void (*send_output_report)(struct sony_sc *);
 	struct power_supply *battery;
@@ -649,6 +658,7 @@ struct sony_sc {
 #endif
 
 	u8 mac_address[6];
+	u8 hotplug_worker_initialized;
 	u8 state_worker_initialized;
 	u8 defer_initialization;
 	u8 cable_state;
@@ -663,7 +673,7 @@ struct sony_sc {
 	u16 prev_timestamp;
 	unsigned int timestamp_us;
 
-	bool ds4_dongle_connected;
+	enum ds4_dongle_state ds4_dongle_state;
 	/* DS4 calibration data */
 	struct ds4_calibration_data ds4_calib_data[6];
 };
@@ -677,6 +687,11 @@ static inline void sony_schedule_work(struct sony_sc *sc,
 	case SONY_WORKER_STATE:
 		if (!sc->defer_initialization)
 			schedule_work(&sc->state_worker);
+		break;
+	case SONY_WORKER_HOTPLUG:
+		if (sc->hotplug_worker_initialized)
+			schedule_work(&sc->hotplug_worker);
+		break;
 	}
 }
 
@@ -1085,6 +1100,9 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		dualshock4_parse_report(sc, rd, size);
 	} else if ((sc->quirks & DUALSHOCK4_DONGLE) && rd[0] == 0x01 &&
 			size == 64) {
+		unsigned long flags;
+		enum ds4_dongle_state dongle_state;
+
 		/*
 		 * In the case of a DS4 USB dongle, bit[2] of byte 31 indicates
 		 * if a DS4 is actually connected (indicated by '0').
@@ -1092,16 +1110,45 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		 */
 		bool connected = (rd[31] & 0x04) ? false : true;
 
-		if (!sc->ds4_dongle_connected && connected) {
+		spin_lock_irqsave(&sc->lock, flags);
+		dongle_state = sc->ds4_dongle_state;
+		spin_unlock_irqrestore(&sc->lock, flags);
+
+		/*
+		 * The dongle always sends input reports even when no
+		 * DS4 is attached. When a DS4 is connected, we need to
+		 * obtain calibration data before we can use it.
+		 * The code below tracks dongle state and kicks of
+		 * calibration when needed and only allows us to process
+		 * input if a DS4 is actually connected.
+		 */
+		if (dongle_state == DONGLE_DISCONNECTED && connected) {
 			hid_info(sc->hdev, "DualShock 4 USB dongle: controller connected\n");
 			sony_set_leds(sc);
-			sc->ds4_dongle_connected = true;
-		} else if (sc->ds4_dongle_connected && !connected) {
+
+			spin_lock_irqsave(&sc->lock, flags);
+			sc->ds4_dongle_state = DONGLE_CALIBRATING;
+			spin_unlock_irqrestore(&sc->lock, flags);
+
+			sony_schedule_work(sc, SONY_WORKER_HOTPLUG);
+
+			/* Don't process the report since we don't have
+			 * calibration data, but let hidraw have it anyway.
+			 */
+			return 0;
+		} else if ((dongle_state == DONGLE_CONNECTED ||
+			    dongle_state == DONGLE_DISABLED) && !connected) {
 			hid_info(sc->hdev, "DualShock 4 USB dongle: controller disconnected\n");
-			sc->ds4_dongle_connected = false;
+
+			spin_lock_irqsave(&sc->lock, flags);
+			sc->ds4_dongle_state = DONGLE_DISCONNECTED;
+			spin_unlock_irqrestore(&sc->lock, flags);
+
 			/* Return 0, so hidraw can get the report. */
 			return 0;
-		} else if (!sc->ds4_dongle_connected) {
+		} else if (dongle_state == DONGLE_CALIBRATING ||
+			   dongle_state == DONGLE_DISABLED ||
+			   dongle_state == DONGLE_DISCONNECTED) {
 			/* Return 0, so hidraw can get the report. */
 			return 0;
 		}
@@ -1518,6 +1565,33 @@ static int dualshock4_get_calibration_data(struct sony_sc *sc)
 	return ret;
 }
 
+static void dualshock4_calibration_work(struct work_struct *work)
+{
+	struct sony_sc *sc = container_of(work, struct sony_sc, hotplug_worker);
+	unsigned long flags;
+	enum ds4_dongle_state dongle_state;
+	int ret;
+
+	ret = dualshock4_get_calibration_data(sc);
+	if (ret < 0) {
+		/* This call is very unlikely to fail for the dongle. When it
+		 * fails we are probably in a very bad state, so mark the
+		 * dongle as disabled. We will re-enable the dongle if a new
+		 * DS4 hotplug is detect from sony_raw_event as any issues
+		 * are likely resolved then (the dongle is quite stupid).
+		 */
+		hid_err(sc->hdev, "DualShock 4 USB dongle: calibration failed, disabling device\n");
+		dongle_state = DONGLE_DISABLED;
+	} else {
+		hid_info(sc->hdev, "DualShock 4 USB dongle: calibration completed\n");
+		dongle_state = DONGLE_CONNECTED;
+	}
+
+	spin_lock_irqsave(&sc->lock, flags);
+	sc->ds4_dongle_state = dongle_state;
+	spin_unlock_irqrestore(&sc->lock, flags);
+}
+
 static void sixaxis_set_leds_from_id(struct sony_sc *sc)
 {
 	static const u8 sixaxis_leds[10][4] = {
@@ -2362,6 +2436,8 @@ static inline void sony_init_output_report(struct sony_sc *sc,
 
 static inline void sony_cancel_work_sync(struct sony_sc *sc)
 {
+	if (sc->hotplug_worker_initialized)
+		cancel_work_sync(&sc->hotplug_worker);
 	if (sc->state_worker_initialized)
 		cancel_work_sync(&sc->state_worker);
 }
@@ -2443,6 +2519,12 @@ static int sony_input_configured(struct hid_device *hdev,
 			goto err_stop;
 		}
 
+		if (sc->quirks & DUALSHOCK4_DONGLE) {
+			INIT_WORK(&sc->hotplug_worker, dualshock4_calibration_work);
+			sc->hotplug_worker_initialized = 1;
+			sc->ds4_dongle_state = DONGLE_DISCONNECTED;
+		}
+
 		sony_init_output_report(sc, dualshock4_send_output_report);
 	} else if (sc->quirks & MOTION_CONTROLLER) {
 		sony_init_output_report(sc, motion_send_output_report);
-- 
2.9.3

