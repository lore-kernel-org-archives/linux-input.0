From: Jordi Pujol <jordipujolp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] usbmouse: random freeze/hangup; synchronize irq completion
Date: Mon, 14 Feb 2011 09:51:00 +0100
Message-ID: <201102140951.00866.jordipujolp@gmail.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0zOWN4au+QJG70S"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

--Boundary-00=_0zOWN4au+QJG70S
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

usbmouse: synchonize the irq completion for each urb.

Without this patch the mouse was a bit erratic and when
using the mouse the system gets freezed/hangup randomly (one or two times a 
day).

Jordi Pujol

Live never ending Tale
GNU/Linux Live forever!
http://livenet.selfip.com

--Boundary-00=_0zOWN4au+QJG70S
Content-Type: text/x-patch;
  charset="UTF-8";
  name="usb_mouse_synchronize irq_urb.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usb_mouse_synchronize irq_urb.patch"

 usbmouse: synchonize the irq completion

Signed-off-by: Jordi Pujol <jordipujolp AT gmail DOT com>

--- linux-2.6.37-old/include/linux/usb.h	2011-01-05 01:50:19.000000000 +0100
+++ linux-2.6.37/include/linux/usb.h	2011-02-10 09:31:30.098752709 +0100
@@ -1214,6 +1214,7 @@ struct urb {
 	int error_count;		/* (return) number of ISO errors */
 	void *context;			/* (in) context for completion */
 	usb_complete_t complete;	/* (in) completion routine */
+	struct mutex		complete_mutex;		/* synchronize completion */
 	struct usb_iso_packet_descriptor iso_frame_desc[0];
 					/* (in) ISO ONLY */
 };
@@ -1250,6 +1251,7 @@ static inline void usb_fill_control_urb(
 	urb->transfer_buffer_length = buffer_length;
 	urb->complete = complete_fn;
 	urb->context = context;
+	mutex_init(&urb->complete_mutex);
 }

 /**
@@ -1279,6 +1281,7 @@ static inline void usb_fill_bulk_urb(str
 	urb->transfer_buffer_length = buffer_length;
 	urb->complete = complete_fn;
 	urb->context = context;
+	mutex_init(&urb->complete_mutex);
 }

 /**
@@ -1326,6 +1329,7 @@ static inline void usb_fill_int_urb(stru
 	else
 		urb->interval = interval;
 	urb->start_frame = -1;
+	mutex_init(&urb->complete_mutex);
 }

 extern void usb_init_urb(struct urb *urb);
--- linux-2.6.37-old/drivers/hid/usbhid/usbmouse.c
+++ linux-2.6.37/drivers/hid/usbhid/usbmouse.c	2011-02-06 16:15:10.432559673 +0100
@@ -66,13 +71,15 @@ static void usb_mouse_irq(struct urb *ur
 	struct input_dev *dev = mouse->dev;
 	int status;

+	mutex_lock(&urb->complete_mutex);
+
 	switch (urb->status) {
 	case 0:			/* success */
 		break;
 	case -ECONNRESET:	/* unlink */
 	case -ENOENT:
 	case -ESHUTDOWN:
-		return;
+		goto out;
 	/* -EPIPE:  should clear the halt */
 	default:		/* error */
 		goto resubmit;
@@ -95,6 +102,9 @@ resubmit:
 		err ("can't resubmit intr, %s-%s/input0, status %d",
 				mouse->usbdev->bus->bus_name,
 				mouse->usbdev->devpath, status);
+
+out:
+	mutex_unlock(&urb->complete_mutex);
 }

 static int usb_mouse_open(struct input_dev *dev)

--Boundary-00=_0zOWN4au+QJG70S--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
