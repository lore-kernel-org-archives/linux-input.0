From: Yusuke Fujimaki <usk.fujimaki@gmail.com>
Subject: [PATCH] HID: asus: add support for hotkeys
Date: Thu, 12 May 2016 01:46:07 +0900
Message-ID: <1462985167-8566-1-git-send-email-usk.fujimaki@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:33932 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbcEKQqo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2016 12:46:44 -0400
Received: by mail-pa0-f67.google.com with SMTP id yl2so3962540pac.1
        for <linux-input@vger.kernel.org>; Wed, 11 May 2016 09:46:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Yusuke Fujimaki <usk.fujimaki@gmail.com>

Asus X205TA and E200HA keyboard hotkeys (excluding volume control) sends vendor specific usage id.
This patch add input mapping to support such hotkeys.

Signed-off-by: Yusuke Fujimaki <usk.fujimaki@gmail.com>
---
 drivers/hid/hid-asus.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 7a811ec..a71f90c 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -26,6 +26,10 @@
 
 #include "hid-ids.h"
 
+#define HID_UP_ASUSVENDOR	0xff310000
+#define asus_map_key_clear(c)	hid_map_usage_clear(hi, usage, bit, max, \
+					EV_KEY, (c))
+
 static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
@@ -36,6 +40,26 @@ static __u8 *asus_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+static int asus_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+		struct hid_field *field, struct hid_usage *usage,
+		unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_ASUSVENDOR)
+		return 0;
+
+	switch (usage->hid & HID_USAGE) {
+	case 0x10: asus_map_key_clear(KEY_BRIGHTNESSDOWN);	break;
+	case 0x20: asus_map_key_clear(KEY_BRIGHTNESSUP);	break;
+	case 0x35: asus_map_key_clear(KEY_DISPLAY_OFF);		break;
+	case 0x6b: asus_map_key_clear(KEY_TOUCHPAD_TOGGLE);	break;
+	case 0x6c: asus_map_key_clear(KEY_SLEEP);		break;
+	case 0x88: asus_map_key_clear(KEY_RFKILL);		break;
+	default:
+		return 0;
+	}
+	return 1;
+}
+
 static const struct hid_device_id asus_devices[] = {
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_NOTEBOOK_KEYBOARD) },
 	{ }
@@ -45,6 +69,7 @@ MODULE_DEVICE_TABLE(hid, asus_devices);
 static struct hid_driver asus_driver = {
 	.name = "asus",
 	.id_table = asus_devices,
+	.input_mapping = asus_input_mapping,
 	.report_fixup = asus_report_fixup
 };
 module_hid_driver(asus_driver);
-- 
2.1.4

