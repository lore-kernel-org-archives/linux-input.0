From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 1/3] input: rotary-encoder: defer calls gpio_to_irq()
Date: Wed, 25 Jul 2012 20:25:12 +0200
Message-ID: <1343240714-11399-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:37296 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803Ab2GYSZV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 14:25:21 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jhovold@gmail.com, hartleys@visionengravers.com, Daniel Mack <zonque@gmail.com>

Don't call gpio_to_irq() on GPIOs before gpio_request() succeeded on
them. This avoids Ooopses with incorrect DT bindings.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 drivers/input/misc/rotary_encoder.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index f07f784..00a7bda 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -163,8 +163,6 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 
 	encoder->input = input;
 	encoder->pdata = pdata;
-	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
-	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
 
 	/* create and register the input driver */
 	input->name = pdev->name;
@@ -215,6 +213,9 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 		goto exit_free_gpio_a;
 	}
 
+	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
+	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
+
 	/* request the IRQs */
 	if (pdata->half_period) {
 		handler = &rotary_encoder_half_period_irq;
-- 
1.7.10.4

