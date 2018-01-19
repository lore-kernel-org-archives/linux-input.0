From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/7] Input: libps2 - use u8 for byte data
Date: Fri, 19 Jan 2018 11:41:06 -0800
Message-ID: <20180119194111.185590-3-dmitry.torokhov@gmail.com>
References: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34607 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756214AbeASTlR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 14:41:17 -0500
In-Reply-To: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Instead of using unsigned char for the byte data switch to using u8. Also
use unsigned int for the command codes and timeouts, and have
ps2_handle_ack() and ps2_handle_response() return bool instead of int, as
they do not return error codes but rather signal whether a byte was handled
or not handled. ps2_is_keyboard_id() now returns bool as well.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/libps2.c | 31 ++++++++++++++++---------------
 include/linux/libps2.h       | 20 ++++++++++----------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 21aea5169a99c..c3712f0a47b50 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -34,7 +34,7 @@ MODULE_LICENSE("GPL");
  * ps2_sendbyte() can only be called from a process context.
  */
 
-int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout)
+int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout)
 {
 	serio_pause_rx(ps2dev->serio);
 	ps2dev->nak = 1;
@@ -75,7 +75,7 @@ EXPORT_SYMBOL(ps2_end_command);
  * and discards them.
  */
 
-void ps2_drain(struct ps2dev *ps2dev, int maxbytes, int timeout)
+void ps2_drain(struct ps2dev *ps2dev, size_t maxbytes, unsigned int timeout)
 {
 	if (maxbytes > sizeof(ps2dev->cmdbuf)) {
 		WARN_ON(1);
@@ -102,9 +102,9 @@ EXPORT_SYMBOL(ps2_drain);
  * known keyboard IDs.
  */
 
-int ps2_is_keyboard_id(char id_byte)
+bool ps2_is_keyboard_id(u8 id_byte)
 {
-	static const char keyboard_ids[] = {
+	static const u8 keyboard_ids[] = {
 		0xab,	/* Regular keyboards		*/
 		0xac,	/* NCD Sun keyboard		*/
 		0x2b,	/* Trust keyboard, translated	*/
@@ -123,7 +123,8 @@ EXPORT_SYMBOL(ps2_is_keyboard_id);
  * completion.
  */
 
-static int ps2_adjust_timeout(struct ps2dev *ps2dev, int command, int timeout)
+static int ps2_adjust_timeout(struct ps2dev *ps2dev,
+			      unsigned int command, unsigned int timeout)
 {
 	switch (command) {
 	case PS2_CMD_RESET_BAT:
@@ -178,11 +179,11 @@ static int ps2_adjust_timeout(struct ps2dev *ps2dev, int command, int timeout)
  * ps2_command() can only be called from a process context
  */
 
-int __ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
+int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 {
-	int timeout;
-	int send = (command >> 12) & 0xf;
-	int receive = (command >> 8) & 0xf;
+	unsigned int timeout;
+	unsigned int send = (command >> 12) & 0xf;
+	unsigned int receive = (command >> 8) & 0xf;
 	int rc = -1;
 	int i;
 
@@ -256,7 +257,7 @@ int __ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
 }
 EXPORT_SYMBOL(__ps2_command);
 
-int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command)
+int ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 {
 	int rc;
 
@@ -286,7 +287,7 @@ EXPORT_SYMBOL(ps2_init);
  * to properly process ACK/NAK of a command from a PS/2 device.
  */
 
-int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data)
+bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
 {
 	switch (data) {
 	case PS2_RET_ACK:
@@ -318,7 +319,7 @@ int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data)
 		}
 		/* Fall through */
 	default:
-		return 0;
+		return false;
 	}
 
 	if (!ps2dev->nak) {
@@ -333,7 +334,7 @@ int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data)
 	if (data != PS2_RET_ACK)
 		ps2_handle_response(ps2dev, data);
 
-	return 1;
+	return true;
 }
 EXPORT_SYMBOL(ps2_handle_ack);
 
@@ -343,7 +344,7 @@ EXPORT_SYMBOL(ps2_handle_ack);
  * waiting for completion of the command.
  */
 
-int ps2_handle_response(struct ps2dev *ps2dev, unsigned char data)
+bool ps2_handle_response(struct ps2dev *ps2dev, u8 data)
 {
 	if (ps2dev->cmdcnt)
 		ps2dev->cmdbuf[--ps2dev->cmdcnt] = data;
@@ -359,7 +360,7 @@ int ps2_handle_response(struct ps2dev *ps2dev, unsigned char data)
 		wake_up(&ps2dev->wait);
 	}
 
-	return 1;
+	return true;
 }
 EXPORT_SYMBOL(ps2_handle_response);
 
diff --git a/include/linux/libps2.h b/include/linux/libps2.h
index 4ad06e824f76f..365c50b097ded 100644
--- a/include/linux/libps2.h
+++ b/include/linux/libps2.h
@@ -36,21 +36,21 @@ struct ps2dev {
 	wait_queue_head_t wait;
 
 	unsigned long flags;
-	unsigned char cmdbuf[8];
-	unsigned char cmdcnt;
-	unsigned char nak;
+	u8 cmdbuf[8];
+	u8 cmdcnt;
+	u8 nak;
 };
 
 void ps2_init(struct ps2dev *ps2dev, struct serio *serio);
-int ps2_sendbyte(struct ps2dev *ps2dev, unsigned char byte, int timeout);
-void ps2_drain(struct ps2dev *ps2dev, int maxbytes, int timeout);
+int ps2_sendbyte(struct ps2dev *ps2dev, u8 byte, unsigned int timeout);
+void ps2_drain(struct ps2dev *ps2dev, size_t maxbytes, unsigned int timeout);
 void ps2_begin_command(struct ps2dev *ps2dev);
 void ps2_end_command(struct ps2dev *ps2dev);
-int __ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);
-int ps2_command(struct ps2dev *ps2dev, unsigned char *param, int command);
-int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data);
-int ps2_handle_response(struct ps2dev *ps2dev, unsigned char data);
+int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command);
+int ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command);
+bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data);
+bool ps2_handle_response(struct ps2dev *ps2dev, u8 data);
 void ps2_cmd_aborted(struct ps2dev *ps2dev);
-int ps2_is_keyboard_id(char id);
+bool ps2_is_keyboard_id(u8 id);
 
 #endif /* _LIBPS2_H */
-- 
2.16.0.rc1.238.g530d649a79-goog

