From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/5] Input: pxrc - do not store unneeded data in driver structure
Date: Tue, 24 Jul 2018 02:35:19 +0000
Message-ID: <20180724023520.2189-4-dmitry.torokhov@gmail.com>
References: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180724023520.2189-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>
List-Id: linux-input@vger.kernel.org

There is no need to store data buffer size, pointer to the buffer, or endpoint
address in pxrc structure, as they are either only needed during setup, or are
available from elsewhere.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/pxrc.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
index 327b5ef8515f..887a0df9d9a7 100644
--- a/drivers/input/joystick/pxrc.c
+++ b/drivers/input/joystick/pxrc.c
@@ -25,15 +25,13 @@ struct pxrc {
 	struct urb		*urb;
 	struct mutex		pm_mutex;
 	bool			is_open;
-	__u8			epaddr;
 	char			phys[64];
-	unsigned char           *data;
-	size_t			bsize;
 };
 
 static void pxrc_usb_irq(struct urb *urb)
 {
 	struct pxrc *pxrc = urb->context;
+	u8 *data = urb->transfer_buffer;
 	int error;
 
 	switch (urb->status) {
@@ -61,15 +59,15 @@ static void pxrc_usb_irq(struct urb *urb)
 	}
 
 	if (urb->actual_length == 8) {
-		input_report_abs(pxrc->input, ABS_X, pxrc->data[0]);
-		input_report_abs(pxrc->input, ABS_Y, pxrc->data[2]);
-		input_report_abs(pxrc->input, ABS_RX, pxrc->data[3]);
-		input_report_abs(pxrc->input, ABS_RY, pxrc->data[4]);
-		input_report_abs(pxrc->input, ABS_RUDDER, pxrc->data[5]);
-		input_report_abs(pxrc->input, ABS_THROTTLE, pxrc->data[6]);
-		input_report_abs(pxrc->input, ABS_MISC, pxrc->data[7]);
-
-		input_report_key(pxrc->input, BTN_A, pxrc->data[1]);
+		input_report_abs(pxrc->input, ABS_X, data[0]);
+		input_report_abs(pxrc->input, ABS_Y, data[2]);
+		input_report_abs(pxrc->input, ABS_RX, data[3]);
+		input_report_abs(pxrc->input, ABS_RY, data[4]);
+		input_report_abs(pxrc->input, ABS_RUDDER, data[5]);
+		input_report_abs(pxrc->input, ABS_THROTTLE, data[6]);
+		input_report_abs(pxrc->input, ABS_MISC, data[7]);
+
+		input_report_key(pxrc->input, BTN_A, data[1]);
 	}
 
 exit:
@@ -124,6 +122,8 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 {
 	struct usb_device *udev = interface_to_usbdev(pxrc->intf);
 	struct usb_endpoint_descriptor *epirq;
+	size_t xfer_size;
+	void *xfer_buf;
 	unsigned int pipe;
 	int error;
 
@@ -136,10 +136,9 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 		return error;
 	}
 
-	pxrc->bsize = usb_endpoint_maxp(epirq);
-	pxrc->epaddr = epirq->bEndpointAddress;
-	pxrc->data = devm_kmalloc(&pxrc->intf->dev, pxrc->bsize, GFP_KERNEL);
-	if (!pxrc->data)
+	xfer_size = usb_endpoint_maxp(epirq);
+	xfer_buf = devm_kmalloc(&pxrc->intf->dev, xfer_size, GFP_KERNEL);
+	if (!xfer_buf)
 		return -ENOMEM;
 
 	usb_set_intfdata(pxrc->intf, pxrc);
@@ -154,8 +153,8 @@ static int pxrc_usb_init(struct pxrc *pxrc)
 	if (error)
 		return error;
 
-	pipe = usb_rcvintpipe(udev, pxrc->epaddr),
-	usb_fill_int_urb(pxrc->urb, udev, pipe, pxrc->data, pxrc->bsize,
+	pipe = usb_rcvintpipe(udev, epirq->bEndpointAddress),
+	usb_fill_int_urb(pxrc->urb, udev, pipe, xfer_buf, xfer_size,
 			 pxrc_usb_irq, pxrc, 1);
 
 	return 0;
-- 
2.11.0
