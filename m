From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH RFC 1/3] input: rotary_encoder: make use of devm_* to simplify .probe and .remove
Date: Wed,  2 Dec 2015 11:07:12 +0100
Message-ID: <1449050834-31779-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38215 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932489AbbLBKH3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Dec 2015 05:07:29 -0500
In-Reply-To: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Rob Herring <robh@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, devicetree@vger.kernel.org, linux-input@vger.kernel.org

=46or all operations called in .probe there are devm_* variants.
(input_register_device is clever enough to be devm aware on its own.)
This allows to get rid of the error unwind code paths in .probe and the
complete .remove function.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/input/misc/rotary_encoder.c | 74 +++++++++++------------------=
--------
 1 file changed, 22 insertions(+), 52 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/r=
otary_encoder.c
index 8aee71986430..386bdb5314e6 100644
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
@@ -277,11 +277,11 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 		}
 	}
=20
-	encoder =3D kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
-	input =3D input_allocate_device();
+	encoder =3D devm_kzalloc(dev, sizeof(struct rotary_encoder), GFP_KERN=
EL);
+	input =3D devm_input_allocate_device(&pdev->dev);
 	if (!encoder || !input) {
-		err =3D -ENOMEM;
-		goto exit_free_mem;
+		dev_err(dev, "unable to allocate memory\n");
+		return -ENOMEM;
 	}
=20
 	encoder->input =3D input;
@@ -301,16 +301,18 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 	}
=20
 	/* request the GPIOs */
-	err =3D gpio_request_one(pdata->gpio_a, GPIOF_IN, dev_name(dev));
+	err =3D devm_gpio_request_one(dev, pdata->gpio_a,
+				    GPIOF_IN, dev_name(dev));
 	if (err) {
 		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_a);
-		goto exit_free_mem;
+		return err;
 	}
=20
-	err =3D gpio_request_one(pdata->gpio_b, GPIOF_IN, dev_name(dev));
+	err =3D devm_gpio_request_one(dev, pdata->gpio_b,
+				    GPIOF_IN, dev_name(dev));
 	if (err) {
 		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_b);
-		goto exit_free_gpio_a;
+		return err;
 	}
=20
 	encoder->irq_a =3D gpio_to_irq(pdata->gpio_a);
@@ -331,30 +333,29 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 	default:
 		dev_err(dev, "'%d' is not a valid steps-per-period value\n",
 			pdata->steps_per_period);
-		err =3D -EINVAL;
-		goto exit_free_gpio_b;
+		return -EINVAL;
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
@@ -362,42 +363,11 @@ static int rotary_encoder_probe(struct platform_d=
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
-
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
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
