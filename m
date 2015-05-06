From: Sean Young <sean@mess.org>
Subject: [PATCH 1/2] HID: sjoy: support Super Joy Box 4
Date: Wed,  6 May 2015 21:38:42 +0100
Message-ID: <1430944724-3980-1-git-send-email-sean@mess.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gofer.mess.org ([80.229.237.210]:43428 "EHLO gofer.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbbEFUqZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 6 May 2015 16:46:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

This device supports force feedback and has two ports.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/hid/hid-core.c          | 1 +
 drivers/hid/hid-sjoy.c          | 3 +++
 drivers/hid/usbhid/hid-quirks.c | 1 -
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 56ce8c2..1855b65 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1976,6 +1976,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_JOY_BOX_3_PRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_DUAL_BOX_PRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_JOY_BOX_5_PRO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PLAYDOTCOM, USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SLIM_TABLET_5_8_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SLIM_TABLET_12_1_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_Q_PAD) },
diff --git a/drivers/hid/hid-sjoy.c b/drivers/hid/hid-sjoy.c
index 37845ec..36b6470 100644
--- a/drivers/hid/hid-sjoy.c
+++ b/drivers/hid/hid-sjoy.c
@@ -166,6 +166,9 @@ static const struct hid_device_id sjoy_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD),
 		.driver_data = HID_QUIRK_MULTI_INPUT |
 			       HID_QUIRK_SKIP_OUTPUT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_PLAYDOTCOM, USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII),
+		.driver_data = HID_QUIRK_MULTI_INPUT |
+			       HID_QUIRK_SKIP_OUTPUT_REPORTS },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, sjoy_devices);
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index a821277..849d4e1 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -52,7 +52,6 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_ETURBOTOUCH, USB_DEVICE_ID_ETURBOTOUCH_2968, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_GREENASIA, USB_DEVICE_ID_GREENASIA_DUAL_USB_JOYPAD, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_PANTHERLORD, USB_DEVICE_ID_PANTHERLORD_TWIN_USB_JOYSTICK, HID_QUIRK_MULTI_INPUT | HID_QUIRK_SKIP_OUTPUT_REPORTS },
-	{ USB_VENDOR_ID_PLAYDOTCOM, USB_DEVICE_ID_PLAYDOTCOM_EMS_USBII, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_TOUCHPACK, USB_DEVICE_ID_TOUCHPACK_RTS, HID_QUIRK_MULTI_INPUT },
 
 	{ USB_VENDOR_ID_AIREN, USB_DEVICE_ID_AIREN_SLIMPLUS, HID_QUIRK_NOGET },
-- 
2.1.0

