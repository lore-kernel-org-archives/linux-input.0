From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 04/20] Input: ep93xx_keypad - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:44 +0530
Message-ID: <1367814240-8959-4-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:61929 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab3EFEhL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:11 -0400
Received: by mail-pd0-f178.google.com with SMTP id w11so1797230pde.9
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:10 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, H Hartley Sweeten <hsweeten@visionengravers.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
---
 drivers/input/keyboard/ep93xx_keypad.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index 9857e8f..a8d5aac 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -330,7 +330,6 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 
 failed_free_irq:
 	free_irq(keypad->irq, pdev);
-	platform_set_drvdata(pdev, NULL);
 failed_free_dev:
 	input_free_device(input_dev);
 failed_put_clk:
@@ -353,8 +352,6 @@ static int ep93xx_keypad_remove(struct platform_device *pdev)
 
 	free_irq(keypad->irq, pdev);
 
-	platform_set_drvdata(pdev, NULL);
-
 	if (keypad->enabled)
 		clk_disable(keypad->clk);
 	clk_put(keypad->clk);
-- 
1.7.9.5

