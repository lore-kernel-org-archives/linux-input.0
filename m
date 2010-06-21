From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 3/3] HID: magicmouse: enable horizontal scrolling
Date: Sun, 20 Jun 2010 21:32:31 -0400
Message-ID: <1277083951-29137-4-git-send-email-chase.douglas@canonical.com>
References: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:53220 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757231Ab0FUBck (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 20 Jun 2010 21:32:40 -0400
In-Reply-To: <1277083951-29137-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Michael Poole <mdpoole@troilus.org>
Cc: linux-input@vger.kernel.org

Mimicks OS X behavior.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 drivers/hid/hid-magicmouse.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index fe0c760..0b89c1c 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -95,6 +95,7 @@ struct magicmouse_sc {
 	struct {
 		short x;
 		short y;
+		short scroll_x;
 		short scroll_y;
 		u8 size;
 	} touches[16];
@@ -181,11 +182,13 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	 */
 	if (emulate_scroll_wheel) {
 		unsigned long now = jiffies;
-		int step = msc->touches[id].scroll_y - y;
+		int step_x = msc->touches[id].scroll_x - x;
+		int step_y = msc->touches[id].scroll_y - y;
 
 		/* Calculate and apply the scroll motion. */
 		switch (tdata[7] & TOUCH_STATE_MASK) {
 		case TOUCH_STATE_START:
+			msc->touches[id].scroll_x = x;
 			msc->touches[id].scroll_y = y;
 
 			/* Reset acceleration after half a second. */
@@ -198,12 +201,20 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 
 			break;
 		case TOUCH_STATE_DRAG:
-			step /= (64 - (int)scroll_speed) * msc->scroll_accel;
-			if (step != 0) {
-				msc->touches[id].scroll_y -= step *
+			step_x /= (64 - (int)scroll_speed) * msc->scroll_accel;
+			if (step_x != 0) {
+				msc->touches[id].scroll_x -= step_x *
 					(64 - scroll_speed) * msc->scroll_accel;
 				msc->scroll_jiffies = now;
-				input_report_rel(input, REL_WHEEL, step);
+				input_report_rel(input, REL_HWHEEL, -step_x);
+			}
+
+			step_y /= (64 - (int)scroll_speed) * msc->scroll_accel;
+			if (step_y != 0) {
+				msc->touches[id].scroll_y -= step_y *
+					(64 - scroll_speed) * msc->scroll_accel;
+				msc->scroll_jiffies = now;
+				input_report_rel(input, REL_WHEEL, step_y);
 			}
 			break;
 		}
@@ -318,8 +329,10 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
 	__set_bit(EV_REL, input->evbit);
 	__set_bit(REL_X, input->relbit);
 	__set_bit(REL_Y, input->relbit);
-	if (emulate_scroll_wheel)
+	if (emulate_scroll_wheel) {
 		__set_bit(REL_WHEEL, input->relbit);
+		__set_bit(REL_HWHEEL, input->relbit);
+	}
 
 	if (report_touches) {
 		__set_bit(EV_ABS, input->evbit);
-- 
1.7.0.4

