From: Clinton Sprain <clintonsprain@gmail.com>
Subject: [PATCH 3/3] input: appletouch: fix jumps when additional fingers
 are detected
Date: Fri, 17 Jan 2014 19:58:02 -0600
Message-ID: <52D9DFAA.10205@gmail.com>
References: <52D9DE7A.7040509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:57783 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbaARB6F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 20:58:05 -0500
Received: by mail-ig0-f182.google.com with SMTP id uy17so3209723igb.3
        for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 17:58:04 -0800 (PST)
In-Reply-To: <52D9DE7A.7040509@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

Discard cursor movements if they directly coincide with
a change in the number of fingers detected. This helps
mitigate two issues - a sudden jump of the cursor when
a second finger enters or leaves the trackpad, and an
unexpected jump in page scrolling under the same
scenario. This doesn't completely eliminate all jumps
but does greatly reduce their frequency and velocity.

Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>
---
 drivers/input/mouse/appletouch.c |   41 ++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 4a3bbcd..406054a 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -218,6 +218,7 @@ struct atp {
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
 	int			idlecount;	/* number of empty packets */
 	struct work_struct	work;
+	int			fingers_old;	/* last # of fingers detected*/
 };
 #define dbg_dump(msg, tab)						\
 {									\
@@ -538,6 +539,7 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 	int x, y, x_z, y_z, x_f, y_f;
 	int retval, i, j;
 	int key;
+	int fingers;
 	struct atp *dev = urb->context;
 	int status = atp_status_check(urb);
 
@@ -621,7 +623,16 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 			      dev->info->yfact, &y_z, &y_f);
 	key = dev->data[dev->info->datalen - 1] & ATP_STATUS_BUTTON;
 
-	if (x && y) {
+	fingers = max(x_f, y_f);
+
+	/*
+	 * Only act if we have valid x/y and # of fingers did not change.
+	 * If the # of fingers just changed, acting on the new x/y values will
+	 * cause the cursor to jump across the screen or the page to scroll
+	 * unexpectedly.
+	 */
+
+	if (x && y && (dev->fingers_old == fingers)) {
 		if (dev->x_old != -1) {
 			if (legacy == true) {
 				x = atp_smooth_legacy(x, dev->x_old);
@@ -646,7 +657,7 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 			input_report_abs(dev->input, ABS_Y, y);
 			input_report_abs(dev->input, ABS_PRESSURE,
 					 min(ATP_PRESSURE, x_z + y_z));
-			atp_report_fingers(dev->input, max(x_f, y_f));
+			atp_report_fingers(dev->input, fingers);
 		}
 		atp_refresh_old_xy(x, y, dev);
 
@@ -661,6 +672,12 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
 	}
 
+	/* if # of fingers changed, old x/y values are no longer useful */
+	if (dev->fingers_old != fingers)
+		atp_reset_old_xy(dev);
+
+	dev->fingers_old = fingers;
+
 	input_report_key(dev->input, BTN_LEFT, key);
 	input_sync(dev->input);
 
@@ -679,6 +696,7 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 	int x, y, x_z, y_z, x_f, y_f;
 	int retval, i, j;
 	int key;
+	int fingers;
 	struct atp *dev = urb->context;
 	int status = atp_status_check(urb);
 
@@ -740,7 +758,16 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 			      dev->info->yfact, &y_z, &y_f);
 	key = dev->data[dev->info->datalen - 1] & ATP_STATUS_BUTTON;
 
-	if (x && y) {
+	fingers = max(x_f, y_f);
+
+	/*
+	 * Only act if we have valid x/y and # of fingers did not change.
+	 * If the # of fingers just changed, acting on the new x/y values will
+	 * cause the cursor to jump across the screen or the page to scroll
+	 * unexpectedly.
+	 */
+
+	if (x && y && (dev->fingers_old == fingers)) {
 		if (dev->x_old != -1) {
 			if (legacy == true) {
 				x = atp_smooth_legacy(x, dev->x_old);
@@ -765,7 +792,7 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 			input_report_abs(dev->input, ABS_Y, y);
 			input_report_abs(dev->input, ABS_PRESSURE,
 					 min(ATP_PRESSURE, x_z + y_z));
-			atp_report_fingers(dev->input, max(x_f, y_f));
+			atp_report_fingers(dev->input, fingers);
 		}
 		atp_refresh_old_xy(x, y, dev);
 
@@ -780,6 +807,12 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
 	}
 
+	/* if # of fingers changed, old x/y values are no longer useful */
+	if (dev->fingers_old != fingers)
+		atp_reset_old_xy(dev);
+
+	dev->fingers_old = fingers;
+
 	input_report_key(dev->input, BTN_LEFT, key);
 	input_sync(dev->input);
 
-- 
1.7.9.5

