From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH v2] input : wacom_w8001 - report resolution to userland
Date: Fri, 28 Jan 2011 22:21:47 -0800
Message-ID: <1296282107-14237-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37031 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab1A2GWW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Jan 2011 01:22:22 -0500
Received: by pwj3 with SMTP id 3so750974pwj.19
        for <linux-input@vger.kernel.org>; Fri, 28 Jan 2011 22:22:22 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, rydberg@euromail.se, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Serial devices send both pen and touch data through the same logical
port. Since we scaled touch to pen maximum, we use pen resolution
for touch as well here.

This is under the assumption that pen and touch share the same physical
surface. In the case when a small physical dimensional difference occurs
between pen and touch, we assume the tolerance for touch point precision
is higher than pen and the difference is within touch point tolerance.

A per-MT tool based resolution mechanism should be introduced if the
above assumption does not hold true for the pen and touch devices any
more. A good candidate to resolve this issue without introducing design
change could be to report touch resolution through ABS_MT_POSITION_X/Y.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/touchscreen/wacom_w8001.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 5cb8449..d9dde0d 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -51,6 +51,10 @@ MODULE_LICENSE("GPL");
 #define W8001_PKTLEN_TPCCTL	11	/* control packet */
 #define W8001_PKTLEN_TOUCH2FG	13
 
+/* resolution in points/mm */
+#define W8001_PEN_RESOLUTION    100
+#define W8001_TOUCH_RESOLUTION  10
+
 struct w8001_coord {
 	u8 rdy;
 	u8 tsw;
@@ -198,7 +202,7 @@ static void parse_touchquery(u8 *data, struct w8001_touch_query *query)
 		query->y = 1024;
 		if (query->panel_res)
 			query->x = query->y = (1 << query->panel_res);
-		query->panel_res = 10;
+		query->panel_res = W8001_TOUCH_RESOLUTION;
 	}
 }
 
@@ -394,6 +398,8 @@ static int w8001_setup(struct w8001 *w8001)
 
 		input_set_abs_params(dev, ABS_X, 0, coord.x, 0, 0);
 		input_set_abs_params(dev, ABS_Y, 0, coord.y, 0, 0);
+		input_abs_set_res(dev, ABS_X, W8001_PEN_RESOLUTION);
+		input_abs_set_res(dev, ABS_Y, W8001_PEN_RESOLUTION);
 		input_set_abs_params(dev, ABS_PRESSURE, 0, coord.pen_pressure, 0, 0);
 		if (coord.tilt_x && coord.tilt_y) {
 			input_set_abs_params(dev, ABS_TILT_X, 0, coord.tilt_x, 0, 0);
@@ -418,15 +424,15 @@ static int w8001_setup(struct w8001 *w8001)
 		w8001->max_touch_x = touch.x;
 		w8001->max_touch_y = touch.y;
 
-		/* scale to pen maximum */
-		if (w8001->max_pen_x && w8001->max_pen_y) {
-			touch.x = w8001->max_pen_x;
-			touch.y = w8001->max_pen_y;
+		/* pen not supported */
+		if (!w8001->max_pen_x || !w8001->max_pen_y) {
+			/* set axes with touch data */
+			input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
+			input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
+			input_abs_set_res(dev, ABS_X, touch.panel_res);
+			input_abs_set_res(dev, ABS_Y, touch.panel_res);
 		}
 
-		input_set_abs_params(dev, ABS_X, 0, touch.x, 0, 0);
-		input_set_abs_params(dev, ABS_Y, 0, touch.y, 0, 0);
-
 		switch (touch.sensor_id) {
 		case 0:
 		case 2:
-- 
1.7.3.5

