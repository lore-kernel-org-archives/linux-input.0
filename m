From: Pedro Vanzella <pedro@pedrovanzella.com>
Subject: [PATCH] HID: hid-logitech-hidpp: detect wireless lightspeed devices
Date: Tue, 28 May 2019 12:29:24 -0400
Message-ID: <20190528162924.32754-1-pedro@pedrovanzella.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Pedro Vanzella <pedro@pedrovanzella.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Send a low device index when the device is connected via the lightspeed
receiver so that the receiver will pass the message along to the device
instead of responding. If we don't do that, we end up thinking it's a
hidpp10 device and miss out on all new features available to newer devices.

This will enable correct detection of the following models:
G603, GPro, G305, G613, G900 and G903, and possibly others.

Signed-off-by: Pedro Vanzella <pedro@pedrovanzella.com>
---
 drivers/hid/hid-logitech-hidpp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 72fc9c0566db..621fce141d9f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -62,6 +62,7 @@ MODULE_PARM_DESC(disable_tap_to_click,
 #define HIDPP_QUIRK_CLASS_K400			BIT(2)
 #define HIDPP_QUIRK_CLASS_G920			BIT(3)
 #define HIDPP_QUIRK_CLASS_K750			BIT(4)
+#define HIDPP_QUIRK_CLASS_LIGHTSPEED		BIT(5)
 
 /* bits 2..20 are reserved for classes */
 /* #define HIDPP_QUIRK_CONNECT_EVENTS		BIT(21) disabled */
@@ -236,7 +237,11 @@ static int __hidpp_send_report(struct hid_device *hdev,
 	 * set the device_index as the receiver, it will be overwritten by
 	 * hid_hw_request if needed
 	 */
-	hidpp_report->device_index = 0xff;
+	if (hidpp->quirks & HIDPP_QUIRK_CLASS_LIGHTSPEED) {
+		hidpp_report->device_index = 0x01;
+	} else {
+		hidpp_report->device_index = 0xff;
+	}
 
 	if (hidpp->quirks & HIDPP_QUIRK_FORCE_OUTPUT_REPORTS) {
 		ret = hid_hw_output_report(hdev, (u8 *)hidpp_report, fields_count);
@@ -3753,6 +3758,9 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC06B) },
 	{ /* Logitech G900 Gaming Mouse over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC081) },
+	{ /* Logitech Gaming Mice over Lightspeed Receiver */
+	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC539),
+	  .driver_data = HIDPP_QUIRK_CLASS_LIGHTSPEED },
 	{ /* Logitech G920 Wheel over USB */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
-- 
2.21.0
