From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/3] usbtouchscreen: Implement runtime power management
Date: Mon, 7 Jun 2010 15:13:42 +0200
Message-ID: <201006071513.42714.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>
List-Id: linux-input@vger.kernel.org

>From 6a5112cb162bf9075a4ad65692494465f5ced331 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Mon, 7 Jun 2010 12:55:39 +0200
Subject: [PATCH 2/3] usbtouchscreen: Implement runtime power management

This implement USB autosuspend while the device is opened for
devices that do remote wakeup with a fallback to open/close for
those devices that don't.

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
---
 drivers/input/touchscreen/usbtouchscreen.c |   24 +++++++++++++++++++++---
 1 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 6d23c0e..0c2d7c1 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1263,6 +1263,7 @@ static void usbtouch_irq(struct urb *urb)
 	usbtouch->type->process_pkt(usbtouch, usbtouch->data, urb->actual_length);
 
 exit:
+	usb_mark_last_busy(interface_to_usbdev(usbtouch->interface));
 	retval = usb_submit_urb(urb, GFP_ATOMIC);
 	if (retval)
 		err("%s - usb_submit_urb failed with result: %d",
@@ -1272,23 +1273,39 @@ exit:
 static int usbtouch_open(struct input_dev *input)
 {
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
+	int r;
 
 	usbtouch->irq->dev = interface_to_usbdev(usbtouch->interface);
 
+	r = usb_autopm_get_interface(usbtouch->interface) ? -EIO : 0;
+	if (r < 0)
+		goto out;
+	
 	if (!usbtouch->type->irq_always) {
-		if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
-		  return -EIO;
+		if (usb_submit_urb(usbtouch->irq, GFP_KERNEL)) {
+			r = -EIO;
+			goto out_put;
+		}
 	}
 
-	return 0;
+	usbtouch->interface->needs_remote_wakeup = 1;
+out_put:
+	usb_autopm_put_interface(usbtouch->interface);
+out:
+	return r;
 }
 
 static void usbtouch_close(struct input_dev *input)
 {
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
+	int r;
 
 	if (!usbtouch->type->irq_always)
 		usb_kill_urb(usbtouch->irq);
+	r = usb_autopm_get_interface(usbtouch->interface);
+	usbtouch->interface->needs_remote_wakeup = 0;
+	if (!r)
+		usb_autopm_put_interface(usbtouch->interface);
 }
 
 static int usbtouch_suspend
@@ -1505,6 +1522,7 @@ static struct usb_driver usbtouch_driver = {
 	.suspend	= usbtouch_suspend,
 	.resume		= usbtouch_resume,
 	.id_table	= usbtouch_devices,
+	.supports_autosuspend = 1,
 };
 
 static int __init usbtouch_init(void)
-- 
1.6.4.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
