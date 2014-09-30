From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 13/13] HID: logitech-hidpp: support combo keyboard touchpad TK820
Date: Tue, 30 Sep 2014 13:18:35 -0400
Message-ID: <1412097515-17241-14-git-send-email-benjamin.tissoires@redhat.com>
References: <1412097515-17241-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1412097515-17241-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Andrew de los Reyes <andrew-vger@gizmolabs.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The TK820 presents both a keyboard and a touchpad on the same
physical (and logical device). Use the generic hid-input
processing for the keyboard part. The keyboard input device is created
when the receiver is plugged in, so no events are missed on connect.

When the device actaully connects, we can set it to use the raw
multitouch reporting to have a consistent user experience accross
all Logitech touchpads.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 17e27e9..361e97d 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -39,6 +39,7 @@ MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
 /* bits 1..20 are reserved for classes */
 #define HIDPP_QUIRK_DELAYED_INIT		BIT(21)
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
+#define HIDPP_QUIRK_MULTI_INPUT			BIT(23)
 
 /*
  * There are two hidpp protocols in use, the first version hidpp10 is known
@@ -614,6 +615,12 @@ static int wtp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
+	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+
+	if ((hidpp->quirks & HIDPP_QUIRK_MULTI_INPUT) &&
+	    (field->application == HID_GD_KEYBOARD))
+		return 0;
+
 	return -1;
 }
 
@@ -622,6 +629,10 @@ static void wtp_populate_input(struct hidpp_device *hidpp,
 {
 	struct wtp_data *wd = hidpp->private_data;
 
+	if ((hidpp->quirks & HIDPP_QUIRK_MULTI_INPUT) && origin_is_hid_core)
+		/* this is the generic hid-input call */
+		return;
+
 	__set_bit(EV_ABS, input_dev->evbit);
 	__set_bit(EV_KEY, input_dev->evbit);
 	__clear_bit(EV_REL, input_dev->evbit);
@@ -1114,6 +1125,10 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
 		connect_mask &= ~HID_CONNECT_HIDINPUT;
 
+	/* Re-enable hidinput for multi-input devices */
+	if (hidpp->quirks & HIDPP_QUIRK_MULTI_INPUT)
+		connect_mask |= HID_CONNECT_HIDINPUT;
+
 	ret = hid_hw_start(hdev, connect_mask);
 	if (ret) {
 		hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
@@ -1160,6 +1175,11 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_T651),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP },
+	{ /* Keyboard TK820 */
+	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
+		USB_VENDOR_ID_LOGITECH, 0x4102),
+	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_MULTI_INPUT |
+			 HIDPP_QUIRK_CLASS_WTP },
 
 	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
-- 
2.1.0
