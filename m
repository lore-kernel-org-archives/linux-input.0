From: Hui Wang <jason77.wang@gmail.com>
Subject: [v2] input/imx_keypad: add pm suspend and resume functions
Date: Wed, 12 Oct 2011 17:39:16 +0800
Message-ID: <1318412356-19719-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:64691 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab1JLJjg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Oct 2011 05:39:36 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, s.hauer@pengutronix.de, maramaopercheseimorto@gmail.com, gaowanlong@cn.fujitsu.com
Cc: linux-input@vger.kernel.org

The imx_keypad driver is set wake capable in the imx_keypad_probe(),
but it doesn't implement suspend and reusme callback interface.

>From the i.MX series MCU Reference Manual, the kpp (keypad port) is
a major wake up source which can detect any key press even in low
power modes and even when there is no clock.

Now add suspend and resume callback functions for this driver.

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---

In the V2:
1) add a check for input->users before disable clock.
2) add mutex_lock/unlock to protect input->users checking.
3) use SIMPLE_DEV_PM_OPS.

 drivers/input/keyboard/imx_keypad.c |   46 +++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index d92c15c..c43fa97 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -567,10 +567,56 @@ static int __devexit imx_keypad_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int imx_kbd_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_keypad *kbd = platform_get_drvdata(pdev);
+	struct input_dev *input_dev = kbd->input_dev;
+
+	/* imx kbd can wake up system even clock is disabled */
+	mutex_lock(&input_dev->mutex);
+
+	if (input_dev->users)
+		clk_disable(kbd->clk);
+
+	mutex_unlock(&input_dev->mutex);
+
+	if (device_may_wakeup(&pdev->dev))
+		enable_irq_wake(kbd->irq);
+
+	return 0;
+}
+
+static int imx_kbd_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_keypad *kbd = platform_get_drvdata(pdev);
+	struct input_dev *input_dev = kbd->input_dev;
+
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(kbd->irq);
+
+	mutex_lock(&input_dev->mutex);
+
+	if (input_dev->users)
+		clk_enable(kbd->clk);
+
+	mutex_unlock(&input_dev->mutex);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(imx_kbd_pm_ops, imx_kbd_suspend, imx_kbd_resume);
+#endif
+
 static struct platform_driver imx_keypad_driver = {
 	.driver		= {
 		.name	= "imx-keypad",
 		.owner	= THIS_MODULE,
+#ifdef CONFIG_PM
+		.pm	= &imx_kbd_pm_ops,
+#endif
 	},
 	.probe		= imx_keypad_probe,
 	.remove		= __devexit_p(imx_keypad_remove),
-- 
1.7.6

