From: Karsten Merker <merker@debian.org>
Subject: [PATCH RFC V3 1/3] Input: goodix - add axis swapping and axis inversion support
Date: Sun, 18 Oct 2015 17:52:57 +0200
Message-ID: <1445183579-29176-2-git-send-email-merker@debian.org>
References: <1445183579-29176-1-git-send-email-merker@debian.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445183579-29176-1-git-send-email-merker@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Karsten Merker <merker@debian.org>
List-Id: linux-input@vger.kernel.org

Implement support for the following device-tree and ACPI 5.1 DSD
properties in the goodix touchscreen driver:

 - touchscreen-inverted-x:  X axis is inverted (boolean)
 - touchscreen-inverted-y:  Y axis is inverted (boolean)
 - touchscreen-swapped-x-y: X and Y axis are swapped (boolean)

These are necessary on tablets which have a display in portrait
format while the touchscreen is in landscape format, such as e.g.
the MSI Primo 81.

Signed-off-by: Karsten Merker <merker@debian.org>
Tested-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/input/touchscreen/goodix.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 22bfc4b..b585123 100644
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
@@ -53,6 +54,9 @@ struct goodix_ts_data {
 	atomic_t open_count;
 	/* Protects power management calls and access to suspended flag */
 	struct mutex mutex;
+	bool swapped_x_y;
+	bool inverted_x;
+	bool inverted_y;
 };
 
 #define GOODIX_GPIO_INT_NAME		"irq"
@@ -271,6 +275,14 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
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
@@ -666,6 +678,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 			 error);
 		ts->abs_x_max = GOODIX_MAX_WIDTH;
 		ts->abs_y_max = GOODIX_MAX_HEIGHT;
+		if (ts->swapped_x_y)
+			swap(ts->abs_x_max, ts->abs_y_max);
 		ts->int_trigger_type = GOODIX_INT_TRIGGER;
 		ts->max_touch_num = GOODIX_MAX_CONTACTS;
 		return;
@@ -673,6 +687,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 
 	ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
 	ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
+	if (ts->swapped_x_y)
+		swap(ts->abs_x_max, ts->abs_y_max);
 	ts->int_trigger_type = config[TRIGGER_LOC] & 0x03;
 	ts->max_touch_num = config[MAX_CONTACTS_LOC] & 0x0f;
 	if (!ts->abs_x_max || !ts->abs_y_max || !ts->max_touch_num) {
@@ -680,6 +696,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 			"Invalid config, using defaults\n");
 		ts->abs_x_max = GOODIX_MAX_WIDTH;
 		ts->abs_y_max = GOODIX_MAX_HEIGHT;
+		if (ts->swapped_x_y)
+			swap(ts->abs_x_max, ts->abs_y_max);
 		ts->max_touch_num = GOODIX_MAX_CONTACTS;
 	}
 
@@ -805,6 +823,13 @@ static int goodix_configure_dev(struct goodix_ts_data *ts)
 {
 	int error;
 
+	ts->swapped_x_y = device_property_read_bool(&ts->client->dev,
+						    "touchscreen-swapped-x-y");
+	ts->inverted_x = device_property_read_bool(&ts->client->dev,
+						   "touchscreen-inverted-x");
+	ts->inverted_y = device_property_read_bool(&ts->client->dev,
+						   "touchscreen-inverted-y");
+
 	goodix_read_config(ts);
 
 	error = goodix_request_input_dev(ts);
-- 
2.1.4
