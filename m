From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH 3/3] Input: hgpk - Extend jumpyness detection
Date: Sat,  2 Oct 2010 21:42:43 +0100 (BST)
Message-ID: <20101002204243.EFD039D401B@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:3704 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751689Ab0JBUxT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Oct 2010 16:53:19 -0400
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
 drivers/input/mouse/hgpk.c |   97 +++++++++++++++++++++++++++++++++++--------
 drivers/input/mouse/hgpk.h |    2 +
 2 files changed, 81 insertions(+), 18 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index a6c4ffe..975951d 100644
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
@@ -48,12 +50,13 @@ static int advanced;
 module_param(advanced, int, 0644);
 MODULE_PARM_DESC(advanced, "use 6-byte packet advanced mode.");
 
-static int recalib_delta = 100;
-module_param(recalib_delta, int, 0644);
-MODULE_PARM_DESC(recalib_delta,
-	"packets containing a delta this large will cause a recalibration.");
+static int discard_threshold = 60;
+module_param(discard_threshold, int, 0644);
+MODULE_PARM_DESC(discard_threshold,
+	"packets with a delta this large will be discarded, "
+	"and a recalibration may be scheduled.");
 
-static int jumpy_delay = 1000;
+static int jumpy_delay = 20;
 module_param(jumpy_delay, int, 0644);
 MODULE_PARM_DESC(jumpy_delay,
 	"delay (ms) before recal after jumpiness detected");
@@ -74,25 +77,77 @@ MODULE_PARM_DESC(post_interrupt_delay,
 	"delay (ms) before recal after recal interrupt detected");
 
 /*
- * When the touchpad gets ultra-sensitive, one can keep their finger 1/2"
- * above the pad and still have it send packets.  This causes a jump cursor
- * when one places their finger on the pad.  We can probably detect the
- * jump as we see a large deltas (>= 100px).  In mouse mode, I've been
- * unable to even come close to 100px deltas during normal usage, so I think
- * this threshold is safe.  If a large delta occurs, trigger a recalibration.
+ * see if new value is within 20% of half of old value
  */
-static void hgpk_jumpy_hack(struct psmouse *psmouse, int x, int y)
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
+ * Throw out oddly large packets, and any that immediately follow whose
+ * values are each approximately half of the previous.  It seems
+ * that the ALPS firmware emits errant packets, and they get averaged
+ * out slowly.
+ */
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
+	if (avx > discard_threshold ||
+		(avx > discard_threshold/2 && ((avx / 4) > priv->xlast))) {
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
+
+	if (avy > discard_threshold ||
+		(avy > discard_threshold/2 && ((avy / 4) > priv->ylast))) {
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
 
-	if (abs(x) > recalib_delta || abs(y) > recalib_delta) {
-		hgpk_err(psmouse, ">%dpx jump detected (%d,%d)\n",
-				recalib_delta, x, y);
-		/* My car gets forty rods to the hogshead and that's the
-		 * way I likes it! */
+	if (do_recal && jumpy_delay) {
+		hgpk_err(psmouse, "scheduling recalibration\n");
 		psmouse_queue_work(psmouse, &priv->recalib_wq,
 				msecs_to_jiffies(jumpy_delay));
 	}
+
+	return priv->xbigj || priv->ybigj;
 }
 
 static void reset_spew_detection(struct hgpk_data *priv)
@@ -326,7 +381,12 @@ static void hgpk_process_packet(struct psmouse *psmouse)
 		y = ((packet[0] << 3) & 0x100) - packet[2];
 	}
 
-	hgpk_jumpy_hack(psmouse, x, y);
+	if (hgpk_discard_decay_hack(psmouse, x, y)) {
+		if (tpdebug)
+			hgpk_dbg(psmouse, "discarding\n");
+		return;
+	}
+
 	hgpk_spewing_hack(psmouse, left, right, x, y);
 
 	if (tpdebug)
@@ -686,6 +746,7 @@ int hgpk_init(struct psmouse *psmouse)
 	psmouse->private = priv;
 	priv->psmouse = psmouse;
 	priv->powered = true;
+	priv->xlast = priv->ylast = ILLEGAL_XY;
 	INIT_DELAYED_WORK(&priv->recalib_wq, hgpk_recalib_work);
 
 	err = psmouse_reset(psmouse);
diff --git a/drivers/input/mouse/hgpk.h b/drivers/input/mouse/hgpk.h
index 1ec18c8..5991be2 100644
--- a/drivers/input/mouse/hgpk.h
+++ b/drivers/input/mouse/hgpk.h
@@ -32,6 +32,8 @@ struct hgpk_data {
 	enum hgpk_spew_flag spew_flag;
 	int spew_count, x_tally, y_tally;	/* spew detection */
 	int abs_x, abs_y;  /* for computing delta in advanced mode  */
+	int xbigj, ybigj, xlast, ylast; /* jumpyness detection */
+	int xsaw_secondary, ysaw_secondary; /* jumpyness detection */
 	int dupe_count;
 	int buttons;
 	unsigned long recalib_window;
-- 
1.7.2.3

