From: Chris Diamand <chris@diamand.org>
Subject: [PATCH] Input: byd - Simplify initialization sequence code.
Date: Wed,  3 Feb 2016 23:35:52 +0000
Message-ID: <1454542552-28995-1-git-send-email-chris@diamand.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38735 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157AbcBCXgL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Feb 2016 18:36:11 -0500
Received: by mail-wm0-f45.google.com with SMTP id p63so93582541wmp.1
        for <linux-input@vger.kernel.org>; Wed, 03 Feb 2016 15:36:10 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: Chris Diamand <chris@diamand.org>

The touchpad initialization sequence was spread out over several
functions, and used two different data structures to store the
different sections.

However, the different parts are only ever used together, so merge
them into one function and data structure.

Signed-off-by: Chris Diamand <chris@diamand.org>
---
 drivers/input/mouse/byd.c | 133 ++++++++++++++++++----------------------------
 1 file changed, 51 insertions(+), 82 deletions(-)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index 9425e0f..00910f3 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -162,18 +162,6 @@ static psmouse_ret_t byd_process_byte(struct psmouse *psmouse)
 	return PSMOUSE_FULL_PACKET;
 }
 
-/* Send a sequence of bytes, where each is ACKed before the next is sent. */
-static int byd_send_sequence(struct psmouse *psmouse, const u8 *seq, size_t len)
-{
-	unsigned int i;
-
-	for (i = 0; i < len; ++i) {
-		if (ps2_command(&psmouse->ps2dev, NULL, seq[i]))
-			return -1;
-	}
-	return 0;
-}
-
 /* Keep scrolling after fingers are removed. */
 #define SCROLL_INERTIAL		0x01
 #define SCROLL_NO_INERTIAL	0x02
@@ -183,69 +171,20 @@ static int byd_send_sequence(struct psmouse *psmouse, const u8 *seq, size_t len)
 /* Clicking can only be done by pressing. */
 #define CLICK_PRESS_ONLY	0x02
 
