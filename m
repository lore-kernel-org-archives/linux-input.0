From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [RFC/RFT 2/5] USB: usbtouch: Implement reset_resume()
Date: Fri, 12 Mar 2010 15:42:11 +0100
Message-ID: <201003121542.11340.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

>From 6771256d8fe7540e747fe45a4b3529c5466c09b7 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Thu, 11 Mar 2010 15:00:40 +0100
Subject: [PATCH 2/5] USB: usbtouch: Implement reset_resume()

In reset_resume() redo model specific init and then do a resume

Signed-off-by: Oliver Neukum <neukum-shG/GajIFYqbacvFa/9K2g@public.gmane.org>
---
 drivers/input/touchscreen/usbtouchscreen.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 6db0a03..8836761 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1310,6 +1310,26 @@ static int usbtouch_resume(struct usb_interface *intf)
 	return rv;
 }
 
+static int usbtouch_reset_resume(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+	int rv;
+
+	/* device specific init */
+	if (usbtouch->type->init) {
+		rv = usbtouch->type->init(usbtouch);
+		if (rv) {
+			dbg("%s - type->init() failed, err: %d", __func__, rv);
+			goto err_out;
+		}
+	}
+	
+	rv = usbtouch_resume(intf);
+
+err_out:
+	return rv;
+}
+
 static void usbtouch_free_buffers(struct usb_device *udev,
 				  struct usbtouch_usb *usbtouch)
 {
@@ -1501,6 +1521,7 @@ static struct usb_driver usbtouch_driver = {
 	.disconnect	= usbtouch_disconnect,
 	.suspend	= usbtouch_suspend,
 	.resume		= usbtouch_resume,
+	.reset_resume	= usbtouch_reset_resume,
 	.id_table	= usbtouch_devices,
 };
 
-- 
1.6.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
