From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 2/4] Input: m68kspkr - Remove redundant platform_set_drvdata()
Date: Mon, 27 May 2013 17:07:06 +0530
Message-ID: <1369654628-20714-2-git-send-email-sachin.kamat@linaro.org>
References: <1369654628-20714-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:56900 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980Ab3E0LvG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 May 2013 07:51:06 -0400
Received: by mail-pd0-f181.google.com with SMTP id bv13so4646042pdb.40
        for <linux-input@vger.kernel.org>; Mon, 27 May 2013 04:51:05 -0700 (PDT)
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
 drivers/input/misc/m68kspkr.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/m68kspkr.c b/drivers/input/misc/m68kspkr.c
index b40ee4b..def21dc 100644
--- a/drivers/input/misc/m68kspkr.c
+++ b/drivers/input/misc/m68kspkr.c
@@ -85,7 +85,6 @@ static int m68kspkr_remove(struct platform_device *dev)
 	struct input_dev *input_dev = platform_get_drvdata(dev);
 
 	input_unregister_device(input_dev);
-	platform_set_drvdata(dev, NULL);
 	/* turn off the speaker */
 	m68kspkr_event(NULL, EV_SND, SND_BELL, 0);
 
-- 
1.7.9.5

