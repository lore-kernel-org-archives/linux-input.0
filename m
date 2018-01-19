From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 7/7] Input: libps2 - relax command byte ACK handling
Date: Fri, 19 Jan 2018 11:41:11 -0800
Message-ID: <20180119194111.185590-8-dmitry.torokhov@gmail.com>
References: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36195 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756251AbeASTlW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 14:41:22 -0500
In-Reply-To: <20180119194111.185590-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

When we probe PS/2 devices we first issue "Get ID" command and only if we
receive what we consider a valid keyboard or mouse ID we disable the device
and continue with protocol detection. That means that the device may be
transmitting motion or keystroke data, while we expect ACK response.

Instead of signaling failure if we see anything but ACK/NAK let's ignore
"garbage" response until we see ACK for the command byte (first byte). The
checks for subsequent ACKs of command parameters will continue be strict.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/libps2.c | 25 ++++++++++++++++++++++---
 include/linux/libps2.h       |  1 +
 2 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
index f05c407b31f3d..e6a07e68d1ff6 100644
--- a/drivers/input/serio/libps2.c
+++ b/drivers/input/serio/libps2.c
@@ -256,16 +256,23 @@ int __ps2_command(struct ps2dev *ps2dev, u8 *param, unsigned int command)
 		for (i = 0; i < receive; i++)
 			ps2dev->cmdbuf[(receive - 1) - i] = param[i];
 
+	/* Signal that we are sending the command byte */
+	ps2dev->flags |= PS2_FLAG_ACK_CMD;
+
 	/*
 	 * Some devices (Synaptics) peform the reset before
 	 * ACKing the reset command, and so it can take a long
 	 * time before the ACK arrives.
 	 */
-	rc = ps2_do_sendbyte(ps2dev, command & 0xff,
-			     command == PS2_CMD_RESET_BAT ? 1000 : 200, 2);
+	timeout = command == PS2_CMD_RESET_BAT ? 1000 : 200;
+
+	rc = ps2_do_sendbyte(ps2dev, command & 0xff, timeout, 2);
 	if (rc)
 		goto out_reset_flags;
 
+	/* Now we are sending command parameters, if any */
+	ps2dev->flags &= ~PS2_FLAG_ACK_CMD;
+
 	for (i = 0; i < send; i++) {
 		rc = ps2_do_sendbyte(ps2dev, param[i], 200, 2);
 		if (rc)
@@ -416,7 +423,19 @@ bool ps2_handle_ack(struct ps2dev *ps2dev, u8 data)
 		}
 		/* Fall through */
 	default:
-		return false;
+		/*
+		 * Do not signal errors if we get unexpected reply while
+		 * waiting for an ACK to the initial (first) command byte:
+		 * the device might not be quiesced yet and continue
+		 * delivering data.
+		 * Note that we reset PS2_FLAG_WAITID flag, so the workaround
+		 * for mice not acknowledging the Get ID command only triggers
+		 * on the 1st byte; if device spews data we really want to see
+		 * a real ACK from it.
+		 */
+		dev_dbg(&ps2dev->serio->dev, "unexpected %#02x\n", data);
+		ps2dev->flags &= ~PS2_FLAG_WAITID;
+		return ps2dev->flags & PS2_FLAG_ACK_CMD;
 	}
 
 	if (!ps2dev->nak) {
diff --git a/include/linux/libps2.h b/include/linux/libps2.h
index cd4454502a042..8b8139337e552 100644
--- a/include/linux/libps2.h
+++ b/include/linux/libps2.h
@@ -27,6 +27,7 @@
 #define PS2_FLAG_CMD1		BIT(2)	/* Waiting for the first byte of command response */
 #define PS2_FLAG_WAITID		BIT(3)	/* Command executing is GET ID */
 #define PS2_FLAG_NAK		BIT(4)	/* Last transmission was NAKed */
+#define PS2_FLAG_ACK_CMD	BIT(5)	/* Waiting to ACK the command (first) byte */
 
 struct ps2dev {
 	struct serio *serio;
-- 
2.16.0.rc1.238.g530d649a79-goog

