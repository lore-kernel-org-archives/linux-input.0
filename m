From: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
Subject: [PATCH 2/3] usbtouchscreen: Implement runtime power management
Date: Thu, 15 Jul 2010 15:56:38 +0200
Message-ID: <201007151556.38810.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

>From 71b07110871d7b9e754a3b56f3e914745c329be6 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date: Thu, 24 Jun 2010 08:38:57 +0200
Subject: [PATCH 2/3] usbtouchscreen: Implement runtime power management

This implement USB autosuspend while the device is opened for
devices that do remote wakeup with a fallback to open/close for
those devices that don't. Devices that require the host to
constantly poll them are never autosuspended.

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>
---
 drivers/input/touchscreen/usbtouchscreen.c |   27 ++++++++++++++++++++++++---
 1 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index f51d2fd..3c57df8 100644
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
@@ -1450,8 +1467,11 @@ static int usbtouch_probe(struct usb_interface *intf,
 	usb_set_intfdata(intf, usbtouch);
 
 	if (usbtouch->type->irq_always) {
+		/* this can't fail */
+		usb_autopm_get_interface(intf);
 		err = usb_submit_urb(usbtouch->irq, GFP_KERNEL);
 		if (err) {
+			usb_autopm_put_interface(intf);
 			err("%s - usb_submit_urb failed with result: %d",
 			    __func__, err);
 			goto out_unregister_input;
@@ -1505,6 +1525,7 @@ static struct usb_driver usbtouch_driver = {
 	.suspend	= usbtouch_suspend,
 	.resume		= usbtouch_resume,
 	.id_table	= usbtouch_devices,
+	.supports_autosuspend = 1,
 };
 
 static int __init usbtouch_init(void)
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
