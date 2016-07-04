From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2] HID: hid-led: add support for Greynut Luxafor
Date: Mon, 4 Jul 2016 21:47:52 +0200
Message-ID: <bbbcb6de-241b-4f39-b8b2-1e6e83a0415f@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35310 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbcGDTsD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2016 15:48:03 -0400
Received: by mail-wm0-f68.google.com with SMTP id a66so23824004wme.2
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2016 12:47:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Add support for Greynut Luxafor. This device has two groups of three
independent LED's each.

Successfully tested with such a device.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- add device to HID_LED help info in Kconfig
---
 drivers/hid/Kconfig    |  1 +
 drivers/hid/hid-core.c |  1 +
 drivers/hid/hid-ids.h  |  1 +
 drivers/hid/hid-led.c  | 26 ++++++++++++++++++++++++++
 4 files changed, 29 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 74f8e37..78ac481 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -398,6 +398,7 @@ config HID_LED
 	- Dream Cheeky Webmail Notifier and Friends Alert
 	- ThingM blink(1)
 	- Delcom Visual Signal Indicator Generation 2
+	- Greynut Luxafor
 
 	To compile this driver as a module, choose M here: the
 	module will be called hid-led.
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 0777ff2..2187d60 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1966,6 +1966,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACENAVIGATOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_PICOLCD_BOOTLOADER) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP, USB_DEVICE_ID_LUXAFOR) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_KEYBOARD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f1bd6f6..6a9e025 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -688,6 +688,7 @@
 #define USB_DEVICE_ID_PICOLCD_BOOTLOADER	0xf002
 #define USB_DEVICE_ID_PICK16F1454	0x0042
 #define USB_DEVICE_ID_PICK16F1454_V2	0xf2f7
+#define USB_DEVICE_ID_LUXAFOR		0xf372
 
 #define USB_VENDOR_ID_MICROSOFT		0x045e
 #define USB_DEVICE_ID_SIDEWINDER_GV	0x003b
diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index b5ef6e1..164ec0e 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -28,6 +28,7 @@ enum hidled_type {
 	DREAM_CHEEKY,
 	THINGM,
 	DELCOM,
+	LUXAFOR,
 };
 
 static unsigned const char riso_kagaku_tbl[] = {
@@ -329,6 +330,19 @@ static int delcom_init(struct hidled_device *ldev)
 	return dp.fw.family_code == 2 ? 0 : -ENODEV;
 }
 
+static int luxafor_write(struct led_classdev *cdev, enum led_brightness br)
+{
+	struct hidled_led *led = to_hidled_led(cdev);
+	__u8 buf[MAX_REPORT_SIZE] = { [1] = 1 };
+
+	buf[2] = led->rgb->num + 1;
+	buf[3] = led->rgb->red.cdev.brightness;
+	buf[4] = led->rgb->green.cdev.brightness;
+	buf[5] = led->rgb->blue.cdev.brightness;
+
+	return hidled_send(led->rgb->ldev, buf);
+}
+
 static const struct hidled_config hidled_configs[] = {
 	{
 		.type = RISO_KAGAKU,
@@ -373,6 +387,16 @@ static const struct hidled_config hidled_configs[] = {
 		.init = delcom_init,
 		.write = delcom_write,
 	},
+	{
+		.type = LUXAFOR,
+		.name = "Greynut Luxafor",
+		.short_name = "luxafor",
+		.max_brightness = 255,
+		.num_leds = 6,
+		.report_size = 9,
+		.report_type = OUTPUT_REPORT,
+		.write = luxafor_write,
+	},
 };
 
 static int hidled_init_led(struct hidled_led *led, const char *color_name,
@@ -480,6 +504,8 @@ static const struct hid_device_id hidled_table[] = {
 	  USB_DEVICE_ID_BLINK1), .driver_data = THINGM },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELCOM,
 	  USB_DEVICE_ID_DELCOM_VISUAL_IND), .driver_data = DELCOM },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROCHIP,
+	  USB_DEVICE_ID_LUXAFOR), .driver_data = LUXAFOR },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, hidled_table);
-- 
2.9.0


