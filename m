From: Chris Moeller <kode54@gmail.com>
Subject: [PATCH 2.6.38.7 3/3] xpad: wireless LED setting
Date: Sun, 12 Jun 2011 17:49:49 -0700
Message-ID: <1307926190.8254.21.camel@sabin.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56683 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab1FMAtv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jun 2011 20:49:51 -0400
Received: by pzk9 with SMTP id 9so1908986pzk.19
        for <linux-input@vger.kernel.org>; Sun, 12 Jun 2011 17:49:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

This patch removes the non-functional bulk output URB method for setting
XBox360 Wireless Controller player number indicators on controller
activation, and replaces it with a functional IRQ output URB method. It
also implements the LED command control for these devices.

Signed-off-by: Chris Moeller <kode54@gmail.com>

---

I chose to duplicate the LED command setting function in the
xpad360w_process_packet function, as the other LED setting function is
designed to require mutex locking, which I found to deadlock the driver
when used in that manner. I will consider adding a lock, as testing with
a rumble flooding application collided with the LED control and
prevented it from setting the player number on connect. I'm not even
sure how the mutex could be deadlocking in the input packet handler, or
even what good it would do in that case, since the rumble setting
functions don't lock it. In fact, only the LED setting function locks
it.

--- linux/drivers/input/joystick/xpad.c.orig	2011-06-11 19:49:56.964914370 -0700
+++ linux/drivers/input/joystick/xpad.c	2011-06-12 16:38:14.911710960 -0700
@@ -251,13 +251,12 @@ struct usb_xpad {
 
 	int pad_present;
 
+	int interface_number;
+
 	struct urb *irq_in;		/* urb for interrupt in report */
 	unsigned char *idata;		/* input data */
 	dma_addr_t idata_dma;
 
-	struct urb *bulk_out;
-	unsigned char *bdata;
-
 #if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XPAD_LEDS)
 	struct urb *irq_out;		/* urb for interrupt out report */
 	unsigned char *odata;		/* output data */
@@ -437,8 +436,23 @@ static void xpad360w_process_packet(stru
 	/* Presence change */
 	if (data[0] & 0x08) {
 		if (data[1] & 0x80) {
+#if defined(CONFIG_JOYSTICK_XPAD_LEDS)
+			xpad->odata[0] = 0x00;
+			xpad->odata[1] = 0x00;
+			xpad->odata[2] = 0x08;
+			xpad->odata[3] = 0x42 + (xpad->interface_number & 6) / 2;
+			xpad->odata[4] = 0x00;
+			xpad->odata[5] = 0x00;
+			xpad->odata[6] = 0x00;
+			xpad->odata[7] = 0x00;
+			xpad->odata[8] = 0x00;
+			xpad->odata[9] = 0x00;
+			xpad->odata[10] = 0x00;
+			xpad->odata[11] = 0x00;
+			xpad->irq_out->transfer_buffer_length = 12;
+			usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+#endif
 			xpad->pad_present = 1;
-			usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
 		} else
 			xpad->pad_present = 0;
 	}
@@ -492,23 +506,6 @@ exit:
 		     __func__, retval);
 }
 
