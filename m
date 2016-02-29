From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/3] hid: thingm: remove workqueue
Date: Mon, 29 Feb 2016 21:34:50 +0100
Message-ID: <56D4AB6A.3070100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35582 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbcB2Uiu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Feb 2016 15:38:50 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-leds@vger.kernel.org, linux-input@vger.kernel.org

Defining workqueues in LED drivers isn't needed any longer as the LED core
was extended with a generic workqueue recently.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/hid-thingm.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index b95d397..69a6ada 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -14,7 +14,6 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/workqueue.h>
 
 #include "hid-ids.h"
 
@@ -56,7 +55,6 @@ struct thingm_rgb {
 	struct thingm_led red;
 	struct thingm_led green;
 	struct thingm_led blue;
-	struct work_struct work;
 	u8 num;
 };
 
@@ -131,25 +129,21 @@ static int thingm_write_color(struct thingm_rgb *rgb)
 	return thingm_send(rgb->tdev, buf);
 }
 
-static void thingm_work(struct work_struct *work)
+static int thingm_led_set(struct led_classdev *ldev,
+			  enum led_brightness brightness)
 {
-	struct thingm_rgb *rgb = container_of(work, struct thingm_rgb, work);
+	struct thingm_led *led = container_of(ldev, struct thingm_led, ldev);
+	int ret;
 
-	mutex_lock(&rgb->tdev->lock);
+	mutex_lock(&led->rgb->tdev->lock);
 
-	if (thingm_write_color(rgb))
-		hid_err(rgb->tdev->hdev, "failed to write color\n");
+	ret = thingm_write_color(led->rgb);
+	if (ret)
+		hid_err(led->rgb->tdev->hdev, "failed to write color\n");
 
-	mutex_unlock(&rgb->tdev->lock);
-}
+	mutex_unlock(&led->rgb->tdev->lock);
 
-static void thingm_led_set(struct led_classdev *ldev,
-		enum led_brightness brightness)
-{
-	struct thingm_led *led = container_of(ldev, struct thingm_led, ldev);
-
-	/* the ledclass has already stored the brightness value */
-	schedule_work(&led->rgb->work);
+	return ret;
 }
 
 static int thingm_init_rgb(struct thingm_rgb *rgb)
@@ -162,7 +156,7 @@ static int thingm_init_rgb(struct thingm_rgb *rgb)
 			"thingm%d:red:led%d", minor, rgb->num);
 	rgb->red.ldev.name = rgb->red.name;
 	rgb->red.ldev.max_brightness = 255;
-	rgb->red.ldev.brightness_set = thingm_led_set;
+	rgb->red.ldev.brightness_set_blocking = thingm_led_set;
 	rgb->red.rgb = rgb;
 
 	err = led_classdev_register(&rgb->tdev->hdev->dev, &rgb->red.ldev);
@@ -174,7 +168,7 @@ static int thingm_init_rgb(struct thingm_rgb *rgb)
 			"thingm%d:green:led%d", minor, rgb->num);
 	rgb->green.ldev.name = rgb->green.name;
 	rgb->green.ldev.max_brightness = 255;
-	rgb->green.ldev.brightness_set = thingm_led_set;
+	rgb->green.ldev.brightness_set_blocking = thingm_led_set;
 	rgb->green.rgb = rgb;
 
 	err = led_classdev_register(&rgb->tdev->hdev->dev, &rgb->green.ldev);
@@ -186,15 +180,13 @@ static int thingm_init_rgb(struct thingm_rgb *rgb)
 			"thingm%d:blue:led%d", minor, rgb->num);
 	rgb->blue.ldev.name = rgb->blue.name;
 	rgb->blue.ldev.max_brightness = 255;
-	rgb->blue.ldev.brightness_set = thingm_led_set;
+	rgb->blue.ldev.brightness_set_blocking = thingm_led_set;
 	rgb->blue.rgb = rgb;
 
 	err = led_classdev_register(&rgb->tdev->hdev->dev, &rgb->blue.ldev);
 	if (err)
 		goto unregister_green;
 
-	INIT_WORK(&rgb->work, thingm_work);
-
 	return 0;
 
 unregister_green:
@@ -211,7 +203,6 @@ static void thingm_remove_rgb(struct thingm_rgb *rgb)
 	led_classdev_unregister(&rgb->red.ldev);
 	led_classdev_unregister(&rgb->green.ldev);
 	led_classdev_unregister(&rgb->blue.ldev);
-	flush_work(&rgb->work);
 }
 
 static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
-- 
2.7.1


