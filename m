From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH] input: pxa27x_keypad: add wakeup support
Date: Mon, 02 Jun 2008 18:00:50 +0800
Message-ID: <4843C4D2.8060800@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.225]:33242 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759107AbYFBKA6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Jun 2008 06:00:58 -0400
Received: by rv-out-0506.google.com with SMTP id l9so973119rvb.1
        for <linux-input@vger.kernel.org>; Mon, 02 Jun 2008 03:00:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>


Signed-off-by: eric miao <eric.miao@marvell.com>
---

Dmitry, please let me know when this gets merged, thanks.

 drivers/input/keyboard/pxa27x_keypad.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c b/drivers/input/keyboard/pxa27x_keypad.c
index 3dea0c5..27aa540 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -105,6 +105,8 @@ struct pxa27x_keypad {
 	struct input_dev *input_dev;
 	void __iomem *mmio_base;
 
+	int irq;
+
 	/* matrix key code map */
 	unsigned int matrix_keycodes[MAX_MATRIX_KEY_NUM];
 
@@ -385,6 +387,9 @@ static int pxa27x_keypad_suspend(struct platform_device *pdev, pm_message_t stat
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
 
 	clk_disable(keypad->clk);
+
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(keypad->irq);
 	return 0;
 }
 
@@ -393,6 +398,9 @@ static int pxa27x_keypad_resume(struct platform_device *pdev)
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
 	struct input_dev *input_dev = keypad->input_dev;
 
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(keypad->irq);
+
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users) {
@@ -497,6 +505,8 @@ static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
 		goto failed_free_dev;
 	}
 
+	keypad->irq = irq;
+
 	/* Register the input device */
 	error = input_register_device(input_dev);
 	if (error) {
@@ -504,6 +514,7 @@ static int __devinit pxa27x_keypad_probe(struct platform_device *pdev)
 		goto failed_free_irq;
 	}
 
+	device_init_wakeup(&pdev->dev, 1);
 	return 0;
 
 failed_free_irq:
@@ -527,7 +538,7 @@ static int __devexit pxa27x_keypad_remove(struct platform_device *pdev)
 	struct pxa27x_keypad *keypad = platform_get_drvdata(pdev);
 	struct resource *res;
 
-	free_irq(platform_get_irq(pdev, 0), pdev);
+	free_irq(keypad->irq, pdev);
 
 	clk_disable(keypad->clk);
 	clk_put(keypad->clk);
-- 
1.5.4.3

