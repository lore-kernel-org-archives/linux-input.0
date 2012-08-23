From: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
Subject: [PATCH] hid: Remove duplicate ID for QUANTA 3001 touchscreen
Date: Thu, 23 Aug 2012 11:12:47 +0100
Message-ID: <1345716767-2872-1-git-send-email-simon.farnsworth@onelan.co.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from claranet-outbound-smtp06.uk.clara.net ([195.8.89.39]:53419 "EHLO
	claranet-outbound-smtp06.uk.clara.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752847Ab2HWKMx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Aug 2012 06:12:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@bitmath.se>, Simon Farnsworth <simon.farnsworth@onelan.co.uk>

For some reason, we had two IDs for the QUANTA 3001 touchscreen controller,
one USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001 and one
USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN. As this has caused
confusion, remove USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN
completely, and fix places where it was used to refer to
USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001.

Signed-off-by: Simon Farnsworth <simon.farnsworth@onelan.co.uk>
---
Henrik suggested removing the duplicate IDs from the QUANTA devices.

I've torn out the PIXART one, as we have a vendor ID for PIXART, and I
suspect that it's simply that PIXART sold a rebranded QUANTA device for a
while, and the first example of the QUANTA controller was under PIXART
branding.

 drivers/hid/hid-ids.h           | 1 -
 drivers/hid/usbhid/hid-quirks.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1dcb76f..d615ecb 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -652,7 +652,6 @@
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH		0x3000
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001		0x3001
 #define USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008		0x3008
-#define USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN	0x3001
 
 #define USB_VENDOR_ID_ROCCAT		0x1e7d
 #define USB_DEVICE_ID_ROCCAT_ARVO	0x30d4
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 903eef3..58bd4f2 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -74,7 +74,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN1, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PIXART, USB_DEVICE_ID_PIXART_OPTICAL_TOUCH_SCREEN2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_PRODIGE, USB_DEVICE_ID_PRODIGE_CORDLESS, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_PIXART_IMAGING_INC_OPTICAL_TOUCH_SCREEN, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3001, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_QUANTA, USB_DEVICE_ID_QUANTA_OPTICAL_TOUCH_3008, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
-- 
1.7.11.2

