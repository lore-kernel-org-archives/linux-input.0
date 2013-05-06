From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 20/20] Input: w90p910_keypad - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:54:00 +0530
Message-ID: <1367814240-8959-20-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:58609 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab3EFEhw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:52 -0400
Received: by mail-pa0-f52.google.com with SMTP id bg2so1818221pad.11
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:52 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
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
 drivers/input/keyboard/w90p910_keypad.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/w90p910_keypad.c b/drivers/input/keyboard/w90p910_keypad.c
index ee163be..72e6a56 100644
--- a/drivers/input/keyboard/w90p910_keypad.c
+++ b/drivers/input/keyboard/w90p910_keypad.c
@@ -249,7 +249,6 @@ static int w90p910_keypad_remove(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
-	platform_set_drvdata(pdev, NULL);
 	kfree(keypad);
 
 	return 0;
-- 
1.7.9.5

