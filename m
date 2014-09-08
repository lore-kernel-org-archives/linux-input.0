From: Oliver Neukum <oneukum@suse.de>
Subject: [PATCH] usbhid: fix PIXART optical mouse
Date: Mon,  8 Sep 2014 11:21:49 +0200
Message-ID: <1410168109-16005-1-git-send-email-oneukum@suse.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51754 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103AbaIHJVy (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Sep 2014 05:21:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.com, linux-input@vger.kernel.org, johan@kernel.org
Cc: Oliver Neukum <oneukum@suse.de>

This mouse keeps disconnecting in runlevel 3. It needs the
ALWAYS_POLL quirk.

Signed-off-by: Oliver Neukum <oneukum@suse.de>
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0d2e07d..c2aca75 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -736,6 +736,7 @@
 #define USB_DEVICE_ID_PI_ENGINEERING_VEC_USB_FOOTPEDAL	0xff
 
 #define USB_VENDOR_ID_PIXART				0x093a
+#define USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE		0x2510
 #define USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN	0x8001
 #define USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1	0x8002
 #define USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN2	0x8003
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index ca18136..8c97e63 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -80,6 +80,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_NOVATEK, USB_DEVICE_ID_NOVATEK_MOUSE, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1610, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_PENMOUNT, USB_DEVICE_ID_PENMOUNT_1640, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_USB_OPTICAL_MOUSE, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN2, HID_QUIRK_NO_INIT_REPORTS },
-- 
1.8.4.5

