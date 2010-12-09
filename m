From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2]input - wacom_w8001: Add one finger touch support
Date: Wed,  8 Dec 2010 17:23:49 -0800
Message-ID: <1291857829-13804-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56870 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab0LIBXS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Dec 2010 20:23:18 -0500
Received: by gyb11 with SMTP id 11so1082218gyb.19
        for <linux-input@vger.kernel.org>; Wed, 08 Dec 2010 17:23:17 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/touchscreen/wacom_w8001.c |   74 +++++++++++++++++++++++++++++--
 1 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 90b92e8..68087d8 100644
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
@@ -151,6 +181,18 @@ static void parse_touchquery(u8 *data, struct w8001_touch_query *query)
 	query->y = data[5] << 9;
 	query->y |= data[6] << 2;
 	query->y |= (data[2] >> 3) & 0x3;
+
+	/* Early days' one finger touch models need the following defaults */
+	if (!query->x && !query->y) {
+		query->x = 1024;
+		query->y = 1024;
+		query->panel_res = 10;
+		query->panel_res = 10;
+		if (data[1]) {
+			query->x = (1 << data[1]);
+			query->y = (1 << data[1]);
+		}
+	}
 }
 
 static void report_pen_events(struct w8001 *w8001, struct w8001_coord *coord)
@@ -199,6 +241,7 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 				   unsigned char data, unsigned int flags)
 {
 	struct w8001 *w8001 = serio_get_drvdata(serio);
+	struct input_dev *dev = w8001->dev;
 	struct w8001_coord coord;
 	unsigned char tmp;
 
@@ -213,9 +256,15 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 
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
@@ -228,9 +277,17 @@ static irqreturn_t w8001_interrupt(struct serio *serio,
 		if (tmp == W8001_TOUCH_BYTE)
 			break;
 
+		if (w8001->has_touch) {
+			/* send touch data out */
+			w8001->has_touch = 0;
+			input_report_key(dev, BTN_TOUCH, 0);
+			input_report_key(dev, BTN_TOOL_FINGER, 0);
+		}
+
 		w8001->idx = 0;
 		parse_data(w8001->data, &coord);
 		report_pen_events(w8001, &coord);
+		w8001->pen_in_prox = coord.rdy ? true : false;
 		break;
 
 	/* control packet */
@@ -313,11 +370,20 @@ static int w8001_setup(struct w8001 *w8001)
 	 */
 	if (!error && w8001->response[1]) {
 		struct w8001_touch_query touch;
+		int px, py;
 
 		parse_touchquery(w8001->response, &touch);
 
-		input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
-		input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
+		px = w8001->max_touch_x = touch.x;
+		py = w8001->max_touch_x = touch.y;
+
+		/* scale to pen maximum */
+		if (coord.x && coord.y) {
+			px = w8001->max_pen_x = coord.x;
+			py = w8001->max_pen_y = coord.y;
+		}
+		input_set_abs_params(dev, ABS_X, 0, px, 0, 0);
+		input_set_abs_params(dev, ABS_Y, 0, py, 0, 0);
 		dev->keybit[BIT_WORD(BTN_TOOL_FINGER)] |= BIT_MASK(BTN_TOOL_FINGER);
 
 		switch (touch.sensor_id) {
-- 
1.7.2.3

