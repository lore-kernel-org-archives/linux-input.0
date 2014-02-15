From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 1/2] Input: imx_keypad - Propagate the real error code on platform_get_irq() failure
Date: Sat, 15 Feb 2014 00:59:46 -0200
Message-ID: <1392433187-7756-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:39857 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518AbaBODHU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 14 Feb 2014 22:07:20 -0500
Received: by mail-yk0-f175.google.com with SMTP id 131so25419389ykp.6
        for <linux-input@vger.kernel.org>; Fri, 14 Feb 2014 19:07:19 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

No need to return a 'fake' return value on platform_get_irq() failure.

Just return the error code itself instead.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index cbf4f80..de07035 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -439,7 +439,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(&pdev->dev, "no irq defined in platform data\n");
-		return -EINVAL;
+		return irq;
 	}
 
 	input_dev = devm_input_allocate_device(&pdev->dev);
-- 
1.8.1.2