-static int byd_enable(struct psmouse *psmouse)
-{
-	const u8 seq1[] = { 0xE2, 0x00, 0xE0, 0x02, 0xE0 };
-	const u8 seq2[] = {
-		0xD3, 0x01,
-		0xD0, 0x00,
-		0xD0, 0x04,
-		/* Whether clicking is done by tapping or pressing. */
-		0xD4, CLICK_PRESS_ONLY,
-		0xD5, 0x01,
-		0xD7, 0x03,
-		/* Vertical and horizontal one-finger scroll zone inertia. */
-		0xD8, SCROLL_INERTIAL,
-		0xDA, 0x05,
-		0xDB, 0x02,
-		0xE4, 0x05,
-		0xD6, 0x01,
-		0xDE, 0x04,
-		0xE3, 0x01,
-		0xCF, 0x00,
-		0xD2, 0x03,
-		/* Vertical and horizontal two-finger scrolling inertia. */
-		0xE5, SCROLL_INERTIAL,
-		0xD9, 0x02,
-		0xD9, 0x07,
-		0xDC, 0x03,
-		0xDD, 0x03,
-		0xDF, 0x03,
-		0xE1, 0x03,
-		0xD1, 0x00,
-		0xCE, 0x00,
-		0xCC, 0x00,
-		0xE0, 0x00,
-		0xE2, 0x01
-	};
-	u8 param[4];
-
-	if (byd_send_sequence(psmouse, seq1, ARRAY_SIZE(seq1)))
-		return -1;
-
-	/* Send a 0x01 command, which should return 4 bytes. */
-	if (ps2_command(&psmouse->ps2dev, param, 0x0401))
-		return -1;
-
-	if (byd_send_sequence(psmouse, seq2, ARRAY_SIZE(seq2)))
-		return -1;
-
-	return 0;
-}
-
-/*
- * Send the set of PS/2 commands required to make it identify as an
- * intellimouse with 4-byte instead of 3-byte packets.
- */
-static int byd_send_intellimouse_sequence(struct psmouse *psmouse)
+static int byd_reset_touchpad(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	u8 param[4];
 	int i;
+
 	const struct {
 		u16 command;
 		u8 arg;
 	} seq[] = {
+		/*
+		 * Intellimouse initialization sequence, to get 4-byte instead
+		 * of 3-byte packets.
+		 */
 		{ PSMOUSE_CMD_RESET_BAT, 0 },
 		{ PSMOUSE_CMD_RESET_BAT, 0 },
 		{ PSMOUSE_CMD_GETID, 0 },
@@ -264,27 +203,57 @@ static int byd_send_intellimouse_sequence(struct psmouse *psmouse)
 		{ PSMOUSE_CMD_GETID, 0 },
 		{ PSMOUSE_CMD_SETRATE, 0x64 },
 		{ PSMOUSE_CMD_SETRES, 0x03 },
-		{ PSMOUSE_CMD_ENABLE, 0 }
+		{ PSMOUSE_CMD_ENABLE, 0 },
+		/*
+		 * BYD-specific initialization, which enables absolute mode and
+		 * (if desired), the touchpad's built-in gesture detection.
+		 */
+		{0xE2, 0},
+		{0x00, 0},
+		{0xE0, 0},
+		{0x02, 0},
+		{0xE0, 0},
+		/* The touchpad should reply with 4 seemingly-random bytes */
+		{0x0401, 0},
+		/* Pairs of parameters and values. */
+		{0xD3, 0}, {0x01, 0},
+		{0xD0, 0}, {0x00, 0},
+		{0xD0, 0}, {0x04, 0},
+		/* Whether clicking is done by tapping or pressing. */
+		{0xD4, 0}, {CLICK_PRESS_ONLY, 0},
+		{0xD5, 0}, {0x01, 0},
+		{0xD7, 0}, {0x03, 0},
+		/* Vertical and horizontal one-finger scroll zone inertia. */
+		{0xD8, 0}, {SCROLL_INERTIAL, 0},
+		{0xDA, 0}, {0x05, 0},
+		{0xDB, 0}, {0x02, 0},
+		{0xE4, 0}, {0x05, 0},
+		{0xD6, 0}, {0x01, 0},
+		{0xDE, 0}, {0x04, 0},
+		{0xE3, 0}, {0x01, 0},
+		{0xCF, 0}, {0x00, 0},
+		{0xD2, 0}, {0x03, 0},
+		/* Vertical and horizontal two-finger scrolling inertia. */
+		{0xE5, 0}, {SCROLL_INERTIAL, 0},
+		{0xD9, 0}, {0x02, 0},
+		{0xD9, 0}, {0x07, 0},
+		{0xDC, 0}, {0x03, 0},
+		{0xDD, 0}, {0x03, 0},
+		{0xDF, 0}, {0x03, 0},
+		{0xE1, 0}, {0x03, 0},
+		{0xD1, 0}, {0x00, 0},
+		{0xCE, 0}, {0x00, 0},
+		{0xCC, 0}, {0x00, 0},
+		{0xE0, 0}, {0x00, 0},
+		{0xE2, 0}, {0x01, 0},
 	};
 
-	memset(param, 0, sizeof(param));
 	for (i = 0; i < ARRAY_SIZE(seq); ++i) {
+		memset(param, 0, sizeof(param));
 		param[0] = seq[i].arg;
 		if (ps2_command(ps2dev, param, seq[i].command))
-			return -1;
+			return -EIO;
 	}
-
-	return 0;
-}
-
-static int byd_reset_touchpad(struct psmouse *psmouse)
-{
-	if (byd_send_intellimouse_sequence(psmouse))
-		return -EIO;
-
-	if (byd_enable(psmouse))
-		return -EIO;
-
 	return 0;
 }
 
-- 
2.1.4

