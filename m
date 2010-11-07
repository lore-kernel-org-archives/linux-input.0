From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH 2/2] Input: hgpk - Extend jumpyness detection
Date: Sun,  7 Nov 2010 15:05:26 +0000 (GMT)
Message-ID: <20101107150526.3EB219D401B@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:19947 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752938Ab0KGPFa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Nov 2010 10:05:30 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org, pgf@laptop.org

In addition to forcing recalibrations upon detection of cursor jumps (and
performing them quicker than before), detect and discard errant 'jump'
packets caused by a firmware bug, which are then repeated with each one
being approximately half the delta of the one previously (as if it is
averaging out)

Based on original work by Paul Fox

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/mouse/hgpk.c |  106 +++++++++++++++++++++++++++++++++++--------
 drivers/input/mouse/hgpk.h |    2 +
 2 files changed, 88 insertions(+), 20 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 2225947..5404cf0 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -40,6 +40,8 @@
 #include "psmouse.h"
 #include "hgpk.h"
 
+#define ILLEGAL_XY 999999
+
 static bool tpdebug;
 module_param(tpdebug, bool, 0644);
 MODULE_PARM_DESC(tpdebug, "enable debugging, dumping packets to KERN_DEBUG.");
@@ -47,9 +49,10 @@ MODULE_PARM_DESC(tpdebug, "enable debugging, dumping packets to KERN_DEBUG.");
 static int recalib_delta = 100;
 module_param(recalib_delta, int, 0644);
 MODULE_PARM_DESC(recalib_delta,
-	"packets containing a delta this large will cause a recalibration.");
+	"packets containing a delta this large will be discarded, and a "
+	"recalibration may be scheduled.");
 
-static int jumpy_delay = 1000;
+static int jumpy_delay = 20;
 module_param(jumpy_delay, int, 0644);
 MODULE_PARM_DESC(jumpy_delay,
 	"delay (ms) before recal after jumpiness detected");
@@ -96,25 +99,76 @@ static int hgpk_mode_from_name(const char *buf, int len)
 }
 
 /*
- * When the touchpad gets ultra-sensitive, one can keep their finger 1/2"
- * above the pad and still have it send packets.  This causes a jump cursor
- * when one places their finger on the pad.  We can probably detect the
- * jump as we see a large deltas (>= 100px).  In mouse mode, I've been
- * unable to even come close to 100px deltas during normal usage, so I think
- * this threshold is safe.  If a large delta occurs, trigger a recalibration.
+ * see if new value is within 20% of half of old value
+ */
+static int approx_half(int curr, int prev)
+{
+	int belowhalf, abovehalf;
+
+	if (curr < 5 || prev < 5)
+		return 0;
+
+	belowhalf = (prev * 8) / 20;
+	abovehalf = (prev * 12) / 20;
+
+	return belowhalf < curr && curr <= abovehalf;
+}
+
+/*
+ * Throw out oddly large delta packets, and any that immediately follow whose
+ * values are each approximately half of the previous.  It seems that the ALPS
+ * firmware emits errant packets, and they get averaged out slowly.
  */
