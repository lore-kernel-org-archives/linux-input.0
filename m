From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/9] Input: ab8500-ponkey - Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 20:21:50 +0530
Message-ID: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33485 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760081Ab3EDOwL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 May 2013 10:52:11 -0400
Received: by mail-pd0-f175.google.com with SMTP id y14so1351882pdi.6
        for <linux-input@vger.kernel.org>; Sat, 04 May 2013 07:52:11 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Sundar Iyer <sundar.iyer@stericsson.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Sundar Iyer <sundar.iyer@stericsson.com>
---
This series compile tested and based on linux-next (20130503).
---
 drivers/input/misc/ab8500-ponkey.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
index 2f090b4..f2fbdd8 100644
--- a/drivers/input/misc/ab8500-ponkey.c
+++ b/drivers/input/misc/ab8500-ponkey.c
@@ -127,8 +127,6 @@ static int ab8500_ponkey_remove(struct platform_device *pdev)
 	input_unregister_device(ponkey->idev);
 	kfree(ponkey);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.4.1

