From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6/7] Input: libps2 - support retransmission of command data
Date: Fri, 19 Jan 2018 11:41:10 -0800
Message-ID: <20180119194111.185590-7-dmitry.torokhov@gmail.com>
References: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The devices are allowed to respond to either command byte or command
parameter with a NAK (0xfe), and the host is supposed to resend the
"correct" byte. The device then will either respond with ACK or ERR (0xfc).
Let's teach libps2 to handle the NAK responses properly, so that individual
drivers do not need to handle them.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/libps2.c | 103 +++++++++++++++++++++++++++++--------------
 1 file changed, 71 insertions(+), 32 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 82befae4dab04..f05c407b31f3d 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -26,35 +26,63 @@ MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
 MODULE_DESCRIPTION("PS/2 driver library");
 MODULE_LICENSE("GPL");
 
-static int ps2_do_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
+static int ps2_do_sendbyte(struct ps2dev *ps2dev, u8 byte,
+			   unsigned int timeout, unsigned int max_attempts)
+	__releases(&ps2dev->serio->lock) __acquires(&ps2dev->serio->lock)
 {
+	int attempt = 0;
 	int error;
 
-	serio_pause_rx(ps2dev->serio);
-	ps2dev->nak = 1;
-	ps2dev->flags |= PS2_FLAG_ACK;
-	serio_continue_rx(ps2dev->serio);
+	lockdep_assert_held(&ps2dev->serio->lock);
 
-	error = serio_write(ps2dev->serio, byte);
-	if (error)
-		dev_dbg(&ps2dev->serio->dev,
-			"failed to write %#02x: %d\n", byte, error);
-	else
-		wait_event_timeout(ps2dev->wait,
-				   !(ps2dev->flags & PS2_FLAG_ACK),
-				   msecs_to_jiffies(timeout));
+	do {
+		ps2dev->nak = 1;
+		ps2dev->flags |= PS2_FLAG_ACK;
+
+		serio_continue_rx(ps2dev->serio);
+
+		error = serio_write(ps2dev->serio, byte);
+		if (error)
+			dev_dbg(&ps2dev->serio->dev,
+				"failed to write %#02x: %d\n", byte, error);
+		else
+			wait_event_timeout(ps2dev->wait,
+					   !(ps2dev->flags & PS2_FLAG_ACK),
+					   msecs_to_jiffies(timeout));
+
+		serio_pause_rx(ps2dev->serio);
+	} while (ps2dev->nak == PS2_RET_NAK && ++attempt < max_attempts);
 
-	serio_pause_rx(ps2dev->serio);
 	ps2dev->flags &= ~PS2_FLAG_ACK;
-	serio_continue_rx(ps2dev->serio);
 
-	return -ps2dev->nak;
+	if (!error) {
+		switch (ps2dev->nak) {
+		case 0:
+			break;
+		case PS2_RET_NAK:
+			error = -EAGAIN;
+			break;
+		case PS2_RET_ERR:
+			error = -EPROTO;
+			break;
+		default:
+			error = -EIO;
+			break;
+		}
+	}
+
+	if (error || attempt > 1)
+		dev_dbg(&ps2dev->serio->dev,
+			"%02x - %d (%x), attempt %d\n",
+			byte, error, ps2dev->nak, attempt);
+
+	return error;
 }
 
 /*
  * ps2_sendbyte() sends a byte to the device and waits for acknowledge.
- * It doesn't handle retransmission, though it could - because if there
- * is a need for retransmissions device has to be replaced anyway.
+ * It doesn't handle retransmission, the caller is expected to handle
+ * it when needed.
  *
  * ps2_sendbyte() can only be called from a process context.
  */
@@ -63,9 +91,13 @@ int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
 {
 	int retval;
 
-	retval = ps2_do_sendbyte(ps2dev, byte, timeout);
+	serio_pause_rx(ps2dev->serio);
+
+	retval = ps2_do_sendbyte(ps2dev, byte, timeout, 1);
 	dev_dbg(&ps2dev->serio->dev, "%02x - %x\n", byte, ps2dev->nak);
 
+	serio_continue_rx(ps2dev->serio);
+
 	return retval;
 }
 EXPORT_SYMBOL(ps2_sendbyte);
@@ -200,48 +232,48 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 	unsigned int timeout;
 	unsigned int send = (command >> 12) & 0xf;
 	unsigned int receive = (command >> 8) & 0xf;
-	int rc = -1;
+	int rc;
 	int i;
 	u8 send_param[16];
 
 	if (receive > sizeof(ps2dev->cmdbuf)) {
 		WARN_ON(1);
-		return -1;
+		return -EINVAL;
 	}
 
 	if (send && !param) {
 		WARN_ON(1);
-		return -1;
+		return -EINVAL;
 	}
 
 	memcpy(send_param, param, send);
 
 	serio_pause_rx(ps2dev->serio);
+
 	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
 	ps2dev->cmdcnt = receive;
 	if (receive && param)
 		for (i = 0; i < receive; i++)
 			ps2dev->cmdbuf[(receive - 1) - i] = param[i];
-	serio_continue_rx(ps2dev->serio);
 
 	/*
 	 * Some devices (Synaptics) peform the reset before
 	 * ACKing the reset command, and so it can take a long
 	 * time before the ACK arrives.
 	 */
-	if (ps2_do_sendbyte(ps2dev, command & 0xff,
-			    command == PS2_CMD_RESET_BAT ? 1000 : 200)) {
-		serio_pause_rx(ps2dev->serio);
+	rc = ps2_do_sendbyte(ps2dev, command & 0xff,
+			     command == PS2_CMD_RESET_BAT ? 1000 : 200, 2);
+	if (rc)
 		goto out_reset_flags;
-	}
 
 	for (i = 0; i < send; i++) {
-		if (ps2_do_sendbyte(ps2dev, param[i], 200)) {
-			serio_pause_rx(ps2dev->serio);
+		rc = ps2_do_sendbyte(ps2dev, param[i], 200, 2);
+		if (rc)
 			goto out_reset_flags;
-		}
 	}
 
+	serio_continue_rx(ps2dev->serio);
+
 	/*
 	 * The reset command takes a long time to execute.
 	 */
@@ -263,8 +295,11 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 		for (i = 0; i < receive; i++)
 			param[i] = ps2dev->cmdbuf[(receive - 1) - i];
 
-	if (ps2dev->cmdcnt && (command != PS2_CMD_RESET_BAT || ps2dev->cmdcnt != 1))
+	if (ps2dev->cmdcnt &&
+	    (command != PS2_CMD_RESET_BAT || ps2dev->cmdcnt != 1)) {
+		rc = -EPROTO;
 		goto out_reset_flags;
+	}
 
 	rc = 0;
 
@@ -278,7 +313,11 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 		ps2dev->nak, ps2dev->flags,
 		receive, param ?: send_param);
 
-	return rc;
+	/*
+	 * ps_command() handles resends itself, so do not leak -EAGAIN
+	 * to the callers.
+	 */
+	return rc != -EAGAIN ? rc : -EPROTO;
 }
 EXPORT_SYMBOL(__ps2_command);
 
-- 
2.16.0.rc1.238.g530d649a79-goog
