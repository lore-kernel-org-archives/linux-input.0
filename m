From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 08/14] alps: Use input_mt_assign_slots && input_mt_sync_frame instead of DIY
Date: Wed,  9 Jul 2014 17:24:13 +0200
Message-ID: <1404919459-23561-9-git-send-email-hdegoede@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60925 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932558AbaGIPYi (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:38 -0400
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

When there are 2 fingers on the pad we don't know which one is which, so
use input_mt_assign_slots to make sure the right set of coordinates ends
up in the right slot.

Besides ensuring things end up in the right slot, this also results in a nice
cleanup, since sync_frame also handles non mt position and btn_touch reporting.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 52 ++++++++++++++--------------------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 772e4b0..9bebeb4 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -419,25 +419,26 @@ static int alps_process_bitmap(struct alps_data *priv,
 	return fingers;
 }
 
-static void alps_set_slot(struct input_dev *dev, int slot, bool active,
-			  int x, int y)
+static void alps_set_slot(struct input_dev *dev, int slot, int x, int y)
 {
 	input_mt_slot(dev, slot);
-	input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
-	if (active) {
-		input_report_abs(dev, ABS_MT_POSITION_X, x);
-		input_report_abs(dev, ABS_MT_POSITION_Y, y);
-	}
+	input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
+	input_report_abs(dev, ABS_MT_POSITION_X, x);
+	input_report_abs(dev, ABS_MT_POSITION_Y, y);
 }
 
-static void alps_report_semi_mt_data(struct psmouse *psmouse, int num_fingers)
+static void alps_report_mt_data(struct psmouse *psmouse, int n)
 {
 	struct alps_data *priv = psmouse->private;
 	struct input_dev *dev = psmouse->dev;
 	struct alps_fields *f = &priv->f;
+	int i, slot[MAX_TOUCHES];
+
+	input_mt_assign_slots(dev, slot, f->mt, n);
+	for (i = 0; i < n; i++)
+		alps_set_slot(dev, slot[i], f->mt[i].x, f->mt[i].y);
 
-	alps_set_slot(dev, 0, num_fingers != 0, f->mt[0].x, f->mt[0].y);
-	alps_set_slot(dev, 1, num_fingers == 2, f->mt[1].x, f->mt[1].y);
+	input_mt_sync_frame(dev);
 }
 
 static void alps_process_trackstick_packet_v3(struct psmouse *psmouse)
@@ -674,12 +675,7 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 		fingers = f->pressure > 0 ? 1 : 0;
 	}
 
-	if (f->pressure >= 64)
-		input_report_key(dev, BTN_TOUCH, 1);
-	else
-		input_report_key(dev, BTN_TOUCH, 0);
-
-	alps_report_semi_mt_data(psmouse, fingers);
+	alps_report_mt_data(psmouse, (fingers <= 2) ? fingers : 1);
 
 	input_mt_report_finger_count(dev, fingers);
 
@@ -687,10 +683,6 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 	input_report_key(dev, BTN_RIGHT, f->right);
 	input_report_key(dev, BTN_MIDDLE, f->middle);
 
-	if (f->pressure > 0) {
-		input_report_abs(dev, ABS_X, f->st.x);
-		input_report_abs(dev, ABS_Y, f->st.y);
-	}
 	input_report_abs(dev, ABS_PRESSURE, f->pressure);
 
 	input_sync(dev);
@@ -853,22 +845,13 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
 		fingers = f->fingers;
 	}
 
-	if (f->pressure >= 64)
-		input_report_key(dev, BTN_TOUCH, 1);
-	else
-		input_report_key(dev, BTN_TOUCH, 0);
-
-	alps_report_semi_mt_data(psmouse, fingers);
+	alps_report_mt_data(psmouse, (fingers <= 2) ? fingers : 1);
 
 	input_mt_report_finger_count(dev, fingers);
 
 	input_report_key(dev, BTN_LEFT, f->left);
 	input_report_key(dev, BTN_RIGHT, f->right);
 
-	if (f->pressure > 0) {
-		input_report_abs(dev, ABS_X, f->st.x);
-		input_report_abs(dev, ABS_Y, f->st.y);
-	}
 	input_report_abs(dev, ABS_PRESSURE, f->pressure);
 
 	input_sync(dev);
@@ -2003,17 +1986,14 @@ static void alps_set_abs_params_st(struct alps_data *priv,
 static void alps_set_abs_params_mt(struct alps_data *priv,
 				   struct input_dev *dev1)
 {
-	set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
-	input_mt_init_slots(dev1, 2, 0);
 	input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
 	input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
 
-	set_bit(BTN_TOOL_DOUBLETAP, dev1->keybit);
+	input_mt_init_slots(dev1, MAX_TOUCHES, INPUT_MT_POINTER |
+		INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK | INPUT_MT_SEMI_MT);
+
 	set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
 	set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
-
-	input_set_abs_params(dev1, ABS_X, 0, priv->x_max, 0, 0);
-	input_set_abs_params(dev1, ABS_Y, 0, priv->y_max, 0, 0);
 }
 
 int alps_init(struct psmouse *psmouse)
-- 
2.0.0

