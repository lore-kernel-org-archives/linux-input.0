From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 3/3] Input: rotary-encoder - support more than 2 gpios as input
Date: Tue,  2 Feb 2016 11:24:38 +0100
Message-ID: <1454408678-6011-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47273 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754487AbcBBKZ1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Feb 2016 05:25:27 -0500
In-Reply-To: <1454408678-6011-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylvain Rochet <sylvain.rochet@finsecur.com>, Johan Hovold <johan@kernel.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: devicetree@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 .../devicetree/bindings/input/rotary-encoder.txt   |   2 +-
 arch/arm/mach-pxa/raumfeld.c                       |  25 ++-
 drivers/input/misc/rotary_encoder.c                | 171 ++++++++-----=
--------
 include/linux/rotary_encoder.h                     |   4 -
 4 files changed, 84 insertions(+), 118 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt=
 b/Documentation/devicetree/bindings/input/rotary-encoder.txt
index de99cbbbf6da..6c9f0c8a846c 100644
--- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -1,7 +1,7 @@
 Rotary encoder DT bindings
=20
 Required properties:
-- gpios: a spec for two GPIOs to be used
+- gpios: a spec for at least two GPIOs to be used, most significant fi=
rst
=20
 Optional properties:
 - linux,axis: the input subsystem axis to map to this rotary encoder.
diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.=
c
index 8347d87a713d..87988d717465 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
+#include <linux/gpio/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/input.h>
 #include <linux/rotary_encoder.h>
@@ -370,10 +371,25 @@ static struct rotary_encoder_platform_data raumfe=
ld_rotary_encoder_info =3D {
 	.steps		=3D 24,
 	.axis		=3D REL_X,
 	.relative_axis	=3D 1,
-	.gpio_a		=3D GPIO_VOLENC_A,
-	.gpio_b		=3D GPIO_VOLENC_B,
-	.inverted_a	=3D 1,
-	.inverted_b	=3D 0,
+};
+
+static struct gpiod_lookup_table raumfeld_rotary_encoder_gpio_lookup =3D=
 {
+	.dev_id =3D "rotary_encoder.0",
+	.table =3D {
+		{
+			.chip_label =3D "gpio-0",
+			.chip_hwnum =3D GPIO_VOLENC_A,
+			.idx =3D 0,
+			.flags =3D GPIO_ACTIVE_LOW,
+		},
+		{
+			.chip_label =3D "gpio-0",
+			.chip_hwnum =3D GPIO_VOLENC_B,
+			.idx =3D 1,
+			.flags =3D GPIO_ACTIVE_HIGH,
+		},
+		{ /* sentinel */ }
+	},
 };
=20
 static struct platform_device rotary_encoder_device =3D {
@@ -1051,6 +1067,7 @@ static void __init __maybe_unused raumfeld_contro=
ller_init(void)
 	int ret;
=20
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_controller_pin_config));
+	gpiod_add_lookup_table(&raumfeld_rotary_encoder_gpio_lookup);
 	platform_device_register(&rotary_encoder_device);
 	spi_register_board_info(ARRAY_AND_SIZE(controller_spi_devices));
 	i2c_register_board_info(0, &raumfeld_controller_i2c_board_info, 1);
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/r=
otary_encoder.c
index 0582e851993f..256fe232a26b 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -25,7 +25,6 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/of_gpio.h>
 #include <linux/pm.h>
=20
 #define DRV_NAME "rotary-encoder"
@@ -36,45 +35,47 @@ struct rotary_encoder {
 	/* configuration */
 	unsigned int steps;
 	unsigned int axis;
-	unsigned int gpio_a;
-	unsigned int gpio_b;
-	unsigned int inverted_a;
-	unsigned int inverted_b;
 	unsigned int steps_per_period;
 	bool relative_axis;
 	bool rollover;
 	bool wakeup_source;
=20
-	unsigned int irq_a;
-	unsigned int irq_b;
+	struct gpio_descs *gpios;
+	unsigned int *irq;
=20
 	/* state */
 	unsigned int pos;
 	bool armed;
-	unsigned char dir;	/* 0 - clockwise, 1 - CCW */
+	signed char dir;	/* 1 - clockwise, -1 - CCW */
 	char last_stable;
 };