-static void xpad_bulk_out(struct urb *urb)
-{
-	switch (urb->status) {
-	case 0:
-		/* success */
-		break;
-	case -ECONNRESET:
-	case -ENOENT:
-	case -ESHUTDOWN:
-		/* this urb is terminated, clean up */
-		dbg("%s - urb shutting down with status: %d", __func__, urb->status);
-		break;
-	default:
-		dbg("%s - nonzero urb status received: %d", __func__, urb->status);
-	}
-}
-
 #if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XPAD_LEDS)
 static void xpad_irq_out(struct urb *urb)
 {
@@ -667,14 +664,37 @@ struct xpad_led {
 
 static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 {
-	if (command >= 0 && command < 14) {
-		mutex_lock(&xpad->odata_mutex);
-		xpad->odata[0] = 0x01;
-		xpad->odata[1] = 0x03;
-		xpad->odata[2] = command;
-		xpad->irq_out->transfer_buffer_length = 3;
-		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
-		mutex_unlock(&xpad->odata_mutex);
+	if (xpad->xtype == XTYPE_XBOX || xpad->xtype == XTYPE_XBOX360) {
+		if (command >= 0 && command < 14) {
+			mutex_lock(&xpad->odata_mutex);
+			xpad->odata[0] = 0x01;
+			xpad->odata[1] = 0x03;
+			xpad->odata[2] = command;
+			xpad->irq_out->transfer_buffer_length = 3;
+			usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+			mutex_unlock(&xpad->odata_mutex);
+		}
+	} else if (xpad->xtype == XTYPE_XBOX360W) {
+		if (command >= 0 && command < 16) {
+			if (command == 16)
+				command = 2 + (xpad->interface_number & 6) / 2;
+			mutex_lock(&xpad->odata_mutex);
+			xpad->odata[0] = 0x00;
+			xpad->odata[1] = 0x00;
+			xpad->odata[2] = 0x08;
+			xpad->odata[3] = 0x40 + command;
+			xpad->odata[4] = 0x00;
+			xpad->odata[5] = 0x00;
+			xpad->odata[6] = 0x00;
+			xpad->odata[7] = 0x00;
+			xpad->odata[8] = 0x00;
+			xpad->odata[9] = 0x00;
+			xpad->odata[10] = 0x00;
+			xpad->odata[11] = 0x00;
+			xpad->irq_out->transfer_buffer_length = 12;
+			usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+			mutex_unlock(&xpad->odata_mutex);
+		}
 	}
 }
 
@@ -695,7 +715,7 @@ static int xpad_led_probe(struct usb_xpa
 	struct led_classdev *led_cdev;
 	int error;
 
-	if (xpad->xtype != XTYPE_XBOX360)
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
 		return 0;
 
 	xpad->led = led = kzalloc(sizeof(struct xpad_led), GFP_KERNEL);
@@ -721,7 +741,8 @@ static int xpad_led_probe(struct usb_xpa
 	/*
 	 * Light up the segment corresponding to controller number
 	 */
-	xpad_send_led_command(xpad, (led_no % 4) + 2);
+	if (xpad->xtype == XTYPE_XBOX360)
+		xpad_send_led_command(xpad, (led_no % 4) + 2);
 
 	return 0;
 }
@@ -921,43 +942,9 @@ static int xpad_probe(struct usb_interfa
 
 	usb_set_intfdata(intf, xpad);
 
-	if (xpad->xtype == XTYPE_XBOX360W) {
-		/*
-		 * Setup the message to set the LEDs on the
-		 * controller when it shows up
-		 */
-		xpad->bulk_out = usb_alloc_urb(0, GFP_KERNEL);
-		if (!xpad->bulk_out) {
-			error = -ENOMEM;
-			goto fail7;
-		}
-
-		xpad->bdata = kzalloc(XPAD_PKT_LEN, GFP_KERNEL);
-		if (!xpad->bdata) {
-			error = -ENOMEM;
-			goto fail8;
-		}
-
-		xpad->bdata[2] = 0x08;
-		switch (intf->cur_altsetting->desc.bInterfaceNumber) {
-		case 0:
-			xpad->bdata[3] = 0x42;
-			break;
-		case 2:
-			xpad->bdata[3] = 0x43;
-			break;
-		case 4:
-			xpad->bdata[3] = 0x44;
-			break;
-		case 6:
-			xpad->bdata[3] = 0x45;
-		}
-
-		ep_irq_in = &intf->cur_altsetting->endpoint[1].desc;
-		usb_fill_bulk_urb(xpad->bulk_out, udev,
-				usb_sndbulkpipe(udev, ep_irq_in->bEndpointAddress),
-				xpad->bdata, XPAD_PKT_LEN, xpad_bulk_out, xpad);
+	xpad->interface_number = intf->cur_altsetting->desc.bInterfaceNumber;
 
+	if (xpad->xtype == XTYPE_XBOX360W) {
 		/*
 		 * Submit the int URB immediately rather than waiting for open
 		 * because we get status messages from the device whether
@@ -968,13 +955,11 @@ static int xpad_probe(struct usb_interfa
 		xpad->irq_in->dev = xpad->udev;
 		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
 		if (error)
-			goto fail9;
+			goto fail7;
 	}
 
 	return 0;
 
- fail9:	kfree(xpad->bdata);
- fail8:	usb_free_urb(xpad->bulk_out);
  fail7:	input_unregister_device(input_dev);
 	input_dev = NULL;
  fail6:	xpad_led_disconnect(xpad);
@@ -998,8 +983,6 @@ static void xpad_disconnect(struct usb_i
 	xpad_deinit_output(xpad);
 
 	if (xpad->xtype == XTYPE_XBOX360W) {
-		usb_kill_urb(xpad->bulk_out);
-		usb_free_urb(xpad->bulk_out);
 		usb_kill_urb(xpad->irq_in);
 	}
 
@@ -1007,7 +990,6 @@ static void xpad_disconnect(struct usb_i
 	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
 			xpad->idata, xpad->idata_dma);
 
-	kfree(xpad->bdata);
 	kfree(xpad);
 
 	usb_set_intfdata(intf, NULL);


