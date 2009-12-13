From: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Subject: [PATCH 1/2]
Date: Sun, 13 Dec 2009 23:01:05 +0100
Message-ID: <1260741665.9901.10.camel@sardelle.necksus.de>
References: <1259513695.32495.171.camel@sardelle.necksus.de>
	 <20091204084902.GB22570@core.coreip.homeip.net>
	 <1259963240.27307.213.camel@sardelle.necksus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:36689 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754410AbZLMWBJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Dec 2009 17:01:09 -0500
In-Reply-To: <1259963240.27307.213.camel@sardelle.necksus.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: Linux Input ML <linux-input@vger.kernel.org>


Hi Dmitry,

for the record, I have put together one last time what I consider the
best solution.  Sorry if I seem pushy, but I think we have ironed out
all the issues, and waiting longer isn't going to make the code prettier
(or more correct).

This is your last patch, with the desync fixed:



Date: Fri, 4 Dec 2009 21:50:37 +0100
Subject: [PATCH 1/2] reworked again, 9bytes


Input: ALPS - add interleaved protocol support (Dell E6x00 series)

From: Sebastian Kapfer <sebastian_kapfer@gmx.net>

Properly handle version of the protocol where standard PS/2 packets
from trackpoint are stuffed into middle (byte 3-6) of the standard
ALPS packets when both the touchpad and trackpoint are used together.

The patch is based on work done by Matthew Chapman and additional
research done by David Kubicek and Erik Osterholm:

        https://bugs.launchpad.net/ubuntu/+source/linux/+bug/296610

Many thanks to David Kubicek for his efforts in researching fine points
of this new version of the protocol, especially interaction between pad
and stick in these models.

Signed-off-by: Sebastian Kapfer <sebastian_kapfer@gmx.net>

---
 drivers/input/mouse/alps.c    |  254 ++++++++++++++++++++++++++++++++++++-----
 drivers/input/mouse/alps.h    |    1 +
 drivers/input/mouse/psmouse.h |    2 +-
 3 files changed, 229 insertions(+), 28 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index a3f492a..71b40ae 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -5,6 +5,7 @@
  * Copyright (c) 2003-2005 Peter Osterlund <petero2@telia.com>
  * Copyright (c) 2004 Dmitry Torokhov <dtor@mail.ru>
  * Copyright (c) 2005 Vojtech Pavlik <vojtech@suse.cz>
+ * Copyright (c) 2009 Sebastian Kapfer <sebastian_kapfer@gmx.net>
  *
  * ALPS detection, tap switching and status querying info is taken from
  * tpconfig utility (by C. Scott Ananian and Bruce Kall).
@@ -28,7 +29,6 @@
 #define dbg(format, arg...) do {} while (0)
 #endif
 
-
 #define ALPS_OLDPROTO		0x01	/* old style input */
 #define ALPS_DUALPOINT		0x02	/* touchpad has trackstick */
 #define ALPS_PASS		0x04	/* device has a pass-through port */
@@ -37,7 +37,8 @@
 #define ALPS_FW_BK_1		0x10	/* front & back buttons present */
 #define ALPS_FW_BK_2		0x20	/* front & back buttons present */
 #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
-
+#define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved with
+					   6-byte ALPS packet */
 
 static const struct alps_model_info alps_model_data[] = {
 	{ { 0x32, 0x02, 0x14 },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* Toshiba Salellite Pro M10 */
@@ -58,7 +59,9 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x20, 0x02, 0x0e },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* XXX */
 	{ { 0x22, 0x02, 0x0a },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },
 	{ { 0x22, 0x02, 0x14 }, 0xff, 0xff, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude D600 */
-	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude E6500 */
+	/* Dell Latitude E5500, E6400, E6500, Precision M4400 */
+	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
+		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED },
 	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell Vostro 1400 */
 };
 
