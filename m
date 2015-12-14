From: Akihiko Odaki <akihiko.odaki.4i-0UtvDL+eMPseNZI6UXDsdg@public.gmane.org>
Subject: [PATCH 2/2] HID: Add new Japanese Surface 3 Pro Type Cover
Date: Mon, 14 Dec 2015 21:50:29 +0900
Message-ID: <1450097429-4959-2-git-send-email-akihiko.odaki.4i@stu.hosei.ac.jp>
References: <1450097429-4959-1-git-send-email-akihiko.odaki.4i@stu.hosei.ac.jp>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1450097429-4959-1-git-send-email-akihiko.odaki.4i-0UtvDL+eMPseNZI6UXDsdg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Akihiko Odaki <akihiko.odaki.4i-0UtvDL+eMPseNZI6UXDsdg@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Add support for the new Japanese version of Microsoft Surface 3 Pro
Type Cover.

Signed-off-by: Akihiko Odaki <akihiko.odaki.4i-0UtvDL+eMPseNZI6UXDsdg@public.gmane.org>
---
 drivers/hid/hid-ids.h           | 1 +
 drivers/hid/hid-multitouch.c    | 3 +++
 drivers/hid/usbhid/hid-quirks.c | 1 +
 3 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8b78a7f..a12e392 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -683,6 +683,7 @@
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3    0x07dc
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2  0x07e2
 #define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP 0x07dd
+#define USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2_JP	0x07e3
 #define USB_DEVICE_ID_MS_TYPE_COVER_3    0x07de
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
 
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index dfc2698..b5e040d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1342,6 +1342,9 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP) },
 	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
 		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
+			USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2_JP) },
+	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
+		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
 			USB_DEVICE_ID_MS_TYPE_COVER_3) },
 	{ .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
 		MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index 7dd0953..50a57d0 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -91,6 +91,7 @@ static const struct hid_blacklist {
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_JP, HID_QUIRK_NO_INIT_REPORTS },
+	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_PRO_3_2_JP, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_POWER_COVER, HID_QUIRK_NO_INIT_REPORTS },
 	{ USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL, HID_QUIRK_NO_INIT_REPORTS },
-- 
2.6.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
