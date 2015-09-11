From: WEN Pingbo <pingbo.wen@linaro.org>
Subject: [PATCH 2/2] Input: lpc32xx: handle clk_enable return value
Date: Fri, 11 Sep 2015 11:02:56 +0800
Message-ID: <1441940576-4972-2-git-send-email-pingbo.wen@linaro.org>
References: <1441940576-4972-1-git-send-email-pingbo.wen@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34906 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbbIKDDz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Sep 2015 23:03:55 -0400
Received: by pacfv12 with SMTP id fv12so62134551pac.2
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2015 20:03:55 -0700 (PDT)
In-Reply-To: <1441940576-4972-1-git-send-email-pingbo.wen@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: broonie@kernel.org, linux-input@vger.kernel.org, WEN Pingbo <pingbo.wen@linaro.org>

If clk_enable failed, return the err code

Signed-off-by: WEN Pingbo <pingbo.wen@linaro.org>
---
 drivers/input/touchscreen/lpc32xx_ts.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index 24d704c..60cd31d 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -145,8 +145,14 @@ static void lpc32xx_stop_tsc(struct lpc32xx_tsc *tsc)
 static void lpc32xx_setup_tsc(struct lpc32xx_tsc *tsc)
 {
 	u32 tmp;
+	int retval;
 
-	clk_enable(tsc->clk);
+	retval = clk_enable(tsc->clk);
+	if (retval) {
+		dev_err(&tsc->dev->dev,
+			"clk_enable failed, ret %d\n", retval);
+		return;
+	}
 
 	tmp = tsc_readl(tsc, LPC32XX_TSC_CON) & ~LPC32XX_TSC_ADCCON_POWER_UP;
 
-- 
1.9.1

