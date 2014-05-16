From: Sarah Bessmer <aotos@fastmail.fm>
Subject: [PATCH v2] input: xpad: Prevent corruption of urb request.
Date: Fri, 16 May 2014 02:11:57 -0700
Message-ID: <20140516021157.45c281f9@willow>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45494 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755534AbaEPI6B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 16 May 2014 04:58:01 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9D304206FE
	for <linux-input@vger.kernel.org>; Fri, 16 May 2014 04:57:57 -0400 (EDT)
Received: from willow (unknown [75.175.110.81])
	by mail.messagingengine.com (Postfix) with ESMTPA id 1BC716800F7
	for <linux-input@vger.kernel.org>; Fri, 16 May 2014 04:57:57 -0400 (EDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

The xpad_send_led_command() and xpad_play_effect() functions submit urb requests, but do not
wait for the previous urb request to complete before using the same resources to
submit a new request.  This can lead to unpredictable undesirable effects, including
memory corruption and dereferencing of NULL pointers(and needless to say, kernel
panics).

Fix the issue by introducing a busy flag set on submission of the urb request, and
cleared on urb request completion.  If this flag is set while in xpad_send_led_command()
or xpad_play_effect(), the led/rumble packet data is buffered, and will be sent from
the urb request completion routine when the current urb request finishes.


Patch tested with rumble against a Logitech F510 and an X-Box v1 pad.


Signed-off-by: Sarah Bessmer <aotos@fastmail.fm>
---
v2:
-fixed introduced race in xpad_irq_out()

--- linux-3.14.4/drivers/input/joystick/xpad.c.orig	2014-05-15 13:13:39.000000000 -0700
+++ linux-3.14.4/drivers/input/joystick/xpad.c	2014-05-16 02:00:56.000000000 -0700
@@ -78,6 +78,7 @@
 #include <linux/stat.h>
 #include <linux/module.h>
 #include <linux/usb/input.h>
+#include <linux/spinlock.h>
 
 #define DRIVER_AUTHOR "Marko Friedemann <mfr@bmx-chemnitz.de>"
 #define DRIVER_DESC "X-Box pad driver"
@@ -282,7 +283,15 @@ struct usb_xpad {
 	struct urb *irq_out;		/* urb for interrupt out report */
 	unsigned char *odata;		/* output data */
 	dma_addr_t odata_dma;
-	struct mutex odata_mutex;
+	int odata_busy;
+
+	spinlock_t pend_lock;
+
+	unsigned pend_rum;
+	unsigned char rum_data[XPAD_PKT_LEN];
+
+	unsigned pend_led;
+	unsigned char led_data[XPAD_PKT_LEN];
 #endif
 
 #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
@@ -541,12 +550,37 @@ static void xpad_irq_out(struct urb *urb
 	struct usb_xpad *xpad = urb->context;
 	struct device *dev = &xpad->intf->dev;
 	int retval, status;
+	unsigned long flags;
 
 	status = urb->status;
 
 	switch (status) {
 	case 0:
 		/* success */
+		spin_lock_irqsave(&xpad->pend_lock, flags);
+		xpad->irq_out->transfer_buffer_length = 0;
+
+		if (xpad->pend_rum != 0) {
+			memcpy(xpad->odata, xpad->rum_data, xpad->pend_rum);
+			xpad->irq_out->transfer_buffer_length = xpad->pend_rum;
+			xpad->pend_rum = 0;
+		} else if (xpad->pend_led != 0) {
+			memcpy(xpad->odata, xpad->led_data, xpad->pend_led);
+			xpad->irq_out->transfer_buffer_length = xpad->pend_led;
+			xpad->pend_led = 0;
+		}
+
+		if (xpad->irq_out->transfer_buffer_length != 0) {
+			spin_unlock_irqrestore(&xpad->pend_lock, flags);
+			if (usb_submit_urb(xpad->irq_out, GFP_ATOMIC) != 0) {
+				spin_lock_irqsave(&xpad->pend_lock, flags);
+				xpad->odata_busy = 0;
+				spin_unlock_irqrestore(&xpad->pend_lock, flags);
+			}
+		} else {
+			xpad->odata_busy = 0;
+			spin_unlock_irqrestore(&xpad->pend_lock, flags);
+		}
 		return;
 
 	case -ECONNRESET:
@@ -555,19 +589,27 @@ static void xpad_irq_out(struct urb *urb
 		/* this urb is terminated, clean up */
 		dev_dbg(dev, "%s - urb shutting down with status: %d\n",
 			__func__, status);
+
+		spin_lock_irqsave(&xpad->pend_lock, flags);
+		xpad->odata_busy = 0;
+		spin_unlock_irqrestore(&xpad->pend_lock, flags);
 		return;
 
 	default:
 		dev_dbg(dev, "%s - nonzero urb status received: %d\n",
 			__func__, status);
-		goto exit;
-	}
 
-exit:
-	retval = usb_submit_urb(urb, GFP_ATOMIC);
-	if (retval)
-		dev_err(dev, "%s - usb_submit_urb failed with result %d\n",
-			__func__, retval);
+		retval = usb_submit_urb(urb, GFP_ATOMIC);
+		if (retval) {
+			dev_err(dev, "%s - usb_submit_urb failed with result %d\n",
+				__func__, retval);
+			spin_lock_irqsave(&xpad->pend_lock, flags);
+			xpad->odata_busy = 0;
+			spin_unlock_irqrestore(&xpad->pend_lock, flags);
+		}
+
+		return;
+	}
 }
 
 static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad)
@@ -585,7 +627,12 @@ static int xpad_init_output(struct usb_i
 		goto fail1;
 	}
 
-	mutex_init(&xpad->odata_mutex);
+	xpad->odata_busy = 0;
+
+	spin_lock_init(&xpad->pend_lock);
+
+	xpad->pend_rum = 0;
+	xpad->pend_led = 0;
 
 	xpad->irq_out = usb_alloc_urb(0, GFP_KERNEL);
 	if (!xpad->irq_out) {
@@ -628,61 +675,91 @@ static void xpad_stop_output(struct usb_
 #endif
 
 #ifdef CONFIG_JOYSTICK_XPAD_FF
+static int xpad_make_rum_data(struct usb_xpad *xpad, __u16 strong, __u16 weak)
+{
+	switch (xpad->xtype) {
+
+	case XTYPE_XBOX:
+		xpad->rum_data[0] = 0x00;
+		xpad->rum_data[1] = 0x06;
+		xpad->rum_data[2] = 0x00;
+		xpad->rum_data[3] = strong / 256;	/* left actuator */
+		xpad->rum_data[4] = 0x00;
+		xpad->rum_data[5] = weak / 256;	/* right actuator */
+		xpad->pend_rum = 6;
+		return 0;
+
+
+	case XTYPE_XBOX360:
+		xpad->rum_data[0] = 0x00;
+		xpad->rum_data[1] = 0x08;
+		xpad->rum_data[2] = 0x00;
+		xpad->rum_data[3] = strong / 256;  /* left actuator? */
+		xpad->rum_data[4] = weak / 256;	/* right actuator? */
+		xpad->rum_data[5] = 0x00;
+		xpad->rum_data[6] = 0x00;
+		xpad->rum_data[7] = 0x00;
+		xpad->pend_rum = 8;
+		return 0;
+
+	case XTYPE_XBOX360W:
+		xpad->rum_data[0] = 0x00;
+		xpad->rum_data[1] = 0x01;
+		xpad->rum_data[2] = 0x0F;
+		xpad->rum_data[3] = 0xC0;
+		xpad->rum_data[4] = 0x00;
+		xpad->rum_data[5] = strong / 256;
+		xpad->rum_data[6] = weak / 256;
+		xpad->rum_data[7] = 0x00;
+		xpad->rum_data[8] = 0x00;
+		xpad->rum_data[9] = 0x00;
+		xpad->rum_data[10] = 0x00;
+		xpad->rum_data[11] = 0x00;
+		xpad->pend_rum = 12;
+		return 0;
+
+	}
+	return -1;
+}
+
 static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
 {
 	struct usb_xpad *xpad = input_get_drvdata(dev);
 
 	if (effect->type == FF_RUMBLE) {
-		__u16 strong = effect->u.rumble.strong_magnitude;
-		__u16 weak = effect->u.rumble.weak_magnitude;
-
-		switch (xpad->xtype) {
+		unsigned long flags;
+		int mrdrv;
 
-		case XTYPE_XBOX:
-			xpad->odata[0] = 0x00;
-			xpad->odata[1] = 0x06;
-			xpad->odata[2] = 0x00;
-			xpad->odata[3] = strong / 256;	/* left actuator */
-			xpad->odata[4] = 0x00;
-			xpad->odata[5] = weak / 256;	/* right actuator */
-			xpad->irq_out->transfer_buffer_length = 6;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
-
-		case XTYPE_XBOX360:
-			xpad->odata[0] = 0x00;
-			xpad->odata[1] = 0x08;
-			xpad->odata[2] = 0x00;
-			xpad->odata[3] = strong / 256;  /* left actuator? */
-			xpad->odata[4] = weak / 256;	/* right actuator? */
-			xpad->odata[5] = 0x00;
-			xpad->odata[6] = 0x00;
-			xpad->odata[7] = 0x00;
-			xpad->irq_out->transfer_buffer_length = 8;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
-
-		case XTYPE_XBOX360W:
-			xpad->odata[0] = 0x00;
-			xpad->odata[1] = 0x01;
-			xpad->odata[2] = 0x0F;
-			xpad->odata[3] = 0xC0;
-			xpad->odata[4] = 0x00;
-			xpad->odata[5] = strong / 256;
-			xpad->odata[6] = weak / 256;
-			xpad->odata[7] = 0x00;
-			xpad->odata[8] = 0x00;
-			xpad->odata[9] = 0x00;
-			xpad->odata[10] = 0x00;
-			xpad->odata[11] = 0x00;
-			xpad->irq_out->transfer_buffer_length = 12;
-
-			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+		spin_lock_irqsave(&xpad->pend_lock, flags);
+		mrdrv = xpad_make_rum_data(xpad, effect->u.rumble.strong_magnitude,
+						effect->u.rumble.weak_magnitude);
+
+		if (mrdrv == 0 && !xpad->odata_busy) {
+			memcpy(xpad->odata, xpad->rum_data, xpad->pend_rum);
+			xpad->irq_out->transfer_buffer_length = xpad->pend_rum;
+			xpad->pend_rum = 0;
+			xpad->odata_busy = 1;
+			spin_unlock_irqrestore(&xpad->pend_lock, flags);
+
+			if (usb_submit_urb(xpad->irq_out, GFP_ATOMIC) != 0) {
+				spin_lock_irqsave(&xpad->pend_lock, flags);
+				xpad->odata_busy = 0;
+				spin_unlock_irqrestore(&xpad->pend_lock, flags);
+			}
+		} else {
+			spin_unlock_irqrestore(&xpad->pend_lock, flags);
+
+			if (mrdrv == 0) {
+				dev_dbg(&xpad->dev->dev,
+					"%s - rumble while urb busy\n", __func__);
+			}
+		}
 
-		default:
+		if (mrdrv != 0) {
 			dev_dbg(&xpad->dev->dev,
 				"%s - rumble command sent to unsupported xpad type: %d\n",
 				__func__, xpad->xtype);
+
 			return -1;
 		}
 	}
@@ -716,13 +793,30 @@ struct xpad_led {
 static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 {
 	if (command >= 0 && command < 14) {
-		mutex_lock(&xpad->odata_mutex);
-		xpad->odata[0] = 0x01;
-		xpad->odata[1] = 0x03;
-		xpad->odata[2] = command;
-		xpad->irq_out->transfer_buffer_length = 3;
-		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
-		mutex_unlock(&xpad->odata_mutex);
+		unsigned long flags;
+
+		spin_lock_irqsave(&xpad->pend_lock, flags);
+		xpad->led_data[0] = 0x01;
+		xpad->led_data[1] = 0x03;
+		xpad->led_data[2] = command;
+		xpad->pend_led = 3;
+
+		if (!xpad->odata_busy) {
+			memcpy(xpad->odata, xpad->led_data, xpad->pend_led);
+			xpad->irq_out->transfer_buffer_length = xpad->pend_led;
+			xpad->pend_led = 0;
+			xpad->odata_busy = 1;
+			spin_unlock_irqrestore(&xpad->pend_lock, flags);
+
+			if (usb_submit_urb(xpad->irq_out, GFP_KERNEL) != 0) {
+				spin_lock_irqsave(&xpad->pend_lock, flags);
+				xpad->odata_busy = 0;
+				spin_unlock_irqrestore(&xpad->pend_lock, flags);
+			}
+		} else {
+			spin_unlock_irqrestore(&xpad->pend_lock, flags);
+			dev_dbg(&xpad->dev->dev, "%s - led while urb busy\n", __func__);
+		}
 	}
 }
