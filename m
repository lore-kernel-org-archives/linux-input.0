From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH 2/2] Use colors for the Dualshock 4 LED names
Date: Mon, 20 Jan 2014 12:27:02 -0500
Message-ID: <1390238822-18164-2-git-send-email-frank.praznik@oh.rr.com>
References: <1390238822-18164-1-git-send-email-frank.praznik@oh.rr.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:55076 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbaATR13 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jan 2014 12:27:29 -0500
In-Reply-To: <1390238822-18164-1-git-send-email-frank.praznik@oh.rr.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, Frank Praznik <frank.praznik@oh.rr.com>

Use the naming scheme 'devicename:colour' for the Dualshock 4
LED lightbar controls as specified in Documentation/leds/leds-class.txt

Signed-off-by: Frank Praznik <frank.praznik@oh.rr.com>

---
 
 Apply against jikos/hid.git/for-3.14/sony

 drivers/hid/hid-sony.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 62765c7..1235405 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -834,33 +834,39 @@ static int sony_leds_init(struct hid_device *hdev)
 	struct sony_sc *drv_data;
 	int n, ret = 0;
 	int max_brightness;
+	int use_colors;
 	struct led_classdev *led;
 	size_t name_sz;
 	char *name;
 	size_t name_len;
 	const char *name_fmt;
+	static const char * const color_str[] = { "red", "green", "blue" };
 	static const __u8 initial_values[MAX_LEDS] = { 0x00, 0x00, 0x00, 0x00 };
 
 	drv_data = hid_get_drvdata(hdev);
 	BUG_ON(!(drv_data->quirks & SONY_LED_SUPPORT));
 
 	if (drv_data->quirks & BUZZ_CONTROLLER) {
+		drv_data->led_count = 4;
+		max_brightness = 1;
+		use_colors = 0;
 		name_len = strlen("::buzz#");
 		name_fmt = "%s::buzz%d";
 		/* Validate expected report characteristics. */
 		if (!hid_validate_values(hdev, HID_OUTPUT_REPORT, 0, 0, 7))
 			return -ENODEV;
-	} else {
-		name_len = strlen("::sony#");
-		name_fmt = "%s::sony%d";
-	}
-
-	if (drv_data->quirks & DUALSHOCK4_CONTROLLER_USB) {
+	} else if (drv_data->quirks & DUALSHOCK4_CONTROLLER_USB) {
 		drv_data->led_count = 3;
 		max_brightness = 255;
+		use_colors = 1;
+		name_len = 0;
+		name_fmt = "%s:%s";
 	} else {
 		drv_data->led_count = 4;
 		max_brightness = 1;
+		use_colors = 0;
+		name_len = strlen("::sony#");
+		name_fmt = "%s::sony%d";
 	}
 
 	/* Clear LEDs as we have no way of reading their initial state. This is
@@ -871,6 +877,10 @@ static int sony_leds_init(struct hid_device *hdev)
 	name_sz = strlen(dev_name(&hdev->dev)) + name_len + 1;
 
 	for (n = 0; n < drv_data->led_count; n++) {
+
+		if (use_colors)
+			name_sz = strlen(dev_name(&hdev->dev)) + strlen(color_str[n]) + 2;
+
 		led = kzalloc(sizeof(struct led_classdev) + name_sz, GFP_KERNEL);
 		if (!led) {
 			hid_err(hdev, "Couldn't allocate memory for LED %d\n", n);
@@ -879,7 +889,10 @@ static int sony_leds_init(struct hid_device *hdev)
 		}
 
 		name = (void *)(&led[1]);
-		snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), n + 1);
+		if (use_colors)
+			snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), color_str[n]);
+		else
+			snprintf(name, name_sz, name_fmt, dev_name(&hdev->dev), n + 1);
 		led->name = name;
 		led->brightness = 0;
 		led->max_brightness = max_brightness;
-- 
1.8.3.2

