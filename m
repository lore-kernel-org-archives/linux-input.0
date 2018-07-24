From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/5] Input: pxrc - do not store USB device in private struct
Date: Tue, 24 Jul 2018 02:35:16 +0000
Message-ID: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>
List-Id: linux-input@vger.kernel.org

From: Marcus Folkesson <marcus.folkesson@gmail.com>

The USB device is only needed during setup, so put it back after
initialization and do not store it in our private struct.

Also, the USB device is a parent of USB interface so our driver
model rules ensure that USB device should not disappear while
interface device is still there; there is no need to take reference
to the USB device.

Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Patchwork-Id: 10526903
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/pxrc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 07a0dbd3ced2..000b9b7da744 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -27,7 +27,6 @@ MODULE_DEVICE_TABLE(usb, pxrc_table);
 
 struct pxrc {
 	struct input_dev	*input;
-	struct usb_device	*udev;
 	struct usb_interface	*intf;
 	struct urb		*urb;
 	struct mutex		pm_mutex;
@@ -122,6 +121,7 @@ static void pxrc_close(struct input_dev *input)
 
 static int pxrc_usb_init(struct pxrc *pxrc)
 {
+	struct usb_device *udev = interface_to_usbdev(pxrc->intf);
 	struct usb_endpoint_descriptor *epirq;
 	unsigned int pipe;
 	int retval;
@@ -145,7 +145,7 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 	}
 
 	usb_set_intfdata(pxrc->intf, pxrc);
-	usb_make_path(pxrc->udev, pxrc->phys, sizeof(pxrc->phys));
+	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
 	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
 
 	pxrc->urb = usb_alloc_urb(0, GFP_KERNEL);
@@ -154,9 +154,9 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 		goto error;
 	}
 
-	pipe = usb_rcvintpipe(pxrc->udev, pxrc->epaddr),
-	usb_fill_int_urb(pxrc->urb, pxrc->udev, pipe, pxrc->data, pxrc->bsize,
-						pxrc_usb_irq, pxrc, 1);
+	pipe = usb_rcvintpipe(udev, pxrc->epaddr),
+	usb_fill_int_urb(pxrc->urb, udev, pipe, pxrc->data, pxrc->bsize,
+			 pxrc_usb_irq, pxrc, 1);
 
 error:
 	return retval;
@@ -174,7 +174,7 @@ static int pxrc_input_init(struct pxrc *pxrc)
 
 	pxrc->input->name = "PXRC Flight Controller Adapter";
 	pxrc->input->phys = pxrc->phys;
-	usb_to_input_id(pxrc->udev, &pxrc->input->id);
+	usb_to_input_id(interface_to_usbdev(pxrc->intf), &pxrc->input->id);
 
 	pxrc->input->open = pxrc_open;
 	pxrc->input->close = pxrc_close;
@@ -204,7 +204,6 @@ static int pxrc_probe(struct usb_interface *intf,
 		return -ENOMEM;
 
 	mutex_init(&pxrc->pm_mutex);
-	pxrc->udev = usb_get_dev(interface_to_usbdev(intf));
 	pxrc->intf = intf;
 
 	retval = pxrc_usb_init(pxrc);
-- 
2.11.0
