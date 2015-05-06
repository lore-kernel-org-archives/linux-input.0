From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] Revert "HID: logitech-hidpp: support combo keyboard touchpad TK820"
Date: Wed,  6 May 2015 15:01:31 -0400
Message-ID: <1430938891-28814-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This reverts commit 3a61e97563d78a2ca10752902449570d8433ce76.

The Logitech TK820 seems to be affected by a firmware bug which
delays the sending of the keys (pressed, or released, which triggers
a key-repeat) while holding fingers on the touch sensor.
This behavior can be observed while using the mouse emulation mode
if the user moves the finger while typing (highly improbable though).
Holding the finger still while in the mouse emulation mode does
not trigger the key repeat problem.
So better keep things in their previous state to not have to
explain users that the new key-repeat bug they see is a "feature".

Furthermore, I noticed that I disabled the media keys whith
this patch. Sorry, my bad.

I think it is best to revert the patch, in all the current
versions it has been shipped.

Cc: <stable@vger.kernel.org> # v3.19 and above
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi,

well, I discussed about this 2 weeks ago with Nestor. Some users were
complaining about spurious key repeats, and I was able to reproduce them
by holding a finger on the sensor while typing (which can be easily trigger
given the proximity of the sensor and the keyboard).
The new part is that:
1. the original patch killed the media keys (oops)
2. the key-repeat bug can also be triggered while in mouse mode but you need
   to semd events from the touchpad while typing to get it.

In all cases, the patch is broken in its current state, and instead of asking
users to use the parameter disable_raw_mode=1, lets just disable the raw support
of the keyboard/touchpad for now.

Cheers,
Benjamin

 drivers/hid/hid-logitech-hidpp.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index b3cf6fd..5fd530a 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -44,7 +44,6 @@ MODULE_PARM_DESC(disable_raw_mode,
 /* bits 1..20 are reserved for classes */
 #define HIDPP_QUIRK_DELAYED_INIT		BIT(21)
 #define HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS	BIT(22)
-#define HIDPP_QUIRK_MULTI_INPUT			BIT(23)
 
 /*
  * There are two hidpp protocols in use, the first version hidpp10 is known
@@ -706,12 +705,6 @@ static int wtp_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 		struct hid_field *field, struct hid_usage *usage,
 		unsigned long **bit, int *max)
 {
-	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
-
-	if ((hidpp->quirks & HIDPP_QUIRK_MULTI_INPUT) &&
-	    (field->application == HID_GD_KEYBOARD))
-		return 0;
-
 	return -1;
 }
 
@@ -720,10 +713,6 @@ static void wtp_populate_input(struct hidpp_device *hidpp,
 {
 	struct wtp_data *wd = hidpp->private_data;
 
-	if ((hidpp->quirks & HIDPP_QUIRK_MULTI_INPUT) && origin_is_hid_core)
-		/* this is the generic hid-input call */
-		return;
-
 	__set_bit(EV_ABS, input_dev->evbit);
 	__set_bit(EV_KEY, input_dev->evbit);
 	__clear_bit(EV_REL, input_dev->evbit);
@@ -1245,10 +1234,6 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	if (hidpp->quirks & HIDPP_QUIRK_DELAYED_INIT)
 		connect_mask &= ~HID_CONNECT_HIDINPUT;
 
-	/* Re-enable hidinput for multi-input devices */
-	if (hidpp->quirks & HIDPP_QUIRK_MULTI_INPUT)
-		connect_mask |= HID_CONNECT_HIDINPUT;
-
 	ret = hid_hw_start(hdev, connect_mask);
 	if (ret) {
 		hid_err(hdev, "%s:hid_hw_start returned error\n", __func__);
@@ -1296,11 +1281,6 @@ static const struct hid_device_id hidpp_devices[] = {
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_T651),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP },
-	{ /* Keyboard TK820 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4102),
-	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_MULTI_INPUT |
-			 HIDPP_QUIRK_CLASS_WTP },
 
 	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
 		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
-- 
2.3.6
