From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/2] hid: thingm: factor out duplicated code to
 thingm_init_led
Date: Sun, 17 Apr 2016 22:46:59 +0200
Message-ID: <5713F643.80408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36517 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750733AbcDQUwB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Apr 2016 16:52:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id l6so19700983wml.3
        for <linux-input@vger.kernel.org>; Sun, 17 Apr 2016 13:52:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org

Simplify thingm_init_rgb by factoring out duplicated code
to thingm_init_led.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/hid-thingm.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index 847a497..a90463e 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -157,48 +157,35 @@ static int thingm_led_set(struct led_classdev *ldev,
 	return ret;
 }
 
+static int thingm_init_led(struct thingm_led *led, const char *color_name,
+			   struct thingm_rgb *rgb, int minor)
+{
+	snprintf(led->name, sizeof(led->name), "thingm%d:%s:led%d",
+		 minor, color_name, rgb->num);
+	led->ldev.name = led->name;
+	led->ldev.max_brightness = 255;
+	led->ldev.brightness_set_blocking = thingm_led_set;
+	led->rgb = rgb;
+	return devm_led_classdev_register(&rgb->tdev->hdev->dev, &led->ldev);
+}
+
 static int thingm_init_rgb(struct thingm_rgb *rgb)
 {
 	const int minor = ((struct hidraw *) rgb->tdev->hdev->hidraw)->minor;
 	int err;
 
 	/* Register the red diode */
-	snprintf(rgb->red.name, sizeof(rgb->red.name),
-			"thingm%d:red:led%d", minor, rgb->num);
-	rgb->red.ldev.name = rgb->red.name;
-	rgb->red.ldev.max_brightness = 255;
-	rgb->red.ldev.brightness_set_blocking = thingm_led_set;
-	rgb->red.rgb = rgb;
-
-	err = devm_led_classdev_register(&rgb->tdev->hdev->dev,
-					 &rgb->red.ldev);
+	err = thingm_init_led(&rgb->red, "red", rgb, minor);
 	if (err)
 		return err;
 
 	/* Register the green diode */
-	snprintf(rgb->green.name, sizeof(rgb->green.name),
-			"thingm%d:green:led%d", minor, rgb->num);
-	rgb->green.ldev.name = rgb->green.name;
-	rgb->green.ldev.max_brightness = 255;
-	rgb->green.ldev.brightness_set_blocking = thingm_led_set;
-	rgb->green.rgb = rgb;
-
-	err = devm_led_classdev_register(&rgb->tdev->hdev->dev,
-					 &rgb->green.ldev);
+	err = thingm_init_led(&rgb->green, "green", rgb, minor);
 	if (err)
 		return err;
 
 	/* Register the blue diode */
-	snprintf(rgb->blue.name, sizeof(rgb->blue.name),
-			"thingm%d:blue:led%d", minor, rgb->num);
-	rgb->blue.ldev.name = rgb->blue.name;
-	rgb->blue.ldev.max_brightness = 255;
-	rgb->blue.ldev.brightness_set_blocking = thingm_led_set;
-	rgb->blue.rgb = rgb;
-
-	err = devm_led_classdev_register(&rgb->tdev->hdev->dev,
-					 &rgb->blue.ldev);
-	return err;
+	return thingm_init_led(&rgb->blue, "blue", rgb, minor);
 }
 
 static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
-- 
2.8.0