=20
-static int rotary_encoder_get_state(const struct rotary_encoder *encod=
er)
+static unsigned rotary_encoder_get_state(const struct rotary_encoder *=
encoder)
 {
-	int a =3D !!gpio_get_value(encoder->gpio_a);
-	int b =3D !!gpio_get_value(encoder->gpio_b);
+	int i;
+	unsigned ret =3D 0;
=20
-	a ^=3D encoder->inverted_a;
-	b ^=3D encoder->inverted_b;
+	for (i =3D 0; i < encoder->gpios->ndescs; ++i) {
+		int val =3D gpiod_get_value(encoder->gpios->desc[i]);
+		/* convert from gray encoding to normal */
+		if (ret & 1)
+			val =3D !val;
=20
-	return ((a << 1) | b);
+		ret =3D ret << 1 | val;
+	}
+
+	return ret & 3;
 }
=20
 static void rotary_encoder_report_event(struct rotary_encoder *encoder=
)
 {
 	if (encoder->relative_axis) {
 		input_report_rel(encoder->input,
-				 encoder->axis, encoder->dir ? -1 : 1);
+				 encoder->axis, encoder->dir);
 	} else {
 		unsigned int pos =3D encoder->pos;
=20
-		if (encoder->dir) {
+		if (encoder->dir < 0) {
 			/* turning counter-clockwise */
 			if (encoder->rollover)
 				pos +=3D encoder->steps;
@@ -112,12 +113,12 @@ static irqreturn_t rotary_encoder_irq(int irq, vo=
id *dev_id)
 		break;
=20
 	case 0x1:
-	case 0x2:
+	case 0x3:
 		if (encoder->armed)
-			encoder->dir =3D state - 1;
+			encoder->dir =3D 2 - state;
 		break;
=20
-	case 0x3:
+	case 0x2:
 		encoder->armed =3D true;
 		break;
 	}
@@ -132,19 +133,13 @@ static irqreturn_t rotary_encoder_half_period_irq=
(int irq, void *dev_id)
=20
 	state =3D rotary_encoder_get_state(encoder);
=20
-	switch (state) {
-	case 0x00:
-	case 0x03:
+	if (state & 1) {
+		encoder->dir =3D ((encoder->last_stable - state + 1) % 4) - 1;
+	} else {
 		if (state !=3D encoder->last_stable) {
 			rotary_encoder_report_event(encoder);
 			encoder->last_stable =3D state;
 		}
-		break;
-
-	case 0x01:
-	case 0x02:
-		encoder->dir =3D (encoder->last_stable + state) & 0x01;
-		break;
 	}
=20
 	return IRQ_HANDLED;
@@ -153,44 +148,16 @@ static irqreturn_t rotary_encoder_half_period_irq=
(int irq, void *dev_id)
 static irqreturn_t rotary_encoder_quarter_period_irq(int irq, void *de=
v_id)
 {
 	struct rotary_encoder *encoder =3D dev_id;
-	unsigned char sum;
 	int state;
=20
 	state =3D rotary_encoder_get_state(encoder);
=20
-	/*
-	 * We encode the previous and the current state using a byte.
-	 * The previous state in the MSB nibble, the current state in the LSB
-	 * nibble. Then use a table to decide the direction of the turn.
-	 */
-	sum =3D (encoder->last_stable << 4) + state;
-	switch (sum) {
-	case 0x31:
-	case 0x10:
-	case 0x02:
-	case 0x23:
-		encoder->dir =3D 0; /* clockwise */
-		break;
-
-	case 0x13:
-	case 0x01:
-	case 0x20:
-	case 0x32:
-		encoder->dir =3D 1; /* counter-clockwise */
-		break;
-
-	default:
-		/*
-		 * Ignore all other values. This covers the case when the
-		 * state didn't change (a spurious interrupt) and the
-		 * cases where the state changed by two steps, making it
-		 * impossible to tell the direction.
-		 *
-		 * In either case, don't report any event and save the
-		 * state for later.
-		 */
+	if ((encoder->last_stable + 1) % 4 =3D=3D state)
+		encoder->dir =3D 1;
+	else if (encoder->last_stable =3D=3D (state + 1) % 4)
+		encoder->dir =3D -1;
+	else
 		goto out;
-	}
=20
 	rotary_encoder_report_event(encoder);
=20
@@ -212,7 +179,6 @@ static int rotary_encoder_parse_dt(struct device *d=
ev,
 	const struct of_device_id *of_id =3D
 				of_match_device(rotary_encoder_of_match, dev);
 	struct device_node *np =3D dev->of_node;
-	enum of_gpio_flags flags;
 	int error;
=20
 	if (!of_id || !np)
@@ -221,12 +187,6 @@ static int rotary_encoder_parse_dt(struct device *=
dev,
 	of_property_read_u32(np, "rotary-encoder,steps", &encoder->steps);
 	of_property_read_u32(np, "linux,axis", &encoder->axis);
=20
-	encoder->gpio_a =3D of_get_gpio_flags(np, 0, &flags);
-	encoder->inverted_a =3D flags & OF_GPIO_ACTIVE_LOW;
-
-	encoder->gpio_b =3D of_get_gpio_flags(np, 1, &flags);
-	encoder->inverted_b =3D flags & OF_GPIO_ACTIVE_LOW;
-
 	encoder->relative_axis =3D
 		of_property_read_bool(np, "rotary-encoder,relative-axis");
 	encoder->rollover =3D
@@ -273,11 +233,6 @@ static int rotary_encoder_parse_pdata(struct devic=
e *dev,
=20
 	encoder->steps =3D pdata->steps;
 	encoder->axis =3D pdata->axis;
-	encoder->gpio_a =3D pdata->gpio_a;
-	encoder->gpio_b =3D pdata->gpio_b;
-	encoder->inverted_a =3D pdata->inverted_a;
-	encoder->inverted_b =3D pdata->inverted_b;
-	encoder->steps_per_period =3D pdata->steps_per_period;
 	encoder->relative_axis =3D pdata->relative_axis;
 	encoder->rollover =3D pdata->rollover;
=20
@@ -291,6 +246,7 @@ static int rotary_encoder_probe(struct platform_dev=
ice *pdev)
 	struct input_dev *input;
 	irq_handler_t handler;
 	int err;
+	unsigned int i;
=20
 	encoder =3D devm_kzalloc(dev, sizeof(struct rotary_encoder), GFP_KERN=
EL);
 	input =3D devm_input_allocate_device(&pdev->dev);
@@ -307,6 +263,16 @@ static int rotary_encoder_probe(struct platform_de=
vice *pdev)
 	if (err < 0)
 		return err;
=20
+	encoder->gpios =3D devm_gpiod_get_array(dev, NULL, GPIOD_IN);
+	if (IS_ERR(encoder->gpios)) {
+		dev_err(dev, "unable to get gpios\n");
+		return PTR_ERR(encoder->gpios);
+	}
+	if (encoder->gpios->ndescs < 2) {
+		dev_err(dev, "not enough gpios found\n");
+		return -EINVAL;
+	}
+
 	encoder->input =3D input;
=20
 	input->name =3D pdev->name;
@@ -322,25 +288,7 @@ static int rotary_encoder_probe(struct platform_de=
vice *pdev)
 				     encoder->axis, 0, encoder->steps, 0, 1);
 	}
=20
-	/* request the GPIOs */
-	err =3D devm_gpio_request_one(dev, encoder->gpio_a,
-				    GPIOF_IN, dev_name(dev));
-	if (err) {
-		dev_err(dev, "unable to request GPIO %d\n", encoder->gpio_a);
-		return err;
-	}
-
-	err =3D devm_gpio_request_one(dev, encoder->gpio_b,
-				    GPIOF_IN, dev_name(dev));
-	if (err) {
-		dev_err(dev, "unable to request GPIO %d\n", encoder->gpio_b);
-		return err;
-	}
-
-	encoder->irq_a =3D gpio_to_irq(encoder->gpio_a);
-	encoder->irq_b =3D gpio_to_irq(encoder->gpio_b);
-
-	switch (encoder->steps_per_period) {
+	switch (encoder->steps_per_period >> (encoder->gpios->ndescs - 2)) {
 	case 4:
 		handler =3D &rotary_encoder_quarter_period_irq;
 		encoder->last_stable =3D rotary_encoder_get_state(encoder);
@@ -358,20 +306,23 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 		return -EINVAL;
 	}
=20
-	err =3D devm_request_irq(dev, encoder->irq_a, handler,
-			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			       DRV_NAME, encoder);
-	if (err) {
-		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_a);
-		return err;
-	}
+	encoder->irq =3D
+		devm_kzalloc(dev,
+			     sizeof(*encoder->irq) * encoder->gpios->ndescs,
+			     GFP_KERNEL);
+	if (!encoder->irq)
+		return -ENOMEM;
=20
-	err =3D devm_request_irq(dev, encoder->irq_b, handler,
-			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			       DRV_NAME, encoder);
-	if (err) {
-		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_b);
-		return err;
+	for (i =3D 0; i < encoder->gpios->ndescs; ++i) {
+		encoder->irq[i] =3D gpiod_to_irq(encoder->gpios->desc[i]);
+		err =3D devm_request_irq(dev, encoder->irq[i], handler,
+				       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+				       DRV_NAME, encoder);
+		if (err) {
+			dev_err(dev, "unable to request IRQ %d (gpio#%d)\n",
+				encoder->irq[i], i);
+			return err;
+		}
 	}
=20
 	err =3D input_register_device(input);
@@ -399,8 +350,9 @@ static int rotary_encoder_suspend(struct device *de=
v)
 	struct rotary_encoder *encoder =3D dev_get_drvdata(dev);
=20
 	if (device_may_wakeup(dev)) {
-		enable_irq_wake(encoder->irq_a);
-		enable_irq_wake(encoder->irq_b);
+		unsigned int i;
+		for (i =3D 0; i < encoder->gpios->ndescs; ++i)
+			enable_irq_wake(encoder->irq[i]);
 	}
=20
 	return 0;
@@ -411,8 +363,9 @@ static int rotary_encoder_resume(struct device *dev=
)
 	struct rotary_encoder *encoder =3D dev_get_drvdata(dev);
=20
 	if (device_may_wakeup(dev)) {
-		disable_irq_wake(encoder->irq_a);
-		disable_irq_wake(encoder->irq_b);
+		unsigned int i;
+		for (i =3D 0; i < encoder->gpios->ndescs; ++i)
+			disable_irq_wake(encoder->irq[i]);
 	}
=20
 	return 0;
diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_enco=
der.h
index fe3dc64e5aeb..4536c813a1e9 100644
--- a/include/linux/rotary_encoder.h
+++ b/include/linux/rotary_encoder.h
@@ -4,10 +4,6 @@
 struct rotary_encoder_platform_data {
 	unsigned int steps;
 	unsigned int axis;
-	unsigned int gpio_a;
-	unsigned int gpio_b;
-	unsigned int inverted_a;
-	unsigned int inverted_b;
 	unsigned int steps_per_period;
 	bool relative_axis;
 	bool rollover;
--=20
2.7.0.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