@@ -69,20 +72,56 @@ static const struct alps_model_info alps_model_data[] = {
  */
 
 /*
- * ALPS abolute Mode - new format
+ * PS/2 packet format
+ *
+ * byte 0:  0    0 YSGN XSGN    1    M    R    L
+ * byte 1: X7   X6   X5   X4   X3   X2   X1   X0
+ * byte 2: Y7   Y6   Y5   Y4   Y3   Y2   Y1   Y0
+ *
+ * Note that the device never signals overflow condition.
+ *
+ * ALPS absolute Mode - new format
  *
  * byte 0:  1    ?    ?    ?    1    ?    ?    ?
  * byte 1:  0   x6   x5   x4   x3   x2   x1   x0
- * byte 2:  0   x10  x9   x8   x7    ?  fin  ges
+ * byte 2:  0  x10   x9   x8   x7    ?  fin  ges
  * byte 3:  0   y9   y8   y7    1    M    R    L
  * byte 4:  0   y6   y5   y4   y3   y2   y1   y0
  * byte 5:  0   z6   z5   z4   z3   z2   z1   z0
  *
+ * Dualpoint device -- interleaved packet format
+ *
+ * byte 0:    1    1    0    0    1    1    1    1
+ * byte 1:    0   x6   x5   x4   x3   x2   x1   x0
+ * byte 2:    0  x10   x9   x8   x7    0  fin  ges
+ * byte 3:    0    0 YSGN XSGN    1    1    1    1
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
 
+static void alps_report_buttons(struct input_dev *dev,
+				int left, int right, int middle,
+				bool release_only)
+{
+	if (!left || !release_only)
+		input_report_key(dev, BTN_LEFT, left);
+
+	if (!right || !release_only)
+		input_report_key(dev, BTN_RIGHT, right);
+
+	if (!middle || !release_only)
+		input_report_key(dev, BTN_MIDDLE, middle);
+}
+
 static void alps_process_packet(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
@@ -93,18 +132,6 @@ static void alps_process_packet(struct psmouse *psmouse)
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
@@ -140,18 +167,25 @@ static void alps_process_packet(struct psmouse *psmouse)
 		input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
 		input_report_rel(dev2, REL_Y, -(y > 255 ? (y - 512) : y));
 
-		input_report_key(dev2, BTN_LEFT, left);
-		input_report_key(dev2, BTN_RIGHT, right);
-		input_report_key(dev2, BTN_MIDDLE, middle);
+		alps_report_buttons(dev2, left, right, middle, false);
 
-		input_sync(dev);
 		input_sync(dev2);
+		input_sync(dev);
 		return;
 	}
 
-	input_report_key(dev, BTN_LEFT, left);
-	input_report_key(dev, BTN_RIGHT, right);
-	input_report_key(dev, BTN_MIDDLE, middle);
+	alps_report_buttons(dev, left, right, middle, false);
+
+	if (model->flags & ALPS_PS2_INTERLEAVED) {
+		/*
+		 * On devices using interleaved packets, when user presses
+		 * the same button on both trackpoint and touchpad, the
+		 * release for the trackpoint is not reported so we have
+		 * send release events to both devices.
+		 */
+		alps_report_buttons(dev2, left, right, middle, true);
+		input_sync(dev2);
+	}
 
 	/* Convert hardware tap to a reasonable Z value */
 	if (ges && !fin)
@@ -202,25 +236,188 @@ static void alps_process_packet(struct psmouse *psmouse)
 	input_sync(dev);
 }
 
+static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
+					unsigned char packet[],
+					bool report_buttons)
+{
+	struct alps_data *priv = psmouse->private;
+	struct input_dev *dev2 = priv->dev2;
+
+	if (report_buttons) {
+		int left = packet[0] & 1;
+		int right = packet[0] & 2;
+		int middle = packet[0] & 4;
+
+
+		if (priv->i->flags & ALPS_PS2_INTERLEAVED) {
+			alps_report_buttons(psmouse->dev,
+					    left, right, middle, true);
+			input_sync(psmouse->dev);
+		}
+
+		alps_report_buttons(dev2, left, right, middle, false);
+	}
+
+	input_report_rel(dev2, REL_X,
+		packet[1] ? packet[1] - ((packet[0] << 4) & 0x100) : 0);
+	input_report_rel(dev2, REL_Y,
+		packet[2] ? ((packet[0] << 3) & 0x100) - packet[2] : 0);
+
+	input_sync(dev2);
+}
+
+static bool alps_is_valid_first_byte(const struct alps_model_info *model,
+				     unsigned char data)
+{
+	return (data & model->mask0) == model->byte0;
+}
+
+static psmouse_ret_t alps_handle_interleaved_ps2(struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+
+	if (psmouse->pktcnt < 6)
+		return PSMOUSE_GOOD_DATA;
+
+	if (psmouse->pktcnt == 6) {
+		/*
+		 * Start a timer to flush the packet if it ends up last
+		 * 6-byte packet in the stream. Timer needs to fire
+		 * psmouse core times out itself. 20 ms should be enough
+		 * to decide if we are getting more data or not.
+		 */
+		mod_timer(&priv->timer, jiffies + msecs_to_jiffies(20));
+		return PSMOUSE_GOOD_DATA;
+	}
+
+	del_timer(&priv->timer);
+
+	if (psmouse->packet[6] & 0x80) {
+
+		/*
+		 * Highest bit is set - that means we either had
+		 * complete ALPS packet and this is start of the
+		 * next packet or we got garbage.
+		 */
+
+		if (((psmouse->packet[3] |
+		      psmouse->packet[4] |
+		      psmouse->packet[5]) & 0x80) ||
+		    (!alps_is_valid_first_byte(priv->i, psmouse->packet[6]))) {
+			dbg("refusing packet %x %x %x %x "
+			    "(suspected interleaved ps/2)\n",
+			    psmouse->packet[3], psmouse->packet[4],
+			    psmouse->packet[5], psmouse->packet[6]);
+			return PSMOUSE_BAD_DATA;
+		}
+
+		alps_process_packet(psmouse);
+
+		/* Continue with the next packet */
+		psmouse->packet[0] = psmouse->packet[6];
+		psmouse->pktcnt = 1;
+
+	} else {
+
+		/*
+		 * High bit is 0 - that means that we indeed got a PS/2
+		 * packet in the middle of ALPS packet.
+		 *
+		 * There is also possibility that we got 6-byte ALPS
+		 * packet followed  by 3-byte packet from trackpoint. We
+		 * can not distinguish between these 2 scenarios but
+		 * becase the latter is unlikely to happen in course of
+		 * normal operation (user would need to press all
+		 * buttons on the pad and start moving trackpoint
+		 * without touching the pad surface) we assume former.
+		 * Even if we are wrong the wost thing that would happen
+		 * the cursor would jump but we should not get protocol
+		 * desynchronization.
+		 */
+
+		if (psmouse->pktcnt == 9) {
+			/* Process interleaved PS/2 data */
+			alps_report_bare_ps2_packet(psmouse,
+				&psmouse->packet[3], false);
+
+			/* Continue with the standard ALPS protocol handling */
+			psmouse->packet[3] = psmouse->packet[6];
+			psmouse->packet[4] = psmouse->packet[7];
+			psmouse->packet[5] = psmouse->packet[8];
+			psmouse->pktcnt = 6;
+			alps_process_packet(psmouse);
+			return PSMOUSE_FULL_PACKET;
+		}
+	}
+
+	return PSMOUSE_GOOD_DATA;
+}
+
+static void alps_flush_packet(unsigned long data)
+{
+	struct psmouse *psmouse = (struct psmouse *)data;
+
+	serio_pause_rx(psmouse->ps2dev.serio);
+
+	if (psmouse->pktcnt == 6) {
+
+		/*
+		 * We did not any more data in reasonable amount of time.
+		 * Validate the last 3 bytes and process as a standard
+		 * ALPS packet.
+		 */
+		if ((psmouse->packet[3] |
+		     psmouse->packet[4] |
+		     psmouse->packet[5]) & 0x80) {
+			dbg("refusing packet %x %x %x "
+			    "(suspected interleaved ps/2)\n",
+			    psmouse->packet[3], psmouse->packet[4],
+			    psmouse->packet[5]);
+		} else {
+			alps_process_packet(psmouse);
+		}
+		psmouse->pktcnt = 0;
+	}
+
+	serio_continue_rx(psmouse->ps2dev.serio);
+}
+
 static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
