From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] Input: samsung-keypad - Implement runtime power management support
Date: Wed, 28 Dec 2011 11:21:24 +0000
Message-ID: <1325071284-28634-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:46395 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753640Ab1L1LV3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Dec 2011 06:21:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

When runtime power management is enabled put the Samsung keypad driver
into suspend mode with wakeups disabled whenever the device is open but
a key is not actually been pressed. As well as saving a trivial amount of
power this will support the use of SoC wide idle modes which put the entire
device into a retention mode and use explicit wakeup sources to exit.

Since not all of the interrupt controllers used with the driver support
set_irq_wake() (though they all do the right thing) and there's a nasty
WARN() when we disable wake after failing to enable it keep track of the
current wake status from runtime PM and only disable wake if we managed
to enable it; I'm not entirely sure why this doesn't affect the existing
uses of the API in the driver.

System suspend is unaffected as the driver core will runtime resume any
suspended devices prior to system suspend.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/keyboard/samsung-keypad.c |   80 +++++++++++++++++++++++++++++--
 1 files changed, 75 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index aa936ee..e7a6dad 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -20,6 +20,8 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_gpio.h>
@@ -69,6 +71,7 @@ struct samsung_keypad {
 	void __iomem *base;
 	wait_queue_head_t wait;
 	bool stopped;
+	bool wake_enabled;
 	int irq;
 	enum samsung_keypad_type type;
 	unsigned int row_shift;
@@ -155,6 +158,8 @@ static irqreturn_t samsung_keypad_irq(int irq, void *dev_id)
 	unsigned int val;
 	bool key_down;
 
+	pm_runtime_get_sync(keypad->input_dev->dev.parent);
+
 	do {
 		val = readl(keypad->base + SAMSUNG_KEYIFSTSCLR);
 		/* Clear interrupt. */
@@ -169,6 +174,8 @@ static irqreturn_t samsung_keypad_irq(int irq, void *dev_id)
 
 	} while (key_down && !keypad->stopped);
 
+	pm_runtime_put_sync(keypad->input_dev->dev.parent);
+
 	return IRQ_HANDLED;
 }
 
@@ -176,6 +183,8 @@ static void samsung_keypad_start(struct samsung_keypad *keypad)
 {
 	unsigned int val;
 
+	pm_runtime_get_sync(keypad->input_dev->dev.parent);
+
 	/* Tell IRQ thread that it may poll the device. */
 	keypad->stopped = false;
 
@@ -188,12 +197,16 @@ static void samsung_keypad_start(struct samsung_keypad *keypad)
 
 	/* KEYIFCOL reg clear. */
 	writel(0, keypad->base + SAMSUNG_KEYIFCOL);
+
+	pm_runtime_put_sync(keypad->input_dev->dev.parent);
 }
 
 static void samsung_keypad_stop(struct samsung_keypad *keypad)
 {
 	unsigned int val;
 
+	pm_runtime_get_sync(keypad->input_dev->dev.parent);
+
 	/* Signal IRQ thread to stop polling and disable the handler. */
 	keypad->stopped = true;
 	wake_up(&keypad->wait);
@@ -214,6 +227,8 @@ static void samsung_keypad_stop(struct samsung_keypad *keypad)
 	 * re-enable the handler.
 	 */
 	enable_irq(keypad->irq);
+
+	pm_runtime_put_sync(keypad->input_dev->dev.parent);
 }
 
 static int samsung_keypad_open(struct input_dev *input_dev)
@@ -398,6 +413,8 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
 		goto err_free_mem;
 	}
 
+	keypad->stopped = true;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		error = -ENODEV;
@@ -467,13 +484,14 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
 		goto err_put_clk;
 	}
 
+	device_init_wakeup(&pdev->dev, pdata->wakeup);
+	platform_set_drvdata(pdev, keypad);
+	pm_runtime_enable(&pdev->dev);
+
 	error = input_register_device(keypad->input_dev);
 	if (error)
 		goto err_free_irq;
 
-	device_init_wakeup(&pdev->dev, pdata->wakeup);
-	platform_set_drvdata(pdev, keypad);
-
 	if (pdev->dev.of_node) {
 		devm_kfree(&pdev->dev, (void *)pdata->keymap_data->keymap);
 		devm_kfree(&pdev->dev, (void *)pdata->keymap_data);
@@ -483,6 +501,7 @@ static int __devinit samsung_keypad_probe(struct platform_device *pdev)
 
 err_free_irq:
 	free_irq(keypad->irq, keypad);
+	pm_runtime_disable(&pdev->dev);
 err_put_clk:
 	clk_put(keypad->clk);
 	samsung_keypad_dt_gpio_free(keypad);
@@ -499,6 +518,7 @@ static int __devexit samsung_keypad_remove(struct platform_device *pdev)
 {
 	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
 
+	pm_runtime_disable(&pdev->dev);
 	device_init_wakeup(&pdev->dev, 0);
 	platform_set_drvdata(pdev, NULL);
 
@@ -519,6 +539,53 @@ static int __devexit samsung_keypad_remove(struct platform_device *pdev)
 	return 0;
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int samsung_keypad_runtime_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
+	unsigned int val;
+	int ret;
+
+	if (keypad->stopped)
+		return 0;
+
+	/* This may fail on some SoCs due to lack of controller support */
+	ret = enable_irq_wake(keypad->irq);
+	if (ret == 0)
+		keypad->wake_enabled = true;
+
+	val = readl(keypad->base + SAMSUNG_KEYIFCON);
+	val |= SAMSUNG_KEYIFCON_WAKEUPEN;
+	writel(val, keypad->base + SAMSUNG_KEYIFCON);
+
+	clk_disable(keypad->clk);
+
+	return 0;
+}
+
+static int samsung_keypad_runtime_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct samsung_keypad *keypad = platform_get_drvdata(pdev);
+	unsigned int val;
+
+	if (keypad->stopped)
+		return 0;
+
+	clk_enable(keypad->clk);
+
+	val = readl(keypad->base + SAMSUNG_KEYIFCON);
+	val &= ~SAMSUNG_KEYIFCON_WAKEUPEN;
+	writel(val, keypad->base + SAMSUNG_KEYIFCON);
+
+	if (keypad->wake_enabled)
+		disable_irq_wake(keypad->irq);
+
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_PM_SLEEP
 static void samsung_keypad_toggle_wakeup(struct samsung_keypad *keypad,
 					 bool enable)
@@ -591,8 +658,11 @@ MODULE_DEVICE_TABLE(of, samsung_keypad_dt_match);
 #define samsung_keypad_dt_match NULL
 #endif
 
-static SIMPLE_DEV_PM_OPS(samsung_keypad_pm_ops,
-			 samsung_keypad_suspend, samsung_keypad_resume);
+static const struct dev_pm_ops samsung_keypad_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(samsung_keypad_suspend, samsung_keypad_resume)
+	SET_RUNTIME_PM_OPS(samsung_keypad_runtime_suspend,
+			   samsung_keypad_runtime_resume, NULL)
+};
 
 static struct platform_device_id samsung_keypad_driver_ids[] = {
 	{
-- 
1.7.7.3

