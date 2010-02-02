From: akpm@linux-foundation.org
Subject: [patch 6/7] usbtouchscreen: don't send interrupt urbs to bulk endpoints
Date: Tue, 02 Feb 2010 14:42:56 -0800
Message-ID: <201002022242.o12MguA0019148@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51633 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756701Ab0BBWnV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Feb 2010 17:43:21 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dtor@mail.ru
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org, linux@rainbow-software.org, daniel.ritz@gmx.ch, ddstreet@ieee.org, dmitry.torokhov@gmail.com, floe@butterbrot.org, greg@kroah.com, jim-linux@nurd.se, oliver@neukum.org

From: Ondrej Zary <linux@rainbow-software.org>

Don't send interrupt urbs to bulk endpoints.
This fixes EHCI corruption after rmmod with NEXIO touchscreen.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jim Persson <jim-linux@nurd.se>
Cc: Florian Echtler <floe@butterbrot.org>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Greg KH <greg@kroah.com>
Cc: Oliver Neukum <oliver@neukum.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/input/touchscreen/usbtouchscreen.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff -puN drivers/input/touchscreen/usbtouchscreen.c~usbtouchscreen-dont-send-interrupt-urbs-to-bulk-endpoints drivers/input/touchscreen/usbtouchscreen.c
--- a/drivers/input/touchscreen/usbtouchscreen.c~usbtouchscreen-dont-send-interrupt-urbs-to-bulk-endpoints
+++ a/drivers/input/touchscreen/usbtouchscreen.c
@@ -1375,10 +1375,16 @@ static int usbtouch_probe(struct usb_int
 		input_set_abs_params(input_dev, ABS_PRESSURE, type->min_press,
 		                     type->max_press, 0, 0);
 
-	usb_fill_int_urb(usbtouch->irq, udev,
+	if (usb_endpoint_type(endpoint) == USB_ENDPOINT_XFER_INT)
+		usb_fill_int_urb(usbtouch->irq, udev,
 			 usb_rcvintpipe(udev, endpoint->bEndpointAddress),
 			 usbtouch->data, type->rept_size,
 			 usbtouch_irq, usbtouch, endpoint->bInterval);
+	else
+		usb_fill_bulk_urb(usbtouch->irq, udev,
+			 usb_rcvbulkpipe(udev, endpoint->bEndpointAddress),
+			 usbtouch->data, type->rept_size,
+			 usbtouch_irq, usbtouch);
 
 	usbtouch->irq->dev = udev;
 	usbtouch->irq->transfer_dma = usbtouch->data_dma;
_
