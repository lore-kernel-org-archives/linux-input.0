From: Hui Wang <jason77.wang@gmail.com>
Subject: [PATCH] input/imx_keypad: add pm suspend and resume functions
Date: Fri, 30 Sep 2011 15:54:14 +0800
Message-ID: <1317369254-31146-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:39942 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754779Ab1I3Hya (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Sep 2011 03:54:30 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, s.hauer@pengutronix.de, maramaopercheseimorto@gmail.com
Cc: linux-input@vger.kernel.org

The imx_keypad driver is set wake capable in the imx_keypad_probe(),
but it doesn't implement suspend and reusme callback interface.

>From the i.MX series MCU Reference Manual, the kpp (keypad port) is
a major wake up source which can detect any key press even in low
power modes and even when there is no clock.

Now add suspend and resume callback functions for this driver.

Signed-off-by: Hui Wang <jason77.wang@gmail.com>
---
Validated this patch both on i.MX51 PDK and i.MX31 PDK

 drivers/input/keyboard/imx_keypad.c |   42 +++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index d92c15c..9992617 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -567,10 +567,52 @@ static int __devexit imx_keypad_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int imx_kbd_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct imx_keypad *kbd = platform_get_drvdata(pdev);
+
+	clk_disable(kbd->clk);
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
+	mutex_lock(&input_dev->mutex);
+
+	if (device_may_wakeup(&pdev->dev))
+		disable_irq_wake(kbd->irq);
+
+	if (input_dev->users)
+		clk_enable(kbd->clk);
+
+	mutex_unlock(&input_dev->mutex);
+
+	return 0;
+}
+
+static const struct dev_pm_ops imx_kbd_pm_ops = {
+	.suspend	= imx_kbd_suspend,
+	.resume		= imx_kbd_resume,
+};
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

