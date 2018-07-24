From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/5] Input: pxrc - flatten probe code
Date: Tue, 24 Jul 2018 02:35:20 +0000
Message-ID: <20180724023520.2189-5-dmitry.torokhov@gmail.com>
References: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>
List-Id: linux-input@vger.kernel.org

Instead of splitting probe code into separate USB and input setup, flatten it.
This allows for easier inspection of order of set up steps, since the probe code
is reasonably small.

Move input-related initialization (phys) from USB block to input block.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/pxrc.c | 84 ++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 49 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 887a0df9d9a7..ea2bf5951d67 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -3,7 +3,6 @@
  * Driver for Phoenix RC Flight Controller Adapter
  *
  * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
- *
  */
 
 #include <linux/kernel.h>
@@ -16,8 +15,8 @@
 #include <linux/mutex.h>
 #include <linux/input.h>
 
-#define PXRC_VENDOR_ID	(0x1781)
-#define PXRC_PRODUCT_ID	(0x0898)
+#define PXRC_VENDOR_ID		0x1781
+#define PXRC_PRODUCT_ID		0x0898
 
 struct pxrc {
 	struct input_dev	*input;
@@ -118,59 +117,66 @@ static void pxrc_free_urb(void *_pxrc)
 	usb_free_urb(pxrc->urb);
 }
 
-static int pxrc_usb_init(struct pxrc *pxrc)
+static int pxrc_probe(struct usb_interface *intf,
+		      const struct usb_device_id *id)
 {
-	struct usb_device *udev = interface_to_usbdev(pxrc->intf);
+	struct usb_device *udev = interface_to_usbdev(intf);
+	struct pxrc *pxrc;
 	struct usb_endpoint_descriptor *epirq;
 	size_t xfer_size;
 	void *xfer_buf;
-	unsigned int pipe;
 	int error;
 
-	/* Set up the endpoint information */
-	/* This device only has an interrupt endpoint */
-	error = usb_find_common_endpoints(pxrc->intf->cur_altsetting,
+	/*
+	 * Locate the endpoint information. This device only has an
+	 * interrupt endpoint.
+	 */
+	error = usb_find_common_endpoints(intf->cur_altsetting,
 					  NULL, NULL, &epirq, NULL);
 	if (error) {
-		dev_err(&pxrc->intf->dev, "Could not find endpoint\n");
+		dev_err(&intf->dev, "Could not find endpoint\n");
 		return error;
 	}
 
-	xfer_size = usb_endpoint_maxp(epirq);
-	xfer_buf = devm_kmalloc(&pxrc->intf->dev, xfer_size, GFP_KERNEL);
-	if (!xfer_buf)
+	pxrc = devm_kzalloc(&intf->dev, sizeof(*pxrc), GFP_KERNEL);
+	if (!pxrc)
 		return -ENOMEM;
 
+	mutex_init(&pxrc->pm_mutex);
+	pxrc->intf = intf;
+
 	usb_set_intfdata(pxrc->intf, pxrc);
-	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
-	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
+
+	xfer_size = usb_endpoint_maxp(epirq);
+	xfer_buf = devm_kmalloc(&intf->dev, xfer_size, GFP_KERNEL);
+	if (!xfer_buf)
+		return -ENOMEM;
 
 	pxrc->urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!pxrc->urb)
 		return -ENOMEM;
 
-	error = devm_add_action_or_reset(&pxrc->intf->dev, pxrc_free_urb, pxrc);
+	error = devm_add_action_or_reset(&intf->dev, pxrc_free_urb, pxrc);
 	if (error)
 		return error;
 
-	pipe = usb_rcvintpipe(udev, epirq->bEndpointAddress),
-	usb_fill_int_urb(pxrc->urb, udev, pipe, xfer_buf, xfer_size,
-			 pxrc_usb_irq, pxrc, 1);
+	usb_fill_int_urb(pxrc->urb, udev,
+			 usb_rcvintpipe(udev, epirq->bEndpointAddress),
+			 xfer_buf, xfer_size, pxrc_usb_irq, pxrc, 1);
 
-	return 0;
-}
-
-static int pxrc_input_init(struct pxrc *pxrc)
-{
-	pxrc->input = devm_input_allocate_device(&pxrc->intf->dev);
-	if (pxrc->input == NULL) {
-		dev_err(&pxrc->intf->dev, "couldn't allocate input device\n");
+	pxrc->input = devm_input_allocate_device(&intf->dev);
+	if (!pxrc->input) {
+		dev_err(&intf->dev, "couldn't allocate input device\n");
 		return -ENOMEM;
 	}
 
 	pxrc->input->name = "PXRC Flight Controller Adapter";
+
+	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
+	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
 	pxrc->input->phys = pxrc->phys;
-	usb_to_input_id(interface_to_usbdev(pxrc->intf), &pxrc->input->id);
+
+	usb_to_input_id(udev, &pxrc->input->id);
 
 	pxrc->input->open = pxrc_open;
 	pxrc->input->close = pxrc_close;
@@ -186,27 +192,7 @@ static int pxrc_input_init(struct pxrc *pxrc)
 
 	input_set_drvdata(pxrc->input, pxrc);
 
-	return input_register_device(pxrc->input);
-}
-
-static int pxrc_probe(struct usb_interface *intf,
-		      const struct usb_device_id *id)
-{
-	struct pxrc *pxrc;
-	int error;
-
-	pxrc = devm_kzalloc(&intf->dev, sizeof(*pxrc), GFP_KERNEL);
-	if (!pxrc)
-		return -ENOMEM;
-
-	mutex_init(&pxrc->pm_mutex);
-	pxrc->intf = intf;
-
-	error = pxrc_usb_init(pxrc);
-	if (error)
-		return error;
-
-	error = pxrc_input_init(pxrc);
+	error = input_register_device(pxrc->input);
 	if (error)
 		return error;
 
-- 
2.11.0
