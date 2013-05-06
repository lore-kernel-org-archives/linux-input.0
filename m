From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 07/20] Input: jornada680_kbd - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:47 +0530
Message-ID: <1367814240-8959-7-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:35964 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab3EFEhT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:19 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so1796276pbc.3
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:18 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Kristoffer Ericson <kristoffer.ericson@gmail.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
---
 drivers/input/keyboard/jornada680_kbd.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/jornada680_kbd.c b/drivers/input/keyboard/jornada680_kbd.c
index 74e75a6..a2a034c 100644
--- a/drivers/input/keyboard/jornada680_kbd.c
+++ b/drivers/input/keyboard/jornada680_kbd.c
@@ -233,7 +233,6 @@ static int jornada680kbd_probe(struct platform_device *pdev)
  failed:
 	printk(KERN_ERR "Jornadakbd: failed to register driver, error: %d\n",
 		error);
-	platform_set_drvdata(pdev, NULL);
 	input_free_polled_device(poll_dev);
 	kfree(jornadakbd);
 	return error;
@@ -244,7 +243,6 @@ static int jornada680kbd_remove(struct platform_device *pdev)
 {
 	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
 	input_unregister_polled_device(jornadakbd->poll_dev);
 	input_free_polled_device(jornadakbd->poll_dev);
 	kfree(jornadakbd);
-- 
1.7.9.5

