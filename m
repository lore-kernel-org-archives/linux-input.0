From: Sebastian Siewior <bigeasy@linutronix.de>
Subject: [PATCH] [INPUT] ucb1400: add key interface
Date: Thu, 24 Apr 2008 13:03:05 +0200
Message-ID: <20080424110305.GA2971@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:41115 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbYDXLDO (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Apr 2008 07:03:14 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, dtor@mail.ru
Cc: linux-input@vger.kernel.org

now the driver sends key events and feeds /dev/input/mice

Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ucb1400_ts.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c b/drivers/input/touchscreen/ucb1400_ts.c
index 9337352..ad14413 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -326,12 +326,14 @@ static int ucb1400_ts_thread(void *_ucb)
 			 */
 			if (valid) {
 				ucb1400_ts_event_release(ucb->ts_idev);
+				input_report_key(ucb->ts_idev, BTN_TOUCH, 0);
 				valid = 0;
 			}
 
 			timeout = MAX_SCHEDULE_TIMEOUT;
 		} else {
 			valid = 1;
+			input_report_key(ucb->ts_idev, BTN_TOUCH, 1);
 			ucb1400_ts_evt_add(ucb->ts_idev, p, x, y);
 			timeout = msecs_to_jiffies(10);
 		}
@@ -527,7 +529,8 @@ static int ucb1400_ts_probe(struct device *dev)
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

