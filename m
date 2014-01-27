From: Luis Ortega <luiorpe1@upv.es>
Subject: [PATCH 2/4] Input: zforce - fix lines exceeding 80 columns
Date: Mon, 27 Jan 2014 19:46:11 +0100
Message-ID: <1390848373-7723-3-git-send-email-luiorpe1@upv.es>
References: <1390848373-7723-1-git-send-email-luiorpe1@upv.es>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390848373-7723-1-git-send-email-luiorpe1@upv.es>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: heiko@sntech.de, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Ortega <luiorpe1@upv.es>
List-Id: linux-input@vger.kernel.org

Fixed lines exceeding 80 characters long wherever possible,
as per the coding style.

Signed-off-by: Luis Ortega <luiorpe1@upv.es>
---
 drivers/input/touchscreen/zforce_ts.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
index c145c1d..c1b6b82 100644
--- a/drivers/input/touchscreen/zforce_ts.c
+++ b/drivers/input/touchscreen/zforce_ts.c
@@ -235,7 +235,8 @@ static int zforce_scan_frequency(struct zforce_ts *ts, u16 idle, u16 finger,
 			(finger & 0xff), ((finger >> 8) & 0xff),
 			(stylus & 0xff), ((stylus >> 8) & 0xff) };
 
-	dev_dbg(&client->dev, "set scan frequency to (idle: %d, finger: %d, stylus: %d)\n",
+	dev_dbg(&client->dev,
+		"set scan frequency to (idle: %d, finger: %d, stylus: %d)\n",
 		idle, finger, stylus);
 
 	return zforce_send_wait(ts, &buf[0], ARRAY_SIZE(buf));
@@ -332,7 +333,8 @@ static int zforce_touch_event(struct zforce_ts *ts, u8 *payload)
 
 	count = payload[0];
 	if (count > ZFORCE_REPORT_POINTS) {
-		dev_warn(&client->dev, "too many coordinates %d, expected max %d\n",
+		dev_warn(&client->dev,
+			 "too many coordinates %d, expected max %d\n",
 			 count, ZFORCE_REPORT_POINTS);
 		count = ZFORCE_REPORT_POINTS;
 	}
@@ -494,8 +496,8 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 	while (!gpio_get_value(pdata->gpio_int)) {
 		ret = zforce_read_packet(ts, payload_buffer);
 		if (ret < 0) {
-			dev_err(&client->dev, "could not read packet, ret: %d\n",
-				ret);
+			dev_err(&client->dev,
+				"could not read packet, ret: %d\n", ret);
 			break;
 		}
 
@@ -539,7 +541,8 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 						payload[RESPONSE_DATA + 4];
 			ts->version_rev   = (payload[RESPONSE_DATA + 7] << 8) |
 						payload[RESPONSE_DATA + 6];
-			dev_dbg(&ts->client->dev, "Firmware Version %04x:%04x %04x:%04x\n",
+			dev_dbg(&ts->client->dev,
+				"Firmware Version %04x:%04x %04x:%04x\n",
 				ts->version_major, ts->version_minor,
 				ts->version_build, ts->version_rev);
 
@@ -552,7 +555,8 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
 			break;
 
 		default:
-			dev_err(&ts->client->dev, "unrecognized response id: 0x%x\n",
+			dev_err(&ts->client->dev,
+				"unrecognized response id: 0x%x\n",
 				payload[RESPONSE_ID]);
 			break;
 		}
@@ -618,7 +622,8 @@ static int zforce_suspend(struct device *dev)
 
 		enable_irq_wake(client->irq);
 	} else if (input->users) {
-		dev_dbg(&client->dev, "suspend without being a wakeup source\n");
+		dev_dbg(&client->dev,
+			"suspend without being a wakeup source\n");
 
 		ret = zforce_stop(ts);
 		if (ret)
-- 
1.8.5.3
