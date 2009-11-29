From: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Subject: [alps] Timing patch, revised again :-)
Date: Sun, 29 Nov 2009 17:54:55 +0100
Message-ID: <1259513695.32495.171.camel@sardelle.necksus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46414 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751373AbZK2Qy5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 29 Nov 2009 11:54:57 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input ML <linux-input@vger.kernel.org>
Cc: David Kubicek <dave@awk.cz>


Dear Dmitry,

the timer patch so far works great.  You can't desync the touchpad
anymore by just pressing all buttons.  It still goes wrong when you
press all buttons and move both touchpad & trackpoint pointer tough :-)

I've changed two little things:

1. The reporting of buttons went to dev2 sometimes, as bare_ps2_packet
signalled the click on 'dev', not psmouse->dev.  This lead to sticking
buttons.

2. We needlessly break the distinction of PS/2 and touchpad on older
models, where it may have been cleanly possible.  (If you don't want to
keep that feature and rather simplify the code, that's fine with me,
too.  But as I said, bare_ps2_packet needs to be fixed up then.)

In the end, I think it's good enough to commit it.  I'm not really happy
with the fact that we need a timer now, but hey, it wasn't our fault.

Again, working great as long as you don't do really crazy stuff as
described above.  I just hope the 20msecs is not a machine parameter
which just happens to work for me.

Best wishes,
  Sebastian


Input: ALPS - add interleaved protocol support (Dell E6x00 series)

From: Sebastian Kapfer <sebastian_kapfer@gmx.net>

Properly handle version of the protocol where standard PS/2 packets
from trackpoint are stuffed into middle (byte 3-6) of the standard
ALPS packets when both the touchpad and trackpoint are used together.

The patch is based on work done by Matthew Chapman and additional
research done by David Kubicek and Erik Osterholm:

        https://bugs.launchpad.net/ubuntu/+source/linux/+bug/296610

Signed-off-by: Sebastian Kapfer <sebastian_kapfer@gmx.net>

---
 drivers/input/mouse/alps.c |  211 +++++++++++++++++++++++++++++++++++++++-----
 drivers/input/mouse/alps.h |    3 +-
 2 files changed, 189 insertions(+), 25 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index a3f492a..38aabb7 100644
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
@@ -37,6 +38,9 @@
 #define ALPS_FW_BK_1		0x10	/* front & back buttons present */
 #define ALPS_FW_BK_2		0x20	/* front & back buttons present */
 #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
