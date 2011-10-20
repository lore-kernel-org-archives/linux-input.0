From: Sean Young <sean@mess.org>
Subject: [PATCH] HID: Add USB device IDs for more PS/PS2 adapters
Date: Thu, 20 Oct 2011 21:26:21 +0100
Message-ID: <1319142381-13495-1-git-send-email-sean@mess.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pequod.mess.org ([188.220.58.213]:46042 "EHLO pequod.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab1JTUiF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Oct 2011 16:38:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, linux-input@vger.kernel.org
Cc: Sean Young <sean@mess.org>

Support the following models: Super Joy Box 3 Pro, Super Dual Box Pro
and Super Joy Box 5 Pro. These models have support for pressure
sensitive buttons and they can force the controller to either digital
or analog mode, both of which are not supported yet.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/hid/Kconfig             |    6 +++++-
 drivers/hid/hid-core.c          |    3 +++
 drivers/hid/hid-ids.h           |    3 +++
 drivers/hid/hid-sjoy.c          |    7 +++++++
 drivers/hid/usbhid/hid-quirks.c |    1 -
 5 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index 88cb1a8..22a4a05 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -564,7 +564,11 @@ config HID_SMARTJOYPLUS
 	tristate "SmartJoy PLUS PS2/USB adapter support"
 	depends on USB_HID
 	---help---
-	Support for SmartJoy PLUS PS2/USB adapter.
+	Support for SmartJoy PLUS PS2/USB adapter, Super Dual Box,
+	Super Joy Box 3 Pro, Super Dual Box Pro, and Super Joy Box 5 Pro.
+
+	Note that DDR (Dance Dance Revolution) mode is not supported, nor
+	is pressure sensitive buttons on the pro models.
 
 config SMARTJOYPLUS_FF
 	bool "SmartJoy PLUS PS2/USB adapter force feedback support"
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 3ef01a2..2572db9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1536,6 +1536,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_UNITEC, USB_DEVICE_ID_UNITEC_USB_TOUCH_0A19) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_JOY_BOX_3_PRO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_DUAL_BOX_PRO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_JOY_BOX_5_PRO) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SLIM_TABLET_5_8_INCH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_SLIM_TABLET_12_1_INCH) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 057c405..a73dd86 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -693,6 +693,9 @@
 #define USB_VENDOR_ID_WISEGROUP_LTD	0x6666
 #define USB_VENDOR_ID_WISEGROUP_LTD2	0x6677
 #define USB_DEVICE_ID_SMARTJOY_DUAL_PLUS 0x8802
+#define USB_DEVICE_ID_SUPER_JOY_BOX_3_PRO 0x8801
+#define USB_DEVICE_ID_SUPER_DUAL_BOX_PRO 0x8802
+#define USB_DEVICE_ID_SUPER_JOY_BOX_5_PRO 0x8804
 
 #define USB_VENDOR_ID_X_TENSIONS               0x1ae7
 #define USB_DEVICE_ID_SPEEDLINK_VAD_CEZANNE    0x9001
diff --git a/drivers/hid/hid-sjoy.c b/drivers/hid/hid-sjoy.c
index 810425f..670da91 100644
--- a/drivers/hid/hid-sjoy.c
+++ b/drivers/hid/hid-sjoy.c
@@ -154,6 +154,13 @@ err:
 }
 
 static const struct hid_device_id sjoy_devices[] = {
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_JOY_BOX_3_PRO) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_DUAL_BOX_PRO),
+		.driver_data = HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET |
+			       HID_QUIRK_SKIP_OUTPUT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SUPER_JOY_BOX_5_PRO),
+		.driver_data = HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET |
+			       HID_QUIRK_SKIP_OUTPUT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_SMARTJOY_PLUS) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_DUAL_USB_JOYPAD),
 		.driver_data = HID_QUIRK_MULTI_INPUT | HID_QUIRK_NOGET |
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index d078888..4ea4641 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -82,7 +82,6 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_WALTOP, USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_WISEGROUP, USB_DEVICE_ID_QUAD_USB_JOYPAD, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 
-	{ USB_VENDOR_ID_WISEGROUP_LTD, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_WISEGROUP_LTD2, USB_DEVICE_ID_SMARTJOY_DUAL_PLUS, HID_QUIRK_NOGET | HID_QUIRK_MULTI_INPUT },
 
 	{ USB_VENDOR_ID_PI_ENGINEERING, USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL, HID_QUIRK_HIDINPUT_FORCE },
-- 
1.7.6.4

