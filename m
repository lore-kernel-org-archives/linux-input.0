From: Florian Loitsch <linux@florian.loitsch.com>
Subject: Re: appletouch position calculation
Date: Sat, 26 May 2007 19:48:04 +0200
Message-ID: <200705261948.04141.linux@florian.loitsch.com>
References: <200705050343.10647.linux@florian.loitsch.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763491AbXEZRtV@vger.kernel.org>
In-Reply-To: <200705050343.10647.linux@florian.loitsch.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Another macbook touchpad patch. Tries to follow the first detected finger.

any comments appreciated.

could somebody rapidly give me a link to create correct patches, so I could 
send correct patches to the maintainer (I can't find any 'signoff' option 
in 'git show' and I'm not able to select specific commits with 'git 
format-patch').

thanks,
// florian loitsch

commit 191faef8618a5471b9ad5db93fb0ca6eb9b1e66e
Author: Florian Loitsch <oss@florian.loitsch.com>
Date:   Sat May 26 19:21:54 2007 +0200

    calculate position of all fingers and choose the one closest to the old 
one.

diff --git a/drivers/input/mouse/appletouch.c 
b/drivers/input/mouse/appletouch.c
index 2162021..ba86504 100644
--- a/drivers/input/mouse/appletouch.c
+++ b/drivers/input/mouse/appletouch.c
@@ -191,9 +191,12 @@ MODULE_PARM_DESC(threshold, "Discards any change in data 
from a sensor (trackpad
 static int x_position_mode = ATP_MEAN_POS;
 module_param(x_position_mode, int, 0644);
 MODULE_PARM_DESC(x_position_mode, "0 == mean, 1 == left-most finger, 2 == 
mean of all fingers, 3 == right-most finger");
-static int y_position_mode = ATP_MEAN_POS;
+static int y_position_mode = ATP_FIRST_FINGER_POS;
 module_param(y_position_mode, int, 0644);
 MODULE_PARM_DESC(y_position_mode, "0 == mean, 1 == top finger, 2 == mean of 
all fingers, 3 == bottom finger");
+static int closest_position = ATP_LAST_FINGER_POS;
+module_param(closest_position, int, 0644);
+MODULE_PARM_DESC(closest_position, "follow finger: 0 == deactivated, 1 == 
activated");
 
 static int debug = 1;
 module_param(debug, int, 0644);
@@ -230,7 +233,7 @@ static inline int atp_is_geyser_3(struct atp *dev)
  *   * the position of the last found finger (ATP_LAST_FINGER_POS)
  */
 static int atp_calculate_abs(int *xy_sensors, int nb_sensors, int fact,
-			     int mode, int *z, int *fingers)
+			     int old_pos, int mode, int *z, int *fingers)
 {
 	int i;
 	/* values to calculate mean */
@@ -239,6 +242,8 @@ static int atp_calculate_abs(int *xy_sensors, int 
nb_sensors, int fact,
 	int finger_pos;
 	int res_pos = 0; /* used as tmp-accumulator too */
 	int first_finger = 1;
+	int min_dist = INT_MAX;
+	int dist;
 
 	*fingers = 0;
 
@@ -277,15 +282,22 @@ static int atp_calculate_abs(int *xy_sensors, int 
nb_sensors, int fact,
 			i++;
 		}
 
+		finger_pos = finger_pcum * fact / finger_psum;
 		if (mode == ATP_MEAN_POS)
 			res_pos += finger_pcum;
-		else {
-			finger_pos = finger_pcum * fact / finger_psum;
-			if ((first_finger && mode == ATP_FIRST_FINGER_POS) ||
-			    mode == ATP_LAST_FINGER_POS)
+		else if (mode == ATP_MEAN_FINGER_POS)
+			res_pos += finger_pos;
+		/* closest_position takes precedence over first/last finger */
+		else if (closest_position && old_pos >= 0) {
+			dist = abs(old_pos - finger_pos);
+			if (dist < min_dist) {
+				min_dist = dist;
 				res_pos = finger_pos;
-			else if (mode == ATP_MEAN_FINGER_POS)
-				res_pos += finger_pos;
+			}
+		} else if (mode == ATP_LAST_FINGER_POS) {
+			res_pos = finger_pos;
+		} else if (mode == ATP_FIRST_FINGER_POS && first_finger) {
+			res_pos = finger_pos;
 		}
 
 		(*fingers)++;
@@ -450,9 +462,11 @@ static void atp_complete(struct urb* urb)
 	dbg_dump("accumulator", dev->xy_acc);
 
 	x = atp_calculate_abs(dev->xy_acc, ATP_XSENSORS,
-			      ATP_XFACT, x_position_mode, &x_z, &x_f);
+			      ATP_XFACT, dev->x_old, x_position_mode,
+			      &x_z, &x_f);
 	y = atp_calculate_abs(dev->xy_acc + ATP_XSENSORS, ATP_YSENSORS,
-			      ATP_YFACT, y_position_mode, &y_z, &y_f);
+			      ATP_YFACT, dev->y_old, y_position_mode,
+			      &y_z, &y_f);
 
 	fingers = max(x_f, y_f);
 	if (x && y) {
