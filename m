From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 3/4] Fix hover in Android (Gingerbread)
Date: Thu,  7 Jul 2011 14:04:59 -0700
Message-ID: <1310072700-2829-3-git-send-email-killertofu@gmail.com>
References: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:65059 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab1GGVFf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 17:05:35 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so722510pvg.19
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2011 14:05:35 -0700 (PDT)
In-Reply-To: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>, Dima Zavin <dima@android.com>, Jason Gerecke <killertofu@gmail.com>

As of Gingerbread, Android does not pay attention to if the pen
is in contact with the screen, or merely in proximity. Since the
Xorg Wacom driver does not make use of MT pen events, we simply
do not emit MT data while hovering.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 Now being sent upstream to LKML at the behest of Google.

 drivers/input/touchscreen/wacom_w8001.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index e94a21a..40ed685 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -279,10 +279,12 @@ static void report_pen_events(struct w8001 *w8001, struct w8001_coord *coord)
 	input_report_key(dev, BTN_STYLUS, coord->f1);
 	input_report_key(dev, w8001->type, coord->rdy);
 
-	input_report_abs(dev, ABS_MT_POSITION_X, coord->x);
-	input_report_abs(dev, ABS_MT_POSITION_Y, coord->y);
-	input_report_abs(dev, ABS_MT_PRESSURE, coord->pen_pressure);
-	input_report_abs(dev, ABS_MT_TOOL_TYPE, MT_TOOL_PEN);
+	if (coord->pen_pressure > 0) {
+		input_report_abs(dev, ABS_MT_POSITION_X, coord->x);
+		input_report_abs(dev, ABS_MT_POSITION_Y, coord->y);
+		input_report_abs(dev, ABS_MT_PRESSURE, coord->pen_pressure);
+		input_report_abs(dev, ABS_MT_TOOL_TYPE, MT_TOOL_PEN);
+	}
 
 	input_mt_sync(dev);
 	input_sync(dev);
-- 
1.7.5.2

