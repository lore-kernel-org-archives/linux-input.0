From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 2/3] input: rotary-encoder: use gpio_request_one()
Date: Wed, 25 Jul 2012 20:25:13 +0200
Message-ID: <1343240714-11399-2-git-send-email-zonque@gmail.com>
References: <1343240714-11399-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:37299 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab2GYSZV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 14:25:21 -0400
In-Reply-To: <1343240714-11399-1-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jhovold@gmail.com, hartleys@visionengravers.com, Daniel Mack <zonque@gmail.com>

Use gpio_request_one() instead of separate calls to gpio_request() and
gpio_direction_input() to simplify the code.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/input/misc/rotary_encoder.c |   33 ++++++++-------------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 00a7bda..e261ad4 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -145,6 +145,7 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
 	struct rotary_encoder *encoder;
 	struct input_dev *input;
+	struct device *dev = &pdev->dev;
 	irq_handler_t handler;
 	int err;
 
@@ -180,36 +181,20 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 
 	err = input_register_device(input);
 	if (err) {
-		dev_err(&pdev->dev, "failed to register input device\n");
+		dev_err(dev, "failed to register input device\n");
 		goto exit_free_mem;
 	}
 
 	/* request the GPIOs */
-	err = gpio_request(pdata->gpio_a, DRV_NAME);
+	err = gpio_request_one(pdata->gpio_a, GPIOF_IN, dev_name(dev));
 	if (err) {
-		dev_err(&pdev->dev, "unable to request GPIO %d\n",
-			pdata->gpio_a);
+		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_a);
 		goto exit_unregister_input;
 	}
 
-	err = gpio_direction_input(pdata->gpio_a);
+	err = gpio_request_one(pdata->gpio_b, GPIOF_IN, dev_name(dev));
 	if (err) {
-		dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
-			pdata->gpio_a);
-		goto exit_unregister_input;
-	}
-
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
+		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_b);
 		goto exit_free_gpio_a;
 	}
 
@@ -228,8 +213,7 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			  DRV_NAME, encoder);
 	if (err) {
-		dev_err(&pdev->dev, "unable to request IRQ %d\n",
-			encoder->irq_a);
+		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_a);
 		goto exit_free_gpio_b;
 	}
 
@@ -237,8 +221,7 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			  DRV_NAME, encoder);
 	if (err) {
-		dev_err(&pdev->dev, "unable to request IRQ %d\n",
-			encoder->irq_b);
+		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_b);
 		goto exit_free_irq_a;
 	}
 
-- 
1.7.10.4

