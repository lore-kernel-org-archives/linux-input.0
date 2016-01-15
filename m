From: =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>
Subject: [PATCH 3/3] Input: rotary_encoder - use threaded irqs
Date: Fri, 15 Jan 2016 22:33:50 +0200
Message-ID: <1452890030-23316-3-git-send-email-timo.teras@iki.fi>
References: <1452890030-23316-1-git-send-email-timo.teras@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f193.google.com ([209.85.217.193]:36150 "EHLO
	mail-lb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbcAOUd6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Jan 2016 15:33:58 -0500
Received: by mail-lb0-f193.google.com with SMTP id ti8so29831536lbb.3
        for <linux-input@vger.kernel.org>; Fri, 15 Jan 2016 12:33:57 -0800 (PST)
In-Reply-To: <1452890030-23316-1-git-send-email-timo.teras@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>

Convert to use threaded IRQs to support GPIOs that can sleep.
Protect the irq handler with mutex as it can be triggered from
two different irq lines accessing the same state.

This allows using GPIO expanders behind I2C or SPI bus.

Signed-off-by: Timo Ter=C3=A4s <timo.teras@iki.fi>
---
 drivers/input/misc/rotary_encoder.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/r=
otary_encoder.c
index 156f40f..a2d47ce 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -33,6 +33,7 @@
 struct rotary_encoder {
 	struct input_dev *input;
 	const struct rotary_encoder_platform_data *pdata;
+	struct mutex access_mutex;
=20
 	unsigned int axis;
 	unsigned int pos;
@@ -48,8 +49,8 @@ struct rotary_encoder {
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
@@ -94,6 +95,7 @@ static irqreturn_t rotary_encoder_irq(int irq, void *=
dev_id)
 	struct rotary_encoder *encoder =3D dev_id;
 	int state;
=20
+	mutex_lock(&encoder->access_mutex);
 	state =3D rotary_encoder_get_state(encoder->pdata);
=20
 	switch (state) {
@@ -114,6 +116,7 @@ static irqreturn_t rotary_encoder_irq(int irq, void=
 *dev_id)
 		encoder->armed =3D true;
 		break;
 	}
+	mutex_unlock(&encoder->access_mutex);
=20
 	return IRQ_HANDLED;
 }
@@ -123,6 +126,7 @@ static irqreturn_t rotary_encoder_half_period_irq(i=
nt irq, void *dev_id)
 	struct rotary_encoder *encoder =3D dev_id;
 	int state;
=20
+	mutex_lock(&encoder->access_mutex);
 	state =3D rotary_encoder_get_state(encoder->pdata);
=20
 	switch (state) {
@@ -139,6 +143,7 @@ static irqreturn_t rotary_encoder_half_period_irq(i=
nt irq, void *dev_id)
 		encoder->dir =3D (encoder->last_stable + state) & 0x01;
 		break;
 	}
+	mutex_unlock(&encoder->access_mutex);
=20
 	return IRQ_HANDLED;
 }
@@ -149,6 +154,7 @@ static irqreturn_t rotary_encoder_quarter_period_ir=
q(int irq, void *dev_id)
 	unsigned char sum;
 	int state;
=20
+	mutex_lock(&encoder->access_mutex);
 	state =3D rotary_encoder_get_state(encoder->pdata);
=20
 	/*
@@ -189,6 +195,8 @@ static irqreturn_t rotary_encoder_quarter_period_ir=
q(int irq, void *dev_id)
=20
 out:
 	encoder->last_stable =3D state;
+	mutex_unlock(&encoder->access_mutex);
+
 	return IRQ_HANDLED;
 }
=20
@@ -288,6 +296,8 @@ static int rotary_encoder_probe(struct platform_dev=
ice *pdev)
 	if (!encoder || !input)
 		return -ENOMEM;
=20
+	mutex_init(&encoder->access_mutex);
+
 	encoder->input =3D input;
 	encoder->pdata =3D pdata;
=20
@@ -338,17 +348,17 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 		return-EINVAL;
 	}
=20
-	err =3D devm_request_irq(dev, encoder->irq_a, handler,
-			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			       DRV_NAME, encoder);
+	err =3D devm_request_threaded_irq(dev, encoder->irq_a, NULL, handler,
+					IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+					DRV_NAME, encoder);
 	if (err) {
 		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_a);
 		return err;
 	}
=20
-	err =3D devm_request_irq(dev, encoder->irq_b, handler,
-			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			       DRV_NAME, encoder);
+	err =3D devm_request_threaded_irq(dev, encoder->irq_b, NULL, handler,
+					IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+					DRV_NAME, encoder);
 	if (err) {
 		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_b);
 		return err;
--=20
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
