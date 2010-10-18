From: <michael.hennerich@analog.com>
Subject: [PATCH] Input: touchscreen: AD7879: prevent invalid finger data reports
Date: Mon, 18 Oct 2010 15:33:24 +0200
Message-ID: <1287408804-19789-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:37618 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967Ab0JRNka (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Oct 2010 09:40:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, drivers@analog.com, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Considering following scenario - the touch is present on the screen
at the beginning of the last conversion sequence, but by the time
the last sequence is finished, the finger is lift off.
The AD7879 data available interrupt signals (DAV) completion,
however some X,Y values are not valid because the screen inputs were
floating during the acquisition.

The AD7877 acts differently here, since it only asserts DAV
if the touch is still present when the conversion sequence finished.

Based on the fact that this can only happen in the last sample of the
repeated conversion sequence. We simply skip the last.
(Short glitches are filtered by the AD7879 internal median and average filters)
This doesn't cause noticeable side effects, since the minimum conversion
interval is 9.44ms. We receive ~100 waypoint samples per second,
so we simply delay the result by 9.44ms.

Actually this patch repeats the first waypoint twice and then skips the last.
This patch also rejects samples where pressure > pressure_max.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/touchscreen/ad7879.c |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c b/drivers/input/touchscreen/ad7879.c
index ba6f0bd..3173589 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -129,6 +129,9 @@ struct ad7879 {
 	u16			cmd_crtl1;
 	u16			cmd_crtl2;
 	u16			cmd_crtl3;
+	int			x;
+	int			y;
+	int			Rt;	
 };
 
 static int ad7879_read(struct ad7879 *ts, u8 reg)
@@ -175,13 +178,29 @@ static int ad7879_report(struct ad7879 *ts)
 		Rt /= z1;
 		Rt = (Rt + 2047) >> 12;
 
-		if (!timer_pending(&ts->timer))
+		/*
+		 * Sample found inconsistent, pressure is beyond
+		 * the maximum. Don't report it to user space.
+		 */
+		if (Rt > ts->pressure_max)
+			return -EINVAL;
+
+		if (!timer_pending(&ts->timer)) {
+			ts->x = x;
+			ts->y = y;
+			ts->Rt = Rt;
 			input_report_key(input_dev, BTN_TOUCH, 1);
-
-		input_report_abs(input_dev, ABS_X, x);
-		input_report_abs(input_dev, ABS_Y, y);
-		input_report_abs(input_dev, ABS_PRESSURE, Rt);
-		input_sync(input_dev);
+		}
+		
+		input_report_abs(input_dev, ABS_X, ts->x);
+		input_report_abs(input_dev, ABS_Y, ts->y);
+		input_report_abs(input_dev, ABS_PRESSURE, ts->Rt);
+		input_sync(input_dev);		
+
+		ts->x = x;
+		ts->y = y;
+		ts->Rt = Rt;
+		
 		return 0;
 	}
 
-- 
1.6.0.2

