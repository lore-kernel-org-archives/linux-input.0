From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv3 5/5] HID: sony: Add LED support for Sixaxis/Dualshock3 USB
Date: Mon, 18 Nov 2013 21:42:36 +0100
Message-ID: <1384807356-15561-6-git-send-email-sven@narfation.org>
References: <1384807356-15561-1-git-send-email-sven@narfation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42180 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab3KRUna (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Nov 2013 15:43:30 -0500
In-Reply-To: <1384807356-15561-1-git-send-email-sven@narfation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>, Sven Eckelmann <sven@narfation.org>

The PS3 Sixaxis controller has 4 LEDs which can be controlled using the same
command as the rumble functionality. It seems not to be possible to only change
the LED without modifying the rumble motor state. Thus both have to be stored
on the host and retransmitted when either the LED or rumble state is changed.

Third party controllers may not support to disable all LEDs at once. These
controllers automatically switch to blinking of all LEDs when no LED is active
anymore.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Tested-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-sony.c | 118 +++++++++++++++++++++++++++++--------------------
 1 file changed, 71 insertions(+), 47 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 2f93aab..b60bc38 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -39,6 +39,8 @@
 #define BUZZ_CONTROLLER         BIT(3)
 #define PS3REMOTE		BIT(4)
 
+#define SONY_LED_SUPPORT (SIXAXIS_CONTROLLER_USB | BUZZ_CONTROLLER)
+
 static const u8 sixaxis_rdesc_fixup[] = {
 	0x95, 0x13, 0x09, 0x01, 0x81, 0x02, 0x95, 0x0C,
 	0x81, 0x01, 0x75, 0x10, 0x95, 0x04, 0x26, 0xFF,
@@ -223,12 +225,12 @@ static const unsigned int buzz_keymap[] = {
 };
 
 struct sony_sc {
+	struct hid_device *hdev;
 	struct led_classdev *leds[4];
 	unsigned long quirks;
+	struct work_struct state_worker;
 
 #ifdef CONFIG_SONY_FF
-	struct work_struct state_worker;
-	struct hid_device *hdev;
 	__u8 left;
 	__u8 right;
 #endif
@@ -462,6 +464,18 @@ static void buzz_set_leds(struct hid_device *hdev, int leds)
 	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
 }
 
+static void sony_set_leds(struct hid_device *hdev, __u8 leds)
+{
+	struct sony_sc *drv_data = hid_get_drvdata(hdev);
+
+	if (drv_data->quirks & BUZZ_CONTROLLER) {
+		buzz_set_leds(hdev, leds);
+	} else if (drv_data->quirks & SIXAXIS_CONTROLLER_USB) {
+		drv_data->led_state = leds;
+		schedule_work(&drv_data->state_worker);
+	}
+}
+
 static void sony_led_set_brightness(struct led_classdev *led,
 				    enum led_brightness value)
 {
@@ -482,10 +496,10 @@ static void sony_led_set_brightness(struct led_classdev *led,
 			int on = !!(drv_data->led_state & (1 << n));
 			if (value == LED_OFF && on) {
 				drv_data->led_state &= ~(1 << n);
-				buzz_set_leds(hdev, drv_data->led_state);
+				sony_set_leds(hdev, drv_data->led_state);
 			} else if (value != LED_OFF && !on) {
 				drv_data->led_state |= (1 << n);
-				buzz_set_leds(hdev, drv_data->led_state);
+				sony_set_leds(hdev, drv_data->led_state);
 			}
 			break;
 		}
@@ -517,6 +531,25 @@ static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 	return on ? LED_FULL : LED_OFF;
 }
 
+static void sony_leds_remove(struct hid_device *hdev)
+{
+	struct sony_sc *drv_data;
+	struct led_classdev *led;
+	int n;
+
+	drv_data = hid_get_drvdata(hdev);
+	BUG_ON(!(drv_data->quirks & SONY_LED_SUPPORT));
+
+	for (n = 0; n < 4; n++) {
+		led = drv_data->leds[n];
+		drv_data->leds[n] = NULL;
+		if (!led)
+			continue;
+		led_classdev_unregister(led);
+		kfree(led);
+	}
+}
+
 static int sony_leds_init(struct hid_device *hdev)
 {
 	struct sony_sc *drv_data;
@@ -524,20 +557,29 @@ static int sony_leds_init(struct hid_device *hdev)
 	struct led_classdev *led;
 	size_t name_sz;
 	char *name;
+	size_t name_len;
+	const char *name_fmt;
 
 	drv_data = hid_get_drvdata(hdev);
-	BUG_ON(!(drv_data->quirks & BUZZ_CONTROLLER));
+	BUG_ON(!(drv_data->quirks & SONY_LED_SUPPORT));
 
-	/* Validate expected report characteristics. */
-	if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
-		return -ENODEV;
+	if (drv_data->quirks & BUZZ_CONTROLLER) {
+		name_len = strlen("::buzz#");
+		name_fmt = "%s::buzz%d";
+		/* Validate expected report characteristics. */
+		if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
+			return -ENODEV;
+	} else {
+		name_len = strlen("::sony#");
+		name_fmt = "%s::sony%d";
+	}
 
 	/* Clear LEDs as we have no way of reading their initial state. This is
 	 * only relevant if the driver is loaded after somebody actively set the
 	 * LEDs to on */
-	buzz_set_leds(hdev, 0x00);
+	sony_set_leds(hdev, 0x00);
 
-	name_sz = strlen(dev_name(&hdev->dev)) + strlen("::buzz#") + 1;
+	name_sz = strlen(dev_name(&hdev->dev)) + name_len + 1;
 
 	for (n = 0; n < 4; n++) {
 		led = kzalloc(sizeof(struct led_classdev) + name_sz, GFP_KERNEL);
@@ -547,7 +589,7 @@ static int sony_leds_init(struct hid_device *hdev)
 		}
 
 		name = (void *)(&led[1]);
-		snprintf(name, name_sz, "%s::buzz%d", dev_name(&hdev->dev), n + 1);
+		snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), n + 1);
 		led->name = name;
 		led->brightness = 0;
 		led->max_brightness = 1;
@@ -566,45 +608,18 @@ static int sony_leds_init(struct hid_device *hdev)
 	return ret;
 
 error_leds:
-	for (n = 0; n < 4; n++) {
-		led = drv_data->leds[n];
-		drv_data->leds[n] = NULL;
-		if (!led)
-			continue;
-		led_classdev_unregister(led);
-		kfree(led);
-	}
+	sony_leds_remove(hdev);
 
 	return ret;
 }
 
