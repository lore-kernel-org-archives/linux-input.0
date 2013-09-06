From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/4] Input: rb532_button - Remove redundant dev_set_drvdata
Date: Fri,  6 Sep 2013 23:38:08 +0530
Message-ID: <1378490888-5083-4-git-send-email-sachin.kamat@linaro.org>
References: <1378490888-5083-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:55227 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab3IFSIa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Sep 2013 14:08:30 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so3566937pdi.19
        for <linux-input@vger.kernel.org>; Fri, 06 Sep 2013 11:08:29 -0700 (PDT)
In-Reply-To: <1378490888-5083-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

Driver core sets the data to NULL upon release or probe
failure. Hence explicit setting is not necessary.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/misc/rb532_button.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/input/misc/rb532_button.c b/drivers/input/misc/rb532_button.c
index fb4f8ac..83fff38 100644
--- a/drivers/input/misc/rb532_button.c
+++ b/drivers/input/misc/rb532_button.c
@@ -87,7 +87,6 @@ static int rb532_button_remove(struct platform_device *pdev)
 
 	input_unregister_polled_device(poll_dev);
 	input_free_polled_device(poll_dev);
-	dev_set_drvdata(&pdev->dev, NULL);
 
 	return 0;
 }
-- 
1.7.4.1

