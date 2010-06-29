From: Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/2] Implement EV_KEY:BTN_TOUCH reporting on AD7879 touch
 screen driver
Date: Tue, 29 Jun 2010 14:49:57 +0200
Message-ID: <1277815797.11338.8.camel@mhenneri-D02.ad.analog.com>
References: <1277815615.11338.5.camel@mhenneri-D02.ad.analog.com>
Reply-To: michael.hennerich@analog.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nwd2mail11.analog.com ([137.71.25.57]:17627 "EHLO
	nwd2mail11.analog.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab0F2MzN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Jun 2010 08:55:13 -0400
In-Reply-To: <1277815615.11338.5.camel@mhenneri-D02.ad.analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, vapier@gentoo.org

[PATCH 2/2] Implement EV_KEY:BTN_TOUCH reporting on AD7879 touch screen
driver

Some input events users such as Android require BTN_TOUCH events.
Implement EV_KEY:BTN_TOUCH and make sure that the release event 
is not erroneous scheduled without a preceding valid touch.
Avoid duplicated BTN_TOUCH events, even though input core filters them.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

 drivers/input/touchscreen/ad7879.c |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/ad7879.c
b/drivers/input/touchscreen/ad7879.c
index 1ac0713..05e8574 100644
--- a/drivers/input/touchscreen/ad7879.c
+++ b/drivers/input/touchscreen/ad7879.c
@@ -146,7 +146,7 @@ static int ad7879_write(struct ad7879 *ts, u8 reg,
u16 val)
 	return ts->bops->write(ts->dev, reg, val);
 }
 
-static void ad7879_report(struct ad7879 *ts)
+static int ad7879_report(struct ad7879 *ts)
 {
 	struct input_dev *input_dev = ts->input;
 	unsigned Rt;
@@ -175,11 +175,17 @@ static void ad7879_report(struct ad7879 *ts)
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
 
 static void ad7879_ts_event_release(struct ad7879 *ts)
@@ -187,6 +193,7 @@ static void ad7879_ts_event_release(struct ad7879
*ts)
 	struct input_dev *input_dev = ts->input;
 
 	input_report_abs(input_dev, ABS_PRESSURE, 0);
+	input_report_key(input_dev, BTN_TOUCH, 0);
 	input_sync(input_dev);
 }
 
@@ -202,9 +209,9 @@ static irqreturn_t ad7879_irq(int irq, void *handle)
 	struct ad7879 *ts = handle;
 
 	ad7879_multi_read(ts, AD7879_REG_XPLUS, AD7879_NR_SENSE,
ts->conversion_data);
-	ad7879_report(ts);
 
-	mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
+	if (!ad7879_report(ts))
+		mod_timer(&ts->timer, jiffies + TS_PEN_UP_TIMEOUT);
 
 	return IRQ_HANDLED;
 }
@@ -505,6 +512,9 @@ struct ad7879 *ad7879_probe(struct device *dev, u8
devid, unsigned int irq,
 	__set_bit(ABS_Y, input_dev->absbit);
 	__set_bit(ABS_PRESSURE, input_dev->absbit);
 
+	__set_bit(EV_KEY, input_dev->evbit);
+	__set_bit(BTN_TOUCH, input_dev->keybit);
+
 	input_set_abs_params(input_dev, ABS_X,
 			pdata->x_min ? : 0,
 			pdata->x_max ? : MAX_12BIT,


