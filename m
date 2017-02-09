From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: synaptics - use SERIO_OOB_DATA to handle trackstick buttons
Date: Thu,  9 Feb 2017 11:49:09 -0800
Message-ID: <20170209194911.32442-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35458 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbdBIT4f (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Feb 2017 14:56:35 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, Lyude Paul <thatslyude@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Instead of using custom method of "passing" extended buttons from the
touchpad to trackstick, let's switch to the newly introduced SERIO_OOB_DATA
channel.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/synaptics.c | 26 +++++++++++++-------------
 drivers/input/mouse/synaptics.h |  1 -
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index f004f07fefaa..da7719bf887a 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -597,15 +597,13 @@ static int synaptics_is_pt_packet(unsigned char *buf)
 	return (buf[0] & 0xFC) == 0x84 && (buf[3] & 0xCC) == 0xC4;
 }
 
-static void synaptics_pass_pt_packet(struct psmouse *psmouse,
-				     struct serio *ptport,
+static void synaptics_pass_pt_packet(struct serio *ptport,
 				     unsigned char *packet)
 {
-	struct synaptics_data *priv = psmouse->private;
 	struct psmouse *child = serio_get_drvdata(ptport);
 
 	if (child && child->state == PSMOUSE_ACTIVATED) {
-		serio_interrupt(ptport, packet[1] | priv->pt_buttons, 0);
+		serio_interrupt(ptport, packet[1], 0);
 		serio_interrupt(ptport, packet[4], 0);
 		serio_interrupt(ptport, packet[5], 0);
 		if (child->pktsize == 4)
@@ -858,7 +856,6 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
 	struct input_dev *dev = psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
 	int ext_bits = (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) + 1) >> 1;
-	char buf[6] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 	int i;
 
 	if (!SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
@@ -885,15 +882,18 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
 	 * physically wired to the touchpad. Re-route them through
 	 * the pass-through interface.
 	 */
-	if (!priv->pt_port)
-		return;
+	if (priv->pt_port) {
+		u8 pt_buttons;
 
-	/* The trackstick expects at most 3 buttons */
-	priv->pt_buttons = SYN_CAP_EXT_BUTTON_STICK_L(hw->ext_buttons)      |
-			   SYN_CAP_EXT_BUTTON_STICK_R(hw->ext_buttons) << 1 |
-			   SYN_CAP_EXT_BUTTON_STICK_M(hw->ext_buttons) << 2;
+		/* The trackstick expects at most 3 buttons */
+		pt_buttons = SYN_CAP_EXT_BUTTON_STICK_L(hw->ext_buttons)      |
+			     SYN_CAP_EXT_BUTTON_STICK_R(hw->ext_buttons) << 1 |
+			     SYN_CAP_EXT_BUTTON_STICK_M(hw->ext_buttons) << 2;
 
-	synaptics_pass_pt_packet(psmouse, priv->pt_port, buf);
+		serio_interrupt(priv->pt_port,
+				PSMOUSE_OOB_EXTRA_BTNS, SERIO_OOB_DATA);
+		serio_interrupt(priv->pt_port, pt_buttons, SERIO_OOB_DATA);
+	}
 }
 
 static void synaptics_report_buttons(struct psmouse *psmouse,
@@ -1147,7 +1147,7 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
 		if (SYN_CAP_PASS_THROUGH(priv->capabilities) &&
 		    synaptics_is_pt_packet(psmouse->packet)) {
 			if (priv->pt_port)
-				synaptics_pass_pt_packet(psmouse, priv->pt_port,
+				synaptics_pass_pt_packet(priv->pt_port,
 							 psmouse->packet);
 		} else
 			synaptics_process_packet(psmouse);
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 56faa7ec4434..116ae2546ace 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -183,7 +183,6 @@ struct synaptics_data {
 	bool disable_gesture;			/* disable gestures */
 
 	struct serio *pt_port;			/* Pass-through serio port */
-	unsigned char pt_buttons;		/* Pass-through buttons */
 
 	/*
 	 * Last received Advanced Gesture Mode (AGM) packet. An AGM packet
-- 
2.11.0.483.g087da7b7c-goog

