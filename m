From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 6/6] HID: sony: Add conditionals to enable all features in Bluetooth mode
Date: Thu, 30 Jan 2014 12:24:08 -0500
Message-ID: <1391102648-19381-7-git-send-email-frank.praznik@oh.rr.com>
References: <1391102648-19381-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:59584 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298AbaA3RYQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jan 2014 12:24:16 -0500
In-Reply-To: <1391102648-19381-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Add the necessary conditionals to enable battery reporting, rumble, LED
settings and touchpad parsing.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---
 drivers/hid/hid-sony.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index eee56d7..d920362 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -44,8 +44,10 @@
 #define DUALSHOCK4_CONTROLLER_USB BIT(5)
 #define DUALSHOCK4_CONTROLLER_BT  BIT(6)
 
-#define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER | DUALSHOCK4_CONTROLLER_USB)
-#define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT | DUALSHOCK4_CONTROLLER_USB)
+#define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER | \
+			  DUALSHOCK4_CONTROLLER_USB | DUALSHOCK4_CONTROLLER_BT)
+#define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT | \
+			      DUALSHOCK4_CONTROLLER_USB | DUALSHOCK4_CONTROLLER_BT)
 
 #define MAX_LEDS 4
 
@@ -939,8 +941,9 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		swap(rd[47], rd[48]);
 
 		sixaxis_parse_report(sc, rd, size);
-	} else if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
-			size == 64) {
+	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
+			size == 64) || ((sc->quirks & DUALSHOCK4_CONTROLLER_BT)
+			&& rd[0] == 0x11 && size == 78)) {
 		dualshock4_parse_report(sc, rd, size);
 	}
 
@@ -1079,7 +1082,8 @@ static void sony_set_leds(struct hid_device *hdev, const __u8 *leds, int count)
 	if (drv_data->quirks & BUZZ_CONTROLLER && count == 4) {
 		buzz_set_leds(hdev, leds);
 	} else if ((drv_data->quirks & SIXAXIS_CONTROLLER_USB) ||
-		   (drv_data->quirks & DUALSHOCK4_CONTROLLER_USB)) {
+		   (drv_data->quirks & DUALSHOCK4_CONTROLLER_USB) ||
+		   (drv_data->quirks & DUALSHOCK4_CONTROLLER_BT)) {
 		for (n = 0; n < count; n++)
 			drv_data->led_state[n] = leds[n];
 		schedule_work(&drv_data->state_worker);
@@ -1184,7 +1188,8 @@ static int sony_leds_init(struct hid_device *hdev)
 		/* Validate expected report characteristics. */
 		if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
 			return -ENODEV;
-	} else if (drv_data->quirks & DUALSHOCK4_CONTROLLER_USB) {
+	} else if ((drv_data->quirks & DUALSHOCK4_CONTROLLER_USB) ||
+		   (drv_data->quirks & DUALSHOCK4_CONTROLLER_BT)) {
 		drv_data->led_count = 3;
 		max_brightness = 255;
 		use_colors = 1;
@@ -1509,7 +1514,8 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
-	else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
+	else if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) ||
+		 (sc->quirks & DUALSHOCK4_CONTROLLER_BT)) {
 		if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) &&
 		     hdev->ll_driver->output_report == NULL) {
 			hid_err(hdev, "NULL output_report handler\n");
-- 
1.8.5.3

