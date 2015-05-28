From: Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/9] input: goodix: fix alignment issues
Date: Thu, 28 May 2015 15:47:37 +0300
Message-ID: <1432817265-23891-2-git-send-email-irina.tirdea@intel.com>
References: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:9326 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514AbbE1MsN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 28 May 2015 08:48:13 -0400
In-Reply-To: <1432817265-23891-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Irina Tirdea <irina.tirdea@intel.com>

Fix alignment to match open parenthesis detected by
running checkpatch.pl --strict.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/input/touchscreen/goodix.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 0d93b1e..c2e785c 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -69,7 +69,7 @@ static const unsigned long goodix_irq_flags[] = {
  * @len: length of the buffer to write
  */
 static int goodix_i2c_read(struct i2c_client *client,
-				u16 reg, u8 *buf, int len)
+			   u16 reg, u8 *buf, int len)
 {
 	struct i2c_msg msgs[2];
 	u16 wbuf = cpu_to_be16(reg);
@@ -78,7 +78,7 @@ static int goodix_i2c_read(struct i2c_client *client,
 	msgs[0].flags = 0;
 	msgs[0].addr  = client->addr;
 	msgs[0].len   = 2;
-	msgs[0].buf   = (u8 *) &wbuf;
+	msgs[0].buf   = (u8 *)&wbuf;
 
 	msgs[1].flags = I2C_M_RD;
 	msgs[1].addr  = client->addr;
@@ -112,7 +112,7 @@ static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 		data += 1 + GOODIX_CONTACT_SIZE;
 		error = goodix_i2c_read(ts->client,
 					GOODIX_READ_COOR_ADDR +
-						1 + GOODIX_CONTACT_SIZE,
+					1 + GOODIX_CONTACT_SIZE,
 					data,
 					GOODIX_CONTACT_SIZE * (touch_num - 1));
 		if (error)
@@ -157,7 +157,8 @@ static void goodix_process_events(struct goodix_ts_data *ts)
 
 	for (i = 0; i < touch_num; i++)
 		goodix_ts_report_touch(ts,
-				&point_data[1 + GOODIX_CONTACT_SIZE * i]);
+				       &point_data[1 +
+				       GOODIX_CONTACT_SIZE * i]);
 
 	input_mt_sync_frame(ts->input_dev);
 	input_sync(ts->input_dev);
@@ -199,8 +200,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 	int error;
 
 	error = goodix_i2c_read(ts->client, GOODIX_REG_CONFIG_DATA,
-			      config,
-			   GOODIX_CONFIG_MAX_LENGTH);
+				config,
+				GOODIX_CONFIG_MAX_LENGTH);
 	if (error) {
 		dev_warn(&ts->client->dev,
 			 "Error reading config (%d), using defaults\n",
@@ -297,9 +298,9 @@ static int goodix_request_input_dev(struct goodix_ts_data *ts)
 				  BIT_MASK(EV_ABS);
 
 	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_X, 0,
-				ts->abs_x_max, 0, 0);
+			     ts->abs_x_max, 0, 0);
 	input_set_abs_params(ts->input_dev, ABS_MT_POSITION_Y, 0,
-				ts->abs_y_max, 0, 0);
+			     ts->abs_y_max, 0, 0);
 	input_set_abs_params(ts->input_dev, ABS_MT_WIDTH_MAJOR, 0, 255, 0, 0);
 	input_set_abs_params(ts->input_dev, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
 
-- 
1.9.1

