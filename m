From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] input: pxrc - do not store USB device in private struct
Date: Mon, 16 Jul 2018 16:40:14 +0200
Message-ID: <20180716144014.6331-1-marcus.folkesson@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Marcus Folkesson <marcus.folkesson@gmail.com>, Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The USB device is only needed during setup, so put it back after
initialization and do not store it in our private struct.

Also, the USB device is a parent of USB interface so our driver
model rules ensure that USB device should not disappear while
interface device is still there.
So not keep a refcount on the device is safe.

Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/input/joystick/pxrc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 07a0dbd3ced2..46a7acb747bf 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -27,7 +27,6 @@ MODULE_DEVICE_TABLE(usb, pxrc_table);
 
 struct pxrc {
 	struct input_dev	*input;
-	struct usb_device	*udev;
 	struct usb_interface	*intf;
 	struct urb		*urb;
 	struct mutex		pm_mutex;
@@ -120,7 +119,7 @@ static void pxrc_close(struct input_dev *input)
 	mutex_unlock(&pxrc->pm_mutex);
 }
 
-static int pxrc_usb_init(struct pxrc *pxrc)
+static int pxrc_usb_init(struct pxrc *pxrc, struct usb_device *udev)
 {
 	struct usb_endpoint_descriptor *epirq;
 	unsigned int pipe;
@@ -145,7 +144,7 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 	}
 
 	usb_set_intfdata(pxrc->intf, pxrc);
-	usb_make_path(pxrc->udev, pxrc->phys, sizeof(pxrc->phys));
+	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
 	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
 
 	pxrc->urb = usb_alloc_urb(0, GFP_KERNEL);
@@ -154,8 +153,8 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 		goto error;
 	}
 
-	pipe = usb_rcvintpipe(pxrc->udev, pxrc->epaddr),
-	usb_fill_int_urb(pxrc->urb, pxrc->udev, pipe, pxrc->data, pxrc->bsize,
+	pipe = usb_rcvintpipe(udev, pxrc->epaddr),
+	usb_fill_int_urb(pxrc->urb, udev, pipe, pxrc->data, pxrc->bsize,
 						pxrc_usb_irq, pxrc, 1);
 
 error:
@@ -164,7 +163,7 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 
 }
 
-static int pxrc_input_init(struct pxrc *pxrc)
+static int pxrc_input_init(struct pxrc *pxrc, struct usb_device *udev)
 {
 	pxrc->input = devm_input_allocate_device(&pxrc->intf->dev);
 	if (pxrc->input == NULL) {
@@ -174,7 +173,7 @@ static int pxrc_input_init(struct pxrc *pxrc)
 
 	pxrc->input->name = "PXRC Flight Controller Adapter";
 	pxrc->input->phys = pxrc->phys;
-	usb_to_input_id(pxrc->udev, &pxrc->input->id);
+	usb_to_input_id(udev, &pxrc->input->id);
 
 	pxrc->input->open = pxrc_open;
 	pxrc->input->close = pxrc_close;
@@ -197,6 +196,7 @@ static int pxrc_probe(struct usb_interface *intf,
 		      const struct usb_device_id *id)
 {
 	struct pxrc *pxrc;
+	struct usb_device *udev;
 	int retval;
 
 	pxrc = devm_kzalloc(&intf->dev, sizeof(*pxrc), GFP_KERNEL);
@@ -204,23 +204,25 @@ static int pxrc_probe(struct usb_interface *intf,
 		return -ENOMEM;
 
 	mutex_init(&pxrc->pm_mutex);
-	pxrc->udev = usb_get_dev(interface_to_usbdev(intf));
+	udev = usb_get_dev(interface_to_usbdev(intf));
 	pxrc->intf = intf;
 
-	retval = pxrc_usb_init(pxrc);
+	retval = pxrc_usb_init(pxrc, udev);
 	if (retval)
 		goto error;
 
-	retval = pxrc_input_init(pxrc);
+	retval = pxrc_input_init(pxrc, udev);
 	if (retval)
 		goto err_free_urb;
 
+	usb_put_dev(udev);
 	return 0;
 
 err_free_urb:
 	usb_free_urb(pxrc->urb);
 
 error:
+	usb_put_dev(udev);
 	return retval;
 }
 
-- 
2.18.0
