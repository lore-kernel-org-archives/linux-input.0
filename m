From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 05/20] Input: gpio_keys - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:45 +0530
Message-ID: <1367814240-8959-5-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f51.google.com ([209.85.160.51]:34064 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab3EFEhN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:13 -0400
Received: by mail-pb0-f51.google.com with SMTP id wy7so1777775pbc.10
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:13 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Phil Blundell <pb@handhelds.org>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Phil Blundell <pb@handhelds.org>
---
 drivers/input/keyboard/gpio_keys.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index b29ca65..440ce32 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -767,7 +767,6 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	while (--i >= 0)
 		gpio_remove_key(&ddata->data[i]);
 
-	platform_set_drvdata(pdev, NULL);
  fail1:
 	input_free_device(input);
 	kfree(ddata);
-- 
1.7.9.5

