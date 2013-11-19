From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv4 3/5] HID: sony: Rename buzz_* functions to sony_led_*
Date: Tue, 19 Nov 2013 20:26:30 +0100
Message-ID: <1384889192-18488-4-git-send-email-sven@narfation.org>
References: <1384889192-18488-1-git-send-email-sven@narfation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42239 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752376Ab3KST0q (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Nov 2013 14:26:46 -0500
In-Reply-To: <1384889192-18488-1-git-send-email-sven@narfation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Sven Eckelmann <sven@narfation.org>

More controllers managed by the hid-sony module have 4 LEDs. These can share
most of the functionality provided by the buzz functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 drivers/hid/hid-sony.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 0677292..cdb2419 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -466,7 +466,7 @@ static void buzz_set_leds(struct hid_device *hdev, int leds)
 	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
 }
 
-static void buzz_led_set_brightness(struct led_classdev *led,
+static void sony_led_set_brightness(struct led_classdev *led,
 				    enum led_brightness value)
 {
 	struct device *dev = led->dev->parent;
@@ -498,7 +498,7 @@ static void buzz_led_set_brightness(struct led_classdev *led,
 	}
 }
 
-static enum led_brightness buzz_led_get_brightness(struct led_classdev *led)
+static enum led_brightness sony_led_get_brightness(struct led_classdev *led)
 {
 	struct device *dev = led->dev->parent;
 	struct hid_device *hdev = container_of(dev, struct hid_device, dev);
@@ -525,7 +525,7 @@ static enum led_brightness buzz_led_get_brightness(struct led_classdev *led)
 	return on ? LED_FULL : LED_OFF;
 }
 
-static int buzz_init(struct hid_device *hdev)
+static int sony_leds_init(struct hid_device *hdev)
 {
 	struct sony_sc *drv_data;
 	struct buzz_extra *buzz;
@@ -567,8 +567,8 @@ static int buzz_init(struct hid_device *hdev)
 		led->name = name;
 		led->brightness = 0;
 		led->max_brightness = 1;
-		led->brightness_get = buzz_led_get_brightness;
-		led->brightness_set = buzz_led_set_brightness;
+		led->brightness_get = sony_led_get_brightness;
+		led->brightness_set = sony_led_set_brightness;
 
 		if (led_classdev_register(&hdev->dev, led)) {
 			hid_err(hdev, "Failed to register LED %d\n", n);
@@ -596,7 +596,7 @@ error_leds:
 	return ret;
 }
 
-static void buzz_remove(struct hid_device *hdev)
+static void sony_leds_remove(struct hid_device *hdev)
 {
 	struct sony_sc *drv_data;
 	struct buzz_extra *buzz;
@@ -733,7 +733,7 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	else if (sc->quirks & SIXAXIS_CONTROLLER_BT)
 		ret = sixaxis_set_operational_bt(hdev);
 	else if (sc->quirks & BUZZ_CONTROLLER)
-		ret = buzz_init(hdev);
+		ret = sony_leds_init(hdev);
 	else
 		ret = 0;
 
@@ -755,7 +755,7 @@ static void sony_remove(struct hid_device *hdev)
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
 	if (sc->quirks & BUZZ_CONTROLLER)
-		buzz_remove(hdev);
+		sony_leds_remove(hdev);
 
 	sony_destroy_ff(hdev);
 
-- 
1.8.4.3

