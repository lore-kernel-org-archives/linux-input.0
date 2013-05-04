From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 7/9] Input: pmic8xxx-pwrkey - Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 20:21:56 +0530
Message-ID: <1367679118-2980-7-git-send-email-sachin.kamat@linaro.org>
References: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:58468 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760368Ab3EDOw1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 May 2013 10:52:27 -0400
Received: by mail-pd0-f177.google.com with SMTP id g10so1341856pdj.8
        for <linux-input@vger.kernel.org>; Sat, 04 May 2013 07:52:27 -0700 (PDT)
In-Reply-To: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Trilok Soni <tsoni@codeaurora.org>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Trilok Soni <tsoni@codeaurora.org>
---
 drivers/input/misc/pmic8xxx-pwrkey.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/pmic8xxx-pwrkey.c b/drivers/input/misc/pmic8xxx-pwrkey.c
index 4b811be..afd0af9 100644
--- a/drivers/input/misc/pmic8xxx-pwrkey.c
+++ b/drivers/input/misc/pmic8xxx-pwrkey.c
@@ -177,7 +177,6 @@ static int pmic8xxx_pwrkey_probe(struct platform_device *pdev)
 free_press_irq:
 	free_irq(key_press_irq, NULL);
 unreg_input_dev:
-	platform_set_drvdata(pdev, NULL);
 	input_unregister_device(pwr);
 	pwr = NULL;
 free_input_dev:
@@ -198,7 +197,6 @@ static int pmic8xxx_pwrkey_remove(struct platform_device *pdev)
 	free_irq(key_press_irq, pwrkey);
 	free_irq(key_release_irq, pwrkey);
 	input_unregister_device(pwrkey->pwr);
-	platform_set_drvdata(pdev, NULL);
 	kfree(pwrkey);
 
 	return 0;
-- 
1.7.4.1

