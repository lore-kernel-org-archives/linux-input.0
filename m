From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH v2 06/12] HID: sony: Make work handling more generic
Date: Tue,  7 Mar 2017 15:45:05 -0800
Message-ID: <20170307234511.30380-7-roderick@gaikai.com>
References: <20170307234511.30380-1-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33180 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933261AbdCGXqo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Mar 2017 18:46:44 -0500
Received: by mail-pg0-f50.google.com with SMTP id 25so6058606pgy.0
        for <linux-input@vger.kernel.org>; Tue, 07 Mar 2017 15:45:21 -0800 (PST)
In-Reply-To: <20170307234511.30380-1-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The driver currently uses sony_schedule_work to submit output
reports for the different devices for LEDs or rumble.

This patch adds a new parameter to sony_schedule_work to allow
scheduling for other types of work. The next patch in this series
will utilize this functionality. Considering the driver structure
and all error handling it felt best to reuse sony_schedule_work
and sony_cancel_work. The idea was inspired by the wacom driver
which does something similar.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index eff08af..19a4ca8 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -624,6 +624,10 @@ struct ds4_calibration_data {
 	int sens_denom;
 };
 
+enum sony_worker {
+	SONY_WORKER_STATE
+};
+
 struct sony_sc {
 	spinlock_t lock;
 	struct list_head list_node;
@@ -645,7 +649,7 @@ struct sony_sc {
 #endif
 
 	u8 mac_address[6];
-	u8 worker_initialized;
+	u8 state_worker_initialized;
 	u8 defer_initialization;
 	u8 cable_state;
 	u8 battery_charging;
@@ -666,10 +670,14 @@ struct sony_sc {
 
 static void sony_set_leds(struct sony_sc *sc);
 
-static inline void sony_schedule_work(struct sony_sc *sc)
+static inline void sony_schedule_work(struct sony_sc *sc,
+				      enum sony_worker which)
 {
-	if (!sc->defer_initialization)
-		schedule_work(&sc->state_worker);
+	switch (which) {
+	case SONY_WORKER_STATE:
+		if (!sc->defer_initialization)
+			schedule_work(&sc->state_worker);
+	}
 }
 
 static u8 *sixaxis_fixup(struct hid_device *hdev, u8 *rdesc,
@@ -1103,7 +1111,7 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (sc->defer_initialization) {
 		sc->defer_initialization = 0;
-		sony_schedule_work(sc);
+		sony_schedule_work(sc, SONY_WORKER_STATE);
 	}
 
 	return 0;
@@ -1584,7 +1592,7 @@ static void buzz_set_leds(struct sony_sc *sc)
 static void sony_set_leds(struct sony_sc *sc)
 {
 	if (!(sc->quirks & BUZZ_CONTROLLER))
-		sony_schedule_work(sc);
+		sony_schedule_work(sc, SONY_WORKER_STATE);
 	else
 		buzz_set_leds(sc);
 }
@@ -1695,7 +1703,7 @@ static int sony_led_blink_set(struct led_classdev *led, unsigned long *delay_on,
 		new_off != drv_data->led_delay_off[n]) {
 		drv_data->led_delay_on[n] = new_on;
 		drv_data->led_delay_off[n] = new_off;
-		sony_schedule_work(drv_data);
+		sony_schedule_work(drv_data, SONY_WORKER_STATE);
 	}
 
 	return 0;
@@ -2025,7 +2033,7 @@ static int sony_play_effect(struct input_dev *dev, void *data,
 	sc->left = effect->u.rumble.strong_magnitude / 256;
 	sc->right = effect->u.rumble.weak_magnitude / 256;
 
-	sony_schedule_work(sc);
+	sony_schedule_work(sc, SONY_WORKER_STATE);
 	return 0;
 }
 
@@ -2346,15 +2354,15 @@ static inline void sony_init_output_report(struct sony_sc *sc,
 {
 	sc->send_output_report = send_output_report;
 
-	if (!sc->worker_initialized)
+	if (!sc->state_worker_initialized)
 		INIT_WORK(&sc->state_worker, sony_state_worker);
 
-	sc->worker_initialized = 1;
+	sc->state_worker_initialized = 1;
 }
 
 static inline void sony_cancel_work_sync(struct sony_sc *sc)
 {
-	if (sc->worker_initialized)
+	if (sc->state_worker_initialized)
 		cancel_work_sync(&sc->state_worker);
 }
 
-- 
2.9.3

