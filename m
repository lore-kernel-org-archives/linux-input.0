From: Stephen Just <stephenjust@gmail.com>
Subject: [PATCH v2] HID: microsoft: Add Surface 3 type cover
Date: Wed, 22 Jul 2015 20:11:40 -0700
Message-ID: <1437621100-9620-1-git-send-email-stephenjust@gmail.com>
References: <1437334518-17991-1-git-send-email-stephenjust@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34295 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753361AbbGWDMH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Jul 2015 23:12:07 -0400
Received: by pacan13 with SMTP id an13so150541790pac.1
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2015 20:12:06 -0700 (PDT)
In-Reply-To: <1437334518-17991-1-git-send-email-stephenjust@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Stephen Just <stephenjust@gmail.com>, jkosina@suse.cz

Adding support for the Microsoft Surface 3 (non-pro) Type Cover.

The existing definitions and quirks are actually for the Surface
Pro 3 type covers. I've renamed the old constants to reflect that
they belong to the Surface Pro 3, and added a new constant and
matching code for the Surface 3.

Signed-off-by: Stephen Just <stephenjust@gmail.com>
---
 drivers/hid/hid-core.c          | 8 +++++---
 drivers/hid/hid-ids.h           | 5 +++--
 drivers/hid/hid-microsoft.c     | 6 ++++--
 drivers/hid/usbhid/hid-quirks.c | 3 ++-
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 157c627..d9c7cd9 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -705,8 +705,9 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
 		hid->group = HID_GROUP_SENSOR_HUB;
 
 	if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
-	    (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
-	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP ||
+	    (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3 ||
+	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP ||
+	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
 	     hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
 	    hid->group == HID_GROUP_MULTITOUCH)
 		hid->group = HID_GROUP_GENERIC;
@@ -1902,8 +1903,9 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index b04b082..8dab4b2 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -663,8 +663,9 @@
 #define USB_DEVICE_ID_MS_SURFACE_PRO_2   0x0799
 #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
-#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07dc
-#define USB_DEVICE_ID_MS_TYPE_COVER_3_JP 0x07dd
+#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3    0x07dc
+#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
+#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 
 #define USB_VENDOR_ID_MOJO		0x8282
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 32a596f..9aa3515 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -276,9 +276,11 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
 		.driver_data = MS_DUPLICATE_USAGES },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3),
+		.driver_data = MS_HIDINPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP),
 		.driver_data = MS_HIDINPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP),
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
 		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER),
 		.driver_data = MS_HIDINPUT },
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 53e7de7..198e266 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -87,8 +87,9 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C05A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_MOUSE_C06A, HID_QUIRK_ALWAYS_POLL },
 	{ USB_VENDOR_ID_MGE, USB_DEVICE_ID_MGE_UPS, HID_QUIRK_NOGET },
+	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
-- 
2.4.6

