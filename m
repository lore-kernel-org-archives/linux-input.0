From: Philipp Zabel <philipp.zabel@gmail.com>
Subject: [PATCH] Input: pxa27x-keypad - add clk_prepare/clk_unprepare calls
Date: Thu, 15 Mar 2012 19:10:43 +0100
Message-ID: <1331835043.14662.2.camel@flow>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59361 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755827Ab2COSKs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Mar 2012 14:10:48 -0400
Received: by eekc41 with SMTP id c41so1821096eek.19
        for <linux-input@vger.kernel.org>; Thu, 15 Mar 2012 11:10:47 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

This patch adds clk_prepare/clk_unprepare calls to the pxa27x_keypad
driver by using the helper functions clk_prepare_enable and
clk_disable_unprepare.

Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/pxa27x_keypad.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 29fe1b2..4acb7b9 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -399,7 +399,7 @@ static int pxa27x_keypad_open(struct input_dev *dev)
 	struct pxa27x_keypad *keypad = input_get_drvdata(dev);
 
 	/* Enable unit clock */
-	clk_enable(keypad->clk);
+	clk_prepare_enable(keypad->clk);
 	pxa27x_keypad_config(keypad);
 
 	return 0;
@@ -410,7 +410,7 @@ static void pxa27x_keypad_close(struct input_dev *dev)
 	struct pxa27x_keypad *keypad = input_get_drvdata(dev);
 
 	/* Disable clock unit */
-	clk_disable(keypad->clk);
+	clk_disable_unprepare(keypad->clk);
 }
 
 #ifdef CONFIG_PM
@@ -419,7 +419,7 @@ static int pxa27x_keypad_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
 
-	clk_disable(keypad->clk);
+	clk_disable_unprepare(keypad->clk);
 
 	if (device_may_wakeup(&pdev->dev))
 		enable_irq_wake(keypad->irq);
@@ -440,7 +440,7 @@ static int pxa27x_keypad_resume(struct device *dev)
 
 	if (input_dev->users) {
 		/* Enable unit clock */
-		clk_enable(keypad->clk);
+		clk_prepare_enable(keypad->clk);
 		pxa27x_keypad_config(keypad);
 	}
 
-- 
1.7.9.1


