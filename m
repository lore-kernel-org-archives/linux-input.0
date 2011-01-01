From: Chris Moeller <kode54@gmail.com>
Subject: Input: Feature/bug fix for xpad driver
Date: Fri, 31 Dec 2010 19:00:25 -0800
Message-ID: <201012311900.25413.kode54@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bender.sjeng.org ([94.75.209.35]:44809 "EHLO mail.sjeng.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab1AADTw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Dec 2010 22:19:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

This patch is based on kernel version 2.6.35, and addresses two issues.

1) It implements force feedback rumble support for Xbox360 Wireless
controllers, by adding the correct outbound packet format to the relevant
function.

2) It fixes the LED player number indicator control for Xbox360 Wireless
controllers, although I'm not sure if what I changed was completely necessary.
For some strange reason, the bulk packet method was always returning -EINVARG
on usb_submit_urb(), no matter where I happened to address that function on
the bulk packet. So, I removed the bulk send code entirely and enabled the IRQ
send method globally, and send the LED command packet that way instead, which
seems to work. In the process, I also added an extra parameter to the LED
command function to disable mutex locking for calls within an IRQ handler,
since it seems to be unnecessary there, and also causes the kernel to throw a
bug check message.

Both are included in a single patch because they both depend on the same changes to the 
output IRQ initialization and shutdown code. Maybe it could use a bit of restructuring, such as 
moving the LED output packet sending out of the original LED send command, since the 0x4* 
commands are exclusive to the Xbox360 Wireless Controller, and I didn't change the rest of the 
LED interface code to support it that way, so it currently only blinks then steady lights the 
player number.

---
--- a/drivers/input/joystick/xpad.c	2010-12-31 12:11:53.186851487 -0800
+++ b/drivers/input/joystick/xpad.c	2010-12-31 17:51:22.212307496 -0800
@@ -240,20 +240,17 @@ struct usb_xpad {
 	struct usb_device *udev;	/* usb device */
 
 	int pad_present;
+	
+	int interface_number;
 
 	struct urb *irq_in;		/* urb for interrupt in report */
 	unsigned char *idata;		/* input data */
 	dma_addr_t idata_dma;
 
-	struct urb *bulk_out;
-	unsigned char *bdata;
-
-#if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XPAD_LEDS)
 	struct urb *irq_out;		/* urb for interrupt out report */
 	unsigned char *odata;		/* output data */
 	dma_addr_t odata_dma;
 	struct mutex odata_mutex;
-#endif
 
 #if defined(CONFIG_JOYSTICK_XPAD_LEDS)
 	struct xpad_led *led;
@@ -417,13 +414,15 @@ static void xpad360_process_packet(struc
  *
  */
 
+static void xpad_send_led_command(struct usb_xpad *xpad, int command, int mutex);
+
 static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
 {
 	/* Presence change */
 	if (data[0] & 0x08) {
 		if (data[1] & 0x80) {
 			xpad->pad_present = 1;
-			usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
+			xpad_send_led_command(xpad, 0x42 + ((xpad->interface_number / 2) & 3), 0);
 		} else
 			xpad->pad_present = 0;
 	}
@@ -477,24 +476,6 @@ exit:
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
-#if defined(CONFIG_JOYSTICK_XPAD_FF) || defined(CONFIG_JOYSTICK_XPAD_LEDS)
 static void xpad_irq_out(struct urb *urb)
 {
 	int retval, status;
@@ -530,9 +511,6 @@ static int xpad_init_output(struct usb_i
 	struct usb_endpoint_descriptor *ep_irq_out;
 	int error = -ENOMEM;
 
-	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX)
-		return 0;
-
 	xpad->odata = usb_alloc_coherent(xpad->udev, XPAD_PKT_LEN,
 					 GFP_KERNEL, &xpad->odata_dma);
 	if (!xpad->odata)
@@ -560,23 +538,15 @@ static int xpad_init_output(struct usb_i
 
 static void xpad_stop_output(struct usb_xpad *xpad)
 {
-	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX)
-		usb_kill_urb(xpad->irq_out);
+	usb_kill_urb(xpad->irq_out);
 }
 
 static void xpad_deinit_output(struct usb_xpad *xpad)
 {
-	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX) {
-		usb_free_urb(xpad->irq_out);
-		usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
-				xpad->odata, xpad->odata_dma);
-	}
+	usb_free_urb(xpad->irq_out);
+	usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
+			xpad->odata, xpad->odata_dma);
 }
-#else
-static int xpad_init_output(struct usb_interface *intf, struct usb_xpad *xpad) { return 0; }
-static void xpad_deinit_output(struct usb_xpad *xpad) {}
-static void xpad_stop_output(struct usb_xpad *xpad) {}
-#endif
 
 #ifdef CONFIG_JOYSTICK_XPAD_FF
 static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect *effect)
