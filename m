From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH] Alps source code update
Date: Fri, 24 Oct 2014 06:21:23 +0800
Message-ID: <1414102883-11084-1-git-send-email-masaki.ota@jp.alps.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34875 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbaJWWVg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2014 18:21:36 -0400
Received: by mail-pa0-f44.google.com with SMTP id et14so1909696pad.17
        for <linux-input@vger.kernel.org>; Thu, 23 Oct 2014 15:21:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, cernekee@gmail.com, dturvene@dahetral.com
Cc: linux-input@vger.kernel.org, ndevos@redhat.com, jclift@redhat.com, 012nexus@gmail.com, Masaki Ota <masaki.ota@jp.alps.com>

Signed-off-by: Masaki Ota <masaki.ota@jp.alps.com>
- Support Alps Button-less Touchpad device(Rushmore and SS4). New device type and a data decode logic were added.
---
 drivers/input/mouse/alps.c | 1680 +++++++++++++++++++++++++++++++++++---------
 drivers/input/mouse/alps.h |  263 ++++++-
 2 files changed, 1574 insertions(+), 369 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index a59a1a6..d4fc568 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -20,6 +20,7 @@
 #include <linux/input/mt.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
+#include <linux/kernel.h>
 
 #include "psmouse.h"
 #include "alps.h"
@@ -32,6 +33,8 @@
 #define ALPS_REG_BASE_RUSHMORE	0xc2c0
 #define ALPS_REG_BASE_PINNACLE	0x0000
 
