From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 16/20] Input: iforce - use DMA-safe buffores for USB transfers
Date: Mon, 17 Sep 2018 17:47:28 -0700
Message-ID: <20180918004732.9875-16-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

USB transport has to use cache line-aligned buffers for transfers to avoid
DMA issues; serio doe snot have such restrictions. Let's move "data_in"
buffer from main driver structure into transport modules and make sure USB
requirements are respected.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-serio.c | 10 ++++---
 drivers/input/joystick/iforce/iforce-usb.c   | 28 +++++++++++++-------
 drivers/input/joystick/iforce/iforce.h       |  2 --
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index be44aed551f7..c73d988cbc92 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -33,6 +33,7 @@ struct iforce_serio {
 	u8 expect_packet;
 	u8 cmd_response[IFORCE_MAX_LENGTH];
 	u8 cmd_response_len;
+	u8 data_in[IFORCE_MAX_LENGTH];
 };
 
 static void iforce_serio_xmit(struct iforce *iforce)
@@ -169,7 +170,7 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 	}
 
 	if (iforce_serio->idx < iforce_serio->len) {
-		iforce->data[iforce_serio->idx++] = data;
+		iforce_serio->data_in[iforce_serio->idx++] = data;
 		iforce_serio->csum += data;
 		goto out;
 	}
@@ -178,15 +179,16 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 		/* Handle command completion */
 		if (iforce_serio->expect_packet == iforce_serio->id) {
 			iforce_serio->expect_packet = 0;
-			memcpy(iforce_serio->cmd_response, iforce->data,
-			       IFORCE_MAX_LENGTH);
+			memcpy(iforce_serio->cmd_response,
+			       iforce_serio->data_in, IFORCE_MAX_LENGTH);
 			iforce_serio->cmd_response_len = iforce_serio->len;
 
 			/* Signal that command is done */
 			wake_up(&iforce->wait);
 		} else if (likely(iforce->type)) {
 			iforce_process_packet(iforce, iforce_serio->id,
-					      iforce->data, iforce_serio->len);
+					      iforce_serio->data_in,
+					      iforce_serio->len);
 		}
 
 		iforce_serio->pkt = 0;
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 68155c4de412..d85258b50be2 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -30,6 +30,9 @@ struct iforce_usb {
 	struct usb_device *usbdev;
 	struct usb_interface *intf;
 	struct urb *irq, *out;
+
+	u8 data_in[IFORCE_MAX_LENGTH] ____cacheline_aligned;
+	u8 data_out[IFORCE_MAX_LENGTH] ____cacheline_aligned;
 };
 
 static void __iforce_usb_xmit(struct iforce *iforce)
@@ -171,8 +174,8 @@ static void iforce_usb_irq(struct urb *urb)
 		goto exit;
 	}
 
-	iforce_process_packet(iforce, iforce->data[0],
-			      iforce->data + 1, urb->actual_length - 1);
+	iforce_process_packet(iforce, iforce_usb->data_in[0],
+			      iforce_usb->data_in + 1, urb->actual_length - 1);
 
 exit:
 	status = usb_submit_urb(urb, GFP_ATOMIC);
@@ -216,13 +219,16 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	epirq = &interface->endpoint[0].desc;
 	epout = &interface->endpoint[1].desc;
 
-	if (!(iforce_usb = kzalloc(sizeof(*iforce_usb) + 32, GFP_KERNEL)))
+	iforce_usb = kzalloc(sizeof(*iforce_usb), GFP_KERNEL);
+	if (!iforce_usb)
 		goto fail;
 
-	if (!(iforce_usb->irq = usb_alloc_urb(0, GFP_KERNEL)))
+	iforce_usb->irq = usb_alloc_urb(0, GFP_KERNEL);
+	if (!iforce_usb->irq)
 		goto fail;
 
-	if (!(iforce_usb->out = usb_alloc_urb(0, GFP_KERNEL)))
+	iforce_usb->out = usb_alloc_urb(0, GFP_KERNEL);
+	if (!iforce_usb->out)
 		goto fail;
 
 	iforce = &iforce_usb->iforce;
@@ -233,11 +239,15 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	iforce_usb->usbdev = dev;
 	iforce_usb->intf = intf;
 
-	usb_fill_int_urb(iforce_usb->irq, dev, usb_rcvintpipe(dev, epirq->bEndpointAddress),
-			iforce->data, 16, iforce_usb_irq, iforce_usb, epirq->bInterval);
+	usb_fill_int_urb(iforce_usb->irq, dev,
+			 usb_rcvintpipe(dev, epirq->bEndpointAddress),
+			 iforce_usb->data_in, sizeof(iforce_usb->data_in),
+			 iforce_usb_irq, iforce_usb, epirq->bInterval);
 
-	usb_fill_int_urb(iforce_usb->out, dev, usb_sndintpipe(dev, epout->bEndpointAddress),
-			iforce_usb + 1, 32, iforce_usb_out, iforce_usb, epout->bInterval);
+	usb_fill_int_urb(iforce_usb->out, dev,
+			 usb_sndintpipe(dev, epout->bEndpointAddress),
+			 iforce_usb->data_out, sizeof(iforce_usb->data_out),
+			 iforce_usb_out, iforce_usb, epout->bInterval);
 
 	err = iforce_init_device(&intf->dev, BUS_USB, iforce);
 	if (err)
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index 68558c594e54..180de7a3f3a1 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -107,8 +107,6 @@ struct iforce {
 	const struct iforce_xport_ops *xport_ops;
 	int bus;
 
-	unsigned char data[IFORCE_MAX_LENGTH];
-
 	spinlock_t xmit_lock;
 	/* Buffer used for asynchronous sending of bytes to the device */
 	struct circ_buf xmit;
-- 
2.19.0.397.gdd90340f6a-goog
