From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [RFC] Input - synaptics: re-route tracksticks buttons on the Lenovo 2015 series
Date: Thu,  5 Feb 2015 15:38:03 -0500
Message-ID: <1423168683-12507-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53536 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbbBEUiR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 5 Feb 2015 15:38:17 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Hans de Goede <hdegoede@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Lenovos 2015 series has the physical tracktick buttons wired
through the touchpad. The kernel should re-route them through
the pass-through interface.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi Dmitry,

Well, in one of your replies regarding the Synaptics Lenovo 2015
series, you mentioned that you wouldn't mind having the trackstick
buttons re-routed through the trackstick (pass-through interface).

I came out with this patch (checkpatch complains a lot about it but
today's setup is not that convenient), and I'd like to hear what you
think of it.

If you agree to go this path, I'll remove the warnings from checkpatch
and do a proper submission.

The patch is still not future proof (if Synaptics updates the board like
they did for the *40 series, we will need to fix this all over again),
so I might have a little bit more of work to do. Anyway, it works.

Cheers,
Benjamin

 drivers/input/mouse/synaptics.c | 55 ++++++++++++++++++++++++++++++++---------
 drivers/input/mouse/synaptics.h |  2 ++
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index fc0099c..e32cac1 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -190,6 +190,11 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	NULL
 };
 
+static const char * const trackstick_buttons_pnp_ids[] = {
+	"LEN0048",
+	NULL
+};
+
 /*****************************************************************************
  *	Synaptics communications functions
  ****************************************************************************/
@@ -512,18 +517,20 @@ static int synaptics_is_pt_packet(unsigned char *buf)
 	return (buf[0] & 0xFC) == 0x84 && (buf[3] & 0xCC) == 0xC4;
 }
 
-static void synaptics_pass_pt_packet(struct serio *ptport, unsigned char *packet)
+static void synaptics_pass_pt_packet(struct psmouse *psmouse, struct serio *ptport,
+		unsigned char *packet)
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
@@ -782,11 +789,33 @@ static void synaptics_report_buttons(struct psmouse *psmouse,
 		input_report_key(dev, BTN_BACK, hw->down);
 	}
 
-	for (i = 0; i < ext_bits; i++) {
-		input_report_key(dev, BTN_0 + 2 * i,
-				 hw->ext_buttons & (1 << i));
-		input_report_key(dev, BTN_1 + 2 * i,
-				 hw->ext_buttons & (1 << (i + ext_bits)));
+	if (!priv->override_pt_buttons) {
+		for (i = 0; i < ext_bits; i++) {
+			input_report_key(dev, BTN_0 + 2 * i,
+					 hw->ext_buttons & (1 << i));
+			input_report_key(dev, BTN_1 + 2 * i,
+					 hw->ext_buttons & (1 << (i + ext_bits)));
+		}
+	} else {
+		/* 
+		 * This generation of touchpads has the trackstick buttons
+		 * physically wired to the touchpad. Re-route them through
+		 * the pass-through interface.
+		 */
+		if (priv->pt_port &&
+		    SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap) &&
+		    ((psmouse->packet[0] ^ psmouse->packet[3]) & 0x02)) {
+			char buf[6] = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+			priv->pt_buttons = 0x00;
+			/* ext_bits is guaranteed to be <= 4 */
+			for (i = 0; i < ext_bits; i++) {
+				if (hw->ext_buttons & (1 << i))
+					priv->pt_buttons |= 1 << (2 * i);
+				if (hw->ext_buttons & (1 << (i + ext_bits)))
+					priv->pt_buttons |= 1 << (2 * i + 1);
+			}
+			synaptics_pass_pt_packet(psmouse, priv->pt_port, buf);
+		}
 	}
 }
 
@@ -1008,7 +1037,8 @@ static psmouse_ret_t synaptics_process_byte(struct psmouse *psmouse)
 		if (SYN_CAP_PASS_THROUGH(priv->capabilities) &&
 		    synaptics_is_pt_packet(psmouse->packet)) {
 			if (priv->pt_port)
-				synaptics_pass_pt_packet(priv->pt_port, psmouse->packet);
+				synaptics_pass_pt_packet(psmouse, priv->pt_port,
+							 psmouse->packet);
 		} else
 			synaptics_process_packet(psmouse);
 
@@ -1110,8 +1140,11 @@ static void set_input_params(struct psmouse *psmouse,
 		__set_bit(BTN_BACK, dev->keybit);
 	}
 
-	for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap); i++)
-		__set_bit(BTN_0 + i, dev->keybit);
+	if (!psmouse_matches_pnp_id(psmouse, trackstick_buttons_pnp_ids))
+		for (i = 0; i < SYN_CAP_MULTI_BUTTON_NO(priv->ext_cap); i++)
+			__set_bit(BTN_0 + i, dev->keybit);
+	else
+		priv->override_pt_buttons = true;
 
 	__clear_bit(EV_REL, dev->evbit);
 	__clear_bit(REL_X, dev->relbit);
diff --git a/drivers/input/mouse/synaptics.h b/drivers/input/mouse/synaptics.h
index 6faf9bb..fc39b01 100644
--- a/drivers/input/mouse/synaptics.h
+++ b/drivers/input/mouse/synaptics.h
@@ -156,6 +156,8 @@ struct synaptics_data {
 	bool disable_gesture;			/* disable gestures */
 
 	struct serio *pt_port;			/* Pass-through serio port */
+	unsigned char pt_buttons;		/* Pass-through overriding buttons */
+	bool override_pt_buttons;		/* Override the pass-through buttons */
 
 	/*
 	 * Last received Advanced Gesture Mode (AGM) packet. An AGM packet
-- 
2.1.0