+#define V7_LARGE_MOVEMENT		130
+
 static const struct alps_nibble_commands alps_v3_nibble_commands[] = {
 	{ PSMOUSE_CMD_SETPOLL,		0x00 }, /* 0 */
 	{ PSMOUSE_CMD_RESET_DIS,	0x00 }, /* 1 */
@@ -99,8 +102,10 @@ static const struct alps_nibble_commands alps_v6_nibble_commands[] = {
 #define ALPS_FOUR_BUTTONS	0x40	/* 4 direction button present */
 #define ALPS_PS2_INTERLEAVED	0x80	/* 3-byte PS/2 packet interleaved with
 					   6-byte ALPS packet */
-#define ALPS_IS_RUSHMORE	0x100	/* device is a rushmore */
-#define ALPS_BUTTONPAD		0x200	/* device is a clickpad */
+#define ALPS_BTNLESS			0x100	/* ALPS ClickPad flag */
+
+#define	DOL_IS_APDATA(_BY)			((_BY[0]&0x01) == 0x01)
+#define	DOL_IS_PROFDATA(_BY)		((_BY[0]&0x20) == 0x20)
 
 static const struct alps_model_info alps_model_data[] = {
 	{ { 0x32, 0x02, 0x14 },	0x00, ALPS_PROTO_V2, 0xf8, 0xf8, ALPS_PASS | ALPS_DUALPOINT },	/* Toshiba Salellite Pro M10 */
@@ -142,6 +147,20 @@ static void alps_set_abs_params_mt(struct alps_data *priv,
  * isn't valid per PS/2 spec.
  */
 
+static unsigned int alps_pt_distance(struct alps_abs_data *pt0,
+				    struct alps_abs_data *pt1)
+{
+	int vect_x, vect_y;
+
+	if (!pt0 || !pt1)
+		return 0;
+
+	vect_x = pt0->x - pt1->x;
+	vect_y = pt0->y - pt1->y;
+
+	return int_sqrt(vect_x * vect_x + vect_y * vect_y);
+}
+
 /* Packet formats are described in Documentation/input/alps.txt */
 
 static bool alps_is_valid_first_byte(struct alps_data *priv,
@@ -283,10 +302,11 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
  *
  * The bitmaps don't have enough data to track fingers, so this function
  * only generates points representing a bounding box of at most two contacts.
- * These two points are returned in fields->mt.
+ * These two points are returned in x1, y1, x2, and y2.
  */
 static void alps_process_bitmap_dolphin(struct alps_data *priv,
-					struct alps_fields *fields)
+					struct alps_fields *fields,
+					int *x1, int *y1, int *x2, int *y2)
 {
 	int box_middle_x, box_middle_y;
 	unsigned int x_map, y_map;
@@ -309,6 +329,8 @@ static void alps_process_bitmap_dolphin(struct alps_data *priv,
 	if (x_msb > priv->x_bits || y_msb > priv->y_bits)
 		return;
 
+	*x1 = *y1 = *x2 = *y2 = 0;
+
 	if (fields->fingers > 1) {
 		start_bit = priv->x_bits - x_msb;
 		end_bit = priv->x_bits - x_lsb;
@@ -319,35 +341,10 @@ static void alps_process_bitmap_dolphin(struct alps_data *priv,
 		end_bit = y_msb - 1;
 		box_middle_y = (priv->y_max * (start_bit + end_bit)) /
 				(2 * (priv->y_bits - 1));
-		fields->mt[0] = fields->st;
-		fields->mt[1].x = 2 * box_middle_x - fields->mt[0].x;
-		fields->mt[1].y = 2 * box_middle_y - fields->mt[0].y;
-	}
-}
-
-static void alps_get_bitmap_points(unsigned int map,
-				   struct alps_bitmap_point *low,
-				   struct alps_bitmap_point *high,
-				   int *fingers)
-{
-	struct alps_bitmap_point *point;
-	int i, bit, prev_bit = 0;
-
-	point = low;
-	for (i = 0; map != 0; i++, map >>= 1) {
-		bit = map & 1;
-		if (bit) {
-			if (!prev_bit) {
-				point->start_bit = i;
-				point->num_bits = 0;
-				(*fingers)++;
-			}
-			point->num_bits++;
-		} else {
-			if (prev_bit)
-				point = high;
-		}
-		prev_bit = bit;
+		*x1 = fields->pt.x;
+		*y1 = fields->pt.y;
+		*x2 = 2 * box_middle_x - *x1;
+		*y2 = 2 * box_middle_y - *y1;
 	}
 }
 
@@ -358,21 +355,71 @@ static void alps_get_bitmap_points(unsigned int map,
  *
  * The bitmaps don't have enough data to track fingers, so this function
  * only generates points representing a bounding box of all contacts.
- * These points are returned in fields->mt when the return value
+ * These points are returned in x1, y1, x2, and y2 when the return value
  * is greater than 0.
  */
 static int alps_process_bitmap(struct alps_data *priv,
-			       struct alps_fields *fields)
+			       unsigned int x_map, unsigned int y_map,
+			       int *x1, int *y1, int *x2, int *y2)
 {
-	int i, fingers_x = 0, fingers_y = 0, fingers;
+	struct alps_bitmap_point {
+		int start_bit;
+		int num_bits;
+	};
+
+	int fingers_x = 0, fingers_y = 0, fingers;
+	int i, bit, prev_bit;
 	struct alps_bitmap_point x_low = {0,}, x_high = {0,};
 	struct alps_bitmap_point y_low = {0,}, y_high = {0,};
+	struct alps_bitmap_point *point;
 
-	if (!fields->x_map || !fields->y_map)
+	if (!x_map || !y_map)
 		return 0;
 
-	alps_get_bitmap_points(fields->x_map, &x_low, &x_high, &fingers_x);
-	alps_get_bitmap_points(fields->y_map, &y_low, &y_high, &fingers_y);
+	*x1 = *y1 = *x2 = *y2 = 0;
+
+	prev_bit = 0;
+	point = &x_low;
+	for (i = 0; x_map != 0; i++, x_map >>= 1) {
+		bit = x_map & 1;
+		if (bit) {
+			if (!prev_bit) {
+				point->start_bit = i;
+				fingers_x++;
+			}
+			point->num_bits++;
+		} else {
+			if (prev_bit)
+				point = &x_high;
+			else
+				point->num_bits = 0;
+		}
+		prev_bit = bit;
+	}
+
+	/*
+	 * y bitmap is reversed for what we need (lower positions are in
+	 * higher bits), so we process from the top end.
+	 */
+	y_map = y_map << (sizeof(y_map) * BITS_PER_BYTE - priv->y_bits);
+	prev_bit = 0;
+	point = &y_low;
+	for (i = 0; y_map != 0; i++, y_map <<= 1) {
+		bit = y_map & (1 << (sizeof(y_map) * BITS_PER_BYTE - 1));
+		if (bit) {
+			if (!prev_bit) {
+				point->start_bit = i;
+				fingers_y++;
+			}
+			point->num_bits++;
+		} else {
+			if (prev_bit)
+				point = &y_high;
+			else
+				point->num_bits = 0;
+		}
+		prev_bit = bit;
+	}
 
 	/*
 	 * Fingers can overlap, so we use the maximum count of fingers
@@ -381,89 +428,103 @@ static int alps_process_bitmap(struct alps_data *priv,
 	fingers = max(fingers_x, fingers_y);
 
 	/*
-	 * If an axis reports only a single contact, we have overlapping or
-	 * adjacent fingers. Divide the single contact between the two points.
+	 * If total fingers is > 1 but either axis reports only a single
+	 * contact, we have overlapping or adjacent fingers. For the
+	 * purposes of creating a bounding box, divide the single contact
+	 * (roughly) equally between the two points.
 	 */
-	if (fingers_x == 1) {
-		i = (x_low.num_bits - 1) / 2;
-		x_low.num_bits = x_low.num_bits - i;
-		x_high.start_bit = x_low.start_bit + i;
-		x_high.num_bits = max(i, 1);
-	}
-	if (fingers_y == 1) {
-		i = (y_low.num_bits - 1) / 2;
-		y_low.num_bits = y_low.num_bits - i;
-		y_high.start_bit = y_low.start_bit + i;
-		y_high.num_bits = max(i, 1);
-	}
-
-	fields->mt[0].x =
-		(priv->x_max * (2 * x_low.start_bit + x_low.num_bits - 1)) /
-		(2 * (priv->x_bits - 1));
-	fields->mt[0].y =
-		(priv->y_max * (2 * y_low.start_bit + y_low.num_bits - 1)) /
-		(2 * (priv->y_bits - 1));
-
-	fields->mt[1].x =
-		(priv->x_max * (2 * x_high.start_bit + x_high.num_bits - 1)) /
-		(2 * (priv->x_bits - 1));
-	fields->mt[1].y =
-		(priv->y_max * (2 * y_high.start_bit + y_high.num_bits - 1)) /
-		(2 * (priv->y_bits - 1));
-
-	/* y-bitmap order is reversed, except on rushmore */
-	if (!(priv->flags & ALPS_IS_RUSHMORE)) {
-		fields->mt[0].y = priv->y_max - fields->mt[0].y;
-		fields->mt[1].y = priv->y_max - fields->mt[1].y;
+	if (fingers > 1) {
+		if (fingers_x == 1) {
+			i = x_low.num_bits / 2;
+			x_low.num_bits = x_low.num_bits - i;
+			x_high.start_bit = x_low.start_bit + i;
+			x_high.num_bits = max(i, 1);
+		} else if (fingers_y == 1) {
+			i = y_low.num_bits / 2;
+			y_low.num_bits = y_low.num_bits - i;
+			y_high.start_bit = y_low.start_bit + i;
+			y_high.num_bits = max(i, 1);
+		}
+	}
+
+	*x1 = (priv->x_max * (2 * x_low.start_bit + x_low.num_bits - 1)) /
+	      (2 * (priv->x_bits - 1));
+	*y1 = (priv->y_max * (2 * y_low.start_bit + y_low.num_bits - 1)) /
+	      (2 * (priv->y_bits - 1));
+
+	if (fingers > 1) {
+		*x2 = (priv->x_max *
+		       (2 * x_high.start_bit + x_high.num_bits - 1)) /
+		      (2 * (priv->x_bits - 1));
+		*y2 = (priv->y_max *
+		       (2 * y_high.start_bit + y_high.num_bits - 1)) /
+		      (2 * (priv->y_bits - 1));
 	}
 
 	return fingers;
 }
 
-static void alps_set_slot(struct input_dev *dev, int slot, int x, int y)
+static void alps_set_slot(struct input_dev *dev, int slot, bool active,
+			  int x, int y)
 {
 	input_mt_slot(dev, slot);
-	input_mt_report_slot_state(dev, MT_TOOL_FINGER, true);
-	input_report_abs(dev, ABS_MT_POSITION_X, x);
-	input_report_abs(dev, ABS_MT_POSITION_Y, y);
+	input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
+	if (active) {
+		input_report_abs(dev, ABS_MT_POSITION_X, x);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y);
+	}
 }
 
-static void alps_report_mt_data(struct psmouse *psmouse, int n)
+static void alps_report_semi_mt_data(struct input_dev *dev, int num_fingers,
+				     int x1, int y1, int x2, int y2)
 {
-	struct alps_data *priv = psmouse->private;
-	struct input_dev *dev = psmouse->dev;
-	struct alps_fields *f = &priv->f;
-	int i, slot[MAX_TOUCHES];
+	alps_set_slot(dev, 0, num_fingers != 0, x1, y1);
+	alps_set_slot(dev, 1, num_fingers == 2, x2, y2);
+}
 
-	input_mt_assign_slots(dev, slot, f->mt, n);
-	for (i = 0; i < n; i++)
-		alps_set_slot(dev, slot[i], f->mt[i].x, f->mt[i].y);
+static void alps_report_semi_mt_data_ex(struct input_dev *dev, int num_fingers,
+				     struct alps_abs_data coord[])
+{
+	unsigned char i;
 
-	input_mt_sync_frame(dev);
+	for (i = 0; i < num_fingers; i++) {
+		if (!coord[i].x || !coord[i].y || !coord[i].z)
+			alps_set_slot(dev, i, 0, coord[i].x, coord[i].y);
+		else
+			alps_set_slot(dev, i, 1, coord[i].x, coord[i].y);
+	}
 }
 
-static void alps_report_semi_mt_data(struct psmouse *psmouse, int fingers)
+static void alps_report_coord_and_btn(struct psmouse *psmouse,
+				      struct alps_fields *f)
 {
-	struct alps_data *priv = psmouse->private;
-	struct input_dev *dev = psmouse->dev;
-	struct alps_fields *f = &priv->f;
+	struct input_dev *dev;
 
-	/* Use st data when we don't have mt data */
-	if (fingers < 2) {
-		f->mt[0].x = f->st.x;
-		f->mt[0].y = f->st.y;
-		fingers = f->pressure > 0 ? 1 : 0;
-	}
+	if (!psmouse || !f)
+		return;
 
-	alps_report_mt_data(psmouse, (fingers <= 2) ? fingers : 2);
+	dev = psmouse->dev;
 
-	input_mt_report_finger_count(dev, fingers);
+	if (f->fingers) {
+		input_report_key(dev, BTN_TOUCH, 1);
+
+		alps_report_semi_mt_data(dev, f->fingers,
+			f->pt_img[0].x, f->pt_img[0].y,
+			f->pt_img[1].x, f->pt_img[1].y);
+		input_mt_report_finger_count(dev, f->fingers);
 
-	input_report_key(dev, BTN_LEFT, f->left);
-	input_report_key(dev, BTN_RIGHT, f->right);
-	input_report_key(dev, BTN_MIDDLE, f->middle);
+		input_report_abs(dev, ABS_X, f->pt_img[0].x);
+		input_report_abs(dev, ABS_Y, f->pt_img[0].y);
+		input_report_abs(dev, ABS_PRESSURE, f->pt_img[0].z);
+	} else {
+		input_report_key(dev, BTN_TOUCH, 0);
+		input_mt_report_finger_count(dev, 0);
+		input_report_abs(dev, ABS_PRESSURE, 0);
+	}
 
-	input_report_abs(dev, ABS_PRESSURE, f->pressure);
+	input_report_key(dev, BTN_LEFT, f->btn.left);
+	input_report_key(dev, BTN_RIGHT, f->btn.right);
+	input_report_key(dev, BTN_MIDDLE, f->btn.middle);
 
 	input_sync(dev);
 }
@@ -530,16 +591,25 @@ static void alps_process_trackstick_packet_v3(struct psmouse *psmouse)
 
 static void alps_decode_buttons_v3(struct alps_fields *f, unsigned char *p)
 {
-	f->left = !!(p[3] & 0x01);
-	f->right = !!(p[3] & 0x02);
-	f->middle = !!(p[3] & 0x04);
+	f->btn.left = !!(p[3] & 0x01);
+	f->btn.right = !!(p[3] & 0x02);
+	f->btn.middle = !!(p[3] & 0x04);
 
-	f->ts_left = !!(p[3] & 0x10);
-	f->ts_right = !!(p[3] & 0x20);
-	f->ts_middle = !!(p[3] & 0x40);
+	f->btn.ts_left = !!(p[3] & 0x10);
+	f->btn.ts_right = !!(p[3] & 0x20);
+	f->btn.ts_middle = !!(p[3] & 0x40);
 }
 
-static int alps_decode_pinnacle(struct alps_fields *f, unsigned char *p,
+/* proto_v9 */
+static void alps_decode_button_ss3(struct alps_fields *f, unsigned char *p,
+				struct alps_data *priv)
+{
+	if (f->dol_packet_type == DOL_GPDATA ||
+		f->dol_packet_type == DOL_APDATA)
+		f->btn.left = !!(p[3]&0x01);
+}
+
+static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p,
 				 struct psmouse *psmouse)
 {
 	f->first_mp = !!(p[4] & 0x40);
@@ -553,17 +623,15 @@ static int alps_decode_pinnacle(struct alps_fields *f, unsigned char *p,
 		   ((p[2] & 0x7f) << 1) |
 		   (p[4] & 0x01);
 
-	f->st.x = ((p[1] & 0x7f) << 4) | ((p[4] & 0x30) >> 2) |
+	f->pt.x = ((p[1] & 0x7f) << 4) | ((p[4] & 0x30) >> 2) |
 	       ((p[0] & 0x30) >> 4);
-	f->st.y = ((p[2] & 0x7f) << 4) | (p[4] & 0x0f);
-	f->pressure = p[5] & 0x7f;
+	f->pt.y = ((p[2] & 0x7f) << 4) | (p[4] & 0x0f);
+	f->pt.z = p[5] & 0x7f;
 
 	alps_decode_buttons_v3(f, p);
-
-	return 0;
 }
 
-static int alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
+static void alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
 				 struct psmouse *psmouse)
 {
 	alps_decode_pinnacle(f, p, psmouse);
@@ -573,25 +641,20 @@ static int alps_decode_rushmore(struct alps_fields *f, unsigned char *p,
 	f->fingers = max((p[5] & 0x3), ((p[5] >> 2) & 0x3)) + 1;
 	f->x_map |= (p[5] & 0x10) << 11;
 	f->y_map |= (p[5] & 0x20) << 6;
-
-	return 0;
 }
 
-static int alps_decode_dolphin(struct alps_fields *f, unsigned char *p,
+static void alps_decode_dolphin(struct alps_fields *f, unsigned char *p,
 				struct psmouse *psmouse)
 {
 	u64 palm_data = 0;
 	struct alps_data *priv = psmouse->private;
 
-	f->first_mp = !!(p[0] & 0x02);
-	f->is_mp = !!(p[0] & 0x20);
+	f->is_mp = 0;
+	f->first_mp = 0;
 
-	if (!f->is_mp) {
-		f->st.x = ((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
-		f->st.y = ((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
-		f->pressure = (p[0] & 4) ? 0 : p[5] & 0x7f;
-		alps_decode_buttons_v3(f, p);
-	} else {
+	if (DOL_IS_PROFDATA(p)) {
+		f->is_mp = 1;
+		f->dol_packet_type = DOL_PROFDATA;
 		f->fingers = ((p[0] & 0x6) >> 1 |
 		     (p[0] & 0x10) >> 2);
 
@@ -609,22 +672,415 @@ static int alps_decode_dolphin(struct alps_fields *f, unsigned char *p,
 		/* X-profile is stored in p(n) to p(n+m-1), m = x_bits; */
 		f->x_map = (palm_data >> priv->y_bits) &
 			   (BIT(priv->x_bits) - 1);
+	} else {
+		if (DOL_IS_APDATA(p)) {
+			f->dol_packet_type = DOL_APDATA;
+			f->fingers = 2;
+			f->pt_img[0].x = p[1]<<3;
+			f->pt_img[0].y = p[2]<<2;
+			f->pt_img[0].z = 64;
+			f->pt_img[1].x = p[4]<<3;
+			f->pt_img[1].y = p[5]<<2;
+			f->pt_img[1].z = 64;
+		} else {/* is gp data */
+			f->dol_packet_type = DOL_GPDATA;
+			f->first_mp = !!(p[0]&0x02);
+			f->pt.x = f->pt_img[0].x =
+				((p[1] & 0x7f) | ((p[4] & 0x0f) << 7));
+			f->pt.y = f->pt_img[0].y =
+				((p[2] & 0x7f) | ((p[4] & 0xf0) << 3));
+			f->pt.z = f->pt_img[0].z =
+				min(((p[0] & 0x04) ? 0 : p[5] & 0x7f) * 2, 127);
+
+			/*
+				Button number will be included in
+				the PROFILE data for a 3-f packet.
+				So do not change .fingers because
+				it will be updated in Profile data packet.
+			*/
+			if (!f->first_mp)
+				f->fingers = (f->pt_img[0].x &&
+					f->pt_img[0].y && f->pt_img[0].z)?1:0;
+		}
+
+		if (priv->proto_version == ALPS_PROTO_V9)
+			alps_decode_button_ss3(f, p, priv);
+		else
+			alps_decode_buttons_v3(f, p);
 	}
+}
 
-	return 0;
+unsigned char alps_get_pkt_id_ss4_v1(char *byte)
+{
+	unsigned char pkt_id = SS4_PACKET_ID_IDLE;
+
+	if (((byte[0] & 0xFF) == 0x08) && ((byte[1] & 0xFF) == 0x10) &&
+	     ((byte[2] & 0xFF) == 0x00) && ((byte[3] & 0x8F) == 0x08) &&
+	     ((byte[4] & 0xFF) == 0x01) && ((byte[5] & 0xFF) == 0x00)) {
+		pkt_id = SS4_PACKET_ID_IDLE;
+	} else if (((byte[0] & 0x08) == 0x08) && ((byte[1] & 0x10) == 0x10) &&
+		((byte[3] & 0x8E) == 0x08) && ((byte[4] & 0x81) == 0x01)) {
+		pkt_id = SS4_PACKET_ID_ONE;
+	} else if (((byte[0] & 0x08) == 0x08) && ((byte[3] & 0x08) == 0x08) &&
+		  ((byte[4] & 0x01) == 0x01)) {
+		if (((byte[5] & 0x01) == 0x01))
+			pkt_id = SS4_PACKET_ID_TWO;
+		else
+			pkt_id = SS4_PACKET_ID_MULTI;
+	}
+
+	return pkt_id;
+}
+
+unsigned char alps_get_pkt_id_ss4_v2(char *byte)
+{
+	unsigned char pkt_id = SS4_PACKET_ID_IDLE;
+
+	if (((byte[0] & 0xFF) == 0x18) && ((byte[1] & 0xFF) == 0x10) &&
+	     ((byte[2] & 0xFF) == 0x00) && ((byte[3] & 0x88) == 0x08) &&
+	     ((byte[4] & 0xFF) == 0x10) && ((byte[5] & 0xFF) == 0x00)) {
+		pkt_id = SS4_PACKET_ID_IDLE;
+	} else if (!(byte[3] & 0x10)) {
+		pkt_id = SS4_PACKET_ID_ONE;
+	} else {
+		if (!(byte[3] & 0x20))
+			pkt_id = SS4_PACKET_ID_TWO;
+		else
+			pkt_id = SS4_PACKET_ID_MULTI;
+	}
+
+	return pkt_id;
+}
+
+static void alps_process_btnless_click(struct psmouse *psmouse,
+				struct alps_fields *f)
+{
+	struct alps_data *priv = psmouse->private;
+
+	if (!f->btn.left)
+		return;
+
+	/* Clear button flag */
+	f->btn.left = 0;
+
+	switch (f->fingers) {
+	case 1:
+		/* In Left Resting Area */
+		if (PT_IN_LEFT_BTN_AREA(f->pt_img[0].x,
+				f->pt_img[0].y, priv->x_max, priv->y_max)) {
+			f->btn.left = 1;
+		} else if (PT_IN_RIGHT_BTN_AREA(f->pt_img[0].x,
+				f->pt_img[0].y, priv->x_max, priv->y_max)) {
+			/* In Right Resting Area */
+			f->btn.right = 1;
+		} else {
+			/* In Normal area */
+			f->btn.left = 1;
+		}
+		break;
+
+	case 2:
+		/* Both two fingers are in Normal area */
+		if (!PT_IN_BTN_AREA(f->pt_img[0].x,
+				f->pt_img[0].y, priv->x_max, priv->y_max) &&
+				!PT_IN_BTN_AREA(f->pt_img[1].x,
+				f->pt_img[1].y, priv->x_max, priv->y_max)) {
+			f->btn.right = 1;
+		} else if (PT_IN_RIGHT_BTN_AREA(f->pt_img[0].x,
+				f->pt_img[0].y, priv->x_max, priv->y_max) ||
+				PT_IN_RIGHT_BTN_AREA(f->pt_img[1].x,
+				f->pt_img[1].y, priv->x_max, priv->y_max)) {
+			/* Either one finger is in Right Area */
+			f->btn.right = 1;
+		} else {
+			f->btn.left = 1;
+		}
+		break;
+
+	case 3:
+		f->btn.middle = 1;
+		break;
+
+	case 0:
+	default:
+		break;
+	}
+}
+
+static void alps_process_resting_finger(struct psmouse *psmouse,
+	struct alps_fields *f, struct alps_abs_data *output,
+	unsigned char *p_fn)
+{
+	struct alps_data *priv = psmouse->private;
+	static struct alps_abs_data prev_pt[10];
+	static struct alps_abs_data init_pt[10];
+	static unsigned char is_moved[10];
+	static unsigned char prev_fn;
+	static unsigned char prev_coord_is_output[10];
+	unsigned char cur_coord_is_output[10];
+	unsigned char in_resting_area[10];
+	unsigned char i, index;
+	unsigned char output_fn = 0;
+
+	memset(in_resting_area, 0, sizeof(in_resting_area));
+	memset(cur_coord_is_output, 0, sizeof(cur_coord_is_output));
+
+	/* Clear "is_moved" flag when finger number changed */
+	if (f->fingers != prev_fn) {
+		memset(is_moved, 0, sizeof(is_moved));
+		memcpy(init_pt, f->pt_img, sizeof(f->pt_img));
+	}
+
+	/* Calculate output finger */
+	for (i = 0, index = 0; i < f->fingers; i++) {
+		if (is_moved[i] == 0 &&
+			(abs(f->pt_img[i].x - init_pt[i].x)
+				> RESTING_FN_LARGE_MOVEMENT)) {
+			is_moved[i] = 1;
+		}
+
+		/* Check if in resting area */
+		if (PT_IN_BTN_AREA(f->pt_img[i].x,
+				f->pt_img[i].y, priv->x_max, priv->y_max))
+			in_resting_area[i] = 1;
+
+		if (!in_resting_area[i] ||
+			(in_resting_area[i] && is_moved[i])) {
+			memcpy(&output[index++], &f->pt_img[i],
+				sizeof(struct alps_abs_data));
+			cur_coord_is_output[i] = 1;
+			output_fn++;
+		}
+	}
+
+	/* A normal finger becomes a resting finger */
+	for (i = 0; i < f->fingers; i++) {
+		if (prev_coord_is_output[i] &&
+			!cur_coord_is_output[i] && f->pt_img[i].z) {
+			output_fn = 0;
+			memset(output, 0,
+				sizeof(struct alps_abs_data)*f->fingers);
+		}
+	}
+
+	memcpy(prev_pt, f->pt_img, sizeof(f->pt_img));
+	memcpy(prev_coord_is_output, cur_coord_is_output,
+		sizeof(cur_coord_is_output));
+	prev_fn = f->fingers;
+	*p_fn = output_fn;
+}
+
+static void alps_decode_ss4_v1(struct alps_fields *f,
+			unsigned char *p, struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+	unsigned char pkt_id;
+	unsigned int no_data_x, no_data_y;
+
+	if (!psmouse || !f || !p)
+		return;
+
+	pkt_id = alps_get_pkt_id_ss4_v1(p);
+
+	/* Current packet is 1Finger coordinate packet */
+	switch (pkt_id) {
+	case SS4_PACKET_ID_ONE:
+		f->pt_img[0].x = SS4_1F_X_V1(p);
+		f->pt_img[0].y = SS4_1F_Y_V1(p);
+		/* Keep Z-value in 0-127 */
+		f->pt_img[0].z = min(((SS4_1F_Z_V1(p)) * 2), 127);
+		f->large_fn |= SS4_1F_LFB(p) ? 0x01 : 0x00;
+		f->fingers = 1;
+		f->first_mp = 0;
+		f->is_mp = 0;
+		break;
+
+	case SS4_PACKET_ID_TWO:
+		if (priv->flags & ALPS_BTNLESS) {
+			f->pt_img[0].x = SS4_BTL_MF_X_V1(p, 0);
+			f->pt_img[0].y = SS4_BTL_MF_Y_V1(p, 0);
+			f->pt_img[1].x = SS4_BTL_MF_X_V1(p, 1);
+			f->pt_img[1].y = SS4_BTL_MF_Y_V1(p, 1);
+		} else {
+			f->pt_img[0].x = SS4_STD_MF_X_V1(p, 0);
+			f->pt_img[0].y = SS4_STD_MF_Y_V1(p, 0);
+			f->pt_img[1].x = SS4_STD_MF_X_V1(p, 1);
+			f->pt_img[1].y = SS4_STD_MF_Y_V1(p, 1);
+		}
+		f->pt_img[0].z = SS4_MF_Z_V1(p, 0) ? 0x30 : 0;
+		f->pt_img[1].z = SS4_MF_Z_V1(p, 1) ? 0x30 : 0;
+
+		if (SS4_IS_MF_CONTINUE_V1(p)) {
+			f->first_mp = 1;
+		} else {
+			f->fingers = 2;
+			f->first_mp = 0;
+		}
+		f->is_mp = 0;
+
+		break;
+
+	case SS4_PACKET_ID_MULTI:
+		if (priv->flags & ALPS_BTNLESS) {
+			f->pt_img[2].x = SS4_BTL_MF_X_V1(p, 0);
+			f->pt_img[2].y = SS4_BTL_MF_Y_V1(p, 0);
+			f->pt_img[3].x = SS4_BTL_MF_X_V1(p, 1);
+			f->pt_img[3].y = SS4_BTL_MF_Y_V1(p, 1);
+			no_data_x = SS4_MFPACKET_NO_AX_BL;
+			no_data_y = SS4_MFPACKET_NO_AY_BL;
+		} else {
+			f->pt_img[2].x = SS4_STD_MF_X_V1(p, 0);
+			f->pt_img[2].y = SS4_STD_MF_Y_V1(p, 0);
+			f->pt_img[3].x = SS4_STD_MF_X_V1(p, 1);
+			f->pt_img[3].y = SS4_STD_MF_Y_V1(p, 1);
+			no_data_x = SS4_MFPACKET_NO_AX;
+			no_data_y = SS4_MFPACKET_NO_AY;
+		}
+		f->pt_img[2].z = SS4_MF_Z_V1(p, 0) ? 0x30 : 0;
+		f->pt_img[3].z = SS4_MF_Z_V1(p, 1) ? 0x30 : 0;
+
+		f->first_mp = 0;
+		f->is_mp = 1;
+
+		if (SS4_IS_5F_DETECTED_V1(p)) {
+			f->fingers = 5;
+		} else if (f->pt_img[3].x == no_data_x &&
+			     f->pt_img[3].y == no_data_y) {
+			f->fingers = 3;
+			f->pt_img[3].x = 0;
+			f->pt_img[3].y = 0;
+			f->pt_img[3].z = 0;
+		} else {
+			f->fingers = 4;
+		}
+		break;
+
+	case SS4_PACKET_ID_IDLE:
+	default:
+		memset(f, 0, sizeof(struct alps_fields));
+		break;
+	}
+
+	f->btn.left = !!(SS4_BTN_V1(p) & 0x01);
+	if (!(priv->flags & ALPS_BTNLESS)) {
+		f->btn.right = !!(SS4_BTN_V1(p) & 0x02);
+		f->btn.middle = !!(SS4_BTN_V1(p) & 0x04);
+	}
+}
+
+static void alps_decode_ss4_v2(struct alps_fields *f,
+			unsigned char *p, struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+	unsigned char pkt_id;
+	unsigned int no_data_x, no_data_y;
+
+	if (!psmouse || !f || !p)
+		return;
+
+	pkt_id = alps_get_pkt_id_ss4_v2(p);
+
+	/* Current packet is 1Finger coordinate packet */
+	switch (pkt_id) {
+	case SS4_PACKET_ID_ONE:
+		f->pt_img[0].x = SS4_1F_X_V2(p);
+		f->pt_img[0].y = SS4_1F_Y_V2(p);
+		/* Keep Z-value in 0-127 */
+		f->pt_img[0].z = min(((SS4_1F_Z_V2(p)) * 2), 127);
+		f->large_fn |= SS4_1F_LFB_V2(p) ? 0x01 : 0x00;
+		f->fingers = 1;
+		f->first_mp = 0;
+		f->is_mp = 0;
+		break;
+
+	case SS4_PACKET_ID_TWO:
+		if (priv->flags & ALPS_BTNLESS) {
+			f->pt_img[0].x = SS4_BTL_MF_X_V2(p, 0);
+			f->pt_img[0].y = SS4_BTL_MF_Y_V2(p, 0);
+			f->pt_img[1].x = SS4_BTL_MF_X_V2(p, 1);
+			f->pt_img[1].y = SS4_BTL_MF_Y_V2(p, 1);
+		} else {
+			f->pt_img[0].x = SS4_STD_MF_X_V2(p, 0);
+			f->pt_img[0].y = SS4_STD_MF_Y_V2(p, 0);
+			f->pt_img[1].x = SS4_STD_MF_X_V2(p, 1);
+			f->pt_img[1].y = SS4_STD_MF_Y_V2(p, 1);
+		}
+		f->pt_img[0].z = SS4_MF_Z_V2(p, 0) ? 0x30 : 0;
+		f->pt_img[1].z = SS4_MF_Z_V2(p, 1) ? 0x30 : 0;
+
+		f->large_fn |= SS4_MF_LF_V2(p, 0) ? 0x01 : 0;
+		f->large_fn |= SS4_MF_LF_V2(p, 1) ? 0x02 : 0;
+
+		if (SS4_IS_MF_CONTINUE_V2(p)) {
+			f->first_mp = 1;
+		} else {
+			f->fingers = 2;
+			f->first_mp = 0;
+		}
+		f->is_mp = 0;
+		break;
+
+	case SS4_PACKET_ID_MULTI:
+		if (priv->flags & ALPS_BTNLESS) {
+			f->pt_img[2].x = SS4_BTL_MF_X_V2(p, 0);
+			f->pt_img[2].y = SS4_BTL_MF_Y_V2(p, 0);
+			f->pt_img[3].x = SS4_BTL_MF_X_V2(p, 1);
+			f->pt_img[3].y = SS4_BTL_MF_Y_V2(p, 1);
+			no_data_x = SS4_MFPACKET_NO_AX_BL;
+			no_data_y = SS4_MFPACKET_NO_AY_BL;
+		} else {
+			f->pt_img[2].x = SS4_STD_MF_X_V2(p, 0);
+			f->pt_img[2].y = SS4_STD_MF_Y_V2(p, 0);
+			f->pt_img[3].x = SS4_STD_MF_X_V2(p, 1);
+			f->pt_img[3].y = SS4_STD_MF_Y_V2(p, 1);
+			no_data_x = SS4_MFPACKET_NO_AX;
+			no_data_y = SS4_MFPACKET_NO_AY;
+		}
+		f->pt_img[2].z = SS4_MF_Z_V2(p, 0) ? 0x30 : 0;
+		f->pt_img[3].z = SS4_MF_Z_V2(p, 1) ? 0x30 : 0;
+
+		f->large_fn |= SS4_MF_LF_V2(p, 0) ? 0x04 : 0;
+		f->large_fn |= SS4_MF_LF_V2(p, 1) ? 0x08 : 0;
+		f->first_mp = 0;
+		f->is_mp = 1;
+
+		if (SS4_IS_5F_DETECTED_V2(p)) {
+			f->fingers = 5;
+		} else if (f->pt_img[3].x == no_data_x &&
+			     f->pt_img[3].y == no_data_y) {
+			f->fingers = 3;
+			f->pt_img[3].x = 0;
+			f->pt_img[3].y = 0;
+			f->pt_img[3].z = 0;
+		} else {
+			f->fingers = 4;
+		}
+		break;
+
+	case SS4_PACKET_ID_IDLE:
+	default:
+		memset(f, 0, sizeof(struct alps_fields));
+		break;
+	}
+
+	f->btn.left = !!(SS4_BTN_V2(p) & 0x01);
+	if (!(priv->flags & ALPS_BTNLESS)) {
+		f->btn.right = !!(SS4_BTN_V2(p) & 0x02);
+		f->btn.middle = !!(SS4_BTN_V2(p) & 0x04);
+	}
 }
 
 static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
+	struct input_dev *dev = psmouse->dev;
 	struct input_dev *dev2 = priv->dev2;
-	struct alps_fields *f = &priv->f;
-	int fingers = 0;
+	int x1 = 0, y1 = 0, x2 = 0, y2 = 0;
+	int fingers = 0, bmap_fn;
+	struct alps_fields f = {0};
 
-	memset(f, 0, sizeof(*f));
-
-	priv->decode_fields(f, packet, psmouse);
+	priv->decode_fields(&f, packet, psmouse);
 
 	/*
 	 * There's no single feature of touchpad position and bitmap packets
@@ -639,14 +1095,22 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 		 * packet. Check for this, and when it happens process the
 		 * position packet as usual.
 		 */
-		if (f->is_mp) {
-			fingers = f->fingers;
+		if (f.is_mp) {
+			fingers = f.fingers;
 			if (priv->proto_version == ALPS_PROTO_V3) {
-				if (alps_process_bitmap(priv, f) == 0)
-					fingers = 0; /* Use st data */
+				bmap_fn = alps_process_bitmap(priv, f.x_map,
+							      f.y_map, &x1, &y1,
+							      &x2, &y2);
+
+				/*
+				 * We shouldn't report more than one finger if
+				 * we don't have two coordinates.
+				 */
+				if (fingers > 1 && bmap_fn < 2)
+					fingers = bmap_fn;
 
 				/* Now process position packet */
-				priv->decode_fields(f, priv->multi_data,
+				priv->decode_fields(&f, priv->multi_data,
 						    psmouse);
 			} else {
 				/*
@@ -655,14 +1119,15 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 				 * calculate Pt2, so we need to do position
 				 * packet decode first.
 				 */
-				priv->decode_fields(f, priv->multi_data,
+				priv->decode_fields(&f, priv->multi_data,
 						    psmouse);
 
 				/*
 				 * Since Dolphin's finger number is reliable,
 				 * there is no need to compare with bmap_fn.
 				 */
-				alps_process_bitmap_dolphin(priv, f);
+				alps_process_bitmap_dolphin(priv, &f, &x1, &y1,
+					&x2, &y2);
 			}
 		} else {
 			priv->multi_packet = 0;
@@ -677,10 +1142,10 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 	 * out misidentified bitmap packets, we reject anything with this
 	 * bit set.
 	 */
-	if (f->is_mp)
+	if (f.is_mp)
 		return;
 
-	if (!priv->multi_packet && f->first_mp) {
+	if (!priv->multi_packet && f.first_mp) {
 		priv->multi_packet = 1;
 		memcpy(priv->multi_data, packet, sizeof(priv->multi_data));
 		return;
@@ -694,15 +1159,44 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 	 * with x, y, and z all zero, so these seem to be flukes.
 	 * Ignore them.
 	 */
-	if (f->st.x && f->st.y && !f->pressure)
+	if (f.pt.x && f.pt.y && !f.pt.z)
 		return;
 
-	alps_report_semi_mt_data(psmouse, fingers);
+	/*
+	 * If we don't have MT data or the bitmaps were empty, we have
+	 * to rely on ST data.
+	 */
+	if (!fingers) {
+		x1 = f.pt.x;
+		y1 = f.pt.y;
+		fingers = f.pt.z > 0 ? 1 : 0;
+	}
+
+	if (f.pt.z > 0)
+		input_report_key(dev, BTN_TOUCH, 1);
+	else
+		input_report_key(dev, BTN_TOUCH, 0);
+
+	alps_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
+
+	input_mt_report_finger_count(dev, fingers);
+
+	input_report_key(dev, BTN_LEFT, f.btn.left);
+	input_report_key(dev, BTN_RIGHT, f.btn.right);
+	input_report_key(dev, BTN_MIDDLE, f.btn.middle);
+
+	if (f.pt.z > 0) {
+		input_report_abs(dev, ABS_X, f.pt.x);
+		input_report_abs(dev, ABS_Y, f.pt.y);
+	}
+	input_report_abs(dev, ABS_PRESSURE, f.pt.z);
+
+	input_sync(dev);
 
 	if (!(priv->quirks & ALPS_QUIRK_TRACKSTICK_BUTTONS)) {
-		input_report_key(dev2, BTN_LEFT, f->ts_left);
-		input_report_key(dev2, BTN_RIGHT, f->ts_right);
-		input_report_key(dev2, BTN_MIDDLE, f->ts_middle);
+		input_report_key(dev2, BTN_LEFT, f.btn.ts_left);
+		input_report_key(dev2, BTN_RIGHT, f.btn.ts_right);
+		input_report_key(dev2, BTN_MIDDLE, f.btn.ts_middle);
 		input_sync(dev2);
 	}
 }
@@ -727,6 +1221,64 @@ static void alps_process_packet_v3(struct psmouse *psmouse)
 	alps_process_touchpad_packet_v3_v5(psmouse);
 }
 
+/* proto_v9 */
+static void alps_process_touchpad_packet_ss3(struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+	unsigned char *packet = psmouse->packet;
+	struct input_dev *dev = psmouse->dev;
+	int fingers = 0;
+	struct alps_fields f = {0};
+	struct alps_abs_data	pt_output[2] = { {0, 0, 0}, {0, 0, 0} };
+	unsigned char output_fn_num = 0;
+
+	priv->decode_fields(&f, packet, psmouse);
+
+	if ((!!priv->multi_packet) != (!!f.is_mp)) {
+		priv->multi_packet = 0;
+		return;
+	}
+
+	/* When f.first_mp is 1, next packet should be a
+	 *	bitmap packet(when there is no error).
+	 */
+	priv->multi_packet = f.first_mp;
+
+	/* Don't process any 3-f data */
+	if (f.first_mp || f.is_mp)
+		return;
+
+	/*
+	 * If we don't have MT data or the bitmaps were empty, we have
+	 * to rely on ST data.
+	 */
+	fingers = f.fingers;
+
+	alps_process_resting_finger(psmouse, &f, pt_output, &output_fn_num);
+	alps_process_btnless_click(psmouse, &f);
+
+	if (pt_output[0].z || pt_output[1].z)
+		input_report_key(dev, BTN_TOUCH, 1);
+	else
+		input_report_key(dev, BTN_TOUCH, 0);
+
+	alps_report_semi_mt_data_ex(dev, 2, pt_output);
+
+	input_mt_report_finger_count(dev, output_fn_num);
+
+	input_report_key(dev, BTN_LEFT, f.btn.left);
+	input_report_key(dev, BTN_RIGHT, f.btn.right);
+	input_report_key(dev, BTN_MIDDLE, f.btn.middle);
+
+	if (pt_output[0].z > 0) {
+		input_report_abs(dev, ABS_X, pt_output[0].x);
+		input_report_abs(dev, ABS_Y, pt_output[0].y);
+	}
+	input_report_abs(dev, ABS_PRESSURE, pt_output[0].z ? 30 : 0);
+
+	input_sync(dev);
+}
+
 static void alps_process_packet_v6(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
@@ -801,8 +1353,13 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
-	struct alps_fields *f = &priv->f;
+	struct input_dev *dev = psmouse->dev;
 	int offset;
+	int x, y, z;
+	int left, right;
+	int x1, y1, x2, y2;
+	int fingers = 0;
+	unsigned int x_bitmap, y_bitmap;
 
 	/*
 	 * v4 has a 6-byte encoding for bitmap data, but this data is
@@ -824,41 +1381,96 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
 	if (++priv->multi_packet > 2) {
 		priv->multi_packet = 0;
 
-		f->x_map = ((priv->multi_data[2] & 0x1f) << 10) |
+		x_bitmap = ((priv->multi_data[2] & 0x1f) << 10) |
 			   ((priv->multi_data[3] & 0x60) << 3) |
 			   ((priv->multi_data[0] & 0x3f) << 2) |
 			   ((priv->multi_data[1] & 0x60) >> 5);
-		f->y_map = ((priv->multi_data[5] & 0x01) << 10) |
+		y_bitmap = ((priv->multi_data[5] & 0x01) << 10) |
 			   ((priv->multi_data[3] & 0x1f) << 5) |
 			    (priv->multi_data[1] & 0x1f);
 
-		f->fingers = alps_process_bitmap(priv, f);
+		fingers = alps_process_bitmap(priv, x_bitmap, y_bitmap,
+					      &x1, &y1, &x2, &y2);
+
+		/* Store MT data.*/
+		priv->fingers = fingers;
+		priv->x1 = x1;
+		priv->x2 = x2;
+		priv->y1 = y1;
+		priv->y2 = y2;
 	}
 
-	f->left = packet[4] & 0x01;
-	f->right = packet[4] & 0x02;
+	left = packet[4] & 0x01;
+	right = packet[4] & 0x02;
+
+	x = ((packet[1] & 0x7f) << 4) | ((packet[3] & 0x30) >> 2) |
+	    ((packet[0] & 0x30) >> 4);
+	y = ((packet[2] & 0x7f) << 4) | (packet[3] & 0x0f);
+	z = packet[5] & 0x7f;
+
+	/*
+	 * If there were no contacts in the bitmap, use ST
+	 * points in MT reports.
+	 * If there were two contacts or more, report MT data.
+	 */
+	if (priv->fingers < 2) {
+		x1 = x;
+		y1 = y;
+		fingers = z > 0 ? 1 : 0;
+	} else {
+		fingers = priv->fingers;
+		x1 = priv->x1;
+		x2 = priv->x2;
+		y1 = priv->y1;
+		y2 = priv->y2;
+	}
+
+	if (z >= 64)
+		input_report_key(dev, BTN_TOUCH, 1);
+	else
+		input_report_key(dev, BTN_TOUCH, 0);
+
+	alps_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
+
+	input_mt_report_finger_count(dev, fingers);
+
+	input_report_key(dev, BTN_LEFT, left);
+	input_report_key(dev, BTN_RIGHT, right);
 
-	f->st.x = ((packet[1] & 0x7f) << 4) | ((packet[3] & 0x30) >> 2) |
-		  ((packet[0] & 0x30) >> 4);
-	f->st.y = ((packet[2] & 0x7f) << 4) | (packet[3] & 0x0f);
-	f->pressure = packet[5] & 0x7f;
+	if (z > 0) {
+		input_report_abs(dev, ABS_X, x);
+		input_report_abs(dev, ABS_Y, y);
+	}
+	input_report_abs(dev, ABS_PRESSURE, z);
 
-	alps_report_semi_mt_data(psmouse, f->fingers);
+	input_sync(dev);
 }
 
 static bool alps_is_valid_package_v7(struct psmouse *psmouse)
 {
-	switch (psmouse->pktcnt) {
-	case 3:
-		return (psmouse->packet[2] & 0x40) == 0x40;
-	case 4:
-		return (psmouse->packet[3] & 0x48) == 0x48;
-	case 6:
-		return (psmouse->packet[5] & 0x40) == 0x00;
-	}
+	if ((psmouse->pktcnt == 3) && ((psmouse->packet[2] & 0x40) != 0x40))
+		return false;
+	if ((psmouse->pktcnt == 4) && ((psmouse->packet[3] & 0x48) != 0x48))
+		return false;
+	if ((psmouse->pktcnt == 6) && ((psmouse->packet[5] & 0x40) != 0x0))
+		return false;
 	return true;
 }
 
+static int alps_drop_unsupported_packet_v7(struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+	int drop = 1;
+
+	if (priv->r.v7.pkt_id == V7_PACKET_ID_NEW ||
+	    priv->r.v7.pkt_id == V7_PACKET_ID_TWO ||
+	    priv->r.v7.pkt_id == V7_PACKET_ID_MULTI ||
+	    priv->r.v7.pkt_id == V7_PACKET_ID_IDLE)
+		drop = 0;
+
+	return drop;
+}
+
 static unsigned char alps_get_packet_id_v7(char *byte)
 {
 	unsigned char packet_id;
@@ -874,85 +1486,251 @@ static unsigned char alps_get_packet_id_v7(char *byte)
 	else
 		packet_id = V7_PACKET_ID_UNKNOWN;
 
-	return packet_id;
+	return packet_id;
+}
+
+static void alps_get_finger_coordinate_v7(struct alps_abs_data *pt,
+					  unsigned char *pkt,
+					  unsigned char pkt_id)
+{
+	if ((pkt_id == V7_PACKET_ID_TWO) ||
+	   (pkt_id == V7_PACKET_ID_MULTI) ||
+	   (pkt_id == V7_PACKET_ID_NEW)) {
+		pt[0].x = ((pkt[2] & 0x80) << 4);
+		pt[0].x |= ((pkt[2] & 0x3F) << 5);
+		pt[0].x |= ((pkt[3] & 0x30) >> 1);
+		pt[0].x |= (pkt[3] & 0x07);
+		pt[0].y = (pkt[1] << 3) | (pkt[0] & 0x07);
+
+		pt[1].x = ((pkt[3] & 0x80) << 4);
+		pt[1].x |= ((pkt[4] & 0x80) << 3);
+		pt[1].x |= ((pkt[4] & 0x3F) << 4);
+		pt[1].y = ((pkt[5] & 0x80) << 3);
+		pt[1].y |= ((pkt[5] & 0x3F) << 4);
+
+		if (pkt_id == V7_PACKET_ID_TWO) {
+			pt[1].x &= ~0x000F;
+			pt[1].y |= 0x000F;
+		} else if (pkt_id == V7_PACKET_ID_MULTI) {
+			pt[1].x &= ~0x003F;
+			pt[1].y &= ~0x0020;
+			pt[1].y |= ((pkt[4] & 0x02) << 4);
+			pt[1].y |= 0x001F;
+		} else if (pkt_id == V7_PACKET_ID_NEW) {
+			pt[1].x &= ~0x003F;
+			pt[1].x |= (pkt[0] & 0x20);
+			pt[1].y |= 0x000F;
+		}
+
+		pt[0].y = 0x7FF - pt[0].y;
+		pt[1].y = 0x7FF - pt[1].y;
+
+		pt[0].z = (pt[0].x && pt[0].y) ? 62 : 0;
+		pt[1].z = (pt[1].x && pt[1].y) ? 62 : 0;
+	}
+}
+
+static void alps_decode_packet_v7(struct alps_fields *f,
+				  unsigned char *p,
+				  struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+
+	priv->r.v7.pkt_id = alps_get_packet_id_v7(p);
+
+	alps_get_finger_coordinate_v7(f->pt_img, p, priv->r.v7.pkt_id);
+
+	priv->r.v7.rest_left = 0;
+	priv->r.v7.rest_right = 0;
+	priv->r.v7.additional_fingers = 0;
+	memset(&f->btn, 0, sizeof(struct alps_btn));
+
+	if (priv->r.v7.pkt_id == V7_PACKET_ID_TWO ||
+	    priv->r.v7.pkt_id == V7_PACKET_ID_MULTI) {
+
+		if (priv->flags & ALPS_BTNLESS) {
+			priv->r.v7.rest_left = (p[0] & 0x10) >> 4;
+			priv->r.v7.rest_right = (p[0] & 0x20) >> 5;
+			f->btn.middle = (p[0] & 0x80) >> 7;
+		} else {
+			f->btn.left = (p[0] & 0x80) >> 7;
+			f->btn.right = (p[0] & 0x20) >> 5;
+			f->btn.middle = (p[0] & 0x10) >> 4;
+		}
+	}
+
+	if (priv->r.v7.pkt_id == V7_PACKET_ID_MULTI)
+		priv->r.v7.additional_fingers = p[5] & 0x03;
 }
 
-static void alps_get_finger_coordinate_v7(struct input_mt_pos *mt,
-					  unsigned char *pkt,
-					  unsigned char pkt_id)
+static void alps_set_each_pt_attr_v7(struct psmouse *psmouse,
+				     struct alps_abs_data *pt,
+				     struct alps_bl_pt_attr *pt_attr)
 {
-	mt[0].x = ((pkt[2] & 0x80) << 4);
-	mt[0].x |= ((pkt[2] & 0x3F) << 5);
-	mt[0].x |= ((pkt[3] & 0x30) >> 1);
-	mt[0].x |= (pkt[3] & 0x07);
-	mt[0].y = (pkt[1] << 3) | (pkt[0] & 0x07);
+	struct alps_data *priv = psmouse->private;
+	unsigned int dist;
 
-	mt[1].x = ((pkt[3] & 0x80) << 4);
-	mt[1].x |= ((pkt[4] & 0x80) << 3);
-	mt[1].x |= ((pkt[4] & 0x3F) << 4);
-	mt[1].y = ((pkt[5] & 0x80) << 3);
-	mt[1].y |= ((pkt[5] & 0x3F) << 4);
+	if (!pt_attr->is_init_pt_got && pt->z != 0) {
+		pt_attr->is_init_pt_got = 1;
+		pt_attr->is_counted = 0;
+		memcpy(&pt_attr->init_pt, pt, sizeof(pt_attr->init_pt));
+	}
 
-	switch (pkt_id) {
-	case V7_PACKET_ID_TWO:
-		mt[1].x &= ~0x000F;
-		mt[1].y |= 0x000F;
-		break;
+	if (pt->z != 0) {
+		if (pt->y < priv->resting_zone_y_min) {
+			/* A finger is recognized as
+			a non-resting finger if it's
+			position is outside the resting finger zone.*/
+			pt_attr->zone = ZONE_NORMAL;
+			pt_attr->is_counted = 1;
+		} else {
+			/* A finger is recognized as
+			a resting finger if it's position
+			is inside the resting finger zone and
+			there's no large movement
+			from it's touch down position.*/
+			pt_attr->zone = ZONE_RESTING;
+
+			if (pt->x > priv->x_max / 2)
+				pt_attr->zone |= ZONE_RIGHT_BTN;
+			else
+				pt_attr->zone |= ZONE_LEFT_BTN;
+
+			/* A resting finger will turn to
+			be a non-resting finger if it
+			has made large movement from it's touch down position. A
+			non-resting finger will never turn to
+			a resting finger before
+			it leaves the touchpad surface.*/
+			if (pt_attr->is_init_pt_got) {
+				dist = alps_pt_distance(pt, &pt_attr->init_pt);
+
+				if (dist > V7_LARGE_MOVEMENT)
+					pt_attr->is_counted = 1;
+			}
+		}
+	}
+}
 
-	case V7_PACKET_ID_MULTI:
-		mt[1].x &= ~0x003F;
-		mt[1].y &= ~0x0020;
-		mt[1].y |= ((pkt[4] & 0x02) << 4);
-		mt[1].y |= 0x001F;
-		break;
+static void alps_set_pt_attr_v7(struct psmouse *psmouse,
+				       struct alps_fields *f)
+{
+	struct alps_data *priv = psmouse->private;
+	int i;
 
-	case V7_PACKET_ID_NEW:
-		mt[1].x &= ~0x003F;
-		mt[1].x |= (pkt[0] & 0x20);
-		mt[1].y |= 0x000F;
+	switch (priv->r.v7.pkt_id) {
+	case  V7_PACKET_ID_TWO:
+	case  V7_PACKET_ID_MULTI:
+		for (i = 0; i < V7_IMG_PT_NUM; i++)
+			alps_set_each_pt_attr_v7(psmouse,
+						 &f->pt_img[i],
+						 &priv->pt_attr[i]);
+		break;
+	default:
+		/*All finger attributes are cleared
+		when packet ID is 'IDLE', 'New'or
+		other unknown IDs. An 'IDLE' packet indicates
+		that there's no finger and no button activity.
+		A 'NEW' packet indicates the finger position
+		in packet is not continues from previous packet.
+		Such as the condition there's finger placed or lifted.
+		In these cases, finger attributes will be reset.*/
+
+		memset(priv->pt_attr, 0,
+			sizeof(priv->pt_attr[0]) * V7_IMG_PT_NUM);
 		break;
 	}
-
-	mt[0].y = 0x7FF - mt[0].y;
-	mt[1].y = 0x7FF - mt[1].y;
 }
 
-static int alps_get_mt_count(struct input_mt_pos *mt)
+static void alps_cal_output_finger_num_v7(struct psmouse *psmouse,
+					struct alps_fields *f)
 {
+	struct alps_data *priv = psmouse->private;
+	unsigned int fn = 0;
 	int i;
 
-	for (i = 0; i < MAX_TOUCHES && mt[i].x != 0 && mt[i].y != 0; i++)
-		/* empty */;
+	switch (priv->r.v7.pkt_id) {
+	case V7_PACKET_ID_IDLE:
+	case V7_PACKET_ID_NEW:
+		/*No finger is reported when packet ID is
+		'IDLE' or 'New'. An 'IDLE' packet indicates
+		that there's no finger on touchpad.
+		A 'NEW' packet indicates there's finger placed
+		or lifted. Finger position of 'New' packet is
+		not continues from the previous packet.*/
+		fn = 0;
+		break;
+	case V7_PACKET_ID_TWO:
+		if (f->pt_img[0].z == 0) {
+			/*The first finger slot is zero when
+			a non-resting finger lifted and remaining
+			only one resting finger on touchpad.
+			Hardware report the remaining resting finger
+			in second slot.This resting is ignored*/
+			fn = 0;
+		} else if (f->pt_img[1].z == 0) {
+			/* The second finger slot is zero
+			if there's only one finger*/
+			fn = 1;
+		} else {
+			/*All non-resting fingers will be counted to report*/
+			fn = 0;
+			for (i = 0; i < V7_IMG_PT_NUM; i++) {
+				if (priv->pt_attr[i].is_counted)
+					fn++;
+			}
+
+			/*In the case that both fingers are
+			resting fingers, report the first one*/
+			if (!priv->pt_attr[0].is_counted &&
+			    !priv->pt_attr[1].is_counted) {
+				fn = 1;
+			}
+		}
+		break;
+	case V7_PACKET_ID_MULTI:
+		/*A packet ID 'MULTI' indicats that at least 3 non-resting
+		finger exist.*/
+		fn = 3 + priv->r.v7.additional_fingers;
+		break;
+	}
 
-	return i;
+	f->fingers = fn;
 }
 
-static int alps_decode_packet_v7(struct alps_fields *f,
-				  unsigned char *p,
-				  struct psmouse *psmouse)
+static void alps_assign_buttons_v7(struct psmouse *psmouse,
+				   struct alps_fields *f)
 {
-	unsigned char pkt_id;
+	struct alps_data *priv = psmouse->private;
 
-	pkt_id = alps_get_packet_id_v7(p);
-	if (pkt_id == V7_PACKET_ID_IDLE)
-		return 0;
-	if (pkt_id == V7_PACKET_ID_UNKNOWN)
-		return -1;
+	/* It's ClickPad */
+	if (priv->flags & ALPS_BTNLESS) {
+		if (!f->btn.middle)
+			goto exit;
+
+		f->btn.middle = 0;
+		if (priv->prev_btn.left || priv->prev_btn.middle ||
+			priv->prev_btn.right) {
+			memcpy(&f->btn, &priv->prev_btn,
+				sizeof(struct alps_btn));
+			goto exit;
+		}
 
-	alps_get_finger_coordinate_v7(f->mt, p, pkt_id);
+		if (priv->r.v7.rest_right ||
+		    priv->pt_attr[0].zone & ZONE_RIGHT_BTN ||
+		    priv->pt_attr[1].zone & ZONE_RIGHT_BTN) {
+			f->btn.right = 1;
+		} else {
+			f->btn.left = 1;
+		}
 
-	if (pkt_id == V7_PACKET_ID_TWO || pkt_id == V7_PACKET_ID_MULTI) {
-		f->left = (p[0] & 0x80) >> 7;
-		f->right = (p[0] & 0x20) >> 5;
-		f->middle = (p[0] & 0x10) >> 4;
+		goto exit;
 	}
 
-	if (pkt_id == V7_PACKET_ID_TWO)
-		f->fingers = alps_get_mt_count(f->mt);
-	else if (pkt_id == V7_PACKET_ID_MULTI)
-		f->fingers = 3 + (p[5] & 0x03);
+	/* It's Standard, do nothing */
 
-	return 0;
+exit:
+	memcpy(&priv->prev_btn, &f->btn, sizeof(struct alps_btn));
 }
 
 static void alps_process_trackstick_packet_v7(struct psmouse *psmouse)
@@ -962,21 +1740,9 @@ static void alps_process_trackstick_packet_v7(struct psmouse *psmouse)
 	struct input_dev *dev2 = priv->dev2;
 	int x, y, z, left, right, middle;
 
-	/*
-	 *        b7 b6 b5 b4 b3 b2 b1 b0
-	 * Byte0   0  1  0  0  1  0  0  0
-	 * Byte1   1  1  *  *  1  M  R  L
-	 * Byte2  X7  1 X5 X4 X3 X2 X1 X0
-	 * Byte3  Z6  1 Y6 X6  1 Y2 Y1 Y0
-	 * Byte4  Y7  0 Y5 Y4 Y3  1  1  0
-	 * Byte5 T&P  0 Z5 Z4 Z3 Z2 Z1 Z0
-	 * M / R / L: Middle / Right / Left button
-	 */
-
-	x = ((packet[2] & 0xbf)) | ((packet[3] & 0x10) << 2);
-	y = (packet[3] & 0x07) | (packet[4] & 0xb8) |
-	    ((packet[3] & 0x20) << 1);
-	z = (packet[5] & 0x3f) | ((packet[3] & 0x80) >> 1);
+	x = ((packet[2] & 0xBF)) | ((packet[3] & 0x10) << 2);
+	y = (packet[3] & 0x03) | (packet[4] & 0xB8) | ((packet[3] & 0x20) << 1);
+	z = (packet[5] & 0x3F) | ((packet[3] & 0x80) >> 1);
 
 	left = (packet[1] & 0x01);
 	right = (packet[1] & 0x02) >> 1;
@@ -996,35 +1762,115 @@ static void alps_process_trackstick_packet_v7(struct psmouse *psmouse)
 static void alps_process_touchpad_packet_v7(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
-	struct input_dev *dev = psmouse->dev;
-	struct alps_fields *f = &priv->f;
+	struct alps_fields f = {0};
+	unsigned char *packet = psmouse->packet;
 
-	memset(f, 0, sizeof(*f));
+	priv->decode_fields(&f, packet, psmouse);
 
-	if (priv->decode_fields(f, psmouse->packet, psmouse))
+	if (alps_drop_unsupported_packet_v7(psmouse))
 		return;
 
-	alps_report_mt_data(psmouse, alps_get_mt_count(f->mt));
+	alps_set_pt_attr_v7(psmouse, &f);
 
-	input_mt_report_finger_count(dev, f->fingers);
+	alps_cal_output_finger_num_v7(psmouse, &f);
 
-	input_report_key(dev, BTN_LEFT, f->left);
-	input_report_key(dev, BTN_RIGHT, f->right);
-	input_report_key(dev, BTN_MIDDLE, f->middle);
+	alps_assign_buttons_v7(psmouse, &f);
 
-	input_sync(dev);
+	alps_report_coord_and_btn(psmouse, &f);
 }
 
 static void alps_process_packet_v7(struct psmouse *psmouse)
 {
 	unsigned char *packet = psmouse->packet;
 
-	if (packet[0] == 0x48 && (packet[4] & 0x47) == 0x06)
+	if ((packet[0] == 0x48) && ((packet[4] & 0x47) == 0x06))
 		alps_process_trackstick_packet_v7(psmouse);
 	else
 		alps_process_touchpad_packet_v7(psmouse);
 }
 
+static void alps_process_packet_ss4(struct psmouse *psmouse)
+{
+	struct alps_data *priv = psmouse->private;
+	unsigned char *packet = psmouse->packet;
+	struct input_dev *dev = psmouse->dev;
+	struct alps_fields f;
+	struct alps_abs_data output_data[5];
+	unsigned char output_fn;
+
+	memset(&f, 0, sizeof(struct alps_fields));
+	priv->decode_fields(&f, packet, psmouse);
+
+	if (priv->multi_packet) {
+		/*
+		 * Sometimes the first packet will indicate a multi-packet
+		 * sequence, but sometimes the next multi-packet would not come.
+		 * Check for this, and when it happens process the
+		 * position packet as usual.
+		 */
+		if (f.is_mp) {
+			/* Now process the 1st packet */
+			priv->decode_fields(&f, priv->multi_data, psmouse);
+		} else {
+			priv->multi_packet = 0;
+		}
+	}
+
+	/*
+	 * "f.is_mp" would always be '0' after merging the 1st and 2nd packet.
+	 * When it is set, it means 2nd packet comes without 1st packet come.
+	 */
+	if (f.is_mp)
+		return;
+
+	/* Save the first packet */
+	if (!priv->multi_packet && f.first_mp) {
+		priv->multi_packet = 1;
+		memcpy(priv->multi_data, packet, sizeof(priv->multi_data));
+		return;
+	}
+
+	priv->multi_packet = 0;
+
+	/* Set "output_data" and "output_fn" */
+	memset(&output_data[0], 0, sizeof(output_data));
+	if (priv->flags & ALPS_BTNLESS) {
+		alps_process_resting_finger(psmouse, &f,
+			output_data, &output_fn);
+		alps_process_btnless_click(psmouse, &f);
+	} else {
+		memcpy(&output_data[0], &f.pt_img[0],
+			sizeof(struct alps_abs_data) * f.fingers);
+		output_fn = f.fingers;
+	}
+
+	f.pt.x = output_data[0].x;
+	f.pt.y = output_data[0].y;
+	f.pt.z = output_data[0].z;
+
+	if (output_data[0].z || output_data[1].z ||
+		output_data[2].z || output_data[3].z)
+		input_report_key(dev, BTN_TOUCH, 1);
+	else
+		input_report_key(dev, BTN_TOUCH, 0);
+
+	alps_report_semi_mt_data_ex(dev, 4, output_data);
+
+	input_mt_report_finger_count(dev, output_fn);
+
+	input_report_key(dev, BTN_LEFT, f.btn.left);
+	input_report_key(dev, BTN_RIGHT, f.btn.right);
+	input_report_key(dev, BTN_MIDDLE, f.btn.middle);
+
+	if (f.pt.z > 0) {
+		input_report_abs(dev, ABS_X, f.pt.x);
+		input_report_abs(dev, ABS_Y, f.pt.y);
+	}
+	input_report_abs(dev, ABS_PRESSURE, f.pt.z);
+
+	input_sync(dev);
+}
+
 static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 					unsigned char packet[],
 					bool report_buttons)
@@ -1152,11 +1998,22 @@ static void alps_flush_packet(unsigned long data)
 	serio_continue_rx(psmouse->ps2dev.serio);
 }
 
+static bool alps_is_valid_package_ss4(struct psmouse *psmouse)
+{
+	if (psmouse->pktcnt == 4 && ((psmouse->packet[3] & 0x08) != 0x08))
+		return false;
+	if (psmouse->pktcnt == 6 && ((psmouse->packet[5] & 0x10) != 0x0))
+		return false;
+	return true;
+}
+
 static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
 
-	if ((psmouse->packet[0] & 0xc8) == 0x08) { /* PS/2 packet */
+	/* Can not distinguish V8's first byte from PS/2 packet's */
+	if ((psmouse->packet[0] & 0xc8) == 0x08 &&
+			priv->proto_version != ALPS_PROTO_V8) {
 		if (psmouse->pktcnt == 3) {
 			alps_report_bare_ps2_packet(psmouse, psmouse->packet,
 						    true);
@@ -1189,8 +2046,10 @@ static psmouse_ret_t alps_process_byte(struct psmouse *psmouse)
 		return PSMOUSE_BAD_DATA;
 	}
 
-	if (priv->proto_version == ALPS_PROTO_V7 &&
-	    !alps_is_valid_package_v7(psmouse)) {
+	if ((priv->proto_version == ALPS_PROTO_V7 &&
+		!alps_is_valid_package_v7(psmouse)) ||
+		(priv->proto_version == ALPS_PROTO_V8 &&
+		!alps_is_valid_package_ss4(psmouse))) {
 		psmouse_dbg(psmouse, "refusing packet[%i] = %x\n",
 			    psmouse->pktcnt - 1,
 			    psmouse->packet[psmouse->pktcnt - 1]);
@@ -1309,20 +2168,20 @@ static int alps_rpt_cmd(struct psmouse *psmouse, int init_command,
 	return 0;
 }
 
-static bool alps_check_valid_firmware_id(unsigned char id[])
+static int alps_check_valid_firmware_id(unsigned char id[])
 {
-	if (id[0] == 0x73)
-		return true;
+	int valid = 1;
 
-	if (id[0] == 0x88 &&
-	    (id[1] == 0x07 ||
-	     id[1] == 0x08 ||
-	     (id[1] & 0xf0) == 0xb0 ||
-	     (id[1] & 0xf0) == 0xc0)) {
-		return true;
+	if (id[0] == 0x73)
+		valid = 1;
+	else if (id[0] == 0x88) {
+		if ((id[1] == 0x07) ||
+		    (id[1] == 0x08) ||
+		    ((id[1] & 0xf0) == 0xB0))
+			valid = 1;
 	}
 
-	return false;
+	return valid;
 }
 
 static int alps_enter_command_mode(struct psmouse *psmouse)
@@ -1792,45 +2651,6 @@ error:
 	return -1;
 }
 
-static int alps_get_v3_v7_resolution(struct psmouse *psmouse, int reg_pitch)
-{
-	int reg, x_pitch, y_pitch, x_electrode, y_electrode, x_phys, y_phys;
-	struct alps_data *priv = psmouse->private;
-
-	reg = alps_command_mode_read_reg(psmouse, reg_pitch);
-	if (reg < 0)
-		return reg;
-
-	x_pitch = (char)(reg << 4) >> 4; /* sign extend lower 4 bits */
-	x_pitch = 50 + 2 * x_pitch; /* In 0.1 mm units */
-
-	y_pitch = (char)reg >> 4; /* sign extend upper 4 bits */
-	y_pitch = 36 + 2 * y_pitch; /* In 0.1 mm units */
-
-	reg = alps_command_mode_read_reg(psmouse, reg_pitch + 1);
-	if (reg < 0)
-		return reg;
-
-	x_electrode = (char)(reg << 4) >> 4; /* sign extend lower 4 bits */
-	x_electrode = 17 + x_electrode;
-
-	y_electrode = (char)reg >> 4; /* sign extend upper 4 bits */
-	y_electrode = 13 + y_electrode;
-
-	x_phys = x_pitch * (x_electrode - 1); /* In 0.1 mm units */
-	y_phys = y_pitch * (y_electrode - 1); /* In 0.1 mm units */
-
-	priv->x_res = priv->x_max * 10 / x_phys; /* units / mm */
-	priv->y_res = priv->y_max * 10 / y_phys; /* units / mm */
-
-	psmouse_dbg(psmouse,
-		    "pitch %dx%d num-electrodes %dx%d physical size %dx%d mm res %dx%d\n",
-		    x_pitch, y_pitch, x_electrode, y_electrode,
-		    x_phys / 10, y_phys / 10, priv->x_res, priv->y_res);
-
-	return 0;
-}
-
 static int alps_hw_init_rushmore_v3(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
@@ -1851,9 +2671,6 @@ static int alps_hw_init_rushmore_v3(struct psmouse *psmouse)
 	    alps_command_mode_write_reg(psmouse, 0xc2cb, 0x00))
 		goto error;
 
-	if (alps_get_v3_v7_resolution(psmouse, 0xc2da))
-		goto error;
-
 	reg_val = alps_command_mode_read_reg(psmouse, 0xc2c6);
 	if (reg_val == -1)
 		goto error;
@@ -1878,6 +2695,32 @@ error:
 	return ret;
 }
 
+static int alps_hw_init_v7(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	int reg_val, ret = -1;
+
+	if (alps_enter_command_mode(psmouse) ||
+	    alps_command_mode_read_reg(psmouse, 0xc2d9) == -1)
+		goto error;
+
+	if (alps_command_mode_write_reg(psmouse, 0xc2c9, 0x64))
+		goto error;
+
+	reg_val = alps_command_mode_read_reg(psmouse, 0xc2c4);
+	if (reg_val == -1)
+		goto error;
+	if (__alps_command_mode_write_reg(psmouse, reg_val | 0x02))
+		goto error;
+
+	alps_exit_command_mode(psmouse);
+	return ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
+
+error:
+	alps_exit_command_mode(psmouse);
+	return ret;
+}
+
 /* Must be in command mode when calling this function */
 static int alps_absolute_mode_v4(struct psmouse *psmouse)
 {
@@ -1967,6 +2810,102 @@ error:
 	return -1;
 }
 
+static int alps_get_otp_values_ss4(struct psmouse *psmouse,
+	unsigned char index, unsigned char otp[])
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+
+	switch (index) {
+	case 0:
+		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM)  ||
+		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM)  ||
+		    ps2_command(ps2dev, otp, PSMOUSE_CMD_GETINFO))
+			return -1;
+
+		break;
+
+	case 1:
+		if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL)  ||
+		    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETPOLL)  ||
+		    ps2_command(ps2dev, otp, PSMOUSE_CMD_GETINFO))
+			return -1;
+
+		break;
+	}
+
+	return 0;
+}
+
+int alps_update_device_area_ss4_v1(
+	unsigned char otp[][4], struct alps_data *priv)
+{
+	int	num_x_electrode;
+	int	num_y_electrode;
+
+	num_x_electrode = SS4_NUMSENSOR_XOFFSET + (otp[1][0]		& 0x0F);
+	num_y_electrode = ((otp[1][0] >> 4)	& 0x0F);
+
+	priv->x_max = (num_x_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
+	priv->y_max = (num_y_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
+
+	return 0;
+}
+
+int alps_update_device_area_ss4_v2(
+	unsigned char otp[][4], struct alps_data *priv)
+{
+	int	num_x_electrode;
+	int	num_y_electrode;
+
+	num_x_electrode = SS4_NUMSENSOR_XOFFSET + (otp[1][0] & 0x0F);
+	if ((priv->fw_ver[1] > 2) ||
+		(priv->fw_ver[1] == 2 && priv->fw_ver[2] > 0x33)) {
+		num_y_electrode =
+			SS4_NUMSENSOR_YOFFSET + ((otp[1][0] >> 4) & 0x07);
+	} else {
+		num_y_electrode = ((otp[1][0] >> 4) & 0x0F);
+	}
+
+	priv->x_max = (num_x_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
+	priv->y_max = (num_y_electrode - 1) * SS4_COUNT_PER_ELECTRODE;
+
+	return 0;
+}
+
+int alps_update_btn_info_ss4(unsigned char otp[][4], struct alps_data *priv)
+{
+
+	unsigned char is_btnless = 0;
+
+	is_btnless = (otp[1][1] >> 3) &  0x01;
+
+	if (is_btnless)
+		priv->flags |= ALPS_BTNLESS;
+
+	return 0;
+}
+
+static int alps_set_defaults_ss4(struct psmouse *psmouse,
+					struct alps_data *priv)
+{
+	unsigned char otp[2][4];
+
+	memset(otp, 0, sizeof(otp));
+
+	if (alps_get_otp_values_ss4(psmouse, 0, &otp[0][0]) ||
+	    alps_get_otp_values_ss4(psmouse, 1, &otp[1][0]))
+		return -1;
+
+	if (priv->fw_ver[1] >= 2)
+		alps_update_device_area_ss4_v2(otp, priv);
+	else
+		alps_update_device_area_ss4_v1(otp, priv);
+
+	alps_update_btn_info_ss4(otp, priv);
+
+	return 0;
+}
+
 static int alps_dolphin_get_device_area(struct psmouse *psmouse,
 					struct alps_data *priv)
 {
@@ -2030,28 +2969,54 @@ static int alps_hw_init_dolphin_v1(struct psmouse *psmouse)
 	return 0;
 }
 
-static int alps_hw_init_v7(struct psmouse *psmouse)
+static int alps_hw_init_ss3(struct psmouse *psmouse)
 {
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
-	int reg_val, ret = -1;
+	unsigned char	f3param0 = 0x00,
+					f3param1 = 0x00;
 
-	if (alps_enter_command_mode(psmouse) ||
-	    alps_command_mode_read_reg(psmouse, 0xc2d9) == -1)
+	if (alps_enter_command_mode(psmouse))
 		goto error;
 
-	if (alps_get_v3_v7_resolution(psmouse, 0xc397))
+	/* Set to 2 pt-mode */
+	f3param0 = 0x50;
+	f3param1 = 0x3c;
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+	    ps2_command(ps2dev, &f3param0, PSMOUSE_CMD_SETRATE) ||
+	    ps2_command(ps2dev, &f3param1, PSMOUSE_CMD_SETRATE))
 		goto error;
 
-	if (alps_command_mode_write_reg(psmouse, 0xc2c9, 0x64))
-		goto error;
+	/* output APDATA when 1 finger is in resting area */
+	f3param0 = 0xc8;
+	f3param1 = 0x28;
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+	    ps2_command(ps2dev, &f3param0, PSMOUSE_CMD_SETRATE) ||
+	    ps2_command(ps2dev, &f3param1, PSMOUSE_CMD_SETRATE))
+			goto error;
 
-	reg_val = alps_command_mode_read_reg(psmouse, 0xc2c4);
-	if (reg_val == -1)
-		goto error;
-	if (__alps_command_mode_write_reg(psmouse, reg_val | 0x02))
+	return 0;
+
+error:
+	return -1;
+}
+
+
+static int alps_hw_init_ss4(struct psmouse *psmouse)
+{
+	struct ps2dev *ps2dev = &psmouse->ps2dev;
+	char param[2] = {0x64, 0x28};
+	int ret = -1;
+
+	/* enter absolute mode */
+	if (ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+	    ps2_command(ps2dev, NULL, PSMOUSE_CMD_SETSTREAM) ||
+	    ps2_command(ps2dev, &param[0], PSMOUSE_CMD_SETRATE) ||
+	    ps2_command(ps2dev, &param[1], PSMOUSE_CMD_SETRATE)) {
 		goto error;
+	}
 
-	alps_exit_command_mode(psmouse);
 	return ps2_command(ps2dev, NULL, PSMOUSE_CMD_ENABLE);
 
 error:
@@ -2078,6 +3043,7 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->set_abs_params = alps_set_abs_params_st;
 		priv->x_max = 1023;
 		priv->y_max = 767;
+		priv->slot_number = 1;
 		break;
 	case ALPS_PROTO_V3:
 		priv->hw_init = alps_hw_init_v3;
@@ -2086,6 +3052,7 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->decode_fields = alps_decode_pinnacle;
 		priv->nibble_commands = alps_v3_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
+		priv->slot_number = 2;
 		break;
 	case ALPS_PROTO_V4:
 		priv->hw_init = alps_hw_init_v4;
@@ -2093,6 +3060,7 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->set_abs_params = alps_set_abs_params_mt;
 		priv->nibble_commands = alps_v4_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_DISABLE;
+		priv->slot_number = 2;
 		break;
 	case ALPS_PROTO_V5:
 		priv->hw_init = alps_hw_init_dolphin_v1;
@@ -2108,6 +3076,7 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->y_max = 660;
 		priv->x_bits = 23;
 		priv->y_bits = 12;
+		priv->slot_number = 2;
 		break;
 	case ALPS_PROTO_V6:
 		priv->hw_init = alps_hw_init_v6;
@@ -2116,6 +3085,7 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->nibble_commands = alps_v6_nibble_commands;
 		priv->x_max = 2047;
 		priv->y_max = 1535;
+		priv->slot_number = 1;
 		break;
 	case ALPS_PROTO_V7:
 		priv->hw_init = alps_hw_init_v7;
@@ -2129,8 +3099,44 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->byte0 = 0x48;
 		priv->mask0 = 0x48;
 
-		if (priv->fw_ver[1] != 0xba)
-			priv->flags |= ALPS_BUTTONPAD;
+		if (priv->fw_ver[1] == 0xBA) {
+			priv->flags = 0;
+			/* No resting finger area */
+			priv->resting_zone_y_min = priv->y_max;
+		} else {
+			priv->flags = ALPS_BTNLESS;
+			priv->resting_zone_y_min = 0x654;
+		}
+
+		priv->slot_number = 2;
+		break;
+	case ALPS_PROTO_V8:
+		if (priv->fw_ver[1] >= 2)
+			priv->decode_fields = alps_decode_ss4_v2;
+		else
+			priv->decode_fields = alps_decode_ss4_v1;
+
+		priv->hw_init = alps_hw_init_ss4;
+		priv->process_packet = alps_process_packet_ss4;
+		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->nibble_commands = alps_v3_nibble_commands;
+		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
+		priv->x_max = 0xfff;
+		priv->y_max = 0x7ff;
+		priv->byte0 = 0x18;
+		priv->mask0 = 0x18;
+		priv->flags = 0;
+		priv->slot_number = 4;
+		break;
+	case ALPS_PROTO_V9:
+		priv->hw_init = alps_hw_init_ss3;
+		priv->process_packet = alps_process_touchpad_packet_ss3;
+		priv->decode_fields = alps_decode_dolphin;
+		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->nibble_commands = alps_v3_nibble_commands;
+		priv->byte0 = 0xc8;
+		priv->mask0 = 0xc8;
+		priv->slot_number = 2;
 		break;
 	}
 }
@@ -2204,7 +3210,7 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 		else
 			return 0;
 	} else if (ec[0] == 0x88 &&
-		   ((ec[1] & 0xf0) == 0xb0 || (ec[1] & 0xf0) == 0xc0)) {
+		((ec[1] & 0xf0) == 0xB0 || (ec[1] & 0xf0) == 0xC0)) {
 		priv->proto_version = ALPS_PROTO_V7;
 		alps_set_defaults(priv);
 
@@ -2217,7 +3223,6 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 		priv->decode_fields = alps_decode_rushmore;
 		priv->x_bits = 16;
 		priv->y_bits = 12;
-		priv->flags |= ALPS_IS_RUSHMORE;
 
 		/* hack to make addr_command, nibble_command available */
 		psmouse->private = priv;
@@ -2232,6 +3237,22 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 		alps_set_defaults(priv);
 
 		return 0;
+	} else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0x14) {
+		priv->proto_version = ALPS_PROTO_V8;
+		alps_set_defaults(priv);
+
+		if (alps_set_defaults_ss4(psmouse, priv))
+			return -EIO;
+
+		return 0;
+	} else if (e7[0] == 0x73 && e7[1] == 0x03 && e7[2] == 0xc8) {
+		priv->proto_version = ALPS_PROTO_V9;
+		alps_set_defaults(priv);
+
+		if (alps_dolphin_get_device_area(psmouse, priv))
+			return -EIO;
+
+		return 0;
 	}
 
 	psmouse_info(psmouse,
@@ -2272,21 +3293,17 @@ static void alps_set_abs_params_st(struct alps_data *priv,
 static void alps_set_abs_params_mt(struct alps_data *priv,
 				   struct input_dev *dev1)
 {
+	set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
+	input_mt_init_slots(dev1, priv->slot_number, 0);
 	input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
 	input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
 
-	input_abs_set_res(dev1, ABS_MT_POSITION_X, priv->x_res);
-	input_abs_set_res(dev1, ABS_MT_POSITION_Y, priv->y_res);
-
-	input_mt_init_slots(dev1, MAX_TOUCHES, INPUT_MT_POINTER |
-		INPUT_MT_DROP_UNUSED | INPUT_MT_TRACK | INPUT_MT_SEMI_MT);
-
+	set_bit(BTN_TOOL_DOUBLETAP, dev1->keybit);
 	set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
 	set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
 
-	/* V7 is real multi-touch */
-	if (priv->proto_version == ALPS_PROTO_V7)
-		clear_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
+	input_set_abs_params(dev1, ABS_X, 0, priv->x_max, 0, 0);
+	input_set_abs_params(dev1, ABS_Y, 0, priv->y_max, 0, 0);
 }
 
 int alps_init(struct psmouse *psmouse)
@@ -2332,9 +3349,7 @@ int alps_init(struct psmouse *psmouse)
 	dev1->evbit[BIT_WORD(EV_ABS)] |= BIT_MASK(EV_ABS);
 
 	priv->set_abs_params(priv, dev1);
-	/* No pressure on V7 */
-	if (priv->proto_version != ALPS_PROTO_V7)
-		input_set_abs_params(dev1, ABS_PRESSURE, 0, 127, 0, 0);
+	input_set_abs_params(dev1, ABS_PRESSURE, 0, 127, 0, 0);
 
 	if (priv->flags & ALPS_WHEEL) {
 		dev1->evbit[BIT_WORD(EV_REL)] |= BIT_MASK(EV_REL);
@@ -2351,14 +3366,12 @@ int alps_init(struct psmouse *psmouse)
 		dev1->keybit[BIT_WORD(BTN_1)] |= BIT_MASK(BTN_1);
 		dev1->keybit[BIT_WORD(BTN_2)] |= BIT_MASK(BTN_2);
 		dev1->keybit[BIT_WORD(BTN_3)] |= BIT_MASK(BTN_3);
-	} else if (priv->flags & ALPS_BUTTONPAD) {
-		set_bit(INPUT_PROP_BUTTONPAD, dev1->propbit);
-		clear_bit(BTN_RIGHT, dev1->keybit);
 	} else {
 		dev1->keybit[BIT_WORD(BTN_MIDDLE)] |= BIT_MASK(BTN_MIDDLE);
 	}
 
-	snprintf(priv->phys, sizeof(priv->phys), "%s/input1", psmouse->ps2dev.serio->phys);
+	snprintf(priv->phys, sizeof(priv->phys),
+		"%s/input1", psmouse->ps2dev.serio->phys);
 	dev2->phys = priv->phys;
 	dev2->name = (priv->flags & ALPS_DUALPOINT) ?
 		     "DualPoint Stick" : "ALPS PS/2 Device";
@@ -2382,7 +3395,8 @@ int alps_init(struct psmouse *psmouse)
 	psmouse->reconnect = alps_reconnect;
 	psmouse->pktsize = priv->proto_version == ALPS_PROTO_V4 ? 8 : 6;
 
-	/* We are having trouble resyncing ALPS touchpads so disable it for now */
+	/* We are having trouble resyncing ALPS touchpads
+		so disable it for now */
 	psmouse->resync_time = 0;
 
 	return 0;
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 66240b4..55f5193 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -12,8 +12,6 @@
 #ifndef _ALPS_H
 #define _ALPS_H
 
-#include <linux/input/mt.h>
-
 #define ALPS_PROTO_V1	1
 #define ALPS_PROTO_V2	2
 #define ALPS_PROTO_V3	3
@@ -21,8 +19,17 @@
 #define ALPS_PROTO_V5	5
 #define ALPS_PROTO_V6	6
 #define ALPS_PROTO_V7	7	/* t3btl t4s */
+#define ALPS_PROTO_V8	8	/* ss4 */
+#define ALPS_PROTO_V9	9	/* ss3btl */
+
+
+#define MAX_IMG_PT_NUM		5
+#define V7_IMG_PT_NUM		2
 
-#define MAX_TOUCHES	2
+#define ZONE_NORMAL				0x01
+#define ZONE_RESTING			0x02
+#define ZONE_LEFT_BTN			0x04
+#define ZONE_RIGHT_BTN			0x08
 
 #define DOLPHIN_COUNT_PER_ELECTRODE	64
 #define DOLPHIN_PROFILE_XOFFSET		8	/* x-electrode offset */
@@ -45,6 +52,124 @@ enum V7_PACKET_ID {
 	 V7_PACKET_ID_UNKNOWN,
 };
 
+enum SS4_PACKET_ID {
+	SS4_PACKET_ID_IDLE = 0,
+	SS4_PACKET_ID_ONE,
+	SS4_PACKET_ID_TWO,
+	SS4_PACKET_ID_MULTI,
+};
+
+#define SS4_COUNT_PER_ELECTRODE			256
+#define SS4_NUMSENSOR_XOFFSET			7
+#define SS4_NUMSENSOR_YOFFSET			7
+
+/* SWC status( 0:SW OFF, 1: SW ON) */
+#define SS4_BUTTONLESS_BUTTONS	0x01
+
+#define SS4_MASK_NORMAL_BUTTONS	0x07
+
+#define SS4_1F_X_V1(_b)	(((_b[0] << 5) & 0x1E00) | \
+		((_b[0] << 6) & 0x01C0) | \
+		((_b[1] >> 2) & 0x0038) | \
+		((_b[1] >> 1) & 0x0007) \
+		)
+
+#define SS4_1F_Y_V1(_b)	(((_b[2] >> 1) & 0x007F) | \
+		((_b[4] << 5) & 0x0F80) \
+		)
+
+#define SS4_1F_Z_V1(_b)		(_b[5] & 0xFF)
+
+#define	SS4_1F_LFB(_b)		((_b[4] >> 1) & 0x01)
+
+#define SS4_BTN_V1(_b)		(_b[3] & SS4_BUTTONLESS_BUTTONS)
+
+#define SS4_STD_MF_X_V1(_b, _i)	(((_b[0 + _i * 3] >> 2) & 0x0020) | \
+		((_b[1 + _i * 3] << 5) & 0x1FC0) \
+		)
+
+#define SS4_STD_MF_Y_V1(_b, _i)	(((_b[0 + _i * 3] >> 2) & 0x0010) | \
+		((_b[2 + _i * 3] << 4) & 0x0FE0) \
+		)
+
+#define SS4_BTL_BTN_V1(_b)		(_b[3] & SS4_BUTTONLESS_BUTTONS)
+
+#define SS4_BTL_MF_X_V1(_b, _i) (SS4_STD_MF_X_V1(_b, _i) | \
+		((_b[0 + _i * 3] << 2) & 0x0010))
+
+#define SS4_BTL_MF_Y_V1(_b, _i) (SS4_STD_MF_Y_V1(_b, _i) | \
+		((_b[0 + _i * 3] << 2) & 0x0008))
+
+#define SS4_MF_Z_V1(_b, _i)		((_b[0 + _i * 3] >> 4) & 0x0003)
+
+#define SS4_IS_MF_CONTINUE_V1(_b)	((_b[0] & 0x01) == 0x01)
+#define SS4_IS_5F_DETECTED_V1(_b)	((_b[0] & 0x01) == 0x01)
+
+#define SS4_1F_X_V2(_b)	((_b[0] & 0x0007) | \
+		((_b[1] << 3) & 0x0078) | \
+		((_b[1] << 2) & 0x0380) | \
+		((_b[2] << 5) & 0x1C00) \
+		)
+
+#define SS4_1F_Y_V2(_b)	(((_b[2]) & 0x000F) | \
+		((_b[3] >> 2) & 0x0030) | \
+		((_b[4] << 6) & 0x03C0) | \
+		((_b[4] << 5) & 0x0C00) \
+		)
+
+#define SS4_1F_Z_V2(_b)	(((_b[5]) & 0x0F) | \
+		((_b[5] >> 1) & 0x70) | \
+		((_b[4]) & 0x80) \
+		)
+
+#define	SS4_1F_LFB_V2(_b)	(((_b[2] >> 4) & 0x01) == 0x01)
+
+#define	SS4_MF_LF_V2(_b, _i)	((_b[1 + _i * 3] & 0x0004) == 0x0004)
+
+#define SS4_BTN_V2(_b)		((_b[0] >> 5) & SS4_MASK_NORMAL_BUTTONS)
+
+#define SS4_STD_MF_X_V2(_b, _i)	(((_b[0 + _i * 3]  << 5) & 0x00E0) | \
+		((_b[1 + _i * 3]  << 5) & 0x1F00) \
+		)
+
+#define SS4_STD_MF_Y_V2(_b, _i)	(((_b[1 + _i * 3] << 3) & 0x0010) | \
+		((_b[2 + _i * 3] << 5) & 0x01E0) | \
+		((_b[2 + _i * 3] << 4) & 0x0E00) \
+		)
+
+#define SS4_BTL_MF_X_V2(_b, _i)	(SS4_STD_MF_X_V2(_b, _i) | \
+		((_b[0 + _i * 3] >> 3) & 0x0010))
+
+#define SS4_BTL_MF_Y_V2(_b, _i)	(SS4_STD_MF_Y_V2(_b, _i) | \
+		((_b[0 + _i * 3] >> 3) & 0x0008))
+
+#define SS4_MF_Z_V2(_b, _i)	(((_b[1 + _i * 3]) & 0x0001) | \
+		((_b[1 + _i * 3] >> 1) & 0x0002) \
+		)
+
+#define SS4_IS_MF_CONTINUE_V2(_b)	((_b[2] & 0x10) == 0x10)
+#define SS4_IS_5F_DETECTED_V2(_b)	((_b[2] & 0x10) == 0x10)
+
+
+#define SS4_MFPACKET_NO_AX		8160	/* X-Coordinate value */
+#define SS4_MFPACKET_NO_AY		4080	/* Y-Coordinate value */
+#define SS4_MFPACKET_NO_AX_BL	8176	/* Buttonless X-Coordinate value */
+#define SS4_MFPACKET_NO_AY_BL	4088	/* Buttonless Y-Coordinate value */
+
+/* Threshold for resting finger's large movement */
+#define RESTING_FN_LARGE_MOVEMENT	50
+
+#define PT_IN_LEFT_BTN_AREA(_x, _y, _x_max, _y_max)
+		(((_x) < (_x_max)/2) && ((_y) > (_y_max)*4/5))
+
+#define PT_IN_RIGHT_BTN_AREA(_x, _y, _x_max, _y_max)
+		(((_x) >= (_x_max)/2) && ((_y) > (_y_max)*4/5))
+
+#define PT_IN_BTN_AREA(_x, _y, _x_max, _y_max)
+		(PT_IN_LEFT_BTN_AREA(_x, _y, _x_max, _y_max) ||
+		PT_IN_RIGHT_BTN_AREA(_x, _y, _x_max, _y_max)
+		)
+
 /**
  * struct alps_model_info - touchpad ID table
  * @signature: E7 response string to match.
@@ -68,7 +193,7 @@ struct alps_model_info {
 	unsigned char command_mode_resp;
 	unsigned char proto_version;
 	unsigned char byte0, mask0;
-	int flags;
+	unsigned int flags;
 };
 
 /**
@@ -87,47 +212,95 @@ struct alps_nibble_commands {
 	unsigned char data;
 };
 
-struct alps_bitmap_point {
-	int start_bit;
-	int num_bits;
+/**
+ * struct alps_btn - decoded version of the button status
+ * @left: Left touchpad button is active.
+ * @right: Right touchpad button is active.
+ * @middle: Middle touchpad button is active.
+ * @ts_left: Left trackstick button is active.
+ * @ts_right: Right trackstick button is active.
+ * @ts_middle: Middle trackstick button is active.
+ */
+struct alps_btn {
+	unsigned int left:1;
+	unsigned int right:1;
+	unsigned int middle:1;
+
+	unsigned int ts_left:1;
+	unsigned int ts_right:1;
+	unsigned int ts_middle:1;
+};
+
+/**
+ * struct alps_btn - decoded version of the X Y Z postion for ST.
+ * @x: X position for ST.
+ * @y: Y position for ST.
+ * @z: Z position for ST.
+ */
+struct alps_abs_data {
+	unsigned int x;
+	unsigned int y;
+	unsigned int z;
+};
+
+enum dol_Packet {
+	DOL_UNKNOWN,
+	DOL_GPDATA,
+	DOL_PROFDATA,
+	DOL_APDATA
 };
 
 /**
  * struct alps_fields - decoded version of the report packet
+ * @fingers: Number of fingers for MT.
+ * @pt: X Y Z postion for ST.
+ * @pt: X Y Z postion for image MT.
  * @x_map: Bitmap of active X positions for MT.
  * @y_map: Bitmap of active Y positions for MT.
- * @fingers: Number of fingers for MT.
- * @pressure: Pressure.
- * @st: position for ST.
- * @mt: position for MT.
  * @first_mp: Packet is the first of a multi-packet report.
  * @is_mp: Packet is part of a multi-packet report.
- * @left: Left touchpad button is active.
- * @right: Right touchpad button is active.
- * @middle: Middle touchpad button is active.
- * @ts_left: Left trackstick button is active.
- * @ts_right: Right trackstick button is active.
- * @ts_middle: Middle trackstick button is active.
+ * @btn: Button activity status
  */
 struct alps_fields {
+	unsigned int fingers;
+	struct alps_abs_data pt;
+	struct alps_abs_data pt_img[MAX_IMG_PT_NUM];
 	unsigned int x_map;
 	unsigned int y_map;
-	unsigned int fingers;
-
-	int pressure;
-	struct input_mt_pos st;
-	struct input_mt_pos mt[MAX_TOUCHES];
-
+	unsigned int large_fn;
 	unsigned int first_mp:1;
 	unsigned int is_mp:1;
+	enum dol_Packet	dol_packet_type;
+	struct alps_btn btn;
+};
 
