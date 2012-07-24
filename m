From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] input: rotary-encoder: defer calls gpio_to_irq()
Date: Tue, 24 Jul 2012 19:38:07 +0200
Message-ID: <1343151487-27841-2-git-send-email-zonque@gmail.com>
References: <1343151487-27841-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:43742 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755596Ab2GXRpF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jul 2012 13:45:05 -0400
In-Reply-To: <1343151487-27841-1-git-send-email-zonque@gmail.com>
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
index 350cbd1..474b04f 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -223,8 +223,6 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 
 	encoder->input = input;
 	encoder->pdata = pdata;
-	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
-	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
 
 	/* create and register the input driver */
 	input->name = pdev->name;
@@ -275,6 +273,9 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
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

