From: Clinton Sprain <clintonsprain@gmail.com>
Subject: [PATCH v5 2/3] input: appletouch: implement sensor data smoothing
Date: Sat, 29 Mar 2014 16:47:57 -0500
Message-ID: <53373F8D.6030604@gmail.com>
References: <52D9DE7A.7040509@gmail.com> <5320EA03.2040206@gmail.com> <5320EAC5.5000506@gmail.com> <20140327182606.GA8902@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:42867 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbaC2VsA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 29 Mar 2014 17:48:00 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so6163287iec.7
        for <linux-input@vger.kernel.org>; Sat, 29 Mar 2014 14:47:59 -0700 (PDT)
In-Reply-To: <20140327182606.GA8902@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Clinton Sprain <clintonsprain@gmail.com>
Cc: linux-input@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>

input: appletouch: implement sensor data smoothing

Use smoothed version of sensor array data to calculate movement and add weight
to prior values when calculating average. This gives more granular and more
predictable movement.

Changes since v4:
- Scale is now defined as ATP_SCALE
- Smoothing scratch buffers now a part of dev structure
- Now passing dev into atp_calculate_abs
- Now leaving atp_calculate_abs early if no fingers are detected

Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>
---
 drivers/input/mouse/appletouch.c |  110 +++++++++++++++++++++++++++-----------
 1 file changed, 80 insertions(+), 30 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 2745832..8e01363 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -161,6 +161,12 @@ MODULE_DEVICE_TABLE(usb, atp_table);
 #define ATP_XSENSORS	26
 #define ATP_YSENSORS	16
 
+/*
+ * The largest possible bank of sensors with additional buffer of 4 extra values
+ * on either side, for an array of smoothed sensor values.
+ */
+#define ATP_SMOOTHSIZE	34
+
 /* maximum pressure this driver will report */
 #define ATP_PRESSURE	300
 
@@ -168,7 +174,13 @@ MODULE_DEVICE_TABLE(usb, atp_table);
  * Threshold for the touchpad sensors. Any change less than ATP_THRESHOLD is
  * ignored.
  */
-#define ATP_THRESHOLD	 5
+#define ATP_THRESHOLD	5
+
+/*
+ * How far we'll bitshift our sensor values before averaging them. Mitigates
+ * rounding errors.
+ */
+#define ATP_SCALE	12
 
 /* Geyser initialization constants */
 #define ATP_GEYSER_MODE_READ_REQUEST_ID		1
@@ -211,6 +223,8 @@ struct atp {
 	signed char		xy_cur[ATP_XSENSORS + ATP_YSENSORS];
 	signed char		xy_old[ATP_XSENSORS + ATP_YSENSORS];
 	int			xy_acc[ATP_XSENSORS + ATP_YSENSORS];
+	int			smooth[ATP_SMOOTHSIZE];
+	int			smooth_tmp[ATP_SMOOTHSIZE];
 	int			idlecount;	/* number of empty packets */
 	struct work_struct	work;
 };
@@ -329,10 +343,15 @@ static void atp_reinit(struct work_struct *work)
 			retval);
 }
 
-static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
-			     int *z, int *fingers)
+static int atp_calculate_abs(struct atp *dev, int offset, int nb_sensors,
+			     int fact, int *z, int *fingers)
 {
-	int i;
+	int i, k;
+
+	/* Use offset to point xy_sensors at the first value in dev->xy_acc   */
+	/* for whichever dimension we're looking at this particular go-round. */
+	int *xy_sensors = dev->xy_acc + offset;
+
 	/* values to calculate mean */
 	int pcum = 0, psum = 0;
 	int is_increasing = 0;
@@ -344,9 +363,6 @@ static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
 			if (is_increasing)
 				is_increasing = 0;
 
-			continue;
-		}
-
 		/*
 		 * Makes the finger detection more versatile.  For example,
 		 * two fingers with no gap will be detected.  Also, my
@@ -361,27 +377,60 @@ static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
 		 *
 		 * - Jason Parekh <jasonparekh@gmail.com>
 		 */
-		if (i < 1 ||
+
+		} else if (i < 1 ||
 		    (!is_increasing && xy_sensors[i - 1] < xy_sensors[i])) {
 			(*fingers)++;
 			is_increasing = 1;
 		} else if (i > 0 && (xy_sensors[i - 1] - xy_sensors[i] > threshold)) {
 			is_increasing = 0;
 		}
+	}
 
