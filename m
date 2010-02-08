From: Andrew Clayton <andrew@digital-domain.net>
Subject: [PATCH] input/misc: rotary-encoder: Set gpio direction
Date: Mon, 8 Feb 2010 21:03:50 +0000
Message-ID: <20100208210350.36f51cbf@digital-domain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from b.painless.aaisp.net.uk ([81.187.30.52]:47566 "EHLO
	b.painless.aaisp.net.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab0BHVb6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2010 16:31:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Mack <daniel@caiaq.de>, Mark Somerville <mark@scottishclimbs.com>

While trying to get a rotary encoder working under a beagle board using 
the drivers/input/misc/rotary-encoder.c driver, we found that even with 
the right pin mux settings configured through /sys/kernel/debug/omap_mux/*, 
i.e INPUT_PULLUP and MODE4, the gpio_get_value() functions only ever 
returned 1.

By explicitly calling gpio_direction_input() after each requested gpio, 
the driver started working and started returning correct input events.
 
The following is the patch that works for us. What do you think?

Cheers,
Andrew


Set the gpio direction to input for each requested gpio.

Even with the correct pin mux settings, you still need to explicitly 
set the gpio direction. Call gpio_direction_input() after each 
requested gpio.

Signed-off-by: Andrew Clayton <andrew@digital-domain.net>
---
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 3b9f588..4ae0793 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -152,6 +152,13 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 		goto exit_unregister_input;
 	}
 
+	err = gpio_direction_input(pdata->gpio_a);
+	if (err) {
+		dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
+			pdata->gpio_a);
+		goto exit_unregister_input;
+	}
+
 	err = gpio_request(pdata->gpio_b, DRV_NAME);
 	if (err) {
 		dev_err(&pdev->dev, "unable to request GPIO %d\n",
@@ -159,6 +166,13 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 		goto exit_free_gpio_a;
 	}
 
+	err = gpio_direction_input(pdata->gpio_b);
+	if (err) {
+		dev_err(&pdev->dev, "unable to set GPIO %d for input\n",
+			pdata->gpio_b);
+		goto exit_free_gpio_a;
+	}
+
 	/* request the IRQs */
 	err = request_irq(encoder->irq_a, &rotary_encoder_irq,
 			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