@@ -613,6 +583,23 @@ static int xpad_play_effect(struct input
 
 			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
 
+		case XTYPE_XBOX360W:
+			xpad->odata[0] = 0x00;
+			xpad->odata[1] = 0x01;
+			xpad->odata[2] = 0x0F;
+			xpad->odata[3] = 0xC0;
+			xpad->odata[4] = 0x00;
+			xpad->odata[5] = strong / 256;
+			xpad->odata[6] = weak / 256;
+			xpad->odata[7] = 0x00;
+			xpad->odata[8] = 0x00;
+			xpad->odata[9] = 0x00;
+			xpad->odata[10] = 0x00;
+			xpad->odata[11] = 0x00;
+			xpad->irq_out->transfer_buffer_length = 12;
+
+			return usb_submit_urb(xpad->irq_out, GFP_ATOMIC);
+
 		default:
 			dbg("%s - rumble command sent to unsupported xpad type: %d",
 				__func__, xpad->xtype);
@@ -625,7 +612,7 @@ static int xpad_play_effect(struct input
 
 static int xpad_init_ff(struct usb_xpad *xpad)
 {
-	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX)
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX && xpad->xtype != 
XTYPE_XBOX360W)
 		return 0;
 
 	input_set_capability(xpad->dev, EV_FF, FF_RUMBLE);
@@ -646,16 +633,33 @@ struct xpad_led {
 	struct usb_xpad *xpad;
 };
 
-static void xpad_send_led_command(struct usb_xpad *xpad, int command)
+static void xpad_send_led_command(struct usb_xpad *xpad, int command, int mutex)
 {
 	if (command >= 0 && command < 14) {
-		mutex_lock(&xpad->odata_mutex);
+		if (mutex) mutex_lock(&xpad->odata_mutex);
 		xpad->odata[0] = 0x01;
 		xpad->odata[1] = 0x03;
 		xpad->odata[2] = command;
 		xpad->irq_out->transfer_buffer_length = 3;
 		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
-		mutex_unlock(&xpad->odata_mutex);
+		if (mutex) mutex_unlock(&xpad->odata_mutex);
+	} else if (command >= 0x40 && command <= 0x4F) {
+		if (mutex) mutex_lock(&xpad->odata_mutex);
+		xpad->odata[0] = 0x00;
+		xpad->odata[1] = 0x00;
+		xpad->odata[2] = 0x08;
+		xpad->odata[3] = command;
+		xpad->odata[4] = 0x00;
+		xpad->odata[5] = 0x00;
+		xpad->odata[6] = 0x00;
+		xpad->odata[7] = 0x00;
+		xpad->odata[8] = 0x00;
+		xpad->odata[9] = 0x00;
+		xpad->odata[10] = 0x00;
+		xpad->odata[11] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 12;
+		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+		if (mutex) mutex_unlock(&xpad->odata_mutex);
 	}
 }
 
@@ -665,7 +669,7 @@ static void xpad_led_set(struct led_clas
 	struct xpad_led *xpad_led = container_of(led_cdev,
 						 struct xpad_led, led_cdev);
 
-	xpad_send_led_command(xpad_led->xpad, value);
+	xpad_send_led_command(xpad_led->xpad, value, 1);
 }
 
 static int xpad_led_probe(struct usb_xpad *xpad)
@@ -702,7 +706,7 @@ static int xpad_led_probe(struct usb_xpa
 	/*
 	 * Light up the segment corresponding to controller number
 	 */
-	xpad_send_led_command(xpad, (led_no % 4) + 2);
+	xpad_send_led_command(xpad, (led_no % 4) + 2, 1);
 
 	return 0;
 }
@@ -889,6 +893,8 @@ static int xpad_probe(struct usb_interfa
 		goto fail4;
 
 	usb_set_intfdata(intf, xpad);
+	
+	xpad->interface_number = intf->cur_altsetting->desc.bInterfaceNumber;
 
 	/*
 	 * Submit the int URB immediatly rather than waiting for open
@@ -902,44 +908,10 @@ static int xpad_probe(struct usb_interfa
 		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
 		if (error)
 			goto fail4;
-
-		/*
-		 * Setup the message to set the LEDs on the
-		 * controller when it shows up
-		 */
-		xpad->bulk_out = usb_alloc_urb(0, GFP_KERNEL);
-		if(!xpad->bulk_out)
-			goto fail5;
-
-		xpad->bdata = kzalloc(XPAD_PKT_LEN, GFP_KERNEL);
-		if(!xpad->bdata)
-			goto fail6;
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
 	}
 
 	return 0;
 
- fail6:	usb_free_urb(xpad->bulk_out);
- fail5:	usb_kill_urb(xpad->irq_in);
  fail4:	usb_free_urb(xpad->irq_in);
  fail3:	xpad_deinit_output(xpad);
  fail2:	usb_free_coherent(udev, XPAD_PKT_LEN, xpad->idata, xpad->idata_dma);
@@ -959,8 +931,6 @@ static void xpad_disconnect(struct usb_i
 		input_unregister_device(xpad->dev);
 		xpad_deinit_output(xpad);
 		if (xpad->xtype == XTYPE_XBOX360W) {
-			usb_kill_urb(xpad->bulk_out);
-			usb_free_urb(xpad->bulk_out);
 			usb_kill_urb(xpad->irq_in);
 		}
 		usb_free_urb(xpad->irq_in);
