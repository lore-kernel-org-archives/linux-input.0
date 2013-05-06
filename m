From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 06/20] Input: gpio_keys_polled - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:46 +0530
Message-ID: <1367814240-8959-6-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54602 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab3EFEhQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:16 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so1833590pad.37
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:16 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Gabor Juhos <juhosg@openwrt.org>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Gabor Juhos <juhosg@openwrt.org>
---
 drivers/input/keyboard/gpio_keys_polled.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 2114716..cd5ed9e 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -324,7 +324,6 @@ err_free_gpio:
 
 err_free_bdev:
 	kfree(bdev);
-	platform_set_drvdata(pdev, NULL);
 
 err_free_pdata:
 	/* If we have no platform_data, we allocated pdata dynamically.  */
@@ -355,7 +354,6 @@ static int gpio_keys_polled_remove(struct platform_device *pdev)
 		kfree(pdata);
 
 	kfree(bdev);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.9.5

