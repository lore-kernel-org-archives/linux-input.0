From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 01/20] Input: amikbd - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:41 +0530
Message-ID: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:64337 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab3EFEhD (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:03 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so1797859pdj.12
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/keyboard/amikbd.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/amikbd.c b/drivers/input/keyboard/amikbd.c
index ba0b36f..096d606 100644
--- a/drivers/input/keyboard/amikbd.c
+++ b/drivers/input/keyboard/amikbd.c
@@ -246,7 +246,6 @@ static int __exit amikbd_remove(struct platform_device *pdev)
 {
 	struct input_dev *dev = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
 	free_irq(IRQ_AMIGA_CIAA_SP, dev);
 	input_unregister_device(dev);
 	return 0;
-- 
1.7.9.5

