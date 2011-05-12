From: <michael.hennerich@analog.com>
Subject: [PATCH v2 5/6] input: misc: AD714x: Fix captouch wheel option algorithm
Date: Thu, 12 May 2011 10:45:10 +0200
Message-ID: <1305189911-24769-5-git-send-email-michael.hennerich@analog.com>
References: <1305189911-24769-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from am1ehsobe001.messaging.microsoft.com ([213.199.154.204]:31873
	"EHLO AM1EHSOBE001.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752174Ab1ELIyr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2011 04:54:47 -0400
In-Reply-To: <1305189911-24769-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, jeff.dagenais@gmail.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

As reported by Jean-Francois Dagenais, the wheel algorithm caused a
divide by zero exception due to missing variable pre-initialization.
In fact it turned out that the whole algorithm had several problems.
It is therefore replaced with something that is known working.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/misc/ad714x.c |  109 ++++++++-----------------------------------
 1 files changed, 19 insertions(+), 90 deletions(-)

diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index b4d95d5..137c39a 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -79,13 +79,7 @@ struct ad714x_slider_drv {
 struct ad714x_wheel_drv {
 	int abs_pos;
 	int flt_pos;
-	int pre_mean_value;
 	int pre_highest_stage;
-	int pre_mean_value_no_offset;
-	int mean_value;
-	int mean_value_no_offset;
-	int pos_offset;
-	int pos_ratio;
 	int highest_stage;
 	enum ad714x_device_state state;
 	struct input_dev *input;
@@ -407,7 +401,6 @@ static void ad714x_slider_state_machine(struct ad714x_chip *ad714x, int idx)
 				ad714x_slider_cal_highest_stage(ad714x, idx);
 				ad714x_slider_cal_abs_pos(ad714x, idx);
 				ad714x_slider_cal_flt_pos(ad714x, idx);
-
 				input_report_abs(sw->input, ABS_X, sw->flt_pos);
 				input_report_key(sw->input, BTN_TOUCH, 1);
 			} else {
@@ -473,104 +466,41 @@ static void ad714x_wheel_cal_sensor_val(struct ad714x_chip *ad714x, int idx)
 /*
  * When the scroll wheel is activated, we compute the absolute position based
  * on the sensor values. To calculate the position, we first determine the
- * sensor that has the greatest response among the 8 sensors that constitutes
- * the scrollwheel. Then we determined the 2 sensors on either sides of the
+ * sensor that has the greatest response among the sensors that constitutes
+ * the scrollwheel. Then we determined the sensors on either sides of the
  * sensor with the highest response and we apply weights to these sensors. The
- * result of this computation gives us the mean value which defined by the
- * following formula:
- * For i= second_before_highest_stage to i= second_after_highest_stage
- *         v += Sensor response(i)*WEIGHT*(i+3)
- *         w += Sensor response(i)
- * Mean_Value=v/w
- * pos_on_scrollwheel = (Mean_Value - position_offset) / position_ratio
+ * result of this computation gives us the mean value.
  */
 
-#define WEIGHT_FACTOR 30
-/* This constant prevents the "PositionOffset" from reaching a big value */
-#define OFFSET_POSITION_CLAMP	120
 static void ad714x_wheel_cal_abs_pos(struct ad714x_chip *ad714x, int idx)
 {
 	struct ad714x_wheel_plat *hw = &ad714x->hw->wheel[idx];
 	struct ad714x_wheel_drv *sw = &ad714x->sw->wheel[idx];
 	int stage_num = hw->end_stage - hw->start_stage + 1;
-	int second_before, first_before, highest, first_after, second_after;
+	int first_before, highest, first_after;
 	int a_param, b_param;
 
-	/* Calculate Mean value */
-
-	second_before = (sw->highest_stage + stage_num - 2) % stage_num;
 	first_before = (sw->highest_stage + stage_num - 1) % stage_num;
 	highest = sw->highest_stage;
 	first_after = (sw->highest_stage + stage_num + 1) % stage_num;
-	second_after = (sw->highest_stage + stage_num + 2) % stage_num;
-
-	if (((sw->highest_stage - hw->start_stage) > 1) &&
-	    ((hw->end_stage - sw->highest_stage) > 1)) {
-		a_param = ad714x->sensor_val[second_before] *
-			(second_before - hw->start_stage + 3) +
-			ad714x->sensor_val[first_before] *
-			(second_before - hw->start_stage + 3) +
-			ad714x->sensor_val[highest] *
-			(second_before - hw->start_stage + 3) +
-			ad714x->sensor_val[first_after] *
-			(first_after - hw->start_stage + 3) +
-			ad714x->sensor_val[second_after] *
-			(second_after - hw->start_stage + 3);
-	} else {
-		a_param = ad714x->sensor_val[second_before] *
-			(second_before - hw->start_stage + 1) +
-			ad714x->sensor_val[first_before] *
-			(second_before - hw->start_stage + 2) +
-			ad714x->sensor_val[highest] *
-			(second_before - hw->start_stage + 3) +
-			ad714x->sensor_val[first_after] *
-			(first_after - hw->start_stage + 4) +
-			ad714x->sensor_val[second_after] *
-			(second_after - hw->start_stage + 5);
-	}
-	a_param *= WEIGHT_FACTOR;
 
-	b_param = ad714x->sensor_val[second_before] +
+	a_param = ad714x->sensor_val[highest] *
+		(highest - hw->start_stage) +
+		ad714x->sensor_val[first_before] *
+		(highest - hw->start_stage - 1) +
+		ad714x->sensor_val[first_after] *
+		(highest - hw->start_stage + 1);
+	b_param = ad714x->sensor_val[highest] +
 		ad714x->sensor_val[first_before] +
-		ad714x->sensor_val[highest] +
-		ad714x->sensor_val[first_after] +
-		ad714x->sensor_val[second_after];
-
-	sw->pre_mean_value = sw->mean_value;
-	sw->mean_value = a_param / b_param;
-
-	/* Calculate the offset */
-
-	if ((sw->pre_highest_stage == hw->end_stage) &&
-			(sw->highest_stage == hw->start_stage))
-		sw->pos_offset = sw->mean_value;
-	else if ((sw->pre_highest_stage == hw->start_stage) &&
-			(sw->highest_stage == hw->end_stage))
-		sw->pos_offset = sw->pre_mean_value;
-
-	if (sw->pos_offset > OFFSET_POSITION_CLAMP)
-		sw->pos_offset = OFFSET_POSITION_CLAMP;
-
-	/* Calculate the mean value without the offset */
-
-	sw->pre_mean_value_no_offset = sw->mean_value_no_offset;
-	sw->mean_value_no_offset = sw->mean_value - sw->pos_offset;
-	if (sw->mean_value_no_offset < 0)
-		sw->mean_value_no_offset = 0;
-
-	/* Calculate ratio to scale down to NUMBER_OF_WANTED_POSITIONS */
-
-	if ((sw->pre_highest_stage == hw->end_stage) &&
-			(sw->highest_stage == hw->start_stage))
-		sw->pos_ratio = (sw->pre_mean_value_no_offset * 100) /
-			hw->max_coord;
-	else if ((sw->pre_highest_stage == hw->start_stage) &&
-			(sw->highest_stage == hw->end_stage))
-		sw->pos_ratio = (sw->mean_value_no_offset * 100) /
-			hw->max_coord;
-	sw->abs_pos = (sw->mean_value_no_offset * 100) / sw->pos_ratio;
+		ad714x->sensor_val[first_after];
+
+	sw->abs_pos = ((hw->max_coord / (hw->end_stage - hw->start_stage)) *
+			a_param) / b_param;
+
 	if (sw->abs_pos > hw->max_coord)
 		sw->abs_pos = hw->max_coord;
+	else if (sw->abs_pos < 0)
+		sw->abs_pos = 0;
 }
 
 static void ad714x_wheel_cal_flt_pos(struct ad714x_chip *ad714x, int idx)
@@ -644,9 +574,8 @@ static void ad714x_wheel_state_machine(struct ad714x_chip *ad714x, int idx)
 				ad714x_wheel_cal_highest_stage(ad714x, idx);
 				ad714x_wheel_cal_abs_pos(ad714x, idx);
 				ad714x_wheel_cal_flt_pos(ad714x, idx);
-
 				input_report_abs(sw->input, ABS_WHEEL,
-					sw->abs_pos);
+					sw->flt_pos);
 				input_report_key(sw->input, BTN_TOUCH, 1);
 			} else {
 				/* When the user lifts off the sensor, configure
-- 
1.6.0.2


