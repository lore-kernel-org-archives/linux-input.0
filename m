From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] input: Add ClickZone mode support to Clickpad devices
Date: Mon, 14 Dec 2009 11:01:29 +0100
Message-ID: <1260784889-5205-3-git-send-email-tiwai@suse.de>
References: <1260784889-5205-1-git-send-email-tiwai@suse.de>
 <1260784889-5205-2-git-send-email-tiwai@suse.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:33160 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755396AbZLNKDa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Dec 2009 05:03:30 -0500
In-Reply-To: <1260784889-5205-2-git-send-email-tiwai@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Takashi Iwai <tiwai@suse.de>

The Clickpad devices supports only a single button click, the driver
needs to check the left or the right position with some hints.
In "ClickZone" mode, this is decided by the touch position at clicking.

This patch adds the check of the left/right button (also the middle
button) in the synaptics driver side so that the existing user-space
works as is.  This could be implemented in the user-space side, too, but
unfortunately it can't be done automatically because the h/w capability
bits needed to identify the device model aren't exposed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/input/mouse/synaptics.c |   43 +++++++++++++++++++++++++++++++++++++++
 drivers/input/mouse/synaptics.h |    1 +
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 8d8365e..b2db417 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -327,6 +327,45 @@ static void synaptics_pt_create(struct psmouse *psmouse)
  *	Functions to interpret the absolute mode packets
  ****************************************************************************/
 
+/* left and right clickpad button ranges;
+ * the gap between them is interpreted as a middle-button click
+ */
+#define CLICKPAD_LEFT_BTN_X \
+	((XMAX_NOMINAL - XMIN_NOMINAL) * 2 / 5 + XMIN_NOMINAL)
+#define CLICKPAD_RIGHT_BTN_X \
+	((XMAX_NOMINAL - XMIN_NOMINAL) * 3 / 5 + XMIN_NOMINAL)
+
+/* handle clickpad events */
+static void clickpad_process_packet(struct synaptics_data *priv,
+				    struct synaptics_hw_state *hw)
+{
+	/* clickpad mode reports Y range from 0 to YMAX_NOMINAL,
+	 * where the area Y < YMIN_NOMINAL is used as click buttons
+	 */
+	if (hw->y < YMIN_NOMINAL) {
+		/* button area */
+		hw->z = 0; /* don't move pointer */
+		/* clickpad reports only the middle button, and we need
+		 * to fake left/right buttons depending on the touch position
+		 */
+		if (hw->middle) { /* clicked? */
+			hw->middle = 0;
+			if (hw->x < CLICKPAD_LEFT_BTN_X)
+				hw->left = 1;
+			else if (hw->x > CLICKPAD_RIGHT_BTN_X)
+				hw->right = 1;
+			else
+				hw->middle = 1;
+		}
+	} else if (hw->middle) {
+		/* dragging */
+		hw->left = priv->prev_hw.left;
+		hw->right = priv->prev_hw.right;
+		hw->middle = priv->prev_hw.middle;
+	}
+	priv->prev_hw = *hw;
+}
+
 static void synaptics_parse_hw_state(unsigned char buf[], struct synaptics_data *priv, struct synaptics_hw_state *hw)
 {
 	memset(hw, 0, sizeof(struct synaptics_hw_state));
@@ -407,6 +446,9 @@ static void synaptics_process_packet(struct psmouse *psmouse)
 
 	synaptics_parse_hw_state(psmouse->packet, priv, &hw);
 
+	if (SYN_CAP_CLICKPAD(priv->ext_cap))
+		clickpad_process_packet(priv, &hw);
+
 	if (hw.scroll) {
 		priv->scroll += hw.scroll;
 
@@ -702,6 +744,7 @@ int synaptics_init(struct psmouse *psmouse)
 		priv->model_id, priv->capabilities, priv->ext_cap);
 
 	if (SYN_CAP_CLICKPAD(priv->ext_cap)) {
+		printk(KERN_INFO "Synaptics: Clickpad mode enabled\n");
 		/* force to enable the middle button */
 		priv->capabilities |= (1 << 18);
 	}
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 35360a6..76df393 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -105,6 +105,7 @@ struct synaptics_data {
 	unsigned char pkt_type;			/* packet type - old, new, etc */
 	unsigned char mode;			/* current mode byte */
 	int scroll;
+	struct synaptics_hw_state prev_hw;
 };
 
 void synaptics_module_init(void);
-- 
1.6.5.5

