From: Chris Moeller <kode54@gmail.com>
Subject: [PATCH 2.6.38.7 1/3] xpad: common changes
Date: Sun, 12 Jun 2011 17:17:34 -0700
Message-ID: <1307924255.8254.9.camel@sabin.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33609 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253Ab1FMARg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jun 2011 20:17:36 -0400
Received: by pwi15 with SMTP id 15so1891161pwi.19
        for <linux-input@vger.kernel.org>; Sun, 12 Jun 2011 17:17:35 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

This patch enables the output URB for XBox360 Wireless controllers, as
required by either of the other patches which follow.

Signed-off-by: Chris Moeller <kode54@gmail.com>

--- linux/drivers/input/joystick/xpad.c.orig	2011-06-11 19:49:56.964914370 -0700
+++ linux/drivers/input/joystick/xpad.c	2011-06-12 16:38:14.911710960 -0700
@@ -545,7 +542,7 @@ static int xpad_init_output(struct usb_i
 	struct usb_endpoint_descriptor *ep_irq_out;
 	int error;
 
-	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX)
+	if (xpad->xtype == XTYPE_UNKNOWN)
 		return 0;
 
 	xpad->odata = usb_alloc_coherent(xpad->udev, XPAD_PKT_LEN,
@@ -579,13 +576,13 @@ static int xpad_init_output(struct usb_i
 
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


