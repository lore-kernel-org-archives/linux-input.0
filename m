From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [patch]unnecessary GFP_ATOMIC in xpad driver
Date: Thu, 3 Apr 2008 13:50:15 +0200
Message-ID: <200804031350.16684.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jikos-AlSwsSmVLrQ@public.gmane.org, honza-wDf7oJUeT2I@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

GFP_ATOMIC should not be used when GFP_KERNEL can be used.

Signed-off-by: Oliver Neukum <oneukum-l3A5Bk7waGM@public.gmane.org>

---

--- linux-2.6.25-rc7-work/drivers/input/joystick/xpad.c.2	2008-04-03 13:29:55.000000000 +0200
+++ linux-2.6.25-rc7-work/drivers/input/joystick/xpad.c	2008-04-03 13:30:01.000000000 +0200
@@ -412,7 +412,7 @@ static int xpad_init_output(struct usb_i
 		return 0;
 
 	xpad->odata = usb_buffer_alloc(xpad->udev, XPAD_PKT_LEN,
-				       GFP_ATOMIC, &xpad->odata_dma );
+				       GFP_KERNEL, &xpad->odata_dma );
 	if (!xpad->odata)
 		goto fail1;
 
@@ -636,7 +636,7 @@ static int xpad_probe(struct usb_interfa
 		goto fail1;
 
 	xpad->idata = usb_buffer_alloc(udev, XPAD_PKT_LEN,
-				       GFP_ATOMIC, &xpad->idata_dma);
+				       GFP_KERNEL, &xpad->idata_dma);
 	if (!xpad->idata)
 		goto fail1;
 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
