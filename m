From: Matt Whitlock <linux@mattwhitlock.name>
Subject: [PATCH] Input: bcm5974 - report highest finger pressure to Synaptics
Date: Wed,  3 Jun 2015 07:49:25 -0400
Message-ID: <1433332165-25342-1-git-send-email-linux@mattwhitlock.name>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:37660 "EHLO
	resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755443AbbFCLxl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Jun 2015 07:53:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matt Whitlock <linux@mattwhitlock.name>

The Synaptics X.org driver compares the ABS_PRESSURE values in evdev input
events to its FingerLow and FingerHigh parameters to determine how it
should translate touchpad events into X pointer and button events. During a
transition between single-touch and multi-touch, the touchpad on the
MacBookPro6,2 sometimes reports the second finger in the first struct
tp_finger on the wire. If this second finger has a touch_major that (when
normalized) results in an ABS_PRESSURE of less than FingerLow, then the
Synaptics driver gets confused and can generate a spurious event, such as a
tap-and-drag or a secondary button click. This spurious event can manifest
as an undesired GUI operation, such as opening a context menu, selecting
text, or dragging a selection, during a multi-touch scrolling gesture.

This patch changes the report_synaptics_data() function so that it reports
the highest touch_major and highest tool_major of any touching finger as
ABS_PRESSURE and ABS_TOOL_WIDTH, respectively. Formerly this function would
report these values only from the first struct tp_finger and only if its
f->origin were non-zero. This could often lead to spurious reports of
ABS_PRESSURE==0 during multi-touch scrolling, which would also trigger the
aforementioned errant behavior in the Synaptics driver. The new behavior is
for this function to report ABS_PRESSURE==0 only in the case that no finger
has a non-zero f->origin and to report the highest observed ABS_PRESSURE in
the case of one or more fingers having non-zero f->origin.

Signed-off-by: Matt Whitlock <linux@mattwhitlock.name>

---

What follows is sample (abridged) output from evtest and xev when the errant behavior is triggered by beginning a two-finger scrolling gesture (placing the right finger on the touchpad slightly before the left finger), then dragging both fingers down, and then releasing both fingers. No button 1 events should be generated, and yet they are. Of critical importance is the ABS_PRESSURE==0 report at timestamp 1433325385.512505, which is reported even though MT slot 1 still has a finger touching. Producing this behavior is no longer possible after this patch is applied.

Event: time 1433325385.478496, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
Event: time 1433325385.478496, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 517
Event: time 1433325385.478496, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 388
Event: time 1433325385.478496, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 660
Event: time 1433325385.478496, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 1879
Event: time 1433325385.478496, type 3 (EV_ABS), code 51 (ABS_MT_WIDTH_MINOR), value 1697
Event: time 1433325385.478496, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 2414
Event: time 1433325385.478496, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 679
Event: time 1433325385.478496, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
Event: time 1433325385.478496, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 1
Event: time 1433325385.478496, type 3 (EV_ABS), code 0 (ABS_X), value 2414
Event: time 1433325385.478496, type 3 (EV_ABS), code 1 (ABS_Y), value 679
Event: time 1433325385.478496, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 165
Event: time 1433325385.478496, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 7
Event: time 1433325385.478496, -------------- EV_SYN ------------
Event: time 1433325385.512505, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
Event: time 1433325385.512505, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value 518
Event: time 1433325385.512505, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 148
Event: time 1433325385.512505, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 72
Event: time 1433325385.512505, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 2376
Event: time 1433325385.512505, type 3 (EV_ABS), code 52 (ABS_MT_ORIENTATION), value -3214
Event: time 1433325385.512505, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value -511
Event: time 1433325385.512505, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 2994
Event: time 1433325385.512505, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
Event: time 1433325385.512505, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 670
Event: time 1433325385.512505, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 1865
Event: time 1433325385.512505, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 2403
Event: time 1433325385.512505, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 692
Event: time 1433325385.512505, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 0
Event: time 1433325385.512505, type 1 (EV_KEY), code 333 (BTN_TOOL_DOUBLETAP), value 1
Event: time 1433325385.512505, type 3 (EV_ABS), code 0 (ABS_X), value 2403
Event: time 1433325385.512505, type 3 (EV_ABS), code 1 (ABS_Y), value 692
Event: time 1433325385.512505, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 0
Event: time 1433325385.512505, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 0
Event: time 1433325385.512505, -------------- EV_SYN ------------
Event: time 1433325385.520494, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
Event: time 1433325385.520494, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 448
Event: time 1433325385.520494, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 532
Event: time 1433325385.520494, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 2325
Event: time 1433325385.520494, type 3 (EV_ABS), code 52 (ABS_MT_ORIENTATION), value -2410
Event: time 1433325385.520494, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value -531
Event: time 1433325385.520494, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 2978
Event: time 1433325385.520494, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
Event: time 1433325385.520494, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 1853
Event: time 1433325385.520494, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 2398
Event: time 1433325385.520494, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 697
Event: time 1433325385.520494, type 3 (EV_ABS), code 0 (ABS_X), value 2398
Event: time 1433325385.520494, type 3 (EV_ABS), code 1 (ABS_Y), value 697
Event: time 1433325385.520494, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 191
Event: time 1433325385.520494, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 8
Event: time 1433325385.520494, -------------- EV_SYN ------------

