From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/4] Revert to anonymous 'type A' MT protocol for touch
Date: Thu,  7 Jul 2011 14:04:57 -0700
Message-ID: <1310072700-2829-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:65059 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab1GGVFc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jul 2011 17:05:32 -0400
Received: by pvg12 with SMTP id 12so722510pvg.19
        for <linux-input@vger.kernel.org>; Thu, 07 Jul 2011 14:05:31 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jgerecke@wacom.com>, Dima Zavin <dima@android.com>, Jason Gerecke <killertofu@gmail.com>

Android (at least up to Gingerbread) does not understand the 'B' protocol
first made available in 2.6.36. As a workaround until this is fixed, we
drop back to using the 'A' protocol.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 Now being sent upstream to LKML at the behest of Google.

 drivers/input/touchscreen/wacom_w8001.c |   33 ++++++++++++++++++++++++++----
 1 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/touchscreen/wacom_w8001.c
index c14412e..7630806 100644
--- a/drivers/input/touchscreen/wacom_w8001.c
+++ b/drivers/input/touchscreen/wacom_w8001.c
@@ -151,8 +151,6 @@ static void parse_multi_touch(struct w8001 *w8001)
 	for (i = 0; i < 2; i++) {
 		bool touch = data[0] & (1 << i);
 
-		input_mt_slot(dev, i);
-		input_mt_report_slot_state(dev, MT_TOOL_FINGER, touch);
 		if (touch) {
 			x = (data[6 * i + 1] << 7) | data[6 * i + 2];
 			y = (data[6 * i + 3] << 7) | data[6 * i + 4];
@@ -163,9 +161,14 @@ static void parse_multi_touch(struct w8001 *w8001)
 
 			input_report_abs(dev, ABS_MT_POSITION_X, x);
 			input_report_abs(dev, ABS_MT_POSITION_Y, y);
+			input_report_abs(dev, ABS_MT_TOOL_TYPE, MT_TOOL_FINGER);
 			count++;
+
+			input_mt_sync(dev);
 		}
 	}
+	if (count == 0)
+		input_mt_sync(dev);
 
 	/* emulate single touch events when stylus is out of proximity.
 	 * This is to make single touch backward support consistent
@@ -173,8 +176,20 @@ static void parse_multi_touch(struct w8001 *w8001)
 	 */
 	if (w8001->type != BTN_TOOL_PEN &&
 			    w8001->type != BTN_TOOL_RUBBER) {
+		struct w8001_coord coord;
+
 		w8001->type = count == 1 ? BTN_TOOL_FINGER : KEY_RESERVED;
-		input_mt_report_pointer_emulation(dev, true);
+
+		parse_single_touch(data, &coord);
+		x = coord.x;
+		y = coord.y;
+		scale_touch_coordinates(w8001, &x, &y);
+
+		input_report_abs(dev, ABS_X, x);
+		input_report_abs(dev, ABS_Y, y);
+		input_report_key(dev, BTN_TOUCH, count > 0);
+		input_report_key(dev, BTN_TOOL_FINGER, count == 1);
+		input_report_key(dev, BTN_TOOL_DOUBLETAP, count == 2);
 	}
 
 	input_sync(dev);
@@ -228,6 +243,10 @@ static void report_pen_events(struct w8001 *w8001, struct w8001_coord *coord)
 			input_report_key(dev, BTN_STYLUS, 0);
 			input_report_key(dev, BTN_STYLUS2, 0);
 			input_report_key(dev, BTN_TOOL_RUBBER, 0);
+
+			/* No multi-touchpoints -> SYN_MT_REPORT; SYN_REPORT */
+			input_mt_sync(dev);
+
 			input_sync(dev);
 			w8001->type = BTN_TOOL_PEN;
 		}
@@ -236,10 +255,15 @@ static void report_pen_events(struct w8001 *w8001, struct w8001_coord *coord)
 	case BTN_TOOL_FINGER:
 		input_report_key(dev, BTN_TOUCH, 0);
 		input_report_key(dev, BTN_TOOL_FINGER, 0);
-		input_sync(dev);
+
 		/* fall through */
 
 	case KEY_RESERVED:
+		/* No multi-touchpoints -> SYN_MT_REPORT; SYN_REPORT */
+		input_mt_sync(dev);
+
+		input_sync(dev);
+
 		w8001->type = coord->f2 ? BTN_TOOL_RUBBER : BTN_TOOL_PEN;
 		break;
 
@@ -455,7 +479,6 @@ static int w8001_setup(struct w8001 *w8001)
 		case 5:
 			w8001->pktlen = W8001_PKTLEN_TOUCH2FG;
 
-			input_mt_init_slots(dev, 2);
 			input_set_abs_params(dev, ABS_MT_POSITION_X,
 						0, touch.x, 0, 0);
 			input_set_abs_params(dev, ABS_MT_POSITION_Y,
-- 
1.7.5.2

