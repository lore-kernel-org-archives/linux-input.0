From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/7] Input: libps2 - fix switch statement formatting
Date: Fri, 19 Jan 2018 11:41:05 -0800
Message-ID: <20180119194111.185590-2-dmitry.torokhov@gmail.com>
References: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43829 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756203AbeASTlQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 14:41:16 -0500
In-Reply-To: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Individual labels of switch statements should have the same indentation
level as the switch statement itself.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/libps2.c | 131 +++++++++++++++++++++----------------------
 1 file changed, 65 insertions(+), 66 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index 83e9c663aa672..21aea5169a99c 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -126,46 +126,46 @@ EXPORT_SYMBOL(ps2_is_keyboard_id);
 static int ps2_adjust_timeout(struct ps2dev *ps2dev, int command, int timeout)
 {
 	switch (command) {
-		case PS2_CMD_RESET_BAT:
-			/*
-			 * Device has sent the first response byte after
-			 * reset command, reset is thus done, so we can
-			 * shorten the timeout.
-			 * The next byte will come soon (keyboard) or not
-			 * at all (mouse).
-			 */
-			if (timeout > msecs_to_jiffies(100))
-				timeout = msecs_to_jiffies(100);
-			break;
+	case PS2_CMD_RESET_BAT:
+		/*
+		 * Device has sent the first response byte after
+		 * reset command, reset is thus done, so we can
+		 * shorten the timeout.
+		 * The next byte will come soon (keyboard) or not
+		 * at all (mouse).
+		 */
+		if (timeout > msecs_to_jiffies(100))
+			timeout = msecs_to_jiffies(100);
+		break;
 
-		case PS2_CMD_GETID:
-			/*
-			 * Microsoft Natural Elite keyboard responds to
-			 * the GET ID command as it were a mouse, with
-			 * a single byte. Fail the command so atkbd will
-			 * use alternative probe to detect it.
-			 */
-			if (ps2dev->cmdbuf[1] == 0xaa) {
-				serio_pause_rx(ps2dev->serio);
-				ps2dev->flags = 0;
-				serio_continue_rx(ps2dev->serio);
-				timeout = 0;
-			}
-
-			/*
-			 * If device behind the port is not a keyboard there
-			 * won't be 2nd byte of ID response.
-			 */
-			if (!ps2_is_keyboard_id(ps2dev->cmdbuf[1])) {
-				serio_pause_rx(ps2dev->serio);
-				ps2dev->flags = ps2dev->cmdcnt = 0;
-				serio_continue_rx(ps2dev->serio);
-				timeout = 0;
-			}
-			break;
+	case PS2_CMD_GETID:
+		/*
+		 * Microsoft Natural Elite keyboard responds to
+		 * the GET ID command as it were a mouse, with
+		 * a single byte. Fail the command so atkbd will
+		 * use alternative probe to detect it.
+		 */
+		if (ps2dev->cmdbuf[1] == 0xaa) {
+			serio_pause_rx(ps2dev->serio);
+			ps2dev->flags = 0;
+			serio_continue_rx(ps2dev->serio);
+			timeout = 0;
+		}
 
-		default:
-			break;
+		/*
+		 * If device behind the port is not a keyboard there
+		 * won't be 2nd byte of ID response.
+		 */
+		if (!ps2_is_keyboard_id(ps2dev->cmdbuf[1])) {
+			serio_pause_rx(ps2dev->serio);
+			ps2dev->flags = ps2dev->cmdcnt = 0;
+			serio_continue_rx(ps2dev->serio);
+			timeout = 0;
+		}
+		break;
+
+	default:
+		break;
 	}
 
 	return timeout;
@@ -289,39 +289,38 @@ EXPORT_SYMBOL(ps2_init);
 int ps2_handle_ack(struct ps2dev *ps2dev, unsigned char data)
 {
 	switch (data) {
-		case PS2_RET_ACK:
-			ps2dev->nak = 0;
+	case PS2_RET_ACK:
+		ps2dev->nak = 0;
+		break;
+
+	case PS2_RET_NAK:
+		ps2dev->flags |= PS2_FLAG_NAK;
+		ps2dev->nak = PS2_RET_NAK;
+		break;
+
+	case PS2_RET_ERR:
+		if (ps2dev->flags & PS2_FLAG_NAK) {
+			ps2dev->flags &= ~PS2_FLAG_NAK;
+			ps2dev->nak = PS2_RET_ERR;
 			break;
+		}
 
-		case PS2_RET_NAK:
-			ps2dev->flags |= PS2_FLAG_NAK;
-			ps2dev->nak = PS2_RET_NAK;
+	/*
+	 * Workaround for mice which don't ACK the Get ID command.
+	 * These are valid mouse IDs that we recognize.
+	 */
+	case 0x00:
+	case 0x03:
+	case 0x04:
+		if (ps2dev->flags & PS2_FLAG_WAITID) {
+			ps2dev->nak = 0;
 			break;
-
-		case PS2_RET_ERR:
-			if (ps2dev->flags & PS2_FLAG_NAK) {
-				ps2dev->flags &= ~PS2_FLAG_NAK;
-				ps2dev->nak = PS2_RET_ERR;
-				break;
-			}
-
-		/*
-		 * Workaround for mice which don't ACK the Get ID command.
-		 * These are valid mouse IDs that we recognize.
-		 */
-		case 0x00:
-		case 0x03:
-		case 0x04:
-			if (ps2dev->flags & PS2_FLAG_WAITID) {
-				ps2dev->nak = 0;
-				break;
-			}
-			/* Fall through */
-		default:
-			return 0;
+		}
+		/* Fall through */
+	default:
+		return 0;
 	}
 
-
 	if (!ps2dev->nak) {
 		ps2dev->flags &= ~PS2_FLAG_NAK;
 		if (ps2dev->cmdcnt)
-- 
2.16.0.rc1.238.g530d649a79-goog