ButtonPress event, serial 40, synthetic NO, window 0x1800001,
    root 0x2ef, subw 0x0, time 29415321, (113,82), root:(1493,108),
    state 0x0, button 1, same_screen YES
Event: time 1433325385.592484, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
Event: time 1433325385.592484, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 579
Event: time 1433325385.592484, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 2073
Event: time 1433325385.592484, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value -567
Event: time 1433325385.592484, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3121
Event: time 1433325385.592484, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
Event: time 1433325385.592484, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 2361
Event: time 1433325385.592484, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 886
Event: time 1433325385.592484, type 3 (EV_ABS), code 0 (ABS_X), value 2361
Event: time 1433325385.592484, type 3 (EV_ABS), code 1 (ABS_Y), value 886
Event: time 1433325385.592484, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 206
Event: time 1433325385.592484, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 7
Event: time 1433325385.592484, -------------- EV_SYN ------------
Event: time 1433325385.600506, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
Event: time 1433325385.600506, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 595
Event: time 1433325385.600506, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3143
Event: time 1433325385.600506, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
Event: time 1433325385.600506, type 3 (EV_ABS), code 51 (ABS_MT_WIDTH_MINOR), value 1649
Event: time 1433325385.600506, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 2355
Event: time 1433325385.600506, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 903
Event: time 1433325385.600506, type 3 (EV_ABS), code 0 (ABS_X), value 2355
Event: time 1433325385.600506, type 3 (EV_ABS), code 1 (ABS_Y), value 903
Event: time 1433325385.600506, -------------- EV_SYN ------------
Event: time 1433325385.607434, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
Event: time 1433325385.607434, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 468
Event: time 1433325385.607434, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 608
Event: time 1433325385.607434, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value -571
Event: time 1433325385.607434, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3164
Event: time 1433325385.607434, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
Event: time 1433325385.607434, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 2349
Event: time 1433325385.607434, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 929
Event: time 1433325385.607434, type 3 (EV_ABS), code 0 (ABS_X), value 2349
Event: time 1433325385.607434, type 3 (EV_ABS), code 1 (ABS_Y), value 929
Event: time 1433325385.607434, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 209
Event: time 1433325385.607434, -------------- EV_SYN ------------
Event: time 1433325385.616463, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
Event: time 1433325385.616463, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3184
Event: time 1433325385.616463, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
Event: time 1433325385.616463, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 719
Event: time 1433325385.616463, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 2342
Event: time 1433325385.616463, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 992
Event: time 1433325385.616463, type 3 (EV_ABS), code 0 (ABS_X), value 2342
Event: time 1433325385.616463, type 3 (EV_ABS), code 1 (ABS_Y), value 992
Event: time 1433325385.616463, -------------- EV_SYN ------------

ButtonPress event, serial 40, synthetic NO, window 0x1800001,
    root 0x2ef, subw 0x0, time 29415418, (113,82), root:(1493,108),
    state 0x100, button 5, same_screen YES

ButtonRelease event, serial 40, synthetic NO, window 0x1800001,
    root 0x2ef, subw 0x0, time 29415418, (113,82), root:(1493,108),
    state 0x1100, button 5, same_screen YES
Event: time 1433325385.648483, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
Event: time 1433325385.648483, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3279
Event: time 1433325385.648483, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
Event: time 1433325385.648483, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 296
Event: time 1433325385.648483, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 392
Event: time 1433325385.648483, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 2312
Event: time 1433325385.648483, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 1127
Event: time 1433325385.648483, type 3 (EV_ABS), code 0 (ABS_X), value 2312
Event: time 1433325385.648483, type 3 (EV_ABS), code 1 (ABS_Y), value 1127
Event: time 1433325385.648483, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 205
Event: time 1433325385.648483, -------------- EV_SYN ------------

ButtonPress event, serial 40, synthetic NO, window 0x1800001,
    root 0x2ef, subw 0x0, time 29415449, (113,82), root:(1493,108),
    state 0x100, button 5, same_screen YES

