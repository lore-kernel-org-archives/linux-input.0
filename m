From: Clinton Sprain <clintonsprain@gmail.com>
Subject: [PATCH v4 2/3] input: appletouch: implement sensor data smoothing
Date: Wed, 12 Mar 2014 18:16:21 -0500
Message-ID: <5320EAC5.5000506@gmail.com>
References: <52D9DE7A.7040509@gmail.com> <5320EA03.2040206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:41634 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752270AbaCLXQj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Mar 2014 19:16:39 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so202760ier.13
        for <linux-input@vger.kernel.org>; Wed, 12 Mar 2014 16:16:23 -0700 (PDT)
In-Reply-To: <5320EA03.2040206@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

input: appletouch: implement sensor data smoothing

Use smoothed version of sensor array data to calculate movement and add weight
to prior values when calculating average. This gives more granular and more
predictable movement.

Signed-off-by: Clinton Sprain <clintonsprain@gmail.com>
---
 drivers/input/mouse/appletouch.c |   72 ++++++++++++++++++++++++++++----------
 1 file changed, 53 insertions(+), 19 deletions(-)

diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
index 2745832..e00f126 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -332,7 +332,11 @@ static void atp_reinit(struct work_struct *work)
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
 			     int *z, int *fingers)
 {
-	int i;
+	int i, k;
+	int smooth[nb_sensors + 8];
+	int smooth_tmp[nb_sensors + 8];
+	int scale = 12;
+
 	/* values to calculate mean */
 	int pcum = 0, psum = 0;
 	int is_increasing = 0;
@@ -344,9 +348,6 @@ static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
 			if (is_increasing)
 				is_increasing = 0;
 
-			continue;
-		}
-
 		/*
 		 * Makes the finger detection more versatile.  For example,
 		 * two fingers with no gap will be detected.  Also, my
@@ -361,27 +362,60 @@ static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
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
+	/*
+	 * Use a smoothed version of sensor data for movement calculations, to
+	 * combat noise without needing to rely so heavily on a threshold.
+	 * This improves tracking.
+	 *
+	 * The smoothed array is bigger than the original so that the smoothing
+	 * doesn't result in edge values being truncated.
+	 */
+
+	for (i = 0; i < 4; i++)
+		smooth[i] = 0;
+	for (i = nb_sensors + 4; i < nb_sensors + 8; i++)
+		smooth[i] = 0;
+
+	/* Pull base values, scaled up to help avoid truncation errors. */
+
+	for (i = 0; i < nb_sensors; i++)
+		smooth[i + 4] = xy_sensors[i] << scale;
+
+	for (k = 0; k < 4; k++) {
+
+		/* Handle edge. */
+		smooth_tmp[0] = (smooth[0] + smooth[1]) >> 1;
+
+		/* Average values with neighbors. */
+		for (i = 1; i < nb_sensors + 7; i++)
+			smooth_tmp[i] = (smooth[i - 1] + smooth[i] * 2 + smooth[i + 1]) >> 2;
+
+		/* Handle other edge. */
+		smooth_tmp[nb_sensors + 7] = (smooth[nb_sensors + 7] + smooth[nb_sensors + 6]) >> 1;
+
+		for (i = 0; i < nb_sensors + 8; i++)
+			smooth[i] = smooth_tmp[i];
+	}
+
+	for (i = 0; i < nb_sensors + 8; i++) {
+		if ((smooth[i] >> scale) > 0) {  /* Skip individual values if */
+			pcum += (smooth[i]) * i; /* they are small enough to  */
+			psum += (smooth[i]);     /* be truncated to 0 by our  */
+		}                                /* scale; mostly just noise. */
 	}
 
 	if (psum > 0) {
-		*z = psum;
+		*z = psum >> scale;            /* Scale down pressure output. */
 		return pcum * fact / psum;
 	}
 
@@ -559,8 +593,8 @@ static void atp_complete_geyser_1_2(struct urb *urb)
 
 	if (x && y) {
 		if (dev->x_old != -1) {
-			x = (dev->x_old * 3 + x) >> 2;
-			y = (dev->y_old * 3 + y) >> 2;
+			x = (dev->x_old * 7 + x) >> 3;
+			y = (dev->y_old * 7 + y) >> 3;
 			dev->x_old = x;
 			dev->y_old = y;
 
@@ -671,8 +705,8 @@ static void atp_complete_geyser_3_4(struct urb *urb)
 
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