-static void hgpk_jumpy_hack(struct psmouse *psmouse, int x, int y)
+static int hgpk_discard_decay_hack(struct psmouse *psmouse, int x, int y)
 {
 	struct hgpk_data *priv = psmouse->private;
+	int do_recal = 0;
+	int avx, avy;
+
+	avx = abs(x);
+	avy = abs(y);
+
+	/* discard if too big, or half that but > 4 times the prev delta */
+	if (avx > recalib_delta ||
+		(avx > recalib_delta / 2 && ((avx / 4) > priv->xlast))) {
+		hgpk_err(psmouse, "detected %dpx jump in x\n", x);
+		priv->xbigj = avx;
+	} else if (approx_half(avx, priv->xbigj)) {
+		hgpk_err(psmouse, "detected secondary %dpx jump in x\n", x);
+		priv->xbigj = avx;
+		priv->xsaw_secondary++;
+	} else {
+		if (priv->xbigj && priv->xsaw_secondary > 1)
+			do_recal = 1;
+		priv->xbigj = 0;
+		priv->xsaw_secondary = 0;
+	}
 
-	if (abs(x) > recalib_delta || abs(y) > recalib_delta) {
-		hgpk_err(psmouse, ">%dpx jump detected (%d,%d)\n",
-				recalib_delta, x, y);
-		/* My car gets forty rods to the hogshead and that's the
-		 * way I likes it! */
+	if (avy > recalib_delta ||
+		(avy > recalib_delta / 2 && ((avy / 4) > priv->ylast))) {
+		hgpk_err(psmouse, "detected %dpx jump in y\n", y);
+		priv->ybigj = avy;
+	} else if (approx_half(avy, priv->ybigj)) {
+		hgpk_err(psmouse, "detected secondary %dpx jump in y\n", y);
+		priv->ybigj = avy;
+		priv->ysaw_secondary++;
+	} else {
+		if (priv->ybigj && priv->ysaw_secondary > 1)
+			do_recal = 1;
+		priv->ybigj = 0;
+		priv->ysaw_secondary = 0;
+	}
+
+	priv->xlast = avx;
+	priv->ylast = avy;
+
+	if (do_recal && jumpy_delay) {
+		hgpk_err(psmouse, "scheduling recalibration\n");
 		psmouse_queue_work(psmouse, &priv->recalib_wq,
 				msecs_to_jiffies(jumpy_delay));
 	}
+
+	return priv->xbigj || priv->ybigj;
 }
 
 static void hgpk_reset_spew_detection(struct hgpk_data *priv)
@@ -131,6 +185,9 @@ static void hgpk_reset_hack_state(struct psmouse *psmouse)
 	struct hgpk_data *priv = psmouse->private;
 
 	priv->abs_x = priv->abs_y = -1;
+	priv->xlast = priv->ylast = ILLEGAL_XY;
+	priv->xbigj = priv->ybigj = 0;
+	priv->xsaw_secondary = priv->ysaw_secondary = 0;
 	hgpk_reset_spew_detection(priv);
 }
 
@@ -322,7 +379,7 @@ static void hgpk_process_advanced_packet(struct psmouse *psmouse)
 	 * tracking so that we don't erroneously detect a jump on next press.
 	 */
 	if (!down) {
-		hgpk_reset_hack_state(priv);
+		hgpk_reset_hack_state(psmouse);
 		goto done;
 	}
 
@@ -346,10 +403,14 @@ static void hgpk_process_advanced_packet(struct psmouse *psmouse)
 
 	/* Don't apply hacks in PT mode, it seems reliable */
 	if (priv->mode != HGPK_MODE_PENTABLET && priv->abs_x != -1) {
-		hgpk_jumpy_hack(psmouse,
-				priv->abs_x - x, priv->abs_y - y);
-		hgpk_spewing_hack(psmouse, left, right,
-				  priv->abs_x - x, priv->abs_y - y);
+		int x_diff = priv->abs_x - x;
+		int y_diff = priv->abs_y - y;
+		if (hgpk_discard_decay_hack(psmouse, x_diff, y_diff)) {
+			if (tpdebug)
+				hgpk_dbg(psmouse, "discarding\n");
+			goto done;
+		}
+		hgpk_spewing_hack(psmouse, left, right, x_diff, y_diff);
 	}
 
 	input_report_abs(idev, ABS_X, x);
@@ -370,7 +431,12 @@ static void hgpk_process_simple_packet(struct psmouse *psmouse)
 	int x = packet[1] - ((packet[0] << 4) & 0x100);
 	int y = ((packet[0] << 3) & 0x100) - packet[2];
 
-	hgpk_jumpy_hack(psmouse, x, y);
+	if (hgpk_discard_decay_hack(psmouse, x, y)) {
+		if (tpdebug)
+			hgpk_dbg(psmouse, "discarding\n");
+		return;
+	}
+
 	hgpk_spewing_hack(psmouse, left, right, x, y);
 
 	if (tpdebug)
diff --git a/drivers/input/mouse/hgpk.h b/drivers/input/mouse/hgpk.h
index bccdb26..698ecd4 100644
--- a/drivers/input/mouse/hgpk.h
+++ b/drivers/input/mouse/hgpk.h
@@ -42,6 +42,8 @@ struct hgpk_data {
 	struct delayed_work recalib_wq;
 	int abs_x, abs_y;
 	int dupe_count;
+	int xbigj, ybigj, xlast, ylast; /* jumpyness detection */
+	int xsaw_secondary, ysaw_secondary; /* jumpyness detection */
 };
 
 #define hgpk_dbg(psmouse, format, arg...)		\
-- 
1.7.3.2

