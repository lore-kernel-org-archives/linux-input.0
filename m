From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 16/20] Input: sh_keysc - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:56 +0530
Message-ID: <1367814240-8959-16-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:63541 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572Ab3EFEhm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:42 -0400
Received: by mail-pd0-f181.google.com with SMTP id p11so1798103pdj.12
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:42 -0700 (PDT)
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
 drivers/input/keyboard/sh_keysc.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/sh_keysc.c b/drivers/input/keyboard/sh_keysc.c
index fdb9eb2..fe0e498 100644
--- a/drivers/input/keyboard/sh_keysc.c
+++ b/drivers/input/keyboard/sh_keysc.c
@@ -266,7 +266,6 @@ static int sh_keysc_probe(struct platform_device *pdev)
  err2:
 	iounmap(priv->iomem_base);
  err1:
-	platform_set_drvdata(pdev, NULL);
 	kfree(priv);
  err0:
 	return error;
@@ -285,7 +284,6 @@ static int sh_keysc_remove(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
-	platform_set_drvdata(pdev, NULL);
 	kfree(priv);
 
 	return 0;
-- 
1.7.9.5

