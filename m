From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: imx6ul_tsc - fix error handling
Date: Wed, 12 Apr 2017 08:20:10 -0300
Message-ID: <1491996010-19947-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:34884 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753887AbdDLLU0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Apr 2017 07:20:26 -0400
Received: by mail-qk0-f193.google.com with SMTP id k139so3435630qke.2
        for <linux-input@vger.kernel.org>; Wed, 12 Apr 2017 04:20:26 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: haibo.chen@nxp.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>

From: Fabio Estevam <fabio.estevam@nxp.com>

If imx6ul_tsc_init() fails we should not return directly.

We should disable the previously acquired clocks in this case.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/input/touchscreen/imx6ul_tsc.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/imx6ul_tsc.c b/drivers/input/touchscreen/imx6ul_tsc.c
index 7098e0a..ee82a97 100644
--- a/drivers/input/touchscreen/imx6ul_tsc.c
+++ b/drivers/input/touchscreen/imx6ul_tsc.c
@@ -337,11 +337,20 @@ static int imx6ul_tsc_open(struct input_dev *input_dev)
 		dev_err(tsc->dev,
 			"Could not prepare or enable the tsc clock: %d\n",
 			err);
-		clk_disable_unprepare(tsc->adc_clk);
-		return err;
+		goto disable_adc_clk;
 	}
 
-	return imx6ul_tsc_init(tsc);
+	err = imx6ul_tsc_init(tsc);
+	if (err)
+		goto disable_tsc_clk;
+
+	return 0;
+
+disable_tsc_clk:
+	clk_disable_unprepare(tsc->tsc_clk);
+disable_adc_clk:
+	clk_disable_unprepare(tsc->adc_clk);
+	return err;
 }
 
 static void imx6ul_tsc_close(struct input_dev *input_dev)
-- 
2.7.4

