From: Zhang Jiejing <jiejing.zhang@freescale.com>
Subject: [PATCH] input: egalax_ts: optmize driver for more fluency touch feelling
Date: Wed, 7 Dec 2011 17:10:02 +0800
Message-ID: <1323249002-28397-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:44601
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750781Ab1LGJMJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Dec 2011 04:12:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>

egalax_ts use threaded_irq to report touch event, it will wake up the
irq thread and stop the thread irq after process one touch event, so
even user touch the screen very fast, the fastest event report speed
is depends on the scheduler, so the event reported is a uniform speed.

This patch will let thread irq check the gpio's status, if the gpio
is down, means still have more events, it will not exit the irq handler
and continue process another new event, it can improve user experience.

Signed-off-by: Zhang Jiejing <jiejing.zhang@freescale.com>
---
 drivers/input/touchscreen/egalax_ts.c |   63 +++++++++++++++++---------------
 1 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index f694535..21bd2ec 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -74,45 +74,48 @@ static irqreturn_t egalax_ts_interrupt(int irq, void *dev_id)
 	u8 state;
 
 	do {
-		ret = i2c_master_recv(client, buf, MAX_I2C_DATA_LEN);
-	} while (ret == -EAGAIN && tries++ < EGALAX_MAX_TRIES);
+		do {
+			ret = i2c_master_recv(client, buf, MAX_I2C_DATA_LEN);
+		} while (ret == -EAGAIN && tries++ < EGALAX_MAX_TRIES);
 
-	if (ret < 0)
-		return IRQ_HANDLED;
+		if (ret < 0)
+			return IRQ_HANDLED;
 
-	if (buf[0] != REPORT_MODE_MTTOUCH) {
-		/* ignore mouse events and vendor events */
-		return IRQ_HANDLED;
-	}
+		if (buf[0] != REPORT_MODE_MTTOUCH) {
+			/* ignore mouse events and vendor events */
+			return IRQ_HANDLED;
+		}
 
-	state = buf[1];
-	x = (buf[3] << 8) | buf[2];
-	y = (buf[5] << 8) | buf[4];
-	z = (buf[7] << 8) | buf[6];
+		state = buf[1];
+		x = (buf[3] << 8) | buf[2];
+		y = (buf[5] << 8) | buf[4];
+		z = (buf[7] << 8) | buf[6];
 
-	valid = state & EVENT_VALID_MASK;
-	id = (state & EVENT_ID_MASK) >> EVENT_ID_OFFSET;
-	down = state & EVENT_DOWN_UP;
+		valid = state & EVENT_VALID_MASK;
+		id = (state & EVENT_ID_MASK) >> EVENT_ID_OFFSET;
+		down = state & EVENT_DOWN_UP;
 
-	if (!valid || id > MAX_SUPPORT_POINTS) {
-		dev_dbg(&client->dev, "point invalid\n");
-		return IRQ_HANDLED;
-	}
+		if (!valid || id > MAX_SUPPORT_POINTS) {
+			dev_dbg(&client->dev, "point invalid\n");
+			return IRQ_HANDLED;
+		}
 
-	input_mt_slot(input_dev, id);
-	input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, down);
+		input_mt_slot(input_dev, id);
+		input_mt_report_slot_state(input_dev, MT_TOOL_FINGER, down);
 
-	dev_dbg(&client->dev, "%s id:%d x:%d y:%d z:%d",
-		(down ? "down" : "up"), id, x, y, z);
+		dev_dbg(&client->dev, "%s id:%d x:%d y:%d z:%d",
+			(down ? "down" : "up"), id, x, y, z);
 
-	if (down) {
-		input_report_abs(input_dev, ABS_MT_POSITION_X, x);
-		input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
-		input_report_abs(input_dev, ABS_MT_PRESSURE, z);
-	}
+		if (down) {
+			input_report_abs(input_dev, ABS_MT_POSITION_X, x);
+			input_report_abs(input_dev, ABS_MT_POSITION_Y, y);
+			input_report_abs(input_dev, ABS_MT_PRESSURE, z);
+		}
+
+		input_mt_report_pointer_emulation(input_dev, true);
+		input_sync(input_dev);
+	} while (gpio_get_value(irq_to_gpio(client->irq)) == 0);
 
-	input_mt_report_pointer_emulation(input_dev, true);
-	input_sync(input_dev);
 	return IRQ_HANDLED;
 }
 
-- 
1.7.1


