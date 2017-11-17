From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/3 v2] Input: omap4-keypad: Fix platform_get_irq's error checking
Date: Sat, 18 Nov 2017 02:28:48 +0530
Message-ID: <f317ec56b23b11b79284c29d12a7004575aa35db.1510951446.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33291 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761905AbdKQU7W (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 15:59:22 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, linux@roeck-us.net, wsa@the-dreams.de, daniel.thompson@linaro.org, mcuos.com@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes ib v2 :
               Return error(irq) insted of -EINVAL.

 drivers/input/keyboard/omap4-keypad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 940d38b..9ad840c 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -251,9 +251,9 @@ static int omap4_keypad_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (!irq) {
+	if (irq < 0) {
 		dev_err(&pdev->dev, "no keyboard irq assigned\n");
-		return -EINVAL;
+		return irq;
 	}
 
 	keypad_data = kzalloc(sizeof(struct omap4_keypad), GFP_KERNEL);
-- 
2.7.4

