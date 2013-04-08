From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] Input: apbps2 - Convert to devm_ioremap_resource()
Date: Mon,  8 Apr 2013 14:33:51 +0530
Message-ID: <1365411831-8021-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:50900 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934798Ab3DHJPq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Apr 2013 05:15:46 -0400
Received: by mail-pa0-f43.google.com with SMTP id hz11so3164442pad.2
        for <linux-input@vger.kernel.org>; Mon, 08 Apr 2013 02:15:45 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, sachin.kamat@linaro.org, Daniel Hellstrom <daniel@gaisler.com>

Use the newly introduced devm_ioremap_resource() instead of
devm_request_and_ioremap() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages; so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
---
 drivers/input/serio/apbps2.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/input/serio/apbps2.c b/drivers/input/serio/apbps2.c
index 2c14e6f..17e01a8 100644
--- a/drivers/input/serio/apbps2.c
+++ b/drivers/input/serio/apbps2.c
@@ -147,11 +147,9 @@ static int apbps2_of_probe(struct platform_device *ofdev)
 
 	/* Find Device Address */
 	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
-	priv->regs = devm_request_and_ioremap(&ofdev->dev, res);
-	if (!priv->regs) {
-		dev_err(&ofdev->dev, "io-regs mapping failed\n");
-		return -EBUSY;
-	}
+	priv->regs = devm_ioremap_resource(&ofdev->dev, res);
+	if (IS_ERR(priv->regs))
+		return PTR_ERR(priv->regs);
 
 	/* Reset hardware, disable interrupt */
 	iowrite32be(0, &priv->regs->ctrl);
-- 
1.7.9.5

