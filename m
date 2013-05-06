From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 14/20] Input: pxa930_rotary - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:54 +0530
Message-ID: <1367814240-8959-14-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:57751 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752504Ab3EFEhh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:37 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx1so1817766pab.41
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:36 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Yao Yong <yaoyong@marvell.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Yao Yong <yaoyong@marvell.com>
---
 drivers/input/keyboard/pxa930_rotary.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/pxa930_rotary.c b/drivers/input/keyboard/pxa930_rotary.c
index bcad95b..248cdcf 100644
--- a/drivers/input/keyboard/pxa930_rotary.c
+++ b/drivers/input/keyboard/pxa930_rotary.c
@@ -181,7 +181,6 @@ static int pxa930_rotary_remove(struct platform_device *pdev)
 	free_irq(platform_get_irq(pdev, 0), r);
 	input_unregister_device(r->input_dev);
 	iounmap(r->mmio_base);
-	platform_set_drvdata(pdev, NULL);
 	kfree(r);
 
 	return 0;
-- 
1.7.9.5

