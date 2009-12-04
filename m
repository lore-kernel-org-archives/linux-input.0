From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [alps] Timing patch, revised again :-)
Date: Fri, 4 Dec 2009 00:49:02 -0800
Message-ID: <20091204084902.GB22570@core.coreip.homeip.net>
References: <1259513695.32495.171.camel@sardelle.necksus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.211.182]:44766 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755130AbZLDItC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 03:49:02 -0500
Received: by ywh12 with SMTP id 12so2363462ywh.21
        for <linux-input@vger.kernel.org>; Fri, 04 Dec 2009 00:49:08 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1259513695.32495.171.camel@sardelle.necksus.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Kapfer <sebastian_kapfer@gmx.net>
Cc: Linux Input ML <linux-input@vger.kernel.org>, David Kubicek <dave@awk.cz>

Hi Sebastian,

Sorry for the delay, I finally had the time to look over the patch
again.

On Sun, Nov 29, 2009 at 05:54:55PM +0100, Sebastian Kapfer wrote:
> 
> Dear Dmitry,
> 
> the timer patch so far works great.  You can't desync the touchpad
> anymore by just pressing all buttons.  It still goes wrong when you
> press all buttons and move both touchpad & trackpoint pointer tough :-)
> 

Yeah, but due to protocol limitations we can't really do anything about
it. It should not desync though.

> I've changed two little things:
> 
> 1. The reporting of buttons went to dev2 sometimes, as bare_ps2_packet
> signalled the click on 'dev', not psmouse->dev.  This lead to sticking
> buttons.
> 
> 2. We needlessly break the distinction of PS/2 and touchpad on older
> models, where it may have been cleanly possible.  (If you don't want to
> keep that feature and rather simplify the code, that's fine with me,
> too.  But as I said, bare_ps2_packet needs to be fixed up then.)
> 

I tend to agree with Dave's preference of routing button data from 3-byte
packets to stick only and 6- and 9-byte packets to the pad and sending
release to both devices. I think it makes most sense.

> In the end, I think it's good enough to commit it.  I'm not really happy
> with the fact that we need a timer now, but hey, it wasn't our fault.
> 
> Again, working great as long as you don't do really crazy stuff as
> described above.  I just hope the 20msecs is not a machine parameter
> which just happens to work for me.

No it should not, unless the box is loaded very heavily so that
servicing of interrrupts and timers is delayed severely.

Anyway, I rearranged the patch again a bit, could you please try it out
once more and let me know if it still works and I will apply it so it is
included in 2.6.33.

Thanks!

-- 
Dmitry


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
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/alps.c |  247 +++++++++++++++++++++++++++++++++++++++-----
 drivers/input/mouse/alps.h |    1 
 2 files changed, 221 insertions(+), 27 deletions(-)


diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index a3f492a..a8f6917 100644
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
@@ -202,25 +236,181 @@ static void alps_process_packet(struct psmouse *psmouse)
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
+		alps_report_bare_ps2_packet(psmouse, &psmouse->packet[3],
+					    false);
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
@@ -459,6 +649,7 @@ static void alps_disconnect(struct psmouse *psmouse)
 	struct alps_data *priv = psmouse->private;
 
 	psmouse_reset(psmouse);
+	del_timer_sync(&priv->timer);
 	input_unregister_device(priv->dev2);
 	kfree(priv);
 }
@@ -476,6 +667,8 @@ int alps_init(struct psmouse *psmouse)
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
