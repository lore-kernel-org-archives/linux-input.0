From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 01/10 v5] Input: ep93xx_keypad: Fix platform_get_irq's error checking
Date: Tue, 21 Nov 2017 21:41:51 +0530
Message-ID: <49ba0386f1930f58edfd5ee0f5e65d2a02a46744.1511280261.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, maxime.ripard@free-electrons.com, wens@csie.org, mcuos.com@gmail.com, linux@roeck-us.net, linux@armlinux.org.uk, lee.jones@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

The platform_get_irq() function returns negative if an error occurs.
zero or positive number on success. platform_get_irq() error checking
for zero is not correct.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2 :
              Return keypad->irq insted of -ENXIO.
changes in v3 :
              Add failure case '<= 0' instead of '< 0'. IRQ0 is not valid.
changes in v4 :
              Return -ENXIO insted of keypad->irq. Which was not correct in v3.
changes in v5 :
              Remove changes of v3 and v4. go back to version v2. Which is correct.
              No need to check for IRQ0 and return keypad->irq insted of -ENXIO.

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
+	if (keypad->irq < 0) {
+		err = keypad->irq;
 		goto failed_free;
 	}
 
-- 
2.7.4
