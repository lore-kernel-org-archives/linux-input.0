From: Sean Young <sean@mess.org>
Subject: [PATCH] HID: Add device ID for Super Joy Box 3
Date: Sat, 18 Feb 2012 12:53:44 +0000
Message-ID: <1329569624-10669-1-git-send-email-sean@mess.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pequod.mess.org ([93.97.41.153]:46524 "EHLO pequod.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905Ab2BRNDa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Feb 2012 08:03:30 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, Sean Young <sean@mess.org>

Also correct the quirks for the Super Joy Box 3 Pro and Super Dual Box.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/hid/hid-core.c |    1 +
 drivers/hid/hid-ids.h  |    1 +
 drivers/hid/hid-sjoy.c |    6 ++++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 162be09..e89e4c7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1550,6 +1550,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UNITEC, USB_DEVICE_ID_UNITEC_USB_TOUCH_0709) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UNITEC, USB_DEVICE_ID_UNITEC_USB_TOUCH_0A19) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SUPER_JOY_BOX_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_JOY_BOX_3_PRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_DUAL_BOX_PRO) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b6a0455..29a7086 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -717,6 +717,7 @@
 #define USB_DEVICE_ID_1_PHIDGETSERVO_20	0x8101
 #define USB_DEVICE_ID_4_PHIDGETSERVO_20	0x8104
 #define USB_DEVICE_ID_8_8_4_IF_KIT	0x8201
+#define USB_DEVICE_ID_SUPER_JOY_BOX_3	0x8888
 #define USB_DEVICE_ID_QUAD_USB_JOYPAD	0x8800
 #define USB_DEVICE_ID_DUAL_USB_JOYPAD	0x8866
 
diff --git a/drivers/hid/hid-sjoy.c b/drivers/hid/hid-sjoy.c
index 4b14486..42257ac 100644
--- a/drivers/hid/hid-sjoy.c
+++ b/drivers/hid/hid-sjoy.c
@@ -155,7 +155,8 @@ err:
 }
 
 static const struct hid_device_id sjoy_devices[] = {
-	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_JOY_BOX_3_PRO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_JOY_BOX_3_PRO),
+		.driver_data = HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_DUAL_BOX_PRO),
 		.driver_data = HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET |
 			       HID_QUIRK_SKIP_OUTPUT_REPORTS },
@@ -163,8 +164,9 @@ static const struct hid_device_id sjoy_devices[] = {
 		.driver_data = HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET |
 			       HID_QUIRK_SKIP_OUTPUT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SUPER_JOY_BOX_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD),
-		.driver_data = HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET |
+		.driver_data = HID_QUIRK_MULTI_INPUT |
 			       HID_QUIRK_SKIP_OUTPUT_REPORTS },
 	{ }
 };
-- 
1.7.7.6

