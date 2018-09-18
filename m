From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 03/20] Input: iforce - move get_id to the transport operations
Date: Mon, 17 Sep 2018 17:47:15 -0700
Message-ID: <20180918004732.9875-3-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

To avoid #ifdef-ing out parts of the code and having conditionals in normal
control flow, let's define "get_id" transport method and move
implementation into respective transport modules.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 .../input/joystick/iforce/iforce-packets.c    | 64 -------------------
 drivers/input/joystick/iforce/iforce-serio.c  | 17 +++++
 drivers/input/joystick/iforce/iforce-usb.c    | 29 +++++++++
 drivers/input/joystick/iforce/iforce.h        |  6 +-
 4 files changed, 51 insertions(+), 65 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index b8ca9bdfdef8..e677562efc9a 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -210,67 +210,3 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 			break;
 	}
 }
-
-int iforce_get_id_packet(struct iforce *iforce, char *packet)
-{
-	switch (iforce->bus) {
-
-	case IFORCE_USB: {
-#ifdef CONFIG_JOYSTICK_IFORCE_USB
-		int status;
-
-		iforce->cr.bRequest = packet[0];
-		iforce->ctrl->dev = iforce->usbdev;
-
-		status = usb_submit_urb(iforce->ctrl, GFP_KERNEL);
-		if (status) {
-			dev_err(&iforce->intf->dev,
-				"usb_submit_urb failed %d\n", status);
-			return -1;
-		}
-
-		wait_event_interruptible_timeout(iforce->wait,
-			iforce->ctrl->status != -EINPROGRESS, HZ);
-
-		if (iforce->ctrl->status) {
-			dev_dbg(&iforce->intf->dev,
-				"iforce->ctrl->status = %d\n",
-				iforce->ctrl->status);
-			usb_unlink_urb(iforce->ctrl);
-			return -1;
-		}
-#else
-		printk(KERN_DEBUG "iforce_get_id_packet: iforce->bus = USB!\n");
-#endif
-		}
-		break;
-
-	case IFORCE_232:
-
-#ifdef CONFIG_JOYSTICK_IFORCE_232
-		iforce->expect_packet = FF_CMD_QUERY;
-		iforce_send_packet(iforce, FF_CMD_QUERY, packet);
-
-		wait_event_interruptible_timeout(iforce->wait,
-			!iforce->expect_packet, HZ);
-
-		if (iforce->expect_packet) {
-			iforce->expect_packet = 0;
-			return -1;
-		}
-#else
-		dev_err(&iforce->dev->dev,
-			"iforce_get_id_packet: iforce->bus = SERIO!\n");
-#endif
-		break;
-
-	default:
-		dev_err(&iforce->dev->dev,
-			"iforce_get_id_packet: iforce->bus = %d\n",
-			iforce->bus);
-		break;
-	}
-
-	return -(iforce->edata[0] != packet[0]);
-}
-
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index c9469209f994..fa45ce425d47 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -67,8 +67,25 @@ static void iforce_serio_xmit(struct iforce *iforce)
 	spin_unlock_irqrestore(&iforce->xmit_lock, flags);
 }
 
+static int iforce_serio_get_id(struct iforce *iforce, u8 *packet)
+{
+	iforce->expect_packet = FF_CMD_QUERY;
+	iforce_send_packet(iforce, FF_CMD_QUERY, packet);
+
+	wait_event_interruptible_timeout(iforce->wait,
+					 !iforce->expect_packet, HZ);
+
+	if (iforce->expect_packet) {
+		iforce->expect_packet = 0;
+		return -EIO;
+	}
+
+	return -(iforce->edata[0] != packet[0]);
+}
+
 static const struct iforce_xport_ops iforce_serio_xport_ops = {
 	.xmit		= iforce_serio_xmit,
+	.get_id		= iforce_serio_get_id,
 };
 
 static void iforce_serio_write_wakeup(struct serio *serio)
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index d4f7f34db9a0..f7eeaad92602 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -75,8 +75,37 @@ static void iforce_usb_xmit(struct iforce *iforce)
 		__iforce_usb_xmit(iforce);
 }
 
+static int iforce_usb_get_id(struct iforce *iforce, u8 *packet)
+{
+	int status;
+
+	iforce->cr.bRequest = packet[0];
+	iforce->ctrl->dev = iforce->usbdev;
+
+	status = usb_submit_urb(iforce->ctrl, GFP_KERNEL);
+	if (status) {
+		dev_err(&iforce->intf->dev,
+			"usb_submit_urb failed %d\n", status);
+		return -EIO;
+	}
+
+	wait_event_interruptible_timeout(iforce->wait,
+		iforce->ctrl->status != -EINPROGRESS, HZ);
+
+	if (iforce->ctrl->status) {
+		dev_dbg(&iforce->intf->dev,
+			"iforce->ctrl->status = %d\n",
+			iforce->ctrl->status);
+		usb_unlink_urb(iforce->ctrl);
+		return -EIO;
+	}
+
+	return -(iforce->edata[0] != packet[0]);
+}
+
 static const struct iforce_xport_ops iforce_usb_xport_ops = {
 	.xmit		= iforce_usb_xmit,
+	.get_id		= iforce_usb_get_id,
 };
 
 static void iforce_usb_irq(struct urb *urb)
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index 2fea3be751ed..f6636230be31 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -97,6 +97,7 @@ struct iforce;
 
 struct iforce_xport_ops {
 	void (*xmit)(struct iforce *iforce);
+	int (*get_id)(struct iforce *iforce, u8* id);
 };
 
 struct iforce {
@@ -146,6 +147,10 @@ struct iforce {
 /* Encode a time value */
 #define TIME_SCALE(a)	(a)
 
+static inline int iforce_get_id_packet(struct iforce *iforce, u8* id)
+{
+	return iforce->xport_ops->get_id(iforce, id);
+}
 
 /* Public functions */
 /* iforce-main.c */
@@ -156,7 +161,6 @@ int iforce_control_playback(struct iforce*, u16 id, unsigned int);
 void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data);
 int iforce_send_packet(struct iforce *iforce, u16 cmd, unsigned char* data);
 void iforce_dump_packet(struct iforce *iforce, char *msg, u16 cmd, unsigned char *data);
-int iforce_get_id_packet(struct iforce *iforce, char *packet);
 
 /* iforce-ff.c */
 int iforce_upload_periodic(struct iforce *, struct ff_effect *, struct ff_effect *);
-- 
2.19.0.397.gdd90340f6a-goog
