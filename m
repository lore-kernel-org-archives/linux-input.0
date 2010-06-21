From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 2/3] HID: magicmouse: add param for scroll speed
Date: Sun, 20 Jun 2010 21:32:30 -0400
Message-ID: <1277083951-29137-3-git-send-email-chase.douglas@canonical.com>
References: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:53190 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231Ab0FUBci (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jun 2010 21:32:38 -0400
In-Reply-To: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Michael Poole <mdpoole@troilus.org>
Cc: linux-input@vger.kernel.org

The new scroll_speed param takes an integer value from 0 to 63, where 0
is slowest and 63 is fastest. The default of 32 remains the same. This
parameter also affects scroll acceleration linearly.

A second part of this change is a tightly coupled modification to the
scroll acceleration. Previously, scroll acceleration could be reset
without lifting the scroll finger. This is rather unintuitive and hard
to control in the case where a user wants faster scrolling, but wants to
hold the scroll touch for longer than a moment.

Note that scroll acceleration levels are now 1-7, where 7 is slowest. In
the previous implementation, there were 8 levels defined, but it was
impossible to start at the slowest level. In order to keep the default
scroll speed unchanged, only 7 levels are used now.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
Acked-by: Michael Poole <mdpoole@troilus.org>
---
 drivers/hid/hid-magicmouse.c |   43 +++++++++++++++++++++++++++--------------
 1 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index f44aaf2..fe0c760 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -30,6 +30,17 @@ static bool emulate_scroll_wheel = true;
 module_param(emulate_scroll_wheel, bool, 0644);
 MODULE_PARM_DESC(emulate_scroll_wheel, "Emulate a scroll wheel");
 
+static unsigned int scroll_speed = 32;
+static int param_set_scroll_speed(const char *val, struct kernel_param *kp) {
+	unsigned long speed;
+	if (!val || strict_strtoul(val, 0, &speed) || speed > 63)
+		return -EINVAL;
+	scroll_speed = speed;
+	return 0;
+}
+module_param_call(scroll_speed, param_set_scroll_speed, param_get_uint, &scroll_speed, 0644);
+MODULE_PARM_DESC(scroll_speed, "Scroll speed, value from 0 (slow) to 63 (fast)");
+
 static bool scroll_acceleration = false;
 module_param(scroll_acceleration, bool, 0644);
 MODULE_PARM_DESC(scroll_acceleration, "Accelerate sequential scroll events");
@@ -54,6 +65,8 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
 #define TOUCH_STATE_START 0x30
 #define TOUCH_STATE_DRAG  0x40
 
+#define SCROLL_ACCEL_DEFAULT 7
+
 /**
  * struct magicmouse_sc - Tracks Magic Mouse-specific data.
  * @input: Input device through which we report events.
@@ -145,7 +158,7 @@ static void magicmouse_emit_buttons(struct magicmouse_sc *msc, int state)
 	input_report_key(msc->input, BTN_RIGHT, state & 2);
 
 	if (state != last_state)
-		msc->scroll_accel = 0;
+		msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
 }
 
 static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tdata)
@@ -167,30 +180,28 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	 * vertical touch motions.
 	 */
 	if (emulate_scroll_wheel) {
-		static const int accel_profile[] = {
-			256, 228, 192, 160, 128, 96, 64, 32,
-		};
 		unsigned long now = jiffies;
 		int step = msc->touches[id].scroll_y - y;
 
-		/* Reset acceleration after half a second. */
-		if (time_after(now, msc->scroll_jiffies + HZ / 2))
-			msc->scroll_accel = 0;
-
 		/* Calculate and apply the scroll motion. */
 		switch (tdata[7] & TOUCH_STATE_MASK) {
 		case TOUCH_STATE_START:
 			msc->touches[id].scroll_y = y;
-			if (scroll_acceleration)
-				msc->scroll_accel = min_t(int,
-						msc->scroll_accel + 1,
-						ARRAY_SIZE(accel_profile) - 1);
+
+			/* Reset acceleration after half a second. */
+			if (scroll_acceleration && time_before(now,
+						msc->scroll_jiffies + HZ / 2))
+				msc->scroll_accel = max_t(int,
+						msc->scroll_accel - 1, 1);
+			else
+				msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
+
 			break;
 		case TOUCH_STATE_DRAG:
-			step = step / accel_profile[msc->scroll_accel];
+			step /= (64 - (int)scroll_speed) * msc->scroll_accel;
 			if (step != 0) {
-				msc->touches[id].scroll_y -=
-					step * accel_profile[msc->scroll_accel];
+				msc->touches[id].scroll_y -= step *
+					(64 - scroll_speed) * msc->scroll_accel;
 				msc->scroll_jiffies = now;
 				input_report_rel(input, REL_WHEEL, step);
 			}
@@ -351,6 +362,8 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return -ENOMEM;
 	}
 
+	msc->scroll_accel = SCROLL_ACCEL_DEFAULT;
+
 	msc->quirks = id->driver_data;
 	hid_set_drvdata(hdev, msc);
 
-- 
1.7.0.4

