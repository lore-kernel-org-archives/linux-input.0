From: Chris Moeller <kode54@gmail.com>
Subject: [PATCH 2.6.38.7 2/3] xpad: wireless rumble support
Date: Sun, 12 Jun 2011 17:19:26 -0700
Message-ID: <1307924366.8254.11.camel@sabin.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:32873 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253Ab1FMAT1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jun 2011 20:19:27 -0400
Received: by pzk9 with SMTP id 9so1903148pzk.19
        for <linux-input@vger.kernel.org>; Sun, 12 Jun 2011 17:19:27 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

This patch implements rumble support for XBox360 Wireless Controllers.

Signed-off-by: Chris Moeller <kode54@gmail.c>

--- linux/drivers/input/joystick/xpad.c.orig	2011-06-11 19:49:56.964914370 -0700
+++ linux/drivers/input/joystick/xpad.c	2011-06-12 12:02:32.732131132 -0700
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


