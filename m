From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] Input: rotary_encoder cleanup
Date: Sat, 20 Jun 2009 18:15:51 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909019683A5@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from exprod6og106.obsmtp.com ([64.18.1.191]:51754 "HELO
	exprod6og106.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754408AbZFTWW7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Jun 2009 18:22:59 -0400
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Mack <daniel@caiaq.de>

There is no need to carry the two irq numbers in the allocated memory.
They are only needed for the free_irq() calls during the remove.  Since
the driver is already carrying the platform_data we can just call
gpio_to_irq() to get the irq number.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Daniel Mack <daniel@caiaq.de>

---

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index c806fbf..910d2db 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -32,9 +32,6 @@ struct rotary_encoder {
 	unsigned int axis;
 	unsigned int pos;
 
-	unsigned int irq_a;
-	unsigned int irq_b;
-
 	bool armed;
 	unsigned char dir;	/* 0 - clockwise, 1 - CCW */
 };
@@ -121,8 +118,6 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 
 	encoder->input = input;
 	encoder->pdata = pdata;
-	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
-	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
 
 	/* create and register the input driver */
 	input->name = pdev->name;
@@ -160,21 +155,21 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 	}
 
 	/* request the IRQs */
-	err = request_irq(encoder->irq_a, &rotary_encoder_irq,
+	err = request_irq(gpio_to_irq(pdata->gpio_a), &rotary_encoder_irq,
 			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
 			  DRV_NAME, encoder);
 	if (err) {
 		dev_err(&pdev->dev, "unable to request IRQ %d\n",
-			encoder->irq_a);
+			gpio_to_irq(pdata->gpio_a));
 		goto exit_free_gpio_b;
 	}
 
-	err = request_irq(encoder->irq_b, &rotary_encoder_irq,
+	err = request_irq(gpio_to_irq(pdata->gpio_b), &rotary_encoder_irq,
 			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
 			  DRV_NAME, encoder);
 	if (err) {
 		dev_err(&pdev->dev, "unable to request IRQ %d\n",
-			encoder->irq_b);
+			gpio_to_irq(pdata->gpio_b));
 		goto exit_free_irq_a;
 	}
 
@@ -183,7 +178,7 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 	return 0;
 
 exit_free_irq_a:
-	free_irq(encoder->irq_a, encoder);
+	free_irq(gpio_to_irq(pdata->gpio_a), encoder);
 exit_free_gpio_b:
 	gpio_free(pdata->gpio_b);
 exit_free_gpio_a:
@@ -202,8 +197,8 @@ static int __devexit rotary_encoder_remove(struct platform_device *pdev)
 	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
 	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
 
-	free_irq(encoder->irq_a, encoder);
-	free_irq(encoder->irq_b, encoder);
+	free_irq(gpio_to_irq(pdata->gpio_a), encoder);
+	free_irq(gpio_to_irq(pdata->gpio_b), encoder);
 	gpio_free(pdata->gpio_a);
 	gpio_free(pdata->gpio_b);
 	input_unregister_device(encoder->input); 
