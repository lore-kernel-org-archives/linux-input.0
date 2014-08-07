From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Input: imx_keypad - use dev_get_drvdata()
Date: Thu,  7 Aug 2014 01:40:57 -0300
Message-ID: <1407386457-32587-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:47418 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277AbaHGEl1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Aug 2014 00:41:27 -0400
Received: by mail-yk0-f181.google.com with SMTP id q200so2412034ykb.12
        for <linux-input@vger.kernel.org>; Wed, 06 Aug 2014 21:41:26 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

There is no need to first get a platform_device structure in the suspend/resume
functions. 

Make the code simpler by calling dev_get_drvdata() directly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 20a99c3..56f6e99 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -533,8 +533,7 @@ static int imx_keypad_probe(struct platform_device *pdev)
 
 static int __maybe_unused imx_kbd_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_keypad *kbd = platform_get_drvdata(pdev);
+	struct imx_keypad *kbd = dev_get_drvdata(dev);
 	struct input_dev *input_dev = kbd->input_dev;
 
 	/* imx kbd can wake up system even clock is disabled */
@@ -545,7 +544,7 @@ static int __maybe_unused imx_kbd_suspend(struct device *dev)
 
 	mutex_unlock(&input_dev->mutex);
 
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(dev))
 		enable_irq_wake(kbd->irq);
 
 	return 0;
@@ -553,12 +552,11 @@ static int __maybe_unused imx_kbd_suspend(struct device *dev)
 
 static int __maybe_unused imx_kbd_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct imx_keypad *kbd = platform_get_drvdata(pdev);
+	struct imx_keypad *kbd = dev_get_drvdata(dev);
 	struct input_dev *input_dev = kbd->input_dev;
 	int ret = 0;
 
-	if (device_may_wakeup(&pdev->dev))
+	if (device_may_wakeup(dev))
 		disable_irq_wake(kbd->irq);
 
 	mutex_lock(&input_dev->mutex);
-- 
1.9.1

