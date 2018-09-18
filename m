From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 09/20] Input: iforce - use DMA-safe buffer when getting IDs from USB
Date: Mon, 17 Sep 2018 17:47:21 -0700
Message-ID: <20180918004732.9875-9-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

When working with USB devices we need to use DMA-safe buffers,
and iforce->edata is not one. Let's rework the code to allocate
temporary buffer (iforce_get_id() is called only during initialization
so there is no reason to have permanent buffer) and use it. While at it,
let's utilize usb_control_msg() API which simplifies code.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-usb.c | 68 +++++++---------------
 1 file changed, 22 insertions(+), 46 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 9d635f01cf19..cefaa1c5abc7 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -29,8 +29,7 @@ struct iforce_usb {
 
 	struct usb_device *usbdev;
 	struct usb_interface *intf;
-	struct urb *irq, *out, *ctrl;
-	struct usb_ctrlrequest cr;
+	struct urb *irq, *out;
 };
 
 static void __iforce_usb_xmit(struct iforce *iforce)
@@ -92,30 +91,32 @@ static int iforce_usb_get_id(struct iforce *iforce, u8 *packet)
 {
 	struct iforce_usb *iforce_usb = container_of(iforce, struct iforce_usb,
 						     iforce);
+	u8 *buf;
 	int status;
 
-	iforce_usb->cr.bRequest = packet[0];
-	iforce_usb->ctrl->dev = iforce_usb->usbdev;
-
-	status = usb_submit_urb(iforce_usb->ctrl, GFP_KERNEL);
-	if (status) {
+	buf = kmalloc(IFORCE_MAX_LENGTH, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	status = usb_control_msg(iforce_usb->usbdev,
+				 usb_rcvctrlpipe(iforce_usb->usbdev, 0),
+				 packet[0],
+				 USB_TYPE_VENDOR | USB_DIR_IN |
+					USB_RECIP_INTERFACE,
+				 0, 0, buf, IFORCE_MAX_LENGTH, HZ);
+	if (status < 0) {
 		dev_err(&iforce_usb->intf->dev,
-			"usb_submit_urb failed %d\n", status);
-		return -EIO;
-	}
-
-	wait_event_interruptible_timeout(iforce->wait,
-		iforce_usb->ctrl->status != -EINPROGRESS, HZ);
-
-	if (iforce_usb->ctrl->status) {
-		dev_dbg(&iforce_usb->intf->dev,
-			"iforce->ctrl->status = %d\n",
-			iforce_usb->ctrl->status);
-		usb_unlink_urb(iforce_usb->ctrl);
-		return -EIO;
+			"usb_submit_urb failed: %d\n", status);
+	} else if (buf[0] != packet[0]) {
+		status = -EIO;
+	} else {
+		iforce->ecmd = 0xff00 | status;
+		memcpy(iforce->edata, buf, status);
+		status = 0;
 	}
 
-	return -(iforce->edata[0] != packet[0]);
+	kfree(buf);
+	return status;
 }
 
 static int iforce_usb_start_io(struct iforce *iforce)
@@ -136,7 +137,6 @@ static void iforce_usb_stop_io(struct iforce *iforce)
 
 	usb_kill_urb(iforce_usb->irq);
 	usb_kill_urb(iforce_usb->out);
-	usb_kill_urb(iforce_usb->ctrl);
 }
 
 static const struct iforce_xport_ops iforce_usb_xport_ops = {
@@ -197,18 +197,6 @@ static void iforce_usb_out(struct urb *urb)
 	wake_up(&iforce->wait);
 }
 
-static void iforce_usb_ctrl(struct urb *urb)
-{
-	struct iforce_usb *iforce_usb = urb->context;
-	struct iforce *iforce = &iforce_usb->iforce;
-
-	if (urb->status)
-		return;
-
-	iforce->ecmd = 0xff00 | urb->actual_length;
-	wake_up(&iforce->wait);
-}
-
 static int iforce_usb_probe(struct usb_interface *intf,
 				const struct usb_device_id *id)
 {
@@ -236,9 +224,6 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	if (!(iforce_usb->out = usb_alloc_urb(0, GFP_KERNEL)))
 		goto fail;
 
-	if (!(iforce_usb->ctrl = usb_alloc_urb(0, GFP_KERNEL)))
-		goto fail;
-
 	iforce = &iforce_usb->iforce;
 
 	iforce->xport_ops = &iforce_usb_xport_ops;
@@ -247,19 +232,12 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	iforce_usb->usbdev = dev;
 	iforce_usb->intf = intf;
 
-	iforce_usb->cr.bRequestType = USB_TYPE_VENDOR | USB_DIR_IN | USB_RECIP_INTERFACE;
-	iforce_usb->cr.wIndex = 0;
-	iforce_usb->cr.wLength = cpu_to_le16(16);
-
 	usb_fill_int_urb(iforce_usb->irq, dev, usb_rcvintpipe(dev, epirq->bEndpointAddress),
 			iforce->data, 16, iforce_usb_irq, iforce_usb, epirq->bInterval);
 
 	usb_fill_int_urb(iforce_usb->out, dev, usb_sndintpipe(dev, epout->bEndpointAddress),
 			iforce_usb + 1, 32, iforce_usb_out, iforce_usb, epout->bInterval);
 
-	usb_fill_control_urb(iforce_usb->ctrl, dev, usb_rcvctrlpipe(dev, 0),
-			(void*) &iforce_usb->cr, iforce->edata, 16, iforce_usb_ctrl, iforce_usb);
-
 	err = iforce_init_device(&intf->dev, BUS_USB, iforce);
 	if (err)
 		goto fail;
@@ -271,7 +249,6 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	if (iforce_usb) {
 		usb_free_urb(iforce_usb->irq);
 		usb_free_urb(iforce_usb->out);
-		usb_free_urb(iforce_usb->ctrl);
 		kfree(iforce_usb);
 	}
 
@@ -288,7 +265,6 @@ static void iforce_usb_disconnect(struct usb_interface *intf)
 
 	usb_free_urb(iforce_usb->irq);
 	usb_free_urb(iforce_usb->out);
-	usb_free_urb(iforce_usb->ctrl);
 
 	kfree(iforce_usb);
 }
-- 
2.19.0.397.gdd90340f6a-goog
