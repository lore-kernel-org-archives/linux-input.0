From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 3/3] input: rotary-encoder: add DT bindings
Date: Mon, 30 Jul 2012 23:12:14 -0700
Message-ID: <20120731061214.GB32327@core.coreip.homeip.net>
References: <1343240714-11399-1-git-send-email-zonque@gmail.com>
 <1343240714-11399-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:36565 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754832Ab2GaGMU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jul 2012 02:12:20 -0400
Received: by pbbrp8 with SMTP id rp8so11132754pbb.19
        for <linux-input@vger.kernel.org>; Mon, 30 Jul 2012 23:12:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343240714-11399-3-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-input@vger.kernel.org, jhovold@gmail.com, hartleys@visionengravers.com

Hi Daniel,

On Wed, Jul 25, 2012 at 08:25:14PM +0200, Daniel Mack wrote:
> +#ifdef CONFIG_OF
> +static struct of_device_id rotary_encoder_of_match[] = {
> +	{ .compatible = "rotary-encoder", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, rotary_encoder_of_match);
> +
> +static int rotary_encoder_probe_dt(struct platform_device *pdev,
> +				   struct rotary_encoder *encoder)
> +{
> +	int tmp;
> +	enum of_gpio_flags flags;
> +	struct rotary_encoder_platform_data *pdata = &encoder->pdata;
> +	struct device_node *np = pdev->dev.of_node;
> +	const struct of_device_id *of_id =
> +		of_match_device(rotary_encoder_of_match, &pdev->dev);
> +
> +	if (!of_id)
> +		return 0;
> +
> +	if (of_property_read_u32(np, "rotary-encoder,steps", &tmp) == 0)
> +		pdata->steps = tmp;
> +	if (of_property_read_u32(np, "linux,axis", &tmp) == 0)
> +		pdata->axis = tmp;

You should be able to simply say

	of_property_read_u32(np, "linux,axis", &pdata->axis);

> +
> +	pdata->gpio_a = of_get_gpio_flags(np, 0, &flags);
> +	pdata->inverted_a = flags & OF_GPIO_ACTIVE_LOW;
> +
> +	pdata->gpio_b = of_get_gpio_flags(np, 1, &flags);
> +	pdata->inverted_b = flags & OF_GPIO_ACTIVE_LOW;
> +
> +	if (of_get_property(np, "rotary-encoder,relative-axis", NULL))
> +		pdata->relative_axis = 1;
> +	if (of_get_property(np, "rotary-encoder,rollover", NULL))
> +		pdata->rollover = 1;
> +	if (of_get_property(np, "rotary-encoder,half-period", NULL))
> +		pdata->half_period = 1;
> +
> +	return 1;
> +}
> +#else
> +static inline int rotary_encoder_probe_dt(struct platform_device *)


This does not match the other instance (you are missing the 2nd
argument).

> +{
> +	return 0;
> +}
> +#endif
> +
>  static int __devinit rotary_encoder_probe(struct platform_device *pdev)
>  {
> -	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
> +	struct rotary_encoder_platform_data *pdata;
>  	struct rotary_encoder *encoder;
>  	struct input_dev *input;
>  	struct device *dev = &pdev->dev;
>  	irq_handler_t handler;
> +	bool use_of = 0;
>  	int err;
>  
> -	if (!pdata) {
> +	encoder = kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
> +	if (!encoder)
> +		return -ENOMEM;
> +
> +	err = rotary_encoder_probe_dt(pdev, encoder);
> +	if (err < 0)
> +		return err;

Not that your implementation can fail, but why do you fail device
initialization even if we have kernel-supplied platform data?

> +	if (err > 0)
> +		use_of = 1;
> +
> +	if (!&pdev->dev.platform_data && !use_of) {

!&pdev->dev.platform_data is never false, you meant

	!pdev->dev.platform_data

BTW, we have an accessor function dev_get_platdata().

Still, I do not line the copying of pdata over, maybe we coudl have
something like the patch below?

Thanks!

-- 
Dmitry

Input: rotary-encoder - add DT bindings

From: Daniel Mack <zonque@gmail.com>

This adds devicetree bindings to the rotary encoder driver and some
documentation about how to use them. Tested on a PXA3xx platform.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

 .../devicetree/bindings/input/rotary-encoder.txt   |   36 ++++++++
 drivers/input/misc/rotary_encoder.c                |   96 +++++++++++++++++---
 2 files changed, 116 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/rotary-encoder.txt


diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
new file mode 100644
index 0000000..3315495
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -0,0 +1,36 @@
+Rotary encoder DT bindings
+
+Required properties:
+- gpios: a spec for two GPIOs to be used
+
+Optional properties:
+- linux,axis: the input subsystem axis to map to this rotary encoder.
+  Defaults to 0 (ABS_X / REL_X)
+- rotary-encoder,steps: Number of steps in a full turnaround of the
+  encoder. Only relevant for absolute axis. Defaults to 24 which is a
+  typical value for such devices.
+- rotary-encoder,relative-axis: register a relative axis rather than an
+  absolute one. Relative axis will only generate +1/-1 events on the input
+  device, hence no steps need to be passed.
+- rotary-encoder,rollover: Automatic rollove when the rotary value becomes
+  greater than the specified steps or smaller than 0. For absolute axis only.
+- rotary-encoder,half-period: Makes the driver work on half-period mode.
+
+See Documentation/input/rotary-encoder.txt for more information.
+
+Example:
+
+		rotary@0 {
+			compatible = "rotary-encoder";
+			gpios = <&gpio 19 1>, <&gpio 20 0>; /* GPIO19 is inverted */
+			linux,axis = <0>; /* REL_X */
+			rotary-encoder,relative-axis;
+		};
+
+		rotary@1 {
+			compatible = "rotary-encoder";
+			gpios = <&gpio 21 0>, <&gpio 22 0>;
+			linux,axis = <1>; /* ABS_Y */
+			rotary-encoder,steps = <24>;
+			rotary-encoder,rollover;
+		};
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index ea51265..0f9d746 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -24,6 +24,8 @@
 #include <linux/gpio.h>
 #include <linux/rotary_encoder.h>
 #include <linux/slab.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
 
 #define DRV_NAME "rotary-encoder"
 
@@ -140,6 +142,56 @@ static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id rotary_encoder_of_match[] = {
+	{ .compatible = "rotary-encoder", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rotary_encoder_of_match);
+
+static struct rotary_encoder_platform_data * __devinit
+rotary_encoder_parse_dt(struct device *dev)
+{
+	const struct of_device_id *of_id =
+				of_match_device(rotary_encoder_of_match, dev);
+	struct device_node *np = dev->of_node;
+	struct rotary_encoder_platform_data *pdata;
+	enum of_gpio_flags flags;
+
+	if (!of_id || !np)
+		return NULL;
+
+	pdata = kzalloc(sizeof(struct rotary_encoder_platform_data),
+			GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	of_property_read_u32(np, "rotary-encoder,steps", &pdata->steps);
+	of_property_read_u32(np, "linux,axis", &pdata->axis);
+
+	pdata->gpio_a = of_get_gpio_flags(np, 0, &flags);
+	pdata->inverted_a = flags & OF_GPIO_ACTIVE_LOW;
+
+	pdata->gpio_b = of_get_gpio_flags(np, 1, &flags);
+	pdata->inverted_b = flags & OF_GPIO_ACTIVE_LOW;
+
+	pdata->relative_axis = !!of_get_property(np,
+					"rotary-encoder,relative-axis", NULL);
+	pdata->rollover = !!of_get_property(np,
+					"rotary-encoder,rollover", NULL);
+	pdata->half_period = !!of_get_property(np,
+					"rotary-encoder,half-period", NULL))
+
+	return pdata;
+}
+#else
+static inline struct rotary_encoder_platform_data *
+rotary_encoder_parse_dt(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -150,14 +202,19 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 	int err;
 
 	if (!pdata) {
-		dev_err(&pdev->dev, "missing platform data\n");
-		return -ENOENT;
+		pdata = rotary_encoder_parse_dt(dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+
+		if (!pdata) {
+			dev_err(dev, "missing platform data\n");
+			return -EINVAL;
+		}
 	}
 
 	encoder = kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
 	input = input_allocate_device();
 	if (!encoder || !input) {
-		dev_err(&pdev->dev, "failed to allocate memory for device\n");
 		err = -ENOMEM;
 		goto exit_free_mem;
 	}
@@ -165,10 +222,9 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 	encoder->input = input;
 	encoder->pdata = pdata;
 
-	/* create and register the input driver */
 	input->name = pdev->name;
 	input->id.bustype = BUS_HOST;
-	input->dev.parent = &pdev->dev;
+	input->dev.parent = dev;
 
 	if (pdata->relative_axis) {
 		input->evbit[0] = BIT_MASK(EV_REL);
@@ -179,17 +235,11 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 				     pdata->axis, 0, pdata->steps, 0, 1);
 	}
 
-	err = input_register_device(input);
-	if (err) {
-		dev_err(dev, "failed to register input device\n");
-		goto exit_free_mem;
-	}
-
 	/* request the GPIOs */
 	err = gpio_request_one(pdata->gpio_a, GPIOF_IN, dev_name(dev));
 	if (err) {
 		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_a);
-		goto exit_unregister_input;
+		goto exit_free_mem;
 	}
 
 	err = gpio_request_one(pdata->gpio_b, GPIOF_IN, dev_name(dev));
@@ -225,22 +275,30 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 		goto exit_free_irq_a;
 	}
 
+	err = input_register_device(input);
+	if (err) {
+		dev_err(dev, "failed to register input device\n");
+		goto exit_free_irq_b;
+	}
+
 	platform_set_drvdata(pdev, encoder);
 
 	return 0;
 
+exit_free_irq_b:
+	free_irq(encoder->irq_b, encoder);
 exit_free_irq_a:
 	free_irq(encoder->irq_a, encoder);
 exit_free_gpio_b:
 	gpio_free(pdata->gpio_b);
 exit_free_gpio_a:
 	gpio_free(pdata->gpio_a);
-exit_unregister_input:
-	input_unregister_device(input);
-	input = NULL; /* so we don't try to free it */
 exit_free_mem:
 	input_free_device(input);
 	kfree(encoder);
+	if (!dev_get_platdata(&pdev->dev))
+		kfree(pdata);
+
 	return err;
 }
 
@@ -253,10 +311,15 @@ static int __devexit rotary_encoder_remove(struct platform_device *pdev)
 	free_irq(encoder->irq_b, encoder);
 	gpio_free(pdata->gpio_a);
 	gpio_free(pdata->gpio_b);
+
 	input_unregister_device(encoder->input);
-	platform_set_drvdata(pdev, NULL);
 	kfree(encoder);
 
+	if (!dev_get_platdata(&pdev->dev))
+		kfree(pdata);
+
+	platform_set_drvdata(pdev, NULL);
+
 	return 0;
 }
 
@@ -266,6 +329,7 @@ static struct platform_driver rotary_encoder_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(rotary_encoder_of_match),
 	}
 };
 module_platform_driver(rotary_encoder_driver);
