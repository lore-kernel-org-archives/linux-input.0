From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 03/20] Input: davinci_keyscan - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:43 +0530
Message-ID: <1367814240-8959-3-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:45324 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab3EFEhI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:08 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp8so1756970pbb.8
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:08 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Miguel Aguilar <miguel.aguilar@ridgerun.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Miguel Aguilar <miguel.aguilar@ridgerun.com>
---
 drivers/input/keyboard/davinci_keyscan.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
index 8297537..d15977a 100644
--- a/drivers/input/keyboard/davinci_keyscan.c
+++ b/drivers/input/keyboard/davinci_keyscan.c
@@ -314,8 +314,6 @@ static int davinci_ks_remove(struct platform_device *pdev)
 	iounmap(davinci_ks->base);
 	release_mem_region(davinci_ks->pbase, davinci_ks->base_size);
 
-	platform_set_drvdata(pdev, NULL);
-
 	kfree(davinci_ks);
 
 	return 0;
-- 
1.7.9.5

