From: Marek Vasut <marex@denx.de>
Subject: [PATCH] Input: smtpe-ts: Use msecs_to_jiffies() instead of HZ
Date: Wed,  6 May 2015 01:46:36 +0200
Message-ID: <1430869596-7044-1-git-send-email-marex@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:34296 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbbEEXqp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 May 2015 19:46:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Use msecs_to_jiffies(50) instead of plain (HZ / 50) as the
former is independent of kernel HZ settings and provides
stable delay.

The delay here must be stable, otherwise we might start polling
for pen-up event too early. This would in turn render the
touchscreen unusable.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/stmpe-ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

NOTE: This applies all the way back to Linux ~2.6.36, so I should
      probably also submit this for -stable if acceptable ?

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 42ce31a..a8f5ea7 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -164,7 +164,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
 			STMPE_TSC_CTRL_TSC_EN, STMPE_TSC_CTRL_TSC_EN);
 
 	/* start polling for touch_det to detect release */
-	schedule_delayed_work(&ts->work, HZ / 50);
+	schedule_delayed_work(&ts->work, msecs_to_jiffies(50));
 
 	return IRQ_HANDLED;
 }
-- 
2.1.4

