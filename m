From: Herbert Valerio Riedel <hvr@gnu.org>
Subject: [PATCH,RFC] Input: gpio-keys - request and configure GPIOs
Date: Fri, 16 Nov 2007 12:33:50 +0100
Message-ID: <1195212830-9137-1-git-send-email-hvr@gnu.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from shswe.rise-s.com ([83.65.168.195]:41370 "EHLO shswe.swe"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752950AbXKPLq4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 16 Nov 2007 06:46:56 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Paul Sokolovsky <pmiscml@gmail.com>, Philipp Zabel <philipp.zabel@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, Philip Blundell <philb@gnu.org>

Currently, gpio_keys.c assumes the GPIOs to be already properly configured;
this patch changes gpio-keys to perform explicit calls to gpio_request() and
gpio_configure_input().

This matches the behaviour of leds-gpio.

Cc: Paul Sokolovsky <pmiscml@gmail.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Dmitry Torokhov <dtor@mail.ru>
Cc: Philip Blundell <philb@gnu.org>
---
btw, I'm unsure whether the '?:' operator is allowed in kernel source;
but since I found quite a bit of occurences throughout the kernel source
(including gpio_keys.c), I assume it's tolerated... :-)

 drivers/input/keyboard/gpio_keys.c |   26 ++++++++++++++++++++++++--
 1 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 3eddf52..445265c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -75,9 +75,26 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		struct gpio_keys_button *button = &pdata->buttons[i];
-		int irq = gpio_to_irq(button->gpio);
+		int irq;
 		unsigned int type = button->type ?: EV_KEY;
 
+		error = gpio_request(button->gpio, button->desc ?: "gpio_keys");
+		if (error < 0) {
+			pr_err("gpio-keys: failed to request GPIO %d,"
+				" error %d\n", button->gpio, error);
+			goto fail;
+		}
+
+		error = gpio_direction_input(button->gpio);
+		if (error < 0) {
+			pr_err("gpio-keys: failed to configure input"
+				" direction for GPIO %d, error %d\n",
+				button->gpio, error);
+			gpio_free(button->gpio);
+			goto fail;
+		}
+
+		irq = gpio_to_irq(button->gpio);
 		if (irq < 0) {
 			error = irq;
 			printk(KERN_ERR
@@ -85,6 +102,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 				"Unable to get irq number for GPIO %d,"
 				"error %d\n",
 				button->gpio, error);
+			gpio_free(button->gpio);
 			goto fail;
 		}
 
@@ -97,6 +115,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 			printk(KERN_ERR
 				"gpio-keys: Unable to claim irq %d; error %d\n",
 				irq, error);
+			gpio_free(button->gpio);
 			goto fail;
 		}
 
@@ -119,8 +138,10 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	return 0;
 
  fail:
-	while (--i >= 0)
+	while (--i >= 0) {
 		free_irq(gpio_to_irq(pdata->buttons[i].gpio), pdev);
+		gpio_free(pdata->buttons[i].gpio);
+	}
 
 	platform_set_drvdata(pdev, NULL);
 	input_free_device(input);
@@ -139,6 +160,7 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 	for (i = 0; i < pdata->nbuttons; i++) {
 		int irq = gpio_to_irq(pdata->buttons[i].gpio);
 		free_irq(irq, pdev);
+		gpio_free(pdata->buttons[i].gpio);
 	}
 
 	input_unregister_device(input);
-- 
1.5.3.4

