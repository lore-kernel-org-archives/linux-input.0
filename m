From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] HID: asus: Add support for T100 touchpad
Date: Thu, 25 May 2017 16:49:21 +0200
Message-ID: <20170525144921.18552-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47410 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbdEYOt0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 25 May 2017 10:49:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Add support for the Asus T100 touchpad in multi-touch mode (rather
then mouse emulation mode). It turns out that the Asus T100 touchpad
is identical to the already supported i2c-hid Asus touchpads, so
adding support for it was easy.

The only significant difference is that the reported x-coordinates
range on the T100 touchpad is somewhat lower then the range on the
already supported touchpads.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hid/hid-asus.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 101ab2e63d18..b4a6a53f8af2 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -29,6 +29,7 @@
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/input/mt.h>
+#include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
 
 #include "hid-ids.h"
 
@@ -38,6 +39,8 @@ MODULE_AUTHOR("Victor Vlasenko <victor.vlasenko@sysgears.com>");
 MODULE_AUTHOR("Frederik Wenigwieser <frederik.wenigwieser@gmail.com>");
 MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 
+#define T100_TPAD_INTF 2
+
 #define FEATURE_REPORT_ID 0x0d
 #define INPUT_REPORT_ID 0x5d
 #define FEATURE_KBD_REPORT_ID 0x5a
@@ -50,6 +53,7 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define MAX_CONTACTS 5
 
 #define MAX_X 2794
+#define MAX_X_T100 2240
 #define MAX_Y 1758
 #define MAX_TOUCH_MAJOR 8
 #define MAX_PRESSURE 128
@@ -70,11 +74,12 @@ MODULE_DESCRIPTION("Asus HID Keyboard and TouchPad");
 #define QUIRK_NO_CONSUMER_USAGES	BIT(4)
 #define QUIRK_USE_KBD_BACKLIGHT		BIT(5)
 #define QUIRK_T100_KEYBOARD		BIT(6)
+#define QUIRK_T100_TOUCHPAD		BIT(7)
 
 #define I2C_KEYBOARD_QUIRKS			(QUIRK_FIX_NOTEBOOK_REPORT | \
 						 QUIRK_NO_INIT_REPORTS | \
 						 QUIRK_NO_CONSUMER_USAGES)
-#define I2C_TOUCHPAD_QUIRKS			(QUIRK_NO_INIT_REPORTS | \
+#define TOUCHPAD_QUIRKS				(QUIRK_NO_INIT_REPORTS | \
 						 QUIRK_SKIP_INPUT_MAPPING | \
 						 QUIRK_IS_MULTITOUCH)
 
@@ -337,7 +342,10 @@ static int asus_input_configured(struct hid_device *hdev, struct hid_input *hi)
 	if (drvdata->quirks & QUIRK_IS_MULTITOUCH) {
 		int ret;
 
-		input_set_abs_params(input, ABS_MT_POSITION_X, 0, MAX_X, 0, 0);
+		if (drvdata->quirks & QUIRK_T100_TOUCHPAD)
+			input_set_abs_params(input, ABS_MT_POSITION_X, 0, MAX_X_T100, 0, 0);
+		else
+			input_set_abs_params(input, ABS_MT_POSITION_X, 0, MAX_X, 0, 0);
 		input_set_abs_params(input, ABS_MT_POSITION_Y, 0, MAX_Y, 0, 0);
 		input_set_abs_params(input, ABS_TOOL_WIDTH, 0, MAX_TOUCH_MAJOR, 0, 0);
 		input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, MAX_TOUCH_MAJOR, 0, 0);
@@ -490,6 +498,13 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	drvdata->quirks = id->driver_data;
 
+	if (drvdata->quirks & QUIRK_T100_KEYBOARD) {
+		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+
+		if (intf->altsetting->desc.bInterfaceNumber == T100_TPAD_INTF)
+			drvdata->quirks = TOUCHPAD_QUIRKS | QUIRK_T100_TOUCHPAD;
+	}
+
 	if (drvdata->quirks & QUIRK_NO_INIT_REPORTS)
 		hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
 
@@ -562,7 +577,7 @@ static const struct hid_device_id asus_devices[] = {
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD), I2C_KEYBOARD_QUIRKS},
 	{ HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
-		USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD), I2C_TOUCHPAD_QUIRKS },
+		USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD), TOUCHPAD_QUIRKS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
 		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-- 
2.13.0

