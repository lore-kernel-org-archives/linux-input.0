From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 7/7] Input: xpad: simplify error condition in init_output
Date: Fri, 27 May 2016 02:12:55 +0200
Message-ID: <1464307975-25890-8-git-send-email-rojtberg@gmail.com>
References: <1464307975-25890-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34470 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453AbcE0ANQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 20:13:16 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so9498118wmn.1
        for <linux-input@vger.kernel.org>; Thu, 26 May 2016 17:13:16 -0700 (PDT)
In-Reply-To: <1464307975-25890-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

replace goto with simple returns as we really are just returning one
error code.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 4ecbbbf..2689abe 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -836,7 +836,6 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 {
 	struct usb_endpoint_descriptor *ep_irq_out;
 	int ep_irq_out_idx;
-	int error;
 
 	if (xpad->xtype == XTYPE_UNKNOWN)
 		return 0;
@@ -846,16 +845,15 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 	xpad->odata = usb_alloc_coherent(xpad->udev, XPAD_PKT_LEN,
 					 GFP_KERNEL, &xpad->odata_dma);
 	if (!xpad->odata) {
-		error = -ENOMEM;
-		goto fail1;
+		return -ENOMEM;
 	}
 
 	spin_lock_init(&xpad->odata_lock);
 
 	xpad->irq_out = usb_alloc_urb(0, GFP_KERNEL);
 	if (!xpad->irq_out) {
-		error = -ENOMEM;
-		goto fail2;
+		usb_free_coherent(xpad->udev, XPAD_PKT_LEN, xpad->odata, xpad->odata_dma);
+		return -ENOMEM;
 	}
 
 	/* Xbox One controller has in/out endpoints swapped. */
@@ -870,9 +868,6 @@ static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
 	xpad->irq_out->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
 
 	return 0;
-
- fail2:	usb_free_coherent(xpad->udev, XPAD_PKT_LEN, xpad->odata, xpad->odata_dma);
- fail1:	return error;
 }
 
 static void xpad_stop_output(struct usb_xpad *xpad)
-- 
2.7.4

