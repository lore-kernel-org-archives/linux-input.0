From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH v2 4/5] tsc2007: Add poll_period parameter to platform data.
Date: Tue, 17 May 2011 10:56:11 +0200
Message-ID: <1305622572-3154-4-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58508 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752294Ab1EQI4R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 04:56:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kwangwoo Lee <kwangwoo.lee@gmail.com>

This new parameter allows the polling frequency to be configured while
keeping the default of once every millisecond.

Changes in v2:
  - Move poll_period parameter to platform data.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/input/touchscreen/tsc2007.c |    6 +++---
 include/linux/i2c/tsc2007.h         |    1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index faa82dd..87c40c7 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -27,8 +27,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
 
-#define TS_POLL_PERIOD			1 /* ms delay between samples */
-
 #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
 #define TSC2007_MEASURE_AUX		(0x2 << 4)
 #define TSC2007_MEASURE_TEMP1		(0x4 << 4)
@@ -76,6 +74,7 @@ struct tsc2007 {
 	u16			x_plate_ohms;
 	u16			max_rt;
 	unsigned long		poll_delay;
+	unsigned long		poll_period;
 
 	bool			pendown;
 	int			irq;
@@ -230,7 +229,7 @@ static void tsc2007_work(struct work_struct *work)
  out:
 	if (ts->pendown || debounced)
 		schedule_delayed_work(&ts->work,
-				      msecs_to_jiffies(TS_POLL_PERIOD));
+				      msecs_to_jiffies(ts->poll_period));
 	else
 		enable_irq(ts->irq);
 }
@@ -297,6 +296,7 @@ static int __devinit tsc2007_probe(struct i2c_client *client,
 	ts->x_plate_ohms      = pdata->x_plate_ohms;
 	ts->max_rt            = pdata->max_rt ? : MAX_12BIT;
 	ts->poll_delay        = pdata->poll_delay ? : 1;
+	ts->poll_period       = pdata->poll_period ? : 1;
 	ts->get_pendown_state = pdata->get_pendown_state;
 	ts->clear_penirq      = pdata->clear_penirq;
 
diff --git a/include/linux/i2c/tsc2007.h b/include/linux/i2c/tsc2007.h
index 342b130..a51dac0 100644
--- a/include/linux/i2c/tsc2007.h
+++ b/include/linux/i2c/tsc2007.h
@@ -9,6 +9,7 @@ struct tsc2007_platform_data {
 	u16	max_rt; /* max. resistance above which samples are ignored */
 	unsigned long poll_delay; /* delay (in ms) after pen-down event
 				     before polling starts */
+	unsigned long poll_period; /* time (in ms) between samples */
 
 	int	(*get_pendown_state)(void);
 	void	(*clear_penirq)(void);		/* If needed, clear 2nd level
-- 
1.7.5.1

