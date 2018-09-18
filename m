From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 19/20] Input: iforce - drop couple of temps from transport code
Date: Mon, 17 Sep 2018 17:47:31 -0700
Message-ID: <20180918004732.9875-19-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Transport initialization code now deals mostly with transport-specific
data, so we can drop couple of temporary variables.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-serio.c | 7 ++-----
 drivers/input/joystick/iforce/iforce-usb.c   | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index 277522d0f324..e7692a38591e 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -204,16 +204,13 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct iforce_serio *iforce_serio;
-	struct iforce *iforce;
 	int err;
 
 	iforce_serio = kzalloc(sizeof(*iforce_serio), GFP_KERNEL);
 	if (!iforce_serio)
 		return -ENOMEM;
 
-	iforce = &iforce_serio->iforce;
-
-	iforce->xport_ops = &iforce_serio_xport_ops;
+	iforce_serio->iforce.xport_ops = &iforce_serio_xport_ops;
 
 	iforce_serio->serio = serio;
 	serio_set_drvdata(serio, iforce_serio);
@@ -222,7 +219,7 @@ static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 	if (err)
 		goto fail1;
 
-	err = iforce_init_device(&serio->dev, BUS_RS232, iforce);
+	err = iforce_init_device(&serio->dev, BUS_RS232, &iforce_serio->iforce);
 	if (err)
 		goto fail2;
 
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index ae2dd5b5a416..a1e670781441 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -208,7 +208,6 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	struct usb_host_interface *interface;
 	struct usb_endpoint_descriptor *epirq, *epout;
 	struct iforce_usb *iforce_usb;
-	struct iforce *iforce;
 	int err = -ENOMEM;
 
 	interface = intf->cur_altsetting;
@@ -231,9 +230,7 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	if (!iforce_usb->out)
 		goto fail;
 
-	iforce = &iforce_usb->iforce;
-
-	iforce->xport_ops = &iforce_usb_xport_ops;
+	iforce_usb->iforce.xport_ops = &iforce_usb_xport_ops;
 
 	iforce_usb->usbdev = dev;
 	iforce_usb->intf = intf;
@@ -248,7 +245,7 @@ static int iforce_usb_probe(struct usb_interface *intf,
 			 iforce_usb->data_out, sizeof(iforce_usb->data_out),
 			 iforce_usb_out, iforce_usb, epout->bInterval);
 
-	err = iforce_init_device(&intf->dev, BUS_USB, iforce);
+	err = iforce_init_device(&intf->dev, BUS_USB, &iforce_usb->iforce);
 	if (err)
 		goto fail;
 
-- 
2.19.0.397.gdd90340f6a-goog
