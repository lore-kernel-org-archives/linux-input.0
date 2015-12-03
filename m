From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH v2 4/5] Input: wacom_w8001 - split pen and touch
 initialization up
Date: Thu, 3 Dec 2015 14:22:16 +1000
Message-ID: <20151203042216.GA22528@jelly.redhat.com>
References: <20151201220156.GE3740@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:23896 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757454AbbLCEWT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Dec 2015 23:22:19 -0500
Content-Disposition: inline
In-Reply-To: <20151201220156.GE3740@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>

This is preparation work for splitting it up for two event nodes.

The error handling for the touch init failure must be special-cased, a
device may respond to a touch query with a zero reply. In this case we
don't have a touch device, but we don't have a true failure either.
Returning 1 as special value here so we can then restore the true error
code on failure.

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
Acked-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
Change to v1:
- return -ENXIO if both pen and touch failed to initialize
- rebased for v2 of 3/5

 drivers/input/touchscreen/wacom_w8001.c | 204 ++++++++++++++++++--------------
 1 file changed, 116 insertions(+), 88 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 9ea5f82..de8f0e4 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -380,12 +380,10 @@ static void w8001_close(struct input_dev *dev)
 	w8001_command(w8001, W8001_CMD_STOP, false);
 }
 
-static int w8001_setup(struct w8001 *w8001)
+static int w8001_detect(struct w8001 *w8001)
 {
 	struct input_dev *dev = w8001->dev;
-	struct w8001_coord coord;
-	struct w8001_touch_query touch;
-	int error, err_pen, err_touch;
+	int error;
 
 	error = w8001_command(w8001, W8001_CMD_STOP, false);
 	if (error)
@@ -399,98 +397,121 @@ static int w8001_setup(struct w8001 *w8001)
 
 	__set_bit(INPUT_PROP_DIRECT, dev->propbit);
 
+	return 0;
+}
+
+static int w8001_setup_pen(struct w8001 *w8001)
+{
+	struct input_dev *dev = w8001->dev;
+	struct w8001_coord coord;
+	int error;
+
 	/* penabled? */
-	err_pen = w8001_command(w8001, W8001_CMD_QUERY, true);
-	if (!err_pen) {
-		__set_bit(BTN_TOUCH, dev->keybit);
-		__set_bit(BTN_TOOL_PEN, dev->keybit);
-		__set_bit(BTN_TOOL_RUBBER, dev->keybit);
-		__set_bit(BTN_STYLUS, dev->keybit);
-		__set_bit(BTN_STYLUS2, dev->keybit);
+	error = w8001_command(w8001, W8001_CMD_QUERY, true);
+	if (error)
+		return error;
 
-		parse_pen_data(w8001->response, &coord);
-		w8001->max_pen_x = coord.x;
-		w8001->max_pen_y = coord.y;
+	__set_bit(BTN_TOUCH, dev->keybit);
+	__set_bit(BTN_TOOL_PEN, dev->keybit);
+	__set_bit(BTN_TOOL_RUBBER, dev->keybit);
+	__set_bit(BTN_STYLUS, dev->keybit);
+	__set_bit(BTN_STYLUS2, dev->keybit);
 
-		input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
-		input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
-		input_abs_set_res(dev, ABS_X, W8001_PEN_RESOLUTION);
-		input_abs_set_res(dev, ABS_Y, W8001_PEN_RESOLUTION);
-		input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0, 0);
-		if (coord.tilt_x && coord.tilt_y) {
-			input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
-			input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, 0, 0);
-		}
-		w8001->id = 0x90;
-		strlcat(w8001->name, " Penabled", sizeof(w8001->name));
+	parse_pen_data(w8001->response, &coord);
+	w8001->max_pen_x = coord.x;
+	w8001->max_pen_y = coord.y;
+
+	input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
+	input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
+	input_abs_set_res(dev, ABS_X, W8001_PEN_RESOLUTION);
+	input_abs_set_res(dev, ABS_Y, W8001_PEN_RESOLUTION);
+	input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0, 0);
+	if (coord.tilt_x && coord.tilt_y) {
+		input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
+		input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, 0, 0);
 	}
 
