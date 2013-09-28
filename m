From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 5/6] Input: egalax_ts - Remove redundant of_match_ptr
Date: Sat, 28 Sep 2013 17:58:13 +0530
Message-ID: <1380371294-10289-5-git-send-email-sachin.kamat@linaro.org>
References: <1380371294-10289-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:54491 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab3I1M2b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Sep 2013 08:28:31 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so3893301pab.13
        for <linux-input@vger.kernel.org>; Sat, 28 Sep 2013 05:28:31 -0700 (PDT)
In-Reply-To: <1380371294-10289-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/touchscreen/egalax_ts.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index c856fbc..b4d721f 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -274,7 +274,7 @@ static struct i2c_driver egalax_ts_driver = {
 		.name	= "egalax_ts",
 		.owner	= THIS_MODULE,
 		.pm	= &egalax_ts_pm_ops,
-		.of_match_table	= of_match_ptr(egalax_ts_dt_ids),
+		.of_match_table	= egalax_ts_dt_ids,
 	},
 	.id_table	= egalax_ts_id,
 	.probe		= egalax_ts_probe,
-- 
1.7.9.5

