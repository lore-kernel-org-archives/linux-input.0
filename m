From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/6] Input: lpc32xx-keys - Remove redundant of_match_ptr
Date: Sat, 28 Sep 2013 17:58:09 +0530
Message-ID: <1380371294-10289-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:51120 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab3I1M2W (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Sep 2013 08:28:22 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so3641648pbb.6
        for <linux-input@vger.kernel.org>; Sat, 28 Sep 2013 05:28:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/lpc32xx-keys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/lpc32xx-keys.c b/drivers/input/keyboard/lpc32xx-keys.c
index 4218143..8b1b013 100644
--- a/drivers/input/keyboard/lpc32xx-keys.c
+++ b/drivers/input/keyboard/lpc32xx-keys.c
@@ -383,7 +383,7 @@ static struct platform_driver lpc32xx_kscan_driver = {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
 		.pm	= &lpc32xx_kscan_pm_ops,
-		.of_match_table = of_match_ptr(lpc32xx_kscan_match),
+		.of_match_table = lpc32xx_kscan_match,
 	}
 };
 
-- 
1.7.9.5

