From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: quirks: add QUIRK_NOGET for an other TPV touchscreen
Date: Fri, 21 Aug 2015 10:18:08 -0400
Message-ID: <1440166688-4879-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33142 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbbHUOST (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Aug 2015 10:18:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.com>, Blaine Lee <blaine.j.lee@medtronic.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Looks like 0x8882 needs the same quirk than 0x8883.
Given that both devices claim they are "TPV OpticalTouchScreen" rename
the 0x8883 to add its PID in the #define.

Reported-by: Blaine Lee <blaine.j.lee@medtronic.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-ids.h           | 3 ++-
 drivers/hid/usbhid/hid-quirks.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index d6fc680..04dbcea 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -941,7 +941,8 @@
 #define USB_DEVICE_ID_TOUCHPACK_RTS	0x1688
 
 #define USB_VENDOR_ID_TPV		0x25aa
-#define USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN	0x8883
+#define USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN_8882	0x8882
+#define USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN_8883	0x8883
 
 #define USB_VENDOR_ID_TURBOX		0x062a
 #define USB_DEVICE_ID_TURBOX_KEYBOARD	0x0201
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 03decf0..1dff8f0 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -118,7 +118,8 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_SUN, USB_DEVICE_ID_RARITAN_KVM_DONGLE, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_1, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_SYMBOL, USB_DEVICE_ID_SYMBOL_SCANNER_2, HID_QUIRK_NOGET },
-	{ USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN_8882, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_TPV, USB_DEVICE_ID_TPV_OPTICAL_TOUCHSCREEN_8883, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_TURBOX_KEYBOARD, HID_QUIRK_NOGET },
 	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_KNA5, HID_QUIRK_MULTI_INPUT },
 	{ USB_VENDOR_ID_UCLOGIC, USB_DEVICE_ID_UCLOGIC_TABLET_TWA60, HID_QUIRK_MULTI_INPUT },
-- 
2.4.3

