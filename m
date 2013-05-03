From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/9] Input: atmel-wm97xx - Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:58:35 +0530
Message-ID: <1367576922-31459-2-git-send-email-sachin.kamat@linaro.org>
References: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:44003 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab3ECKlo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:41:44 -0400
Received: by mail-pb0-f51.google.com with SMTP id wy7so833094pbc.24
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:41:44 -0700 (PDT)
In-Reply-To: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mark Brown <broonie@kernel.org>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: Mark Brown <broonie@kernel.org>
---
 drivers/input/touchscreen/atmel-wm97xx.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel-wm97xx.c b/drivers/input/touchscreen/atmel-wm97xx.c
index 2c1e46b..268a35e 100644
--- a/drivers/input/touchscreen/atmel-wm97xx.c
+++ b/drivers/input/touchscreen/atmel-wm97xx.c
@@ -372,7 +372,6 @@ static int __init atmel_wm97xx_probe(struct platform_device *pdev)
 err_irq:
 	free_irq(atmel_wm97xx->ac97c_irq, atmel_wm97xx);
 err:
-	platform_set_drvdata(pdev, NULL);
 	kfree(atmel_wm97xx);
 	return ret;
 }
@@ -386,7 +385,6 @@ static int __exit atmel_wm97xx_remove(struct platform_device *pdev)
 	free_irq(atmel_wm97xx->ac97c_irq, atmel_wm97xx);
 	del_timer_sync(&atmel_wm97xx->pen_timer);
 	wm97xx_unregister_mach_ops(wm);
-	platform_set_drvdata(pdev, NULL);
 	kfree(atmel_wm97xx);
 
 	return 0;
-- 
1.7.9.5

