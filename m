From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: samsung-keypad - Don't synchronise with runtime PM put
Date: Sun, 22 Jan 2012 22:18:51 +0000
Message-ID: <1327270731-808-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:54391 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752298Ab2AVWSz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Jan 2012 17:18:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

We don't actually care if the device has been runtime suspended immediately
so we can just drop the reference without waiting for any state change to
be implemented. This may allow us to avoid some suspend/resume cycles and
is a bit more friendly to the rest of the system.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/keyboard/samsung-keypad.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 17ba7f9..2391ae8 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -175,7 +175,7 @@ static irqreturn_t samsung_keypad_irq(int irq, void *dev_id)
 
 	} while (key_down && !keypad->stopped);
 
-	pm_runtime_put_sync(&keypad->pdev->dev);
+	pm_runtime_put(&keypad->pdev->dev);
 
 	return IRQ_HANDLED;
 }
@@ -199,7 +199,7 @@ static void samsung_keypad_start(struct samsung_keypad *keypad)
 	/* KEYIFCOL reg clear. */
 	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
 
-	pm_runtime_put_sync(&keypad->pdev->dev);
+	pm_runtime_put(&keypad->pdev->dev);
 }
 
 static void samsung_keypad_stop(struct samsung_keypad *keypad)
@@ -229,7 +229,7 @@ static void samsung_keypad_stop(struct samsung_keypad *keypad)
 	 */
 	enable_irq(keypad->irq);
 
-	pm_runtime_put_sync(&keypad->pdev->dev);
+	pm_runtime_put(&keypad->pdev->dev);
 }
 
 static int samsung_keypad_open(struct input_dev *input_dev)
-- 
1.7.7.3

