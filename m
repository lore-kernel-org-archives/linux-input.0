From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 12/20] Input: pmic8xxx-keypad - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:52 +0530
Message-ID: <1367814240-8959-12-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f49.google.com ([209.85.160.49]:38044 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482Ab3EFEhc (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:32 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp8so1765861pbb.22
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:31 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
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
 drivers/input/keyboard/pmic8xxx-keypad.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/pmic8xxx-keypad.c b/drivers/input/keyboard/pmic8xxx-keypad.c
index 74339e1..2c9f19a 100644
--- a/drivers/input/keyboard/pmic8xxx-keypad.c
+++ b/drivers/input/keyboard/pmic8xxx-keypad.c
@@ -707,7 +707,6 @@ err_gpio_config:
 err_get_irq:
 	input_free_device(kp->input);
 err_alloc_device:
-	platform_set_drvdata(pdev, NULL);
 	kfree(kp);
 	return rc;
 }
@@ -722,7 +721,6 @@ static int pmic8xxx_kp_remove(struct platform_device *pdev)
 	input_unregister_device(kp->input);
 	kfree(kp);
 
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
-- 
1.7.9.5

