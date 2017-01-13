From: Lucas Stach <l.stach@pengutronix.de>
Subject: [PATCH] Input: synaptics-rmi4: correctly swap clip values if axes are swapped
Date: Fri, 13 Jan 2017 18:43:24 +0100
Message-ID: <20170113174324.3393-1-l.stach@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38957 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750947AbdAMRna (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Jan 2017 12:43:30 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-input@vger.kernel.org, Nick Dyer <nick@shmanahar.org>, Chris Healy <cphealy@gmail.com>, kernel@pengutronix.de, patchwork-lst@pengutronix.de

The clip values need the same swapping as the maximium values if the
sensor axes are swapped.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/input/rmi4/rmi_2d_sensor.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_2d_sensor.c b/drivers/input/rmi4/rmi_2d_sensor.c
index 07007ff8e29f..8bb866c7b985 100644
--- a/drivers/input/rmi4/rmi_2d_sensor.c
+++ b/drivers/input/rmi4/rmi_2d_sensor.c
@@ -144,8 +144,13 @@ static void rmi_2d_sensor_set_input_params(struct rmi_2d_sensor *sensor)
 	int input_flags = 0;
 
 	if (sensor->report_abs) {
-		if (sensor->axis_align.swap_axes)
+		if (sensor->axis_align.swap_axes) {
 			swap(sensor->max_x, sensor->max_y);
+			swap(sensor->axis_align.clip_x_low,
+			     sensor->axis_align.clip_y_low);
+			swap(sensor->axis_align.clip_x_high,
+			     sensor->axis_align.clip_y_high);
+		}
 
 		sensor->min_x = sensor->axis_align.clip_x_low;
 		if (sensor->axis_align.clip_x_high)
-- 
2.11.0

