From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v5 6/7] HID: sony: Add blink support to the Sixaxis and DualShock 4 LEDs
Date: Mon, 14 Apr 2014 10:11:36 -0400
Message-ID: <1397484697-2389-7-git-send-email-frank.praznik@oh.rr.com>
References: <1397484697-2389-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.225]:44173 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750875AbaDNOLv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2014 10:11:51 -0400
In-Reply-To: <1397484697-2389-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, simon@mungewell.org, Frank Praznik <frank.praznik@oh.rr.com>

Add support for setting the blink rate of the LEDs.  The Sixaxis allows control
over each individual LED, but the Dualshock 4 only has one global control for
controlling the hardware blink rate so individual colors will fall back to
software timers.

Setting the brightness cancels the blinking as per the LED class specifications.

The Sixaxis and Dualshock 4 controllers accept delays in decisecond increments
from 0 to 255 (2550 milliseconds).

The value at index 1 of the DualShock 4 USB output report must be 0xFF or the
light bar won't blink.

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---

 v5 addresses some usability issues that arose during testing.
 
 The Sixaxis, when on USB, has an annoying quirk where it will override any LED
 settings and flash the whole light bar until the PS button is pushed.  Since
 the driver can't tell if the controller is overriding the user LED settings,
 all led brightness requests are sent to the controller even if they are
 redundant.  This allows for the user to stop the blinking by setting the
 brightness even if the current brightness is already in the desired state.
 
 The DualShock 4 now has an extra 'global' LED control that allows the
 whole light bar to be turned on and off synchronously instead of having all
 of the individual LEDs map to one global set of delay values.
 
 This fixes inconsistencies that arose in the old system where each individual
 LED mapped to one hardware blink delay. This caused conflicts if different
 LEDs had different triggers assigned to each one and the triggers overrode
 each other's settings.  It also made it impossible to flash the light bar
 synchronously with triggers like 'heartbeat' that control blinking by running
 a software timer and directly manipulating the brightness value, nor could a
 user set the blink rate of the individual colors if they wanted to.
 
 This change also allows for the removal of some DS4 specific special-case code
 in the blink and brightness functions that was present in the previous
 patches.

 drivers/hid/hid-sony.c | 149 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 124 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index f1649d0..54a04ba 100644
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
 
