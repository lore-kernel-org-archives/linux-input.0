From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 05/20] Input: iforce - introduce start and stop io transport ops
Date: Mon, 17 Sep 2018 17:47:17 -0700
Message-ID: <20180918004732.9875-5-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add start_io() and stop_io() transport methods so that core
does not have to know the details.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-main.c  | 25 ++------------------
 drivers/input/joystick/iforce/iforce-serio.c | 13 ++++++++++
 drivers/input/joystick/iforce/iforce-usb.c   | 17 +++++++++++++
 drivers/input/joystick/iforce/iforce.h       |  2 ++
 4 files changed, 34 insertions(+), 23 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 58d5cfe46526..4401ca4a4c38 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -185,15 +185,7 @@ static int iforce_open(struct input_dev *dev)
 {
 	struct iforce *iforce = input_get_drvdata(dev);
 
-	switch (iforce->bus) {
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-		case IFORCE_USB:
-			iforce->irq->dev = iforce->usbdev;
-			if (usb_submit_urb(iforce->irq, GFP_KERNEL))
-				return -EIO;
-			break;
-#endif
-	}
+	iforce->xport_ops->start_io(iforce);
 
 	if (test_bit(EV_FF, dev->evbit)) {
 		/* Enable force feedback */
@@ -226,20 +218,7 @@ static void iforce_close(struct input_dev *dev)
 			!test_bit(IFORCE_XMIT_RUNNING, iforce->xmit_flags));
 	}
 
-	switch (iforce->bus) {
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-	case IFORCE_USB:
-		usb_kill_urb(iforce->irq);
-		usb_kill_urb(iforce->out);
-		usb_kill_urb(iforce->ctrl);
-		break;
-#endif
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-	case IFORCE_232:
-		//TODO: Wait for the last packets to be sent
-		break;
-#endif
-	}
+	iforce->xport_ops->stop_io(iforce);
 }
 
 int iforce_init_device(struct iforce *iforce)
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index eca2f6eca7f0..afc7521b430d 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -83,9 +83,22 @@ static int iforce_serio_get_id(struct iforce *iforce, u8 *packet)
 	return -(iforce->edata[0] != packet[0]);
 }
 
+static int iforce_serio_start_io(struct iforce *iforce)
+{
+	/* No special handling required */
+	return 0;
+}
+
+static void iforce_serio_stop_io(struct iforce *iforce)
+{
+	//TODO: Wait for the last packets to be sent
+}
+
 static const struct iforce_xport_ops iforce_serio_xport_ops = {
 	.xmit		= iforce_serio_xmit,
 	.get_id		= iforce_serio_get_id,
+	.start_io	= iforce_serio_start_io,
+	.stop_io	= iforce_serio_stop_io,
 };
 
 static void iforce_serio_write_wakeup(struct serio *serio)
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index f7eeaad92602..10b583b5fc82 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -103,9 +103,26 @@ static int iforce_usb_get_id(struct iforce *iforce, u8 *packet)
 	return -(iforce->edata[0] != packet[0]);
 }
 
+static int iforce_usb_start_io(struct iforce *iforce)
+{
+	if (usb_submit_urb(iforce->irq, GFP_KERNEL))
+		return -EIO;
+
+	return 0;
+}
+
+static void iforce_usb_stop_io(struct iforce *iforce)
+{
+	usb_kill_urb(iforce->irq);
+	usb_kill_urb(iforce->out);
+	usb_kill_urb(iforce->ctrl);
+}
+
 static const struct iforce_xport_ops iforce_usb_xport_ops = {
 	.xmit		= iforce_usb_xmit,
 	.get_id		= iforce_usb_get_id,
+	.start_io	= iforce_usb_start_io,
+	.stop_io	= iforce_usb_stop_io,
 };
 
 static void iforce_usb_irq(struct urb *urb)
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index f6636230be31..c020d61eccf2 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -98,6 +98,8 @@ struct iforce;
 struct iforce_xport_ops {
 	void (*xmit)(struct iforce *iforce);
 	int (*get_id)(struct iforce *iforce, u8* id);
+	int (*start_io)(struct iforce *iforce);
+	void (*stop_io)(struct iforce *iforce);
 };
 
 struct iforce {
-- 
2.19.0.397.gdd90340f6a-goog
