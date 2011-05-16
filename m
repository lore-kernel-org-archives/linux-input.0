From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH 3/5] tsc2007: Introduce poll_delay parameter.
Date: Mon, 16 May 2011 10:33:01 +0200
Message-ID: <1305534783-4917-3-git-send-email-thierry.reding@avionic-design.de>
References: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:56913 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738Ab1EPIdS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 04:33:18 -0400
In-Reply-To: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kwangwoo Lee <kwlee@mtekvision.com>

Depending on the quality of the touch panel, the time for the X-, X+, Y-
and Y+ inputs to settle may vary. The poll_delay parameter can be used
to override the default of 1 millisecond.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kwangwoo Lee <kwlee@mtekvision.com>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/input/touchscreen/tsc2007.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 95d619c..43b5c09 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -27,7 +27,6 @@
 #include <linux/i2c.h>
 #include <linux/i2c/tsc2007.h>
 
-#define TS_POLL_DELAY			1 /* ms delay between samples */
 #define TS_POLL_PERIOD			1 /* ms delay between samples */
 
 #define TSC2007_MEASURE_TEMP0		(0x0 << 4)
@@ -83,6 +82,10 @@ struct tsc2007 {
 	void			(*clear_penirq)(void);
 };
 
+static int poll_delay = 1;
+module_param(poll_delay, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(poll_delay, "Delay (in ms) after pen-down event before polling starts");
+
 static int max_rt = MAX_12BIT;
 module_param(max_rt, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(max_rt, "Maximum resistance above which samples are ignored");
@@ -245,7 +248,7 @@ static irqreturn_t tsc2007_irq(int irq, void *handle)
 	if (!ts->get_pendown_state || likely(ts->get_pendown_state())) {
 		disable_irq_nosync(ts->irq);
 		schedule_delayed_work(&ts->work,
-				      msecs_to_jiffies(TS_POLL_DELAY));
+				      msecs_to_jiffies(poll_delay));
 	}
 
 	if (ts->clear_penirq)
-- 
1.7.5.1

