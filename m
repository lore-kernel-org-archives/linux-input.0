From: Priit Laes <plaes@plaes.org>
Subject: [PATCH] Input: goodix - preliminary support for GT801-2+1
Date: Sun,  5 Apr 2015 00:08:13 +0300
Message-ID: <1428181693-25362-2-git-send-email-plaes@plaes.org>
References: <1428181693-25362-1-git-send-email-plaes@plaes.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from plaes.org ([188.166.43.21]:54776 "EHLO plaes.org"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752574AbbDDVQs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 4 Apr 2015 17:16:48 -0400
In-Reply-To: <1428181693-25362-1-git-send-email-plaes@plaes.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Priit Laes <plaes@plaes.org>

This patch implements GT801x2 touchscreen support.
Unfortunately, there is a big difference between GT801 and GT9xx series
chips, therefore some advice is needed on how to proceed.

Differences between GT801x2 and GT9xx series:

1. I2C registers: 1 byte (GT801x2) vs 2 bytes (GT9xx)
2. Different configuration layout and version info
3. Different touch report protocol

Signed-off-by: Priit Laes <plaes@plaes.org>
---
 drivers/input/touchscreen/goodix.c | 87 ++++++++++++++++++++++++++++++++------
 1 file changed, 73 insertions(+), 14 deletions(-)

diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
index 3af1698..94e8367 100644
--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -39,15 +39,23 @@ struct goodix_ts_data {
 #define GOODIX_MAX_HEIGHT		4096
 #define GOODIX_MAX_WIDTH		4096
 #define GOODIX_INT_TRIGGER		1
-#define GOODIX_CONTACT_SIZE		8
 #define GOODIX_MAX_CONTACTS		10
 
+#if 0
+#define GOODIX_CONTACT_SIZE		8
 #define GOODIX_CONFIG_MAX_LENGTH	240
 
 /* Register defines */
 #define GOODIX_READ_COOR_ADDR		0x814E
 #define GOODIX_REG_CONFIG_DATA		0x8047
 #define GOODIX_REG_VERSION		0x8140
+#else
+#define GOODIX_READ_COOR_ADDR		0x01
+#define GOODIX_REG_CONFIG_DATA		0x65
+#define GOODIX_REG_VERSION		0xf0
+#define GOODIX_CONFIG_MAX_LENGTH	7
+#define GOODIX_CONTACT_SIZE		5
+#endif
 
 #define RESOLUTION_LOC		1
 #define MAX_CONTACTS_LOC	5
@@ -69,16 +77,15 @@ static const unsigned long goodix_irq_flags[] = {
  * @len: length of the buffer to write
  */
 static int goodix_i2c_read(struct i2c_client *client,
-				u16 reg, u8 *buf, int len)
+				u8 reg, u8 *buf, int len)
 {
 	struct i2c_msg msgs[2];
-	u16 wbuf = cpu_to_be16(reg);
 	int ret;
 
 	msgs[0].flags = 0;
 	msgs[0].addr  = client->addr;
-	msgs[0].len   = 2;
-	msgs[0].buf   = (u8 *) &wbuf;
+	msgs[0].len   = 1;
+	msgs[0].buf   = &reg;
 
 	msgs[1].flags = I2C_M_RD;
 	msgs[1].addr  = client->addr;
@@ -89,6 +96,7 @@ static int goodix_i2c_read(struct i2c_client *client,
 	return ret < 0 ? ret : (ret != ARRAY_SIZE(msgs) ? -EIO : 0);
 }
 
+#if 0
 static int goodix_ts_read_input_report(struct goodix_ts_data *ts, u8 *data)
 {
 	int touch_num;
@@ -133,6 +141,7 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
 	input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, input_w);
 	input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, input_w);
 }
+#endif
 
 /**
  * goodix_process_events - Process incoming events
@@ -144,17 +153,57 @@ static void goodix_ts_report_touch(struct goodix_ts_data *ts, u8 *coor_data)
  */
 static void goodix_process_events(struct goodix_ts_data *ts)
 {
-	u8  point_data[1 + GOODIX_CONTACT_SIZE * ts->max_touch_num];
-	int touch_num;
+	u8 point_data[2 + GOODIX_CONTACT_SIZE * ts->max_touch_num + 1];
+	u8 touch_map[GOODIX_MAX_CONTACTS] = {0};
+	u8 checksum = 0;
 	int i;
+	int loc;
+	int error;
+	int touch_raw;
+	int touch_num;
+	int input_x;
+	int input_y;
+	u8 input_w;
+
+	error = goodix_i2c_read(ts->client, GOODIX_READ_COOR_ADDR, point_data, sizeof(point_data));
 
-	touch_num = goodix_ts_read_input_report(ts, point_data);
-	if (touch_num < 0)
+	if (error) {
+		dev_err(&ts->client->dev, "I2C transfer error: %d\n", error);
 		return;
+	}
+
+	if (!(touch_raw = get_unaligned_le16(&point_data[0])))
+		return;
+
+	touch_num = 0;
+	for (i = 0; (touch_raw != 0) && (i < ts->max_touch_num); i++)
+	{
+		if (touch_raw & 1)
+			touch_map[touch_num++] = i;
+		touch_raw >>= 1;
+	}
+
+	/* TODO: Checksum calculation is buggy */
+	for (i = 0; i < GOODIX_CONTACT_SIZE*touch_num + 3; i++)
+		checksum += point_data[i++];
+
+	dev_debug(&ts->client->dev, "Fingers detected: %d, checksum: %d\n", touch_num, checksum);
 
 	for (i = 0; i < touch_num; i++)
-		goodix_ts_report_touch(ts,
-				&point_data[1 + GOODIX_CONTACT_SIZE * i]);
+	{
+		loc = 2 + GOODIX_CONTACT_SIZE * i;
+		input_x = get_unaligned_be16(&point_data[loc]);
+		input_y = get_unaligned_be16(&point_data[loc + 2]);
+		input_w = point_data[loc + 4];
+		dev_debug(&ts->client->dev, "i: %d: X = %d,Y = %d, W= %d\n", touch_map[i], input_x, input_y, input_w);
+
+		input_mt_slot(ts->input_dev, touch_map[i]);
+		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER, true);
+		input_report_abs(ts->input_dev, ABS_MT_POSITION_X, input_x);
+		input_report_abs(ts->input_dev, ABS_MT_POSITION_Y, input_y);
+		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR, input_w);
+		input_report_abs(ts->input_dev, ABS_MT_WIDTH_MAJOR, input_w);
+	}
 
 	input_mt_sync_frame(ts->input_dev);
 	input_sync(ts->input_dev);
