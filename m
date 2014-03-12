From: Clinton Sprain <clintonsprain@gmail.com>
Subject: [PATCH v4 3/3] input: appletouch: fix jumps when additional fingers
 are detected
Date: Wed, 12 Mar 2014 18:17:50 -0500
Message-ID: <5320EB1E.3020302@gmail.com>
References: <52D9DE7A.7040509@gmail.com> <5320EA03.2040206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:63589 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaCLXSR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Mar 2014 19:18:17 -0400
Received: by mail-ie0-f177.google.com with SMTP id rl12so198552iec.36
        for <linux-input@vger.kernel.org>; Wed, 12 Mar 2014 16:17:52 -0700 (PDT)
In-Reply-To: <5320EA03.2040206@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

input: appletouch: fix jumps when additional fingers are detected

Addresses issues related to when a second finger enters or leaves the field,
causing the cursor to jump or the page to scroll unexpectedly; now, we
discard any movement change that happens at the exact moment we detect a
change in the number of fingers touching the trackpad. This doesn't
completely resolve the issue but does greatly mitigate it.

Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>
---
 drivers/input/mouse/appletouch.c |   27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index e00f126..5140293 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -206,6 +206,7 @@ struct atp {
 	bool			valid;		/* are the samples valid? */
 	bool			size_detect_done;
 	bool			overflow_warned;
+	int			fingers_old;	/* last reported finger count */
 	int			x_old;		/* last reported x/y, */
 	int			y_old;		/* used for smoothing */
 	signed char		xy_cur[ATP_XSENSORS + ATP_YSENSORS];
@@ -508,7 +509,7 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 {
 	int x, y, x_z, y_z, x_f, y_f;
 	int retval, i, j;
-	int key;
+	int key, fingers;
 	struct atp *dev = urb->context;
 	int status = atp_status_check(urb);
 
@@ -591,7 +592,9 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 			      dev->info->yfact, &y_z, &y_f);
 	key = dev->data[dev->info->datalen - 1] & ATP_STATUS_BUTTON;
 
-	if (x && y) {
+	fingers = max(x_f, y_f);
+
+	if (x && y && (fingers == dev->fingers_old)) {
 		if (dev->x_old != -1) {
 			x = (dev->x_old * 7 + x) >> 3;
 			y = (dev->y_old * 7 + y) >> 3;
@@ -608,7 +611,7 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 			input_report_abs(dev->input, ABS_Y, y);
 			input_report_abs(dev->input, ABS_PRESSURE,
 					 min(ATP_PRESSURE, x_z + y_z));
-			atp_report_fingers(dev->input, max(x_f, y_f));
+			atp_report_fingers(dev->input, fingers);
 		}
 		dev->x_old = x;
 		dev->y_old = y;
@@ -616,6 +619,7 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 	} else if (!x && !y) {
 
 		dev->x_old = dev->y_old = -1;
+		dev->fingers_old = 0;
 		input_report_key(dev->input, BTN_TOUCH, 0);
 		input_report_abs(dev->input, ABS_PRESSURE, 0);
 		atp_report_fingers(dev->input, 0);
@@ -624,6 +628,10 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
 	}
 
+	if (fingers != dev->fingers_old)
+		dev->x_old = dev->y_old = -1;
+	dev->fingers_old = fingers;
+
 	input_report_key(dev->input, BTN_LEFT, key);
 	input_sync(dev->input);
 
@@ -641,7 +649,7 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 {
 	int x, y, x_z, y_z, x_f, y_f;
 	int retval, i, j;
-	int key;
+	int key, fingers;
 	struct atp *dev = urb->context;
 	int status = atp_status_check(urb);
 
@@ -703,7 +711,9 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 			      dev->info->yfact, &y_z, &y_f);
 	key = dev->data[dev->info->datalen - 1] & ATP_STATUS_BUTTON;
 
-	if (x && y) {
+	fingers = max(x_f, y_f);
+
+	if (x && y && (fingers == dev->fingers_old)) {
 		if (dev->x_old != -1) {
 			x = (dev->x_old * 7 + x) >> 3;
 			y = (dev->y_old * 7 + y) >> 3;
@@ -720,7 +730,7 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 			input_report_abs(dev->input, ABS_Y, y);
 			input_report_abs(dev->input, ABS_PRESSURE,
 					 min(ATP_PRESSURE, x_z + y_z));
-			atp_report_fingers(dev->input, max(x_f, y_f));
+			atp_report_fingers(dev->input, fingers);
 		}
 		dev->x_old = x;
 		dev->y_old = y;
@@ -728,6 +738,7 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 	} else if (!x && !y) {
 
 		dev->x_old = dev->y_old = -1;
+		dev->fingers_old = 0;
 		input_report_key(dev->input, BTN_TOUCH, 0);
 		input_report_abs(dev->input, ABS_PRESSURE, 0);
 		atp_report_fingers(dev->input, 0);
@@ -736,6 +747,10 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
 	}
 
+	if (fingers != dev->fingers_old)
+		dev->x_old = dev->y_old = -1;
+	dev->fingers_old = fingers;
+
 	input_report_key(dev->input, BTN_LEFT, key);
 	input_sync(dev->input);
 
-- 
1.7.9.5
