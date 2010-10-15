From: <michael.hennerich@analog.com>
Subject: [PATCH 2/3] Input: touchscreen: ad7877 implement EV_KEY:BTN_TOUCH reporting
Date: Fri, 15 Oct 2010 12:40:49 +0200
Message-ID: <1287139250-24777-2-git-send-email-michael.hennerich@analog.com>
References: <1287139250-24777-1-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail10.analog.com ([137.71.25.55]:19080 "EHLO
	nwd2mail10.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334Ab0JOKrd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Oct 2010 06:47:33 -0400
In-Reply-To: <1287139250-24777-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org, drivers@analog.com, Michael Hennerich <michael.hennerich@analog.com>

From: Michael Hennerich <michael.hennerich@analog.com>

Some input users such as Android or X require BTN_TOUCH events.
Implement EV_KEY:BTN_TOUCH and make sure that the release event
is not erroneous scheduled without a preceding valid touch.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/input/touchscreen/ad7877.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/ad7877.c b/drivers/input/touchscreen/ad7877.c
index 53f4d79..96c0a0d 100644
--- a/drivers/input/touchscreen/ad7877.c
+++ b/drivers/input/touchscreen/ad7877.c
@@ -333,7 +333,7 @@ static int ad7877_read_adc(struct spi_device *spi, unsigned command)
 	return status ? : sample;
 }
 
-static void ad7877_rx(struct ad7877 *ts)
+static int ad7877_rx(struct ad7877 *ts)
 {
 	struct input_dev *input_dev = ts->input;
 	unsigned Rt;
@@ -360,11 +360,17 @@ static void ad7877_rx(struct ad7877 *ts)
 		Rt /= z1;
 		Rt = (Rt + 2047) >> 12;
 
+		if (!timer_pending(&ts->timer))
+			input_report_key(input_dev, BTN_TOUCH, 1);
+
 		input_report_abs(input_dev, ABS_X, x);
 		input_report_abs(input_dev, ABS_Y, y);
 		input_report_abs(input_dev, ABS_PRESSURE, Rt);
 		input_sync(input_dev);
+		return 0;
 	}
+
+	return -EINVAL;
 }
 
 static inline void ad7877_ts_event_release(struct ad7877 *ts)
@@ -372,6 +378,7 @@ static inline void ad7877_ts_event_release(struct ad7877 *ts)
 	struct input_dev *input_dev = ts->input;
 
 	input_report_abs(input_dev, ABS_PRESSURE, 0);
+	input_report_key(input_dev, BTN_TOUCH, 0);
 	input_sync(input_dev);
 }
 
@@ -413,11 +420,9 @@ static void ad7877_callback(void *_ts)
 	struct ad7877 *ts = _ts;
 
 	spin_lock_irq(&ts->lock);
-
-	ad7877_rx(ts);
+	if (!ad7877_rx(ts))
+		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
 	ts->pending = 0;
-	mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
-
 	spin_unlock_irq(&ts->lock);
 }
 
@@ -728,6 +733,8 @@ static int __devinit ad7877_probe(struct spi_device *spi)
 	input_dev->phys = ts->phys;
 	input_dev->dev.parent = &spi->dev;
 
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(BTN_TOUCH, input_dev->keybit);
 	__set_bit(EV_ABS, input_dev->evbit);
 	__set_bit(ABS_X, input_dev->absbit);
 	__set_bit(ABS_Y, input_dev->absbit);
-- 
1.6.0.2

