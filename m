From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 18/20] Input: tnetv107x-keypad - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:58 +0530
Message-ID: <1367814240-8959-18-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:41527 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab3EFEhr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:47 -0400
Received: by mail-pa0-f49.google.com with SMTP id bi5so1099289pad.22
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:47 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/tnetv107x-keypad.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/tnetv107x-keypad.c b/drivers/input/keyboard/tnetv107x-keypad.c
index ee16350..5f7b427 100644
--- a/drivers/input/keyboard/tnetv107x-keypad.c
+++ b/drivers/input/keyboard/tnetv107x-keypad.c
@@ -296,7 +296,6 @@ error_clk:
 error_map:
 	release_mem_region(kp->res->start, resource_size(kp->res));
 error_res:
-	platform_set_drvdata(pdev, NULL);
 	kfree(kp);
 	return error;
 }
@@ -311,7 +310,6 @@ static int keypad_remove(struct platform_device *pdev)
 	clk_put(kp->clk);
 	iounmap(kp->regs);
 	release_mem_region(kp->res->start, resource_size(kp->res));
-	platform_set_drvdata(pdev, NULL);
 	kfree(kp);
 
 	return 0;
-- 
1.7.9.5

