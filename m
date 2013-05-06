From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 10/20] Input: omap4-keypad - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:50 +0530
Message-ID: <1367814240-8959-10-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:39388 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab3EFEh0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:26 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so1788689pbc.17
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:26 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/omap4-keypad.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 1b28909..f4aa53a 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -419,8 +419,6 @@ static int omap4_keypad_remove(struct platform_device *pdev)
 	kfree(keypad_data->keymap);
 	kfree(keypad_data);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

