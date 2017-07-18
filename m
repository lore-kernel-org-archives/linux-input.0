From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: ortek: add one more buggy device
Date: Tue, 18 Jul 2017 18:28:13 +0200
Message-ID: <20170718162813.4226-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54500 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751348AbdGRQ2X (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Jul 2017 12:28:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Mairin Duffy <duffy@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

The iHome keypad also requires the same tweak we are doing for other
Ortek devices.

Reported-by: Mairin Duffy <duffy@redhat.com>

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-core.c  | 1 +
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-ortek.c | 6 ++++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 74af0b3..b8e7d31 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2220,6 +2220,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 #if IS_ENABLED(CONFIG_HID_ORTEK)
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_PKB1700) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_IHOME_IMAC_A210S) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SKYCABLE, USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER) },
 #endif
 #if IS_ENABLED(CONFIG_HID_PANTHERLORD)
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 021ab80..5560978 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -828,6 +828,7 @@
 #define USB_VENDOR_ID_ORTEK		0x05a4
 #define USB_DEVICE_ID_ORTEK_PKB1700	0x1700
 #define USB_DEVICE_ID_ORTEK_WKB2000	0x2000
+#define USB_DEVICE_ID_ORTEK_IHOME_IMAC_A210S	0x8003
 
 #define USB_VENDOR_ID_PLANTRONICS	0x047f
 
diff --git a/drivers/hid/hid-ortek.c b/drivers/hid/hid-ortek.c
index 6620f15..8783a06 100644
--- a/drivers/hid/hid-ortek.c
+++ b/drivers/hid/hid-ortek.c
@@ -5,6 +5,7 @@
  *
  *    Ortek PKB-1700
  *    Ortek WKB-2000
+ *    iHome IMAC-A210S
  *    Skycable wireless presenter
  *
  *  Copyright (c) 2010 Johnathon Harris <jmharris@gmail.com>
@@ -28,10 +29,10 @@ static __u8 *ortek_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
 	if (*rsize >= 56 && rdesc[54] == 0x25 && rdesc[55] == 0x01) {
-		hid_info(hdev, "Fixing up logical minimum in report descriptor (Ortek)\n");
+		hid_info(hdev, "Fixing up logical maximum in report descriptor (Ortek)\n");
 		rdesc[55] = 0x92;
 	} else if (*rsize >= 54 && rdesc[52] == 0x25 && rdesc[53] == 0x01) {
-		hid_info(hdev, "Fixing up logical minimum in report descriptor (Skycable)\n");
+		hid_info(hdev, "Fixing up logical maximum in report descriptor (Skycable)\n");
 		rdesc[53] = 0x65;
 	}
 	return rdesc;
@@ -40,6 +41,7 @@ static __u8 *ortek_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 static const struct hid_device_id ortek_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_PKB1700) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_WKB2000) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_ORTEK, USB_DEVICE_ID_ORTEK_IHOME_IMAC_A210S) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SKYCABLE, USB_DEVICE_ID_SKYCABLE_WIRELESS_PRESENTER) },
 	{ }
 };
-- 
2.9.4

