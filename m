From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 6/6] Input: ti_am335x_tsc - Remove redundant of_match_ptr
Date: Sat, 28 Sep 2013 17:58:14 +0530
Message-ID: <1380371294-10289-6-git-send-email-sachin.kamat@linaro.org>
References: <1380371294-10289-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:50032 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754127Ab3I1M2d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Sep 2013 08:28:33 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so3687639pdj.6
        for <linux-input@vger.kernel.org>; Sat, 28 Sep 2013 05:28:33 -0700 (PDT)
In-Reply-To: <1380371294-10289-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 24e625c..14b7390 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -511,7 +511,7 @@ static struct platform_driver ti_tsc_driver = {
 		.name   = "TI-am335x-tsc",
 		.owner	= THIS_MODULE,
 		.pm	= TITSC_PM_OPS,
-		.of_match_table = of_match_ptr(ti_tsc_dt_ids),
+		.of_match_table = ti_tsc_dt_ids,
 	},
 };
 module_platform_driver(ti_tsc_driver);
-- 
1.7.9.5

