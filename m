From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH] HID: microsoft: Add Surface Pro 4 type cover support
Date: Thu, 01 Dec 2016 19:17:13 +0800
Message-ID: <1480591033.2670.2.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:35614 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755946AbcLALRQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 1 Dec 2016 06:17:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input <linux-input@vger.kernel.org>

>From edb2fc779c3e9c118686a3c177cfa304e95e0220 Mon Sep 17 00:00:00 2001
From: Zhang Rui <rui.zhang@intel.com>
Date: Wed, 30 Nov 2016 20:09:11 +0800
Subject: [PATCH] HID: microsoft: Add Surface Pro 4 type cover support

Adding support for the Microsoft Surface Pro 4 Type Cover.

This patch has been tested on my surface pro 4,
keyboard starts working, while the touchpad does not.

I don't know which type of surface pro 4 I have, but the lsusb output
shows it's ID is 07e8, and I use USB_DEVICE_ID_MS_TYPE_COVER_4_1 as
the name, following the patch at
https://bugzilla.kernel.org/show_bug.cgi?id=135561#c0

At the same time, this patch also fixes a long suspend/resume delay
problem when type cover is attached.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=135561
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=186181
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hid/hid-core.c          | 2 ++
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/hid-microsoft.c     | 2 ++
 drivers/hid/usbhid/hid-quirks.c | 1 +
 4 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 2b89c70..3c4085d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -728,6 +728,7 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
 	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2 ||
 	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP ||
 	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP ||
+	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_1 ||
 	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
 	     hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
 	    hid->group == HID_GROUP_MULTITOUCH)
@@ -1984,6 +1985,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_1) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_600) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 575aa65..fe19866 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -719,6 +719,7 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2  0x07e2
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP 0x07e9
+#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_1 0x07e8
 #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index c6cd392..df06e6c 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -282,6 +282,8 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP),
 		.driver_data = MS_HIDINPUT },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_1),
+		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
 		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER),
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index e6cfd32..48d0ce8 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -102,6 +102,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_1, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
-- 
2.7.4