@@ -1168,6 +1170,7 @@ static void sony_led_set_brightness(struct led_classdev *led,
 	struct sony_sc *drv_data;
 
 	int n;
+	int force_update;
 
 	drv_data = hid_get_drvdata(hdev);
 	if (!drv_data) {
@@ -1175,13 +1178,29 @@ static void sony_led_set_brightness(struct led_classdev *led,
 		return;
 	}
 
+	/*
+	 * The Sixaxis on USB will override any LED settings sent to it
+	 * and keep flashing all of the LEDs until the PS button is pressed.
+	 * Updates, even if redundant, must be always be sent to the
+	 * controller to avoid having to toggle the state of an LED just to
+	 * stop the flashing later on.
+	 */
+	force_update = !!(drv_data->quirks & SIXAXIS_CONTROLLER_USB);
+
 	for (n = 0; n < drv_data->led_count; n++) {
-		if (led == drv_data->leds[n]) {
-			if (value != drv_data->led_state[n]) {
-				drv_data->led_state[n] = value;
-				sony_set_leds(drv_data, drv_data->led_state,
-						drv_data->led_count);
-			}
+		if (led == drv_data->leds[n] && (force_update ||
+			(value != drv_data->led_state[n] ||
+			drv_data->led_delay_on[n] ||
+			drv_data->led_delay_off[n]))) {
+
+			drv_data->led_state[n] = value;
+
+			/* Setting the brightness stops the blinking */
+			drv_data->led_delay_on[n] = 0;
+			drv_data->led_delay_off[n] = 0;
+
+			sony_set_leds(drv_data, drv_data->led_state,
+					drv_data->led_count);
 			break;
 		}
 	}
@@ -1209,6 +1228,53 @@ static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
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
+		*delay_on = *delay_off = 500;
+
+	new_on = *delay_on / 10;
+	new_off = *delay_off / 10;
+
+	for (n = 0; n < drv_data->led_count; n++) {
+		if (led == drv_data->leds[n])
+			break;
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
@@ -1232,22 +1298,23 @@ static int sony_leds_init(struct sony_sc *sc)
 {
 	struct hid_device *hdev = sc->hdev;
 	int n, ret = 0;
-	int max_brightness;
-	int use_colors;
+	int use_ds4_names;
 	struct led_classdev *led;
 	size_t name_sz;
 	char *name;
 	size_t name_len;
 	const char *name_fmt;
-	static const char * const color_str[] = { "red", "green", "blue" };
+	static const char * const ds4_name_str[] = { "red", "green", "blue",
+						  "global" };
 	__u8 initial_values[MAX_LEDS] = { 0 };
+	__u8 max_brightness[MAX_LEDS] = { 1 };
+	__u8 use_hw_blink[MAX_LEDS] = { 0 };
 
 	BUG_ON(!(sc->quirks & SONY_LED_SUPPORT));
 
 	if (sc->quirks & BUZZ_CONTROLLER) {
 		sc->led_count = 4;
-		max_brightness = 1;
-		use_colors = 0;
+		use_ds4_names = 0;
 		name_len = strlen("::buzz#");
 		name_fmt = "%s::buzz%d";
 		/* Validate expected report characteristics. */
@@ -1255,16 +1322,18 @@ static int sony_leds_init(struct sony_sc *sc)
 			return -ENODEV;
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
 		dualshock4_set_leds_from_id(sc->device_id, initial_values);
-		sc->led_count = 3;
-		max_brightness = 255;
-		use_colors = 1;
+		initial_values[3] = 1;
+		sc->led_count = 4;
+		memset(max_brightness, 255, 3);
+		use_hw_blink[3] = 1;
+		use_ds4_names = 1;
 		name_len = 0;
 		name_fmt = "%s:%s";
 	} else {
 		sixaxis_set_leds_from_id(sc->device_id, initial_values);
 		sc->led_count = 4;
-		max_brightness = 1;
-		use_colors = 0;
+		memset(use_hw_blink, 1, 4);
+		use_ds4_names = 0;
 		name_len = strlen("::sony#");
 		name_fmt = "%s::sony%d";
 	}
@@ -1280,8 +1349,8 @@ static int sony_leds_init(struct sony_sc *sc)
 
 	for (n = 0; n < sc->led_count; n++) {
 
-		if (use_colors)
-			name_sz = strlen(dev_name(&hdev->dev)) + strlen(color_str[n]) + 2;
+		if (use_ds4_names)
+			name_sz = strlen(dev_name(&hdev->dev)) + strlen(ds4_name_str[n]) + 2;
 
 		led = kzalloc(sizeof(struct led_classdev) + name_sz, GFP_KERNEL);
 		if (!led) {
@@ -1291,16 +1360,20 @@ static int sony_leds_init(struct sony_sc *sc)
 		}
 
 		name = (void *)(&led[1]);
-		if (use_colors)
-			snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), color_str[n]);
+		if (use_ds4_names)
+			snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev),
+			ds4_name_str[n]);
 		else
 			snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), n + 1);
 		led->name = name;
 		led->brightness = initial_values[n];
-		led->max_brightness = max_brightness;
+		led->max_brightness = max_brightness[n];
 		led->brightness_get = sony_led_get_brightness;
 		led->brightness_set = sony_led_set_brightness;
 
+		if (use_hw_blink[n])
+			led->blink_set = sony_led_blink_set;
+
 		sc->leds[n] = led;
 
 		ret = led_classdev_register(&hdev->dev, led);
@@ -1323,6 +1396,7 @@ error_leds:
 static void sixaxis_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
+	int n;
 	union sixaxis_output_report_01 report = {
 		.buf = {
 			0x01,
@@ -1346,6 +1420,22 @@ static void sixaxis_state_worker(struct work_struct *work)
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
@@ -1360,7 +1450,7 @@ static void dualshock4_state_worker(struct work_struct *work)
 
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
 		buf[0] = 0x05;
-		buf[1] = 0x03;
+		buf[1] = 0xFF;
 		offset = 4;
 	} else {
 		buf[0] = 0x11;
@@ -1376,9 +1466,18 @@ static void dualshock4_state_worker(struct work_struct *work)
 	offset += 2;
 #endif
 
-	buf[offset++] = sc->led_state[0];
-	buf[offset++] = sc->led_state[1];
-	buf[offset++] = sc->led_state[2];
+	/* LED 3 is the global control */
+	if (sc->led_state[3]) {
+		buf[offset++] = sc->led_state[0];
+		buf[offset++] = sc->led_state[1];
+		buf[offset++] = sc->led_state[2];
+	} else {
+		offset += 3;
+	}
+
+	/* If both delay values are zero the DualShock 4 disables blinking. */
+	buf[offset++] = sc->led_delay_on[3];
+	buf[offset++] = sc->led_delay_off[3];
 
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
 		hid_hw_output_report(hdev, buf, 32);
-- 
1.8.5.3

