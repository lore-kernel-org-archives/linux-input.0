From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 12/20] Input: iforce - do not combine arguments for iforce_process_packet()
Date: Mon, 17 Sep 2018 17:47:24 -0700
Message-ID: <20180918004732.9875-12-dmitry.torokhov@gmail.com>
References: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918004732.9875-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Tim Schumacher <timschumi@gmx.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Current code combines packet type and data length into single argument to
iforce_process_packet() and then has to untangle it. It is much clearer to
simply use separate arguments.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/iforce/iforce-packets.c | 9 +++++----
 drivers/input/joystick/iforce/iforce-serio.c   | 8 ++++----
 drivers/input/joystick/iforce/iforce-usb.c     | 4 ++--
 drivers/input/joystick/iforce/iforce.h         | 3 ++-
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-packets.c b/drivers/input/joystick/iforce/iforce-packets.c
index ffd1dd65deb8..35b7a5206977 100644
--- a/drivers/input/joystick/iforce/iforce-packets.c
+++ b/drivers/input/joystick/iforce/iforce-packets.c
@@ -166,7 +166,8 @@ static void iforce_report_hats_buttons(struct iforce *iforce, u8 *data)
 	}
 }
 
-void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
+void iforce_process_packet(struct iforce *iforce,
+			   u8 packet_id, u8 *data, size_t len)
 {
 	struct input_dev *dev = iforce->dev;
 	int i, j;
@@ -176,14 +177,14 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 	if (!iforce->type)
 		return;
 
-	switch (HI(cmd)) {
+	switch (packet_id) {
 
 	case 0x01:	/* joystick position data */
 		input_report_abs(dev, ABS_X, (__s16) (((__s16)data[1] << 8) | data[0]));
 		input_report_abs(dev, ABS_Y, (__s16) (((__s16)data[3] << 8) | data[2]));
 		input_report_abs(dev, ABS_THROTTLE, 255 - data[4]);
 
-		if (LO(cmd) >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
+		if (len >= 8 && test_bit(ABS_RUDDER ,dev->absbit))
 			input_report_abs(dev, ABS_RUDDER, (__s8)data[7]);
 
 		iforce_report_hats_buttons(iforce, data);
@@ -217,7 +218,7 @@ void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data)
 			input_report_ff_status(dev, i, FF_STATUS_STOPPED);
 		}
 
-		for (j = 3; j < LO(cmd); j += 2)
+		for (j = 3; j < len; j += 2)
 			mark_core_as_ready(iforce, data[j] | (data[j + 1] << 8));
 
 		break;
diff --git a/drivers/input/joystick/iforce/iforce-serio.c b/drivers/input/joystick/iforce/iforce-serio.c
index 6c6411fbdc32..f8bf7d2aa59f 100644
--- a/drivers/input/joystick/iforce/iforce-serio.c
+++ b/drivers/input/joystick/iforce/iforce-serio.c
@@ -163,16 +163,16 @@ static irqreturn_t iforce_serio_irq(struct serio *serio,
 	}
 
 	if (iforce_serio->idx == iforce_serio->len) {
-		u16 cmd = (iforce_serio->id << 8) | iforce_serio->idx;
-
 		/* Handle command completion */
 		if (iforce_serio->expect_packet == iforce_serio->id) {
 			iforce_serio->expect_packet = 0;
-			iforce->ecmd = cmd;
+			iforce->ecmd = (iforce_serio->id << 8) |
+					iforce_serio->idx;
 			memcpy(iforce->edata, iforce->data, IFORCE_MAX_LENGTH);
 		}
 
-		iforce_process_packet(iforce, cmd, iforce->data);
+		iforce_process_packet(iforce, iforce_serio->id,
+				      iforce->data, iforce_serio->len);
 
 		iforce_serio->pkt = 0;
 		iforce_serio->id  = 0;
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index cefaa1c5abc7..b3743fde2a3a 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -170,8 +170,8 @@ static void iforce_usb_irq(struct urb *urb)
 		goto exit;
 	}
 
-	iforce_process_packet(iforce,
-		(iforce->data[0] << 8) | (urb->actual_length - 1), iforce->data + 1);
+	iforce_process_packet(iforce, iforce->data[0],
+			      iforce->data + 1, urb->actual_length - 1);
 
 exit:
 	status = usb_submit_urb(urb, GFP_ATOMIC);
diff --git a/drivers/input/joystick/iforce/iforce.h b/drivers/input/joystick/iforce/iforce.h
index 3e3df83b9d77..ce3c6aead8b6 100644
--- a/drivers/input/joystick/iforce/iforce.h
+++ b/drivers/input/joystick/iforce/iforce.h
@@ -147,7 +147,8 @@ int iforce_init_device(struct device *parent, u16 bustype,
 
 /* iforce-packets.c */
 int iforce_control_playback(struct iforce*, u16 id, unsigned int);
-void iforce_process_packet(struct iforce *iforce, u16 cmd, unsigned char *data);
+void iforce_process_packet(struct iforce *iforce,
+			   u8 packet_id, u8 *data, size_t len);
 int iforce_send_packet(struct iforce *iforce, u16 cmd, unsigned char* data);
 void iforce_dump_packet(struct iforce *iforce, char *msg, u16 cmd, unsigned char *data);
 
-- 
2.19.0.397.gdd90340f6a-goog
