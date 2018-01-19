From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5/7] Input: libps2 - add debugging statements
Date: Fri, 19 Jan 2018 11:41:09 -0800
Message-ID: <20180119194111.185590-6-dmitry.torokhov@gmail.com>
References: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Debugging via i8042.debug and analyzing raw PS/2 data stream may be
cumbersome as you need to locate the boundaries of commands, decipher the
sliced commands, etc, etc. Let's add a bit more high level debug statements
for ps2_sendbyte(), ps2_command(), and ps2_sliced_command().

We do not introduce a new module parameter, but rater rely on the kernel
having dynamic debug facility enabled (which most everyone has nowadays).
Enable with:

echo "file libps2.c +pf" > /sys/kernel/debug/dynamic_debug/control

or add "libps2.dyndbg=+pf" to the kernel command line.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/libps2.c | 52 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index e96ae477f0b56..82befae4dab04 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -26,22 +26,20 @@ MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
 MODULE_DESCRIPTION("PS/2 driver library");
 MODULE_LICENSE("GPL");
 
-/*
- * ps2_sendbyte() sends a byte to the device and waits for acknowledge.
- * It doesn't handle retransmission, though it could - because if there
- * is a need for retransmissions device has to be replaced anyway.
- *
- * ps2_sendbyte() can only be called from a process context.
- */
-
-int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
+static int ps2_do_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
 {
+	int error;
+
 	serio_pause_rx(ps2dev->serio);
 	ps2dev->nak = 1;
 	ps2dev->flags |= PS2_FLAG_ACK;
 	serio_continue_rx(ps2dev->serio);
 
-	if (serio_write(ps2dev->serio, byte) == 0)
+	error = serio_write(ps2dev->serio, byte);
+	if (error)
+		dev_dbg(&ps2dev->serio->dev,
+			"failed to write %#02x: %d\n", byte, error);
+	else
 		wait_event_timeout(ps2dev->wait,
 				   !(ps2dev->flags & PS2_FLAG_ACK),
 				   msecs_to_jiffies(timeout));
@@ -52,6 +50,24 @@ int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
 
 	return -ps2dev->nak;
 }
+
+/*
+ * ps2_sendbyte() sends a byte to the device and waits for acknowledge.
+ * It doesn't handle retransmission, though it could - because if there
+ * is a need for retransmissions device has to be replaced anyway.
+ *
+ * ps2_sendbyte() can only be called from a process context.
+ */
+
+int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
+{
+	int retval;
+
+	retval = ps2_do_sendbyte(ps2dev, byte, timeout);
+	dev_dbg(&ps2dev->serio->dev, "%02x - %x\n", byte, ps2dev->nak);
+
+	return retval;
+}
 EXPORT_SYMBOL(ps2_sendbyte);
 
 void ps2_begin_command(struct ps2dev *ps2dev)
@@ -186,6 +202,7 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 	unsigned int receive = (command >> 8) & 0xf;
 	int rc = -1;
 	int i;
+	u8 send_param[16];
 
 	if (receive > sizeof(ps2dev->cmdbuf)) {
 		WARN_ON(1);
@@ -197,6 +214,8 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 		return -1;
 	}
 
+	memcpy(send_param, param, send);
+
 	serio_pause_rx(ps2dev->serio);
 	ps2dev->flags = command == PS2_CMD_GETID ? PS2_FLAG_WAITID : 0;
 	ps2dev->cmdcnt = receive;
@@ -210,14 +229,14 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 	 * ACKing the reset command, and so it can take a long
 	 * time before the ACK arrives.
 	 */
-	if (ps2_sendbyte(ps2dev, command & 0xff,
-			 command == PS2_CMD_RESET_BAT ? 1000 : 200)) {
+	if (ps2_do_sendbyte(ps2dev, command & 0xff,
+			    command == PS2_CMD_RESET_BAT ? 1000 : 200)) {
 		serio_pause_rx(ps2dev->serio);
 		goto out_reset_flags;
 	}
 
 	for (i = 0; i < send; i++) {
-		if (ps2_sendbyte(ps2dev, param[i], 200)) {
+		if (ps2_do_sendbyte(ps2dev, param[i], 200)) {
 			serio_pause_rx(ps2dev->serio);
 			goto out_reset_flags;
 		}
@@ -253,6 +272,12 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 	ps2dev->flags = 0;
 	serio_continue_rx(ps2dev->serio);
 
+	dev_dbg(&ps2dev->serio->dev,
+		"%02x [%*ph] - %x/%08lx [%*ph]\n",
+		command & 0xff, send, send_param,
+		ps2dev->nak, ps2dev->flags,
+		receive, param ?: send_param);
+
 	return rc;
 }
 EXPORT_SYMBOL(__ps2_command);
@@ -296,6 +321,7 @@ int ps2_sliced_command(struct ps2dev *ps2dev, u8 command)
 	}
 
 out:
+	dev_dbg(&ps2dev->serio->dev, "%02x - %d\n", command, retval);
 	ps2_end_command(ps2dev);
 	return retval;
 }
-- 
2.16.0.rc1.238.g530d649a79-goog
