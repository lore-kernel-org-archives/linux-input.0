From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/2] HID: multitouch: enable the Surface 3 Type Cover to report multitouch data
Date: Thu, 12 May 2016 16:12:43 +0200
Message-ID: <1463062363-12405-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1463062363-12405-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33477 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751891AbcELOMs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2016 10:12:48 -0400
In-Reply-To: <1463062363-12405-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

There is no reasons to filter out keyboard and consumer control collections
in hid-multitouch.
With the previous hid-input fix, there is now a full support of the Type
Cover and we can remove all specific bits from hid-core and hid-microsoft.

hid-multitouch will automatically set HID_QUIRK_NO_INIT_REPORTS so we can
also remove it from the list of ushbid quirks.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Andy, would you mind checking if this series is sufficient to enable the
TypeCover of the Surface Book?

Cheers,
Benjamin

 drivers/hid/hid-core.c          | 2 --
 drivers/hid/hid-ids.h           | 1 -
 drivers/hid/hid-microsoft.c     | 2 --
 drivers/hid/hid-multitouch.c    | 4 +++-
 drivers/hid/usbhid/hid-quirks.c | 1 -
 5 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 8ea3a26..f055a68 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -727,7 +727,6 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
 	    (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3 ||
 	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2 ||
 	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP ||
-	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
 	     hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
 	    hid->group == HID_GROUP_MULTITOUCH)
 		hid->group = HID_GROUP_GENERIC;
@@ -1976,7 +1975,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_7K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_600) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3KV1) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3eec09a1..99e9852 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -703,7 +703,6 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3    0x07dc
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2  0x07e2
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
-#define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 
 #define USB_VENDOR_ID_MOJO		0x8282
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index e924d55..cf6920b 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -288,8 +288,6 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP),
 		.driver_data = MS_HIDINPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
-		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER),
 		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_KEYBOARD),
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index c741f5e..ac35731 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -835,7 +835,9 @@ static int mt_input_mapping(struct hid_device *hdev, struct hid_input *hi,
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
index b4b8c6a..baf2bad 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -98,7 +98,6 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_QUIRK_NO_INIT_REPORTS },
-	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_NEXIO, USB_DEVICE_ID_NEXIO_MULTITOUCH_PTI0750, HID_QUIRK_NO_INIT_REPORTS },
-- 
2.5.0

