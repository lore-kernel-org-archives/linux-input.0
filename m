From: Michael Poole <mdpoole@troilus.org>
Subject: [PATCH 1/1] hid-magicmouse: Emulate horizontal scrolling.
Date: Mon, 08 Mar 2010 19:58:42 -0500
Message-ID: <871vfu2tvh.fsf@troilus.org>
References: <8763562u0n.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:34106 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756302Ab0CIA6r (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 8 Mar 2010 19:58:47 -0500
Received: by mail-qy0-f177.google.com with SMTP id 7so4726876qyk.21
        for <linux-input@vger.kernel.org>; Mon, 08 Mar 2010 16:58:45 -0800 (PST)
In-Reply-To: <8763562u0n.fsf@troilus.org> (Michael Poole's message of "Mon, 08
	Mar 2010 19:55:36 -0500")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <tissoire@tls.cena.fr>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephane Chatty <chatty@enac.fr>

>From 92872d16dfc6f2c037124644f30f807d30b6557c Mon Sep 17 00:00:00 2001
From: Michael Poole <mdpoole@troilus.org>
Date: Mon, 8 Mar 2010 19:10:13 -0500
Subject: [PATCH 1/1] hid-magicmouse: Emulate horizontal scrolling.

Also publish a parameter to control the emulated scroll
acceleration rates.

Signed-off-by: Michael Poole <mdpoole@troilus.org>
---
 drivers/hid/hid-magicmouse.c |   96 ++++++++++++++++++++++++++++++------------
 1 files changed, 69 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 2e7d701..31e6c2f 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -37,6 +37,14 @@ static bool report_undeciphered;
 module_param(report_undeciphered, bool, 0644);
 MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state field using a MSC_RAW event");
 
+static int scroll_accel_profile[8] = {
+	192, 160, 128, 96, 64, 48, 32, 24
+};
+static unsigned int num_scroll_accel_profile;
+module_param_array(scroll_accel_profile, int, &num_scroll_accel_profile, 0644);
+MODULE_PARM_DESC(scroll_accel_profile, "Acceleration profile for successive "
+		"simulated scroll events");
+
 #define TOUCH_REPORT_ID   0x29
 /* These definitions are not precise, but they're close enough.  (Bits
  * 0x03 seem to indicate the aspect ratio of the touch, bits 0x70 seem
@@ -59,7 +67,8 @@ MODULE_PARM_DESC(report_undeciphered, "Report undeciphered multi-touch state fie
  * @delta_time: 18-bit difference between the two most recent touch
  *     reports from the mouse.
  * @ntouches: Number of touches in most recent touch report.
- * @scroll_accel: Number of consecutive scroll motions.
+ * @scroll_accel_x: Number of consecutive left-right scroll motions.
+ * @scroll_accel_y: Number of consecutive up-down scroll motions.
  * @scroll_jiffies: Time of last scroll motion.
  * @touches: Most recent data for a touch, indexed by tracking ID.
  * @tracking_ids: Mapping of current touch input data to @touches.
@@ -71,12 +80,14 @@ struct magicmouse_sc {
 	int last_timestamp;
 	int delta_time;
 	int ntouches;
-	int scroll_accel;
+	int scroll_accel_x;
+	int scroll_accel_y;
 	unsigned long scroll_jiffies;
 
 	struct {
 		short x;
 		short y;
+		short scroll_x;
 		short scroll_y;
 		u8 size;
 	} touches[16];
@@ -139,8 +150,32 @@ static void magicmouse_emit_buttons(struct magicmouse_sc *msc, int state)
 	input_report_key(msc->input, BTN_LEFT, state & 1);
 	input_report_key(msc->input, BTN_RIGHT, state & 2);
 
-	if (state != last_state)
-		msc->scroll_accel = 0;
+	if (state != last_state) {
+		msc->scroll_accel_x = 0;
+		msc->scroll_accel_y = 0;
+	}
+}
+
+static inline int magicmouse_scroll(int *scroll_accel, short *base_pos,
+		short curr_pos, u8 touch_state)
+{
+	int step = 0;
+
+	switch (touch_state) {
+	case TOUCH_STATE_START:
+		*base_pos = curr_pos;
+		*scroll_accel = min_t(int, *scroll_accel + 1,
+			num_scroll_accel_profile - 1);
+		break;
+	case TOUCH_STATE_DRAG:
+		step = (curr_pos - *base_pos) /
+			scroll_accel_profile[*scroll_accel];
+		if (step)
+			*base_pos = curr_pos;
+		break;
+	}
+
+	return step;
 }
 
 static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tdata)
@@ -163,31 +198,30 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	 */
 	if (emulate_scroll_wheel &&
 	    middle_button_start < x && x < middle_button_stop) {
-		static const int accel_profile[] = {
-			256, 228, 192, 160, 128, 96, 64, 32,
-		};
 		unsigned long now = jiffies;
-		int step = msc->touches[id].scroll_y - y;
+		int step;
 
 		/* Reset acceleration after half a second. */
-		if (time_after(now, msc->scroll_jiffies + HZ / 2))
-			msc->scroll_accel = 0;
-
-		/* Calculate and apply the scroll motion. */
-		switch (tdata[7] & TOUCH_STATE_MASK) {
-		case TOUCH_STATE_START:
-			msc->touches[id].scroll_y = y;
-			msc->scroll_accel = min_t(int, msc->scroll_accel + 1,
-						ARRAY_SIZE(accel_profile) - 1);
-			break;
-		case TOUCH_STATE_DRAG:
-			step = step / accel_profile[msc->scroll_accel];
-			if (step != 0) {
-				msc->touches[id].scroll_y = y;
-				msc->scroll_jiffies = now;
-				input_report_rel(input, REL_WHEEL, step);
-			}
-			break;
+		if (time_after(now, msc->scroll_jiffies + HZ / 2)) {
+			msc->scroll_accel_x = 0;
+			msc->scroll_accel_y = 0;
+		}
+
+		/* Calculate and apply the scroll motions. */
+		step = magicmouse_scroll(&msc->scroll_accel_x,
+			&msc->touches[id].scroll_x, x,
+			tdata[7] & TOUCH_STATE_MASK);
+		if (step) {
+			msc->scroll_jiffies = now;
+			input_report_rel(input, REL_HWHEEL, step);
+		}
+
+		step = magicmouse_scroll(&msc->scroll_accel_y,
+			&msc->touches[id].scroll_y, -y,
+			tdata[7] & TOUCH_STATE_MASK);
+		if (step) {
+			msc->scroll_jiffies = now;
+			input_report_rel(input, REL_WHEEL, step);
 		}
 	}
 
@@ -300,8 +334,10 @@ static void magicmouse_setup_input(struct input_dev *input, struct hid_device *h
 	__set_bit(EV_REL, input->evbit);
 	__set_bit(REL_X, input->relbit);
 	__set_bit(REL_Y, input->relbit);
-	if (emulate_scroll_wheel)
+	if (emulate_scroll_wheel) {
+		__set_bit(REL_HWHEEL, input->relbit);
 		__set_bit(REL_WHEEL, input->relbit);
+	}
 
 	if (report_touches) {
 		__set_bit(EV_ABS, input->evbit);
@@ -434,6 +470,12 @@ static struct hid_driver magicmouse_driver = {
 static int __init magicmouse_init(void)
 {
 	int ret;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(scroll_accel_profile); i++)
+		if (scroll_accel_profile[i] == 0)
+			break;
+	num_scroll_accel_profile = i;
 
 	ret = hid_register_driver(&magicmouse_driver);
 	if (ret)
-- 
1.7.0.2

