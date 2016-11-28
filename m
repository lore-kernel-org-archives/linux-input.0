From: Aniroop Mathur <a.mathur@samsung.com>
Subject: [PATCH] Input: touchscreen: w90p910 - change msleep to usleep_range for small msecs
Date: Tue, 29 Nov 2016 00:13:02 +0530
Message-ID: <1480358582-2954-1-git-send-email-a.mathur@samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36511 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbcK1Sdg (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 13:33:36 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: mcuos.com@gmail.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com, aniroop.mathur@gmail.com, Aniroop Mathur <a.mathur@samsung.com>

msleep(1~20) may not do what the caller intends, and will often sleep longer.
(~20 ms actual sleep for any value given in the 1~20ms range)
This is not the desired behaviour for many cases like device resume time,
device suspend time, device enable time, retry logic, etc.
Thus, change msleep to usleep_range for precise wakeups.

Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
---
 drivers/input/touchscreen/w90p910_ts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index da6004e..3f14b5a 100644
--- a/drivers/input/touchscreen/w90p910_ts.c
+++ b/drivers/input/touchscreen/w90p910_ts.c
@@ -171,9 +171,9 @@ static int w90p910_open(struct input_dev *dev)
 	clk_enable(w90p910_ts->clk);
 
 	__raw_writel(ADC_RST1, w90p910_ts->ts_reg);
-	msleep(1);
+	usleep_range(1000, 1100);
 	__raw_writel(ADC_RST0, w90p910_ts->ts_reg);
-	msleep(1);
+	usleep_range(1000, 1100);
 
 	/* set delay and screen type */
 	val = __raw_readl(w90p910_ts->ts_reg + 0x04);
-- 
2.6.2