+	const struct alps_model_info *model = priv->i;
+
+        dbg ("handle: %x", psmouse->packet[psmouse->pktcnt-1]);
 
 	if ((psmouse->packet[0] & 0xc8) == 0x08) { /* PS/2 packet */
 		if (psmouse->pktcnt == 3) {
-			alps_process_packet(psmouse);
+			alps_report_bare_ps2_packet(psmouse, psmouse->packet,
+						    true);
 			return PSMOUSE_FULL_PACKET;
 		}
 		return PSMOUSE_GOOD_DATA;
 	}
 
-	if ((psmouse->packet[0] & priv->i->mask0) != priv->i->byte0)
+	/* Check for PS/2 packet stuffed in the middle of ALPS packet. */
+
+	if ((model->flags & ALPS_PS2_INTERLEAVED) &&
+	    psmouse->pktcnt >= 4 && (psmouse->packet[3] & 0x0f) == 0x0f) {
+		return alps_handle_interleaved_ps2(psmouse);
+	}
+
+	if (!alps_is_valid_first_byte(model, psmouse->packet[0])) {
+		dbg("refusing packet[0] = %x (mask0 = %x, byte0 = %x)\n",
+		    psmouse->packet[0], model->mask0, model->byte0);
 		return PSMOUSE_BAD_DATA;
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
@@ -459,6 +656,7 @@ static void alps_disconnect(struct psmouse *psmouse)
 	struct alps_data *priv = psmouse->private;
 
 	psmouse_reset(psmouse);
+	del_timer_sync(&priv->timer);
 	input_unregister_device(priv->dev2);
 	kfree(priv);
 }
@@ -476,6 +674,8 @@ int alps_init(struct psmouse *psmouse)
 		goto init_fail;
 
 	priv->dev2 = dev2;
+	setup_timer(&priv->timer, alps_flush_packet, (unsigned long)psmouse);
+
 	psmouse->private = priv;
 
 	model = alps_get_model(psmouse, &version);
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index bc87936..904ed8b 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -23,6 +23,7 @@ struct alps_data {
 	char phys[32];			/* Phys */
 	const struct alps_model_info *i;/* Info */
 	int prev_fin;			/* Finger bit from previous packet */
+	struct timer_list timer;
 };
 
 #ifdef CONFIG_MOUSE_PS2_ALPS
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index e053bdd..d4772fe 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -42,7 +42,7 @@ struct psmouse {
 	struct delayed_work resync_work;
 	char *vendor;
 	char *name;
-	unsigned char packet[8];
+	unsigned char packet[9];
 	unsigned char badbyte;
 	unsigned char pktcnt;
 	unsigned char pktsize;
-- 
1.6.3.3



