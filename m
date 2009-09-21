From: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Subject: [patch]fix usbhid using GFP_KERNEL in interrupt
Date: Mon, 21 Sep 2009 22:25:48 +0200
Message-ID: <200909212225.48513.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Henk Martijn <h.h.martijn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg KH <gregkh-l3A5Bk7waGM@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

hid:usbhid: fix wrong use of GFP_KERNEL
    
hid_input_report() must be told it is called in interrupt context

Signed-off-by: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>

Hi Jiri, Greg,

this should go into the current tree and the stable tree.

	Regards
		Oliver

--
commit ca5c4a1397d1a1c0d1074f4d8922630fdd732780
Author: Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>
Date:   Mon Sep 21 22:02:01 2009 +0200

    hid:usbhid: fix wrong use of GFP_KERNEL
    
    hid_input_report() must be told it is called in interrupt context

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 1b0e07a..ab2869d 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -455,7 +455,7 @@ static void hid_ctrl(struct urb *urb)
 		if (usbhid->ctrl[usbhid->ctrltail].dir == USB_DIR_IN)
 			hid_input_report(urb->context,
 				usbhid->ctrl[usbhid->ctrltail].report->type,
-				urb->transfer_buffer, urb->actual_length, 0);
+				urb->transfer_buffer, urb->actual_length, 1);
 		break;
 	case -ESHUTDOWN:	/* unplug */
 		unplug = 1;

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
