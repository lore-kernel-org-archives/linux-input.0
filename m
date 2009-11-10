From: Ben Dooks <ben@simtec.co.uk>
Subject: [patch 1/3] gpio_keys: use dev_ macros to report information
Date: Tue, 10 Nov 2009 22:59:38 +0000
Message-ID: <20091110230002.096943221@fluff.org.uk>
References: <20091110225937.922379610@fluff.org.uk>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from aeryn.fluff.org.uk ([87.194.8.8]:42286 "EHLO
	kira.home.fluff.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758454AbZKJW75 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Nov 2009 17:59:57 -0500
Content-Disposition: inline; filename=simtec/ready/gpio-buttons-used-dev-reporting.patch
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Simtec Linux Team <linux@simtec.co.uk>

The gpio_keys driver is binding to a platform device but using pr_err()
to report errors. Change to using dev_err() so that all messages are
prefixed by the device name.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>

---
 drivers/input/keyboard/gpio_keys.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

Index: b/drivers/input/keyboard/gpio_keys.c
===================================================================
--- a/drivers/input/keyboard/gpio_keys.c	2009-11-03 22:17:12.000000000 +0000
+++ b/drivers/input/keyboard/gpio_keys.c	2009-11-03 22:22:45.000000000 +0000
@@ -78,6 +78,7 @@ static int __devinit gpio_keys_probe(str
 {
 	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	struct gpio_keys_drvdata *ddata;
+	struct device *dev = &pdev->dev;
 	struct input_dev *input;
 	int i, error;
 	int wakeup = 0;
@@ -87,6 +88,7 @@ static int __devinit gpio_keys_probe(str
 			GFP_KERNEL);
 	input = input_allocate_device();
 	if (!ddata || !input) {
+		dev_err(dev, "failed to allocate state\n");
 		error = -ENOMEM;
 		goto fail1;
 	}
@@ -122,14 +124,14 @@ static int __devinit gpio_keys_probe(str
 
 		error = gpio_request(button->gpio, button->desc ?: "gpio_keys");
 		if (error < 0) {
-			pr_err("gpio-keys: failed to request GPIO %d,"
-				" error %d\n", button->gpio, error);
+			dev_err(dev, "failed to request GPIO %d, error %d\n",
+				button->gpio, error);
 			goto fail2;
 		}
 
 		error = gpio_direction_input(button->gpio);
 		if (error < 0) {
-			pr_err("gpio-keys: failed to configure input"
+			dev_err(dev, "failed to configure"
 				" direction for GPIO %d, error %d\n",
 				button->gpio, error);
 			gpio_free(button->gpio);
@@ -139,8 +141,8 @@ static int __devinit gpio_keys_probe(str
 		irq = gpio_to_irq(button->gpio);
 		if (irq < 0) {
 			error = irq;
-			pr_err("gpio-keys: Unable to get irq number"
-				" for GPIO %d, error %d\n",
+			dev_err(dev, "Unable to get irq number "
+				"for GPIO %d, error %d\n",
 				button->gpio, error);
 			gpio_free(button->gpio);
 			goto fail2;
@@ -152,7 +154,7 @@ static int __devinit gpio_keys_probe(str
 				    button->desc ? button->desc : "gpio_keys",
 				    bdata);
 		if (error) {
-			pr_err("gpio-keys: Unable to claim irq %d; error %d\n",
+			dev_err(dev, "Unable to claim irq %d; error %d\n",
 				irq, error);
 			gpio_free(button->gpio);
 			goto fail2;
@@ -166,7 +168,7 @@ static int __devinit gpio_keys_probe(str
 
 	error = input_register_device(input);
 	if (error) {
-		pr_err("gpio-keys: Unable to register input device, "
+		dev_err(dev, "Unable to register input device, "
 			"error: %d\n", error);
 		goto fail2;
 	}

