From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 02/20] Input: iforce - introduce transport ops
Date: Mon, 17 Sep 2018 17:47:14 -0700
Message-ID: <20180918004732.9875-2-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In order to tease apart the driver into core and transport modules, let's
introduce transport operations and make "xmit" the very first one such
operation.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../input/joystick/iforce/iforce-packets.c    | 20 ++-----------------
 drivers/input/joystick/iforce/iforce-serio.c  |  9 +++++++--
 drivers/input/joystick/iforce/iforce-usb.c    | 15 ++++++++++++--
 drivers/input/joystick/iforce/iforce.h        | 13 ++++++------
 4 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index 91893c751524..b8ca9bdfdef8 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -91,25 +91,9 @@ int iforce_send_packet(struct iforce *iforce, u16 cmd, unsigned char* data)
 /*
  * If necessary, start the transmission
  */
-	switch (iforce->bus) {
-
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-		case IFORCE_232:
-		if (empty)
-			iforce_serial_xmit(iforce);
-		break;
-#endif
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-		case IFORCE_USB:
+	if (empty)
+		iforce->xport_ops->xmit(iforce);
 
-		if (iforce->usbdev && empty &&
-			!test_and_set_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags)) {
-
-			iforce_usb_xmit(iforce);
-		}
-		break;
-#endif
-	}
 	return 0;
 }
 
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index f4ba4a751fe0..c9469209f994 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -23,7 +23,7 @@
 
 #include "iforce.h"
 
-void iforce_serial_xmit(struct iforce *iforce)
+static void iforce_serio_xmit(struct iforce *iforce)
 {
 	unsigned char cs;
 	int i;
@@ -67,11 +67,15 @@ void iforce_serial_xmit(struct iforce *iforce)
 	spin_unlock_irqrestore(&iforce->xmit_lock, flags);
 }
 
+static const struct iforce_xport_ops iforce_serio_xport_ops = {
+	.xmit		= iforce_serio_xmit,
+};
+
 static void iforce_serio_write_wakeup(struct serio *serio)
 {
 	struct iforce *iforce = serio_get_drvdata(serio);
 
-	iforce_serial_xmit(iforce);
+	iforce_serio_xmit(iforce);
 }
 
 static irqreturn_t iforce_serio_irq(struct serio *serio,
@@ -129,6 +133,7 @@ static int iforce_serio_connect(struct serio *serio, struct serio_driver *drv)
 	if (!iforce)
 		return -ENOMEM;
 
+	iforce->xport_ops = &iforce_serio_xport_ops;
 	iforce->bus = IFORCE_232;
 	iforce->serio = serio;
 
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index 78073259c9a1..d4f7f34db9a0 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -23,7 +23,7 @@
 
 #include "iforce.h"
 
-void iforce_usb_xmit(struct iforce *iforce)
+static void __iforce_usb_xmit(struct iforce *iforce)
 {
 	int n, c;
 	unsigned long flags;
@@ -69,6 +69,16 @@ void iforce_usb_xmit(struct iforce *iforce)
 	spin_unlock_irqrestore(&iforce->xmit_lock, flags);
 }
 
+static void iforce_usb_xmit(struct iforce *iforce)
+{
+	if (!test_and_set_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags))
+		__iforce_usb_xmit(iforce);
+}
+
+static const struct iforce_xport_ops iforce_usb_xport_ops = {
+	.xmit		= iforce_usb_xmit,
+};
+
 static void iforce_usb_irq(struct urb *urb)
 {
 	struct iforce *iforce = urb->context;
@@ -113,7 +123,7 @@ static void iforce_usb_out(struct urb *urb)
 		return;
 	}
 
-	iforce_usb_xmit(iforce);
+	__iforce_usb_xmit(iforce);
 
 	wake_up(&iforce->wait);
 }
@@ -155,6 +165,7 @@ static int iforce_usb_probe(struct usb_interface *intf,
 	if (!(iforce->ctrl = usb_alloc_urb(0, GFP_KERNEL)))
 		goto fail;
 
+	iforce->xport_ops = &iforce_usb_xport_ops;
 	iforce->bus = IFORCE_USB;
 	iforce->usbdev = dev;
 	iforce->intf = intf;
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index 0e9d01f8bcb6..2fea3be751ed 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -93,9 +93,16 @@ struct iforce_device {
 	signed short *ff;
 };
 
+struct iforce;
+
+struct iforce_xport_ops {
+	void (*xmit)(struct iforce *iforce);
+};
+
 struct iforce {
 	struct input_dev *dev;		/* Input device interface */
 	struct iforce_device *type;
+	const struct iforce_xport_ops *xport_ops;
 	int bus;
 
 	unsigned char data[IFORCE_MAX_LENGTH];
@@ -141,12 +148,6 @@ struct iforce {
 
 
 /* Public functions */
-/* iforce-serio.c */
-void iforce_serial_xmit(struct iforce *iforce);
-
-/* iforce-usb.c */
-void iforce_usb_xmit(struct iforce *iforce);
-
 /* iforce-main.c */
 int iforce_init_device(struct iforce *iforce);
 
-- 
2.19.0.397.gdd90340f6a-goog
