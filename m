From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] HID: multitouch: enable input devices on Surface Book
Date: Wed, 11 May 2016 16:01:33 +0300
Message-ID: <1462971693-21923-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5666 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751481AbcEKNCJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 11 May 2016 09:02:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Microsoft Surface Book has a nulti-functional input device attached to USB as a
HID device, in particular it includes keyboard and touchpad. Enable it here.

The change has been tested on bare metal.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
In v2:
- combine to one patch and remove unneded hunk
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/hid-multitouch.c    | 5 +++++
 drivers/hid/usbhid/hid-quirks.c | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3eec09a1..1bbc795 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -704,6 +704,7 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2  0x07e2
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
 #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
+#define USB_DEVICE_ID_MS_SURFACE_BOOK		0x07cd
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 
 #define USB_VENDOR_ID_MOJO		0x8282
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c741f5e..c3df02d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1377,6 +1377,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
 			USB_DEVICE_ID_ILITEK_MULTITOUCH) },
 
+	/* Microsoft Surface Book */
+	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
+		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
+			USB_DEVICE_ID_MS_SURFACE_BOOK) },
+
 	/* MosArt panels */
 	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index b4b8c6a..6940956 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -99,6 +99,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_SURFACE_BOOK, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
-- 
2.8.1

