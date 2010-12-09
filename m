From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2]input - wacom_w8001: Support pen or touch only devices
Date: Wed,  8 Dec 2010 17:17:13 -0800
Message-ID: <1291857433-13731-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f180.google.com ([209.85.161.180]:62091 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823Ab0LIBQn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Dec 2010 20:16:43 -0500
Received: by gxk19 with SMTP id 19so1028329gxk.11
        for <linux-input@vger.kernel.org>; Wed, 08 Dec 2010 17:16:42 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Not all penabled devices support touch. The same idea is true for
touch devices. Setting up the devices according to the specific
querying results.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/touchscreen/wacom_w8001.c |   39 ++++++++++++++++++++++++------
 1 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 361d00a..90b92e8 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -37,6 +37,7 @@ MODULE_LICENSE("GPL");
 
 #define W8001_QUERY_PACKET	0x20
 
+#define W8001_CMD_STOP		'0'
 #define W8001_CMD_START		'1'
 #define W8001_CMD_QUERY		'*'
 #define W8001_CMD_TOUCHQUERY	'%'
@@ -279,24 +280,46 @@ static int w8001_setup(struct w8001 *w8001)
 	struct w8001_coord coord;
 	int error;
 
-	error = w8001_command(w8001, W8001_CMD_QUERY, true);
+	error = w8001_command(w8001, W8001_CMD_STOP, false);
 	if (error)
 		return error;
 
-	parse_data(w8001->response, &coord);
+	mdelay(250);	/* wait 250ms before querying the device */
 
-	input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
-	input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
-	input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0, 0);
-	input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
-	input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, 0, 0);
+	/* penabled? */
+	error = w8001_command(w8001, W8001_CMD_QUERY, true);
+	if (!error) {
+		dev->keybit[BIT_WORD(BTN_TOOL_PEN)] |= BIT_MASK(BTN_TOOL_PEN);
+		dev->keybit[BIT_WORD(BTN_TOOL_RUBBER)] |= BIT_MASK(BTN_TOOL_RUBBER);
+		dev->keybit[BIT_WORD(BTN_STYLUS)] |= BIT_MASK(BTN_STYLUS);
+		dev->keybit[BIT_WORD(BTN_STYLUS2)] |= BIT_MASK(BTN_STYLUS2);
+		parse_data(w8001->response, &coord);
+
+		input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
+		input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
+		input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0, 0);
+		if (coord.tilt_x && coord.tilt_y)
+		{
+			input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
+			input_set_abs_params(dev, ABS_TILT_Y, 0, coord.tilt_y, 0, 0);
+		}
+	}
 
+	/* touch enabled? */
 	error = w8001_command(w8001, W8001_CMD_TOUCHQUERY, true);
-	if (!error) {
+
+	/* Some non-touch devices may reply to the touch query. But their
+	 * second byte is empty, which indicates touch is not supported.
+	 */
+	if (!error && w8001->response[1]) {
 		struct w8001_touch_query touch;
 
 		parse_touchquery(w8001->response, &touch);
 
+		input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
+		input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
+		dev->keybit[BIT_WORD(BTN_TOOL_FINGER)] |= BIT_MASK(BTN_TOOL_FINGER);
+
 		switch (touch.sensor_id) {
 		case 0:
 		case 2:
-- 
1.7.2.3

