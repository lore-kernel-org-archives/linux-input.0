From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 1/3] HID: sony: Enable LED controls and rumble for the Sixaxis on Bluetooth.
Date: Tue, 18 Feb 2014 17:22:01 -0500
Message-ID: <1392762123-17725-2-git-send-email-frank.praznik@oh.rr.com>
References: <1392762123-17725-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:64423 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751932AbaBRWWL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Feb 2014 17:22:11 -0500
In-Reply-To: <1392762123-17725-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dh.herrmann@gmail.com, jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Add a SIXAXIS_CONTROLLER macro to simplify conditionals where the
connection type is irrelevant.

Enable the LED and force feedback controls for Sixaxis controllers connected via
Bluetooth.

Send Sixaxis Bluetooth output reports on the control channel.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c     | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f88d1ae..81917eb 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -44,12 +44,12 @@
 #define DUALSHOCK4_CONTROLLER_USB BIT(5)
 #define DUALSHOCK4_CONTROLLER_BT  BIT(6)
 
+#define SIXAXIS_CONTROLLER (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)
 #define DUALSHOCK4_CONTROLLER (DUALSHOCK4_CONTROLLER_USB |\
 				DUALSHOCK4_CONTROLLER_BT)
-#define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER |\
-				DUALSHOCK4_CONTROLLER)
-#define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT |\
+#define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER | BUZZ_CONTROLLER |\
 				DUALSHOCK4_CONTROLLER)
+#define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER | DUALSHOCK4_CONTROLLER)
 
 #define MAX_LEDS 4
 
@@ -935,8 +935,7 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 	/* Sixaxis HID report has acclerometers/gyro with MSByte first, this
 	 * has to be BYTE_SWAPPED before passing up to joystick interface
 	 */
-	if ((sc->quirks & (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT)) &&
-			rd[0] == 0x01 && size == 49) {
+	if ((sc->quirks & SIXAXIS_CONTROLLER) && rd[0] == 0x01 && size == 49) {
 		swap(rd[41], rd[42]);
 		swap(rd[43], rd[44]);
 		swap(rd[45], rd[46]);
@@ -1096,8 +1095,7 @@ static void sony_set_leds(struct hid_device *hdev, const __u8 *leds, int count)
 
 	if (drv_data->quirks & BUZZ_CONTROLLER && count == 4) {
 		buzz_set_leds(hdev, leds);
-	} else if ((drv_data->quirks & SIXAXIS_CONTROLLER_USB) ||
-		   (drv_data->quirks & DUALSHOCK4_CONTROLLER)) {
+	} else {
 		for (n = 0; n < count; n++)
 			drv_data->led_state[n] = leds[n];
 		schedule_work(&drv_data->state_worker);
@@ -1285,7 +1283,11 @@ static void sixaxis_state_worker(struct work_struct *work)
 	buf[10] |= sc->led_state[2] << 3;
 	buf[10] |= sc->led_state[3] << 4;
 
-	hid_output_raw_report(sc->hdev, buf, sizeof(buf), HID_OUTPUT_REPORT);
+	if (sc->quirks & SIXAXIS_CONTROLLER_USB)
+		hid_output_raw_report(sc->hdev, buf, sizeof(buf), HID_OUTPUT_REPORT);
+	else
+		hid_hw_raw_request(sc->hdev, 0x01, buf, sizeof(buf),
+				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
 static void dualshock4_state_worker(struct work_struct *work)
@@ -1520,10 +1522,10 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
 		ret = sixaxis_set_operational_usb(hdev);
 		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
-	}
-	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
+	} else if (sc->quirks & SIXAXIS_CONTROLLER_BT) {
 		ret = sixaxis_set_operational_bt(hdev);
-	else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
+		INIT_WORK(&sc->state_worker, sixaxis_state_worker);
+	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
 		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
 			ret = dualshock4_set_operational_bt(hdev);
 			if (ret < 0) {
-- 
1.8.5.3

