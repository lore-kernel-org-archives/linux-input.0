From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 11/20] Input: opencores-kbd - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:51 +0530
Message-ID: <1367814240-8959-11-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:39975 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280Ab3EFEh3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:29 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz10so1836603pad.16
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:29 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Javier Herrero <jherrero@hvsistemas.es>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Javier Herrero <jherrero@hvsistemas.es>
---
 drivers/input/keyboard/opencores-kbd.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/opencores-kbd.c b/drivers/input/keyboard/opencores-kbd.c
index 7ac5f17..7b9b441 100644
--- a/drivers/input/keyboard/opencores-kbd.c
+++ b/drivers/input/keyboard/opencores-kbd.c
@@ -151,8 +151,6 @@ static int opencores_kbd_remove(struct platform_device *pdev)
 	input_unregister_device(opencores_kbd->input);
 	kfree(opencores_kbd);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

