From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 15/20] Input: samsung-keypad - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:55 +0530
Message-ID: <1367814240-8959-15-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:36481 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab3EFEhk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:40 -0400
Received: by mail-da0-f50.google.com with SMTP id i23so1651307dad.37
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:39 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Joonyoung Shim <jy0922.shim@samsung.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Joonyoung Shim <jy0922.shim@samsung.com>
---
 drivers/input/keyboard/samsung-keypad.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 22e357b..7b938b4 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -487,7 +487,6 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 err_disable_runtime_pm:
 	pm_runtime_disable(&pdev->dev);
 	device_init_wakeup(&pdev->dev, 0);
-	platform_set_drvdata(pdev, NULL);
 err_unprepare_clk:
 	clk_unprepare(keypad->clk);
 	return error;
@@ -499,7 +498,6 @@ static int samsung_keypad_remove(struct platform_device *pdev)
 
 	pm_runtime_disable(&pdev->dev);
 	device_init_wakeup(&pdev->dev, 0);
-	platform_set_drvdata(pdev, NULL);
 
 	input_unregister_device(keypad->input_dev);
 
-- 
1.7.9.5