+#define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved with
+					   6-byte ALPS packet */
+#define ALPS_SHARED_BTNSTATE	0x100	/* PS/2 and touchpad share button st. */
 
 
 static const struct alps_model_info alps_model_data[] = {
@@ -58,7 +62,9 @@ static const struct alps_model_info alps_model_data[] = {
 	{ { 0x20, 0x02, 0x0e },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT }, /* XXX */
 	{ { 0x22, 0x02, 0x0a },	0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },
 	{ { 0x22, 0x02, 0x14 }, 0xff, 0xff, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude D600 */
-	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf, ALPS_PASS | ALPS_DUALPOINT }, /* Dell Latitude E6500 */
+	/* Dell Latitude E6400, E6500, E5500, Precision M4400 */
+	{ { 0x62, 0x02, 0x14 }, 0xcf, 0xcf,
+		ALPS_PASS | ALPS_DUALPOINT | ALPS_PS2_INTERLEAVED | ALPS_SHARED_BTNSTATE },
 	{ { 0x73, 0x02, 0x50 }, 0xcf, 0xcf, ALPS_FOUR_BUTTONS },	  /* Dell Vostro 1400 */
 };
 
@@ -69,7 +75,13 @@ static const struct alps_model_info alps_model_data[] = {
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
@@ -78,11 +90,54 @@ static const struct alps_model_info alps_model_data[] = {
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
 
+/* at least some Alps units merge the mouse buttons of the touchpad and the
+ * PS/2 passthrough.  for the ALPS_PS2_INTERLEAVED units, we then can't
+ * distinguish which device a click came from, since the button bit in the
+ * interleaved packet could mean that either of the devices sent a click.
+ * (this has been tested in the field for all models except the M4400.)
+ * we route all the button clicks to the touchpad device.
+ * otherwise we easily end up with hung buttons.
+ */
+static void alps_report_buttons(struct psmouse *psmouse,
+                                int left, int right, int middle,
+                                struct input_dev *preferred_dev)
+{
+	struct alps_data *priv = psmouse->private;
+	const struct alps_model_info *model = priv->i;
+	struct input_dev *dev = preferred_dev;
+
+	if (model->flags & ALPS_SHARED_BTNSTATE
+	    && model->flags & ALPS_PS2_INTERLEAVED)
+		dev = psmouse->dev;
+
+	input_report_key(dev, BTN_LEFT, left);
+	input_report_key(dev, BTN_RIGHT, right);
+	input_report_key(dev, BTN_MIDDLE, middle);
+
+	/* calling code will input_sync the preferred_dev */
+	if (preferred_dev != dev)
+		input_sync(dev);
+}
+
 static void alps_process_packet(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
@@ -93,18 +148,6 @@ static void alps_process_packet(struct psmouse *psmouse)
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
@@ -140,18 +183,13 @@ static void alps_process_packet(struct psmouse *psmouse)
 		input_report_rel(dev2, REL_X,  (x > 383 ? (x - 768) : x));
 		input_report_rel(dev2, REL_Y, -(y > 255 ? (y - 512) : y));
 
-		input_report_key(dev2, BTN_LEFT, left);
-		input_report_key(dev2, BTN_RIGHT, right);
-		input_report_key(dev2, BTN_MIDDLE, middle);
+		alps_report_buttons(psmouse, left, right, middle, dev2);
 
-		input_sync(dev);
 		input_sync(dev2);
 		return;
 	}
 
-	input_report_key(dev, BTN_LEFT, left);
-	input_report_key(dev, BTN_RIGHT, right);
-	input_report_key(dev, BTN_MIDDLE, middle);
+	alps_report_buttons(psmouse, left, right, middle, dev);
 
 	/* Convert hardware tap to a reasonable Z value */
 	if (ges && !fin)
@@ -202,25 +240,147 @@ static void alps_process_packet(struct psmouse *psmouse)
 	input_sync(dev);
 }
 
+static void alps_report_bare_ps2_packet(unsigned char packet[],
+					struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+	struct input_dev *dev2 = priv->dev2;
+
+	alps_report_buttons(psmouse, packet[0] & 1, packet[0] & 2,
+	                    packet[0] & 4, dev2);
+	input_report_rel(dev2, REL_X,
+		packet[1] ? packet[1] - ((packet[0] << 4) & 0x100) : 0);
+	input_report_rel(dev2, REL_Y,
+		packet[2] ? ((packet[0] << 3) & 0x100) - packet[2] : 0);
+	input_sync(dev2);
+}
+
+static psmouse_ret_t alps_handle_interleaved_ps2(struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+
+	if (psmouse->pktcnt < 7) {
+		if (psmouse->pktcnt == 6 && !(psmouse->packet[3] & 0x80)) {
+			/*
+			 * Need to time out before timeout in psmouse core
+			 * code. 20 ms should be enough to decide if we are
+			 * getting more data or not.
+			 */
+			mod_timer(&priv->timer, jiffies + msecs_to_jiffies(20));
+		}
+
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
+		    (psmouse->packet[6] & priv->i->mask0) != priv->i->byte0) {
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
+		 * High bit is 0 - that means that we indeed
+		 * got a PS/2 packet in the middle of ALPS packet
+		 */
+
+		psmouse->packet[3] &= 0xf0 | (psmouse->packet[6] & 0x0f);
+		alps_report_bare_ps2_packet(&psmouse->packet[3], psmouse);
+
+		/*
+		 * Continue with the standard ALPS protocol handling
+		 */
+		psmouse->packet[3] = psmouse->packet[6];
+		psmouse->pktcnt = 4;
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
 
 	if ((psmouse->packet[0] & 0xc8) == 0x08) { /* PS/2 packet */
 		if (psmouse->pktcnt == 3) {
-			alps_process_packet(psmouse);
+			alps_report_bare_ps2_packet(psmouse->packet, psmouse);
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
+	if ((psmouse->packet[0] & model->mask0) != model->byte0) {
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
@@ -459,6 +619,7 @@ static void alps_disconnect(struct psmouse *psmouse)
 	struct alps_data *priv = psmouse->private;
 
 	psmouse_reset(psmouse);
+	del_timer_sync(&priv->timer);
 	input_unregister_device(priv->dev2);
 	kfree(priv);
 }
@@ -476,6 +637,8 @@ int alps_init(struct psmouse *psmouse)
 		goto init_fail;
 
 	priv->dev2 = dev2;
+	setup_timer(&priv->timer, alps_flush_packet, (unsigned long)psmouse);
+
 	psmouse->private = priv;
 
 	model = alps_get_model(psmouse, &version);
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index bc87936..ba4a7f5 100644
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
+	struct timer_list timer;
 };
 
 #ifdef CONFIG_MOUSE_PS2_ALPS
-- 
1.6.3.3



