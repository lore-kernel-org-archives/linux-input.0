From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 19/20] Input: twl4030_keypad - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:59 +0530
Message-ID: <1367814240-8959-19-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:56398 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355Ab3EFEhu (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:50 -0400
Received: by mail-da0-f54.google.com with SMTP id u36so1629588dak.27
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:49 -0700 (PDT)
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
 drivers/input/keyboard/twl4030_keypad.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 04f84fd..f05ee1db 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -438,7 +438,6 @@ static int twl4030_kp_remove(struct platform_device *pdev)
 
 	free_irq(kp->irq, kp);
 	input_unregister_device(kp->input);
-	platform_set_drvdata(pdev, NULL);
 	kfree(kp);
 
 	return 0;
-- 
1.7.9.5

