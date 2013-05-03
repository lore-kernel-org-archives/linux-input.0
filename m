From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/3] Input: altera_ps2 - Remove redundant platform_set_drvdata()
Date: Fri,  3 May 2013 16:06:38 +0530
Message-ID: <1367577400-9527-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:45138 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab3ECKtk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 May 2013 06:49:40 -0400
Received: by mail-pb0-f52.google.com with SMTP id xa7so840294pbc.25
        for <linux-input@vger.kernel.org>; Fri, 03 May 2013 03:49:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Thomas Chou <thomas@wytron.com.tw>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Thomas Chou <thomas@wytron.com.tw>
---
 drivers/input/serio/altera_ps2.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/serio/altera_ps2.c b/drivers/input/serio/altera_ps2.c
index 479ce5f..a0a2657 100644
--- a/drivers/input/serio/altera_ps2.c
+++ b/drivers/input/serio/altera_ps2.c
@@ -163,7 +163,6 @@ static int altera_ps2_remove(struct platform_device *pdev)
 {
 	struct ps2if *ps2if = platform_get_drvdata(pdev);
 
-	platform_set_drvdata(pdev, NULL);
 	serio_unregister_port(ps2if->io);
 	free_irq(ps2if->irq, ps2if);
 	iounmap(ps2if->base);
-- 
1.7.9.5

