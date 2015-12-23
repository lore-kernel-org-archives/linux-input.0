From: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
Subject: [PATCH 4/4] HID: usbhid: use to_usb_device
Date: Wed, 23 Dec 2015 21:26:53 +0800
Message-ID: <639acbe1bd1388d007c88b80041807c2d8f48bf2.1450876612.git.geliangtang@163.com>
References: <41e4a06ba4bb1f35c195c7ea66071953600ca930.1450876612.git.geliangtang@163.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <41e4a06ba4bb1f35c195c7ea66071953600ca930.1450876612.git.geliangtang-9Onoh4P/yGk@public.gmane.org>
In-Reply-To: <41e4a06ba4bb1f35c195c7ea66071953600ca930.1450876612.git.geliangtang-9Onoh4P/yGk@public.gmane.org>
References: <41e4a06ba4bb1f35c195c7ea66071953600ca930.1450876612.git.geliangtang-9Onoh4P/yGk@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Use to_usb_device() instead of open-coding it.

Signed-off-by: Geliang Tang <geliangtang-9Onoh4P/yGk@public.gmane.org>
---
 drivers/hid/usbhid/usbhid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/usbhid/usbhid.h b/drivers/hid/usbhid/usbhid.h
index 807922b..fa47d66 100644
--- a/drivers/hid/usbhid/usbhid.h
+++ b/drivers/hid/usbhid/usbhid.h
@@ -96,7 +96,7 @@ struct usbhid_device {
 };
 
 #define	hid_to_usb_dev(hid_dev) \
-	container_of(hid_dev->dev.parent->parent, struct usb_device, dev)
+	to_usb_device(hid_dev->dev.parent->parent)
 
 #endif
 
-- 
2.5.0


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
