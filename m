From: WEN Pingbo <pingbo.wen@linaro.org>
Subject: [PATCH 1/2] Input: at32psif: handle clk_enable return value
Date: Fri, 11 Sep 2015 11:02:55 +0800
Message-ID: <1441940576-4972-1-git-send-email-pingbo.wen@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35873 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbIKDDw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2015 23:03:52 -0400
Received: by padhk3 with SMTP id hk3so60892376pad.3
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2015 20:03:52 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: broonie@kernel.org, linux-input@vger.kernel.org, WEN Pingbo <pingbo.wen@linaro.org>

We should print the err if clk_enable failed.

Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
---
 drivers/input/serio/at32psif.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/at32psif.c b/drivers/input/serio/at32psif.c
index 2e4ff5b..aebb996 100644
--- a/drivers/input/serio/at32psif.c
+++ b/drivers/input/serio/at32psif.c
@@ -185,6 +185,7 @@ static void psif_set_prescaler(struct psif *psif)
 {
 	unsigned long prscv;
 	unsigned long rate = clk_get_rate(psif->pclk);
+	int retval;
 
 	/* PRSCV = Pulse length (100 us) * PSIF module frequency. */
 	prscv = 100 * (rate / 1000000UL);
@@ -195,7 +196,10 @@ static void psif_set_prescaler(struct psif *psif)
 				"prescaler set to max\n");
 	}
 
-	clk_enable(psif->pclk);
+	retval = clk_enable(psif->pclk);
+	if (retval < 0)
+		dev_err(&psif->pdev->dev,
+			"could not enable pclk, ret %d\n", retval);
 	psif_writel(psif, PSR, prscv);
 	clk_disable(psif->pclk);
 }
-- 
1.9.1

