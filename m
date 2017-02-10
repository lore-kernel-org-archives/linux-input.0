From: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] HID: hiddev: allocate minor number hiddev's USB interface is bound to
Date: Fri, 10 Feb 2017 17:09:00 +0900
Message-ID: <1486714140-17081-1-git-send-email-climbbb.kim@gmail.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

When HID device connect to the PC, HID devic driver announces which driver
is loaded with a kernel info message. In this case, hiddev's minor number
is always '0' even though hiddev's real minor number is another one.

To display hiddev with minor number asked from usb core, we need
to fill hiddev's minor number this interface is bound to.

Signed-off-by: Jaejoong Kim <climbbb.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/hid/usbhid/hiddev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/usbhid/hiddev.c b/drivers/hid/usbhid/hiddev.c
index 700145b..27e1f8d 100644
--- a/drivers/hid/usbhid/hiddev.c
+++ b/drivers/hid/usbhid/hiddev.c
@@ -910,6 +910,7 @@ int hiddev_connect(struct hid_device *hid, unsigned int force)
 		kfree(hiddev);
 		return -1;
 	}
+	hid->minor = usbhid->intf->minor;
 	return 0;
 }
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
