From: Marek Vasut <marex@denx.de>
Subject: [PATCH 1/2] Input: smtpe-ts: Use msecs_to_jiffies() instead of HZ
Date: Fri,  8 May 2015 03:53:10 +0200
Message-ID: <1431049991-30129-1-git-send-email-marex@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:54411 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751394AbbEHBx1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2015 21:53:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Use msecs_to_jiffies(20) instead of plain (HZ / 50), as the
former is much more explicit about it's behavior. We want
to schedule the task 20 mS from now, so make it explicit in
the code.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/stmpe-ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 42ce31a..9e5c880 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -164,7 +164,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
 			STMPE_TSC_CTRL_TSC_EN, STMPE_TSC_CTRL_TSC_EN);
 
 	/* start polling for touch_det to detect release */
-	schedule_delayed_work(&ts->work, HZ / 50);
+	schedule_delayed_work(&ts->work, msecs_to_jiffies(20));
 
 	return IRQ_HANDLED;
 }
-- 
2.1.4