-	unsigned int left:1;
-	unsigned int right:1;
-	unsigned int middle:1;
+/**
+ * struct v7_raw - data decoded from raw packet for V7.
+ * @pkt_id: An id that specifies the type of packet.
+ * @additional_fingers: Number of additional finger that is neighter included
+ *  in pt slot nor reflected in rest_left and rest_right flag of data packet.
+ * @rest_left: There are fingers on left resting zone.
+ * @rest_right: There are fingers on right resting zone.
+ */
+struct v7_raw {
+	unsigned char pkt_id;
+	unsigned int additional_fingers;
+	unsigned char rest_left;
+	unsigned char rest_right;
+};
 
-	unsigned int ts_left:1;
-	unsigned int ts_right:1;
-	unsigned int ts_middle:1;
+/**
+ * struct alps_bl_pt_attr - generic attributes of touch points for buttonless device
+ * @zone: The part of touchpad that the touch point locates
+ * @is_counted: The touch point is not a resting finger.
+ * @is_init_pt_got: The touch down point is got.
+ * @init_pt: The X Y Z position of the touch down point.
+ */
+struct alps_bl_pt_attr {
+	unsigned char zone;
+	unsigned char is_counted;
+	unsigned char is_init_pt_got;
+	struct alps_abs_data init_pt;
 };
 
 /**
@@ -142,12 +315,13 @@ struct alps_fields {
  *   known format for this model.  The first byte of the report, ANDed with
  *   mask0, should match byte0.
  * @mask0: The mask used to check the first byte of the report.
- * @fw_ver: cached copy of firmware version (EC report)
  * @flags: Additional device capabilities (passthrough port, trackstick, etc.).
  * @x_max: Largest possible X position value.
  * @y_max: Largest possible Y position value.
+ * @resting_zone_y_min: Smallest Y postion value of the bottom resting zone.
  * @x_bits: Number of X bits in the MT bitmap.
  * @y_bits: Number of Y bits in the MT bitmap.
+ * @img_fingers: Number of image fingers.
  * @hw_init: Protocol-specific hardware init function.
  * @process_packet: Protocol-specific function to process a report packet.
  * @decode_fields: Protocol-specific function to read packet bitfields.
@@ -155,9 +329,18 @@ struct alps_fields {
  * @prev_fin: Finger bit from previous packet.
  * @multi_packet: Multi-packet data in progress.
  * @multi_data: Saved multi-packet data.
- * @f: Decoded packet data fields.
+ * @x1: First X coordinate from last MT report.
+ * @x2: Second X coordinate from last MT report.
+ * @y1: First Y coordinate from last MT report.
+ * @y2: Second Y coordinate from last MT report.
+ * @fingers: Number of fingers from last MT report.
  * @quirks: Bitmap of ALPS_QUIRK_*.
  * @timer: Timer for flushing out the final report packet in the stream.
+ * @v7: Data decoded from raw packet for V7
+ * @phy_btn: Physical button is active.
+ * @prev_phy_btn: Physical button of previous packet is active.
+ * @pressed_btn_bits: Pressed positon of button zone
+ * @pt_attr: Generic attributes of touch points for buttonless device.
  */
 struct alps_data {
 	struct input_dev *dev2;
@@ -168,27 +351,35 @@ struct alps_data {
 	int addr_command;
 	unsigned char proto_version;
 	unsigned char byte0, mask0;
+	unsigned int flags;
 	unsigned char fw_ver[3];
-	int flags;
 	int x_max;
 	int y_max;
+	int resting_zone_y_min;
 	int x_bits;
 	int y_bits;
-	unsigned int x_res;
-	unsigned int y_res;
+	unsigned char slot_number;
 
 	int (*hw_init)(struct psmouse *psmouse);
 	void (*process_packet)(struct psmouse *psmouse);
-	int (*decode_fields)(struct alps_fields *f, unsigned char *p,
+	void (*decode_fields)(struct alps_fields *f, unsigned char *p,
 			      struct psmouse *psmouse);
 	void (*set_abs_params)(struct alps_data *priv, struct input_dev *dev1);
 
 	int prev_fin;
 	int multi_packet;
 	unsigned char multi_data[6];
-	struct alps_fields f;
+	int x1, x2, y1, y2;
+	int fingers;
 	u8 quirks;
 	struct timer_list timer;
+
+	/* these are used for buttonless touchpad*/
+	union {
+		struct v7_raw v7;
+	} r;
+	struct alps_btn prev_btn;
+	struct alps_bl_pt_attr pt_attr[MAX_IMG_PT_NUM];
 };
 
 #define ALPS_QUIRK_TRACKSTICK_BUTTONS	1 /* trakcstick buttons in trackstick packet */
-- 
1.9.1

