From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv4 4/5] HID: sony: Move LED data to the main structure
Date: Tue, 19 Nov 2013 20:26:31 +0100
Message-ID: <1384889192-18488-5-git-send-email-sven@narfation.org>
References: <1384889192-18488-1-git-send-email-sven@narfation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42241 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376Ab3KST0t (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Nov 2013 14:26:49 -0500
In-Reply-To: <1384889192-18488-1-git-send-email-sven@narfation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Sven Eckelmann <sven@narfation.org>

It is not necessary to keep the LED information in an extra struct which is
only used by the Buzz device. It can also be used by other devices.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/hid/hid-sony.c | 58 +++++++++++++++-----------------------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index cdb2419..2f93aab 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -223,6 +223,7 @@ static const unsigned int buzz_keymap[] = {
 };
 
 struct sony_sc {
+	struct led_classdev *leds[4];
 	unsigned long quirks;
 
 #ifdef CONFIG_SONY_FF
@@ -232,12 +233,7 @@ struct sony_sc {
 	__u8 right;
 #endif
 
-	void *extra;
-};
-
-struct buzz_extra {
-	int led_state;
-	struct led_classdev *leds[4];
+	__u8 led_state;
 };
 
 static __u8 *ps3remote_fixup(struct hid_device *hdev, __u8 *rdesc,
@@ -472,26 +468,24 @@ static void sony_led_set_brightness(struct led_classdev *led,
 	struct device *dev = led->dev->parent;
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
 	struct sony_sc *drv_data;
-	struct buzz_extra *buzz;
 
 	int n;
 
 	drv_data = hid_get_drvdata(hdev);
-	if (!drv_data || !drv_data->extra) {
+	if (!drv_data) {
 		hid_err(hdev, "No device data\n");
 		return;
 	}
-	buzz = drv_data->extra;
 
 	for (n = 0; n < 4; n++) {
-		if (led == buzz->leds[n]) {
-			int on = !! (buzz->led_state & (1 << n));
+		if (led == drv_data->leds[n]) {
+			int on = !!(drv_data->led_state & (1 << n));
 			if (value == LED_OFF && on) {
-				buzz->led_state &= ~(1 << n);
-				buzz_set_leds(hdev, buzz->led_state);
+				drv_data->led_state &= ~(1 << n);
+				buzz_set_leds(hdev, drv_data->led_state);
 			} else if (value != LED_OFF && !on) {
-				buzz->led_state |= (1 << n);
-				buzz_set_leds(hdev, buzz->led_state);
+				drv_data->led_state |= (1 << n);
+				buzz_set_leds(hdev, drv_data->led_state);
 			}
 			break;
 		}
@@ -503,21 +497,19 @@ static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 	struct device *dev = led->dev->parent;
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
 	struct sony_sc *drv_data;
-	struct buzz_extra *buzz;
 
 	int n;
 	int on = 0;
 
 	drv_data = hid_get_drvdata(hdev);
-	if (!drv_data || !drv_data->extra) {
+	if (!drv_data) {
 		hid_err(hdev, "No device data\n");
 		return LED_OFF;
 	}
-	buzz = drv_data->extra;
 
 	for (n = 0; n < 4; n++) {
-		if (led == buzz->leds[n]) {
-			on = !! (buzz->led_state & (1 << n));
+		if (led == drv_data->leds[n]) {
+			on = !!(drv_data->led_state & (1 << n));
 			break;
 		}
 	}
@@ -528,7 +520,6 @@ static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 static int sony_leds_init(struct hid_device *hdev)
 {
 	struct sony_sc *drv_data;
-	struct buzz_extra *buzz;
 	int n, ret = 0;
 	struct led_classdev *led;
 	size_t name_sz;
@@ -541,13 +532,6 @@ static int sony_leds_init(struct hid_device *hdev)
 	if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
 		return -ENODEV;
 
-	buzz = kzalloc(sizeof(*buzz), GFP_KERNEL);
-	if (!buzz) {
-		hid_err(hdev, "Insufficient memory, cannot allocate driver data\n");
-		return -ENOMEM;
-	}
-	drv_data->extra = buzz;
-
 	/* Clear LEDs as we have no way of reading their initial state. This is
 	 * only relevant if the driver is loaded after somebody actively set the
 	 * LEDs to on */
@@ -576,49 +560,41 @@ static int sony_leds_init(struct hid_device *hdev)
 			goto error_leds;
 		}
 
-		buzz->leds[n] = led;
+		drv_data->leds[n] = led;
 	}
 
 	return ret;
 
 error_leds:
 	for (n = 0; n < 4; n++) {
-		led = buzz->leds[n];
-		buzz->leds[n] = NULL;
+		led = drv_data->leds[n];
+		drv_data->leds[n] = NULL;
 		if (!led)
 			continue;
 		led_classdev_unregister(led);
 		kfree(led);
 	}
 
-	kfree(drv_data->extra);
-	drv_data->extra = NULL;
 	return ret;
 }
 
 static void sony_leds_remove(struct hid_device *hdev)
 {
 	struct sony_sc *drv_data;
-	struct buzz_extra *buzz;
 	struct led_classdev *led;
 	int n;
 
 	drv_data = hid_get_drvdata(hdev);
 	BUG_ON(!(drv_data->quirks & BUZZ_CONTROLLER));
 
-	buzz = drv_data->extra;
-
 	for (n = 0; n < 4; n++) {
-		led = buzz->leds[n];
-		buzz->leds[n] = NULL;
+		led = drv_data->leds[n];
+		drv_data->leds[n] = NULL;
 		if (!led)
 			continue;
 		led_classdev_unregister(led);
 		kfree(led);
 	}
-
-	kfree(drv_data->extra);
-	drv_data->extra = NULL;
 }
 
 #ifdef CONFIG_SONY_FF
-- 
1.8.4.3

