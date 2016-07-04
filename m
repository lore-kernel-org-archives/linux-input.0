From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH v2 2/2] HID: hid-led: add support for Delcom Visual Signal
 Indicator G2
Date: Mon, 4 Jul 2016 21:45:54 +0200
Message-ID: <db35f624-72b7-7504-4e19-e60bd41041ca@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34298 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753711AbcGDTp6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jul 2016 15:45:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id 187so23854689wmz.1
        for <linux-input@vger.kernel.org>; Mon, 04 Jul 2016 12:45:57 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org

Add support for the HID-compliant Delcom Visual Signal Indicator
generation 2 devices.

Successfully tested with part no 904000 from the family of these devices.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- add device to HID_LED help info in Kconfig
- factor out enabling a led to delcom_enable_led
- set only brightness of affected led in delcom_write 
---
 drivers/hid/Kconfig    |  1 +
 drivers/hid/hid-core.c |  1 +
 drivers/hid/hid-ids.h  |  3 ++
 drivers/hid/hid-led.c  | 98 ++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index c5de17c..74f8e37 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -397,6 +397,7 @@ config HID_LED
 	- Riso Kagaku Webmail Notifier
 	- Dream Cheeky Webmail Notifier and Friends Alert
 	- ThingM blink(1)
+	- Delcom Visual Signal Indicator Generation 2
 
 	To compile this driver as a module, choose M here: the
 	module will be called hid-led.
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index efd8f8c..0777ff2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1878,6 +1878,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_BARCODE_4) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CYPRESS, USB_DEVICE_ID_CYPRESS_MOUSE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DELCOM, USB_DEVICE_ID_DELCOM_VISUAL_IND) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0006) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, 0x0011) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, USB_DEVICE_ID_DREAM_CHEEKY_WN) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 191c981..f1bd6f6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -299,6 +299,9 @@
 #define USB_VENDOR_ID_DEALEXTREAME	0x10c5
 #define USB_DEVICE_ID_DEALEXTREAME_RADIO_SI4701	0x819a
 
+#define USB_VENDOR_ID_DELCOM		0x0fc5
+#define USB_DEVICE_ID_DELCOM_VISUAL_IND	0xb080
+
 #define USB_VENDOR_ID_DELORME		0x1163
 #define USB_DEVICE_ID_DELORME_EARTHMATE	0x0100
 #define USB_DEVICE_ID_DELORME_EM_LT20	0x0200
diff --git a/drivers/hid/hid-led.c b/drivers/hid/hid-led.c
index fce2a03..b5ef6e1 100644
--- a/drivers/hid/hid-led.c
+++ b/drivers/hid/hid-led.c
@@ -27,6 +27,7 @@ enum hidled_type {
 	RISO_KAGAKU,
 	DREAM_CHEEKY,
 	THINGM,
+	DELCOM,
 };
 
 static unsigned const char riso_kagaku_tbl[] = {
@@ -43,6 +44,28 @@ static unsigned const char riso_kagaku_tbl[] = {
 
 #define RISO_KAGAKU_IX(r, g, b) riso_kagaku_tbl[((r)?1:0)+((g)?2:0)+((b)?4:0)]
 
+union delcom_packet {
+	__u8 data[8];
+	struct {
+		__u8 major_cmd;
+		__u8 minor_cmd;
+		__u8 data_lsb;
+		__u8 data_msb;
+	} tx;
+	struct {
+		__u8 cmd;
+	} rx;
+	struct {
+		__le16 family_code;
+		__le16 security_code;
+		__u8 fw_version;
+	} fw;
+};
+
+#define DELCOM_GREEN_LED	0
+#define DELCOM_RED_LED		1
+#define DELCOM_BLUE_LED		2
+
 struct hidled_device;
 struct hidled_rgb;
 
@@ -244,6 +267,68 @@ static int thingm_init(struct hidled_device *ldev)
 	return 0;
 }
 
+static inline int delcom_get_lednum(const struct hidled_led *led)
+{
+	if (led == &led->rgb->red)
+		return DELCOM_RED_LED;
+	else if (led == &led->rgb->green)
+		return DELCOM_GREEN_LED;
+	else
+		return DELCOM_BLUE_LED;
+}
+
+static int delcom_enable_led(struct hidled_led *led)
+{
+	union delcom_packet dp = { .tx.major_cmd = 101, .tx.minor_cmd = 12 };
+
+	dp.tx.data_lsb = 1 << delcom_get_lednum(led);
+	dp.tx.data_msb = 0;
+
+	return hidled_send(led->rgb->ldev, dp.data);
+}
+
+static int delcom_set_pwm(struct hidled_led *led)
+{
+	union delcom_packet dp = { .tx.major_cmd = 101, .tx.minor_cmd = 34 };
+
+	dp.tx.data_lsb = delcom_get_lednum(led);
+	dp.tx.data_msb = led->cdev.brightness;
+
+	return hidled_send(led->rgb->ldev, dp.data);
+}
+
+static int delcom_write(struct led_classdev *cdev, enum led_brightness br)
+{
+	struct hidled_led *led = to_hidled_led(cdev);
+	int ret;
+
+	/*
+	 * enable LED
+	 * We can't do this in the init function already because the device
+	 * is internally reset later.
+	 */
+	ret = delcom_enable_led(led);
+	if (ret)
+		return ret;
+
+	return delcom_set_pwm(led);
+}
+
+static int delcom_init(struct hidled_device *ldev)
+{
+	union delcom_packet dp = { .rx.cmd = 104 };
+	int ret;
+
+	ret = hidled_recv(ldev, dp.data);
+	if (ret)
+		return ret;
+	/*
+	 * Several Delcom devices share the same USB VID/PID
+	 * Check for family id 2 for Visual Signal Indicator
+	 */
+	return dp.fw.family_code == 2 ? 0 : -ENODEV;
+}
+
 static const struct hidled_config hidled_configs[] = {
 	{
 		.type = RISO_KAGAKU,
@@ -277,6 +362,17 @@ static const struct hidled_config hidled_configs[] = {
 		.init = thingm_init,
 		.write = thingm_write,
 	},
+	{
+		.type = DELCOM,
+		.name = "Delcom Visual Signal Indicator G2",
+		.short_name = "delcom",
+		.max_brightness = 100,
+		.num_leds = 1,
+		.report_size = 8,
+		.report_type = RAW_REQUEST,
+		.init = delcom_init,
+		.write = delcom_write,
+	},
 };
 
 static int hidled_init_led(struct hidled_led *led, const char *color_name,
@@ -382,6 +478,8 @@ static const struct hid_device_id hidled_table[] = {
 	  USB_DEVICE_ID_DREAM_CHEEKY_FA), .driver_data = DREAM_CHEEKY },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THINGM,
 	  USB_DEVICE_ID_BLINK1), .driver_data = THINGM },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_DELCOM,
+	  USB_DEVICE_ID_DELCOM_VISUAL_IND), .driver_data = DELCOM },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, hidled_table);
-- 
2.9.0

