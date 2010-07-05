From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH] HID: magicmouse: report last touch up
Date: Mon,  5 Jul 2010 09:57:52 -0400
Message-ID: <1278338272-5588-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:50176 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab0GEN6D (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jul 2010 09:58:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Michael Poole <mdpoole@troilus.org>, linux-input@vger.kernel.org

The evdev multitouch protocol requires that a last MT sync event must be
sent after all touches are up. This change adds the last MT sync event
to the hid-magicmouse driver.

Also, don't send events when a touch leaves.

Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
---
 drivers/hid/hid-magicmouse.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 0b89c1c..ee78787 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -98,6 +98,7 @@ struct magicmouse_sc {
 		short scroll_x;
 		short scroll_y;
 		u8 size;
+		u8 down;
 	} touches[16];
 	int tracking_ids[16];
 };
@@ -170,6 +171,7 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	int id = (misc >> 6) & 15;
 	int x = x_y << 12 >> 20;
 	int y = -(x_y >> 20);
+	int down = (tdata[7] & TOUCH_STATE_MASK) != TOUCH_STATE_NONE;
 
 	/* Store tracking ID and other fields. */
 	msc->tracking_ids[raw_id] = id;
@@ -221,9 +223,11 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	}
 
 	/* Generate the input events for this touch. */
-	if (report_touches) {
+	if (report_touches && down) {
 		int orientation = (misc >> 10) - 32;
 
+		msc->touches[id].down = 1;
+
 		input_report_abs(input, ABS_MT_TRACKING_ID, id);
 		input_report_abs(input, ABS_MT_TOUCH_MAJOR, tdata[3]);
 		input_report_abs(input, ABS_MT_TOUCH_MINOR, tdata[4]);
@@ -243,7 +247,7 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	struct input_dev *input = msc->input;
-	int x, y, ts, ii, clicks;
+	int x, y, ts, ii, clicks, last_up;
 
 	switch (data[0]) {
 	case 0x10:
@@ -263,6 +267,20 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		msc->ntouches = (size - 6) / 8;
 		for (ii = 0; ii < msc->ntouches; ii++)
 			magicmouse_emit_touch(msc, ii, data + ii * 8 + 6);
+
+		if (report_touches) {
+			last_up = 1;
+			for (ii = 0; ii < ARRAY_SIZE(msc->touches); ii++) {
+				if (msc->touches[ii].down) {
+					last_up = 0;
+					msc->touches[ii].down = 0;
+				}
+			}
+			if (last_up) {
+				input_mt_sync(input);
+			}
+		}
+
 		/* When emulating three-button mode, it is important
 		 * to have the current touch information before
 		 * generating a click event.
-- 
1.7.1

