From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: lpc32xx_ts - check for clk_prepare_enable() error
Date: Wed, 12 Apr 2017 08:29:23 -0300
Message-ID: <1491996563-23095-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34308 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752016AbdDLL3s (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Apr 2017 07:29:48 -0400
Received: by mail-qt0-f195.google.com with SMTP id r49so3334825qta.1
        for <linux-input@vger.kernel.org>; Wed, 12 Apr 2017 04:29:48 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: vz@mleia.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

clk_prepare_enable() may fail, so we better check its return value and
propagate it in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/input/touchscreen/lpc32xx_ts.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index e0baa7d..4eb31ec 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -142,11 +142,14 @@ static void lpc32xx_stop_tsc(struct lpc32xx_tsc *tsc)
 	clk_disable_unprepare(tsc->clk);
 }
 
-static void lpc32xx_setup_tsc(struct lpc32xx_tsc *tsc)
+static int lpc32xx_setup_tsc(struct lpc32xx_tsc *tsc)
 {
 	u32 tmp;
+	int err;
 
-	clk_prepare_enable(tsc->clk);
+	err = clk_prepare_enable(tsc->clk);
+	if (err)
+		return err;
 
 	tmp = tsc_readl(tsc, LPC32XX_TSC_CON) & ~LPC32XX_TSC_ADCCON_POWER_UP;
 
@@ -184,15 +187,15 @@ static void lpc32xx_setup_tsc(struct lpc32xx_tsc *tsc)
 
 	/* Enable automatic ts event capture */
 	tsc_writel(tsc, LPC32XX_TSC_CON, tmp | LPC32XX_TSC_ADCCON_AUTO_EN);
+
+	return 0;
 }
 
 static int lpc32xx_ts_open(struct input_dev *dev)
 {
 	struct lpc32xx_tsc *tsc = input_get_drvdata(dev);
 
-	lpc32xx_setup_tsc(tsc);
-
-	return 0;
+	return lpc32xx_setup_tsc(tsc);
 }
 
 static void lpc32xx_ts_close(struct input_dev *dev)
-- 
2.7.4