@@ -168,17 +217,21 @@ static void goodix_process_events(struct goodix_ts_data *ts)
  */
 static irqreturn_t goodix_ts_irq_handler(int irq, void *dev_id)
 {
+#if 0
 	static const u8 end_cmd[] = {
 		GOODIX_READ_COOR_ADDR >> 8,
 		GOODIX_READ_COOR_ADDR & 0xff,
 		0
 	};
+#endif
 	struct goodix_ts_data *ts = dev_id;
 
 	goodix_process_events(ts);
 
+#if 0
 	if (i2c_master_send(ts->client, end_cmd, sizeof(end_cmd)) < 0)
 		dev_err(&ts->client->dev, "I2C write end_cmd error\n");
+#endif
 
 	return IRQ_HANDLED;
 }
@@ -209,8 +262,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 		return;
 	}
 
-	ts->abs_x_max = get_unaligned_le16(&config[RESOLUTION_LOC]);
-	ts->abs_y_max = get_unaligned_le16(&config[RESOLUTION_LOC + 2]);
+	ts->abs_x_max = get_unaligned_be16(&config[RESOLUTION_LOC]);
+	ts->abs_y_max = get_unaligned_be16(&config[RESOLUTION_LOC + 2]);
 	ts->int_trigger_type = config[TRIGGER_LOC] & 0x03;
 	ts->max_touch_num = config[MAX_CONTACTS_LOC] & 0x0f;
 	if (!ts->abs_x_max || !ts->abs_y_max || !ts->max_touch_num) {
@@ -220,6 +273,8 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 		ts->abs_y_max = GOODIX_MAX_HEIGHT;
 		ts->max_touch_num = GOODIX_MAX_CONTACTS;
 	}
+	dev_info(&ts->client->dev, "X_MAX = %d,Y_MAX = %d,MAX_TOUCH_NUM = %d\n",
+		 ts->abs_x_max, ts->abs_y_max, ts->max_touch_num);
 }
 
 /**
@@ -231,13 +286,14 @@ static void goodix_read_config(struct goodix_ts_data *ts)
 static int goodix_read_version(struct i2c_client *client, u16 *version)
 {
 	int error;
-	u8 buf[6];
+	u8 buf[16];
 
 	error = goodix_i2c_read(client, GOODIX_REG_VERSION, buf, sizeof(buf));
 	if (error) {
 		dev_err(&client->dev, "read version failed: %d\n", error);
 		return error;
 	}
+	print_hex_dump_bytes("", DUMP_PREFIX_NONE, buf, ARRAY_SIZE(buf));
 
 	if (version)
 		*version = get_unaligned_le16(&buf[4]);
@@ -387,6 +443,8 @@ MODULE_DEVICE_TABLE(acpi, goodix_acpi_match);
 
 #ifdef CONFIG_OF
 static const struct of_device_id goodix_of_match[] = {
+	{ .compatible = "goodix,gt801x2" },
+/*
 	{ .compatible = "goodix,gt911" },
 	{ .compatible = "goodix,gt9110" },
 	{ .compatible = "goodix,gt912" },
@@ -394,6 +452,7 @@ static const struct of_device_id goodix_of_match[] = {
 	{ .compatible = "goodix,gt9271" },
 	{ .compatible = "goodix,gt928" },
 	{ .compatible = "goodix,gt967" },
+*/
 	{ }
 };
 MODULE_DEVICE_TABLE(of, goodix_of_match);
-- 
2.3.5

