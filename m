From: =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>
Subject: [PATCH 1/3] Input: rotary_encoder - convert to devm-* api
Date: Fri, 15 Jan 2016 22:33:48 +0200
Message-ID: <1452890030-23316-1-git-send-email-timo.teras@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:33782 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918AbcAOUd5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 15:33:57 -0500
Received: by mail-lb0-f194.google.com with SMTP id bc4so21890300lbc.0
        for <linux-input@vger.kernel.org>; Fri, 15 Jan 2016 12:33:56 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>

Use managed resource API for simplifying error paths.

Signed-off-by: Timo Ter=C3=A4s <timo.teras@iki.fi>
---
 drivers/input/misc/rotary_encoder.c | 73 ++++++++++-------------------=
--------
 1 file changed, 20 insertions(+), 53 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/r=
otary_encoder.c
index 8aee719..0f23d32 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -211,8 +211,8 @@ static struct rotary_encoder_platform_data *rotary_=
encoder_parse_dt(struct devic
 	if (!of_id || !np)
 		return NULL;
=20
-	pdata =3D kzalloc(sizeof(struct rotary_encoder_platform_data),
-			GFP_KERNEL);
+	pdata =3D devm_kzalloc(dev, sizeof(struct rotary_encoder_platform_dat=
a),
+			     GFP_KERNEL);
 	if (!pdata)
 		return ERR_PTR(-ENOMEM);
=20
@@ -277,12 +277,10 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 		}
 	}
=20
-	encoder =3D kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
-	input =3D input_allocate_device();
-	if (!encoder || !input) {
-		err =3D -ENOMEM;
-		goto exit_free_mem;
-	}
+	encoder =3D devm_kzalloc(dev, sizeof(struct rotary_encoder), GFP_KERN=
EL);
+	input =3D devm_input_allocate_device(dev);
+	if (!encoder || !input)
+		return -ENOMEM;
=20
 	encoder->input =3D input;
 	encoder->pdata =3D pdata;
@@ -301,16 +299,16 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 	}
=20
 	/* request the GPIOs */
-	err =3D gpio_request_one(pdata->gpio_a, GPIOF_IN, dev_name(dev));
+	err =3D devm_gpio_request_one(dev, pdata->gpio_a, GPIOF_IN, dev_name(=
dev));
 	if (err) {
 		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_a);
-		goto exit_free_mem;
+		return err;
 	}
=20
-	err =3D gpio_request_one(pdata->gpio_b, GPIOF_IN, dev_name(dev));
+	err =3D devm_gpio_request_one(dev, pdata->gpio_b, GPIOF_IN, dev_name(=
dev));
 	if (err) {
 		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_b);
-		goto exit_free_gpio_a;
+		return err;
 	}
=20
 	encoder->irq_a =3D gpio_to_irq(pdata->gpio_a);
@@ -331,30 +329,29 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 	default:
 		dev_err(dev, "'%d' is not a valid steps-per-period value\n",
 			pdata->steps_per_period);
-		err =3D -EINVAL;
-		goto exit_free_gpio_b;
+		return-EINVAL;
 	}
=20
-	err =3D request_irq(encoder->irq_a, handler,
-			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			  DRV_NAME, encoder);
+	err =3D devm_request_irq(dev, encoder->irq_a, handler,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			       DRV_NAME, encoder);
 	if (err) {
 		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_a);
-		goto exit_free_gpio_b;
+		return err;
 	}
=20
-	err =3D request_irq(encoder->irq_b, handler,
-			  IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			  DRV_NAME, encoder);
+	err =3D devm_request_irq(dev, encoder->irq_b, handler,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			       DRV_NAME, encoder);
 	if (err) {
 		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_b);
-		goto exit_free_irq_a;
+		return err;
 	}
=20
 	err =3D input_register_device(input);
 	if (err) {
 		dev_err(dev, "failed to register input device\n");
-		goto exit_free_irq_b;
+		return err;
 	}
=20
 	device_init_wakeup(&pdev->dev, pdata->wakeup_source);
@@ -362,42 +359,12 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 	platform_set_drvdata(pdev, encoder);
=20
 	return 0;
-
-exit_free_irq_b:
-	free_irq(encoder->irq_b, encoder);
-exit_free_irq_a:
-	free_irq(encoder->irq_a, encoder);
-exit_free_gpio_b:
-	gpio_free(pdata->gpio_b);
-exit_free_gpio_a:
-	gpio_free(pdata->gpio_a);
-exit_free_mem:
-	input_free_device(input);
-	kfree(encoder);
-	if (!dev_get_platdata(&pdev->dev))
-		kfree(pdata);
-
-	return err;
 }
=20
 static int rotary_encoder_remove(struct platform_device *pdev)
 {
-	struct rotary_encoder *encoder =3D platform_get_drvdata(pdev);
-	const struct rotary_encoder_platform_data *pdata =3D encoder->pdata;
-
 	device_init_wakeup(&pdev->dev, false);
=20
-	free_irq(encoder->irq_a, encoder);
-	free_irq(encoder->irq_b, encoder);
-	gpio_free(pdata->gpio_a);
-	gpio_free(pdata->gpio_b);
-
-	input_unregister_device(encoder->input);
-	kfree(encoder);
-
-	if (!dev_get_platdata(&pdev->dev))
-		kfree(pdata);
-
 	return 0;
 }
=20
--=20
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
