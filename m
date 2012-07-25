From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2 1/2] input: rotary-encoder: switch to devm_* allocation of GPIOs and IRQs
Date: Wed, 25 Jul 2012 09:43:47 +0200
Message-ID: <1343202228-1507-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:41903 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304Ab2GYHo7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 03:44:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jhovold@gmail.com, hartleys@visionengravers.com, Daniel Mack <zonque@gmail.com>

This simplifies the error unwind pathes.

Also, don't call gpio_to_irq() on GPIOs before dev_gpio_request_one()
succeeded on them. This avoids Ooopses with incorrect DT bindings.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/input/misc/rotary_encoder.c |   67 +++++++++++------------------------
 1 file changed, 21 insertions(+), 46 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index f07f784..d4e0abb 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -145,6 +145,7 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
 	struct rotary_encoder *encoder;
 	struct input_dev *input;
+	struct device *dev = &pdev->dev;
 	irq_handler_t handler;
 	int err;
 
@@ -163,13 +164,11 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 
 	encoder->input = input;
 	encoder->pdata = pdata;
-	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
-	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
 
 	/* create and register the input driver */
 	input->name = pdev->name;
 	input->id.bustype = BUS_HOST;
-	input->dev.parent = &pdev->dev;
+	input->dev.parent = dev;
 
 	if (pdata->relative_axis) {
 		input->evbit[0] = BIT_MASK(EV_REL);
@@ -182,38 +181,27 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 
 	err = input_register_device(input);
 	if (err) {
-		dev_err(&pdev->dev, "failed to register input device\n");
+		dev_err(dev, "failed to register input device\n");
 		goto exit_free_mem;
 	}
 
 	/* request the GPIOs */
-	err = gpio_request(pdata->gpio_a, DRV_NAME);
+	err = devm_gpio_request_one(dev, pdata->gpio_a,
+				    GPIOF_IN, dev_name(dev));
 	if (err) {
-		dev_err(&pdev->dev, "unable to request GPIO %d\n",
-			pdata->gpio_a);
+		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_a);
 		goto exit_unregister_input;
 	}
 
-	err = gpio_direction_input(pdata->gpio_a);
+	err = devm_gpio_request_one(dev, pdata->gpio_b,
+				    GPIOF_IN, dev_name(dev));
 	if (err) {
-		dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
-			pdata->gpio_a);
+		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_b);
 		goto exit_unregister_input;
 	}
 
-	err = gpio_request(pdata->gpio_b, DRV_NAME);
-	if (err) {
-		dev_err(&pdev->dev, "unable to request GPIO %d\n",
-			pdata->gpio_b);
-		goto exit_free_gpio_a;
-	}
-
-	err = gpio_direction_input(pdata->gpio_b);
-	if (err) {
-		dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
-			pdata->gpio_b);
-		goto exit_free_gpio_a;
-	}
+	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
+	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
 
 	/* request the IRQs */
 	if (pdata->half_period) {
@@ -223,34 +211,26 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 		handler = &rotary_encoder_irq;
 	}
 
-	err = request_irq(encoder->irq_a, handler,
-			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			  DRV_NAME, encoder);
+	err = devm_request_irq(dev, encoder->irq_a, handler,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			       dev_name(dev), encoder);
 	if (err) {
-		dev_err(&pdev->dev, "unable to request IRQ %d\n",
-			encoder->irq_a);
-		goto exit_free_gpio_b;
+		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_a);
+		goto exit_unregister_input;
 	}
 
-	err = request_irq(encoder->irq_b, handler,
-			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			  DRV_NAME, encoder);
+	err = devm_request_irq(dev, encoder->irq_b, handler,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			       dev_name(dev), encoder);
 	if (err) {
-		dev_err(&pdev->dev, "unable to request IRQ %d\n",
-			encoder->irq_b);
-		goto exit_free_irq_a;
+		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_b);
+		goto exit_unregister_input;
 	}
 
 	platform_set_drvdata(pdev, encoder);
 
 	return 0;
 
-exit_free_irq_a:
-	free_irq(encoder->irq_a, encoder);
-exit_free_gpio_b:
-	gpio_free(pdata->gpio_b);
-exit_free_gpio_a:
-	gpio_free(pdata->gpio_a);
 exit_unregister_input:
 	input_unregister_device(input);
 	input = NULL; /* so we don't try to free it */
@@ -263,12 +243,7 @@ exit_free_mem:
 static int __devexit rotary_encoder_remove(struct platform_device *pdev)
 {
 	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
-	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
 
-	free_irq(encoder->irq_a, encoder);
-	free_irq(encoder->irq_b, encoder);
-	gpio_free(pdata->gpio_a);
-	gpio_free(pdata->gpio_b);
 	input_unregister_device(encoder->input);
 	platform_set_drvdata(pdev, NULL);
 	kfree(encoder);
-- 
1.7.10.4

