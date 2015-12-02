From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH RFC 2/3] input: rotary_encoder: move configuration data to driver data
Date: Wed,  2 Dec 2015 11:07:13 +0100
Message-ID: <1449050834-31779-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1449050834-31779-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449050834-31779-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, Ezequiel Garcia <ezequiel-30ULvvUtt6G51wMPkGsGjgyUoB5FGQPZ@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sylvain Rochet <sylvain.rochet-ETtyaVkrhkNWk0Htik3J/w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

This is a preparation for the next few patches. There is no change in
behaviour intended.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
---
 drivers/input/misc/rotary_encoder.c | 166 ++++++++++++++++++++--------=
--------
 1 file changed, 94 insertions(+), 72 deletions(-)

diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/r=
otary_encoder.c
index 386bdb5314e6..0582e851993f 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -32,58 +32,65 @@
=20
 struct rotary_encoder {
 	struct input_dev *input;
-	const struct rotary_encoder_platform_data *pdata;
=20
+	/* configuration */
+	unsigned int steps;
 	unsigned int axis;
-	unsigned int pos;
+	unsigned int gpio_a;
+	unsigned int gpio_b;
+	unsigned int inverted_a;
+	unsigned int inverted_b;
+	unsigned int steps_per_period;
+	bool relative_axis;
+	bool rollover;
+	bool wakeup_source;
=20
 	unsigned int irq_a;
 	unsigned int irq_b;
=20
+	/* state */
+	unsigned int pos;
 	bool armed;
 	unsigned char dir;	/* 0 - clockwise, 1 - CCW */
-
 	char last_stable;
 };
=20
-static int rotary_encoder_get_state(const struct rotary_encoder_platfo=
rm_data *pdata)
+static int rotary_encoder_get_state(const struct rotary_encoder *encod=
er)
 {
-	int a =3D !!gpio_get_value(pdata->gpio_a);
-	int b =3D !!gpio_get_value(pdata->gpio_b);
+	int a =3D !!gpio_get_value(encoder->gpio_a);
+	int b =3D !!gpio_get_value(encoder->gpio_b);
=20
-	a ^=3D pdata->inverted_a;
-	b ^=3D pdata->inverted_b;
+	a ^=3D encoder->inverted_a;
+	b ^=3D encoder->inverted_b;
=20
 	return ((a << 1) | b);
 }
