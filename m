From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 9/9] Input: rotary_encoder - Remove redundant platform_set_drvdata()
Date: Sat,  4 May 2013 20:21:58 +0530
Message-ID: <1367679118-2980-9-git-send-email-sachin.kamat@linaro.org>
References: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:61977 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760417Ab3EDOwd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 4 May 2013 10:52:33 -0400
Received: by mail-da0-f53.google.com with SMTP id o9so1195246dan.26
        for <linux-input@vger.kernel.org>; Sat, 04 May 2013 07:52:32 -0700 (PDT)
In-Reply-To: <1367679118-2980-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Daniel Mack <daniel@caiaq.de>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Daniel Mack <daniel@caiaq.de>
---
 drivers/input/misc/rotary_encoder.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index aff47b2..5b1aff8 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -317,8 +317,6 @@ static int rotary_encoder_remove(struct platform_device *pdev)
 	if (!dev_get_platdata(&pdev->dev))
 		kfree(pdata);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.4.1

