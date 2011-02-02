From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: [PATCH] rotary_encoder: Use proper irqflags
Date: Wed,  2 Feb 2011 22:29:29 +0100
Message-ID: <1296682169-12653-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jack.hrz.tu-chemnitz.de ([134.109.132.46]:47185 "EHLO
	jack.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494Ab1BBVyd (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Feb 2011 16:54:33 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>

IORESOURCE_IRQ_* is wrong for irq_request, use the correct IRQF_* instead.

Signed-off-by: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
---
 drivers/input/misc/rotary_encoder.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 1f8e010..7e64d01 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -176,7 +176,7 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 
 	/* request the IRQs */
 	err = request_irq(encoder->irq_a, &rotary_encoder_irq,
-			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
+			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			  DRV_NAME, encoder);
 	if (err) {
 		dev_err(&pdev->dev, "unable to request IRQ %d\n",
@@ -185,7 +185,7 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 	}
 
 	err = request_irq(encoder->irq_b, &rotary_encoder_irq,
-			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
+			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			  DRV_NAME, encoder);
 	if (err) {
 		dev_err(&pdev->dev, "unable to request IRQ %d\n",
-- 
1.7.4.rc3

