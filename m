From: Benjamin Valentin <benpicco@zedat.fu-berlin.de>
Subject: [PATCH][resubmit] xpad.c: Add rumble support for original xbox
 controller
Date: Wed, 20 Jan 2010 01:04:06 +0100
Message-ID: <20100120010406.54a11bc6@rechenknecht2k7>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:33992 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751458Ab0ATAZO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Jan 2010 19:25:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hi,
Seems like this got lost somehow, I also did some minor coding style
changes to better comply with the kernel standards.
Since this is a patch against Linux 2.6.33-rc4, I've also added the fix
from [1].

[1]
http://git.kernel.org/gitweb.cgi?p=linux/kernel/git/dtor/input.git;a=blobdiff;f=drivers/input/joystick/xpad.c;h=8a28fb7846dc1f16a18a064b6cc631d2ca82afa4;hp=482cb1204e438e8cadc4c488b8e3ede398f998fa;hb=dd38d6889dc5dae2014d9eac72fae32f477f294e;hpb=e4e6efd2df4b5754bd519b516207eb723d1f17df

This patch adds rumble support for xbox 1 compatible controllers.

Signed-off-by: Benjamin Valentin <benpicco@zedat.fu-berlin.de>

--- a/drivers/input/joystick/xpad.c	2010-01-13 21:35:35.081651802 +0100
+++ b/drivers/input/joystick/xpad.c	2010-01-13 22:02:29.313757056 +0100
@@ -446,7 +446,7 @@ static void xpad_irq_in(struct urb *urb)
 	}
 
 exit:
-	retval = usb_submit_urb (urb, GFP_ATOMIC);
+	retval = usb_submit_urb(urb, GFP_ATOMIC);
 	if (retval)
 		err ("%s - usb_submit_urb failed with result %d",
 		     __func__, retval);
@@ -505,7 +505,7 @@ static int xpad_init_output(struct usb_i
 	struct usb_endpoint_descriptor *ep_irq_out;
 	int error = -ENOMEM;
 
-	if (xpad->xtype != XTYPE_XBOX360)
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX)
 		return 0;
 
 	xpad->odata = usb_buffer_alloc(xpad->udev, XPAD_PKT_LEN,
@@ -535,13 +535,13 @@ static int xpad_init_output(struct usb_i
 
 static void xpad_stop_output(struct usb_xpad *xpad)
 {
-	if (xpad->xtype == XTYPE_XBOX360)
+	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX)
 		usb_kill_urb(xpad->irq_out);
 }
 
 static void xpad_deinit_output(struct usb_xpad *xpad)
 {
-	if (xpad->xtype == XTYPE_XBOX360) {
+	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX) {
 		usb_free_urb(xpad->irq_out);
 		usb_buffer_free(xpad->udev, XPAD_PKT_LEN,
 				xpad->odata, xpad->odata_dma);
@@ -554,24 +555,46 @@ static void xpad_stop_output(struct usb_
 #endif
 
 #ifdef CONFIG_JOYSTICK_XPAD_FF
-static int xpad_play_effect(struct input_dev *dev, void *data,
-			    struct ff_effect *effect)
+static int xpad_send_rumble(struct usb_xpad *xpad, __u8 left, __u8 right)
+{
+	switch (xpad->xtype) {
+	case XTYPE_XBOX:
+		xpad->odata[0] = 0x00;
+		xpad->odata[1] = 0x06;
+		xpad->odata[2] = 0x00;
+		xpad->odata[3] = left;  /* left actuator (strong) */
+		xpad->odata[4] = 0x00;
+		xpad->odata[5] = right; /* right actuator (weak) */
+		xpad->irq_out->transfer_buffer_length = 6;
+		break;
+	case XTYPE_XBOX360:
+		xpad->odata[0] = 0x00;
+		xpad->odata[1] = 0x08;
+		xpad->odata[2] = 0x00;
+		xpad->odata[3] = left;  /* left actuator (strong) */
+		xpad->odata[4] = right; /* right actuator (weak) */
+		xpad->odata[5] = 0x00;
+		xpad->odata[6] = 0x00;
+		xpad->odata[7] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 8;
+		break;
+	default:
+		dbg("%s - rumble command sent to unsupported xpad type: %d",
+			__func__, xpad->xtype);
+		return 0;
+	}
+
+	return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+}
+
+static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
 
 	if (effect->type == FF_RUMBLE) {
-		__u16 strong = effect->u.rumble.strong_magnitude;
-		__u16 weak = effect->u.rumble.weak_magnitude;
-		xpad->odata[0] = 0x00;
-		xpad->odata[1] = 0x08;
-		xpad->odata[2] = 0x00;
-		xpad->odata[3] = strong / 256;
-		xpad->odata[4] = weak / 256;
-		xpad->odata[5] = 0x00;
-		xpad->odata[6] = 0x00;
-		xpad->odata[7] = 0x00;
-		xpad->irq_out->transfer_buffer_length = 8;
-		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+		__u8 strong = effect->u.rumble.strong_magnitude / 256;
+		__u8 weak   = effect->u.rumble.weak_magnitude / 256;
+		xpad_send_rumble(xpad, strong, weak);
 	}
 
 	return 0;
@@ -579,7 +601,7 @@ static int xpad_play_effect(struct input
 
 static int xpad_init_ff(struct usb_xpad *xpad)
 {
-	if (xpad->xtype != XTYPE_XBOX360)
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX)
 		return 0;
 
 	input_set_capability(xpad->dev, EV_FF, FF_RUMBLE);
