From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH v2 5/8] HID: sony: Convert startup and shutdown functions to use a uniform parameter type
Date: Thu,  6 Mar 2014 17:32:53 -0500
Message-ID: <1394145176-24174-6-git-send-email-frank.praznik@oh.rr.com>
References: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.231]:9254 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750829AbaCFWkY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 6 Mar 2014 17:40:24 -0500
In-Reply-To: <1394145176-24174-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, dh.herrmann@gmail.com, Frank Praznik <frank.praznik@oh.rr.com>

Convert all of the local initialization and shutdown functions to take a
parameter type of struct sony_sc* instead of using a mix of struct sony_sc* and
struct hid_device*.

Allows for the removal of some calls to hid_get_drvdata().

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>
---
 drivers/hid/hid-sony.c | 67 ++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 35 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 5e9bb57..a9bcfbe 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1096,19 +1096,18 @@ static void buzz_set_leds(struct hid_device *hdev, const __u8 *leds)
 	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
 }
 
-static void sony_set_leds(struct hid_device *hdev, const __u8 *leds, int count)
+static void sony_set_leds(struct sony_sc *sc, const __u8 *leds, int count)
 {
-	struct sony_sc *drv_data = hid_get_drvdata(hdev);
 	int n;
 
 	BUG_ON(count > MAX_LEDS);
 
-	if (drv_data->quirks & BUZZ_CONTROLLER && count == 4) {
-		buzz_set_leds(hdev, leds);
+	if (sc->quirks & BUZZ_CONTROLLER && count == 4) {
+		buzz_set_leds(sc->hdev, leds);
 	} else {
 		for (n = 0; n < count; n++)
-			drv_data->led_state[n] = leds[n];
-		schedule_work(&drv_data->state_worker);
+			sc->led_state[n] = leds[n];
+		schedule_work(&sc->state_worker);
 	}
 }
 
@@ -1131,7 +1130,8 @@ static void sony_led_set_brightness(struct led_classdev *led,
 		if (led == drv_data->leds[n]) {
 			if (value != drv_data->led_state[n]) {
 				drv_data->led_state[n] = value;
-				sony_set_leds(hdev, drv_data->led_state, drv_data->led_count);
+				sony_set_leds(drv_data, drv_data->led_state,
+						drv_data->led_count);
 			}
 			break;
 		}
@@ -1160,30 +1160,28 @@ static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 	return LED_OFF;
 }
 
-static void sony_leds_remove(struct hid_device *hdev)
+static void sony_leds_remove(struct sony_sc *sc)
 {
-	struct sony_sc *drv_data;
 	struct led_classdev *led;
 	int n;
 
-	drv_data = hid_get_drvdata(hdev);
-	BUG_ON(!(drv_data->quirks & SONY_LED_SUPPORT));
+	BUG_ON(!(sc->quirks & SONY_LED_SUPPORT));
 
-	for (n = 0; n < drv_data->led_count; n++) {
-		led = drv_data->leds[n];
-		drv_data->leds[n] = NULL;
+	for (n = 0; n < sc->led_count; n++) {
+		led = sc->leds[n];
+		sc->leds[n] = NULL;
 		if (!led)
 			continue;
 		led_classdev_unregister(led);
 		kfree(led);
 	}
 
-	drv_data->led_count = 0;
+	sc->led_count = 0;
 }
 
-static int sony_leds_init(struct hid_device *hdev)
+static int sony_leds_init(struct sony_sc *sc)
 {
-	struct sony_sc *drv_data;
+	struct hid_device *hdev = sc->hdev;
 	int n, ret = 0;
 	int max_brightness;
 	int use_colors;
@@ -1195,11 +1193,10 @@ static int sony_leds_init(struct hid_device *hdev)
 	static const char * const color_str[] = { "red", "green", "blue" };
 	static const __u8 initial_values[MAX_LEDS] = { 0x00, 0x00, 0x00, 0x00 };
 
-	drv_data = hid_get_drvdata(hdev);
-	BUG_ON(!(drv_data->quirks & SONY_LED_SUPPORT));
+	BUG_ON(!(sc->quirks & SONY_LED_SUPPORT));
 
-	if (drv_data->quirks & BUZZ_CONTROLLER) {
-		drv_data->led_count = 4;
+	if (sc->quirks & BUZZ_CONTROLLER) {
+		sc->led_count = 4;
 		max_brightness = 1;
 		use_colors = 0;
 		name_len = strlen("::buzz#");
@@ -1207,14 +1204,14 @@ static int sony_leds_init(struct hid_device *hdev)
 		/* Validate expected report characteristics. */
 		if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
 			return -ENODEV;
-	} else if (drv_data->quirks & DUALSHOCK4_CONTROLLER) {
-		drv_data->led_count = 3;
+	} else if (sc->quirks & DUALSHOCK4_CONTROLLER) {
+		sc->led_count = 3;
 		max_brightness = 255;
 		use_colors = 1;
 		name_len = 0;
 		name_fmt = "%s:%s";
 	} else {
-		drv_data->led_count = 4;
+		sc->led_count = 4;
 		max_brightness = 1;
 		use_colors = 0;
 		name_len = strlen("::sony#");
@@ -1226,11 +1223,11 @@ static int sony_leds_init(struct hid_device *hdev)
 	 * only relevant if the driver is loaded after somebody actively set the
 	 * LEDs to on
 	 */
-	sony_set_leds(hdev, initial_values, drv_data->led_count);
+	sony_set_leds(sc, initial_values, sc->led_count);
 
 	name_sz = strlen(dev_name(&hdev->dev)) + name_len + 1;
 
-	for (n = 0; n < drv_data->led_count; n++) {
+	for (n = 0; n < sc->led_count; n++) {
 
 		if (use_colors)
 			name_sz = strlen(dev_name(&hdev->dev)) + strlen(color_str[n]) + 2;
@@ -1260,13 +1257,13 @@ static int sony_leds_init(struct hid_device *hdev)
 			goto error_leds;
 		}
 
-		drv_data->leds[n] = led;
+		sc->leds[n] = led;
 	}
 
 	return ret;
 
 error_leds:
-	sony_leds_remove(hdev);
+	sony_leds_remove(sc);
 
 	return ret;
 }
@@ -1355,9 +1352,9 @@ static int sony_play_effect(struct input_dev *dev, void *data,
 	return 0;
 }
 
-static int sony_init_ff(struct hid_device *hdev)
+static int sony_init_ff(struct sony_sc *sc)
 {
-	struct hid_input *hidinput = list_entry(hdev->inputs.next,
+	struct hid_input *hidinput = list_entry(sc->hdev->inputs.next,
 						struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
 
@@ -1366,7 +1363,7 @@ static int sony_init_ff(struct hid_device *hdev)
 }
 
 #else
-static int sony_init_ff(struct hid_device *hdev)
+static int sony_init_ff(struct sony_sc *sc)
 {
 	return 0;
 }
@@ -1718,7 +1715,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_stop;
 
 	if (sc->quirks & SONY_LED_SUPPORT) {
-		ret = sony_leds_init(hdev);
+		ret = sony_leds_init(sc);
 		if (ret < 0)
 			goto err_stop;
 	}
@@ -1737,7 +1734,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	}
 
 	if (sc->quirks & SONY_FF_SUPPORT) {
-		ret = sony_init_ff(hdev);
+		ret = sony_init_ff(sc);
 		if (ret < 0)
 			goto err_close;
 	}
@@ -1747,7 +1744,7 @@ err_close:
 	hid_hw_close(hdev);
 err_stop:
 	if (sc->quirks & SONY_LED_SUPPORT)
-		sony_leds_remove(hdev);
+		sony_leds_remove(sc);
 	if (sc->quirks & SONY_BATTERY_SUPPORT)
 		sony_battery_remove(sc);
 	sony_cancel_work_sync(sc);
@@ -1761,7 +1758,7 @@ static void sony_remove(struct hid_device *hdev)
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
 	if (sc->quirks & SONY_LED_SUPPORT)
-		sony_leds_remove(hdev);
+		sony_leds_remove(sc);
 
 	if (sc->quirks & SONY_BATTERY_SUPPORT) {
 		hid_hw_close(hdev);
-- 
1.8.5.3

