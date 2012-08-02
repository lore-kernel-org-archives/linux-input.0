From: Yann Cantin <yann.cantin-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: [RFC ebeam PATCH v2 2/3] hid: hid-core.c: Blackist eBeam classic device.
Date: Thu,  2 Aug 2012 14:59:56 +0200
Message-ID: <1343912397-18353-3-git-send-email-yann.cantin@laposte.net>
References: <1343912397-18353-1-git-send-email-yann.cantin@laposte.net>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1343912397-18353-1-git-send-email-yann.cantin-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yann Cantin <yann.cantin-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


Signed-off-by: Yann Cantin <yann.cantin-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
---
 drivers/hid/hid-core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 60ea284..b1ed8ee 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1908,6 +1908,9 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
+#if defined(CONFIG_INPUT_EBEAM_USB)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_EFI, USB_DEVICE_ID_EFI_CLASSIC) },
+#endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
-- 
1.7.10

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
