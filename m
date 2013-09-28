From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/6] Input: sirfsoc-onkey - Remove redundant of_match_ptr
Date: Sat, 28 Sep 2013 17:58:12 +0530
Message-ID: <1380371294-10289-4-git-send-email-sachin.kamat@linaro.org>
References: <1380371294-10289-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:65379 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072Ab3I1M23 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Sep 2013 08:28:29 -0400
Received: by mail-pd0-f181.google.com with SMTP id g10so3720635pdj.12
        for <linux-input@vger.kernel.org>; Sat, 28 Sep 2013 05:28:28 -0700 (PDT)
In-Reply-To: <1380371294-10289-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/misc/sirfsoc-onkey.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/sirfsoc-onkey.c b/drivers/input/misc/sirfsoc-onkey.c
index 0621c36..7b8b03e 100644
--- a/drivers/input/misc/sirfsoc-onkey.c
+++ b/drivers/input/misc/sirfsoc-onkey.c
@@ -153,7 +153,7 @@ static struct platform_driver sirfsoc_pwrc_driver = {
 		.name	= "sirfsoc-pwrc",
 		.owner	= THIS_MODULE,
 		.pm	= &sirfsoc_pwrc_pm_ops,
-		.of_match_table = of_match_ptr(sirfsoc_pwrc_of_match),
+		.of_match_table = sirfsoc_pwrc_of_match,
 	}
 };
 
-- 
1.7.9.5

