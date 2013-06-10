From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: tps6507x-ts - use bool for booleans
Date: Sun,  9 Jun 2013 22:53:45 -0700
Message-ID: <1370843627-30823-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:61051 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723Ab3FJFxu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jun 2013 01:53:50 -0400
Received: by mail-pd0-f177.google.com with SMTP id p10so1498227pdj.22
        for <linux-input@vger.kernel.org>; Sun, 09 Jun 2013 22:53:49 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: manishv.b@ti.com, davinci-linux-open-source@linux.davincidsp.com

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

Note that neither of these 3 patches has been tested on the real hardware as
I don't have it so if someone could give them a spin that would be great.

 drivers/input/touchscreen/tps6507x-ts.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index 1fb397c..c981ccf 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -45,12 +45,12 @@ struct tps6507x_ts {
 	struct ts_event		tc;
 	struct tps6507x_dev	*mfd;
 	u16			model;
-	unsigned		pendown;
+	u16			min_pressure;
 	int			irq;
 	void			(*clear_penirq)(void);
 	unsigned long		poll_period;	/* ms */
-	u16			min_pressure;
 	int			vref;		/* non-zero to leave vref on */
+	bool			pendown;
 };
 
 static int tps6507x_read_u8(struct tps6507x_ts *tsc, u8 reg, u8 *data)
@@ -165,12 +165,12 @@ static void tps6507x_ts_handler(struct work_struct *work)
 	struct tps6507x_ts *tsc =  container_of(work,
 				struct tps6507x_ts, work.work);
 	struct input_dev *input_dev = tsc->input_dev;
-	int pendown;
+	bool pendown;
 	int schd;
 	s32 ret;
 
-	ret =  tps6507x_adc_conversion(tsc, TPS6507X_TSCMODE_PRESSURE,
-				       &tsc->tc.pressure);
+	ret = tps6507x_adc_conversion(tsc, TPS6507X_TSCMODE_PRESSURE,
+				      &tsc->tc.pressure);
 	if (ret)
 		goto done;
 
@@ -181,7 +181,7 @@ static void tps6507x_ts_handler(struct work_struct *work)
 		input_report_key(input_dev, BTN_TOUCH, 0);
 		input_report_abs(input_dev, ABS_PRESSURE, 0);
 		input_sync(input_dev);
-		tsc->pendown = 0;
+		tsc->pendown = false;
 	}
 
 	if (pendown) {
@@ -206,7 +206,7 @@ static void tps6507x_ts_handler(struct work_struct *work)
 		input_report_abs(input_dev, ABS_Y, tsc->tc.y);
 		input_report_abs(input_dev, ABS_PRESSURE, tsc->tc.pressure);
 		input_sync(input_dev);
-		tsc->pendown = 1;
+		tsc->pendown = true;
 	}
 
 done:
-- 
1.8.1.4

