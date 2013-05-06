From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 17/20] Input: spear-keyboard - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:57 +0530
Message-ID: <1367814240-8959-17-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:43737 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752602Ab3EFEhp (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:45 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so1836715pad.16
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:44 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/input/keyboard/spear-keyboard.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index cb1e8f6..7111124 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -290,7 +290,6 @@ static int spear_kbd_remove(struct platform_device *pdev)
 	clk_unprepare(kbd->clk);
 
 	device_init_wakeup(&pdev->dev, 0);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.9.5

