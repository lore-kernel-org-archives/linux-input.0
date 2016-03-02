From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] hid: thingm: change driver to use RGB LED core extension
Date: Wed, 2 Mar 2016 21:15:14 +0100
Message-ID: <56D749D2.80101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Based on the proposed RGB LED core extension the thingm driver was
changed to make use of this extension. It allows to simplify
the code a lot. For now primary purpose of this patch is to facilitate
testing of the RGB LED core extension.

I didn't find a way to split the patch into smaller parts as either
you use the RGB LED extension or not. However this shouldn't be really
an issue as the resulting code is relatively short and simple.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/hid/hid-thingm.c | 131 +++++++++++++----------------------------------
 1 file changed, 36 insertions(+), 95 deletions(-)

diff --git a/drivers/hid/hid-thingm.c b/drivers/hid/hid-thingm.c
index 847a497..07b9f1b 100644
--- a/drivers/hid/hid-thingm.c
+++ b/drivers/hid/hid-thingm.c
@@ -19,6 +19,7 @@
 
 #define REPORT_ID	1
 #define REPORT_SIZE	9
+#define NUMRGB_MAX	2
 
 /* Firmware major number of supported devices */
 #define THINGM_MAJOR_MK1	'1'
@@ -42,33 +43,26 @@ static const struct thingm_fwinfo thingm_fwinfo[] = {
 	}
 };
 
-/* A red, green or blue channel, part of an RGB chip */
 struct thingm_led {
-	struct thingm_rgb *rgb;
-	struct led_classdev ldev;
-	char name[32];
-};
-
-/* Basically a WS2812 5050 RGB LED chip */
-struct thingm_rgb {
-	struct thingm_device *tdev;
-	struct thingm_led red;
-	struct thingm_led green;
-	struct thingm_led blue;
-	u8 num;
+	struct led_classdev		cdev;
+	char				name[32];
+	unsigned			led_num;
+	struct thingm_device		*tdev;
 };
 
 struct thingm_device {
-	struct hid_device *hdev;
+	struct hid_device		*hdev;
 	struct {
 		char major;
 		char minor;
-	} version;
-	const struct thingm_fwinfo *fwinfo;
-	struct mutex lock;
-	struct thingm_rgb *rgb;
+	}				version;
+	const struct thingm_fwinfo	*fwinfo;
+	struct mutex			lock;
+	struct thingm_led		tled[NUMRGB_MAX];
 };
 
+#define to_thingm_led(arg) container_of((arg), struct thingm_led, cdev)
+
 static int thingm_send(struct thingm_device *tdev, u8 buf[REPORT_SIZE])
 {
 	int ret;
@@ -133,86 +127,33 @@ static int thingm_version(struct thingm_device *tdev)
 	return 0;
 }
 
-static int thingm_write_color(struct thingm_rgb *rgb)
+static int thingm_brightness_set_blocking(struct led_classdev *cdev,
+					  enum led_brightness value)
 {
-	u8 buf[REPORT_SIZE] = { REPORT_ID, 'c', 0, 0, 0, 0, 0, rgb->num, 0 };
-
-	buf[2] = rgb->red.ldev.brightness;
-	buf[3] = rgb->green.ldev.brightness;
-	buf[4] = rgb->blue.ldev.brightness;
-
-	return thingm_send(rgb->tdev, buf);
-}
+	struct thingm_led *tled = to_thingm_led(cdev);
+	u8 buf[REPORT_SIZE] = { REPORT_ID, 'c' };
 
-static int thingm_led_set(struct led_classdev *ldev,
-			  enum led_brightness brightness)
-{
-	struct thingm_led *led = container_of(ldev, struct thingm_led, ldev);
-	int ret;
+	value = led_hsv_to_rgb(value);
 
-	ret = thingm_write_color(led->rgb);
-	if (ret)
-		hid_err(led->rgb->tdev->hdev, "failed to write color\n");
+	buf[2] = (value >> 16) & 0xff;
+	buf[3] = (value >> 8) & 0xff;
+	buf[4] = value & 0xff;
+	buf[7] = tled->led_num;
 
-	return ret;
-}
-
-static int thingm_init_rgb(struct thingm_rgb *rgb)
-{
-	const int minor = ((struct hidraw *) rgb->tdev->hdev->hidraw)->minor;
-	int err;
-
-	/* Register the red diode */
-	snprintf(rgb->red.name, sizeof(rgb->red.name),
-			"thingm%d:red:led%d", minor, rgb->num);
-	rgb->red.ldev.name = rgb->red.name;
-	rgb->red.ldev.max_brightness = 255;
-	rgb->red.ldev.brightness_set_blocking = thingm_led_set;
-	rgb->red.rgb = rgb;
-
-	err = devm_led_classdev_register(&rgb->tdev->hdev->dev,
-					 &rgb->red.ldev);
-	if (err)
-		return err;
-
-	/* Register the green diode */
-	snprintf(rgb->green.name, sizeof(rgb->green.name),
-			"thingm%d:green:led%d", minor, rgb->num);
-	rgb->green.ldev.name = rgb->green.name;
-	rgb->green.ldev.max_brightness = 255;
-	rgb->green.ldev.brightness_set_blocking = thingm_led_set;
-	rgb->green.rgb = rgb;
-
-	err = devm_led_classdev_register(&rgb->tdev->hdev->dev,
-					 &rgb->green.ldev);
-	if (err)
-		return err;
-
-	/* Register the blue diode */
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
+	return thingm_send(tled->tdev, buf);
 }
 
 static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct thingm_device *tdev;
-	int i, err;
+	struct led_classdev *cdev;
+	int i, err, minor;
 
-	tdev = devm_kzalloc(&hdev->dev, sizeof(struct thingm_device),
-			GFP_KERNEL);
+	tdev = devm_kzalloc(&hdev->dev, sizeof(*tdev), GFP_KERNEL);
 	if (!tdev)
 		return -ENOMEM;
 
 	tdev->hdev = hdev;
-	hid_set_drvdata(hdev, tdev);
 
 	err = hid_parse(hdev);
 	if (err)
@@ -236,22 +177,22 @@ static int thingm_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return -ENODEV;
 	}
 
-	tdev->rgb = devm_kzalloc(&hdev->dev,
-			sizeof(struct thingm_rgb) * tdev->fwinfo->numrgb,
-			GFP_KERNEL);
-	if (!tdev->rgb)
-		return -ENOMEM;
-
 	err = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
 	if (err)
 		return err;
 
-	for (i = 0; i < tdev->fwinfo->numrgb; ++i) {
-		struct thingm_rgb *rgb = tdev->rgb + i;
+	minor = ((struct hidraw *)hdev->hidraw)->minor;
 
-		rgb->tdev = tdev;
-		rgb->num = tdev->fwinfo->first + i;
-		err = thingm_init_rgb(rgb);
+	for (i = 0; i < tdev->fwinfo->numrgb; ++i) {
+		tdev->tled[i].tdev = tdev;
+		tdev->tled[i].led_num = tdev->fwinfo->first + i;
+		snprintf(tdev->tled[i].name, sizeof(tdev->tled[i].name),
+			 "thingm%d:rgb:led%d", minor, i);
+		cdev = &tdev->tled[i].cdev;
+		cdev->name = tdev->tled[i].name;
+		cdev->flags = LED_DEV_CAP_RGB | LED_HW_PLUGGABLE;
+		cdev->brightness_set_blocking = thingm_brightness_set_blocking;
+		err = devm_led_classdev_register(&hdev->dev, cdev);
 		if (err) {
 			hid_hw_stop(hdev);
 			return err;
-- 
2.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
