From: Karsten Merker <merker@debian.org>
Subject: [PATCH 1/2] Input: goodix - add dt axis swapping and axis inversion support
Date: Thu,  1 Oct 2015 00:29:54 +0200
Message-ID: <1443652195-7104-2-git-send-email-merker@debian.org>
References: <1443652195-7104-1-git-send-email-merker@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443652195-7104-1-git-send-email-merker@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Karsten Merker <merker@debian.org>
List-Id: linux-input@vger.kernel.org

Implement support for the following device-tree properties
in the goodix touchscreen driver:

 - touchscreen-inverted-x:  X axis is inverted (boolean)
 - touchscreen-inverted-y:  Y axis is inverted (boolean)
 - touchscreen-swapped-x-y: X and Y axis are swapped (boolean)

These are necessary on tablets which have a display in portrait
format while the touchscreen is in landscape format, such as e.g.
the MSI Primo 81.

Signed-off-by: Karsten Merker <merker@debian.org>
---
 drivers/input/touchscreen/goodix.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index f8e5b49..f2b1590 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -2,6 +2,7 @@
  *  Driver for Goodix Touchscreens
  *
  *  Copyright (c) 2014 Red Hat Inc.
+ *  Copyright (c) 2015 K. Merker <merker@debian.org>
  *
  *  This code is based on gt9xx.c authored by andrew@goodix.com:
  *
@@ -48,6 +49,9 @@ struct goodix_ts_data {
 	unsigned long irq_flags;
 	atomic_t esd_timeout;
 	struct delayed_work esd_work;
+	bool swapped_x_y;
+	bool inverted_x;
+	bool inverted_y;
 };
 
 #define GOODIX_DEVICE_ESD_TIMEOUT_PROPERTY     "esd-recovery-timeout-ms"
@@ -262,6 +266,14 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
 		input_y = ts->abs_y_max - input_y;
 	}
 
+	/* Inversions have to happen before axis swapping */
+	if (ts->inverted_x)
+		input_x = ts->abs_x_max - input_x;
+	if (ts->inverted_y)
+		input_y = ts->abs_y_max - input_y;
+	if (ts->swapped_x_y)
+		swap(input_x, input_y);
+
 	input_mt_slot(ts->input_dev, id);
 	input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
 	input_report_abs(ts->input_dev, ABS_MT_POSITION_X, input_x);
@@ -670,6 +682,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 			 error);
 		ts->abs_x_max = GOODIX_MAX_WIDTH;
 		ts->abs_y_max = GOODIX_MAX_HEIGHT;
+		if (ts->swapped_x_y)
+			swap(ts->abs_x_max, ts->abs_y_max);
 		ts->int_trigger_type = GOODIX_INT_TRIGGER;
 		ts->max_touch_num = GOODIX_MAX_CONTACTS;
 		return;
@@ -677,6 +691,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 
 	ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
 	ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
+	if (ts->swapped_x_y)
+		swap(ts->abs_x_max, ts->abs_y_max);
 	ts->int_trigger_type = config[TRIGGER_LOC] & 0x03;
 	ts->max_touch_num = config[MAX_CONTACTS_LOC] & 0x0f;
 	if (!ts->abs_x_max || !ts->abs_y_max || !ts->max_touch_num) {
@@ -684,6 +700,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 			"Invalid config, using defaults\n");
 		ts->abs_x_max = GOODIX_MAX_WIDTH;
 		ts->abs_y_max = GOODIX_MAX_HEIGHT;
+		if (ts->swapped_x_y)
+			swap(ts->abs_x_max, ts->abs_y_max);
 		ts->max_touch_num = GOODIX_MAX_CONTACTS;
 	}
 
@@ -913,6 +931,15 @@ static int goodix_ts_probe(struct i2c_client *client,
 
 	ts->cfg_len = goodix_get_cfg_len(ts->id);
 
+#ifdef CONFIG_OF
+	ts->swapped_x_y = of_property_read_bool(client->dev.of_node,
+						"touchscreen-swapped-x-y");
+	ts->inverted_x = of_property_read_bool(client->dev.of_node,
+					       "touchscreen-inverted-x");
+	ts->inverted_y = of_property_read_bool(client->dev.of_node,
+					       "touchscreen-inverted-y");
+#endif
+
 	goodix_read_config(ts);
 
 	if (ts->gpiod_int && ts->gpiod_rst) {
-- 
2.1.4
