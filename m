From: Matt Whitlock <linux@mattwhitlock.name>
Subject: [PATCH 2/2] Input: bcm5974 - report ABS_MT_PRESSURE + remove redundant emulation code
Date: Mon,  8 Jun 2015 21:07:55 -0400
Message-ID: <1433812075-16622-2-git-send-email-linux@mattwhitlock.name>
References: <556EF8AB.6090704@bitmath.org>
 <1433812075-16622-1-git-send-email-linux@mattwhitlock.name>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from resqmta-ch2-04v.sys.comcast.net ([69.252.207.36]:44633 "EHLO
	resqmta-ch2-04v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752154AbbFIBIo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Jun 2015 21:08:44 -0400
In-Reply-To: <1433812075-16622-1-git-send-email-linux@mattwhitlock.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matt Whitlock <linux@mattwhitlock.name>

Now that input_mt_report_pointer_emulation() can synthesize ABS_TOOL_WIDTH
from ABS_MT_WIDTH_MAJOR, the report_synaptics_data() function in bcm5974.c
is entirely redundant. This patch removes this function and introduces
reporting of ABS_MT_PRESSURE (faked from f->touch_major) to cause the
emulation code to synthesize ABS_PRESSURE.

Signed-off-by: Matt Whitlock <linux@mattwhitlock.name>

---

== Test case #1: Single-finger touch ==

Old behavior:

Event: time 1433421663.308600, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 0
Event: time 1433421663.308600, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 316
Event: time 1433421663.308600, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 668
Event: time 1433421663.308600, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 1840
Event: time 1433421663.308600, type 3 (EV_ABS), code 51 (ABS_MT_WIDTH_MINOR), value 1482
Event: time 1433421663.308600, type 3 (EV_ABS), code 52 (ABS_MT_ORIENTATION), value 13588
Event: time 1433421663.308600, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 434
Event: time 1433421663.308600, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3148
Event: time 1433421663.308600, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
Event: time 1433421663.308600, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 1
Event: time 1433421663.308600, type 3 (EV_ABS), code 0 (ABS_X), value 434
Event: time 1433421663.308600, type 3 (EV_ABS), code 1 (ABS_Y), value 3148
Event: time 1433421663.308600, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 134
Event: time 1433421663.308600, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 7
Event: time 1433421663.308600, -------------- EV_SYN ------------

New behavior:

Event: time 1433421077.994753, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 0
Event: time 1433421077.994753, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 224
Event: time 1433421077.994753, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 466
Event: time 1433421077.994753, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 1616
Event: time 1433421077.994753, type 3 (EV_ABS), code 51 (ABS_MT_WIDTH_MINOR), value 1464
Event: time 1433421077.994753, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 501
Event: time 1433421077.994753, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3288
Event: time 1433421077.994753, type 3 (EV_ABS), code 58 (ABS_MT_PRESSURE), value 112
Event: time 1433421077.994753, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
Event: time 1433421077.994753, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 1
Event: time 1433421077.994753, type 3 (EV_ABS), code 0 (ABS_X), value 501
Event: time 1433421077.994753, type 3 (EV_ABS), code 1 (ABS_Y), value 3288
Event: time 1433421077.994753, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 95
Event: time 1433421077.994753, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 11
Event: time 1433421077.994753, -------------- EV_SYN ------------

== Test case #2: Two-finger touch ==

Old behavior:

Event: time 1433421678.186983, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 1
Event: time 1433421678.186983, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 384
Event: time 1433421678.186983, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 648
Event: time 1433421678.186983, type 3 (EV_ABS), code 51 (ABS_MT_WIDTH_MINOR), value 1672
Event: time 1433421678.186983, type 3 (EV_ABS), code 52 (ABS_MT_ORIENTATION), value 0
Event: time 1433421678.186983, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value -1810
Event: time 1433421678.186983, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3298
Event: time 1433421678.186983, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
Event: time 1433421678.186983, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 2
Event: time 1433421678.186983, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 404
Event: time 1433421678.186983, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 616
Event: time 1433421678.186983, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 1950
Event: time 1433421678.186983, type 3 (EV_ABS), code 51 (ABS_MT_WIDTH_MINOR), value 1488
Event: time 1433421678.186983, type 3 (EV_ABS), code 52 (ABS_MT_ORIENTATION), value 16009
Event: time 1433421678.186983, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 2076
Event: time 1433421678.186983, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3384
Event: time 1433421678.186983, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
Event: time 1433421678.186983, type 1 (EV_KEY), code 333 (BTN_TOOL_DOUBLETAP), value 1
Event: time 1433421678.186983, type 3 (EV_ABS), code 0 (ABS_X), value -1810
Event: time 1433421678.186983, type 3 (EV_ABS), code 1 (ABS_Y), value 3298
Event: time 1433421678.186983, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 163
Event: time 1433421678.186983, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 7
Event: time 1433421678.186983, -------------- EV_SYN ------------

New behavior:

Event: time 1433421166.097247, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 1
Event: time 1433421166.097247, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 285
Event: time 1433421166.097247, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 483
Event: time 1433421166.097247, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 1840
Event: time 1433421166.097247, type 3 (EV_ABS), code 51 (ABS_MT_WIDTH_MINOR), value 1696
Event: time 1433421166.097247, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value -1718
Event: time 1433421166.097247, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3518
Event: time 1433421166.097247, type 3 (EV_ABS), code 58 (ABS_MT_PRESSURE), value 180
Event: time 1433421166.097247, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
Event: time 1433421166.097247, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 2
Event: time 1433421166.097247, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 364
Event: time 1433421166.097247, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 554
Event: time 1433421166.097247, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 1794
Event: time 1433421166.097247, type 3 (EV_ABS), code 51 (ABS_MT_WIDTH_MINOR), value 1738
Event: time 1433421166.097247, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 2501
Event: time 1433421166.097247, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3276
Event: time 1433421166.097247, type 3 (EV_ABS), code 58 (ABS_MT_PRESSURE), value 182
Event: time 1433421166.097247, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
Event: time 1433421166.097247, type 1 (EV_KEY), code 333 (BTN_TOOL_DOUBLETAP), value 1
Event: time 1433421166.097247, type 3 (EV_ABS), code 0 (ABS_X), value -1718
Event: time 1433421166.097247, type 3 (EV_ABS), code 1 (ABS_Y), value 3518
Event: time 1433421166.097247, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 153
Event: time 1433421166.097247, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 13
Event: time 1433421166.097247, -------------- EV_SYN ------------

== Test case #3: Side-of-thumb touch ==

Old behavior:

Event: time 1433421696.969475, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
Event: time 1433421696.969475, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 3
Event: time 1433421696.969475, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 952
Event: time 1433421696.969475, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 642
Event: time 1433421696.969475, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 3810
Event: time 1433421696.969475, type 3 (EV_ABS), code 52 (ABS_MT_ORIENTATION), value -14967
Event: time 1433421696.969475, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 678
Event: time 1433421696.969475, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3379
Event: time 1433421696.969475, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
Event: time 1433421696.969475, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 1
Event: time 1433421696.969475, type 3 (EV_ABS), code 0 (ABS_X), value 678
Event: time 1433421696.969475, type 3 (EV_ABS), code 1 (ABS_Y), value 3379
Event: time 1433421696.969475, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 255
Event: time 1433421696.969475, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 14
Event: time 1433421696.969475, -------------- EV_SYN ------------

New behavior:

Event: time 1433421224.271508, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 3
Event: time 1433421224.271508, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 1020
Event: time 1433421224.271508, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 606
Event: time 1433421224.271508, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 3828
Event: time 1433421224.271508, type 3 (EV_ABS), code 51 (ABS_MT_WIDTH_MINOR), value 1828
Event: time 1433421224.271508, type 3 (EV_ABS), code 52 (ABS_MT_ORIENTATION), value -16206
Event: time 1433421224.271508, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 193
Event: time 1433421224.271508, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3119
Event: time 1433421224.271508, type 3 (EV_ABS), code 58 (ABS_MT_PRESSURE), value 300
Event: time 1433421224.271508, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
Event: time 1433421224.271508, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 1
Event: time 1433421224.271508, type 3 (EV_ABS), code 0 (ABS_X), value 193
Event: time 1433421224.271508, type 3 (EV_ABS), code 1 (ABS_Y), value 3119
Event: time 1433421224.271508, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 255
Event: time 1433421224.271508, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 28
Event: time 1433421224.271508, -------------- EV_SYN ------------
---
 drivers/input/mouse/bcm5974.c | 41 ++++++++++++++---------------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index b10709f..7e5df76 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -458,10 +458,6 @@ static void setup_events_to_report(struct input_dev *input_dev,
 {
 	__set_bit(EV_ABS, input_dev->evbit);
 
-	/* for synaptics only */
-	input_set_abs_params(input_dev, ABS_PRESSURE, 0, 256, 5, 0);
-	input_set_abs_params(input_dev, ABS_TOOL_WIDTH, 0, 16, 0, 0);
-
 	/* finger touch area */
 	set_abs(input_dev, ABS_MT_TOUCH_MAJOR, &cfg->w);
 	set_abs(input_dev, ABS_MT_TOUCH_MINOR, &cfg->w);
@@ -473,6 +469,8 @@ static void setup_events_to_report(struct input_dev *input_dev,
 	/* finger position */
 	set_abs(input_dev, ABS_MT_POSITION_X, &cfg->x);
 	set_abs(input_dev, ABS_MT_POSITION_Y, &cfg->y);
+	/* finger pressure (synthesized from touch area) */
+	set_abs(input_dev, ABS_MT_PRESSURE, &cfg->p);
 
 	__set_bit(EV_KEY, input_dev->evbit);
 	__set_bit(BTN_LEFT, input_dev->keybit);
@@ -482,6 +480,10 @@ static void setup_events_to_report(struct input_dev *input_dev,
 
 	input_mt_init_slots(input_dev, MAX_FINGERS,
 		INPUT_MT_POINTER | INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK);
+
+	/* override axis ranges for synaptics */
+	input_set_abs_params(input_dev, ABS_PRESSURE, 0, 256, 5, 0);
+	input_set_abs_params(input_dev, ABS_TOOL_WIDTH, 0, 16, 0, 0);
 }
 
 /* report button data as logical button state */
@@ -501,10 +503,13 @@ static int report_bt_state(struct bcm5974 *dev, int size)
 	return 0;
 }
 
-static void report_finger_data(struct input_dev *input, int slot,
+static void report_finger_data(struct bcm5974 *dev, int slot,
 			       const struct input_mt_pos *pos,
 			       const struct tp_finger *f)
 {
+	struct input_dev *input = dev->input;
+	const struct bcm5974_config *cfg = &dev->cfg;
+
 	input_mt_slot(input, slot);
 	input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
 
@@ -520,25 +525,9 @@ static void report_finger_data(struct input_dev *input, int slot,
 			 MAX_FINGER_ORIENTATION - raw2int(f->orientation));
 	input_report_abs(input, ABS_MT_POSITION_X, pos->x);
 	input_report_abs(input, ABS_MT_POSITION_Y, pos->y);
-}
-
-static void report_synaptics_data(struct input_dev *input,
-				  const struct bcm5974_config *cfg,
-				  const struct tp_finger *f, int raw_n)
-{
-	int abs_p = 0, abs_w = 0;
-
-	if (raw_n) {
-		int p = raw2int(f->touch_major);
-		int w = raw2int(f->tool_major);
-		if (p > 0 && raw2int(f->origin)) {
-			abs_p = clamp_val(256 * p / cfg->p.max, 0, 255);
-			abs_w = clamp_val(16 * w / cfg->w.max, 0, 15);
-		}
-	}
-
-	input_report_abs(input, ABS_PRESSURE, abs_p);
-	input_report_abs(input, ABS_TOOL_WIDTH, abs_w);
+	/* clamp to avoid two-finger emulation in synaptics driver */
+	input_report_abs(input, ABS_MT_PRESSURE,
+			 clamp_val(raw2int(f->touch_major), cfg->p.min, cfg->p.max));
 }
 
 /* report trackpad data as logical trackpad state */
@@ -567,13 +556,11 @@ static int report_tp_state(struct bcm5974 *dev, int size)
 	input_mt_assign_slots(input, dev->slots, dev->pos, n, 0);
 
 	for (i = 0; i < n; i++)
-		report_finger_data(input, dev->slots[i],
+		report_finger_data(dev, dev->slots[i],
 				   &dev->pos[i], dev->index[i]);
 
 	input_mt_sync_frame(input);
 
-	report_synaptics_data(input, c, f, raw_n);
-
 	/* type 2 reports button events via ibt only */
 	if (c->tp_type == TYPE2) {
 		int ibt = raw2int(dev->tp_data[BUTTON_TYPE2]);
-- 
2.4.2

