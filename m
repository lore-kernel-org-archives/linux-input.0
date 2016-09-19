From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] Input: snvs_pwrkey - drop input_free_device call if input_register_device fails
Date: Mon, 19 Sep 2016 09:49:16 +0800
Message-ID: <1474249756-30843-1-git-send-email-axel.lin@ingics.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35036 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936003AbcISBt1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 18 Sep 2016 21:49:27 -0400
Received: by mail-pf0-f194.google.com with SMTP id 6so3504153pfl.2
        for <linux-input@vger.kernel.org>; Sun, 18 Sep 2016 18:49:27 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Robin Gong <b38343@freescale.com>, Shawn Guo <shawnguo@kernel.org>, linux-input@vger.kernel.org, Axel Lin <axel.lin@ingics.com>

Current code uses devm_input_allocate_device() so don't explicitly call
input_free_device if input_register_device fails.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/input/keyboard/snvs_pwrkey.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 24a9f59..7544888 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -168,7 +168,6 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	error = input_register_device(input);
 	if (error < 0) {
 		dev_err(&pdev->dev, "failed to register input device\n");
-		input_free_device(input);
 		return error;
 	}
 
-- 
2.7.4

