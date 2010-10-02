From: Daniel Drake <dsd@laptop.org>
Subject: [PATCH 2/3] Input: hgpk - Rework spew detection
Date: Sat,  2 Oct 2010 21:42:39 +0100 (BST)
Message-ID: <20101002204239.CB11A9D401C@zog.reactivated.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from queueout04-winn.ispmail.ntl.com ([81.103.221.58]:3704 "EHLO
	queueout04-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751689Ab0JBUxS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Oct 2010 16:53:18 -0400
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
 drivers/input/mouse/hgpk.c |   69 +++++++++++++++++++++++++++++++++++++++----
 drivers/input/mouse/hgpk.h |   13 +++++++-
 2 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/hgpk.c b/drivers/input/mouse/hgpk.c
index de635ed..a6c4ffe 100644
--- a/drivers/input/mouse/hgpk.c
+++ b/drivers/input/mouse/hgpk.c
@@ -58,7 +58,7 @@ module_param(jumpy_delay, int, 0644);
 MODULE_PARM_DESC(jumpy_delay,
 	"delay (ms) before recal after jumpiness detected");
 
-static int spew_delay = 1000;
+static int spew_delay = 1;
 module_param(spew_delay, int, 0644);
 MODULE_PARM_DESC(spew_delay,
 	"delay (ms) before recal after packet spew detected");
@@ -95,6 +95,14 @@ static void hgpk_jumpy_hack(struct psmouse *psmouse, int x, int y)
 	}
 }
 
+static void reset_spew_detection(struct hgpk_data *priv)
+{
+	priv->spew_count = 0;
+	priv->x_tally = 0;
+	priv->y_tally = 0;
+	priv->spew_flag = NO_SPEW;
+}
+
 /*
  * We have no idea why this particular hardware bug occurs.  The touchpad
  * will randomly start spewing packets without anything touching the
@@ -120,20 +128,57 @@ static void hgpk_spewing_hack(struct psmouse *psmouse,
 	if (l || r)
 		return;
 
+	/* don't track spew if the workaround feature has been turned off */
+	if (!spew_delay)
+		return;
+
+	if (abs(x) > 3 || abs(y) > 3) {
+		/* no spew, or spew ended */
+		reset_spew_detection(priv);
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
 
@@ -229,9 +274,18 @@ static int process_advanced_packet(struct psmouse *psmouse, int *x, int *y,
 	 * relative calcs, and our jump detection.
 	 */
 	if (*x == priv->abs_x && *y == priv->abs_y) {
+		if (++priv->dupe_count > SPEW_WATCH_COUNT) {
+			if (tpdebug)
+				hgpk_dbg(psmouse, "hard spew detected\n");
+			priv->spew_flag = RECALIBRATING;
+			psmouse_queue_work(psmouse, &priv->recalib_wq,
+					   msecs_to_jiffies(spew_delay));
+		}
 		if (tpdebug)
 			hgpk_dbg(psmouse, "dupe\n");
 		return -1;
+	} else {
+		priv->dupe_count = 0;
 	}
 
 	/*
@@ -378,6 +432,7 @@ static int hgpk_force_recalibrate(struct psmouse *psmouse)
 	msleep(150);
 
 	priv->isdown = false;
+	reset_spew_detection(priv);
 
 	if (hgpk_advanced_mode(psmouse)) {
 		hgpk_err(psmouse, "Failed to reinit advanced mode!\n");
diff --git a/drivers/input/mouse/hgpk.h b/drivers/input/mouse/hgpk.h
index 002df7b..1ec18c8 100644
--- a/drivers/input/mouse/hgpk.h
+++ b/drivers/input/mouse/hgpk.h
@@ -16,12 +16,23 @@ enum hgpk_model_t {
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
 struct hgpk_data {
 	struct psmouse *psmouse;
 	bool powered;
 	bool isdown;
-	int count, x_tally, y_tally;	/* hardware workaround stuff */
+	enum hgpk_spew_flag spew_flag;
+	int spew_count, x_tally, y_tally;	/* spew detection */
 	int abs_x, abs_y;  /* for computing delta in advanced mode  */
+	int dupe_count;
 	int buttons;
 	unsigned long recalib_window;
 	struct delayed_work recalib_wq;
-- 
1.7.2.3

