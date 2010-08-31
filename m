From: Chase Douglas <chase.douglas@canonical.com>
Subject: [PATCH 6/6 v2] HID: magicmouse: Adjust major / minor axes to scale
Date: Tue, 31 Aug 2010 14:41:08 -0400
Message-ID: <1283280068-12285-6-git-send-email-chase.douglas@canonical.com>
References: <1283280068-12285-1-git-send-email-chase.douglas@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1283280068-12285-1-git-send-email-chase.douglas@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Michael Poole <mdpoole@troilus.org>, Henrik Rydberg <rydberg@euromail.se>, Tejun Heo <tj@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Henrik Rydberg <rydberg@euromail.se>

By visual inspection, the reported touch_major and touch_minor axes
are roughly a factor of four too small. The factor is approximate,
since the protocol is not known and the HID report encodes touch size
with fewer bits than positions. This patch scales the reported values
by a factor of four.

Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
Acked-by: Michael Poole <mdpoole@troilus.org>
---
 drivers/hid/hid-magicmouse.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 364556a..898d0b8 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -253,8 +253,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	/* Generate the input events for this touch. */
 	if (report_touches && down) {
 		input_report_abs(input, ABS_MT_TRACKING_ID, id);
-		input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major);
-		input_report_abs(input, ABS_MT_TOUCH_MINOR, touch_minor);
+		input_report_abs(input, ABS_MT_TOUCH_MAJOR, touch_major << 2);
+		input_report_abs(input, ABS_MT_TOUCH_MINOR, touch_minor << 2);
 		input_report_abs(input, ABS_MT_ORIENTATION, orientation);
 		input_report_abs(input, ABS_MT_POSITION_X, x);
 		input_report_abs(input, ABS_MT_POSITION_Y, y);
-- 
1.7.1
