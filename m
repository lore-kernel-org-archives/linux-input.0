From: Akihiko Odaki <akihiko.odaki.4i-0UtvDL+eMPseNZI6UXDsdg@public.gmane.org>
Subject: [PATCH 1/2] HID: Use multitouch driver for Type Covers
Date: Mon, 14 Dec 2015 21:50:28 +0900
Message-ID: <1450097429-4959-1-git-send-email-akihiko.odaki.4i@stu.hosei.ac.jp>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Akihiko Odaki <akihiko.odaki.4i-0UtvDL+eMPseNZI6UXDsdg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Use multitouch driver instead of microsoft one for Microsoft Surface
Type Covers.

By using MT_CLS_EXPORT_ALL_INPUTS, the keyboards function as well as
the multitouch pads do.

Signed-off-by: Akihiko Odaki <akihiko.odaki.4i-0UtvDL+eMPseNZI6UXDsdg@public.gmane.org>
---
 drivers/hid/hid-core.c       | 14 --------------
 drivers/hid/hid-microsoft.c  | 10 ----------
 drivers/hid/hid-multitouch.c | 17 +++++++++++++++++
 3 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index c6f7a69..43afc55 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -723,15 +723,6 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
 	    type == HID_COLLECTION_PHYSICAL)
 		hid->group = HID_GROUP_SENSOR_HUB;
 
-	if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
-	    (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3 ||
-	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2 ||
-	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP ||
-	     hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
-	     hid->product == USB_DEVICE_ID_MS_POWER_COVER) &&
-	    hid->group == HID_GROUP_MULTITOUCH)
-		hid->group = HID_GROUP_GENERIC;
-
 	if ((parser->global.usage_page << 16) == HID_UP_GENDESK)
 		for (i = 0; i < parser->local.usage_index; i++)
 			if (parser->local.usage[i] == HID_GD_POINTER)
@@ -1933,11 +1924,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_NTRIG, USB_DEVICE_ID_NTRIG_TOUCH_SCREEN) },
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index 77a2cf3..0dbc2a0 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -276,16 +276,6 @@ static const struct hid_device_id ms_devices[] = {
 		.driver_data = MS_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
 		.driver_data = MS_DUPLICATE_USAGES },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3),
-		.driver_data = MS_HIDINPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2),
-		.driver_data = MS_HIDINPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP),
-		.driver_data = MS_HIDINPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
-		.driver_data = MS_HIDINPUT },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER),
-		.driver_data = MS_HIDINPUT },
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT),
 		.driver_data = MS_PRESENTER },
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 3d664d0..dfc2698 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1330,6 +1330,23 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
 			USB_DEVICE_ID_ILITEK_MULTITOUCH) },
 
+	/* Microsoft Surface Typecover */
+	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
+		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
+			USB_DEVICE_ID_MS_TYPE_COVER_PRO_3) },
+	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
+		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
+			USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2) },
+	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
+		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
+			USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
+	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
+		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
+			USB_DEVICE_ID_MS_TYPE_COVER_3) },
+	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
+		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
+			USB_DEVICE_ID_MS_POWER_COVER) },
+
 	/* MosArt panels */
 	{ .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
 		MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
