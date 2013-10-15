From: Christian Engelmayer <christian.engelmayer@frequentis.com>
Subject: [PATCH] Input: usbtouchscreen - separate report and transmit buffer
 size handling
Date: Tue, 15 Oct 2013 16:50:00 +0200
Message-ID: <20131015165000.5987a916@frequentis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail1.frequentis.com ([195.20.158.50]:33493 "EHLO
	mail1.frequentis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932202Ab3JOOuI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Oct 2013 10:50:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Forest Bond <forest.bond@rapidrollout.com>, Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, christian.engelmayer@frequentis.com

This patch supports the separate handling of the USB transfer buffer length
and the length of the buffer used for multi packet support. The USB transfer
size can now be explicitly configured via the device_info record. Otherwise
it defaults to the configured report packet size as before. For devices
supporting multiple report or diagnostic packets, the USB transfer size is
now reduced to the USB endpoints wMaxPacketSize if not explicitly set.

This fixes an issue where event reporting can be delayed for an arbitrary
time for multi packet devices. For instance the report size for eGalax devices
is defined to the 16 byte maximum diagnostic packet size as opposed to the 5
byte report packet size. In case the driver requests 16 byte from the USB
interrupt endpoint, the USB host controller driver needs to split up the
request into 2 accesses according to the endpoints wMaxPacketSize of 8 byte.
When the first transfer is answered by the eGalax device with not less than
the full 8 byte requested, the host controller has got no way of knowing
whether the touch controller has got additional data queued and will issue
the second transfer. If per example a liftoff event finishes at such a
wMaxPacketSize boundary, the data will not be available to the usbtouch driver
until a further event is triggered and transfered to the host. From user
perspective the BTN_TOUCH release event in this case is stuck until the next
touch down event.

Signed-off-by: Christian Engelmayer <christian.engelmayer@frequentis.com>
---
 drivers/input/touchscreen/usbtouchscreen.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 721fdb3..aa1f6a7 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -76,6 +76,7 @@ struct usbtouch_device_info {
 	int min_yc, max_yc;
 	int min_press, max_press;
 	int rept_size;
+	int xmit_size;
 
 	/*
 	 * Always service the USB devices irq not just when the input device is
@@ -1523,7 +1524,7 @@ static int usbtouch_reset_resume(struct usb_interface *intf)
 static void usbtouch_free_buffers(struct usb_device *udev,
 				  struct usbtouch_usb *usbtouch)
 {
-	usb_free_coherent(udev, usbtouch->type->rept_size,
+	usb_free_coherent(udev, usbtouch->type->xmit_size,
 			  usbtouch->data, usbtouch->data_dma);
 	kfree(usbtouch->buffer);
 }
@@ -1567,8 +1568,15 @@ static int usbtouch_probe(struct usb_interface *intf,
 	usbtouch->type = type;
 	if (!type->process_pkt)
 		type->process_pkt = usbtouch_process_pkt;
+	if (!type->xmit_size) {
+		if ((type->get_pkt_len) &&
+		    (type->rept_size > le16_to_cpu(endpoint->wMaxPacketSize)))
+			type->xmit_size = le16_to_cpu(endpoint->wMaxPacketSize);
+		else
+			type->xmit_size = type->rept_size;
+	}
 
-	usbtouch->data = usb_alloc_coherent(udev, type->rept_size,
+	usbtouch->data = usb_alloc_coherent(udev, type->xmit_size,
 					    GFP_KERNEL, &usbtouch->data_dma);
 	if (!usbtouch->data)
 		goto out_free;
@@ -1628,12 +1636,12 @@ static int usbtouch_probe(struct usb_interface *intf,
 	if (usb_endpoint_type(endpoint) == USB_ENDPOINT_XFER_INT)
 		usb_fill_int_urb(usbtouch->irq, udev,
 			 usb_rcvintpipe(udev, endpoint->bEndpointAddress),
-			 usbtouch->data, type->rept_size,
+			 usbtouch->data, type->xmit_size,
 			 usbtouch_irq, usbtouch, endpoint->bInterval);
 	else
 		usb_fill_bulk_urb(usbtouch->irq, udev,
 			 usb_rcvbulkpipe(udev, endpoint->bEndpointAddress),
-			 usbtouch->data, type->rept_size,
+			 usbtouch->data, type->xmit_size,
 			 usbtouch_irq, usbtouch);
 
 	usbtouch->irq->dev = udev;
-- 
1.7.2.5

