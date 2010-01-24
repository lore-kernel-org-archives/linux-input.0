From: Benjamin Valentin <benpicco@zedat.fu-berlin.de>
Subject: Re: [PATCH][resubmit] xpad.c: Add rumble support for original xbox
 controller
Date: Sun, 24 Jan 2010 06:23:22 +0100
Message-ID: <20100124062322.63c0b1d9@rechenknecht2k7>
References: <20100120010406.54a11bc6@rechenknecht2k7>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51280 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120Ab0AXFXW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Jan 2010 00:23:22 -0500
In-Reply-To: <20100120010406.54a11bc6@rechenknecht2k7>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Scott Moreau <oreaus@gmail.com>

Hi,
this is the patch against Linux 2.6.33-rc5, no functionality changed.

Signed-off-by: Benjamin Valentin <benpicco@zedat.fu-berlin.de>
--- drivers/input/joystick/xpad.c	2010-01-24 06:03:41.000000000 +0100
+++ drivers/input/joystick/xpad.c	2010-01-24 06:09:50.000000000 +0100
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
@@ -554,24 +554,46 @@ static void xpad_stop_output(struct usb_
 #endif
 
 #ifdef CONFIG_JOYSTICK_XPAD_FF
-static int xpad_play_effect(struct input_dev *dev, void *data,
-			    struct ff_effect *effect)
+static int xpad_send_rumble(struct usb_xpad *xpad, __u8 left, __u8 right)
 {
-	struct usb_xpad *xpad = input_get_drvdata(dev);
-
-	if (effect->type == FF_RUMBLE) {
-		__u16 strong = effect->u.rumble.strong_magnitude;
-		__u16 weak = effect->u.rumble.weak_magnitude;
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
 		xpad->odata[0] = 0x00;
 		xpad->odata[1] = 0x08;
 		xpad->odata[2] = 0x00;
-		xpad->odata[3] = strong / 256;
-		xpad->odata[4] = weak / 256;
+		xpad->odata[3] = left;  /* left actuator (strong) */
+		xpad->odata[4] = right; /* right actuator (weak) */
 		xpad->odata[5] = 0x00;
 		xpad->odata[6] = 0x00;
 		xpad->odata[7] = 0x00;
 		xpad->irq_out->transfer_buffer_length = 8;
-		usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
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
+{
+	struct usb_xpad *xpad = input_get_drvdata(dev);
+
+	if (effect->type == FF_RUMBLE) {
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
