From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 8/9] Input: tnetv107x-ts - Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:58:41 +0530
Message-ID: <1367576922-31459-8-git-send-email-sachin.kamat@linaro.org>
References: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:57670 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761851Ab3ECKmK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:42:10 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so860430pde.4
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:42:09 -0700 (PDT)
In-Reply-To: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/touchscreen/tnetv107x-ts.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/tnetv107x-ts.c b/drivers/input/touchscreen/tnetv107x-ts.c
index acfb876..c47827a 100644
--- a/drivers/input/touchscreen/tnetv107x-ts.c
+++ b/drivers/input/touchscreen/tnetv107x-ts.c
@@ -351,7 +351,6 @@ error_clk:
 error_map:
 	release_mem_region(ts->res->start, resource_size(ts->res));
 error_res:
-	platform_set_drvdata(pdev, NULL);
 	kfree(ts);
 
 	return error;
@@ -366,7 +365,6 @@ static int tsc_remove(struct platform_device *pdev)
 	clk_put(ts->clk);
 	iounmap(ts->regs);
 	release_mem_region(ts->res->start, resource_size(ts->res));
-	platform_set_drvdata(pdev, NULL);
 	kfree(ts);
 
 	return 0;
-- 
1.7.9.5

