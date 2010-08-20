From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 3/3] input: add multitouch slot support to w8001.
Date: Fri, 20 Aug 2010 14:55:35 +1000
Message-ID: <1282280135-15942-4-git-send-email-peter.hutterer@who-t.net>
References: <1282280135-15942-1-git-send-email-peter.hutterer@who-t.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:20585 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab0HTEzJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Aug 2010 00:55:09 -0400
In-Reply-To: <1282280135-15942-1-git-send-email-peter.hutterer@who-t.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, pinglinux@gmail.com, rydberg@euromail.se
Cc: Peter Hutterer <peter.hutterer@who-t.net>

Some serial wacom devices support two-finger touch. Test for this during
init and parse the touch packets accordingly. Touch packets are
processed using Protocol B (MT Slots).

Note: there are several wacom versions that do touch but not two-finger
touch. These are not catered for here, touch events for these are simply
discarded.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
CC: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/input/touchscreen/wacom_w8001.c |   99 ++++++++++++++++++++++++++++++-
 1 files changed, 96 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index c302cc3..a38a3aa 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -60,6 +60,17 @@ struct w8001_coord {
 	u8 tilt_y;
 };
 
+/* touch data packet */
+struct w8001_touch {
+	u8 f1_status;
+	u16 f1_x;
+	u16 f1_y;
+	/* only some tablets have 2FG info */
+	u8 f2_status;
+	u16 f2_x;
+	u16 f2_y;
+};
+
 /* touch query reply packet */
 struct w8001_touch_query {
 	u8 panel_res;
@@ -85,8 +96,18 @@ struct w8001 {
 	char phys[32];
 	int type;
 	unsigned int pktlen;
+	unsigned char tracking_id[2];
 };
 
+static int get_next_tracking_id(void)
+{
+	static unsigned char next_tracking_id;
+	next_tracking_id = (next_tracking_id + 1) % 256;
+	if (next_tracking_id == 0)
+		next_tracking_id = 1;
+	return next_tracking_id;
+}
+
 static void parse_data(u8 *data, struct w8001_coord *coord)
 {
 	memset(coord, 0, sizeof(*coord));
@@ -111,6 +132,26 @@ static void parse_data(u8 *data, struct w8001_coord *coord)
 	coord->tilt_y = data[8] & 0x7F;
 }
 
+static void parse_touch(u8 *data,
+			unsigned int pktlen, struct w8001_touch *touch)
+{
+	memset(touch, 0, sizeof(*touch));
+
+	touch->f1_status = data[0] & 0x1;
+	touch->f1_x = data[1] << 7;
+	touch->f1_x |= data[2];
+	touch->f1_y = data[3] << 7;
+	touch->f1_y |= data[4];
+
+	if (pktlen >= W8001_PKTLEN_TOUCH2FG) {
+		touch->f2_status = (data[0] & 0x2) >> 1;
+		touch->f2_x = data[7] << 7;
+		touch->f2_x |= data[8];
+		touch->f2_y = data[9] << 7;
+		touch->f2_y |= data[10];
+	}
+}
+
 static void parse_touchquery(u8 *data, struct w8001_touch_query *query)
 {
 	memset(query, 0, sizeof(*query));
@@ -128,6 +169,46 @@ static void parse_touchquery(u8 *data, struct w8001_touch_query *query)
 	query->y |= (data[2] >> 3) & 0x3;
 }
 
+static void w8001_mt_event(struct input_dev *dev,
+			   int slot, int tid, int x, int y)
+{
+	input_mt_slot(dev, slot);
+	if (tid != 0) {
+		input_report_abs(dev, ABS_MT_POSITION_X, x);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y);
+	}
+	input_report_abs(dev, ABS_MT_TRACKING_ID, tid);
+	input_report_abs(dev, ABS_MT_TOOL_TYPE, MT_TOOL_FINGER);
+	input_mt_sync(dev);
+}
+
+static void w8001_track_fingers(struct w8001 *w8001, struct w8001_touch *touch)
+{
+	struct input_dev *dev = w8001->dev;
+
+	if (touch->f1_status) {
+		if (!w8001->tracking_id[0])
+			w8001->tracking_id[0] = get_next_tracking_id();
+		w8001_mt_event(dev, 0, w8001->tracking_id[0],
+			       touch->f1_x, touch->f1_y);
+	} else if (w8001->tracking_id[0]) {
+		w8001->tracking_id[0] = 0;
+		w8001_mt_event(dev, 0, 0, touch->f1_x, touch->f1_y);
+	}
+
+	if (touch->f2_status) {
+		if (!w8001->tracking_id[1])
+			w8001->tracking_id[1] = get_next_tracking_id();
+		w8001_mt_event(dev, 1, w8001->tracking_id[1],
+			       touch->f2_x, touch->f2_y);
+	} else if (w8001->tracking_id[1]) {
+		w8001->tracking_id[1] = 0;
+		w8001_mt_event(dev, 1, 0, touch->f2_x, touch->f2_y);
+	}
+
+	input_sync(dev);
+}
+
 static void report_pen_events(struct w8001 *w8001, struct w8001_coord *coord)
 {
 	struct input_dev *dev = w8001->dev;
@@ -172,6 +253,7 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 {
 	struct w8001 *w8001 = serio_get_drvdata(serio);
 	struct w8001_coord coord;
+	struct w8001_touch touch;
 	unsigned char tmp;
 
 	w8001->data[w8001->idx] = data;
@@ -217,10 +299,11 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 		complete(&w8001->cmd_done);
 		break;
 
+	/* 2 finger touch packet */
 	case W8001_PKTLEN_TOUCH2FG - 1:
-		/* ignore two-finger touch packet. */
-		if (w8001->pktlen == w8001->idx)
-			w8001->idx = 0;
+		w8001->idx = 0;
+		parse_touch(w8001->data, w8001->pktlen, &touch);
+		w8001_track_fingers(w8001, &touch);
 		break;
 	}
 
@@ -282,6 +365,16 @@ static int w8001_setup(struct w8001 *w8001)
 			break;
 		case 5:
 			w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
+
+			input_mt_create_slots(dev, 2);
+			input_set_abs_params(dev, ABS_MT_TRACKING_ID,
+						0, 255, 0, 0);
+			input_set_abs_params(dev, ABS_MT_POSITION_X,
+						0, touch.x, 0, 0);
+			input_set_abs_params(dev, ABS_MT_POSITION_Y,
+						0, touch.y, 0, 0);
+			input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
+						0, 0, 0, 0);
 			break;
 		}
 	}
-- 
1.7.2.1

