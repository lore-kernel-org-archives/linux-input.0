From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 09/20] Input: matrix_keypad - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:49 +0530
Message-ID: <1367814240-8959-9-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:47679 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab3EFEhY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:24 -0400
Received: by mail-pb0-f43.google.com with SMTP id md12so1799663pbc.16
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:24 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Marek Vasut <marek.vasut@gmail.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/input/keyboard/matrix_keypad.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 71d7719..90ff73a 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -549,8 +549,6 @@ static int matrix_keypad_remove(struct platform_device *pdev)
 	input_unregister_device(keypad->input_dev);
 	kfree(keypad);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

