From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 2/3] hid: thingm: switch to managed version of
 led_classdev_register
Date: Mon, 29 Feb 2016 21:38:26 +0100
Message-ID: <56D4AC42.8070402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-leds-owner@vger.kernel.org>
Sender: linux-leds-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-leds@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Simplify the code by switching to the managed version of
led_classdev_register.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/hid-thingm.c | 46 ++++++++--------------------------------------
 1 file changed, 8 insertions(+), 38 deletions(-)

diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index 69a6ada..5e35ec1 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -159,7 +159,8 @@ static int thingm_init_rgb(struct thingm_rgb *rgb)
 	rgb->red.ldev.brightness_set_blocking = thingm_led_set;
 	rgb->red.rgb = rgb;
 
-	err = led_classdev_register(&rgb->tdev->hdev->dev, &rgb->red.ldev);
+	err = devm_led_classdev_register(&rgb->tdev->hdev->dev,
+					 &rgb->red.ldev);
 	if (err)
 		return err;
 
@@ -171,9 +172,10 @@ static int thingm_init_rgb(struct thingm_rgb *rgb)
 	rgb->green.ldev.brightness_set_blocking = thingm_led_set;
 	rgb->green.rgb = rgb;
 
-	err = led_classdev_register(&rgb->tdev->hdev->dev, &rgb->green.ldev);
+	err = devm_led_classdev_register(&rgb->tdev->hdev->dev,
+					 &rgb->green.ldev);
 	if (err)
-		goto unregister_red;
+		return err;
 
 	/* Register the blue diode */
 	snprintf(rgb->blue.name, sizeof(rgb->blue.name),
@@ -183,28 +185,11 @@ static int thingm_init_rgb(struct thingm_rgb *rgb)
 	rgb->blue.ldev.brightness_set_blocking = thingm_led_set;
 	rgb->blue.rgb = rgb;
 
-	err = led_classdev_register(&rgb->tdev->hdev->dev, &rgb->blue.ldev);
-	if (err)
-		goto unregister_green;
-
-	return 0;
-
-unregister_green:
-	led_classdev_unregister(&rgb->green.ldev);
-
-unregister_red:
-	led_classdev_unregister(&rgb->red.ldev);
-
+	err = devm_led_classdev_register(&rgb->tdev->hdev->dev,
+					 &rgb->blue.ldev);
 	return err;
 }
 
-static void thingm_remove_rgb(struct thingm_rgb *rgb)
-{
-	led_classdev_unregister(&rgb->red.ldev);
-	led_classdev_unregister(&rgb->green.ldev);
-	led_classdev_unregister(&rgb->blue.ldev);
-}
-
 static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct thingm_device *tdev;
@@ -259,11 +244,8 @@ static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		rgb->tdev = tdev;
 		rgb->num = tdev->fwinfo->first + i;
 		err = thingm_init_rgb(rgb);
-		if (err) {
-			while (--i >= 0)
-				thingm_remove_rgb(tdev->rgb + i);
+		if (err)
 			goto stop;
-		}
 	}
 
 	return 0;
@@ -273,17 +255,6 @@ error:
 	return err;
 }
 
-static void thingm_remove(struct hid_device *hdev)
-{
-	struct thingm_device *tdev = hid_get_drvdata(hdev);
-	int i;
-
-	hid_hw_stop(hdev);
-
-	for (i = 0; i < tdev->fwinfo->numrgb; ++i)
-		thingm_remove_rgb(tdev->rgb + i);
-}
-
 static const struct hid_device_id thingm_table[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THINGM, USB_DEVICE_ID_BLINK1) },
 	{ }
@@ -293,7 +264,6 @@ MODULE_DEVICE_TABLE(hid, thingm_table);
 static struct hid_driver thingm_driver = {
 	.name = "thingm",
 	.probe = thingm_probe,
-	.remove = thingm_remove,
 	.id_table = thingm_table,
 };
 
-- 
2.7.1
