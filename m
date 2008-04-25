From: Sebastian Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] [INPUT] ucb1400: add key interface
Date: Fri, 25 Apr 2008 19:47:57 +0200
Message-ID: <20080425174757.GB10734@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:39474 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762660AbYDYRsH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Apr 2008 13:48:07 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: dtor@mail.ru, linux-input@vger.kernel.org

now the driver sends key events and feeds /dev/input/mice
Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ucb1400_ts.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 9d2dfa0..76d7726 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -255,12 +255,14 @@ static void ucb1400_ts_evt_add(struct input_dev *idev, u16 pressure, u16 x, u16
 	input_report_abs(idev, ABS_X, x);
 	input_report_abs(idev, ABS_Y, y);
 	input_report_abs(idev, ABS_PRESSURE, pressure);
+	input_report_key(idev, BTN_TOUCH, 1);
 	input_sync(idev);
 }
 
 static void ucb1400_ts_event_release(struct input_dev *idev)
 {
 	input_report_abs(idev, ABS_PRESSURE, 0);
+	input_report_key(idev, BTN_TOUCH, 0);
 	input_sync(idev);
 }
 
@@ -519,7 +521,8 @@ static int ucb1400_ts_probe(struct device *dev)
 	idev->id.product	= id;
 	idev->open		= ucb1400_ts_open;
 	idev->close		= ucb1400_ts_close;
-	idev->evbit[0]		= BIT_MASK(EV_ABS);
+	idev->evbit[0]		= BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
+	idev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
 
 	ucb1400_adc_enable(ucb);
 	x_res = ucb1400_ts_read_xres(ucb);
-- 
1.5.4.3

