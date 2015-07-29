From: Calvin Cochran <cochran.calvin@gmail.com>
Subject: [PATCH] Fixes Mayflash 4-port Gamecube adapter's PC mode
Date: Tue, 28 Jul 2015 19:38:19 -0500
Message-ID: <1438130299-14700-1-git-send-email-cochran.calvin@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36469 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752242AbbG2Aio (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 28 Jul 2015 20:38:44 -0400
Received: by obnw1 with SMTP id w1so97117514obn.3
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2015 17:38:43 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Calvin Cochran <cochran.calvin@gmail.com>

From: Calvin Cochran <cochran.calvin@gmail.com>

Enabling HID_QUIRK_MULTI_INPUT allows the adapter to correctly report
its 4 joystick inputs and stops it from acting like a mouse.

This patch was originially submitted by Andrew Rodland on
04 February 2015, but upon cursory inspection of the mailing list
archives, it seems no one ever followed up on it. If there's something
I need to do to make sure he gets credit for the patch, please let
me know. Thanks!

Signed-off-by: Calvin Cochran <cochran.calvin@gmail.com>
---
 drivers/hid/hid-ids.h           | 3 ++-
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b04b082..f91223c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -279,7 +279,8 @@
 #define USB_VENDOR_ID_DMI		0x0c0b
 #define USB_DEVICE_ID_DMI_ENC		0x5fab
 
-#define USB_VENDOR_ID_DRAGONRISE	0x0079
+#define USB_VENDOR_ID_DRAGONRISE		0x0079
+#define USB_DEVICE_ID_DRAGONRISE_GAMECUBE	0x1843
 
 #define USB_VENDOR_ID_DWAV		0x0eef
 #define USB_DEVICE_ID_EGALAX_TOUCHCONTROLLER	0x0001
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 20f9a65..cf14cff 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -71,6 +71,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_CH, USB_DEVICE_ID_CH_AXIS_295, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_CHICONY_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_009B, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_ELAN, USB_DEVICE_ID_ELAN_TOUCHSCREEN_0103, HID_QUIRK_ALWAYS_POLL },
-- 
2.1.4

