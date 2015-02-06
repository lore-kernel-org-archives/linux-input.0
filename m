From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 6/7] Input: synaptics - re-route tracksticks buttons on the Lenovo 2015 series
Date: Fri,  6 Feb 2015 15:04:34 -0500
Message-ID: <1423253075-23469-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423253075-23469-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The 2015 series of the Lenovo thinkpads added back the hardware buttons
on top of the touchpad for the trackstick.

Unfortunately, they are wired to the touchpad, and not the trackstick.
Thus, they are seen as extra buttons from the kernel point of view.

This leads to a problem in user space because extra buttons on synaptics
devices used to be used as scroll up/down buttons. So in the end, the
experience for the user is scroll events for buttons left and right
when using the trackstick. Yay!

Fortunatelly, the firmware advertizes such behavior in the extended
capability $10, and so we can re-route the buttons through the
pass-through interface.

Hallelujah-expressed-by: Peter Hutterer <peter.hutterer@who-t.net>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

v2:
- forward only 3 extra buttons, not the whole array. The PS/2 base protocol
  handles only 3 buttons, so giving more than 3 will mess up REL_X and REL_Y.
- rely on SYN_CAP_EXT_BUTTONS_STICK to know if the re-routing has to be put in
  place or not

 drivers/input/mouse/synaptics.c | 45 +++++++++++++++++++++++++++++++----------
 drivers/input/mouse/synaptics.h |  5 +++++
 2 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 79c4a87..dfe8235 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -585,18 +585,20 @@ static int synaptics_is_pt_packet(unsigned char *buf)
 	return (buf[0] & 0xFC) == 0x84 && (buf[3] & 0xCC) == 0xC4;
 }
 
-static void synaptics_pass_pt_packet(struct serio *ptport, unsigned char *packet)
+static void synaptics_pass_pt_packet(struct psmouse *psmouse,
+		struct serio *ptport, unsigned char *packet)
 {
+	struct synaptics_data *priv = psmouse->private;
 	struct psmouse *child = serio_get_drvdata(ptport);
 
 	if (child && child->state == PSMOUSE_ACTIVATED) {
-		serio_interrupt(ptport, packet[1], 0);
+		serio_interrupt(ptport, packet[1] | priv->pt_buttons, 0);
 		serio_interrupt(ptport, packet[4], 0);
 		serio_interrupt(ptport, packet[5], 0);
 		if (child->pktsize == 4)
 			serio_interrupt(ptport, packet[2], 0);
 	} else
-		serio_interrupt(ptport, packet[1], 0);
+		serio_interrupt(ptport, packet[1] | priv->pt_buttons, 0);
 }
 
 static void synaptics_pt_activate(struct psmouse *psmouse)
@@ -842,6 +844,7 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
 	struct input_dev *dev = psmouse->dev;
 	struct synaptics_data *priv = psmouse->private;
 	int ext_bits = (SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) + 1) >> 1;
+	char buf[6] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
 	int i;
 
 	if (!SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap))
@@ -852,12 +855,30 @@ static void synaptics_report_ext_buttons(struct psmouse *psmouse,
 	    !((psmouse->packet[0] ^ psmouse->packet[3]) & 0x02))
 		return;
 
-	for (i = 0; i < ext_bits; i++) {
-		input_report_key(dev, BTN_0 + 2 * i,
-			hw->ext_buttons & (1 << i));
-		input_report_key(dev, BTN_1 + 2 * i,
-			hw->ext_buttons & (1 << (i + ext_bits)));
+	if (!SYN_CAP_EXT_BUTTONS_STICK(priv->ext_cap_10)) {
+		for (i = 0; i < ext_bits; i++) {
+			input_report_key(dev, BTN_0 + 2 * i,
+				hw->ext_buttons & (1 << i));
+			input_report_key(dev, BTN_1 + 2 * i,
+				hw->ext_buttons & (1 << (i + ext_bits)));
+		}
+		return;
 	}
+
+	/*
+	 * This generation of touchpads has the trackstick buttons
+	 * physically wired to the touchpad. Re-route them through
+	 * the pass-through interface.
+	 */
+	if (!priv->pt_port)
+		return;
+
+	/* the trackstick expects at most 3 buttons */
+	priv->pt_buttons = SYN_CAP_EXT_BUTTON_STICK_L(hw->ext_buttons)      |
+			   SYN_CAP_EXT_BUTTON_STICK_R(hw->ext_buttons) << 1 |
+			   SYN_CAP_EXT_BUTTON_STICK_M(hw->ext_buttons) << 2;
+
+	synaptics_pass_pt_packet(psmouse, priv->pt_port, buf);
 }
 
 static void synaptics_report_buttons(struct psmouse *psmouse,
@@ -1098,7 +1119,8 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
 		if (SYN_CAP_PASS_THROUGH(priv->capabilities) &&
 		    synaptics_is_pt_packet(psmouse->packet)) {
 			if (priv->pt_port)
-				synaptics_pass_pt_packet(priv->pt_port, psmouse->packet);
+				synaptics_pass_pt_packet(psmouse, priv->pt_port,
+							 psmouse->packet);
 		} else
 			synaptics_process_packet(psmouse);
 
@@ -1200,8 +1222,9 @@ static void set_input_params(struct psmouse *psmouse,
 		__set_bit(BTN_BACK, dev->keybit);
 	}
 
-	for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap); i++)
-		__set_bit(BTN_0 + i, dev->keybit);
+	if (!SYN_CAP_EXT_BUTTONS_STICK(priv->ext_cap_10))
+		for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap); i++)
+			__set_bit(BTN_0 + i, dev->keybit);
 
 	__clear_bit(EV_REL, dev->evbit);
 	__clear_bit(REL_X, dev->relbit);
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 9723092..8102a72 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -111,6 +111,10 @@
 #define SYN_CAP_EXT_BUTTONS_STICK(ex10)	((ex10) & 0x010000)
 #define SYN_CAP_SECUREPAD(ex10)		((ex10) & 0x020000)
 
+#define SYN_CAP_EXT_BUTTON_STICK_L(eb)	(!!((eb) & 0x01))
+#define SYN_CAP_EXT_BUTTON_STICK_M(eb)	(!!((eb) & 0x02))
+#define SYN_CAP_EXT_BUTTON_STICK_R(eb)	(!!((eb) & 0x04))
+
 /* synaptics modes query bits */
 #define SYN_MODE_ABSOLUTE(m)		((m) & (1 << 7))
 #define SYN_MODE_RATE(m)		((m) & (1 << 6))
@@ -179,6 +183,7 @@ struct synaptics_data {
 	bool disable_gesture;			/* disable gestures */
 
 	struct serio *pt_port;			/* Pass-through serio port */
+	unsigned char pt_buttons;		/* Pass-through buttons */
 
 	/*
 	 * Last received Advanced Gesture Mode (AGM) packet. An AGM packet
-- 
2.1.0
