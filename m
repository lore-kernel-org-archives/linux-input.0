From: Mike Rapoport <mike@compulab.co.il>
Subject: [PATCH] Input: gpio_keys - swtich to dev_pm_ops
Date: Tue, 21 Jul 2009 16:59:10 +0300
Message-ID: <1248184750-22274-1-git-send-email-mike@compulab.co.il>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from compulab.site5.com ([67.18.134.219]:39990 "EHLO compulab.co.il"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751350AbZGUN7M (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2009 09:59:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 drivers/input/keyboard/gpio_keys.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index efed0c9..a3a3b98 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -215,9 +215,9 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 }
 
 
-#ifdef CONFIG_PM
-static int gpio_keys_suspend(struct platform_device *pdev, pm_message_t state)
+static int gpio_keys_suspend(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	int i;
 
@@ -234,8 +234,9 @@ static int gpio_keys_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int gpio_keys_resume(struct platform_device *pdev)
+static int gpio_keys_resume(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	int i;
 
@@ -251,19 +252,19 @@ static int gpio_keys_resume(struct platform_device *pdev)
 
 	return 0;
 }
-#else
-#define gpio_keys_suspend	NULL
-#define gpio_keys_resume	NULL
-#endif
+
+static struct dev_pm_ops gpio_keys_pm_ops = {
+	.suspend	= gpio_keys_suspend,
+	.resume		= gpio_keys_resume,
+};
 
 static struct platform_driver gpio_keys_device_driver = {
 	.probe		= gpio_keys_probe,
-	.remove		= __devexit_p(gpio_keys_remove),
-	.suspend	= gpio_keys_suspend,
 	.resume		= gpio_keys_resume,
 	.driver		= {
 		.name	= "gpio-keys",
 		.owner	= THIS_MODULE,
+		.pm	= &gpio_keys_pm_ops,
 	}
 };
 
-- 
1.6.0.6

