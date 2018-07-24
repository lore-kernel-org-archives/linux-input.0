From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/5] Input: pxrc - fix freeing URB on device teardown
Date: Tue, 24 Jul 2018 02:35:17 +0000
Message-ID: <20180724023520.2189-2-dmitry.torokhov@gmail.com>
References: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>
List-Id: linux-input@vger.kernel.org

URB is the only resource that is not managed, and thus is destroyed too early,
before we unregister input device and stop URB in pxrc_close(). To fix it let's
install custom devm handler to free the URB at the right time in devm unwind
sequence.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/pxrc.c | 66 ++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 000b9b7da744..1560f0e39c34 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -119,49 +119,52 @@ static void pxrc_close(struct input_dev *input)
 	mutex_unlock(&pxrc->pm_mutex);
 }
 
+static void pxrc_free_urb(void *_pxrc)
+{
+	struct pxrc *pxrc = _pxrc;
+
+	usb_free_urb(pxrc->urb);
+}
+
 static int pxrc_usb_init(struct pxrc *pxrc)
 {
 	struct usb_device *udev = interface_to_usbdev(pxrc->intf);
 	struct usb_endpoint_descriptor *epirq;
 	unsigned int pipe;
-	int retval;
+	int error;
 
 	/* Set up the endpoint information */
 	/* This device only has an interrupt endpoint */
-	retval = usb_find_common_endpoints(pxrc->intf->cur_altsetting,
-			NULL, NULL, &epirq, NULL);
-	if (retval) {
-		dev_err(&pxrc->intf->dev,
-			"Could not find endpoint\n");
-		goto error;
+	error = usb_find_common_endpoints(pxrc->intf->cur_altsetting,
+					  NULL, NULL, &epirq, NULL);
+	if (error) {
+		dev_err(&pxrc->intf->dev, "Could not find endpoint\n");
+		return error;
 	}
 
 	pxrc->bsize = usb_endpoint_maxp(epirq);
 	pxrc->epaddr = epirq->bEndpointAddress;
 	pxrc->data = devm_kmalloc(&pxrc->intf->dev, pxrc->bsize, GFP_KERNEL);
-	if (!pxrc->data) {
-		retval = -ENOMEM;
-		goto error;
-	}
+	if (!pxrc->data)
+		return -ENOMEM;
 
 	usb_set_intfdata(pxrc->intf, pxrc);
 	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
 	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
 
 	pxrc->urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!pxrc->urb) {
-		retval = -ENOMEM;
-		goto error;
-	}
+	if (!pxrc->urb)
+		return -ENOMEM;
+
+	error = devm_add_action_or_reset(&pxrc->intf->dev, pxrc_free_urb, pxrc);
+	if (error)
+		return error;
 
 	pipe = usb_rcvintpipe(udev, pxrc->epaddr),
 	usb_fill_int_urb(pxrc->urb, udev, pipe, pxrc->data, pxrc->bsize,
 			 pxrc_usb_irq, pxrc, 1);
 
-error:
-	return retval;
-
-
+	return 0;
 }
 
 static int pxrc_input_init(struct pxrc *pxrc)
@@ -197,7 +200,7 @@ static int pxrc_probe(struct usb_interface *intf,
 		      const struct usb_device_id *id)
 {
 	struct pxrc *pxrc;
-	int retval;
+	int error;
 
 	pxrc = devm_kzalloc(&intf->dev, sizeof(*pxrc), GFP_KERNEL);
 	if (!pxrc)
@@ -206,29 +209,20 @@ static int pxrc_probe(struct usb_interface *intf,
 	mutex_init(&pxrc->pm_mutex);
 	pxrc->intf = intf;
 
-	retval = pxrc_usb_init(pxrc);
-	if (retval)
-		goto error;
+	error = pxrc_usb_init(pxrc);
+	if (error)
+		return error;
 
-	retval = pxrc_input_init(pxrc);
-	if (retval)
-		goto err_free_urb;
+	error = pxrc_input_init(pxrc);
+	if (error)
+		return error;
 
 	return 0;
-
-err_free_urb:
-	usb_free_urb(pxrc->urb);
-
-error:
-	return retval;
 }
 
 static void pxrc_disconnect(struct usb_interface *intf)
 {
-	struct pxrc *pxrc = usb_get_intfdata(intf);
-
-	usb_free_urb(pxrc->urb);
-	usb_set_intfdata(intf, NULL);
+	/* All driver resources are devm-managed. */
 }
 
 static int pxrc_suspend(struct usb_interface *intf, pm_message_t message)
-- 
2.11.0
