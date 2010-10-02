From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH 1/3] Input: hgpk - enable advanced mode through module parameter
Date: Sat,  2 Oct 2010 21:42:34 +0100 (BST)
Message-ID: <20101002204235.052959D401B@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:3704 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751689Ab0JBUxQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Oct 2010 16:53:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org, pgf@laptop.org

We continue battling "cursor madness" problems with this touchpad when
the units are out in the field, but the problems are hard to reproduce
elsewhere.

Add a module option to enable advanced mode, which is possibly more
reliable than simple mode.

Based on work by Paul Fox

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/mouse/hgpk.c |  184 +++++++++++++++++++++++++++++++++++++++++---
 drivers/input/mouse/hgpk.h |    6 ++
 2 files changed, 180 insertions(+), 10 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 1d2205b..de635ed 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -44,6 +44,10 @@ static bool tpdebug;
 module_param(tpdebug, bool, 0644);
 MODULE_PARM_DESC(tpdebug, "enable debugging, dumping packets to KERN_DEBUG.");
 
+static int advanced;
+module_param(advanced, int, 0644);
+MODULE_PARM_DESC(advanced, "use 6-byte packet advanced mode.");
+
 static int recalib_delta = 100;
 module_param(recalib_delta, int, 0644);
 MODULE_PARM_DESC(recalib_delta,
@@ -143,23 +147,130 @@ static void hgpk_spewing_hack(struct psmouse *psmouse,
  * swr/swl are the left/right buttons.
  * x-neg/y-neg are the x and y delta negative bits
  * x-over/y-over are the x and y overflow bits
+ *
+ * ---
+ *
+ * HGPK Advanced Mode - single-mode format
+ *
+ * byte 0(PT):  1    1    0    0    1    1     1     1
+ * byte 0(GS):  1    1    1    1    1    1     1     1
+ * byte 1:      0   x6   x5   x4   x3   x2    x1    x0
+ * byte 2(PT):  0    0   x9   x8   x7    ? pt-dsw    0
+ * byte 2(GS):  0  x10   x9   x8   x7    ? gs-dsw pt-dsw
+ * byte 3:      0   y9   y8   y7    1    0   swr   swl
+ * byte 4:      0   y6   y5   y4   y3   y2    y1    y0
+ * byte 5:      0   z6   z5   z4   z3   z2    z1    z0
+ *
+ * ?'s are not defined in the protocol spec, may vary between models.
+ *
+ * swr/swl are the left/right buttons.
+ *
+ * pt-dsw/gs-dsw indicate that the pt/gs sensor is detecting a
+ * pen/finger
  */
 static int hgpk_validate_byte(unsigned char *packet)
 {
 	return (packet[0] & 0x0C) != 0x08;
 }
 
+static int hgpk_validate_advanced_byte(unsigned char *packet, int pktcnt)
+{
+	BUG_ON(pktcnt < 1);
+
+	if (packet[0] != HGPK_GS)
+		return -1;
+
+	/* bytes 2 - 6 should have 0 in the highest bit */
+	if (pktcnt >= 2 && pktcnt <= 6 && (packet[pktcnt - 1] & 0x80))
+		return -1;
+
+	return 0;
+}
+
+static int process_advanced_packet(struct psmouse *psmouse, int *x, int *y,
+				    int *left, int *right)
+{
+	struct hgpk_data *priv = psmouse->private;
+	unsigned char *packet = psmouse->packet;
+	int down, pt_down;
+	int z, buttons, tmp;
+
+	BUG_ON(psmouse->pktcnt < 6);
+
+	*left = !!(packet[3] & 1);
+	*right = !!(packet[3] & 2);
+	buttons = (packet[3] & 3);
+	*x = packet[1] | ((packet[2] & 0x78) << 4);
+	*y = packet[4] | ((packet[3] & 0x70) << 3);
+	z = packet[5];
+
+	BUG_ON(packet[0] == HGPK_PT);
+	pt_down = !!(packet[2] & 1);
+	down = !!(packet[2] & 2);
+
+	if (tpdebug)
+		hgpk_dbg(psmouse, "l=%d r=%d p=%d g=%d x=%d y=%d z=%d\n",
+			 *left, *right, pt_down, down, *x, *y, z);
+
+	if (!down) {
+		priv->isdown = false;
+		if (buttons != priv->buttons) {
+			*x = *y = 0;
+			priv->buttons = buttons;
+			return 0;
+		}
+		if (tpdebug)
+			hgpk_dbg(psmouse, "not down, no buttons, toss\n");
+		return -1;
+	}
+
+	/*
+	 * The pad seems to give us duplicates pretty often. They screw up our
+	 * relative calcs, and our jump detection.
+	 */
+	if (*x == priv->abs_x && *y == priv->abs_y) {
+		if (tpdebug)
+			hgpk_dbg(psmouse, "dupe\n");
+		return -1;
+	}
+
+	/*
+	 * The first packet after the finger goes down only establishes the
+	 * baseline for relative movement.
+	 * (ignore possibility of finger going down and button being pressed
+	 * simultaneously.)
+	 */
+	if (!priv->isdown) {
+		priv->abs_x = *x;
+		priv->abs_y = *y;
+		priv->isdown = true;
+		return false;
+	}
+
+	tmp = *x; *x -= priv->abs_x; priv->abs_x = tmp;
+	tmp = *y; *y -= priv->abs_y; priv->abs_y = tmp;
+
+	if (tpdebug)
+		hgpk_dbg(psmouse, "rx=%d ry=%d\n", *x, *y);
+	return 0;
+}
+
 static void hgpk_process_packet(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
 	unsigned char *packet = psmouse->packet;
 	int x, y, left, right;
 
-	left = packet[0] & 1;
-	right = (packet[0] >> 1) & 1;
+	if (advanced) {
+		if (process_advanced_packet(psmouse, &x, &y, &left, &right))
+			return;
+	} else {
+		left = packet[0] & 1;
+		right = (packet[0] >> 1) & 1;
 
-	x = packet[1] - ((packet[0] << 4) & 0x100);
-	y = ((packet[0] << 3) & 0x100) - packet[2];
+		x = packet[1] - ((packet[0] << 4) & 0x100);
+		y = ((packet[0] << 3) & 0x100) - packet[2];
+	}
 
 	hgpk_jumpy_hack(psmouse, x, y);
 	hgpk_spewing_hack(psmouse, left, right, x, y);
@@ -180,11 +291,25 @@ static psmouse_ret_t hgpk_process_byte(struct psmouse *psmouse)
 {
 	struct hgpk_data *priv = psmouse->private;
 
-	if (hgpk_validate_byte(psmouse->packet)) {
-		hgpk_dbg(psmouse, "%s: (%d) %02x %02x %02x\n",
-				__func__, psmouse->pktcnt, psmouse->packet[0],
-				psmouse->packet[1], psmouse->packet[2]);
-		return PSMOUSE_BAD_DATA;
+	if (advanced) {
+		if (hgpk_validate_advanced_byte(psmouse->packet,
+						psmouse->pktcnt)) {
+			hgpk_dbg(psmouse, "%s: (%d bytes): "
+				 "%02x %02x %02x %02x %02x %02x\n",
+				 __func__, psmouse->pktcnt,
+				 psmouse->packet[0], psmouse->packet[1],
+				 psmouse->packet[2], psmouse->packet[3],
+				 psmouse->packet[4], psmouse->packet[5]);
+			return PSMOUSE_BAD_DATA;
+		}
+	} else {
+		if (hgpk_validate_byte(psmouse->packet)) {
+			hgpk_dbg(psmouse, "%s: (%d) %02x %02x %02x\n",
+				 __func__, psmouse->pktcnt,
+				 psmouse->packet[0], psmouse->packet[1],
+				 psmouse->packet[2]);
+			return PSMOUSE_BAD_DATA;
+		}
 	}
 
 	if (psmouse->pktcnt >= psmouse->pktsize) {
@@ -210,6 +335,22 @@ static psmouse_ret_t hgpk_process_byte(struct psmouse *psmouse)
 	return PSMOUSE_GOOD_DATA;
 }
 
+static int hgpk_advanced_mode(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+
+	if (!advanced)
+		return 0;
+
+	/* Switch to 'Advanced mode.', four disables in a row. */
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
+			ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
+			ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE) ||
+			ps2_command(ps2dev, NULL, PSMOUSE_CMD_DISABLE))
+		return -1;
+	return 0;
+}
+
 static int hgpk_force_recalibrate(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
@@ -236,6 +377,13 @@ static int hgpk_force_recalibrate(struct psmouse *psmouse)
 	/* according to ALPS, 150mS is required for recalibration */
 	msleep(150);
 
+	priv->isdown = false;
+
+	if (hgpk_advanced_mode(psmouse)) {
+		hgpk_err(psmouse, "Failed to reinit advanced mode!\n");
+		return -1;
+	}
+
 	/* XXX: If a finger is down during this delay, recalibration will
 	 * detect capacitance incorrectly.  This is a hardware bug, and
 	 * we don't have a good way to deal with it.  The 2s window stuff
@@ -290,6 +438,11 @@ static int hgpk_toggle_power(struct psmouse *psmouse, int enable)
 
 		psmouse_reset(psmouse);
 
+		if (hgpk_advanced_mode(psmouse)) {
+			hgpk_err(psmouse, "Failed to reinit advanced mode!\n");
+			return -1;
+		}
+
 		/* should be all set, enable the touchpad */
 		ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_ENABLE);
 		psmouse_set_state(psmouse, PSMOUSE_ACTIVATED);
@@ -329,6 +482,11 @@ static int hgpk_reconnect(struct psmouse *psmouse)
 
 	psmouse_reset(psmouse);
 
+	if (hgpk_advanced_mode(psmouse)) {
+		hgpk_err(psmouse, "failed to reenable advanced mode.\n");
+		return -1;
+	}
+
 	return 0;
 }
 
@@ -431,7 +589,7 @@ static int hgpk_register(struct psmouse *psmouse)
 	psmouse->poll = hgpk_poll;
 	psmouse->disconnect = hgpk_disconnect;
 	psmouse->reconnect = hgpk_reconnect;
-	psmouse->pktsize = 3;
+	psmouse->pktsize = advanced ? 6 : 3;
 
 	/* Disable the idle resync. */
 	psmouse->resync_time = 0;
@@ -479,6 +637,12 @@ int hgpk_init(struct psmouse *psmouse)
 	if (err)
 		goto init_fail;
 
+	err = hgpk_advanced_mode(psmouse);
+	if (err) {
+		hgpk_err(psmouse, "failed to enable advanced mode\n");
+		goto init_fail;
+	}
+
 	err = hgpk_register(psmouse);
 	if (err)
 		goto init_fail;
diff --git a/drivers/input/mouse/hgpk.h b/drivers/input/mouse/hgpk.h
index d61cfd3..002df7b 100644
--- a/drivers/input/mouse/hgpk.h
+++ b/drivers/input/mouse/hgpk.h
@@ -5,6 +5,9 @@
 #ifndef _HGPK_H
 #define _HGPK_H
 
+#define HGPK_GS		0xff       /* The GlideSensor */
+#define HGPK_PT		0xcf       /* The PenTablet */
+
 enum hgpk_model_t {
 	HGPK_MODEL_PREA = 0x0a,	/* pre-B1s */
 	HGPK_MODEL_A = 0x14,	/* found on B1s, PT disabled in hardware */
@@ -16,7 +19,10 @@ enum hgpk_model_t {
 struct hgpk_data {
 	struct psmouse *psmouse;
 	bool powered;
+	bool isdown;
 	int count, x_tally, y_tally;	/* hardware workaround stuff */
+	int abs_x, abs_y;  /* for computing delta in advanced mode  */
+	int buttons;
 	unsigned long recalib_window;
 	struct delayed_work recalib_wq;
 };
-- 
1.7.2.3

