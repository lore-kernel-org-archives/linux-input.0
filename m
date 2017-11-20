From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 01/10 v4] Input: ep93xx_keypad: Fix platform_get_irq's error checking
Date: Mon, 20 Nov 2017 21:56:21 +0530
Message-ID: <987ac156e9590cbe2f667f9782b56515d7a991a4.1511194239.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36890 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbdKTQ0m (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 20 Nov 2017 11:26:42 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, mcuos.com@gmail.com, linux@roeck-us.net, linux@armlinux.org.uk, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Return keypad->irq insted of -ENXIO.
changes in v3 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
changes ib v4 :
              Return -ENXIO insted of keypad->irq. Which was not correct in v3.

 drivers/input/keyboard/ep93xx_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/ep93xx_keypad.c b/drivers/input/keyboard/ep93xx_keypad.c
index f77b295..c6eb31a 100644
--- a/drivers/input/keyboard/ep93xx_keypad.c
+++ b/drivers/input/keyboard/ep93xx_keypad.c
@@ -257,7 +257,7 @@ static int ep93xx_keypad_probe(struct platform_device *pdev)
 	}
 
 	keypad->irq = platform_get_irq(pdev, 0);
-	if (!keypad->irq) {
+	if (keypad->irq <= 0) {
 		err = -ENXIO;
 		goto failed_free;
 	}
-- 
2.7.4

