From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] Input: at32psif - Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 16:06:39 +0530
Message-ID: <1367577400-9527-2-git-send-email-sachin.kamat@linaro.org>
References: <1367577400-9527-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:48856 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762986Ab3ECKtn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:49:43 -0400
Received: by mail-pd0-f172.google.com with SMTP id 5so861178pdd.17
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:49:43 -0700 (PDT)
In-Reply-To: <1367577400-9527-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
---
 drivers/input/serio/at32psif.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/serio/at32psif.c b/drivers/input/serio/at32psif.c
index 190ce35..3290b28 100644
--- a/drivers/input/serio/at32psif.c
+++ b/drivers/input/serio/at32psif.c
@@ -314,8 +314,6 @@ static int __exit psif_remove(struct platform_device *pdev)
 	clk_put(psif->pclk);
 	kfree(psif);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