=20
 static void rotary_encoder_report_event(struct rotary_encoder *encoder=
)
 {
-	const struct rotary_encoder_platform_data *pdata =3D encoder->pdata;
-
-	if (pdata->relative_axis) {
+	if (encoder->relative_axis) {
 		input_report_rel(encoder->input,
-				 pdata->axis, encoder->dir ? -1 : 1);
+				 encoder->axis, encoder->dir ? -1 : 1);
 	} else {
 		unsigned int pos =3D encoder->pos;
=20
 		if (encoder->dir) {
 			/* turning counter-clockwise */
-			if (pdata->rollover)
-				pos +=3D pdata->steps;
+			if (encoder->rollover)
+				pos +=3D encoder->steps;
 			if (pos)
 				pos--;
 		} else {
 			/* turning clockwise */
-			if (pdata->rollover || pos < pdata->steps)
+			if (encoder->rollover || pos < encoder->steps)
 				pos++;
 		}
=20
-		if (pdata->rollover)
-			pos %=3D pdata->steps;
+		if (encoder->rollover)
+			pos %=3D encoder->steps;
=20
 		encoder->pos =3D pos;
-		input_report_abs(encoder->input, pdata->axis, encoder->pos);
+		input_report_abs(encoder->input, encoder->axis, encoder->pos);
 	}
=20
 	input_sync(encoder->input);
@@ -94,7 +101,7 @@ static irqreturn_t rotary_encoder_irq(int irq, void =
*dev_id)
 	struct rotary_encoder *encoder =3D dev_id;
 	int state;
=20
-	state =3D rotary_encoder_get_state(encoder->pdata);
+	state =3D rotary_encoder_get_state(encoder);
=20
 	switch (state) {
 	case 0x0:
@@ -123,7 +130,7 @@ static irqreturn_t rotary_encoder_half_period_irq(i=
nt irq, void *dev_id)
 	struct rotary_encoder *encoder =3D dev_id;
 	int state;
=20
-	state =3D rotary_encoder_get_state(encoder->pdata);
+	state =3D rotary_encoder_get_state(encoder);
=20
 	switch (state) {
 	case 0x00:
@@ -149,7 +156,7 @@ static irqreturn_t rotary_encoder_quarter_period_ir=
q(int irq, void *dev_id)
 	unsigned char sum;
 	int state;
=20
-	state =3D rotary_encoder_get_state(encoder->pdata);
+	state =3D rotary_encoder_get_state(encoder);
=20
 	/*
 	 * We encode the previous and the current state using a byte.
@@ -199,38 +206,34 @@ static const struct of_device_id rotary_encoder_o=
f_match[] =3D {
 };
 MODULE_DEVICE_TABLE(of, rotary_encoder_of_match);
=20
-static struct rotary_encoder_platform_data *rotary_encoder_parse_dt(st=
ruct device *dev)
+static int rotary_encoder_parse_dt(struct device *dev,
+				   struct rotary_encoder *encoder)
 {
 	const struct of_device_id *of_id =3D
 				of_match_device(rotary_encoder_of_match, dev);
 	struct device_node *np =3D dev->of_node;
-	struct rotary_encoder_platform_data *pdata;
 	enum of_gpio_flags flags;
 	int error;
=20
 	if (!of_id || !np)
-		return NULL;
-
-	pdata =3D devm_kzalloc(dev, sizeof(struct rotary_encoder_platform_dat=
a),
-			     GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
+		return 1;
=20
-	of_property_read_u32(np, "rotary-encoder,steps", &pdata->steps);
-	of_property_read_u32(np, "linux,axis", &pdata->axis);
+	of_property_read_u32(np, "rotary-encoder,steps", &encoder->steps);
+	of_property_read_u32(np, "linux,axis", &encoder->axis);
=20
-	pdata->gpio_a =3D of_get_gpio_flags(np, 0, &flags);
-	pdata->inverted_a =3D flags & OF_GPIO_ACTIVE_LOW;
+	encoder->gpio_a =3D of_get_gpio_flags(np, 0, &flags);
+	encoder->inverted_a =3D flags & OF_GPIO_ACTIVE_LOW;
=20
-	pdata->gpio_b =3D of_get_gpio_flags(np, 1, &flags);
-	pdata->inverted_b =3D flags & OF_GPIO_ACTIVE_LOW;
+	encoder->gpio_b =3D of_get_gpio_flags(np, 1, &flags);
+	encoder->inverted_b =3D flags & OF_GPIO_ACTIVE_LOW;
=20
-	pdata->relative_axis =3D
+	encoder->relative_axis =3D
 		of_property_read_bool(np, "rotary-encoder,relative-axis");
-	pdata->rollover =3D of_property_read_bool(np, "rotary-encoder,rollove=
r");
+	encoder->rollover =3D
+		of_property_read_bool(np, "rotary-encoder,rollover");
=20
 	error =3D of_property_read_u32(np, "rotary-encoder,steps-per-period",
-				     &pdata->steps_per_period);
+				     &encoder->steps_per_period);
 	if (error) {
 		/*
 		 * The 'half-period' property has been deprecated, you must use
@@ -238,45 +241,57 @@ static struct rotary_encoder_platform_data *rotar=
y_encoder_parse_dt(struct devic
 		 * need to parse it to maintain compatibility.
 		 */
 		if (of_property_read_bool(np, "rotary-encoder,half-period")) {
-			pdata->steps_per_period =3D 2;
+			encoder->steps_per_period =3D 2;
 		} else {
 			/* Fallback to one step per period behavior */
-			pdata->steps_per_period =3D 1;
+			encoder->steps_per_period =3D 1;
 		}
 	}
=20
-	pdata->wakeup_source =3D of_property_read_bool(np, "wakeup-source");
+	encoder->wakeup_source =3D of_property_read_bool(np, "wakeup-source")=
;
=20
-	return pdata;
+	return 0;
 }
 #else
-static inline struct rotary_encoder_platform_data *
-rotary_encoder_parse_dt(struct device *dev)
+static inline int rotary_encoder_parse_dt(struct device *dev,
+					  struct rotary_encoder *encoder)
 {
-	return NULL;
+	return 1;
 }
 #endif
=20
+static int rotary_encoder_parse_pdata(struct device *dev,
+				      struct rotary_encoder *encoder)
+{
+	const struct rotary_encoder_platform_data *pdata;
+
+	pdata =3D dev_get_platdata(dev);
+	if (!pdata) {
+		dev_err(dev, "missing platform data\n");
+		return -EINVAL;
+	}
+
+	encoder->steps =3D pdata->steps;
+	encoder->axis =3D pdata->axis;
+	encoder->gpio_a =3D pdata->gpio_a;
+	encoder->gpio_b =3D pdata->gpio_b;
+	encoder->inverted_a =3D pdata->inverted_a;
+	encoder->inverted_b =3D pdata->inverted_b;
+	encoder->steps_per_period =3D pdata->steps_per_period;
+	encoder->relative_axis =3D pdata->relative_axis;
+	encoder->rollover =3D pdata->rollover;
+
+	return 0;
+}
+
 static int rotary_encoder_probe(struct platform_device *pdev)
 {
 	struct device *dev =3D &pdev->dev;
-	const struct rotary_encoder_platform_data *pdata =3D dev_get_platdata=
(dev);
 	struct rotary_encoder *encoder;
 	struct input_dev *input;
 	irq_handler_t handler;
 	int err;
=20
-	if (!pdata) {
-		pdata =3D rotary_encoder_parse_dt(dev);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-
-		if (!pdata) {
-			dev_err(dev, "missing platform data\n");
-			return -EINVAL;
-		}
-	}
-
 	encoder =3D devm_kzalloc(dev, sizeof(struct rotary_encoder), GFP_KERN=
EL);
 	input =3D devm_input_allocate_device(&pdev->dev);
 	if (!encoder || !input) {
@@ -284,55 +299,62 @@ static int rotary_encoder_probe(struct platform_d=
evice *pdev)
 		return -ENOMEM;
 	}
=20
+	err =3D rotary_encoder_parse_dt(dev, encoder);
+	if (err > 0)
+		/* not instatiated by dt */
+		err =3D rotary_encoder_parse_pdata(dev, encoder);
+
+	if (err < 0)
+		return err;
+
 	encoder->input =3D input;
-	encoder->pdata =3D pdata;
=20
 	input->name =3D pdev->name;
 	input->id.bustype =3D BUS_HOST;
 	input->dev.parent =3D dev;
=20
-	if (pdata->relative_axis) {
+	if (encoder->relative_axis) {
 		input->evbit[0] =3D BIT_MASK(EV_REL);
-		input->relbit[0] =3D BIT_MASK(pdata->axis);
+		input->relbit[0] =3D BIT_MASK(encoder->axis);
 	} else {
 		input->evbit[0] =3D BIT_MASK(EV_ABS);
 		input_set_abs_params(encoder->input,
-				     pdata->axis, 0, pdata->steps, 0, 1);
+				     encoder->axis, 0, encoder->steps, 0, 1);
 	}
=20
 	/* request the GPIOs */
-	err =3D devm_gpio_request_one(dev, pdata->gpio_a,
+	err =3D devm_gpio_request_one(dev, encoder->gpio_a,
 				    GPIOF_IN, dev_name(dev));
 	if (err) {
-		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_a);
+		dev_err(dev, "unable to request GPIO %d\n", encoder->gpio_a);
 		return err;
 	}
=20
-	err =3D devm_gpio_request_one(dev, pdata->gpio_b,
+	err =3D devm_gpio_request_one(dev, encoder->gpio_b,
 				    GPIOF_IN, dev_name(dev));
 	if (err) {
-		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_b);
+		dev_err(dev, "unable to request GPIO %d\n", encoder->gpio_b);
 		return err;
 	}
=20
-	encoder->irq_a =3D gpio_to_irq(pdata->gpio_a);
-	encoder->irq_b =3D gpio_to_irq(pdata->gpio_b);
+	encoder->irq_a =3D gpio_to_irq(encoder->gpio_a);
+	encoder->irq_b =3D gpio_to_irq(encoder->gpio_b);
=20
-	switch (pdata->steps_per_period) {
+	switch (encoder->steps_per_period) {
 	case 4:
 		handler =3D &rotary_encoder_quarter_period_irq;
-		encoder->last_stable =3D rotary_encoder_get_state(pdata);
+		encoder->last_stable =3D rotary_encoder_get_state(encoder);
 		break;
 	case 2:
 		handler =3D &rotary_encoder_half_period_irq;
-		encoder->last_stable =3D rotary_encoder_get_state(pdata);
+		encoder->last_stable =3D rotary_encoder_get_state(encoder);
 		break;
 	case 1:
 		handler =3D &rotary_encoder_irq;
 		break;
 	default:
 		dev_err(dev, "'%d' is not a valid steps-per-period value\n",
-			pdata->steps_per_period);
+			encoder->steps_per_period);
 		return -EINVAL;
 	}
=20
@@ -358,7 +380,7 @@ static int rotary_encoder_probe(struct platform_dev=
ice *pdev)
 		return err;
 	}
=20
-	device_init_wakeup(&pdev->dev, pdata->wakeup_source);
+	device_init_wakeup(&pdev->dev, encoder->wakeup_source);
=20
 	platform_set_drvdata(pdev, encoder);
=20
--=20
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
