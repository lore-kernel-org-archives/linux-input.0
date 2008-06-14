From: Dan Nicholson <dbn.lists@gmail.com>
Subject: [PATCH] HID: Invert HWHEEL mappings for some Logitech mice
Date: Sat, 14 Jun 2008 10:26:24 -0700
Message-ID: <1213464384-4602-1-git-send-email-dbn.lists@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qmta10.westchester.pa.mail.comcast.net ([76.96.62.17]:53243
	"EHLO QMTA10.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750744AbYFNRbZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Jun 2008 13:31:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Some Logitech mice have a tilt wheel which register as HWHEEL buttons.
The events are positive for a click to the right and negative for a
click to the left. Applications expect the opposite, though.

I suspect this affects a lot more Logitech mice, but these are the only
two I have. I tested this using evtest and a GTK application. A similar
Microsoft Intellimouse I have works correctly.

Signed-off-by: Dan Nicholson <dbn.lists@gmail.com>
---
 drivers/hid/usbhid/hid-quirks.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 1df832a..372799f 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -241,6 +241,8 @@
 #define USB_DEVICE_ID_LD_MACHINETEST	0x2040
 
 #define USB_VENDOR_ID_LOGITECH		0x046d
+#define USB_DEVICE_ID_LOGITECH_LX3	0xc044
+#define USB_DEVICE_ID_LOGITECH_V150	0xc047
 #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
 #define USB_DEVICE_ID_LOGITECH_HARMONY  0xc110
 #define USB_DEVICE_ID_LOGITECH_HARMONY_2 0xc111
@@ -593,6 +595,8 @@ static const struct hid_blacklist {
 
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_ELITE_KBD, HID_QUIRK_LOGITECH_IGNORE_DOUBLED_WHEEL | HID_QUIRK_LOGITECH_EXPANDED_KEYMAP },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_CORDLESS_DESKTOP_LX500, HID_QUIRK_LOGITECH_IGNORE_DOUBLED_WHEEL | HID_QUIRK_LOGITECH_EXPANDED_KEYMAP },
+	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_LX3, HID_QUIRK_INVERT_HWHEEL },
+	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_V150, HID_QUIRK_INVERT_HWHEEL },
 
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_NE4K, HID_QUIRK_MICROSOFT_KEYS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_LK6K, HID_QUIRK_MICROSOFT_KEYS },
-- 
1.5.3.2

