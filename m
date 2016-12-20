From: Nick Dyer <nick@shmanahar.org>
Subject: RMI4 F12 clipping issues
Date: Tue, 20 Dec 2016 21:29:58 +0000
Message-ID: <20161220212957.GA19338@lava.h.shmanahar.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avasout06.plus.net ([212.159.14.18]:46861 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765211AbcLTVaC (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Dec 2016 16:30:02 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Heiny <cheiny@synaptics.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Andrew Duggan <aduggan@synaptics.com>, linux-input@vger.kernel.org

Hi Christopher-

I wonder if you could comment on an issue we've seen with the mainline
RMI4 driver code?

We've discovered that the code where the driver adjusts the positions
reported to the input layer, according to Low/High Transmitter/Receiver
clip values read out of F12 ctrl register 08, doesn't seem to work
properly. It ends up with a stripe of co-ordinates down one side of the
screen which is inaccessible to input touches.

The below patch shows the lines causing the proble. It does fix our
issue, although obviously it's not a proper fix. I suspect the root
cause is that clipping as set in F12 ctrl register 08 has a different
use case (and units) to clipping as defined via device tree, so we
shouldn't be reading these values into clip_x_low etc in rmi_f12.c in
the first place. Do you agree?

I think there's another minor issue in that we should be passing
sensor->min_x to input_set_abs_params(ABS_MT_POSITION_X).

cheers

Nick

---
 drivers/input/rmi4/rmi_2d_sensor.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index e97bd7f..5f474b4 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -52,15 +52,6 @@ void rmi_2d_sensor_abs_process(struct rmi_2d_sensor *sensor,
 	obj->x += axis_align->offset_x;
 	obj->y += axis_align->offset_y;
 
-	obj->x =  max(axis_align->clip_x_low, obj->x);
-	obj->y =  max(axis_align->clip_y_low, obj->y);
-
-	if (axis_align->clip_x_high)
-		obj->x = min(sensor->max_x, obj->x);
-
-	if (axis_align->clip_y_high)
-		obj->y =  min(sensor->max_y, obj->y);
-
 	sensor->tracking_pos[slot].x = obj->x;
 	sensor->tracking_pos[slot].y = obj->y;
 }
@@ -147,16 +138,6 @@ static void rmi_2d_sensor_set_input_params(struct rmi_2d_sensor *sensor)
 		if (sensor->axis_align.swap_axes)
 			swap(sensor->max_x, sensor->max_y);
 
-		sensor->min_x = sensor->axis_align.clip_x_low;
-		if (sensor->axis_align.clip_x_high)
-			sensor->max_x = min(sensor->max_x,
-				sensor->axis_align.clip_x_high);
-
-		sensor->min_y = sensor->axis_align.clip_y_low;
-		if (sensor->axis_align.clip_y_high)
-			sensor->max_y = min(sensor->max_y,
-				sensor->axis_align.clip_y_high);
-
 		set_bit(EV_ABS, input->evbit);
 		input_set_abs_params(input, ABS_MT_POSITION_X, 0, sensor->max_x,
 					0, 0);
-- 
2.7.4

