From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] Input: MT - Add support for balanced slot assignment
Date: Sun, 1 Feb 2015 10:03:23 +0100
Message-ID: <20150201090323.GA12868@polaris.bitmath.org>
References: <1421956345-1546-1-git-send-email-rydberg@bitmath.org>
 <CAN+gG=FNJ8O-=Q4kpsVSYYY+o3KLHpfm43OT-AgTPkHYF-zVLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAN+gG=FNJ8O-=Q4kpsVSYYY+o3KLHpfm43OT-AgTPkHYF-zVLg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Peter Hutterer <peter.hutterer@who-t.net>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

> Tested this morning, and yes, it solves the problem.
> I assumed that the dmax was in mm, and used "10 * priv->x_res", which
> seemed to do the trick:
> - tapping with two fingers side by side triggered the jumps
> - in the general case (switching from the index to the thumb to
> click), the jumps disappeared.

Great, thanks for testing.

> Maybe we should also add a doc telling which units the dmax should be.

I added an enhanced description, which hopefully clarifies the units
of dmax.

> When you'll sign this, you can add my tested-by.

Done, and tested against Linus' master. I take it you have a patch on
this coming up as well?

Thanks,
Henrik

>From 2a4986420e634df2f0ba09198cb1e55714f61577 Mon Sep 17 00:00:00 2001
From: Henrik Rydberg <rydberg@bitmath.org>
Date: Sun, 1 Feb 2015 09:16:10 +0100
Subject: [PATCH v2] Input: MT - Add support for balanced slot assignment

Some devices are not fast enough to differentiate between a
fast-moving contact and a new contact. This problem cannot be fully
resolved because information is truly missing, but it is possible
to safe-guard against obvious mistakes by restricting movement with
a maximum displacement.

The new problem formulation for dmax > 0 cannot benefit from the
speedup for positive definite matrices, but since the convergence is
faster, the result is about the same. For a handful of contacts, the
latency difference is truly negligible.

Suggested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Tested-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Henrik Rydberg <rydberg@bitmath.org>
---
 drivers/input/input-mt.c                  | 31 ++++++++++++++++++++-----------
 drivers/input/mouse/alps.c                |  2 +-
 drivers/input/mouse/bcm5974.c             |  2 +-
 drivers/input/mouse/cypress_ps2.c         |  2 +-
 drivers/input/mouse/synaptics.c           |  2 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c |  2 +-
 include/linux/input/mt.h                  |  3 ++-
 7 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/input/input-mt.c b/drivers/input/input-mt.c
index fbe29fc..cb150a1 100644
--- a/drivers/input/input-mt.c
+++ b/drivers/input/input-mt.c
@@ -293,7 +293,7 @@ void input_mt_sync_frame(struct input_dev *dev)
 }
 EXPORT_SYMBOL(input_mt_sync_frame);
 
-static int adjust_dual(int *begin, int step, int *end, int eq)
+static int adjust_dual(int *begin, int step, int *end, int eq, int mu)
 {
 	int f, *p, s, c;
 
@@ -311,9 +311,10 @@ static int adjust_dual(int *begin, int step, int *end, int eq)
 			s = *p;
 
 	c = (f + s + 1) / 2;
-	if (c == 0 || (c > 0 && !eq))
+	if (c == 0 || (c > mu && (!eq || mu > 0)))
 		return 0;
-	if (s < 0)
+	/* Improve convergence for positive matrices by penalizing overcovers */
+	if (s < 0 && mu <= 0)
 		c *= 2;
 
 	for (p = begin; p != end; p += step)
@@ -322,23 +323,24 @@ static int adjust_dual(int *begin, int step, int *end, int eq)
 	return (c < s && s <= 0) || (f >= 0 && f < c);
 }
 
