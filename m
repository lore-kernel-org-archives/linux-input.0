From: =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>
Subject: [PATCH] Input: rotary-encoder: use request_any_context_irq and gpio_get_value_cansleep
Date: Wed, 23 Dec 2015 20:41:55 +0200
Message-ID: <1450896115-12422-1-git-send-email-timo.teras@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:36114 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933393AbbLWSmD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Dec 2015 13:42:03 -0500
Received: by mail-lf0-f46.google.com with SMTP id z124so146937322lfa.3
        for <linux-input@vger.kernel.org>; Wed, 23 Dec 2015 10:42:01 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>

This allows to use GPIO expanders behind I2C or SPI bus.

Signed-off-by: Timo Ter=C3=A4s <timo.teras@iki.fi>
---
 drivers/input/misc/rotary_encoder.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/r=
otary_encoder.c
index 8aee719..8bedd7b 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -48,8 +48,8 @@ struct rotary_encoder {
=20
 static int rotary_encoder_get_state(const struct rotary_encoder_platfo=
rm_data *pdata)
 {
-	int a =3D !!gpio_get_value(pdata->gpio_a);
-	int b =3D !!gpio_get_value(pdata->gpio_b);
+	int a =3D !!gpio_get_value_cansleep(pdata->gpio_a);
+	int b =3D !!gpio_get_value_cansleep(pdata->gpio_b);
=20
 	a ^=3D pdata->inverted_a;
 	b ^=3D pdata->inverted_b;
@@ -335,18 +335,18 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 		goto exit_free_gpio_b;
 	}
=20
-	err =3D request_irq(encoder->irq_a, handler,
-			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			  DRV_NAME, encoder);
-	if (err) {
+	err =3D request_any_context_irq(encoder->irq_a, handler,
+				      IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				      DRV_NAME, encoder);
+	if (err < 0) {
 		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_a);
 		goto exit_free_gpio_b;
 	}
=20
-	err =3D request_irq(encoder->irq_b, handler,
-			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			  DRV_NAME, encoder);
-	if (err) {
+	err =3D request_any_context_irq(encoder->irq_b, handler,
+				      IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				      DRV_NAME, encoder);
+	if (err < 0) {
 		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_b);
 		goto exit_free_irq_a;
 	}
--=20
2.6.4


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
