From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 4/4] Input: xilinx_ps2 - Remove redundant platform_set_drvdata()
Date: Mon, 27 May 2013 17:07:08 +0530
Message-ID: <1369654628-20714-4-git-send-email-sachin.kamat@linaro.org>
References: <1369654628-20714-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:53566 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758009Ab3E0LvN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 May 2013 07:51:13 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so6718777pbb.13
        for <linux-input@vger.kernel.org>; Mon, 27 May 2013 04:51:13 -0700 (PDT)
In-Reply-To: <1369654628-20714-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/serio/xilinx_ps2.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 17be859..4b7662a 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -349,8 +349,6 @@ static int xps2_of_remove(struct platform_device *of_dev)
 
 	kfree(drvdata);
 
-	platform_set_drvdata(of_dev, NULL);
-
 	return 0;
 }
 
-- 
1.7.9.5

