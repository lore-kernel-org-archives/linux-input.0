From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/4] Input: ixp4xx-beeper - Remove redundant platform_set_drvdata()
Date: Mon, 27 May 2013 17:07:05 +0530
Message-ID: <1369654628-20714-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36406 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757380Ab3E0LvE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 27 May 2013 07:51:04 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so4069500pad.16
        for <linux-input@vger.kernel.org>; Mon, 27 May 2013 04:51:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org

Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
driver is bound) removes the need to set driver data field to
NULL.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/input/misc/ixp4xx-beeper.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/ixp4xx-beeper.c
index deab4a11..f34beb2 100644
--- a/drivers/input/misc/ixp4xx-beeper.c
+++ b/drivers/input/misc/ixp4xx-beeper.c
@@ -138,7 +138,6 @@ static int ixp4xx_spkr_remove(struct platform_device *dev)
 	unsigned int pin = (unsigned int) input_get_drvdata(input_dev);
 
 	input_unregister_device(input_dev);
-	platform_set_drvdata(dev, NULL);
 
 	/* turn the speaker off */
 	disable_irq(IRQ_IXP4XX_TIMER2);
-- 
1.7.9.5

