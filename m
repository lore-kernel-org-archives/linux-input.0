From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/4] Use MT (in addition to single-touch) protocol for all events
Date: Thu,  7 Jul 2011 14:04:58 -0700
Message-ID: <1310072700-2829-2-git-send-email-killertofu@gmail.com>
References: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:65059 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab1GGVFd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 17:05:33 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so722510pvg.19
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2011 14:05:33 -0700 (PDT)
In-Reply-To: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>, Dima Zavin <dima@android.com>, Jason Gerecke <killertofu@gmail.com>

Android (begining with Gingerbread) ignores all single-touch events
from multi-touch capable devices. This patch augments the pen and
single-touch handlers to emit MT events for Android's consumption.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 Now being sent upstream to LKML at the behest of Google.

 drivers/input/touchscreen/wacom_w8001.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index 7630806..e94a21a 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -278,6 +278,13 @@ static void report_pen_events(struct w8001 *w8001, struct w8001_coord *coord)
 	input_report_key(dev, BTN_TOUCH, coord->tsw);
 	input_report_key(dev, BTN_STYLUS, coord->f1);
 	input_report_key(dev, w8001->type, coord->rdy);
+
+	input_report_abs(dev, ABS_MT_POSITION_X, coord->x);
+	input_report_abs(dev, ABS_MT_POSITION_Y, coord->y);
+	input_report_abs(dev, ABS_MT_PRESSURE, coord->pen_pressure);
+	input_report_abs(dev, ABS_MT_TOOL_TYPE, MT_TOOL_PEN);
+
+	input_mt_sync(dev);
 	input_sync(dev);
 
 	if (!coord->rdy)
@@ -298,6 +305,11 @@ static void report_single_touch(struct w8001 *w8001, struct w8001_coord *coord)
 	input_report_key(dev, BTN_TOUCH, coord->tsw);
 	input_report_key(dev, BTN_TOOL_FINGER, coord->tsw);
 
+	input_report_abs(dev, ABS_MT_POSITION_X, x);
+	input_report_abs(dev, ABS_MT_POSITION_Y, y);
+	input_report_abs(dev, ABS_MT_TOOL_TYPE, MT_TOOL_FINGER);
+
+	input_mt_sync(dev);
 	input_sync(dev);
 
 	w8001->type = coord->tsw ? BTN_TOOL_FINGER : KEY_RESERVED;
@@ -485,6 +497,8 @@ static int w8001_setup(struct w8001 *w8001)
 						0, touch.y, 0, 0);
 			input_set_abs_params(dev, ABS_MT_TOOL_TYPE,
 						0, MT_TOOL_MAX, 0, 0);
+			input_set_abs_params(dev, ABS_MT_PRESSURE,
+						0, coord.pen_pressure, 0, 0);
 
 			strlcat(w8001->name, " 2FG", sizeof(w8001->name));
 			if (w8001->max_pen_x && w8001->max_pen_y)
-- 
1.7.5.2

