From: WEN Pingbo <pingbo.wen@linaro.org>
Subject: [PATCH V2 1/2] Input: at32psif: handle clk_enable return value
Date: Fri, 11 Sep 2015 11:34:50 +0800
Message-ID: <1441942490-5980-1-git-send-email-pingbo.wen@linaro.org>
References: <CAOMZO5C_JSsZY=J9a_+Co2+AYeV0HGPDGy-Z5EBBDmKmjgmSjA@mail.gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36353 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbIKDfj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2015 23:35:39 -0400
Received: by padhk3 with SMTP id hk3so61633316pad.3
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2015 20:35:39 -0700 (PDT)
In-Reply-To: <CAOMZO5C_JSsZY=J9a_+Co2+AYeV0HGPDGy-Z5EBBDmKmjgmSjA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: broonie@kernel.org, linux-input@vger.kernel.org, WEN Pingbo <pingbo.wen@linaro.org>

We should print the err if clk_enable failed.

Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
---
 drivers/input/serio/at32psif.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/serio/at32psif.c b/drivers/input/serio/at32psif.c
index 2e4ff5b..38862a8 100644
--- a/drivers/input/serio/at32psif.c
+++ b/drivers/input/serio/at32psif.c
@@ -185,6 +185,7 @@ static void psif_set_prescaler(struct psif *psif)
 {
 	unsigned long prscv;
 	unsigned long rate = clk_get_rate(psif->pclk);
+	int retval;
 
 	/* PRSCV = Pulse length (100 us) * PSIF module frequency. */
 	prscv = 100 * (rate / 1000000UL);
@@ -195,7 +196,12 @@ static void psif_set_prescaler(struct psif *psif)
 				"prescaler set to max\n");
 	}
 
-	clk_enable(psif->pclk);
+	retval = clk_enable(psif->pclk);
+	if (retval < 0) {
+		dev_err(&psif->pdev->dev,
+			"could not enable pclk, ret %d\n", retval);
+		return;
+	}
 	psif_writel(psif, PSR, prscv);
 	clk_disable(psif->pclk);
 }
-- 
1.9.1

