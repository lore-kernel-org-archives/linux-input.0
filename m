From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH] input : wacom - report resolution for ABS_MT events
Date: Thu, 27 Jan 2011 17:47:25 -0800
Message-ID: <1296179245-14614-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60421 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753863Ab1A1Br7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Jan 2011 20:47:59 -0500
Received: by yxt3 with SMTP id 3so869658yxt.19
        for <linux-input@vger.kernel.org>; Thu, 27 Jan 2011 17:47:59 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

This is mainly required by the serial pen and touch devices since
both pen and touch are on the same port. Updated the USB ones to
keep MT event definition consistent among serial and USB devices.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c        |    6 ++++++
 drivers/input/touchscreen/wacom_w8001.c |   23 ++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 367fa82..f129440 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -1283,6 +1283,12 @@ void wacom_setup_input_capabilities(struct input_dev *input_dev,
 			input_set_abs_params(input_dev, ABS_MT_PRESSURE,
 					     0, features->pressure_max,
 					     features->pressure_fuzz, 0);
+			input_abs_set_res(input_dev, ABS_MT_POSITION_X,
+				wacom_calculate_touch_res(features->x_max,
+							features->x_phy));
+			input_abs_set_res(input_dev, ABS_MT_POSITION_Y,
+				wacom_calculate_touch_res(features->y_max,
+							features->y_phy));
 			input_abs_set_res(input_dev, ABS_X,
 				wacom_calculate_touch_res(features->x_max,
 							features->x_phy));
diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 5cb8449..f54da5c 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -51,6 +51,11 @@ MODULE_LICENSE("GPL");
 #define W8001_PKTLEN_TPCCTL	11	/* control packet */
 #define W8001_PKTLEN_TOUCH2FG	13
 
+/* resolution in points/mm */
+#define W8001_PEN_RESOLUTION    100
+#define W8001_TOUCH_RESOLUTION  10
+
+
 struct w8001_coord {
 	u8 rdy;
 	u8 tsw;
@@ -92,6 +97,8 @@ struct w8001 {
 	u16 max_touch_y;
 	u16 max_pen_x;
 	u16 max_pen_y;
+	u16 touch_res_x;
+	u16 touch_res_y;
 	char name[64];
 };
 
@@ -198,7 +205,7 @@ static void parse_touchquery(u8 *data, struct w8001_touch_query *query)
 		query->y = 1024;
 		if (query->panel_res)
 			query->x = query->y = (1 << query->panel_res);
-		query->panel_res = 10;
+		query->panel_res = W8001_TOUCH_RESOLUTION;
 	}
 }
 
@@ -394,6 +401,8 @@ static int w8001_setup(struct w8001 *w8001)
 
 		input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
 		input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
+		input_abs_set_res(dev, ABS_X, W8001_PEN_RESOLUTION);
+		input_abs_set_res(dev, ABS_Y, W8001_PEN_RESOLUTION);
 		input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0, 0);
 		if (coord.tilt_x && coord.tilt_y) {
 			input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
@@ -411,6 +420,9 @@ static int w8001_setup(struct w8001 *w8001)
 	 * second byte is empty, which indicates touch is not supported.
 	 */
 	if (!error && w8001->response[1]) {
+		u16 touch_res_x  = touch.panel_res;
+		u16 touch_res_y = touch.panel_res;
+
 		__set_bit(BTN_TOUCH, dev->keybit);
 		__set_bit(BTN_TOOL_FINGER, dev->keybit);
 
@@ -422,10 +434,17 @@ static int w8001_setup(struct w8001 *w8001)
 		if (w8001->max_pen_x && w8001->max_pen_y) {
 			touch.x = w8001->max_pen_x;
 			touch.y = w8001->max_pen_y;
+
+			/* scale resolution as well */
+			touch_res_x *= w8001->max_pen_x / w8001->max_touch_x;
+			touch_res_y *= w8001->max_pen_y / w8001->max_touch_y;
 		}
 
 		input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
 		input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
+		/* don't report touch resolution for ST since pen resolution
+		 * is more important
+		 */
 
 		switch (touch.sensor_id) {
 		case 0:
@@ -453,6 +472,8 @@ static int w8001_setup(struct w8001 *w8001)
 						0, touch.y, 0, 0);
 			input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
 						0, MT_TOOL_MAX, 0, 0);
+			input_abs_set_res(dev, ABS_MT_POSITION_X, touch_res_x);
+			input_abs_set_res(dev, ABS_MT_POSITION_Y, touch_res_y);
 
 			strlcat(w8001->name, " 2FG", sizeof(w8001->name));
 			if (w8001->max_pen_x && w8001->max_pen_y)
-- 
1.7.3.5

