From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 7/9] Input: ti_am335x_tsc: Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:58:40 +0530
Message-ID: <1367576922-31459-7-git-send-email-sachin.kamat@linaro.org>
References: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:52435 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab3ECKmH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:42:07 -0400
Received: by mail-pb0-f41.google.com with SMTP id mc17so846932pbc.14
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:42:06 -0700 (PDT)
In-Reply-To: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Rachna Patil <rachna@ti.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Rachna Patil <rachna@ti.com>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 51e7b87..50fb129 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -336,7 +336,6 @@ static int titsc_remove(struct platform_device *pdev)
 
 	input_unregister_device(ts_dev->input);
 
-	platform_set_drvdata(pdev, NULL);
 	kfree(ts_dev);
 	return 0;
 }
-- 
1.7.9.5

