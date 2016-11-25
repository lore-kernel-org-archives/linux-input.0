From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 3/3] HID: multitouch: enable the Surface 3 Type Cover to report multitouch data
Date: Fri, 25 Nov 2016 14:27:23 +0100
Message-ID: <1480080443-7636-4-git-send-email-benjamin.tissoires@redhat.com>
References: <1480080443-7636-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36910 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753663AbcKYN1d (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Nov 2016 08:27:33 -0500
In-Reply-To: <1480080443-7636-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Dennis Chen <barracks510@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

There is no reasons to filter out keyboard and consumer control collections
in hid-multitouch.
With the previous hid-input fix, there is now a full support of the Type
Cover and we can remove all specific bits from hid-core and hid-microsoft.

hid-multitouch will automatically set HID_QUIRK_NO_INIT_REPORTS so we can
also remove it from the list of ushbid quirks.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2 (was 2/3)
---
 drivers/hid/hid-core.c          | 2 --
 drivers/hid/hid-ids.h           | 1 -
 drivers/hid/hid-microsoft.c     | 2 --
 drivers/hid/hid-multitouch.c    | 4 +++-
 drivers/hid/usbhid/hid-quirks.c | 1 -
 5 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c961cf1..e5356dc 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -730,7 +730,6 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
 	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4 ||
 	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2 ||
 	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP ||
-	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
 	     hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
 	    hid->group == HID_GROUP_MULTITOUCH)
 		hid->group = HID_GROUP_GENERIC;
@@ -1992,7 +1991,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_600) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3KV1) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index dca49cf2..a27a26c 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -724,7 +724,6 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4 0x07e4
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2 0x07e8
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP 0x07e9
-#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 
 #define USB_VENDOR_ID_MOJO		0x8282
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 5e592f0..74b7b84 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -286,8 +286,6 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP),
 		.driver_data = MS_HIDINPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
-		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER),
 		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_KEYBOARD),
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 8979359..6dca668 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -848,7 +848,9 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (!td->mtclass.export_all_inputs &&
 	    field->application != HID_DG_TOUCHSCREEN &&
 	    field->application != HID_DG_PEN &&
-	    field->application != HID_DG_TOUCHPAD)
+	    field->application != HID_DG_TOUCHPAD &&
+	    field->application != HID_GD_KEYBOARD &&
+	    field->application != HID_CP_CONSUMER_CONTROL)
 		return -1;
 
 	/*
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index d807670..b3e01c8 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -106,7 +106,6 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_4_JP, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
-- 
2.7.4