+	w8001->id = 0x90;
+	strlcat(w8001->name, " Penabled", sizeof(w8001->name));
+
+	return 0;
+}
+
+static int w8001_setup_touch(struct w8001 *w8001)
+{
+	struct input_dev *dev = w8001->dev;
+	struct w8001_touch_query touch;
+	int error;
+
 	/* Touch enabled? */
-	err_touch = w8001_command(w8001, W8001_CMD_TOUCHQUERY, true);
-
-	if (!err_touch && !w8001->response[1])
-		err_touch = -ENXIO;
-
-	if (!err_touch) {
-		__set_bit(BTN_TOUCH, dev->keybit);
-		__set_bit(BTN_TOOL_FINGER, dev->keybit);
-
-		parse_touchquery(w8001->response, &touch);
-		w8001->max_touch_x = touch.x;
-		w8001->max_touch_y = touch.y;
-
-		if (w8001->max_pen_x && w8001->max_pen_y) {
-			/* if pen is supported scale to pen maximum */
-			touch.x = w8001->max_pen_x;
-			touch.y = w8001->max_pen_y;
-			touch.panel_res = W8001_PEN_RESOLUTION;
-		}
-
-		input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
-		input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
-		input_abs_set_res(dev, ABS_X, touch.panel_res);
-		input_abs_set_res(dev, ABS_Y, touch.panel_res);
-
-		switch (touch.sensor_id) {
-		case 0:
-		case 2:
-			w8001->pktlen = W8001_PKTLEN_TOUCH93;
-			w8001->id = 0x93;
-			strlcat(w8001->name, " 1FG", sizeof(w8001->name));
-			break;
-
-		case 1:
-		case 3:
-		case 4:
-			w8001->pktlen = W8001_PKTLEN_TOUCH9A;
-			strlcat(w8001->name, " 1FG", sizeof(w8001->name));
-			w8001->id = 0x9a;
-			break;
-
-		case 5:
-			w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
-
-			__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
-			input_mt_init_slots(dev, 2, 0);
-			input_set_abs_params(dev, ABS_MT_POSITION_X,
-						0, touch.x, 0, 0);
-			input_set_abs_params(dev, ABS_MT_POSITION_Y,
-						0, touch.y, 0, 0);
-			input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
-						0, MT_TOOL_MAX, 0, 0);
-
-			strlcat(w8001->name, " 2FG", sizeof(w8001->name));
-			if (w8001->max_pen_x && w8001->max_pen_y)
-				w8001->id = 0xE3;
-			else
-				w8001->id = 0xE2;
-			break;
-		}
+	error = w8001_command(w8001, W8001_CMD_TOUCHQUERY, true);
+	if (error)
+		return error;
+	/*
+	 * Some non-touch devices may reply to the touch query. But their
+	 * second byte is empty, which indicates touch is not supported.
+	 */
+	if (!w8001->response[1])
+		return -ENXIO;
+
+	__set_bit(BTN_TOUCH, dev->keybit);
+	__set_bit(BTN_TOOL_FINGER, dev->keybit);
+
+	parse_touchquery(w8001->response, &touch);
+	w8001->max_touch_x = touch.x;
+	w8001->max_touch_y = touch.y;
+
+	if (w8001->max_pen_x && w8001->max_pen_y) {
+		/* if pen is supported scale to pen maximum */
+		touch.x = w8001->max_pen_x;
+		touch.y = w8001->max_pen_y;
+		touch.panel_res = W8001_PEN_RESOLUTION;
+	}
+
+	input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
+	input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
+	input_abs_set_res(dev, ABS_X, touch.panel_res);
+	input_abs_set_res(dev, ABS_Y, touch.panel_res);
+
+	switch (touch.sensor_id) {
+	case 0:
+	case 2:
+		w8001->pktlen = W8001_PKTLEN_TOUCH93;
+		w8001->id = 0x93;
+		strlcat(w8001->name, " 1FG", sizeof(w8001->name));
+		break;
+
+	case 1:
+	case 3:
+	case 4:
+		w8001->pktlen = W8001_PKTLEN_TOUCH9A;
+		strlcat(w8001->name, " 1FG", sizeof(w8001->name));
+		w8001->id = 0x9a;
+		break;
+
+	case 5:
+		w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
+
+		__set_bit(BTN_TOOL_DOUBLETAP, dev->keybit);
+		input_mt_init_slots(dev, 2, 0);
+		input_set_abs_params(dev, ABS_MT_POSITION_X,
+					0, touch.x, 0, 0);
+		input_set_abs_params(dev, ABS_MT_POSITION_Y,
+					0, touch.y, 0, 0);
+		input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
+					0, MT_TOOL_MAX, 0, 0);
+
+		strlcat(w8001->name, " 2FG", sizeof(w8001->name));
+		if (w8001->max_pen_x && w8001->max_pen_y)
+			w8001->id = 0xE3;
+		else
+			w8001->id = 0xE2;
+		break;
 	}
 
 	strlcat(w8001->name, " Touchscreen", sizeof(w8001->name));
 
-	return !err_pen || !err_touch ? 0 : -ENXIO;
+	return 0;
 }
 
 /*
@@ -519,7 +540,7 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
 {
 	struct w8001 *w8001;
 	struct input_dev *input_dev;
-	int err;
+	int err, err_pen, err_touch;
 
 	w8001 = kzalloc(sizeof(struct w8001), GFP_KERNEL);
 	input_dev = input_allocate_device();
@@ -538,10 +559,17 @@ static int w8001_connect(struct serio *serio, struct serio_driver *drv)
 	if (err)
 		goto fail2;
 
-	err = w8001_setup(w8001);
+	err = w8001_detect(w8001);
 	if (err)
 		goto fail3;
 
+	err_pen = w8001_setup_pen(w8001);
+	err_touch = w8001_setup_touch(w8001);
+	if (err_pen && err_touch) {
+		err = -ENXIO;
+		goto fail3;
+	}
+
 	input_dev->name = w8001->name;
 	input_dev->phys = w8001->phys;
 	input_dev->id.product = w8001->id;
-- 
2.5.0

