From: Chao Xie <chao.xie@marvell.com>
Subject: [PATCH V2 1/4] Input: pxa27x_keypad keep clock on as wakeup source
Date: Fri, 30 Mar 2012 09:58:15 +0800
Message-ID: <1333072698-15344-1-git-send-email-chao.xie@marvell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:53847 "HELO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759464Ab2C3Boy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Mar 2012 21:44:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, eric.y.miao@gmail.com, haojian.zhuang@marvell.com, linux-arm-kernel@lists.infradead.org

When the keypad is used as wake up source, the clock can not
be disabled. Or it can not detect key pressing.
If the keypad is used as wake up source, when resume back,
do not enable the clock and configure it again because the
register content is retained.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/input/keyboard/pxa27x_keypad.c |   27 ++++++++++++++++++---------
 1 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 29fe1b2..1c5752f 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
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
+		clk_disable(keypad->clk);
 
 	return 0;
 }
@@ -433,19 +437,24 @@ static int pxa27x_keypad_resume(struct device *dev)
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
 	struct input_dev *input_dev = keypad->input_dev;
 
+	/*
+	 * If the keypad is used as wake up source, the clock is not turned
+	 * off. So do not need configure it again.
+	 */
 	if (device_may_wakeup(&pdev->dev))
 		disable_irq_wake(keypad->irq);
+	else {
+		mutex_lock(&input_dev->mutex);
 
-	mutex_lock(&input_dev->mutex);
+		if (input_dev->users) {
+			/* Enable unit clock */
+			clk_enable(keypad->clk);
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

