From: Yann Cantin <yann.cantin-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: [ebeam PATCH v2 1/2] hid: Blacklist eBeam devices
Date: Sat,  6 Oct 2012 15:14:46 +0200
Message-ID: <1349529287-23193-2-git-send-email-yann.cantin@laposte.net>
References: <1349529287-23193-1-git-send-email-yann.cantin@laposte.net>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1349529287-23193-1-git-send-email-yann.cantin-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yann Cantin <yann.cantin-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


Signed-off-by: Yann Cantin <yann.cantin-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
---
 drivers/hid/hid-core.c |    3 +++
 drivers/hid/hid-ids.h  |    3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index bd3971b..59ffaa2 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1937,6 +1937,9 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
+#if defined(CONFIG_INPUT_EBEAM_USB)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_EFI, USB_DEVICE_ID_EFI_EBEAM) },
+#endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 269b509..df826b8 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -274,6 +274,9 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72D0      0x72d0
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_72C4      0x72c4
 
+#define USB_VENDOR_ID_EFI		0x2650
+#define USB_DEVICE_ID_EFI_EBEAM		0x1311
+
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
 
-- 
1.7.10

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
