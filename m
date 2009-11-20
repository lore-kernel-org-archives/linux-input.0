From: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Subject: [PATCH] 9-byte Alps, revisited
Date: Fri, 20 Nov 2009 01:07:49 +0100
Message-ID: <1258675669.5044.540.camel@sardelle.necksus.de>
References: <1258314158.9416.16.camel@sardelle.necksus.de>
	 <20091118090009.GA2983@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:42015 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757395AbZKTAHq (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 19:07:46 -0500
In-Reply-To: <20091118090009.GA2983@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input ML <linux-input@vger.kernel.org>


Hi Dmitry,

thank you for your reply.  It is much cleaner now!  I had to make a few
changes though:

1. As posted, the rearranged patch doesn't work properly.  One has to
retain the sign bits of the PS/2 subpacket.

2. I've also pulled the checking of byte0 before the demuxing of the
PS/2 subpacket.  I think it's safer to desync early if the data is bad.

3. The hardware is very broken:  Touchpad and trackpoint share button
state.  This means that you can trigger this sequence of events:

	<user presses button on trackpoint>
	3byte:  left down  --> reported to "dev2"
	<user moves pointer with touchpad>
	6byte:  left down  --> reported to "dev"
	<user releases button on trackpoint>
	3byte:  left up    --> reported to "dev2"

The result is that dev has a stuck mouse button, and in X11 the mouse
button stays down.  That's why I explicitly cloned button events to both
devices in my first patch. 

However, this created a different problem:  If the user hammered at the
mouse button very quickly, the events would be processed out of order,
e.g.

	touch_press touch_release stick_press stick_release

instead of

	touch_press stick_press touch_release stick_release

As a result of this, a double click was detected in X11.

I have added logic that assigns each button down event to only one of
the devices, and also avoids hanging buttons.  This is activated by a
new flag.

(I'm pretty sure the shared button state is true for most if not all
Alps dualpoints, but I made a separate flag out of it for now).

4. I've noticed the applied patch for the 4-button Alps device. Is it
really intended that one of the buttons fires both a BTN_x event and a
BTN_MIDDLE event?  I don't think so, even tough they share the same bit
in the packet.  BTN_MIDDLE should never be emitted from a device with
the ALPS_FOUR_BUTTONS flag IMHO.  I haven't changed this, never having
seen such a unit.

5. There remains a slight conceptual problem.  The distinction between
6-byte and 9-byte packets is not possible only looking at the first 6
bytes.  (This is a protocoll issue.  We have scrutinized every bit now,
the protocol just seems to be broken in this regard.)

This means that if the user triggers a 6-byte message while holding all
three buttons down (e.g. hold buttons and move pointer via touchpad), we
run into de-sync.

We can't solve this without knowing the message size in the driver.  I
have no idea if we can somehow get this info out of the PS/2 layer.
Dmitry, do you have any insight into this?

I still vote strongly for applying the patch, since this is a mostly
cosmetic problem that never occurs in practical work whereas in the
current state my touchpad is unusable.

Best wishes,
  Sebastian.


Patch following:


Implement protocol for certain Alps dualpoint touchpads sending 9-byte packets,
common in Dell laptops, e.g. E6x00.

Contains pieces of work from Sebastian Kapfer, David Kubicek, Erik Osterholm,
and Dmitry Torokhov.

Signed-off-by: Sebastian Kapfer <sebastian_kapfer@gmx.net>

---
 drivers/input/mouse/alps.c |  140 +++++++++++++++++++++++++++++++++++--------
 drivers/input/mouse/alps.h |    3 +-
 2 files changed, 116 insertions(+), 27 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index a3f492a..aa2498e 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -5,10 +5,14 @@
  * Copyright (c) 2003-2005 Peter Osterlund <petero2@telia.com>
  * Copyright (c) 2004 Dmitry Torokhov <dtor@mail.ru>
  * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
+ * Copyright (c) 2009 Sebastian Kapfer <sebastian_kapfer@gmx.net>
  *
  * ALPS detection, tap switching and status querying info is taken from
  * tpconfig utility (by C. Scott Ananian and Bruce Kall).
  *
+ * Additional research by David Kubicek and Erik Osterholm
+ * (https://bugs.launchpad.net/ubuntu/+source/linux/+bug/296610 )
+ *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
@@ -28,7 +32,6 @@
 #define dbg(format, arg...) do {} while (0)
 #endif
 
-
 #define ALPS_OLDPROTO		0x01	/* old style input */
 #define ALPS_DUALPOINT		0x02	/* touchpad has trackstick */
 #define ALPS_PASS		0x04	/* device has a pass-through port */
@@ -37,7 +40,9 @@
 #define ALPS_FW_BK_1		0x10	/* front & back buttons present */
 #define ALPS_FW_BK_2		0x20	/* front & back buttons present */
 #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
-
+#define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved with
+					   6-byte ALPS packet */
+#define ALPS_SHARED_BTNSTATE	0x100	/* PS/2 and touchpad share button st. */
 
 static const struct alps_model_info alps_model_data[] = {
 	{ { 0x32, 0x02, 0x14 },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* Toshiba Salellite Pro M10 */
@@ -58,7 +63,9 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x20, 0x02, 0x0e },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* XXX */
 	{ { 0x22, 0x02, 0x0a },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },
 	{ { 0x22, 0x02, 0x14 }, 0xff, 0xff, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude D600 */
-	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude E6500 */
+	/* Dell Latitude E6400, E6500, Precision M4400 */
+	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
+		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED | ALPS_SHARED_BTNSTATE },
 	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell Vostro 1400 */
 };
 
@@ -69,7 +76,13 @@ static const struct alps_model_info alps_model_data[] = {
  */
 
 /*
- * ALPS abolute Mode - new format
+ * PS/2 packet format
+ *
+ * byte 0: YOFL XOFL YSGN XSGN  1    M    R    L
+ * byte 1: X7   X6   X5   X4   X3   X2   X1   X0
+ * byte 2: Y7   Y6   Y5   Y4   Y3   Y2   Y1   Y0
+ *
+ * ALPS absolute Mode - new format
  *
  * byte 0:  1    ?    ?    ?    1    ?    ?    ?
  * byte 1:  0   x6   x5   x4   x3   x2   x1   x0
@@ -78,11 +91,59 @@ static const struct alps_model_info alps_model_data[] = {
  * byte 4:  0   y6   y5   y4   y3   y2   y1   y0
  * byte 5:  0   z6   z5   z4   z3   z2   z1   z0
  *
+ * Dualpoint device -- interleaved packet format
+ *
+ * byte 0:    1    1    0    0    1    1    1    1
+ * byte 1:    0   x6   x5   x4   x3   x2   x1   x0
+ * byte 2:    0  x10   x9   x8   x7    0  fin  ges
+ * byte 3: YOFL XOFL YSGN XSGN    1    1    1    1
+ * byte 4:   X7   X6   X5   X4   X3   X2   X1   X0
+ * byte 5:   Y7   Y6   Y5   Y4   Y3   Y2   Y1   Y0
+ * byte 6:    0   y9   y8   y7    1    m    r    l
+ * byte 7:    0   y6   y5   y4   y3   y2   y1   y0
+ * byte 8:    0   z6   z5   z4   z3   z2   z1   z0
+ *
+ * CAPITALS = stick, miniscules = touchpad
+ *
  * ?'s can have different meanings on different models,
  * such as wheel rotation, extra buttons, stick buttons
  * on a dualpoint, etc.
  */
 
+
+/* for Alps units where PS/2 and touchpad share a common button state, try our
+ * best to disentangle them.  If we don't do this, we either get hanging
+ * buttons (when the button-up occurs on the 'wrong' of the two input_dev's) or
+ * duplicated events (if we just broadcast button state to both input_dev's).
+ * the latter can arrive in X11 as doubleclicks if the user clicked quickly.
+ * This also has the advantage that users can assign different actions to
+ * the buttons.
+ */
+static void alps_report_button(struct psmouse *psmouse,
+                               int whichbtn, int state, int mask,
+                               struct input_dev *preferred_dev)
+{
+	struct alps_data *priv = psmouse->private;
+	if (priv->i->flags & ALPS_SHARED_BTNSTATE) {
+		if (state) {
+			if (priv->btn_state & mask)
+				/* already communicated, drop */
+				return;
+			priv->btn_state |= mask;
+		} else {
+			/* release the button on the other device */
+			struct input_dev *other = psmouse->dev;
+			if (preferred_dev == other)
+				other = priv->dev2;
+			priv->btn_state &= 7 ^ mask;
+			input_report_key(other, whichbtn, 0);
+			input_sync(other);
+		}
+	}
+
+	input_report_key(preferred_dev, whichbtn, state);
+}
+
 static void alps_process_packet(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
@@ -93,18 +154,6 @@ static void alps_process_packet(struct psmouse *psmouse)
 	int x, y, z, ges, fin, left, right, middle;
 	int back = 0, forward = 0;
 
-	if ((packet[0] & 0xc8) == 0x08) {   /* 3-byte PS/2 packet */
-		input_report_key(dev2, BTN_LEFT,   packet[0] & 1);
-		input_report_key(dev2, BTN_RIGHT,  packet[0] & 2);
-		input_report_key(dev2, BTN_MIDDLE, packet[0] & 4);
-		input_report_rel(dev2, REL_X,
-			packet[1] ? packet[1] - ((packet[0] << 4) & 0x100) : 0);
-		input_report_rel(dev2, REL_Y,
-			packet[2] ? ((packet[0] << 3) & 0x100) - packet[2] : 0);
-		input_sync(dev2);
-		return;
-	}
-
 	if (model->flags & ALPS_OLDPROTO) {
 		left = packet[2] & 0x10;
 		right = packet[2] & 0x08;
@@ -140,18 +189,17 @@ static void alps_process_packet(struct psmouse *psmouse)
 		input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
 		input_report_rel(dev2, REL_Y, -(y > 255 ? (y - 512) : y));
 
-		input_report_key(dev2, BTN_LEFT, left);
-		input_report_key(dev2, BTN_RIGHT, right);
-		input_report_key(dev2, BTN_MIDDLE, middle);
+		alps_report_button(psmouse, BTN_LEFT, left, 1, dev2);
+		alps_report_button(psmouse, BTN_RIGHT, right, 2, dev2);
+		alps_report_button(psmouse, BTN_MIDDLE, middle, 4, dev2);
 
-		input_sync(dev);
 		input_sync(dev2);
 		return;
 	}
 
-	input_report_key(dev, BTN_LEFT, left);
-	input_report_key(dev, BTN_RIGHT, right);
-	input_report_key(dev, BTN_MIDDLE, middle);
+	alps_report_button(psmouse, BTN_LEFT, left, 1, dev);
+	alps_report_button(psmouse, BTN_RIGHT, right, 2, dev);
+	alps_report_button(psmouse, BTN_MIDDLE, middle, 4, dev);
 
 	/* Convert hardware tap to a reasonable Z value */
 	if (ges && !fin)
@@ -202,25 +250,65 @@ static void alps_process_packet(struct psmouse *psmouse)
 	input_sync(dev);
 }
 
+static void alps_report_bare_ps2_packet(unsigned char packet[],
+					struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+	struct input_dev *dev2 = priv->dev2;
+
+	alps_report_button(psmouse, BTN_LEFT, packet[0] & 1, 1, dev2);
+	alps_report_button(psmouse, BTN_RIGHT, packet[0] & 2, 2, dev2);
+	alps_report_button(psmouse, BTN_MIDDLE, packet[0] & 4, 4, dev2);
+	input_report_rel(dev2, REL_X,
+		packet[1] ? packet[1] - ((packet[0] << 4) & 0x100) : 0);
+	input_report_rel(dev2, REL_Y,
+		packet[2] ? ((packet[0] << 3) & 0x100) - packet[2] : 0);
+	input_sync(dev2);
+}
+
 static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
+	const struct alps_model_info *model = priv->i;
 
 	if ((psmouse->packet[0] & 0xc8) == 0x08) { /* PS/2 packet */
 		if (psmouse->pktcnt == 3) {
-			alps_process_packet(psmouse);
+			alps_report_bare_ps2_packet(psmouse->packet,
+						    psmouse);
 			return PSMOUSE_FULL_PACKET;
 		}
 		return PSMOUSE_GOOD_DATA;
 	}
 
-	if ((psmouse->packet[0] & priv->i->mask0) != priv->i->byte0)
+	if ((psmouse->packet[0] & model->mask0) != model->byte0) {
+		dbg("refusing packet[0] = %x (mask0 = %x, byte0 = %x)\n",
+		    psmouse->packet[0], model->mask0, model->byte0);
 		return PSMOUSE_BAD_DATA;
+	}
+
+	/* Check for PS/2 packet stuffed in the middle of ALPS packet. */
+	if ((model->flags & ALPS_PS2_INTERLEAVED) &&
+	    psmouse->pktcnt >= 4 && (psmouse->packet[3] & 0x0f) == 0x0f) {
+		if (psmouse->pktcnt < 7)
+			return PSMOUSE_GOOD_DATA;
+
+		/* Get the real button data */
+		psmouse->packet[3] &= 0xf0 | (psmouse->packet[6] & 0x0f);
+		alps_report_bare_ps2_packet(&psmouse->packet[3],
+					    psmouse);
+
+		/* Continue with the standard ALPS protocol handling */
+		psmouse->packet[3] = psmouse->packet[6];
+		psmouse->pktcnt = 4;
+	}
 
 	/* Bytes 2 - 6 should have 0 in the highest bit */
 	if (psmouse->pktcnt >= 2 && psmouse->pktcnt <= 6 &&
-	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80))
+	    (psmouse->packet[psmouse->pktcnt - 1] & 0x80)) {
+		dbg("refusing packet[%i] = %x\n",
+		    psmouse->pktcnt - 1, psmouse->packet[psmouse->pktcnt - 1]);
 		return PSMOUSE_BAD_DATA;
+	}
 
 	if (psmouse->pktcnt == 6) {
 		alps_process_packet(psmouse);
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index bc87936..af0f370 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -15,7 +15,7 @@
 struct alps_model_info {
         unsigned char signature[3];
         unsigned char byte0, mask0;
-        unsigned char flags;
+        unsigned int flags;
 };
 
 struct alps_data {
@@ -23,6 +23,7 @@ struct alps_data {
 	char phys[32];			/* Phys */
 	const struct alps_model_info *i;/* Info */
 	int prev_fin;			/* Finger bit from previous packet */
+	int btn_state;			/* Shared state of the buttons */
 };
 
 #ifdef CONFIG_MOUSE_PS2_ALPS
-- 
1.6.3.3





