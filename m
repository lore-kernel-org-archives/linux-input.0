From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH 1/2] Input: hgpk - Rework spew detection
Date: Sun,  7 Nov 2010 15:05:11 +0000 (GMT)
Message-ID: <20101107150511.D20C09D401B@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:12490 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752938Ab0KGPFS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 7 Nov 2010 10:05:18 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, dtor@mail.ru
Cc: linux-input@vger.kernel.org, pgf@laptop.org

The old implementation of spew detection simply tracked the overall
position delta of the cursor over every 100 packets. We found that
this causes occasional false positives in spew detection, and also
that the conditions of the spewy packets are perhaps more fixed than
we once thought.

Rework the spew detection to look for packets of specific small
delta, and only recalibrating if the overall movement delta stays
within expected bounds.

Also discard duplicate packets in the advanced mode, which appear
to be very common. If we don't, the spew detection kicks in far
too early. If we get a large spew of duplicates, request a
recalibration straight up.

Based on earlier work by Paul Fox.

Signed-off-by: Daniel Drake <dsd@laptop.org>
---
 drivers/input/mouse/hgpk.c |  122 ++++++++++++++++++++++++++++++++-----------
 drivers/input/mouse/hgpk.h |   13 ++++-
 2 files changed, 103 insertions(+), 32 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index 3d33d95..2225947 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -54,7 +54,7 @@ module_param(jumpy_delay, int, 0644);
 MODULE_PARM_DESC(jumpy_delay,
 	"delay (ms) before recal after jumpiness detected");
 
-static int spew_delay = 1000;
+static int spew_delay = 1;
 module_param(spew_delay, int, 0644);
 MODULE_PARM_DESC(spew_delay,
 	"delay (ms) before recal after packet spew detected");
@@ -117,6 +117,23 @@ static void hgpk_jumpy_hack(struct psmouse *psmouse, int x, int y)
 	}
 }
 
+static void hgpk_reset_spew_detection(struct hgpk_data *priv)
+{
+	priv->spew_count = 0;
+	priv->dupe_count = 0;
+	priv->x_tally = 0;
+	priv->y_tally = 0;
+	priv->spew_flag = NO_SPEW;
+}
+
+static void hgpk_reset_hack_state(struct psmouse *psmouse)
+{
+	struct hgpk_data *priv = psmouse->private;
+
+	priv->abs_x = priv->abs_y = -1;
+	hgpk_reset_spew_detection(priv);
+}
+
 /*
  * We have no idea why this particular hardware bug occurs.  The touchpad
  * will randomly start spewing packets without anything touching the
@@ -142,20 +159,57 @@ static void hgpk_spewing_hack(struct psmouse *psmouse,
 	if (l || r)
 		return;
 
+	/* don't track spew if the workaround feature has been turned off */
+	if (!spew_delay)
+		return;
+
+	if (abs(x) > 3 || abs(y) > 3) {
+		/* no spew, or spew ended */
+		hgpk_reset_spew_detection(priv);
+		return;
+	}
+
+	/* Keep a tally of the overall delta to the cursor position caused by
+	 * the spew */
 	priv->x_tally += x;
 	priv->y_tally += y;
 
