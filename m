From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/9] Input: mc13783-pwrbutton - Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 20:21:54 +0530
Message-ID: <1367679118-2980-5-git-send-email-sachin.kamat@linaro.org>
References: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:46997 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760340Ab3EDOwW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 May 2013 10:52:22 -0400
Received: by mail-pa0-f41.google.com with SMTP id rl6so1387859pac.28
        for <linux-input@vger.kernel.org>; Sat, 04 May 2013 07:52:21 -0700 (PDT)
In-Reply-To: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/misc/mc13783-pwrbutton.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/mc13783-pwrbutton.c b/drivers/input/misc/mc13783-pwrbutton.c
index 0906ca5..d0277a7 100644
--- a/drivers/input/misc/mc13783-pwrbutton.c
+++ b/drivers/input/misc/mc13783-pwrbutton.c
@@ -250,7 +250,6 @@ static int mc13783_pwrbutton_remove(struct platform_device *pdev)
 
 	input_unregister_device(priv->pwr);
 	kfree(priv);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.4.1

