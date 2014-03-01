From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 4/6] HID: sony: Add blink support to the LEDs
Date: Fri, 28 Feb 2014 22:58:59 -0500
Message-ID: <1393646341-16947-5-git-send-email-frank.praznik@oh.rr.com>
References: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:39036 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752924AbaCAD71 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Feb 2014 22:59:27 -0500
In-Reply-To: <1393646341-16947-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Add support for setting the blink rate of the LEDs.  The Sixaxis allows control
over each individual LED, but the Dualshock 4 only has one global control for
the light bar so changing any individual color changes them all.

Setting the brightness cancels the blinking as per the LED class
specifications.

The Sixaxis and Dualshock 4 controllers accept delays in decisecond increments
from 0 to 255 (2550 milliseconds).

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 105 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 93 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index dc6e6fa..914a6cc 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -741,6 +741,8 @@ struct sony_sc {
 	__u8 battery_charging;
 	__u8 battery_capacity;
 	__u8 led_state[MAX_LEDS];
+	__u8 led_blink_on[MAX_LEDS];
+	__u8 led_blink_off[MAX_LEDS];
 	__u8 led_count;
 };
 
@@ -1127,8 +1129,7 @@ static void sony_led_set_brightness(struct led_classdev *led,
 	struct device *dev = led->dev->parent;
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
 	struct sony_sc *drv_data;
-
-	int n;
+	int n, blink_index = 0;
 
 	drv_data = hid_get_drvdata(hdev);
 	if (!drv_data) {
@@ -1136,14 +1137,30 @@ static void sony_led_set_brightness(struct led_classdev *led,
 		return;
 	}
 
+	/* Get the index of the LED */
 	for (n = 0; n < drv_data->led_count; n++) {
-		if (led == drv_data->leds[n]) {
-			if (value != drv_data->led_state[n]) {
-				drv_data->led_state[n] = value;
-				sony_set_leds(drv_data, drv_data->led_state, drv_data->led_count);
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
+	/* The DualShock 4 has a global LED and always uses index 0 */
+	if (!(drv_data->quirks & DUALSHOCK4_CONTROLLER))
+		blink_index = n;
+
+	if ((value != drv_data->led_state[n])   ||
+		drv_data->led_blink_on[blink_index] ||
+		drv_data->led_blink_off[blink_index]) {
+		drv_data->led_state[n] = value;
+
+		/* Setting the brightness stops the blinking */
+		drv_data->led_blink_on[blink_index] = 0;
+		drv_data->led_blink_off[blink_index] = 0;
+
+		sony_set_leds(drv_data, drv_data->led_state, drv_data->led_count);
 	}
 }
 
@@ -1169,6 +1186,56 @@ static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 	return LED_OFF;
 }
 
+static int sony_blink_set(struct led_classdev *led, unsigned long *delay_on,
+				unsigned long *delay_off)
+{
+	struct device *dev = led->dev->parent;
+	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
+	struct sony_sc *drv_data = hid_get_drvdata(hdev);
+	int n = 0;
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
+	/* The blink controls are global on the DualShock 4 */
+	if (!(drv_data->quirks & DUALSHOCK4_CONTROLLER)) {
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
+	if (new_on != drv_data->led_blink_on[n] ||
+		new_off != drv_data->led_blink_off[n]) {
+		drv_data->led_blink_on[n] = new_on;
+		drv_data->led_blink_off[n] = new_off;
+		schedule_work(&drv_data->state_worker);
+	}
+
+	return 0;
+}
+
 static void sony_leds_remove(struct sony_sc *sc)
 {
 	struct led_classdev *led;
@@ -1259,6 +1326,9 @@ static int sony_leds_init(struct sony_sc *sc)
 		led->brightness_get = sony_led_get_brightness;
 		led->brightness_set = sony_led_set_brightness;
 
+		if (!(sc->quirks & BUZZ_CONTROLLER))
+			led->blink_set = sony_blink_set;
+
 		ret = led_classdev_register(&hdev->dev, led);
 		if (ret) {
 			hid_err(hdev, "Failed to register LED %d\n", n);
@@ -1280,14 +1350,15 @@ error_leds:
 static void sixaxis_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
+	int n;
 	unsigned char buf[] = {
 		0x01,
 		0x00, 0xff, 0x00, 0xff, 0x00,
 		0x00, 0x00, 0x00, 0x00, 0x00,
-		0xff, 0x27, 0x10, 0x00, 0x32,
-		0xff, 0x27, 0x10, 0x00, 0x32,
-		0xff, 0x27, 0x10, 0x00, 0x32,
-		0xff, 0x27, 0x10, 0x00, 0x32,
+		0xff, 0x27, 0x10, 0x00, 0x32, /* LED 4 */
+		0xff, 0x27, 0x10, 0x00, 0x32, /* LED 3 */
+		0xff, 0x27, 0x10, 0x00, 0x32, /* LED 2 */
+		0xff, 0x27, 0x10, 0x00, 0x32, /* LED 1 */
 		0x00, 0x00, 0x00, 0x00, 0x00
 	};
 
@@ -1301,6 +1372,13 @@ static void sixaxis_state_worker(struct work_struct *work)
 	buf[10] |= sc->led_state[2] << 3;
 	buf[10] |= sc->led_state[3] << 4;
 
+	for (n = 0; n < 4; n++) {
+		if (sc->led_blink_on[n] || sc->led_blink_off[n]) {
+			buf[29-(n*5)] = sc->led_blink_off[n];
+			buf[30-(n*5)] = sc->led_blink_on[n];
+		}
+	}
+
 	if (sc->quirks & SIXAXIS_CONTROLLER_USB)
 		hid_output_raw_report(sc->hdev, buf, sizeof(buf), HID_OUTPUT_REPORT);
 	else
@@ -1338,6 +1416,9 @@ static void dualshock4_state_worker(struct work_struct *work)
 	buf[offset++] = sc->led_state[1];
 	buf[offset++] = sc->led_state[2];
 
+	buf[offset++] = sc->led_blink_on[0];
+	buf[offset++] = sc->led_blink_off[0];
+
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
 		hid_hw_output_report(hdev, buf, 32);
 	else
-- 
1.8.5.3

