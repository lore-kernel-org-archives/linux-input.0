From: Christian Engelmayer <christian.engelmayer-USXAA5bZaHGDvotElmWtJA@public.gmane.org>
Subject: [PATCH v2] Input: usbtouchscreen - separate report and transmit
 buffer size handling
Date: Wed, 16 Oct 2013 23:15:44 +0200
Message-ID: <20131016231544.38b118bd@frequentis.com>
References: <20131015165000.5987a916@frequentis.com>
	<20131016062902.GA4282@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131016062902.GA4282-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Forest Bond <forest.bond-XbHmxybg72Wcj+tRJgl41g@public.gmane.org>, Daniel Ritz <daniel.ritz-OI3hZJvNYWs@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, christian.engelmayer-USXAA5bZaHGDvotElmWtJA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This patch supports the separate handling of the USB transfer buffer length
and the length of the buffer used for multi packet support. For devices
supporting multiple report or diagnostic packets, the USB transfer size is now
limited to the USB endpoints wMaxPacketSize - otherwise it defaults to the
configured report packet size as before

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

Signed-off-by: Christian Engelmayer <christian.engelmayer-USXAA5bZaHGDvotElmWtJA@public.gmane.org>
---
v2: Added changes suggested by Dmitry Torokhov:

    * Prefer a temporary variable over a multiple conversion of wMaxPaxetSize.
    * Avoid further modifiction of the shared device info structure.

The existing violation in the probe function

	if (!type->process_pkt)
		type->process_pkt = usbtouch_process_pkt;

seems to be conveniance triggered and while at least at the moment applicable
for all devices of a type, could be easily removed. For a complete cleanup and
eg. setting the shared device information 'const', we would have to adapt the
Nexio support first - nexio_read_data:

	if (!usbtouch->type->max_xc) {
		usbtouch->type->max_xc = 2 * x_len;
		input_set_abs_params(usbtouch->input, ABS_X,
				     0, usbtouch->type->max_xc, 0, 0);
		usbtouch->type->max_yc = 2 * y_len;
		input_set_abs_params(usbtouch->input, ABS_Y,
				     0, usbtouch->type->max_yc, 0, 0);
	}
---
 drivers/input/touchscreen/usbtouchscreen.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 721fdb3..d632848 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -106,6 +106,7 @@ struct usbtouch_device_info {
 struct usbtouch_usb {
 	unsigned char *data;
 	dma_addr_t data_dma;
+	int data_size;
 	unsigned char *buffer;
 	int buf_len;
 	struct urb *irq;
@@ -1523,7 +1524,7 @@ static int usbtouch_reset_resume(struct usb_interface *intf)
 static void usbtouch_free_buffers(struct usb_device *udev,
 				  struct usbtouch_usb *usbtouch)
 {
-	usb_free_coherent(udev, usbtouch->type->rept_size,
+	usb_free_coherent(udev, usbtouch->data_size,
 			  usbtouch->data, usbtouch->data_dma);
 	kfree(usbtouch->buffer);
 }
@@ -1548,6 +1549,7 @@ static int usbtouch_probe(struct usb_interface *intf,
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_device *udev = interface_to_usbdev(intf);
 	struct usbtouch_device_info *type;
+	int wMaxPacketSize;
 	int err = -ENOMEM;
 
 	/* some devices are ignored */
@@ -1557,6 +1559,7 @@ static int usbtouch_probe(struct usb_interface *intf,
 	endpoint = usbtouch_get_input_endpoint(intf->cur_altsetting);
 	if (!endpoint)
 		return -ENXIO;
+	wMaxPacketSize = le16_to_cpu(endpoint->wMaxPacketSize);
 
 	usbtouch = kzalloc(sizeof(struct usbtouch_usb), GFP_KERNEL);
 	input_dev = input_allocate_device();
@@ -1568,7 +1571,9 @@ static int usbtouch_probe(struct usb_interface *intf,
 	if (!type->process_pkt)
 		type->process_pkt = usbtouch_process_pkt;
 
-	usbtouch->data = usb_alloc_coherent(udev, type->rept_size,
+	usbtouch->data_size = (type->get_pkt_len) ?
+			min(type->rept_size, wMaxPacketSize) : type->rept_size;
+	usbtouch->data = usb_alloc_coherent(udev, usbtouch->data_size,
 					    GFP_KERNEL, &usbtouch->data_dma);
 	if (!usbtouch->data)
 		goto out_free;
@@ -1628,12 +1633,12 @@ static int usbtouch_probe(struct usb_interface *intf,
 	if (usb_endpoint_type(endpoint) == USB_ENDPOINT_XFER_INT)
 		usb_fill_int_urb(usbtouch->irq, udev,
 			 usb_rcvintpipe(udev, endpoint->bEndpointAddress),
-			 usbtouch->data, type->rept_size,
+			 usbtouch->data, usbtouch->data_size,
 			 usbtouch_irq, usbtouch, endpoint->bInterval);
 	else
 		usb_fill_bulk_urb(usbtouch->irq, udev,
 			 usb_rcvbulkpipe(udev, endpoint->bEndpointAddress),
-			 usbtouch->data, type->rept_size,
+			 usbtouch->data, usbtouch->data_size,
 			 usbtouch_irq, usbtouch);
 
 	usbtouch->irq->dev = udev;
-- 
1.7.2.5
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
