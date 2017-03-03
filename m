From: <hn.chen@weidahitech.com>
Subject: [PATCH] HID: hid-multitouch: change for touch height/width
Date: Fri, 3 Mar 2017 21:06:09 +0800
Message-ID: <1488546369-32580-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, jonathan.a.clarke@gmail.com, benjamin.tissoires@redhat.com, jikos@kernel.org, HungNien Chen <hn.chen@weidahitech.com>
List-Id: linux-input@vger.kernel.org

From: HungNien Chen <hn.chen@weidahitech.com>

This change is from Jonathan Clarke and have been discussed in previous
thread(2017/01/24). Just doing a slight change in quirk name from Benjamin's
comment.

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/hid/hid-multitouch.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 6926474..24d5b6d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -69,6 +69,7 @@
 #define MT_QUIRK_CONTACT_CNT_ACCURATE	(1 << 12)
 #define MT_QUIRK_FORCE_GET_FEATURE	(1 << 13)
 #define MT_QUIRK_FIX_CONST_CONTACT_ID	(1 << 14)
+#define MT_QUIRK_TOUCH_SIZE_SCALING	(1 << 15)
 
 #define MT_INPUTMODE_TOUCHSCREEN	0x02
 #define MT_INPUTMODE_TOUCHPAD		0x03
@@ -222,7 +223,8 @@ static int cypress_compute_slot(struct mt_device *td)
 	 */
 	{ .name = MT_CLS_3M,
 		.quirks = MT_QUIRK_VALID_IS_CONFIDENCE |
-			MT_QUIRK_SLOT_IS_CONTACTID,
+			MT_QUIRK_SLOT_IS_CONTACTID |
+			MT_QUIRK_TOUCH_SIZE_SCALING,
 		.sn_move = 2048,
 		.sn_width = 128,
 		.sn_height = 128,
@@ -658,9 +660,17 @@ static void mt_complete_slot(struct mt_device *td, struct input_dev *input)
 		if (active) {
 			/* this finger is in proximity of the sensor */
 			int wide = (s->w > s->h);
-			/* divided by two to match visual scale of touch */
-			int major = max(s->w, s->h) >> 1;
-			int minor = min(s->w, s->h) >> 1;
+			int major = max(s->w, s->h);
+			int minor = min(s->w, s->h);
+
+			/*
+			 * divided by two to match visual scale of touch
+			 * for devices with this quirk
+			 */
+			if (td->mtclass.quirks & MT_QUIRK_TOUCH_SIZE_SCALING) {
+				major = major >> 1;
+				minor = minor >> 1;
+			}
 
 			input_event(input, EV_ABS, ABS_MT_POSITION_X, s->x);
 			input_event(input, EV_ABS, ABS_MT_POSITION_Y, s->y);
-- 
1.9.1