-static void sony_leds_remove(struct hid_device *hdev)
-{
-	struct sony_sc *drv_data;
-	struct led_classdev *led;
-	int n;
-
-	drv_data = hid_get_drvdata(hdev);
-	BUG_ON(!(drv_data->quirks & BUZZ_CONTROLLER));
-
-	for (n = 0; n < 4; n++) {
-		led = drv_data->leds[n];
-		drv_data->leds[n] = NULL;
-		if (!led)
-			continue;
-		led_classdev_unregister(led);
-		kfree(led);
-	}
-}
-
-#ifdef CONFIG_SONY_FF
 static void sony_state_worker(struct work_struct *work)
 {
 	struct sony_sc *sc = container_of(work, struct sony_sc, state_worker);
 	unsigned char buf[] = {
 		0x01,
 		0x00, 0xff, 0x00, 0xff, 0x00,
-		0x00, 0x00, 0x00, 0x00, 0x03,
+		0x00, 0x00, 0x00, 0x00, 0x00,
 		0xff, 0x27, 0x10, 0x00, 0x32,
 		0xff, 0x27, 0x10, 0x00, 0x32,
 		0xff, 0x27, 0x10, 0x00, 0x32,
@@ -612,13 +627,18 @@ static void sony_state_worker(struct work_struct *work)
 		0x00, 0x00, 0x00, 0x00, 0x00
 	};
 
+#ifdef CONFIG_SONY_FF
 	buf[3] = sc->right;
 	buf[5] = sc->left;
+#endif
+
+	buf[10] |= (sc->led_state & 0xf) << 1;
 
 	sc->hdev->hid_output_raw_report(sc->hdev, buf, sizeof(buf),
 					HID_OUTPUT_REPORT);
 }
 
+#ifdef CONFIG_SONY_FF
 static int sony_play_effect(struct input_dev *dev, void *data,
 			    struct ff_effect *effect)
 {
@@ -640,10 +660,6 @@ static int sony_init_ff(struct hid_device *hdev)
 	struct hid_input *hidinput = list_entry(hdev->inputs.next,
 						struct hid_input, list);
 	struct input_dev *input_dev = hidinput->input;
-	struct sony_sc *sc = hid_get_drvdata(hdev);
-
-	sc->hdev = hdev;
-	INIT_WORK(&sc->state_worker, sony_state_worker);
 
 	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
 	return input_ff_create_memless(input_dev, NULL, sony_play_effect);
@@ -682,6 +698,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	sc->quirks = quirks;
 	hid_set_drvdata(hdev, sc);
+	sc->hdev = hdev;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -705,23 +722,30 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (sc->quirks & SIXAXIS_CONTROLLER_USB) {
 		hdev->hid_output_raw_report = sixaxis_usb_output_raw_report;
 		ret = sixaxis_set_operational_usb(hdev);
+		INIT_WORK(&sc->state_worker, sony_state_worker);
 	}
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
-	else if (sc->quirks & BUZZ_CONTROLLER)
-		ret = sony_leds_init(hdev);
 	else
 		ret = 0;
 
 	if (ret < 0)
 		goto err_stop;
 
+	if (sc->quirks & SONY_LED_SUPPORT) {
+		ret = sony_leds_init(hdev);
+		if (ret < 0)
+			goto err_stop;
+	}
+
 	ret = sony_init_ff(hdev);
 	if (ret < 0)
 		goto err_stop;
 
 	return 0;
 err_stop:
+	if (sc->quirks & SONY_LED_SUPPORT)
+		sony_leds_remove(hdev);
 	hid_hw_stop(hdev);
 	return ret;
 }
@@ -730,7 +754,7 @@ static void sony_remove(struct hid_device *hdev)
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	if (sc->quirks & BUZZ_CONTROLLER)
+	if (sc->quirks & SONY_LED_SUPPORT)
 		sony_leds_remove(hdev);
 
 	sony_destroy_ff(hdev);
-- 
1.8.4.3

