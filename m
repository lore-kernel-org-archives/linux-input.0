From: Marek Vasut <marex@denx.de>
Subject: [PATCH 2/2] Input: smtpe-ts: Wait 50mS until polling for pen-up
Date: Fri,  8 May 2015 03:53:11 +0200
Message-ID: <1431049991-30129-2-git-send-email-marex@denx.de>
References: <1431049991-30129-1-git-send-email-marex@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:55372 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751313AbbEHBx0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 May 2015 21:53:26 -0400
In-Reply-To: <1431049991-30129-1-git-send-email-marex@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Vipul Kumar Samar <vipulkumar.samar@st.com>, Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Wait a little bit longer, 50mS instead of 20mS, until the driver
starts polling for pen-up. The problematic behavior before this
patch is applied is as follows. The behavior was observed on the
STMPE610QTR controller.

Upon a physical pen-down event, the touchscreen reports one set
of x-y-p coordinates and a pen-down event. After that, the pen-up
polling is triggered and since the controller is not ready yet,
the polling mistakenly detects a pen-up event while the physical
state is still such that the pen is down on the touch surface.

The pen-up handling flushes the controller FIFO, so after that,
all the samples in the controller are discarded. The controller
becomes ready shortly after this bogus pen-up handling and does
generate again a pen-down interrupt. This time, the controller
contains x-y-p samples which all read as zero. Since pressure
value is zero, this set of samples is effectively ignored by
userland.

In the end, the driver just bounces between pen-down and bogus
pen-up handling, generating no useful results. Fix this by giving
the controller a bit more time before polling it for pen-up.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Vipul Kumar Samar <vipulkumar.samar@st.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/stmpe-ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/stmpe-ts.c b/drivers/input/touchscreen/stmpe-ts.c
index 9e5c880..a8f5ea7 100644
--- a/drivers/input/touchscreen/stmpe-ts.c
+++ b/drivers/input/touchscreen/stmpe-ts.c
@@ -164,7 +164,7 @@ static irqreturn_t stmpe_ts_handler(int irq, void *data)
 			STMPE_TSC_CTRL_TSC_EN, STMPE_TSC_CTRL_TSC_EN);
 
 	/* start polling for touch_det to detect release */
-	schedule_delayed_work(&ts->work, msecs_to_jiffies(20));
+	schedule_delayed_work(&ts->work, msecs_to_jiffies(50));
 
 	return IRQ_HANDLED;
 }
-- 
2.1.4

