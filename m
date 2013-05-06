From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 13/20] Input: pxa27x_keypad - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:53 +0530
Message-ID: <1367814240-8959-13-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:50569 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497Ab3EFEhe (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:34 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so1833713pad.37
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:34 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Rodolfo Giometti <giometti@linux.it>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Rodolfo Giometti <giometti@linux.it>
---
 drivers/input/keyboard/pxa27x_keypad.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 5330d8f..74e30cc 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -609,7 +609,6 @@ static int pxa27x_keypad_remove(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
-	platform_set_drvdata(pdev, NULL);
 	kfree(keypad);
 
 	return 0;
-- 
1.7.9.5

