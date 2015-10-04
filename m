From: Andrew Rodland <andrew@cleverdomain.org>
Subject: [PATCH] HID: quirks: add MULTI_INPUT quirk for Dragonrise GameCube adapter
Date: Sat, 03 Oct 2015 22:52:49 -0400
Message-ID: <4642064.DtyDCjyYx4@goron>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751089AbbJDC7X (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 3 Oct 2015 22:59:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Jiri Kosina <jkosina@suse.cz>

This device (aka Mayflash GameCube Adapter) has 4 controller ports, and 
without the quirk they all become one very large joystock device. With the 
quirk they're recognized as 4 separate joysticks.

Signed-off-by: Andrew Rodland <andrew@cleverdomain.org>
---
 drivers/hid/hid-ids.h           | 3 ++-
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index f769208..596f37a 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -287,7 +287,8 @@
 #define USB_VENDOR_ID_DMI    0x0c0b
 #define USB_DEVICE_ID_DMI_ENC    0x5fab

-#define USB_VENDOR_ID_DRAGONRISE 0x0079
+#define USB_VENDOR_ID_DRAGONRISE   0x0079
+#define USB_DEVICE_ID_DRAGONRISE_GAMECUBE  0x1843

 #define USB_VENDOR_ID_DWAV   0x0eef
 #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER 0x0001
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 1dff8f0..1742ed0 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -71,6 +71,7 @@ static const struct hid_blacklist {
  { USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
  { USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE, 
HID_QUIRK_ALWAYS_POLL },
  { USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
+ { USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE, 
HID_QUIRK_MULTI_INPUT },
  { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN, HID_QUIRK_ALWAYS_POLL 
},
  { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B, 
HID_QUIRK_ALWAYS_POLL },
  { USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103, 
HID_QUIRK_ALWAYS_POLL },
-- 
2.1.4
