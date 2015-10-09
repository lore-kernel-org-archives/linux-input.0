From: Karsten Merker <merker@debian.org>
Subject: [PATCH RFC V2 1/3] Input: goodix - add dt axis swapping and axis inversion support
Date: Fri,  9 Oct 2015 19:55:50 +0200
Message-ID: <1444413352-24529-2-git-send-email-merker@debian.org>
References: <1444413352-24529-1-git-send-email-merker@debian.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:49370 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbbJIR5h (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2015 13:57:37 -0400
In-Reply-To: <1444413352-24529-1-git-send-email-merker@debian.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Irina Tirdea <irina.tirdea@intel.com>, Aleksei Mamlin <mamlinav@gmail.com>, linux-input@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, Karsten Merker <merker@debian.org>

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
index 22bfc4b..a05bdad 100644
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
 
@@ -950,6 +968,15 @@ static int goodix_ts_probe(struct i2c_client *client,
 		return 0;
 	}
 
+#ifdef CONFIG_OF
+	ts->swapped_x_y = of_property_read_bool(client->dev.of_node,
+						"touchscreen-swapped-x-y");
+	ts->inverted_x = of_property_read_bool(client->dev.of_node,
+					       "touchscreen-inverted-x");
+	ts->inverted_y = of_property_read_bool(client->dev.of_node,
+					       "touchscreen-inverted-y");
+#endif
+
 	return goodix_configure_dev(ts);
 
 err_free_cfg_name:
-- 
2.1.4

