From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 2/2] input: elants: support common touchscreen DT properties
Date: Tue, 13 Jun 2017 17:29:31 +0200
Message-ID: <ece74b1c229e7516172eacb8be69a558426abfd4.1497367336.git.mirq-linux@rere.qmqm.pl>
References: <5ef7cc1aed6127d95cf5d666e5ec84e5e8993c71.1497367336.git.mirq-linux@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from [91.227.64.183] ([91.227.64.183]:53464 "EHLO rere.qmqm.pl"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1750899AbdFMPhL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 13 Jun 2017 11:37:11 -0400
In-Reply-To: <5ef7cc1aed6127d95cf5d666e5ec84e5e8993c71.1497367336.git.mirq-linux@rere.qmqm.pl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Johnny Chuang <johnny.chuang@emc.com.tw>

This allows for axis inversion and overriding of min/max values.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/input/touchscreen/elants_i2c.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
index 6509407f53e49..3d7d7d6559b0c 100644
--- a/drivers/input/touchscreen/elants_i2c.c
+++ b/drivers/input/touchscreen/elants_i2c.c
@@ -35,6 +35,7 @@
 #include <linux/buffer_head.h>
 #include <linux/slab.h>
 #include <linux/firmware.h>
+#include <linux/input/touchscreen.h>
 #include <linux/input/mt.h>
 #include <linux/acpi.h>
 #include <linux/of.h>
@@ -151,8 +152,7 @@ struct elants_data {
 	u16 hw_version;
 	unsigned int x_res;	/* resolution in units/mm */
 	unsigned int y_res;
-	unsigned int x_max;
-	unsigned int y_max;
+	struct touchscreen_properties prop;
 
 	enum elants_state state;
 	enum elants_iap_mode iap_mode;
@@ -502,10 +502,10 @@ static int elants_i2c_query_ts_info(struct elants_data *ts)
 			 rows, cols, osr);
 	} else {
 		/* translate trace number to TS resolution */
-		ts->x_max = ELAN_TS_RESOLUTION(rows, osr);
-		ts->x_res = DIV_ROUND_CLOSEST(ts->x_max, phy_x);
-		ts->y_max = ELAN_TS_RESOLUTION(cols, osr);
-		ts->y_res = DIV_ROUND_CLOSEST(ts->y_max, phy_y);
+		ts->prop.max_x = ELAN_TS_RESOLUTION(rows, osr);
+		ts->x_res = DIV_ROUND_CLOSEST(ts->prop.max_x, phy_x);
+		ts->prop.max_y = ELAN_TS_RESOLUTION(cols, osr);
+		ts->y_res = DIV_ROUND_CLOSEST(ts->prop.max_y, phy_y);
 	}
 
 	return 0;
@@ -836,8 +836,7 @@ static void elants_i2c_mt_event(struct elants_data *ts, u8 *buf, unsigned report
 
 			input_mt_slot(input, i);
 			input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
-			input_event(input, EV_ABS, ABS_MT_POSITION_X, x);
-			input_event(input, EV_ABS, ABS_MT_POSITION_Y, y);
+			touchscreen_report_pos(input, &ts->prop, x, y, true);
 			input_event(input, EV_ABS, ABS_MT_PRESSURE, p);
 			input_event(input, EV_ABS, ABS_MT_TOUCH_MAJOR, w);
 
@@ -1258,13 +1257,15 @@ static int elants_i2c_probe(struct i2c_client *client,
 	ts->input->name = "Elan Touchscreen";
 	ts->input->id.bustype = BUS_I2C;
 
+	touchscreen_parse_properties(ts->input, true, &ts->prop);
+
 	__set_bit(BTN_TOUCH, ts->input->keybit);
 	__set_bit(EV_ABS, ts->input->evbit);
 	__set_bit(EV_KEY, ts->input->evbit);
 
 	/* Single touch input params setup */
-	input_set_abs_params(ts->input, ABS_X, 0, ts->x_max, 0, 0);
-	input_set_abs_params(ts->input, ABS_Y, 0, ts->y_max, 0, 0);
+	input_set_abs_params(ts->input, ABS_X, 0, ts->prop.max_x, 0, 0);
+	input_set_abs_params(ts->input, ABS_Y, 0, ts->prop.max_y, 0, 0);
 	input_set_abs_params(ts->input, ABS_PRESSURE, 0, 255, 0, 0);
 	input_abs_set_res(ts->input, ABS_X, ts->x_res);
 	input_abs_set_res(ts->input, ABS_Y, ts->y_res);
@@ -1278,8 +1279,8 @@ static int elants_i2c_probe(struct i2c_client *client,
 		return error;
 	}
 
-	input_set_abs_params(ts->input, ABS_MT_POSITION_X, 0, ts->x_max, 0, 0);
-	input_set_abs_params(ts->input, ABS_MT_POSITION_Y, 0, ts->y_max, 0, 0);
+	input_set_abs_params(ts->input, ABS_MT_POSITION_X, 0, ts->prop.max_x, 0, 0);
+	input_set_abs_params(ts->input, ABS_MT_POSITION_Y, 0, ts->prop.max_y, 0, 0);
 	input_set_abs_params(ts->input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
 	input_set_abs_params(ts->input, ABS_MT_PRESSURE, 0, 255, 0, 0);
 	input_abs_set_res(ts->input, ABS_MT_POSITION_X, ts->x_res);
-- 
2.11.0

