From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH] Input: xpad - Don't depend on endpoint order
Date: Sat, 31 Dec 2016 15:43:38 -0500
Message-ID: <1483217018-21150-1-git-send-email-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36018 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753296AbcLaUqP (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 31 Dec 2016 15:46:15 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>

The order of endpoints is well defined on official Xbox pads, but
we have found at least one 3rd-party pad that doesn't follow the
standard ("Titanfall 2 Xbox One controller" 0e6f:0165).

Fortunately, we get lucky with this specific pad because it uses
endpoint addresses that differ only by direction. We know that
there are other pads out where this is not true, so let's go
ahead and fix this.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
 drivers/input/joystick/xpad.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index c7d5b2b..f264d5e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -850,15 +850,11 @@ static void xpad_irq_out(struct urb *urb)
 	spin_unlock_irqrestore(&xpad->odata_lock, flags);
 }
 
-static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
+static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad,
+			struct usb_endpoint_descriptor *ep_irq_out)
 {
-	struct usb_endpoint_descriptor *ep_irq_out;
-	int ep_irq_out_idx;
 	int error;
 
-	if (xpad->xtype == XTYPE_UNKNOWN)
-		return 0;
-
 	init_usb_anchor(&xpad->irq_out_anchor);
 
 	xpad->odata = usb_alloc_coherent(xpad->udev, XPAD_PKT_LEN,
@@ -876,10 +872,6 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 		goto fail2;
 	}
 
-	/* Xbox One controller has in/out endpoints swapped. */
-	ep_irq_out_idx = xpad->xtype == XTYPE_XBOXONE ? 0 : 1;
-	ep_irq_out = &intf->cur_altsetting->endpoint[ep_irq_out_idx].desc;
-
 	usb_fill_int_urb(xpad->irq_out, xpad->udev,
 			 usb_sndintpipe(xpad->udev, ep_irq_out->bEndpointAddress),
 			 xpad->odata, XPAD_PKT_LEN,
@@ -1468,8 +1460,7 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usb_xpad *xpad;
-	struct usb_endpoint_descriptor *ep_irq_in;
-	int ep_irq_in_idx;
+	struct usb_endpoint_descriptor *ep_irq_in, *ep_irq_out;
 	int i, error;
 
 	if (intf->cur_altsetting->desc.bNumEndpoints != 2)
@@ -1539,13 +1530,22 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		goto err_free_in_urb;
 	}
 
-	error = xpad_init_output(intf, xpad);
-	if (error)
+	ep_irq_in = ep_irq_out = NULL;
+	for (i = 0; i < 2; i++) {
+		if (usb_endpoint_dir_in(&intf->cur_altsetting->endpoint[i].desc))
+			ep_irq_in = &intf->cur_altsetting->endpoint[i].desc;
+		else
+			ep_irq_out = &intf->cur_altsetting->endpoint[i].desc;
+	}
+
+	if (!ep_irq_in || !ep_irq_out) {
+		error = -ENODEV;
 		goto err_free_in_urb;
+	}
 
-	/* Xbox One controller has in/out endpoints swapped. */
-	ep_irq_in_idx = xpad->xtype == XTYPE_XBOXONE ? 1 : 0;
-	ep_irq_in = &intf->cur_altsetting->endpoint[ep_irq_in_idx].desc;
+	error = xpad_init_output(intf, xpad, ep_irq_out);
+	if (error)
+		goto err_free_in_urb;
 
 	usb_fill_int_urb(xpad->irq_in, udev,
 			 usb_rcvintpipe(udev, ep_irq_in->bEndpointAddress),
-- 
2.7.4

