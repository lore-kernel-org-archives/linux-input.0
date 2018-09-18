From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 15/20] Input: iforce - allow callers supply data buffer when fetching device IDs
Date: Mon, 17 Sep 2018 17:47:27 -0700
Message-ID: <20180918004732.9875-15-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

We want to move buffer handling into transport layers as the properties of
buffers (DMA-safety, alignment, etc) are different for different
transports. To allow this, let's allow caller to specify their own buffers
for the results of iforce_get_id_packet() and let transport drivers to
figure what buffers they need to use for transfers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-main.c  | 27 ++++++++++---------
 drivers/input/joystick/iforce/iforce-serio.c | 28 ++++++++++++++------
 drivers/input/joystick/iforce/iforce-usb.c   | 11 ++++----
 drivers/input/joystick/iforce/iforce.h       | 11 ++++----
 4 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index 9964aa8b3cdc..5cb3e80f4e0d 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -225,7 +225,9 @@ int iforce_init_device(struct device *parent, u16 bustype,
 {
 	struct input_dev *input_dev;
 	struct ff_device *ff;
-	unsigned char c[] = "CEOV";
+	u8 c[] = "CEOV";
+	u8 buf[IFORCE_MAX_LENGTH];
+	size_t len;
 	int i, error;
 	int ff_effects = 0;
 
@@ -269,7 +271,7 @@ int iforce_init_device(struct device *parent, u16 bustype,
  */
 
 	for (i = 0; i < 20; i++)
-		if (!iforce_get_id_packet(iforce, "O"))
+		if (!iforce_get_id_packet(iforce, 'O', buf, &len))
 			break;
 
 	if (i == 20) { /* 5 seconds */
@@ -283,23 +285,23 @@ int iforce_init_device(struct device *parent, u16 bustype,
  * Get device info.
  */
 
-	if (!iforce_get_id_packet(iforce, "M"))
-		input_dev->id.vendor = (iforce->edata[2] << 8) | iforce->edata[1];
+	if (!iforce_get_id_packet(iforce, 'M', buf, &len) || len < 3)
+		input_dev->id.vendor = (buf[2] << 8) | buf[1];
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet M\n");
 
-	if (!iforce_get_id_packet(iforce, "P"))
-		input_dev->id.product = (iforce->edata[2] << 8) | iforce->edata[1];
+	if (!iforce_get_id_packet(iforce, 'P', buf, &len) || len < 3)
+		input_dev->id.product = (buf[2] << 8) | buf[1];
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet P\n");
 
-	if (!iforce_get_id_packet(iforce, "B"))
-		iforce->device_memory.end = (iforce->edata[2] << 8) | iforce->edata[1];
+	if (!iforce_get_id_packet(iforce, 'B', buf, &len) || len < 3)
+		iforce->device_memory.end = (buf[2] << 8) | buf[1];
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet B\n");
 
-	if (!iforce_get_id_packet(iforce, "N"))
-		ff_effects = iforce->edata[1];
+	if (!iforce_get_id_packet(iforce, 'N', buf, &len) || len < 2)
+		ff_effects = buf[1];
 	else
 		dev_warn(&iforce->dev->dev, "Device does not respond to id packet N\n");
 
@@ -315,8 +317,9 @@ int iforce_init_device(struct device *parent, u16 bustype,
  */
 
 	for (i = 0; c[i]; i++)
-		if (!iforce_get_id_packet(iforce, c + i))
-			iforce_dump_packet(iforce, "info", iforce->ecmd, iforce->edata);
+		if (!iforce_get_id_packet(iforce, c[i], buf, &len))
+			iforce_dump_packet(iforce, "info",
+					   (FF_CMD_QUERY & 0xff00) | len, buf);
 
 /*
  * Disable spring, enable force feedback.
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index 8d7eba9c9f0e..be44aed551f7 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -31,6 +31,8 @@ struct iforce_serio {
 	int idx, pkt, len, id;
 	u8 csum;
 	u8 expect_packet;
+	u8 cmd_response[IFORCE_MAX_LENGTH];
+	u8 cmd_response_len;
 };
 
 static void iforce_serio_xmit(struct iforce *iforce)
@@ -81,24 +83,34 @@ static void iforce_serio_xmit(struct iforce *iforce)
 	spin_unlock_irqrestore(&iforce->xmit_lock, flags);
 }
 
-static int iforce_serio_get_id(struct iforce *iforce, u8 *packet)
+static int iforce_serio_get_id(struct iforce *iforce, u8 id,
+			       u8 *response_data, size_t *response_len)
 {
 	struct iforce_serio *iforce_serio = container_of(iforce,
 							 struct iforce_serio,
 							 iforce);
 
 	iforce_serio->expect_packet = HI(FF_CMD_QUERY);
-	iforce_send_packet(iforce, FF_CMD_QUERY, packet);
+	iforce_serio->cmd_response_len = 0;
+
+	iforce_send_packet(iforce, FF_CMD_QUERY, &id);
 
 	wait_event_interruptible_timeout(iforce->wait,
 					 !iforce_serio->expect_packet, HZ);
 
 	if (iforce_serio->expect_packet) {
 		iforce_serio->expect_packet = 0;
-		return -EIO;
+		return -ETIMEDOUT;
 	}
 
-	return -(iforce->edata[0] != packet[0]);
+	if (iforce_serio->cmd_response[0] != id)
+		return -EIO;
+
+	memcpy(response_data, iforce_serio->cmd_response,
+	       iforce_serio->cmd_response_len);
+	*response_len = iforce_serio->cmd_response_len;
+
+	return 0;
 }
 
 static int iforce_serio_start_io(struct iforce *iforce)
@@ -127,7 +139,7 @@ static void iforce_serio_write_wakeup(struct serio *serio)
 }
 
 static irqreturn_t iforce_serio_irq(struct serio *serio,
-		unsigned char data, unsigned int flags)
+				    unsigned char data, unsigned int flags)
 {
 	struct iforce_serio *iforce_serio = serio_get_drvdata(serio);
 	struct iforce *iforce = &iforce_serio->iforce;
@@ -166,9 +178,9 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 		/* Handle command completion */
 		if (iforce_serio->expect_packet == iforce_serio->id) {
 			iforce_serio->expect_packet = 0;
-			iforce->ecmd = (iforce_serio->id << 8) |
-					iforce_serio->idx;
-			memcpy(iforce->edata, iforce->data, IFORCE_MAX_LENGTH);
+			memcpy(iforce_serio->cmd_response, iforce->data,
+			       IFORCE_MAX_LENGTH);
+			iforce_serio->cmd_response_len = iforce_serio->len;
 
 			/* Signal that command is done */
 			wake_up(&iforce->wait);
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index b3743fde2a3a..68155c4de412 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -87,7 +87,8 @@ static void iforce_usb_xmit(struct iforce *iforce)
 		__iforce_usb_xmit(iforce);
 }
 
-static int iforce_usb_get_id(struct iforce *iforce, u8 *packet)
+static int iforce_usb_get_id(struct iforce *iforce, u8 id,
+			     u8 *response_data, size_t *response_len)
 {
 	struct iforce_usb *iforce_usb = container_of(iforce, struct iforce_usb,
 						     iforce);
@@ -100,18 +101,18 @@ static int iforce_usb_get_id(struct iforce *iforce, u8 *packet)
 
 	status = usb_control_msg(iforce_usb->usbdev,
 				 usb_rcvctrlpipe(iforce_usb->usbdev, 0),
-				 packet[0],
+				 id,
 				 USB_TYPE_VENDOR | USB_DIR_IN |
 					USB_RECIP_INTERFACE,
 				 0, 0, buf, IFORCE_MAX_LENGTH, HZ);
 	if (status < 0) {
 		dev_err(&iforce_usb->intf->dev,
 			"usb_submit_urb failed: %d\n", status);
-	} else if (buf[0] != packet[0]) {
+	} else if (buf[0] != id) {
 		status = -EIO;
 	} else {
-		iforce->ecmd = 0xff00 | status;
-		memcpy(iforce->edata, buf, status);
+		memcpy(response_data, buf, status);
+		*response_len = status;
 		status = 0;
 	}
 
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index ce3c6aead8b6..68558c594e54 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -95,7 +95,8 @@ struct iforce;
 
 struct iforce_xport_ops {
 	void (*xmit)(struct iforce *iforce);
-	int (*get_id)(struct iforce *iforce, u8* id);
+	int (*get_id)(struct iforce *iforce, u8 id,
+		      u8 *response_data, size_t *response_len);
 	int (*start_io)(struct iforce *iforce);
 	void (*stop_io)(struct iforce *iforce);
 };
@@ -107,8 +108,6 @@ struct iforce {
 	int bus;
 
 	unsigned char data[IFORCE_MAX_LENGTH];
-	unsigned char edata[IFORCE_MAX_LENGTH];
-	u16 ecmd;
 
 	spinlock_t xmit_lock;
 	/* Buffer used for asynchronous sending of bytes to the device */
@@ -135,9 +134,11 @@ struct iforce {
 /* Encode a time value */
 #define TIME_SCALE(a)	(a)
 
-static inline int iforce_get_id_packet(struct iforce *iforce, u8* id)
+static inline int iforce_get_id_packet(struct iforce *iforce, u8 id,
+				       u8 *response_data, size_t *response_len)
 {
-	return iforce->xport_ops->get_id(iforce, id);
+	return iforce->xport_ops->get_id(iforce, id,
+					 response_data, response_len);
 }
 
 /* Public functions */
-- 
2.19.0.397.gdd90340f6a-goog
