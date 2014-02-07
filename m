From: Clinton Sprain <clintonsprain@gmail.com>
Subject: [PATCH v2 3/3] input: appletouch: fix jumps when additional fingers
 are detected
Date: Thu, 06 Feb 2014 18:46:21 -0600
Message-ID: <52F42CDD.30703@gmail.com>
References: <52D9DE7A.7040509@gmail.com> <52F42AEE.3040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:55402 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673AbaBGAqW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Feb 2014 19:46:22 -0500
Received: by mail-ie0-f169.google.com with SMTP id to1so1260307ieb.28
        for <linux-input@vger.kernel.org>; Thu, 06 Feb 2014 16:46:22 -0800 (PST)
In-Reply-To: <52F42AEE.3040505@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

Discard cursor movements if they directly coincide with a change in the number of fingers detected. This helps with two issues - a sudden jump of the cursor when a second finger enters or leaves the touchpad, and an unexpected jump in page scrolling under the same scenario. The fix doesn't completely eliminate the problem but does greatly reduce its frequency and severity.

Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>
---
 drivers/input/mouse/appletouch.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index edbdd95..370d0e9 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -212,6 +212,7 @@ struct atp {
 	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
 	int			idlecount;	/* number of empty packets */
+	int			fingers_old;	/* last reported finger count */
 	struct work_struct	work;
 };
 
@@ -505,6 +506,7 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 	int x, y, x_z, y_z, x_f, y_f;
 	int retval, i, j;
 	int key;
+	int fingers;
 	struct atp *dev = urb->context;
 	int status = atp_status_check(urb);
 
@@ -587,7 +589,9 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 			      dev->info->yfact, &y_z, &y_f);
 	key = dev->data[dev->info->datalen - 1] & ATP_STATUS_BUTTON;
 
-	if (x && y) {
+	fingers = max(x_f, y_f);
+
+	if (x && y && (fingers == dev->fingers_old)) {
 		if (dev->x_old != -1) {
 			x = (dev->x_old * 7 + x) >> 3;
 			y = (dev->y_old * 7 + y) >> 3;
@@ -604,7 +608,7 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 			input_report_abs(dev->input, ABS_Y, y);
 			input_report_abs(dev->input, ABS_PRESSURE,
 					 min(ATP_PRESSURE, x_z + y_z));
-			atp_report_fingers(dev->input, max(x_f, y_f));
+			atp_report_fingers(dev->input, fingers);
 		}
 		dev->x_old = x;
 		dev->y_old = y;
@@ -620,6 +624,10 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 		memset(dev->xy_acc, 0, sizeof(dev->xy_acc));
 	}
 
+	if (fingers != dev->fingers_old)
+		dev->x_old = dev->y_old = -1;
+	dev->fingers_old = fingers;
+
 	input_report_key(dev->input, BTN_LEFT, key);
 	input_sync(dev->input);
 
@@ -638,6 +646,7 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 	int x, y, x_z, y_z, x_f, y_f;
 	int retval, i, j;
 	int key;
+	int fingers;
 	struct atp *dev = urb->context;
 	int status = atp_status_check(urb);
 
@@ -699,7 +708,9 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 			      dev->info->yfact, &y_z, &y_f);
 	key = dev->data[dev->info->datalen - 1] & ATP_STATUS_BUTTON;
 
-	if (x && y) {
+	fingers = max(x_f, y_f);
+
+	if (x && y && (fingers == dev->fingers_old)) {
 		if (dev->x_old != -1) {
 			x = (dev->x_old * 7 + x) >> 3;
 			y = (dev->y_old * 7 + y) >> 3;
@@ -716,7 +727,7 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 			input_report_abs(dev->input, ABS_Y, y);
 			input_report_abs(dev->input, ABS_PRESSURE,
 					 min(ATP_PRESSURE, x_z + y_z));
-			atp_report_fingers(dev->input, max(x_f, y_f));
+			atp_report_fingers(dev->input, fingers);
 		}
 		dev->x_old = x;
 		dev->y_old = y;
@@ -732,6 +743,10 @@ static void atp_complete_geyser_3_4(struct urb *urb)
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
