From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 08/20] Input: jornada720_kbd - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:48 +0530
Message-ID: <1367814240-8959-8-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:60550 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752220Ab3EFEhV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:21 -0400
Received: by mail-pd0-f173.google.com with SMTP id v10so1803681pde.32
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:21 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Kristoffer Ericson <Kristoffer.Ericson@gmail.com>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Kristoffer Ericson <Kristoffer.Ericson@gmail.com>
---
 drivers/input/keyboard/jornada720_kbd.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/jornada720_kbd.c b/drivers/input/keyboard/jornada720_kbd.c
index 5ceef63..b0ad457 100644
--- a/drivers/input/keyboard/jornada720_kbd.c
+++ b/drivers/input/keyboard/jornada720_kbd.c
@@ -146,7 +146,6 @@ static int jornada720_kbd_probe(struct platform_device *pdev)
  fail2:	/* IRQ, DEVICE, MEMORY */
 	free_irq(IRQ_GPIO0, pdev);
  fail1:	/* DEVICE, MEMORY */
-	platform_set_drvdata(pdev, NULL);
 	input_free_device(input_dev);
 	kfree(jornadakbd);
 	return err;
@@ -157,7 +156,6 @@ static int jornada720_kbd_remove(struct platform_device *pdev)
 	struct jornadakbd *jornadakbd = platform_get_drvdata(pdev);
 
 	free_irq(IRQ_GPIO0, pdev);
-	platform_set_drvdata(pdev, NULL);
 	input_unregister_device(jornadakbd->input);
 	kfree(jornadakbd);
 
-- 
1.7.9.5

