From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: imx_keypad - use the preferred form for passing a size of a struct
Date: Tue, 30 Dec 2014 11:47:16 -0200
Message-ID: <1419947236-17328-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:60827 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaL3Nri (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Dec 2014 08:47:38 -0500
Received: by mail-vc0-f170.google.com with SMTP id hy4so5794973vcb.1
        for <linux-input@vger.kernel.org>; Tue, 30 Dec 2014 05:47:37 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

According to Documentation/CodingStyle - Chapter 14:

"The preferred form for passing a size of a struct is the following:

        p = kmalloc(sizeof(*p), ...);

The alternative form where struct name is spelled out hurts readability and
introduces an opportunity for a bug when the pointer variable type is changed
but the corresponding sizeof that is passed to a memory allocator is not."

So do it as recommeded.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index e53f232..2e855e6 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -448,8 +448,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	keypad = devm_kzalloc(&pdev->dev, sizeof(struct imx_keypad),
-			      GFP_KERNEL);
+	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
 	if (!keypad) {
 		dev_err(&pdev->dev, "not enough memory for driver data\n");
 		return -ENOMEM;
-- 
1.9.1

