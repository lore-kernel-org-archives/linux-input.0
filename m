From: Chris Moeller <kode54@gmail.com>
Subject: [PATCH 3.6.6 1/1] xpad: fix xbox360w initial LED setting and
 implement LED setting interface
Date: Mon, 12 Nov 2012 19:30:07 -0800
Message-ID: <20121112193007.72a7a8b7@umaro.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:33505 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875Ab2KMDaW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Nov 2012 22:30:22 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so4830495pbb.19
        for <linux-input@vger.kernel.org>; Mon, 12 Nov 2012 19:30:21 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

This patch for XBox360 Wireless Controllers fixes the initial player
indicator setting, and also implements the LED setting interface.

Signed-off-by: Chris Moeller <kode54@gmail.com>

---

This patch still duplicates the LED setting code for the initial player
indicator setting function, as that function needs to send the same
packet without any mutex locking.

--- linux-3.6.orig/drivers/input/joystick/xpad.c	2012-09-30 16:47:46.000000000 -0700
+++ linux-3.6/drivers/input/joystick/xpad.c	2012-11-12 17:26:11.809145345 -0800
@@ -260,13 +260,12 @@ struct usb_xpad {
 
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
@@ -447,7 +446,22 @@ static void xpad360w_process_packet(stru
 	if (data[0] & 0x08) {
 		if (data[1] & 0x80) {
 			xpad->pad_present = 1;
-			usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
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
 		} else
 			xpad->pad_present = 0;
 	}
@@ -502,28 +516,6 @@ exit:
 			__func__, retval);
 }
 
-static void xpad_bulk_out(struct urb *urb)
-{
-	struct usb_xpad *xpad = urb->context;
-	struct device *dev = &xpad->intf->dev;
-
-	switch (urb->status) {
-	case 0:
-		/* success */
-		break;
-	case -ECONNRESET:
-	case -ENOENT:
-	case -ESHUTDOWN:
-		/* this urb is terminated, clean up */
-		dev_dbg(dev, "%s - urb shutting down with status: %d\n",
-			__func__, urb->status);
-		break;
-	default:
-		dev_dbg(dev, "%s - nonzero urb status received: %d\n",
-			__func__, urb->status);
-	}
-}
-
 #if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XPAD_LEDS)
 static void xpad_irq_out(struct urb *urb)
 {
@@ -704,14 +696,37 @@ struct xpad_led {
 
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
+		if (command >= 0 && command < 17) {
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
 
@@ -732,7 +747,7 @@ static int xpad_led_probe(struct usb_xpa
 	struct led_classdev *led_cdev;
 	int error;
 
-	if (xpad->xtype != XTYPE_XBOX360)
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
 		return 0;
 
 	xpad->led = led = kzalloc(sizeof(struct xpad_led), GFP_KERNEL);
@@ -758,7 +773,8 @@ static int xpad_led_probe(struct usb_xpa
 	/*
 	 * Light up the segment corresponding to controller number
 	 */
-	xpad_send_led_command(xpad, (led_no % 4) + 2);
+    if (xpad->xtype == XTYPE_XBOX360)
+		xpad_send_led_command(xpad, (led_no % 4) + 2);
 
 	return 0;
 }
@@ -960,42 +976,7 @@ static int xpad_probe(struct usb_interfa
 	usb_set_intfdata(intf, xpad);
 
 	if (xpad->xtype == XTYPE_XBOX360W) {
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
-
+		xpad->interface_number = intf->cur_altsetting->desc.bInterfaceNumber;
 		/*
 		 * Submit the int URB immediately rather than waiting for open
 		 * because we get status messages from the device whether
@@ -1006,13 +987,11 @@ static int xpad_probe(struct usb_interfa
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
@@ -1036,8 +1015,6 @@ static void xpad_disconnect(struct usb_i
 	xpad_deinit_output(xpad);
 
 	if (xpad->xtype == XTYPE_XBOX360W) {
-		usb_kill_urb(xpad->bulk_out);
-		usb_free_urb(xpad->bulk_out);
 		usb_kill_urb(xpad->irq_in);
 	}
 
@@ -1045,7 +1022,6 @@ static void xpad_disconnect(struct usb_i
 	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
 			xpad->idata, xpad->idata_dma);
 
-	kfree(xpad->bdata);
 	kfree(xpad);
 
 	usb_set_intfdata(intf, NULL);
