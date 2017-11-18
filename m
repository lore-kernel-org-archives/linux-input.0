From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 01/10 v3] Input: ep93xx_keypad: Fix platform_get_irq's error checking
Date: Sat, 18 Nov 2017 16:25:08 +0530
Message-ID: <a9a25cd5775ba4c76d47e8b66934e470f58d9e72.1510999558.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43865 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1422776AbdKRKz3 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Nov 2017 05:55:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, mcuos.com@gmail.com, linux@roeck-us.net, linux@armlinux.org.uk, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
               Return keypad->irq insted of -ENXIO.
changes in v3 :
               Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.

 drivers/input/keyboard/ep93xx_keypad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index f77b295..01788a7 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -257,8 +257,8 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	}
 
 	keypad->irq = platform_get_irq(pdev, 0);
-	if (!keypad->irq) {
-		err = -ENXIO;
+	if (keypad->irq <= 0) {
+		err = keypad->irq;
 		goto failed_free;
 	}
 
-- 
2.7.4

