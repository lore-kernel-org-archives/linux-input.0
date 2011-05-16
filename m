From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: [PATCH 4/5] tsc2007: Introduce poll_period parameter.
Date: Mon, 16 May 2011 10:33:02 +0200
Message-ID: <1305534783-4917-4-git-send-email-thierry.reding@avionic-design.de>
References: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50735 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab1EPIdI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 May 2011 04:33:08 -0400
In-Reply-To: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kwangwoo Lee <kwlee@mtekvision.com>

This new parameter allows the polling frequency to be configured while
keeping the default of once every millisecond.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kwangwoo Lee <kwlee@mtekvision.com>
Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 drivers/input/touchscreen/tsc2007.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c b/drivers/input/touchscreen/tsc2007.c
index 43b5c09..cdaf06f 100644
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
@@ -86,6 +84,10 @@ static int poll_delay = 1;
 module_param(poll_delay, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(poll_delay, "Delay (in ms) after pen-down event before polling starts");
 
+static int poll_period = 1;
+module_param(poll_period, int, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(poll_period, "Time (in ms) between successive samples");
+
 static int max_rt = MAX_12BIT;
 module_param(max_rt, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(max_rt, "Maximum resistance above which samples are ignored");
@@ -236,7 +238,7 @@ static void tsc2007_work(struct work_struct *work)
  out:
 	if (ts->pendown || debounced)
 		schedule_delayed_work(&ts->work,
-				      msecs_to_jiffies(TS_POLL_PERIOD));
+				      msecs_to_jiffies(poll_period));
 	else
 		enable_irq(ts->irq);
 }
-- 
1.7.5.1

