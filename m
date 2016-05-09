From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] HID: usbhid: enable keyboard on Surface Book
Date: Mon,  9 May 2016 17:50:40 +0300
Message-ID: <1462805440-72759-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:12353 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750919AbcEIOup (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 9 May 2016 10:50:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Microsoft Surface Book has a keyboard attached to USB as a HID device.
Enable it here.

The change has been tested on bare metal.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-core.c          | 1 +
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/usbhid/hid-quirks.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8ea3a26..dac091d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -728,6 +728,7 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
 	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2 ||
 	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP ||
 	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
+	     hid->product == USB_DEVICE_ID_MS_SURFACE_BOOK ||
 	     hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
 	    hid->group == HID_GROUP_MULTITOUCH)
 		hid->group = HID_GROUP_GENERIC;
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

