From: Chao Xie <chao.xie@marvell.com>
Subject: [PATCH V3 1/4] Input: pxa27x_keypad keep clock on as wakeup source
Date: Sun,  1 Apr 2012 10:08:01 +0800
Message-ID: <1333246084-14110-1-git-send-email-chao.xie@marvell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:43847 "HELO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753984Ab2DACIn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Mar 2012 22:08:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, eric.y.miao@gmail.com, linux-arm-kernel@lists.infradead.org, haojian.zhuang@marvell.com

When the keypad is used as wake up source, the clock can not
be disabled. Or it can not detect key pressing.
If the keypad is used as wake up source, when resume back,
do not enable the clock and configure it again because the
register content is retained.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/input/keyboard/pxa27x_keypad.c |   33 ++++++++++++++++++++-----------
 1 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 29fe1b2..b07771e 100644
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
@@ -419,10 +419,14 @@ static int pxa27x_keypad_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
 
-	clk_disable(keypad->clk);
-
+	/*
+	 * If the keypad is used a wake up source, clock can not be disabled.
+	 * Or it can not detect the key pressing.
+	 */
 	if (device_may_wakeup(&pdev->dev))
 		enable_irq_wake(keypad->irq);
+	else
+		clk_disable_unprepare(keypad->clk);
 
 	return 0;
 }
@@ -433,19 +437,24 @@ static int pxa27x_keypad_resume(struct device *dev)
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
 	struct input_dev *input_dev = keypad->input_dev;
 
-	if (device_may_wakeup(&pdev->dev))
+	/*
+	 * If the keypad is used as wake up source, the clock is not turned
+	 * off. So do not need configure it again.
+	 */
+	if (device_may_wakeup(&pdev->dev)) {
 		disable_irq_wake(keypad->irq);
+	} else {
+		mutex_lock(&input_dev->mutex);
 
-	mutex_lock(&input_dev->mutex);
+		if (input_dev->users) {
+			/* Enable unit clock */
+			clk_prepare_enable(keypad->clk);
+			pxa27x_keypad_config(keypad);
+		}
 
-	if (input_dev->users) {
-		/* Enable unit clock */
-		clk_enable(keypad->clk);
-		pxa27x_keypad_config(keypad);
+		mutex_unlock(&input_dev->mutex);
 	}
 
-	mutex_unlock(&input_dev->mutex);
-
 	return 0;
 }
 
-- 
1.7.0.4

