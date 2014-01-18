From: Clinton Sprain <clintonsprain@gmail.com>
Subject: [PATCH 2/3] input: appletouch: use better cursor movement smoothing
 algorithm
Date: Fri, 17 Jan 2014 19:56:52 -0600
Message-ID: <52D9DF64.2000102@gmail.com>
References: <52D9DE7A.7040509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:63587 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbaARB4z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Jan 2014 20:56:55 -0500
Received: by mail-ie0-f176.google.com with SMTP id lx4so6188766iec.7
        for <linux-input@vger.kernel.org>; Fri, 17 Jan 2014 17:56:55 -0800 (PST)
In-Reply-To: <52D9DE7A.7040509@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

Implements a new algorithm used to smooth cursor
movement, using a sampling of the cursor's last three
positions to modulate the next cursor movement. This
further mitigates the 'stepping' users see when moving
the cursor diagonally. A 'legacy' module parameter has
been added in case the older devices do not like the
new algorithm.

Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>

---
 drivers/input/mouse/appletouch.c |   99 ++++++++++++++++++++++++++++++++------
 1 file changed, 83 insertions(+), 16 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index f5a16ee..4a3bbcd 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -209,13 +209,16 @@ struct atp {
 	bool			overflow_warned;
 	int			x_old;		/* last reported x/y, */
 	int			y_old;		/* used for smoothing */
+	int			x_older;	/* 2nd to last reported x/y,*/
+	int			y_older;	/* used for smoothing */
+	int			x_oldest;       /* 3rd to last reported x/y,*/
+	int			y_oldest;       /* used for smoothing */
 	signed char		xy_cur[ATP_XSENSORS + ATP_YSENSORS];
 	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
 	int			idlecount;	/* number of empty packets */
 	struct work_struct	work;
 };
-
 #define dbg_dump(msg, tab)						\
 {									\
 	if (debug > 1) {						\
@@ -260,6 +263,13 @@ static int debug;
 module_param(debug, int, 0644);
 MODULE_PARM_DESC(debug, "Activate debugging output");
 
+static int legacy;
+module_param(legacy, int, 0644);
+MODULE_PARM_DESC(legacy, "1 = Use old cursor movement smoothing."
+			 " Older behavior averages current with"
+			 " last cursor position. New behavior"
+			 " uses cursor movement inertia.");
+
 /*
  * By default newer Geyser devices send standard USB HID mouse
  * packets (Report ID 2). This code changes device mode, so it
@@ -338,6 +348,49 @@ static void atp_reinit(struct work_struct *work)
 			retval);
 }
 
+static int atp_smooth_legacy(int curr, int old)
+{
+	return (old * 3 + curr) >> 2;
+}
+
+static int atp_smooth(int curr, int old, int older, int oldest)
+{
+	return (oldest + older * 2 + old * 4 + curr) >> 3;
+}
+
+static void atp_refresh_old_xy(int x, int y, struct atp *dev)
+{
+	if (legacy != true) {
+		dev->x_oldest = dev->x_older;
+		dev->y_oldest = dev->y_older;
+		dev->x_older = dev->x_old;
+		dev->y_older = dev->y_old;
+	}
+	dev->x_old = x;
+	dev->y_old = y;
+}
+
+static void atp_reset_old_xy(struct atp *dev)
+{
+	if (legacy != true) {
+		dev->x_oldest = dev->y_oldest = -1;
+		dev->x_older = dev->y_older = -1;
+	}
+	dev->x_old = dev->y_old = -1;
+}
+
+static void atp_default_old_xy(struct atp *dev)
+{
+	if (dev->x_older == -1)
+		dev->x_older = dev->x_old;
+	if (dev->y_older == -1)
+		dev->y_older = dev->y_old;
+	if (dev->x_oldest == -1)
+		dev->x_oldest = dev->x_older;
+	if (dev->y_oldest == -1)
+		dev->y_oldest = dev->y_older;
+}
+
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
 			     int *z, int *fingers)
 {
@@ -570,10 +623,18 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 
 	if (x && y) {
 		if (dev->x_old != -1) {
-			x = (dev->x_old * 3 + x) >> 2;
-			y = (dev->y_old * 3 + y) >> 2;
-			dev->x_old = x;
-			dev->y_old = y;
+			if (legacy == true) {
+				x = atp_smooth_legacy(x, dev->x_old);
+				y = atp_smooth_legacy(y, dev->y_old);
+			} else {
+
+				atp_default_old_xy(dev);
+
+				x = atp_smooth(x, dev->x_old,
+					dev->x_older, dev->x_oldest);
+				y = atp_smooth(y, dev->y_old,
+					dev->y_older, dev->y_oldest);
+			}
 
 			if (debug > 1)
 				printk(KERN_DEBUG "appletouch: "
@@ -587,12 +648,11 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 					 min(ATP_PRESSURE, x_z + y_z));
 			atp_report_fingers(dev->input, max(x_f, y_f));
 		}
-		dev->x_old = x;
-		dev->y_old = y;
+		atp_refresh_old_xy(x, y, dev);
 
 	} else if (!x && !y) {
 
-		dev->x_old = dev->y_old = -1;
+		atp_reset_old_xy(dev);
 		input_report_key(dev->input, BTN_TOUCH, 0);
 		input_report_abs(dev->input, ABS_PRESSURE, 0);
 		atp_report_fingers(dev->input, 0);
@@ -682,10 +742,18 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 
 	if (x && y) {
 		if (dev->x_old != -1) {
-			x = (dev->x_old * 3 + x) >> 2;
-			y = (dev->y_old * 3 + y) >> 2;
-			dev->x_old = x;
-			dev->y_old = y;
+			if (legacy == true) {
+				x = atp_smooth_legacy(x, dev->x_old);
+				y = atp_smooth_legacy(y, dev->y_old);
+			} else {
+
+				atp_default_old_xy(dev);
+
+				x = atp_smooth(x, dev->x_old,
+					dev->x_older, dev->x_oldest);
+				y = atp_smooth(y, dev->y_old,
+					dev->y_older, dev->y_oldest);
+			}
 
 			if (debug > 1)
 				printk(KERN_DEBUG "appletouch: X: %3d Y: %3d "
@@ -699,12 +767,11 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 					 min(ATP_PRESSURE, x_z + y_z));
 			atp_report_fingers(dev->input, max(x_f, y_f));
 		}
-		dev->x_old = x;
-		dev->y_old = y;
+		atp_refresh_old_xy(x, y, dev);
 
 	} else if (!x && !y) {
 
-		dev->x_old = dev->y_old = -1;
+		atp_reset_old_xy(dev);
 		input_report_key(dev->input, BTN_TOUCH, 0);
 		input_report_abs(dev->input, ABS_PRESSURE, 0);
 		atp_report_fingers(dev->input, 0);
@@ -730,7 +797,7 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 	if (!x && !y && !key) {
 		dev->idlecount++;
 		if (dev->idlecount == 10) {
-			dev->x_old = dev->y_old = -1;
+			atp_reset_old_xy(dev);
 			dev->idlecount = 0;
 			schedule_work(&dev->work);
 			/* Don't resubmit urb here, wait for reinit */
-- 
1.7.9.5

