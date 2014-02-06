From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v3 6/6] HID: sony: Add conditionals to enable all features in Bluetooth mode
Date: Wed,  5 Feb 2014 20:03:49 -0500
Message-ID: <1391648629-3077-7-git-send-email-frank.praznik@oh.rr.com>
References: <1391648629-3077-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:56652 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183AbaBFBER (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Feb 2014 20:04:17 -0500
In-Reply-To: <1391648629-3077-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Add the conditionals to enable rumble, battery reporting, LED and touchpad
support for the Dualshock 4 in Bluetooth mode.

Add dualshock4_set_operational_bt to initialize the controller to the proper
operational state.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 v3 adds a DUALSHOCK4_CONTROLLER macro for conditional cases where the
 connection type is irrelevant as well as dualshock4_set_operational_bt to
 explicitly initialize the controller instead of the device state being set as a
 side effect of initializing the LED system.

 drivers/hid/hid-sony.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 84633bf..1b150d8 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -44,8 +44,12 @@
 #define DUALSHOCK4_CONTROLLER_USB BIT(5)
 #define DUALSHOCK4_CONTROLLER_BT  BIT(6)
 
-#define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER | DUALSHOCK4_CONTROLLER_USB)
-#define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT | DUALSHOCK4_CONTROLLER_USB)
+#define DUALSHOCK4_CONTROLLER (DUALSHOCK4_CONTROLLER_USB |\
+				DUALSHOCK4_CONTROLLER_BT)
+#define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER |\
+				DUALSHOCK4_CONTROLLER)
+#define SONY_BATTERY_SUPPORT (SIXAXIS_CONTROLLER_USB | SIXAXIS_CONTROLLER_BT |\
+				DUALSHOCK4_CONTROLLER)
 
 #define MAX_LEDS 4
 
@@ -939,8 +943,9 @@ static int sony_raw_event(struct hid_device *hdev, struct hid_report *report,
 		swap(rd[47], rd[48]);
 
 		sixaxis_parse_report(sc, rd, size);
-	} else if ((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
-			size == 64) {
+	} else if (((sc->quirks & DUALSHOCK4_CONTROLLER_USB) && rd[0] == 0x01 &&
+			size == 64) || ((sc->quirks & DUALSHOCK4_CONTROLLER_BT)
+			&& rd[0] == 0x11 && size == 78)) {
 		dualshock4_parse_report(sc, rd, size);
 	}
 
@@ -1051,6 +1056,17 @@ static int sixaxis_set_operational_bt(struct hid_device *hdev)
 	return hdev->hid_output_raw_report(hdev, buf, sizeof(buf), HID_FEATURE_REPORT);
 }
 
+/* Requesting feature report 0x02 in Bluetooth mode changes the state of the
+ * controller so that it sends full input reports of type 0x11.
+ */
+static int dualshock4_set_operational_bt(struct hid_device *hdev)
+{
+	__u8 buf[37] = { 0 };
+
+	return hid_hw_raw_request(hdev, 0x02, buf, sizeof(buf),
+				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
+}
+
 static void buzz_set_leds(struct hid_device *hdev, const __u8 *leds)
 {
 	struct list_head *report_list =
@@ -1079,7 +1095,7 @@ static void sony_set_leds(struct hid_device *hdev, const __u8 *leds, int count)
 	if (drv_data->quirks & BUZZ_CONTROLLER && count == 4) {
 		buzz_set_leds(hdev, leds);
 	} else if ((drv_data->quirks & SIXAXIS_CONTROLLER_USB) ||
-		   (drv_data->quirks & DUALSHOCK4_CONTROLLER_USB)) {
+		   (drv_data->quirks & DUALSHOCK4_CONTROLLER)) {
 		for (n = 0; n < count; n++)
 			drv_data->led_state[n] = leds[n];
 		schedule_work(&drv_data->state_worker);
@@ -1184,7 +1200,7 @@ static int sony_leds_init(struct hid_device *hdev)
 		/* Validate expected report characteristics. */
 		if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
 			return -ENODEV;
-	} else if (drv_data->quirks & DUALSHOCK4_CONTROLLER_USB) {
+	} else if (drv_data->quirks & DUALSHOCK4_CONTROLLER) {
 		drv_data->led_count = 3;
 		max_brightness = 255;
 		use_colors = 1;
@@ -1509,7 +1525,14 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
-	else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
+	else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
+		if (sc->quirks & DUALSHOCK4_CONTROLLER_BT) {
+			ret = dualshock4_set_operational_bt(hdev);
+			if (ret < 0) {
+				hid_err(hdev, "failed to set the Dualshock 4 operational mode\n");
+				goto err_stop;
+			}
+		}
 		/* The Dualshock 4 touchpad supports 2 touches and has a
 		 * resolution of 1920x940.
 		 */
-- 
1.8.5.3

