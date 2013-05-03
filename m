From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 9/9] Input: w90p910_ts: Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 15:58:42 +0530
Message-ID: <1367576922-31459-9-git-send-email-sachin.kamat@linaro.org>
References: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:49831 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761851Ab3ECKmM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:42:12 -0400
Received: by mail-pb0-f42.google.com with SMTP id up7so837678pbc.1
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:42:12 -0700 (PDT)
In-Reply-To: <1367576922-31459-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Wan ZongShun <mcuos.com@gmail.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Wan ZongShun <mcuos.com@gmail.com>
---
 drivers/input/touchscreen/w90p910_ts.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/w90p910_ts.c b/drivers/input/touchscreen/w90p910_ts.c
index d2ef8f0..003d0c3 100644
--- a/drivers/input/touchscreen/w90p910_ts.c
+++ b/drivers/input/touchscreen/w90p910_ts.c
@@ -318,8 +318,6 @@ static int w90x900ts_remove(struct platform_device *pdev)
 	input_unregister_device(w90p910_ts->input);
 	kfree(w90p910_ts);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

