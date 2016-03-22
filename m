From: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
Subject: [PATCH 3/4] gtco: stop saving struct usb_device
Date: Tue, 22 Mar 2016 16:04:56 +0100
Message-ID: <1458659097-8213-4-git-send-email-oneukum@suse.com>
References: <1458659097-8213-1-git-send-email-oneukum@suse.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458659097-8213-1-git-send-email-oneukum-IBi9RG/b67k@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
List-Id: linux-input@vger.kernel.org

The device can now easily be derived from the interface.
Stop leaving a private copy.

Signed-off-by: Oliver Neukum <oneukum-IBi9RG/b67k@public.gmane.org>
---
 drivers/input/tablet/gtco.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/input/tablet/gtco.c b/drivers/input/tablet/gtco.c
index 3a7f3a4..362ae3b 100644
--- a/drivers/input/tablet/gtco.c
+++ b/drivers/input/tablet/gtco.c
@@ -104,7 +104,6 @@ MODULE_DEVICE_TABLE (usb, gtco_usbid_table);
 struct gtco {
 
 	struct input_dev  *inputdevice; /* input device struct pointer  */
-	struct usb_device *usbdev; /* the usb device for this device */
 	struct usb_interface *intf;	/* the usb interface for this device */
 	struct urb        *urbinfo;	 /* urb for incoming reports      */
 	dma_addr_t        buf_dma;  /* dma addr of the data buffer*/
@@ -540,7 +539,7 @@ static int gtco_input_open(struct input_dev *inputdev)
 {
 	struct gtco *device = input_get_drvdata(inputdev);
 
-	device->urbinfo->dev = device->usbdev;
+	device->urbinfo->dev = interface_to_usbdev(device->intf);
 	if (usb_submit_urb(device->urbinfo, GFP_KERNEL))
 		return -EIO;
 
@@ -824,6 +823,7 @@ static int gtco_probe(struct usb_interface *usbinterface,
 	int                     result = 0, retry;
 	int			error;
 	struct usb_endpoint_descriptor *endpoint;
+	struct usb_device	*udev = interface_to_usbdev(usbinterface);
 
 	/* Allocate memory for device structure */
 	gtco = kzalloc(sizeof(struct gtco), GFP_KERNEL);
@@ -838,11 +838,10 @@ static int gtco_probe(struct usb_interface *usbinterface,
 	gtco->inputdevice = input_dev;
 
 	/* Save interface information */
-	gtco->usbdev = interface_to_usbdev(usbinterface);
 	gtco->intf = usbinterface;
 
 	/* Allocate some data for incoming reports */
-	gtco->buffer = usb_alloc_coherent(gtco->usbdev, REPORT_MAX_SIZE,
+	gtco->buffer = usb_alloc_coherent(udev, REPORT_MAX_SIZE,
 					  GFP_KERNEL, &gtco->buf_dma);
 	if (!gtco->buffer) {
 		dev_err(&usbinterface->dev, "No more memory for us buffers\n");
@@ -899,8 +898,8 @@ static int gtco_probe(struct usb_interface *usbinterface,
 
 	/* Couple of tries to get reply */
 	for (retry = 0; retry < 3; retry++) {
-		result = usb_control_msg(gtco->usbdev,
-					 usb_rcvctrlpipe(gtco->usbdev, 0),
+		result = usb_control_msg(udev,
+					 usb_rcvctrlpipe(udev, 0),
 					 USB_REQ_GET_DESCRIPTOR,
 					 USB_RECIP_INTERFACE | USB_DIR_IN,
 					 REPORT_DEVICE_TYPE << 8,
@@ -928,7 +927,7 @@ static int gtco_probe(struct usb_interface *usbinterface,
 	}
 
 	/* Create a device file node */
-	usb_make_path(gtco->usbdev, gtco->usbpath, sizeof(gtco->usbpath));
+	usb_make_path(udev, gtco->usbpath, sizeof(gtco->usbpath));
 	strlcat(gtco->usbpath, "/input0", sizeof(gtco->usbpath));
 
 	/* Set Input device functions */
@@ -945,15 +944,15 @@ static int gtco_probe(struct usb_interface *usbinterface,
 	gtco_setup_caps(input_dev);
 
 	/* Set input device required ID information */
-	usb_to_input_id(gtco->usbdev, &input_dev->id);
+	usb_to_input_id(udev, &input_dev->id);
 	input_dev->dev.parent = &usbinterface->dev;
 
 	/* Setup the URB, it will be posted later on open of input device */
 	endpoint = &usbinterface->altsetting[0].endpoint[0].desc;
 
 	usb_fill_int_urb(gtco->urbinfo,
-			 gtco->usbdev,
-			 usb_rcvintpipe(gtco->usbdev,
+			 udev,
+			 usb_rcvintpipe(udev,
 					endpoint->bEndpointAddress),
 			 gtco->buffer,
 			 REPORT_MAX_SIZE,
@@ -977,7 +976,7 @@ static int gtco_probe(struct usb_interface *usbinterface,
  err_free_urb:
 	usb_free_urb(gtco->urbinfo);
  err_free_buf:
-	usb_free_coherent(gtco->usbdev, REPORT_MAX_SIZE,
+	usb_free_coherent(udev, REPORT_MAX_SIZE,
 			  gtco->buffer, gtco->buf_dma);
  err_free_devs:
 	input_free_device(input_dev);
@@ -994,13 +993,14 @@ static void gtco_disconnect(struct usb_interface *interface)
 {
 	/* Grab private device ptr */
 	struct gtco *gtco = usb_get_intfdata(interface);
+	struct usb_device *udev = interface_to_usbdev(interface);
 
 	/* Now reverse all the registration stuff */
 	if (gtco) {
 		input_unregister_device(gtco->inputdevice);
 		usb_kill_urb(gtco->urbinfo);
 		usb_free_urb(gtco->urbinfo);
-		usb_free_coherent(gtco->usbdev, REPORT_MAX_SIZE,
+		usb_free_coherent(udev, REPORT_MAX_SIZE,
 				  gtco->buffer, gtco->buf_dma);
 		kfree(gtco);
 	}
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