-	if (++priv->count > 100) {
+	switch (priv->spew_flag) {
+	case NO_SPEW:
+		/* we're not spewing, but this packet might be the start */
+		priv->spew_flag = MAYBE_SPEWING;
+
+		/* fall-through */
+
+	case MAYBE_SPEWING:
+		priv->spew_count++;
+
+		if (priv->spew_count < SPEW_WATCH_COUNT)
+			break;
+
+		/* excessive spew detected, request recalibration */
+		priv->spew_flag = SPEW_DETECTED;
+
+		/* fall-through */
+
+	case SPEW_DETECTED:
+		/* only recalibrate when the overall delta to the cursor
+		 * is really small. if the spew is causing significant cursor
+		 * movement, it is probably a case of the user moving the
+		 * cursor very slowly across the screen. */
 		if (abs(priv->x_tally) < 3 && abs(priv->y_tally) < 3) {
-			hgpk_dbg(psmouse, "packet spew detected (%d,%d)\n",
+			hgpk_err(psmouse, "packet spew detected (%d,%d)\n",
 				 priv->x_tally, priv->y_tally);
+			priv->spew_flag = RECALIBRATING;
 			psmouse_queue_work(psmouse, &priv->recalib_wq,
 					   msecs_to_jiffies(spew_delay));
 		}
-		/* reset every 100 packets */
-		priv->count = 0;
-		priv->x_tally = 0;
-		priv->y_tally = 0;
+
+		break;
+	case RECALIBRATING:
+		/* we already detected a spew and requested a recalibration,
+		 * just wait for the queue to kick into action. */
+		break;
 	}
 }
 
@@ -267,30 +321,43 @@ static void hgpk_process_advanced_packet(struct psmouse *psmouse)
 	 * If this packet says that the finger was removed, reset our position
 	 * tracking so that we don't erroneously detect a jump on next press.
 	 */
-	if (!down)
-		priv->abs_x = priv->abs_y = -1;
+	if (!down) {
+		hgpk_reset_hack_state(priv);
+		goto done;
+	}
 
 	/*
-	 * Report position if finger/pen is down, but weed out duplicate
-	 * packets (we get quite a few in this mode, and they mess up our
-	 * jump detection.
+	 * Weed out duplicate packets (we get quite a few, and they mess up
+	 * our jump detection)
 	 */
-	if (down && (x != priv->abs_x || y != priv->abs_y)) {
-
-		/* Don't apply hacks in PT mode, it seems reliable */
-		if (priv->mode != HGPK_MODE_PENTABLET && priv->abs_x != -1) {
-			hgpk_jumpy_hack(psmouse,
-					priv->abs_x - x, priv->abs_y - y);
-			hgpk_spewing_hack(psmouse, left, right,
-					  priv->abs_x - x, priv->abs_y - y);
+	if (x == priv->abs_x && y == priv->abs_y) {
+		if (++priv->dupe_count > SPEW_WATCH_COUNT) {
+			if (tpdebug)
+				hgpk_dbg(psmouse, "hard spew detected\n");
+			priv->spew_flag = RECALIBRATING;
+			psmouse_queue_work(psmouse, &priv->recalib_wq,
+					   msecs_to_jiffies(spew_delay));
 		}
+		goto done;
+	}
 
-		input_report_abs(idev, ABS_X, x);
-		input_report_abs(idev, ABS_Y, y);
-		priv->abs_x = x;
-		priv->abs_y = y;
+	/* not a duplicate, continue with position reporting */
+	priv->dupe_count = 0;
+
+	/* Don't apply hacks in PT mode, it seems reliable */
+	if (priv->mode != HGPK_MODE_PENTABLET && priv->abs_x != -1) {
+		hgpk_jumpy_hack(psmouse,
+				priv->abs_x - x, priv->abs_y - y);
+		hgpk_spewing_hack(psmouse, left, right,
+				  priv->abs_x - x, priv->abs_y - y);
 	}
 
+	input_report_abs(idev, ABS_X, x);
+	input_report_abs(idev, ABS_Y, y);
+	priv->abs_x = x;
+	priv->abs_y = y;
+
+done:
 	input_sync(idev);
 }
 
@@ -462,13 +529,6 @@ static void hgpk_setup_input_device(struct input_dev *input,
 	}
 }
 
-static void hgpk_reset_hack_state(struct psmouse *psmouse)
-{
-	struct hgpk_data *priv = psmouse->private;
-
-	priv->abs_x = priv->abs_y = -1;
-}
-
 static int hgpk_reset_device(struct psmouse *psmouse, bool recalibrate)
 {
 	int err;
diff --git a/drivers/input/mouse/hgpk.h b/drivers/input/mouse/hgpk.h
index 01c983b..bccdb26 100644
--- a/drivers/input/mouse/hgpk.h
+++ b/drivers/input/mouse/hgpk.h
@@ -16,6 +16,15 @@ enum hgpk_model_t {
 	HGPK_MODEL_D = 0x50,	/* C1, mass production */
 };
 
+enum hgpk_spew_flag {
+	NO_SPEW,
+	MAYBE_SPEWING,
+	SPEW_DETECTED,
+	RECALIBRATING,
+};
+
+#define SPEW_WATCH_COUNT 42  /* at 12ms/packet, this is 1/2 second */
+
 enum hgpk_mode {
 	HGPK_MODE_MOUSE,
 	HGPK_MODE_GLIDESENSOR,
@@ -27,10 +36,12 @@ struct hgpk_data {
 	struct psmouse *psmouse;
 	enum hgpk_mode mode;
 	bool powered;
-	int count, x_tally, y_tally;	/* hardware workaround stuff */
+	enum hgpk_spew_flag spew_flag;
+	int spew_count, x_tally, y_tally;	/* spew detection */
 	unsigned long recalib_window;
 	struct delayed_work recalib_wq;
 	int abs_x, abs_y;
+	int dupe_count;
 };
 
 #define hgpk_dbg(psmouse, format, arg...)		\
-- 
1.7.3.2

