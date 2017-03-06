From: <hn.chen@weidahitech.com>
Subject: [PATCH] HID: hid-multitouch: change for touch height/width
Date: Mon, 6 Mar 2017 11:30:14 +0800
Message-ID: <1488771014-22856-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, jonathan.a.clarke@gmail.com, benjamin.tissoires@redhat.com, jikos@kernel.org, HungNien Chen <hn.chen@weidahitech.com>
List-Id: linux-input@vger.kernel.org

From: HungNien Chen <hn.chen@weidahitech.com>

Just quote from Jonathan Clarke in previous thread(2017/01/24):
"This division by 2 was added along with the touch width/height
fields 6 years ago so that those fields 'match the visual scale
of the touch' for a specific device (3M PCT)"
"The scaling is also discarding information about touch size
(1 bit for each of width/height) which is useful for any
application that wants to know about it."

Jonathan mentioned just what I thought in a new project recently.
It dosen't make sense to discard 1 bit width/height in general
case according to the spec in multi-touch-protocol.txt so
I would like to make a slight change here.

A quirk MT_QUIRK_TOUCH_SIZE_SCALING was added to service
devices like 3M PCT with a special visual scale and
the division by 2 only take effect with devices like that.

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