ButtonRelease event, serial 40, synthetic NO, window 0x1800001,
    root 0x2ef, subw 0x0, time 29415449, (113,82), root:(1493,108),
    state 0x1100, button 5, same_screen YES
Event: time 1433325385.656456, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
Event: time 1433325385.656456, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 452
Event: time 1433325385.656456, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 598
Event: time 1433325385.656456, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3301
Event: time 1433325385.656456, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
Event: time 1433325385.656456, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 58
Event: time 1433325385.656456, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 72
Event: time 1433325385.656456, type 3 (EV_ABS), code 50 (ABS_MT_WIDTH_MAJOR), value 1758
Event: time 1433325385.656456, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 2303
Event: time 1433325385.656456, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 1148
Event: time 1433325385.656456, type 3 (EV_ABS), code 0 (ABS_X), value 2303
Event: time 1433325385.656456, type 3 (EV_ABS), code 1 (ABS_Y), value 1148
Event: time 1433325385.656456, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 172
Event: time 1433325385.656456, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 7
Event: time 1433325385.656456, -------------- EV_SYN ------------
Event: time 1433325385.663437, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
Event: time 1433325385.663437, type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 132
Event: time 1433325385.663437, type 3 (EV_ABS), code 49 (ABS_MT_TOUCH_MINOR), value 122
Event: time 1433325385.663437, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 3366
Event: time 1433325385.663437, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 0
Event: time 1433325385.663437, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value -1
Event: time 1433325385.663437, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 1
Event: time 1433325385.663437, type 1 (EV_KEY), code 333 (BTN_TOOL_DOUBLETAP), value 0
Event: time 1433325385.663437, type 3 (EV_ABS), code 0 (ABS_X), value -576
Event: time 1433325385.663437, type 3 (EV_ABS), code 1 (ABS_Y), value 3366
Event: time 1433325385.663437, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 56
Event: time 1433325385.663437, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 8
Event: time 1433325385.663437, -------------- EV_SYN ------------
Event: time 1433325385.671508, type 3 (EV_ABS), code 47 (ABS_MT_SLOT), value 1
Event: time 1433325385.671508, type 3 (EV_ABS), code 57 (ABS_MT_TRACKING_ID), value -1
Event: time 1433325385.671508, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 0
Event: time 1433325385.671508, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 0
Event: time 1433325385.671508, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 0
Event: time 1433325385.671508, type 3 (EV_ABS), code 28 (ABS_TOOL_WIDTH), value 0
Event: time 1433325385.671508, -------------- EV_SYN ------------

ButtonRelease event, serial 40, synthetic NO, window 0x1800001,
    root 0x2ef, subw 0x0, time 29415797, (113,82), root:(1493,108),
    state 0x100, button 1, same_screen YES
---
 drivers/input/mouse/bcm5974.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/input/mouse/bcm5974.c b/drivers/input/mouse/bcm5974.c
index b10709f..95474f4 100644
--- a/drivers/input/mouse/bcm5974.c
+++ b/drivers/input/mouse/bcm5974.c
@@ -526,19 +526,24 @@ static void report_synaptics_data(struct input_dev *input,
 				  const struct bcm5974_config *cfg,
 				  const struct tp_finger *f, int raw_n)
 {
-	int abs_p = 0, abs_w = 0;
+	int i, max_p = 0, max_w = 0;
 
-	if (raw_n) {
-		int p = raw2int(f->touch_major);
-		int w = raw2int(f->tool_major);
-		if (p > 0 && raw2int(f->origin)) {
-			abs_p = clamp_val(256 * p / cfg->p.max, 0, 255);
-			abs_w = clamp_val(16 * w / cfg->w.max, 0, 15);
+	for (i = 0; i < raw_n; ++i) {
+		if (f[i].origin) {
+			int p = raw2int(f[i].touch_major);
+			int w = raw2int(f[i].tool_major);
+
+			if (p > max_p)
+				max_p = p;
+			if (w > max_w)
+				max_w = w;
 		}
 	}
 
-	input_report_abs(input, ABS_PRESSURE, abs_p);
-	input_report_abs(input, ABS_TOOL_WIDTH, abs_w);
+	input_report_abs(input, ABS_PRESSURE,
+			clamp_val(256 * max_p / cfg->p.max, 0, 255));
+	input_report_abs(input, ABS_TOOL_WIDTH,
+			clamp_val(16 * max_w / cfg->w.max, 0, 15));
 }
 
 /* report trackpad data as logical trackpad state */
-- 
2.4.2

