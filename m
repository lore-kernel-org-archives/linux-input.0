From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/9] Input: 88pm860x-ts- Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:58:34 +0530
Message-ID: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33034 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab3ECKlj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:41:39 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so863041pad.11
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:41:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/touchscreen/88pm860x-ts.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/88pm860x-ts.c b/drivers/input/touchscreen/88pm860x-ts.c
index c706894..e8d4572 100644
--- a/drivers/input/touchscreen/88pm860x-ts.c
+++ b/drivers/input/touchscreen/88pm860x-ts.c
@@ -299,7 +299,6 @@ static int pm860x_touch_remove(struct platform_device *pdev)
 
 	input_unregister_device(touch->idev);
 	free_irq(touch->irq, touch);
-	platform_set_drvdata(pdev, NULL);
 	kfree(touch);
 	return 0;
 }
-- 
1.7.9.5

