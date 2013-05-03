From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/3] Input: amimouse - Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 16:12:21 +0530
Message-ID: <1367577742-14712-2-git-send-email-sachin.kamat@linaro.org>
References: <1367577742-14712-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:59832 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758199Ab3ECKzW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:55:22 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so870138pab.17
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:55:21 -0700 (PDT)
In-Reply-To: <1367577742-14712-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/mouse/amimouse.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/mouse/amimouse.c b/drivers/input/mouse/amimouse.c
index b55d5af..62ec52b 100644
--- a/drivers/input/mouse/amimouse.c
+++ b/drivers/input/mouse/amimouse.c
@@ -133,7 +133,6 @@ static int __exit amimouse_remove(struct platform_device *pdev)
 {
 	struct input_dev *dev = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
 	input_unregister_device(dev);
 	return 0;
 }
-- 
1.7.9.5

