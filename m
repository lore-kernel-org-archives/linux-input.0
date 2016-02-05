From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 2/3] fixup! Input: rotary_encoder - use threaded irqs
Date: Fri,  5 Feb 2016 13:08:20 +0100
Message-ID: <1454674101-1194-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:50403 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752116AbcBEMI4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 5 Feb 2016 07:08:56 -0500
In-Reply-To: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: devicetree@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

request_threaed_irq fails if handler == NULL and ONESHOT not in flags.
---
 drivers/input/misc/rotary_encoder.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 309612a6d9f5..5a4e1d69c4af 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -296,7 +296,8 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	}
 
 	err = devm_request_threaded_irq(dev, encoder->irq_a, NULL, handler,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+				IRQF_ONESHOT,
 				DRV_NAME, encoder);
 	if (err) {
 		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_a);
@@ -304,7 +305,8 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	}
 
 	err = devm_request_threaded_irq(dev, encoder->irq_b, NULL, handler,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+				IRQF_ONESHOT,
 				DRV_NAME, encoder);
 	if (err) {
 		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_b);
-- 
2.7.0

