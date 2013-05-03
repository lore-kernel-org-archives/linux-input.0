From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/9] Input: da9052_tsi - Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:58:36 +0530
Message-ID: <1367576922-31459-3-git-send-email-sachin.kamat@linaro.org>
References: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:48197 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab3ECKlr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:41:47 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so842685pdj.8
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:41:46 -0700 (PDT)
In-Reply-To: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Anthony Olech <Anthony.Olech@diasemi.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Anthony Olech <Anthony.Olech@diasemi.com>
---
 drivers/input/touchscreen/da9052_tsi.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/da9052_tsi.c b/drivers/input/touchscreen/da9052_tsi.c
index 8f561e2..ab64d58 100644
--- a/drivers/input/touchscreen/da9052_tsi.c
+++ b/drivers/input/touchscreen/da9052_tsi.c
@@ -329,8 +329,6 @@ static int  da9052_ts_remove(struct platform_device *pdev)
 	input_unregister_device(tsi->dev);
 	kfree(tsi);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