-		/*
-		 * Subtracts threshold so a high sensor that just passes the
-		 * threshold won't skew the calculated absolute coordinate.
-		 * Fixes an issue where slowly moving the mouse would
-		 * occasionally jump a number of pixels (slowly moving the
-		 * finger makes this issue most apparent.)
-		 */
-		pcum += (xy_sensors[i] - threshold) * i;
-		psum += (xy_sensors[i] - threshold);
+	if (*fingers < 1)     /* No need to continue if no fingers are found. */
+		return 0;
+
+	/*
+	 * Use a smoothed version of sensor data for movement calculations, to
+	 * combat noise without needing to rely so heavily on a threshold.
+	 * This improves tracking.
+	 *
+	 * The smoothed array is bigger than the original so that the smoothing
+	 * doesn't result in edge values being truncated.
+	 */
+
+	memset(dev->smooth, 0, sizeof(dev->smooth));
+	memset(dev->smooth_tmp, 0, sizeof(dev->smooth_tmp));
+
+	/* Pull base values, scaled up to help avoid truncation errors. */
+
+	for (i = 0; i < nb_sensors; i++)
+		dev->smooth[i + 4] = xy_sensors[i] << ATP_SCALE;
+
+	for (k = 0; k < 4; k++) {
+		/* Handle edge. */
+		dev->smooth_tmp[0] = (dev->smooth[0] + dev->smooth[1]) >> 1;
+
+		/* Average values with neighbors. */
+		for (i = 1; i < nb_sensors + 7; i++)
+			dev->smooth_tmp[i] = (dev->smooth[i - 1] + dev->smooth[i] * 2 + dev->smooth[i + 1]) >> 2;
+
+		/* Handle other edge. */
+		dev->smooth_tmp[nb_sensors + 7] = (dev->smooth[nb_sensors + 7] + dev->smooth[nb_sensors + 6]) >> 1;
+
+		for (i = 0; i < nb_sensors + 8; i++)
+			dev->smooth[i] = dev->smooth_tmp[i];
+	}
+
+	for (i = 0; i < nb_sensors + 8; i++) {
+		if ((dev->smooth[i] >> ATP_SCALE) > 0) {  /* Skip values if   */
+			pcum += (dev->smooth[i]) * i; /* they're small enough */
+			psum += (dev->smooth[i]);     /* to be truncated to 0 */
+		}                                  /* by scale. Mostly noise. */
 	}
 
 	if (psum > 0) {
-		*z = psum;
+		*z = psum >> ATP_SCALE;        /* Scale down pressure output. */
 		return pcum * fact / psum;
 	}
 
@@ -551,16 +600,16 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 
 	dbg_dump("accumulator", dev->xy_acc);
 
-	x = atp_calculate_abs(dev->xy_acc, ATP_XSENSORS,
-			      dev->info->xfact, &x_z, &x_f);
-	y = atp_calculate_abs(dev->xy_acc + ATP_XSENSORS, ATP_YSENSORS,
-			      dev->info->yfact, &y_z, &y_f);
+	x = atp_calculate_abs(dev, 0, ATP_XSENSORS, dev->info->xfact,
+			      &x_z, &x_f);
+	y = atp_calculate_abs(dev, ATP_XSENSORS, ATP_YSENSORS, dev->info->yfact,
+			      &y_z, &y_f);
 	key = dev->data[dev->info->datalen - 1] & ATP_STATUS_BUTTON;
 
 	if (x && y) {
 		if (dev->x_old != -1) {
-			x = (dev->x_old * 3 + x) >> 2;
-			y = (dev->y_old * 3 + y) >> 2;
+			x = (dev->x_old * 7 + x) >> 3;
+			y = (dev->y_old * 7 + y) >> 3;
 			dev->x_old = x;
 			dev->y_old = y;
 
@@ -663,16 +712,17 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 
 	dbg_dump("accumulator", dev->xy_acc);
 
-	x = atp_calculate_abs(dev->xy_acc, ATP_XSENSORS,
-			      dev->info->xfact, &x_z, &x_f);
-	y = atp_calculate_abs(dev->xy_acc + ATP_XSENSORS, ATP_YSENSORS,
-			      dev->info->yfact, &y_z, &y_f);
+	x = atp_calculate_abs(dev, 0, ATP_XSENSORS, dev->info->xfact,
+			      &x_z, &x_f);
+	y = atp_calculate_abs(dev, ATP_XSENSORS, ATP_YSENSORS, dev->info->yfact,
+			      &y_z, &y_f);
+
 	key = dev->data[dev->info->datalen - 1] & ATP_STATUS_BUTTON;
 
 	if (x && y) {
 		if (dev->x_old != -1) {
-			x = (dev->x_old * 3 + x) >> 2;
-			y = (dev->y_old * 3 + y) >> 2;
+			x = (dev->x_old * 7 + x) >> 3;
+			y = (dev->y_old * 7 + y) >> 3;
 			dev->x_old = x;
 			dev->y_old = y;
 
-- 
1.7.9.5

