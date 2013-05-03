From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] Input: q40kbd - Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 16:12:20 +0530
Message-ID: <1367577742-14712-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:44504 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758199Ab3ECKzS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:55:18 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so857050pdj.38
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:55:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/serio/q40kbd.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index 436a343..7a65a1b 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -181,7 +181,6 @@ static int q40kbd_remove(struct platform_device *pdev)
 	free_irq(Q40_IRQ_KEYBOARD, q40kbd);
 	kfree(q40kbd);
 
-	platform_set_drvdata(pdev, NULL);
 	return 0;
 }
 
-- 
1.7.9.5

