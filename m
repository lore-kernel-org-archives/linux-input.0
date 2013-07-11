From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] Input: imx_keypad - Simplify devm_kzalloc
Date: Thu, 11 Jul 2013 01:44:48 -0300
Message-ID: <1373517888-15615-2-git-send-email-festevam@gmail.com>
References: <1373517888-15615-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:38950 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab3GKEpC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Jul 2013 00:45:02 -0400
Received: by mail-yh0-f51.google.com with SMTP id l109so3093158yhq.24
        for <linux-input@vger.kernel.org>; Wed, 10 Jul 2013 21:45:01 -0700 (PDT)
In-Reply-To: <1373517888-15615-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

According to Documentation/CodingStyle:

"The preferred form for passing a size of a struct is the following:

	p = kmalloc(sizeof(*p), ...);"

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 99d3360..c944659 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -454,8 +454,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	keypad = devm_kzalloc(&pdev->dev, sizeof(struct imx_keypad),
-			     GFP_KERNEL);
+	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
 	if (!keypad) {
 		dev_err(&pdev->dev, "not enough memory for driver data\n");
 		return -ENOMEM;
-- 
1.8.1.2

