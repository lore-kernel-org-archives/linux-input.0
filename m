From: Chris Moeller <kode54@gmail.com>
Subject: [PATCH 2.6.38.7] xpad: Implemented rumble support for wireless
 controllers
Date: Sun, 12 Jun 2011 12:29:37 -0700
Message-ID: <1307906984.3478.13.camel@sabin.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:44284 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411Ab1FLT3r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jun 2011 15:29:47 -0400
Received: by pxi2 with SMTP id 2so2553282pxi.10
        for <linux-input@vger.kernel.org>; Sun, 12 Jun 2011 12:29:46 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Implements rumble support for XBox360 Wireless Controllers.

Signed-off-by: Chris Moeller <kode54@gmail.com>

---

I finally returned from my weeks of idling around in Windows to actually get some Linux development done. It was easier than
I thought to split out just the rumble support, which requires minimal changes to the driver.

Implementing XBox360 Wireless LED support will require a bit more work to pull off properly, since it seems to hate that bulk
interface method completely. The LED output function should not require any more synchronization than it already has, although
the initial LED send command will have to be separated out, since it can't be locked at all. I presume that won't be a problem
as there should be no rumble commands to collide with it when the controller is just being reported as present. I will
probably limit it to working if the CONFIG_JOYSTICK_XPAD_LEDS macro is defined, as that is one of the minimum requirements for
the IRQ out interface to be enabled.

--- linux/drivers/input/joystick/xpad.c.orig	2011-06-11 19:49:56.964914370 -0700
+++ linux/drivers/input/joystick/xpad.c	2011-06-12 12:02:32.732131132 -0700
@@ -545,7 +545,7 @@ static int xpad_init_output(struct usb_i
 	struct usb_endpoint_descriptor *ep_irq_out;
 	int error;
 
-	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX)
+	if (xpad->xtype == XTYPE_UNKNOWN)
 		return 0;
 
 	xpad->odata = usb_alloc_coherent(xpad->udev, XPAD_PKT_LEN,
@@ -579,13 +579,13 @@ static int xpad_init_output(struct usb_i
 
 static void xpad_stop_output(struct usb_xpad *xpad)
 {
-	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX)
+	if (xpad->xtype != XTYPE_UNKNOWN)
 		usb_kill_urb(xpad->irq_out);
 }
 
 static void xpad_deinit_output(struct usb_xpad *xpad)
 {
-	if (xpad->xtype == XTYPE_XBOX360 || xpad->xtype == XTYPE_XBOX) {
+	if (xpad->xtype != XTYPE_UNKNOWN) {
 		usb_free_urb(xpad->irq_out);
 		usb_free_coherent(xpad->udev, XPAD_PKT_LEN,
 				xpad->odata, xpad->odata_dma);
@@ -632,6 +632,23 @@ static int xpad_play_effect(struct input
 
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
@@ -644,7 +661,7 @@ static int xpad_play_effect(struct input
 
 static int xpad_init_ff(struct usb_xpad *xpad)
 {
-	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX)
+	if (xpad->xtype == XTYPE_UNKNOWN)
 		return 0;
 
 	input_set_capability(xpad->dev, EV_FF, FF_RUMBLE);


