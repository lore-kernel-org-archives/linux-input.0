From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v3 8/8] HID: sony: Add blink support to the Sixaxis and DualShock 4 LEDs
Date: Sat, 15 Mar 2014 09:41:22 -0400
Message-ID: <1394890882-2039-9-git-send-email-frank.praznik@oh.rr.com>
References: <1394890882-2039-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:38466 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756577AbaCONlh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Mar 2014 09:41:37 -0400
In-Reply-To: <1394890882-2039-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Add support for setting the blink rate of the LEDs.  The Sixaxis allows control
over each individual LED, but the Dualshock 4 only has one global control for
the light bar so changing any individual color changes the global blink rate.

Setting the brightness cancels the blinking as per the LED class specifications.

The Sixaxis and Dualshock 4 controllers accept delays in decisecond increments
from 0 to 255 (2550 milliseconds).

The value at index 1 of the DualShock 4 USB output report must be 0xFF or the
light bar won't blink.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 113 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 104 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d323039..74da922 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -773,6 +773,8 @@ struct sony_sc {
 	__u8 battery_charging;
 	__u8 battery_capacity;
 	__u8 led_state[MAX_LEDS];
+	__u8 led_delay_on[MAX_LEDS];
+	__u8 led_delay_off[MAX_LEDS];
 	__u8 led_count;
 };
 
@@ -1167,7 +1169,7 @@ static void sony_led_set_brightness(struct led_classdev *led,
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
 	struct sony_sc *drv_data;
 
-	int n;
+	int n, blink_index;
 
 	drv_data = hid_get_drvdata(hdev);
 	if (!drv_data) {
@@ -1176,14 +1178,31 @@ static void sony_led_set_brightness(struct led_classdev *led,
 	}
 
 	for (n = 0; n < drv_data->led_count; n++) {
-		if (led == drv_data->leds[n]) {
-			if (value != drv_data->led_state[n]) {
-				drv_data->led_state[n] = value;
-				sony_set_leds(drv_data, drv_data->led_state,
-						drv_data->led_count);
-			}
+		if (led == drv_data->leds[n])
 			break;
-		}
+	}
+
+	/* This LED is not registered on this device */
+	if (n >= drv_data->led_count)
+		return;
+
+	/* The DualShock 4 has a global blink setting and always uses index 0 */
+	if (drv_data->quirks & DUALSHOCK4_CONTROLLER)
+		blink_index = 0;
+	else
+		blink_index = n;
+
+	if ((value != drv_data->led_state[n]) ||
+		drv_data->led_delay_on[blink_index] ||
+		drv_data->led_delay_off[blink_index]) {
+		drv_data->led_state[n] = value;
+
+		/* Setting the brightness stops the blinking */
+		drv_data->led_delay_on[blink_index] = 0;
+		drv_data->led_delay_off[blink_index] = 0;
+
+		sony_set_leds(drv_data, drv_data->led_state,
+				drv_data->led_count);
 	}
 }
 
@@ -1209,6 +1228,58 @@ static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 	return LED_OFF;
 }
 
+static int sony_led_blink_set(struct led_classdev *led, unsigned long *delay_on,
+				unsigned long *delay_off)
+{
+	struct device *dev = led->dev->parent;
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct sony_sc *drv_data = hid_get_drvdata(hdev);
+	int n;
+	__u8 new_on, new_off;
+
+	if (!drv_data) {
+		hid_err(hdev, "No device data\n");
+		return -EINVAL;
+	}
+
+	/* Max delay is 255 deciseconds or 2550 milliseconds */
+	if (*delay_on > 2550)
+		*delay_on = 2550;
+	if (*delay_off > 2550)
+		*delay_off = 2550;
+
+	/* Blink at 1 Hz if both values are zero */
+	if (!*delay_on && !*delay_off)
+		*delay_on = *delay_off = 1000;
+
+	new_on = *delay_on / 10;
+	new_off = *delay_off / 10;
+
+	/* The DualShock 4 has a global blink setting and always uses index 0 */
+	if (drv_data->quirks & DUALSHOCK4_CONTROLLER) {
+		n = 0;
+	} else {
+		for (n = 0; n < drv_data->led_count; n++) {
+			if (led == drv_data->leds[n])
+				break;
+		}
+	}
+
+	/* This LED is not registered on this device */
+	if (n >= drv_data->led_count)
+		return -EINVAL;
+
+	/* Don't schedule work if the values didn't change */
+	if (new_on != drv_data->led_delay_on[n] ||
+		new_off != drv_data->led_delay_off[n]) {
+		drv_data->led_delay_on[n] = new_on;
+		drv_data->led_delay_off[n] = new_off;
+		schedule_work(&drv_data->state_worker);
+	}
+
+	return 0;
+}
+
 static void sony_leds_remove(struct sony_sc *sc)
 {
 	struct led_classdev *led;
@@ -1301,6 +1372,9 @@ static int sony_leds_init(struct sony_sc *sc)
 		led->brightness_get = sony_led_get_brightness;
 		led->brightness_set = sony_led_set_brightness;
 
+		if (!(sc->quirks & BUZZ_CONTROLLER))
+			led->blink_set = sony_led_blink_set;
+
 		sc->leds[n] = led;
 
 		ret = led_classdev_register(&hdev->dev, led);
@@ -1325,6 +1399,7 @@ error_leds:
 static void sixaxis_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
+	int n;
 	union sixaxis_output_report_01 report = {
 		.buf = {
 			0x01,
@@ -1348,6 +1423,22 @@ static void sixaxis_state_worker(struct work_struct *work)
 	report.data.leds_bitmap |= sc->led_state[2] << 3;
 	report.data.leds_bitmap |= sc->led_state[3] << 4;
 
+	/*
+	 * The LEDs in the report are indexed in reverse order to their
+	 * corresponding light on the controller.
+	 * Index 0 = LED 4, index 1 = LED 3, etc...
+	 *
+	 * In the case of both delay values being zero (blinking disabled) the
+	 * default report values should be used or the controller LED will be
+	 * always off.
+	 */
+	for (n = 0; n < 4; n++) {
+		if (sc->led_delay_on[n] || sc->led_delay_off[n]) {
+			report.data.led[3 - n].duty_off = sc->led_delay_off[n];
+			report.data.led[3 - n].duty_on = sc->led_delay_on[n];
+		}
+	}
+
 	hid_hw_raw_request(sc->hdev, report.data.report_id, report.buf,
 			sizeof(report), HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
@@ -1362,7 +1453,7 @@ static void dualshock4_state_worker(struct work_struct *work)
 
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
 		buf[0] = 0x05;
-		buf[1] = 0x03;
+		buf[1] = 0xFF;
 		offset = 4;
 	} else {
 		buf[0] = 0x11;
@@ -1382,6 +1473,10 @@ static void dualshock4_state_worker(struct work_struct *work)
 	buf[offset++] = sc->led_state[1];
 	buf[offset++] = sc->led_state[2];
 
+	/* If both delay values are zero the DualShock 4 disables blinking. */
+	buf[offset++] = sc->led_delay_on[0];
+	buf[offset++] = sc->led_delay_off[0];
+
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
 		hid_hw_output_report(hdev, buf, 32);
 	else
-- 
1.8.5.3

