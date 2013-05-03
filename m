From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 6/9] Input: mc13783_ts: Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:58:39 +0530
Message-ID: <1367576922-31459-6-git-send-email-sachin.kamat@linaro.org>
References: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51353 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab3ECKmE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:42:04 -0400
Received: by mail-pa0-f53.google.com with SMTP id kq12so857705pab.40
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:42:03 -0700 (PDT)
In-Reply-To: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Sascha Hauer <s.hauer@pengutronix.de>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/input/touchscreen/mc13783_ts.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
index 89308fe..d6f099c 100644
--- a/drivers/input/touchscreen/mc13783_ts.c
+++ b/drivers/input/touchscreen/mc13783_ts.c
@@ -233,8 +233,6 @@ static int mc13783_ts_remove(struct platform_device *pdev)
 {
 	struct mc13783_ts_priv *priv = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	destroy_workqueue(priv->workq);
 	input_unregister_device(priv->idev);
 	kfree(priv);
-- 
1.7.9.5

