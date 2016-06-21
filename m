From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 1/4] HID: hid-led: add support for devices with multiple
 independent LEDs
Date: Tue, 21 Jun 2016 21:48:26 +0200
Message-ID: <f3e5f8e0-1095-5fcd-71de-42aa7e57933b@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34451 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003AbcFUTvD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 15:51:03 -0400
Received: by mail-lf0-f67.google.com with SMTP id l184so6472672lfl.1
        for <linux-input@vger.kernel.org>; Tue, 21 Jun 2016 12:51:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Add generic support for devices with multiple independent LED's.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/hid-led.c | 85 +++++++++++++++++++++++++++++++++------------------
 1 file changed, 55 insertions(+), 30 deletions(-)

diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index 43fb089..d5d8d94 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -43,12 +43,14 @@ static unsigned const char riso_kagaku_tbl[] = {
 #define RISO_KAGAKU_IX(r, g, b) riso_kagaku_tbl[((r)?1:0)+((g)?2:0)+((b)?4:0)]
 
 struct hidled_device;
+struct hidled_rgb;
 
 struct hidled_config {
 	enum hidled_type	type;
 	const char		*name;
 	const char		*short_name;
 	enum led_brightness	max_brightness;
+	int			num_leds;
 	size_t			report_size;
 	enum hidled_report_type	report_type;
 	u8			report_id;
@@ -58,16 +60,22 @@ struct hidled_config {
 
 struct hidled_led {
 	struct led_classdev	cdev;
-	struct hidled_device	*ldev;
+	struct hidled_rgb	*rgb;
 	char			name[32];
 };
 
-struct hidled_device {
-	const struct hidled_config *config;
+struct hidled_rgb {
+	struct hidled_device	*ldev;
 	struct hidled_led	red;
 	struct hidled_led	green;
 	struct hidled_led	blue;
+	u8			num;
+};
+
+struct hidled_device {
+	const struct hidled_config *config;
 	struct hid_device       *hdev;
+	struct hidled_rgb	*rgb;
 	struct mutex		lock;
 };
 
@@ -107,13 +115,13 @@ static int hidled_send(struct hidled_device *ldev, __u8 *buf)
 	return ret == ldev->config->report_size ? 0 : -EMSGSIZE;
 }
 
-static u8 riso_kagaku_index(struct hidled_device *ldev)
+static u8 riso_kagaku_index(struct hidled_rgb *rgb)
 {
 	enum led_brightness r, g, b;
 
-	r = ldev->red.cdev.brightness;
-	g = ldev->green.cdev.brightness;
-	b = ldev->blue.cdev.brightness;
+	r = rgb->red.cdev.brightness;
+	g = rgb->green.cdev.brightness;
+	b = rgb->blue.cdev.brightness;
 
 	if (riso_kagaku_switch_green_blue)
 		return RISO_KAGAKU_IX(r, b, g);
@@ -124,27 +132,27 @@ static u8 riso_kagaku_index(struct hidled_device *ldev)
 static int riso_kagaku_write(struct led_classdev *cdev, enum led_brightness br)
 {
 	struct hidled_led *led = to_hidled_led(cdev);
-	struct hidled_device *ldev = led->ldev;
+	struct hidled_rgb *rgb = led->rgb;
 	__u8 buf[MAX_REPORT_SIZE] = {};
 
-	buf[1] = riso_kagaku_index(ldev);
+	buf[1] = riso_kagaku_index(rgb);
 
-	return hidled_send(ldev, buf);
+	return hidled_send(rgb->ldev, buf);
 }
 
 static int dream_cheeky_write(struct led_classdev *cdev, enum led_brightness br)
 {
 	struct hidled_led *led = to_hidled_led(cdev);
-	struct hidled_device *ldev = led->ldev;
+	struct hidled_rgb *rgb = led->rgb;
 	__u8 buf[MAX_REPORT_SIZE] = {};
 
-	buf[1] = ldev->red.cdev.brightness;
-	buf[2] = ldev->green.cdev.brightness;
-	buf[3] = ldev->blue.cdev.brightness;
+	buf[1] = rgb->red.cdev.brightness;
+	buf[2] = rgb->green.cdev.brightness;
+	buf[3] = rgb->blue.cdev.brightness;
 	buf[7] = 0x1a;
 	buf[8] = 0x05;
 
-	return hidled_send(ldev, buf);
+	return hidled_send(rgb->ldev, buf);
 }
 
 static int dream_cheeky_init(struct hidled_device *ldev)
@@ -167,6 +175,7 @@ static const struct hidled_config hidled_configs[] = {
 		.name = "Riso Kagaku Webmail Notifier",
 		.short_name = "riso_kagaku",
 		.max_brightness = 1,
+		.num_leds = 1,
 		.report_size = 6,
 		.report_type = OUTPUT_REPORT,
 		.report_id = 0,
@@ -177,6 +186,7 @@ static const struct hidled_config hidled_configs[] = {
 		.name = "Dream Cheeky Webmail Notifier",
 		.short_name = "dream_cheeky",
 		.max_brightness = 31,
+		.num_leds = 1,
 		.report_size = 9,
 		.report_type = RAW_REQUEST,
 		.report_id = 0,
@@ -186,35 +196,41 @@ static const struct hidled_config hidled_configs[] = {
 };
 
 static int hidled_init_led(struct hidled_led *led, const char *color_name,
-			   struct hidled_device *ldev, unsigned int minor)
+			   struct hidled_rgb *rgb, unsigned int minor)
 {
-	snprintf(led->name, sizeof(led->name), "%s%u:%s",
-		 ldev->config->short_name, minor, color_name);
+	const struct hidled_config *config = rgb->ldev->config;
+
+	if (config->num_leds > 1)
+		snprintf(led->name, sizeof(led->name), "%s%u:%s:led%u",
+			 config->short_name, minor, color_name, rgb->num);
+	else
+		snprintf(led->name, sizeof(led->name), "%s%u:%s",
+			 config->short_name, minor, color_name);
 	led->cdev.name = led->name;
-	led->cdev.max_brightness = ldev->config->max_brightness;
-	led->cdev.brightness_set_blocking = ldev->config->write;
+	led->cdev.max_brightness = config->max_brightness;
+	led->cdev.brightness_set_blocking = config->write;
 	led->cdev.flags = LED_HW_PLUGGABLE;
-	led->ldev = ldev;
+	led->rgb = rgb;
 
-	return devm_led_classdev_register(&ldev->hdev->dev, &led->cdev);
+	return devm_led_classdev_register(&rgb->ldev->hdev->dev, &led->cdev);
 }
 
-static int hidled_init_rgb(struct hidled_device *ldev, unsigned int minor)
+static int hidled_init_rgb(struct hidled_rgb *rgb, unsigned int minor)
 {
 	int ret;
 
 	/* Register the red diode */
-	ret = hidled_init_led(&ldev->red, "red", ldev, minor);
+	ret = hidled_init_led(&rgb->red, "red", rgb, minor);
 	if (ret)
 		return ret;
 
 	/* Register the green diode */
-	ret = hidled_init_led(&ldev->green, "green", ldev, minor);
+	ret = hidled_init_led(&rgb->green, "green", rgb, minor);
 	if (ret)
 		return ret;
 
 	/* Register the blue diode */
-	return hidled_init_led(&ldev->blue, "blue", ldev, minor);
+	return hidled_init_led(&rgb->blue, "blue", rgb, minor);
 }
 
 static int hidled_probe(struct hid_device *hdev, const struct hid_device_id *id)
@@ -247,16 +263,25 @@ static int hidled_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			return ret;
 	}
 
+	ldev->rgb = devm_kcalloc(&hdev->dev, ldev->config->num_leds,
+				 sizeof(struct hidled_rgb), GFP_KERNEL);
+	if (!ldev->rgb)
+		return -ENOMEM;
+
 	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
 	if (ret)
 		return ret;
 
 	minor = ((struct hidraw *) hdev->hidraw)->minor;
 
-	ret = hidled_init_rgb(ldev, minor);
-	if (ret) {
-		hid_hw_stop(hdev);
-		return ret;
+	for (i = 0; i < ldev->config->num_leds; i++) {
+		ldev->rgb[i].ldev = ldev;
+		ldev->rgb[i].num = i;
+		ret = hidled_init_rgb(&ldev->rgb[i], minor);
+		if (ret) {
+			hid_hw_stop(hdev);
+			return ret;
+		}
 	}
 
 	hid_info(hdev, "%s initialized\n", ldev->config->name);
-- 
2.9.0

