From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v3 3/3] Input: rotary-encoder - support more than 2 gpios as input
Date: Fri,  5 Feb 2016 13:08:21 +0100
Message-ID: <1454674101-1194-4-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1454674101-1194-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1454674101-1194-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sylvain Rochet <sylvain.rochet-ETtyaVkrhkNWk0Htik3J/w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This changes how the used gpios are stored (i.e. a struct gpio_descs
instead of two struct gpio_desc) and as with >2 gpios the states are
numbered differently the function rotary_encoder_get_state returns
unencoded numbers instead of grey encoded numbers before. The latter ha=
s
some implications on how the returned value is used and so the change i=
s
bigger than one might expect at first.

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 .../devicetree/bindings/input/rotary-encoder.txt   |   2 +-
 drivers/input/misc/rotary_encoder.c                | 156 +++++++++----=
--------
 2 files changed, 65 insertions(+), 93 deletions(-)

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
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/r=
otary_encoder.c
index 5a4e1d69c4af..09f6de77d1af 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -40,35 +40,42 @@ struct rotary_encoder {
=20
 	unsigned int pos;
=20
-	struct gpio_desc *gpio_a;
-	struct gpio_desc *gpio_b;
+	struct gpio_descs *gpios;
=20
-	unsigned int irq_a;
-	unsigned int irq_b;
+	unsigned int *irq;
=20
 	bool armed;
-	unsigned char dir;	/* 0 - clockwise, 1 - CCW */
+	signed char dir;	/* 1 - clockwise, -1 - CCW */
=20
-	char last_stable;
+	unsigned last_stable;
 };
=20
-static int rotary_encoder_get_state(struct rotary_encoder *encoder)
+static unsigned rotary_encoder_get_state(struct rotary_encoder *encode=
r)
 {
-	int a =3D !!gpiod_get_value_cansleep(encoder->gpio_a);
-	int b =3D !!gpiod_get_value_cansleep(encoder->gpio_b);
+	int i;
+	unsigned ret =3D 0;
=20
-	return ((a << 1) | b);
+	for (i =3D 0; i < encoder->gpios->ndescs; ++i) {
+		int val =3D gpiod_get_value(encoder->gpios->desc[i]);
+		/* convert from gray encoding to normal */
+		if (ret & 1)
+			val =3D !val;
+
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
@@ -93,7 +100,7 @@ static void rotary_encoder_report_event(struct rotar=
y_encoder *encoder)
 static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 {
 	struct rotary_encoder *encoder =3D dev_id;
-	int state;
+	unsigned state;
=20
 	mutex_lock(&encoder->access_mutex);
=20
@@ -108,12 +115,12 @@ static irqreturn_t rotary_encoder_irq(int irq, vo=
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
@@ -126,25 +133,19 @@ static irqreturn_t rotary_encoder_irq(int irq, vo=
id *dev_id)
 static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_i=
d)
 {
 	struct rotary_encoder *encoder =3D dev_id;
-	int state;
+	unsigned int state;
=20
 	mutex_lock(&encoder->access_mutex);
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
 	mutex_unlock(&encoder->access_mutex);
@@ -155,46 +156,18 @@ static irqreturn_t rotary_encoder_half_period_irq=
(int irq, void *dev_id)
 static irqreturn_t rotary_encoder_quarter_period_irq(int irq, void *de=
v_id)
 {
 	struct rotary_encoder *encoder =3D dev_id;
-	unsigned char sum;
-	int state;
+	unsigned int state;
=20
 	mutex_lock(&encoder->access_mutex);
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
@@ -213,6 +186,7 @@ static int rotary_encoder_probe(struct platform_dev=
ice *pdev)
 	irq_handler_t handler;
 	u32 steps_per_period;
 	int err;
+	unsigned i;
=20
 	encoder =3D devm_kzalloc(dev, sizeof(struct rotary_encoder), GFP_KERN=
EL);
 	if (!encoder)
@@ -243,24 +217,16 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 	encoder->relative_axis =3D
 		device_property_read_bool(dev, "rotary-encoder,relative-axis");
=20
-	encoder->gpio_a =3D devm_gpiod_get_index(dev, NULL, 0, GPIOD_IN);
-	if (IS_ERR(encoder->gpio_a)) {
-		err =3D PTR_ERR(encoder->gpio_a);
-		dev_err(dev, "unable to get GPIO at index 0: %d\n", err);
-		return err;
+	encoder->gpios =3D devm_gpiod_get_array(dev, NULL, GPIOD_IN);
+	if (IS_ERR(encoder->gpios)) {
+		dev_err(dev, "unable to get gpios\n");
+		return PTR_ERR(encoder->gpios);
 	}
-
-	encoder->irq_a =3D gpiod_to_irq(encoder->gpio_a);
-
-	encoder->gpio_b =3D devm_gpiod_get_index(dev, NULL, 1, GPIOD_IN);
-	if (IS_ERR(encoder->gpio_b)) {
-		err =3D PTR_ERR(encoder->gpio_b);
-		dev_err(dev, "unable to get GPIO at index 1: %d\n", err);
-		return err;
+	if (encoder->gpios->ndescs < 2) {
+		dev_err(dev, "not enough gpios found\n");
+		return -EINVAL;
 	}
=20
-	encoder->irq_b =3D gpiod_to_irq(encoder->gpio_b);
-
 	input =3D devm_input_allocate_device(dev);
 	if (!input)
 		return -ENOMEM;
@@ -277,7 +243,7 @@ static int rotary_encoder_probe(struct platform_dev=
ice *pdev)
 		input_set_abs_params(input,
 				     encoder->axis, 0, encoder->steps, 0, 1);
=20
-	switch (steps_per_period) {
+	switch (steps_per_period >> (encoder->gpios->ndescs - 2)) {
 	case 4:
 		handler =3D &rotary_encoder_quarter_period_irq;
 		encoder->last_stable =3D rotary_encoder_get_state(encoder);
@@ -295,22 +261,26 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 		return -EINVAL;
 	}
=20
-	err =3D devm_request_threaded_irq(dev, encoder->irq_a, NULL, handler,
-				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
-				IRQF_ONESHOT,
-				DRV_NAME, encoder);
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
-	err =3D devm_request_threaded_irq(dev, encoder->irq_b, NULL, handler,
+	for (i =3D 0; i < encoder->gpios->ndescs; ++i) {
+		encoder->irq[i] =3D gpiod_to_irq(encoder->gpios->desc[i]);
+
+		err =3D devm_request_threaded_irq(dev, encoder->irq[i],
+				NULL, handler,
 				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
 				IRQF_ONESHOT,
 				DRV_NAME, encoder);
-	if (err) {
-		dev_err(dev, "unable to request IRQ %d\n", encoder->irq_b);
-		return err;
+		if (err) {
+			dev_err(dev, "unable to request IRQ %d (gpio#%d)\n",
+				encoder->irq[i], i);
+			return err;
+		}
 	}
=20
 	err =3D input_register_device(input);
@@ -332,8 +302,9 @@ static int __maybe_unused rotary_encoder_suspend(st=
ruct device *dev)
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
@@ -344,8 +315,9 @@ static int __maybe_unused rotary_encoder_resume(str=
uct device *dev)
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
--=20
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
