From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 02/20] Input: bf54x-keys - Remove redundant platform_set_drvdata()
Date: Mon,  6 May 2013 09:53:42 +0530
Message-ID: <1367814240-8959-2-git-send-email-sachin.kamat@linaro.org>
References: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:54025 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab3EFEhG (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 00:37:06 -0400
Received: by mail-pd0-f176.google.com with SMTP id x10so1792384pdj.7
        for <linux-input@vger.kernel.org>; Sun, 05 May 2013 21:37:05 -0700 (PDT)
In-Reply-To: <1367814240-8959-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Michael Hennerich <hennerich@blackfin.uclinux.org>

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
---
 drivers/input/keyboard/bf54x-keys.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index 20b9fa9..fc88fb4 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -326,7 +326,6 @@ out0:
 	kfree(bf54x_kpad->keycode);
 out:
 	kfree(bf54x_kpad);
-	platform_set_drvdata(pdev, NULL);
 
 	return error;
 }
@@ -346,7 +345,6 @@ static int bfin_kpad_remove(struct platform_device *pdev)
 
 	kfree(bf54x_kpad->keycode);
 	kfree(bf54x_kpad);
-	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
-- 
1.7.9.5