-static void find_reduced_matrix(int *w, int nr, int nc, int nrc)
+static void find_reduced_matrix(int *w, int nr, int nc, int nrc, int mu)
 {
 	int i, k, sum;
 
 	for (k = 0; k < nrc; k++) {
 		for (i = 0; i < nr; i++)
-			adjust_dual(w + i, nr, w + i + nrc, nr <= nc);
+			adjust_dual(w + i, nr, w + i + nrc, nr <= nc, mu);
 		sum = 0;
 		for (i = 0; i < nrc; i += nr)
-			sum += adjust_dual(w + i, 1, w + i + nr, nc <= nr);
+			sum += adjust_dual(w + i, 1, w + i + nr, nc <= nr, mu);
 		if (!sum)
 			break;
 	}
 }
 
 static int input_mt_set_matrix(struct input_mt *mt,
-			       const struct input_mt_pos *pos, int num_pos)
+			       const struct input_mt_pos *pos, int num_pos,
+			       int mu)
 {
 	const struct input_mt_pos *p;
 	struct input_mt_slot *s;
@@ -352,7 +354,7 @@ static int input_mt_set_matrix(struct input_mt *mt,
 		y = input_mt_get_value(s, ABS_MT_POSITION_Y);
 		for (p = pos; p != pos + num_pos; p++) {
 			int dx = x - p->x, dy = y - p->y;
-			*w++ = dx * dx + dy * dy;
+			*w++ = dx * dx + dy * dy - mu;
 		}
 	}
 
@@ -393,17 +395,24 @@ static void input_mt_set_slots(struct input_mt *mt,
  * @slots: the slot assignment to be filled
  * @pos: the position array to match
  * @num_pos: number of positions
+ * @dmax: maximum ABS_MT_POSITION displacement (zero for infinite)
  *
  * Performs a best match against the current contacts and returns
  * the slot assignment list. New contacts are assigned to unused
  * slots.
  *
+ * The assignments are balanced so that all coordinate displacements are
+ * below the euclidian distance dmax. If no such assignment can be found,
+ * some contacts are assigned to unused slots.
+ *
  * Returns zero on success, or negative error in case of failure.
  */
 int input_mt_assign_slots(struct input_dev *dev, int *slots,
-			  const struct input_mt_pos *pos, int num_pos)
+			  const struct input_mt_pos *pos, int num_pos,
+			  int dmax)
 {
 	struct input_mt *mt = dev->mt;
+	int mu = 2 * dmax * dmax;
 	int nrc;
 
 	if (!mt || !mt->red)
@@ -413,8 +422,8 @@ int input_mt_assign_slots(struct input_dev *dev, int *slots,
 	if (num_pos < 1)
 		return 0;
 
-	nrc = input_mt_set_matrix(mt, pos, num_pos);
-	find_reduced_matrix(mt->red, num_pos, nrc / num_pos, nrc);
+	nrc = input_mt_set_matrix(mt, pos, num_pos, mu);
+	find_reduced_matrix(mt->red, num_pos, nrc / num_pos, nrc, mu);
 	input_mt_set_slots(mt, slots, num_pos);
 
 	return 0;
diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 54ff0379..6c64fb2 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -435,7 +435,7 @@ static void alps_report_mt_data(struct psmouse *psmouse, int n)
 	struct alps_fields *f = &priv->f;
 	int i, slot[MAX_TOUCHES];
 
-	input_mt_assign_slots(dev, slot, f->mt, n);
+	input_mt_assign_slots(dev, slot, f->mt, n, 0);
 	for (i = 0; i < n; i++)
 		alps_set_slot(dev, slot[i], f->mt[i].x, f->mt[i].y);
 
diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index c329cdb..b10709f 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -564,7 +564,7 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 		dev->index[n++] = &f[i];
 	}
 
-	input_mt_assign_slots(input, dev->slots, dev->pos, n);
+	input_mt_assign_slots(input, dev->slots, dev->pos, n, 0);
 
 	for (i = 0; i < n; i++)
 		report_finger_data(input, dev->slots[i],
diff --git a/drivers/input/mouse/cypress_ps2.c b/drivers/input/mouse/cypress_ps2.c
index 8af34ff..9118a18 100644
--- a/drivers/input/mouse/cypress_ps2.c
+++ b/drivers/input/mouse/cypress_ps2.c
@@ -538,7 +538,7 @@ static void cypress_process_packet(struct psmouse *psmouse, bool zero_pkt)
 		pos[i].y = contact->y;
 	}
 
-	input_mt_assign_slots(input, slots, pos, n);
+	input_mt_assign_slots(input, slots, pos, n, 0);
 
 	for (i = 0; i < n; i++) {
 		contact = &report_data.contacts[i];
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index f947292..84d0401 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1204,7 +1204,7 @@ static void synaptics_profile_sensor_process(struct psmouse *psmouse,
 		pos[i].y = synaptics_invert_y(hw[i]->y);
 	}
 
-	input_mt_assign_slots(dev, slot, pos, nsemi);
+	input_mt_assign_slots(dev, slot, pos, nsemi, 0);
 
 	for (i = 0; i < nsemi; i++) {
 		input_mt_slot(dev, slot[i]);
diff --git a/drivers/input/touchscreen/pixcir_i2c_ts.c b/drivers/input/touchscreen/pixcir_i2c_ts.c
index fc49c75..ccdf654 100644
--- a/drivers/input/touchscreen/pixcir_i2c_ts.c
+++ b/drivers/input/touchscreen/pixcir_i2c_ts.c
@@ -126,7 +126,7 @@ static void pixcir_ts_report(struct pixcir_i2c_ts_data *ts,
 			pos[i].y = touch->y;
 		}
 
-		input_mt_assign_slots(ts->input, slots, pos, n);
+		input_mt_assign_slots(ts->input, slots, pos, n, 0);
 	}
 
 	for (i = 0; i < n; i++) {
diff --git a/include/linux/input/mt.h b/include/linux/input/mt.h
index f583ff6..d7188de 100644
--- a/include/linux/input/mt.h
+++ b/include/linux/input/mt.h
@@ -119,7 +119,8 @@ struct input_mt_pos {
 };
 
 int input_mt_assign_slots(struct input_dev *dev, int *slots,
-			  const struct input_mt_pos *pos, int num_pos);
+			  const struct input_mt_pos *pos, int num_pos,
+			  int dmax);
 
 int input_mt_get_slot_by_key(struct input_dev *dev, int key);
 
-- 
2.2.2
