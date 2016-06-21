From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 3/4] HID: hid-led: add support for ThingM blink(1)
Date: Tue, 21 Jun 2016 21:49:29 +0200
Message-ID: <b7d3cac3-a09a-5b39-85ea-6b03e7e0de20@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35875 "EHLO
	mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbcFUTvG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 15:51:06 -0400
Received: by mail-lf0-f68.google.com with SMTP id a2so6451993lfe.3
        for <linux-input@vger.kernel.org>; Tue, 21 Jun 2016 12:51:05 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Add support for ThingM blink(1) and make the dedicated ThingM driver
obsolete.

Successfully tested with a blink(1) mk2.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/hid/Kconfig   |  7 +++---
 drivers/hid/hid-led.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f7be60f..ab22090 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -393,9 +393,10 @@ config HID_LED
 	depends on HID
 	depends on LEDS_CLASS
 	---help---
-	Support for simple RGB LED devices. Currently supported are the
-	Riso Kagaku Webmail Notifier and the Dream Cheeky Webmail Notifier
-	and Friends Alert.
+	Support for simple RGB LED devices. Currently supported are:
+	- Riso Kagaku Webmail Notifier
+	- Dream Cheeky Webmail Notifier and Friends Alert
+	- ThingM blink(1)
 
 	To compile this driver as a module, choose M here: the
 	module will be called hid-led.
diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index 4075f09..e11b645 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -26,6 +26,7 @@ enum hidled_report_type {
 enum hidled_type {
 	RISO_KAGAKU,
 	DREAM_CHEEKY,
+	THINGM,
 };
 
 static unsigned const char riso_kagaku_tbl[] = {
@@ -198,6 +199,57 @@ static int dream_cheeky_init(struct hidled_device *ldev)
 	return hidled_send(ldev, buf);
 }
 
+static int _thingm_write(struct led_classdev *cdev, enum led_brightness br,
+			 u8 offset)
+{
+	struct hidled_led *led = to_hidled_led(cdev);
+	__u8 buf[MAX_REPORT_SIZE] = { [1] = 'c' };
+
+	buf[2] = led->rgb->red.cdev.brightness;
+	buf[3] = led->rgb->green.cdev.brightness;
+	buf[4] = led->rgb->blue.cdev.brightness;
+	buf[7] = led->rgb->num + offset;
+
+	return hidled_send(led->rgb->ldev, buf);
+}
+
+static int thingm_write_v1(struct led_classdev *cdev, enum led_brightness br)
+{
+	return _thingm_write(cdev, br, 0);
+}
+
+static int thingm_write(struct led_classdev *cdev, enum led_brightness br)
+{
+	return _thingm_write(cdev, br, 1);
+}
+
+static const struct hidled_config hidled_config_thingm_v1 = {
+	.name = "ThingM blink(1) v1",
+	.short_name = "thingm",
+	.max_brightness = 255,
+	.num_leds = 1,
+	.report_size = 9,
+	.report_type = RAW_REQUEST,
+	.report_id = 1,
+	.write = thingm_write_v1,
+};
+
+static int thingm_init(struct hidled_device *ldev)
+{
+	__u8 buf[MAX_REPORT_SIZE] = { [1] = 'v' };
+	int ret;
+
+	ret = hidled_recv(ldev, buf);
+	if (ret)
+		return ret;
+
+	/* Check for firmware major version 1 */
+	if (buf[3] == '1')
+		ldev->config = &hidled_config_thingm_v1;
+
+	return 0;
+}
+
 static const struct hidled_config hidled_configs[] = {
 	{
 		.type = RISO_KAGAKU,
@@ -222,6 +274,18 @@ static const struct hidled_config hidled_configs[] = {
 		.init = dream_cheeky_init,
 		.write = dream_cheeky_write,
 	},
+	{
+		.type = THINGM,
+		.name = "ThingM blink(1)",
+		.short_name = "thingm",
+		.max_brightness = 255,
+		.num_leds = 2,
+		.report_size = 9,
+		.report_type = RAW_REQUEST,
+		.report_id = 1,
+		.init = thingm_init,
+		.write = thingm_write,
+	},
 };
 
 static int hidled_init_led(struct hidled_led *led, const char *color_name,
@@ -325,6 +389,8 @@ static const struct hid_device_id hidled_table[] = {
 	  USB_DEVICE_ID_DREAM_CHEEKY_WN), .driver_data = DREAM_CHEEKY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY,
 	  USB_DEVICE_ID_DREAM_CHEEKY_FA), .driver_data = DREAM_CHEEKY },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_THINGM,
+	  USB_DEVICE_ID_BLINK1), .driver_data = THINGM },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, hidled_table);
-- 
2.9.0

