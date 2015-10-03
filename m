From: Oliver Schmitt <voltumna@gmx.net>
Subject: [PATCH] usbhid: Fix for the WiiU adapter from Mayflash
Date: Sat,  3 Oct 2015 18:20:02 +0200
Message-ID: <1443889202-12113-1-git-send-email-voltumna@gmx.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:53233 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960AbbJCQUf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 3 Oct 2015 12:20:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, Oliver Schmitt <voltumna@gmx.net>

The WiiU adapter from Mayflash (see http://www.mayflash.com/Products/NINTENDOWiiU/W009.html) is not working correctly.

The "XInput" mode works fine, the controller is recognized as a xbox controller. But it is only possible to connect one controller with this method.

In "DInput" mode the device is recognized as some kind of mouse input but no joystick is created. This commit will change this behavior with HID_QUIRK_MULTI_INPUT to split the device into 4 input devices so that it will also create joysticks in /dev/input/js*.

Signed-off-by: Oliver Schmitt <voltumna@gmx.net>
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f769208..cfb317e 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -288,6 +288,7 @@
 #define USB_DEVICE_ID_DMI_ENC		0x5fab
 
 #define USB_VENDOR_ID_DRAGONRISE	0x0079
+#define USB_DEVICE_ID_DRAGONRISE_WIIU	0x1800
 
 #define USB_VENDOR_ID_DWAV		0x0eef
 #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 1dff8f0..26d2f83 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -71,6 +71,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_WIIU, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103, HID_QUIRK_ALWAYS_POLL },
-- 
2.5.3

