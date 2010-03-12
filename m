From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [RFC/RFT 5/5] USB: usbtouch: autosuspend for active touchscreens
Date: Fri, 12 Mar 2010 15:44:13 +0100
Message-ID: <201003121544.13173.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

>From e8d77319b208e06e66ea89efc9780f0c7c7690c6 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Thu, 11 Mar 2010 15:40:54 +0100
Subject: [PATCH 5/5] USB: usbtouch: autosuspend for active touchscreens

USB autosuspend with all bells and whistles.

Signed-off-by: Oliver Neukum <neukum-shG/GajIFYqbacvFa/9K2g@public.gmane.org>
---
 drivers/input/touchscreen/usbtouchscreen.c |   33 +++++++++++++++++++--------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index cc0eb7c..f89036a 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1260,6 +1260,7 @@ static void usbtouch_irq(struct urb *urb)
 	usbtouch->type->process_pkt(usbtouch, usbtouch->data, urb->actual_length);
 
 exit:
+	usb_mark_last_busy(interface_to_usbdev(usbtouch->interface));
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
 	if (retval)
 		err("%s - usb_submit_urb failed with result: %d",
@@ -1269,36 +1270,48 @@ exit:
 static int usbtouch_open(struct input_dev *input)
 {
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
-	int r;
+	int rv = 0;
 
 	usbtouch->irq->dev = interface_to_usbdev(usbtouch->interface);
 	
-	r = usb_autopm_get_interface(usbtouch->interface);
-	if (r < 0)
+	rv = usb_autopm_get_interface(usbtouch->interface);
+	if (rv < 0)
 		goto err_out;
 
 	if (!usbtouch->type->irq_always) {
-		if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
-		  goto err_out_revert;
+		rv = usb_submit_urb(usbtouch->irq, GFP_KERNEL);
+		if (rv < 0)
+			goto err_out_revert;
 		usbtouch->submitted = true;
 	}
-
-	return 0;
+	usbtouch->interface->needs_remote_wakeup = 1;
 
 err_out_revert:
 	usb_autopm_put_interface(usbtouch->interface);
 err_out:
-	return -EIO;
+	return rv < 0 ? -EIO : 0;
 }
 
 static void usbtouch_close(struct input_dev *input)
 {
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
+	int r;
 
 	usbtouch->submitted = false;
-	if (!usbtouch->type->irq_always)
+
+	/*
+	 * if the irq needs to be kept running we know remote
+	 * wakeup will be needed and as it is requested at this
+	 * time we do nothing
+	 */
+	if (!usbtouch->type->irq_always) {
 		usb_kill_urb(usbtouch->irq);
-	usb_autopm_put_interface(usbtouch->interface);
+		r = usb_autopm_get_interface(usbtouch->interface);
+		if (r == 0) {
+			usbtouch->interface->needs_remote_wakeup = 0;
+			usb_autopm_put_interface(usbtouch->interface);
+		}
+	}
 }
 
 static int usbtouch_suspend(struct usb_interface *intf, pm_message_t message)
-- 
1.6.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
