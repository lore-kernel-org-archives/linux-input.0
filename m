From: Felipe Otamendi <felipe.otamendi@gmail.com>
Subject: [PATCH v2] Input: Fix multitouch support for Type Cover 3
Date: Mon, 20 Apr 2015 00:12:54 -0300
Message-ID: <1429499574-3019-1-git-send-email-felipe.otamendi@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vn0-f44.google.com ([209.85.216.44]:37210 "EHLO
	mail-vn0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752359AbbDTDNM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Apr 2015 23:13:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@gmail.com, Felipe Otamendi <felipe.otamendi@gmail.com>

Make the Type Cover 3 use the hid multitouch driver, which is better suited for the touchpad. Also, since it has multiple reports under the same interface, allow the generic hid driver to handle non-multitouch inputs such as the keyboard's.

Signed-off-by: Felipe Otamendi <felipe.otamendi@gmail.com>
---
 drivers/hid/hid-core.c       | 6 ++----
 drivers/hid/hid-microsoft.c  | 2 --
 drivers/hid/hid-multitouch.c | 8 ++++++++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 56ce8c2..5a80896 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -705,9 +705,8 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
 		hid->group = HID_GROUP_SENSOR_HUB;
 
 	if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
-	    (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
-	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP) &&
-	    hid->group == HID_GROUP_MULTITOUCH)
+		hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP &&
+		hid->group == HID_GROUP_MULTITOUCH)
 		hid->group = HID_GROUP_GENERIC;
 
 	if ((parser->global.usage_page << 16) == HID_UP_GENDESK)
@@ -1878,7 +1877,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index af935eb..c4400a0 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -276,8 +276,6 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
 		.driver_data = MS_DUPLICATE_USAGES },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
-		.driver_data = MS_HIDINPUT },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP),
 		.driver_data = MS_HIDINPUT },
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f65e78b..a4e2b1d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -937,6 +937,9 @@ static void mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		case HID_DG_TOUCHSCREEN:
 			/* we do not set suffix = "Touchscreen" */
 			break;
+		case HID_DG_TOUCHPAD:
+			suffix = "Touchpad";
+			break;
 		case HID_GD_SYSTEM_CONTROL:
 			suffix = "System Control";
 			break;
@@ -1235,6 +1238,11 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
 			USB_DEVICE_ID_ILITEK_MULTITOUCH) },
 
+	/* Microsoft Type Cover 3 */
+	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
+		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
+			USB_DEVICE_ID_MS_TYPE_COVER_3) },
+
 	/* MosArt panels */
 	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
-- 
2.1.0

