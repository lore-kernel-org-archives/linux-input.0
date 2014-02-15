From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] Input: imx_keypad - Omit error message devm_kzalloc() failure
Date: Sat, 15 Feb 2014 00:59:47 -0200
Message-ID: <1392433187-7756-2-git-send-email-festevam@gmail.com>
References: <1392433187-7756-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yh0-f41.google.com ([209.85.213.41]:49841 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbaBOC75 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Feb 2014 21:59:57 -0500
Received: by mail-yh0-f41.google.com with SMTP id f73so12675060yha.0
        for <linux-input@vger.kernel.org>; Fri, 14 Feb 2014 18:59:56 -0800 (PST)
In-Reply-To: <1392433187-7756-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no need to print an error message in the driver for devm_kzalloc()
failure because OOM core code handles it properly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index de07035..40ad98d 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -450,10 +450,8 @@ static int imx_keypad_probe(struct platform_device *pdev)
 
 	keypad = devm_kzalloc(&pdev->dev, sizeof(struct imx_keypad),
 			     GFP_KERNEL);
-	if (!keypad) {
-		dev_err(&pdev->dev, "not enough memory for driver data\n");
+	if (!keypad)
 		return -ENOMEM;
-	}
 
 	keypad->input_dev = input_dev;
 	keypad->irq = irq;
-- 
1.8.1.2

