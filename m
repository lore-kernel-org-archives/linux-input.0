From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH v2 3/5] tsc2007: Add poll_delay parameter to platform data.
Date: Tue, 17 May 2011 10:56:10 +0200
Message-ID: <1305622572-3154-3-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51567 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084Ab1EQI4R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 04:56:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kwangwoo Lee <kwangwoo.lee@gmail.com>

Depending on the quality of the touch panel, the time for the X-, X+, Y-
and Y+ inputs to settle may vary. The poll_delay parameter can be used
to override the default of 1 millisecond.

Changes in v2:
  - Move poll_delay parameter to platform data.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/input/touchscreen/tsc2007.c |    5 +++--
 include/linux/i2c/tsc2007.h         |    2 ++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 8c48a91..faa82dd 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -27,7 +27,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
 
-#define TS_POLL_DELAY			1 /* ms delay between samples */
 #define TS_POLL_PERIOD			1 /* ms delay between samples */
 
 #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
@@ -76,6 +75,7 @@ struct tsc2007 {
 	u16			model;
 	u16			x_plate_ohms;
 	u16			max_rt;
+	unsigned long		poll_delay;
 
 	bool			pendown;
 	int			irq;
@@ -242,7 +242,7 @@ static irqreturn_t tsc2007_irq(int irq, void *handle)
 	if (!ts->get_pendown_state || likely(ts->get_pendown_state())) {
 		disable_irq_nosync(ts->irq);
 		schedule_delayed_work(&ts->work,
-				      msecs_to_jiffies(TS_POLL_DELAY));
+				      msecs_to_jiffies(ts->poll_delay));
 	}
 
 	if (ts->clear_penirq)
@@ -296,6 +296,7 @@ static int __devinit tsc2007_probe(struct i2c_client *client,
 	ts->model             = pdata->model;
 	ts->x_plate_ohms      = pdata->x_plate_ohms;
 	ts->max_rt            = pdata->max_rt ? : MAX_12BIT;
+	ts->poll_delay        = pdata->poll_delay ? : 1;
 	ts->get_pendown_state = pdata->get_pendown_state;
 	ts->clear_penirq      = pdata->clear_penirq;
 
diff --git a/include/linux/i2c/tsc2007.h b/include/linux/i2c/tsc2007.h
index d95f113..342b130 100644
--- a/include/linux/i2c/tsc2007.h
+++ b/include/linux/i2c/tsc2007.h
@@ -7,6 +7,8 @@ struct tsc2007_platform_data {
 	u16	model;				/* 2007. */
 	u16	x_plate_ohms;
 	u16	max_rt; /* max. resistance above which samples are ignored */
+	unsigned long poll_delay; /* delay (in ms) after pen-down event
+				     before polling starts */
 
 	int	(*get_pendown_state)(void);
 	void	(*clear_penirq)(void);		/* If needed, clear 2nd level
-- 
1.7.5.1

