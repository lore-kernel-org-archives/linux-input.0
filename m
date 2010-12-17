From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/3 v2] input - wacom_w8001: Add one finger touch support
Date: Fri, 17 Dec 2010 09:37:54 -0800
Message-ID: <1292607474-22674-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38723 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754753Ab0LQRhS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Dec 2010 12:37:18 -0500
Received: by yxt3 with SMTP id 3so431837yxt.19
        for <linux-input@vger.kernel.org>; Fri, 17 Dec 2010 09:37:17 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/touchscreen/wacom_w8001.c |   89 ++++++++++++++++++++++++++++---
 1 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 59664a8..763eb8f 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -3,6 +3,7 @@
  *
  * Copyright (c) 2008 Jaya Kumar
  * Copyright (c) 2010 Red Hat, Inc.
+ * Copyright (c) 2010 Ping Cheng, Wacom. <pingc@wacom.com>
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License. See the file COPYING in the main directory of this archive for
@@ -86,6 +87,12 @@ struct w8001 {
 	char phys[32];
 	int type;
 	unsigned int pktlen;
+	bool pen_in_prox;
+	bool has_touch;
+	int max_touch_x;
+	int max_touch_y;
+	int max_pen_x;
+	int max_pen_y;
 };
 
 static void parse_data(u8 *data, struct w8001_coord *coord)
@@ -112,6 +119,29 @@ static void parse_data(u8 *data, struct w8001_coord *coord)
 	coord->tilt_y = data[8] & 0x7F;
 }
 
+static void parse_single_touch(struct w8001 *w8001)
+{
+	struct input_dev *dev = w8001->dev;
+	unsigned char *data = w8001->data;
+
+	int x = (data[1] << 7) | data[2];
+	int y = (data[3] << 7) | data[4];
+	w8001->has_touch = data[0] & 0x1;
+
+	/* scale to pen maximum */
+	if (w8001->max_pen_x && w8001->max_pen_y && w8001->max_touch_x) {
+		x = x * w8001->max_pen_x / w8001->max_touch_x;
+		y = y * w8001->max_pen_y / w8001->max_touch_y;
+	}
+
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, y);
+	input_report_key(dev, BTN_TOUCH, w8001->has_touch);
+	input_report_key(dev, BTN_TOOL_FINGER, w8001->has_touch);
+
+	input_sync(dev);
+}
+
 static void parse_touch(struct w8001 *w8001)
 {
 	struct input_dev *dev = w8001->dev;
@@ -151,6 +181,15 @@ static void parse_touchquery(u8 *data, struct w8001_touch_query *query)
 	query->y = data[5] << 9;
 	query->y |= data[6] << 2;
 	query->y |= (data[2] >> 3) & 0x3;
+
+	/* Early days' one finger touch models need the following defaults */
+	if (!query->x && !query->y) {
+		query->x = 1024;
+		query->y = 1024;
+		if (query->panel_res)
+			query->x = query->y = (1 << query->panel_res);
+		query->panel_res = 10;
+	}
 }
 
 static void report_pen_events(struct w8001 *w8001, struct w8001_coord *coord)
@@ -199,6 +238,7 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 				   unsigned char data, unsigned int flags)
 {
 	struct w8001 *w8001 = serio_get_drvdata(serio);
+	struct input_dev *dev = w8001->dev;
 	struct w8001_coord coord;
 	unsigned char tmp;
 
@@ -213,9 +253,15 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 
 	case W8001_PKTLEN_TOUCH93 - 1:
 	case W8001_PKTLEN_TOUCH9A - 1:
-		/* ignore one-finger touch packet. */
-		if (w8001->pktlen == w8001->idx)
+		tmp = (w8001->data[0] & W8001_TOUCH_BYTE);
+		if (tmp != W8001_TOUCH_BYTE)
+			break;
+
+		if (w8001->pktlen == w8001->idx) {
 			w8001->idx = 0;
+			if (!w8001->pen_in_prox)
+				parse_single_touch(w8001);
+		}
 		break;
 
 	/* Pen coordinates packet */
@@ -228,9 +274,18 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 		if (tmp == W8001_TOUCH_BYTE)
 			break;
 
+		if (w8001->has_touch) {
+			/* send touch data out first */
+			w8001->has_touch = 0;
+			input_report_key(dev, BTN_TOUCH, 0);
+			input_report_key(dev, BTN_TOOL_FINGER, 0);
+			input_sync(dev);
+		}
+
 		w8001->idx = 0;
 		parse_data(w8001->data, &coord);
 		report_pen_events(w8001, &coord);
+		w8001->pen_in_prox = coord.rdy ? true : false;
 		break;
 
 	/* control packet */
@@ -274,6 +329,24 @@ static int w8001_command(struct w8001 *w8001, unsigned char command,
 	return rc;
 }
 
+static void w8001_setup_single_touch(struct w8001 *w8001)
+{
+	struct input_dev *dev = w8001->dev;
+	int px = w8001->max_touch_x, py = w8001->max_touch_y;
+
+	__set_bit(BTN_TOUCH, dev->keybit);
+	__set_bit(BTN_TOOL_FINGER, dev->keybit);
+
+	/* scale to pen maximum */
+	if (w8001->max_pen_x && w8001->max_pen_y) {
+		px = w8001->max_pen_x;
+		py = w8001->max_pen_y;
+	}
+
+	input_set_abs_params(dev, ABS_X, 0, px, 0, 0);
+	input_set_abs_params(dev, ABS_Y, 0, py, 0, 0);
+}
+
 static int w8001_setup(struct w8001 *w8001)
 {
 	struct input_dev *dev = w8001->dev;
@@ -289,6 +362,7 @@ static int w8001_setup(struct w8001 *w8001)
 	/* penabled? */
 	error = w8001_command(w8001, W8001_CMD_QUERY, true);
 	if (!error) {
+		__set_bit(BTN_TOUCH, dev->keybit);
 		__set_bit(BTN_TOOL_PEN, dev->keybit);
 		__set_bit(BTN_TOOL_RUBBER, dev->keybit);
 		__set_bit(BTN_STYLUS, dev->keybit);
@@ -302,6 +376,8 @@ static int w8001_setup(struct w8001 *w8001)
 			input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
 			input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, 0, 0);
 		}
+		w8001->max_pen_x = coord.x;
+		w8001->max_pen_y = coord.y;
 	}
 
 	/* touch enabled? */
@@ -314,20 +390,20 @@ static int w8001_setup(struct w8001 *w8001)
 		struct w8001_touch_query touch;
 
 		parse_touchquery(w8001->response, &touch);
-
-		input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
-		input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
-		__set_bit(BTN_TOOL_FINGER, dev->keybit);
+		w8001->max_touch_x = touch.x;
+		w8001->max_touch_y = touch.y;
 
 		switch (touch.sensor_id) {
 		case 0:
 		case 2:
 			w8001->pktlen = W8001_PKTLEN_TOUCH93;
+			w8001_setup_single_touch(w8001);
 			break;
 		case 1:
 		case 3:
 		case 4:
 			w8001->pktlen = W8001_PKTLEN_TOUCH9A;
+			w8001_setup_single_touch(w8001);
 			break;
 		case 5:
 			w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
@@ -396,7 +472,6 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
 	input_dev->dev.parent = &serio->dev;
 
 	input_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
-	__set_bit(BTN_TOUCH, input_dev->keybit);
 
 	serio_set_drvdata(serio, w8001);
 	err = serio_open(serio, drv);
-- 
1.7.3.3

