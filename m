From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 3/3] input: rotary-encoder: add DT bindings
Date: Wed, 25 Jul 2012 20:25:14 +0200
Message-ID: <1343240714-11399-3-git-send-email-zonque@gmail.com>
References: <1343240714-11399-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:37305 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab2GYSZV (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Jul 2012 14:25:21 -0400
In-Reply-To: <1343240714-11399-1-git-send-email-zonque@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jhovold@gmail.com, hartleys@visionengravers.com, Daniel Mack <zonque@gmail.com>

This adds devicetree bindings to the rotary encoder driver and some
documentation about how to use them. Tested on a PXA3xx platform.

To allow kernel provided data to override DT values, and to avoid
touching the pdev->platform_data, a copy of struct
rotary_encoder_platform_data is now kept privately in
struct rotary_encoder.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/input/rotary-encoder.txt   |   37 +++++++
 drivers/input/misc/rotary_encoder.c                |  101 ++++++++++++++++----
 2 files changed, 120 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/rotary-encoder.txt

diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b/Documentation/devicetree/bindings/input/rotary-encoder.txt
new file mode 100644
index 0000000..dd1f634
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
@@ -0,0 +1,37 @@
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
+
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index e261ad4..91c661d 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -24,12 +24,14 @@
 #include <linux/gpio.h>
 #include <linux/rotary_encoder.h>
 #include <linux/slab.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
 
 #define DRV_NAME "rotary-encoder"
 
 struct rotary_encoder {
 	struct input_dev *input;
-	struct rotary_encoder_platform_data *pdata;
+	struct rotary_encoder_platform_data pdata;
 
 	unsigned int axis;
 	unsigned int pos;
@@ -56,7 +58,7 @@ static int rotary_encoder_get_state(struct rotary_encoder_platform_data *pdata)
 
 static void rotary_encoder_report_event(struct rotary_encoder *encoder)
 {
-	struct rotary_encoder_platform_data *pdata = encoder->pdata;
+	struct rotary_encoder_platform_data *pdata = &encoder->pdata;
 
 	if (pdata->relative_axis) {
 		input_report_rel(encoder->input,
@@ -91,7 +93,7 @@ static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 	struct rotary_encoder *encoder = dev_id;
 	int state;
 
-	state = rotary_encoder_get_state(encoder->pdata);
+	state = rotary_encoder_get_state(&encoder->pdata);
 
 	switch (state) {
 	case 0x0:
@@ -120,7 +122,7 @@ static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
 	struct rotary_encoder *encoder = dev_id;
 	int state;
 
-	state = rotary_encoder_get_state(encoder->pdata);
+	state = rotary_encoder_get_state(&encoder->pdata);
 
 	switch (state) {
 	case 0x00:
@@ -140,35 +142,96 @@ static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id rotary_encoder_of_match[] = {
+	{ .compatible = "rotary-encoder", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rotary_encoder_of_match);
+
+static int rotary_encoder_probe_dt(struct platform_device *pdev,
+				   struct rotary_encoder *encoder)
+{
+	int tmp;
+	enum of_gpio_flags flags;
+	struct rotary_encoder_platform_data *pdata = &encoder->pdata;
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id =
+		of_match_device(rotary_encoder_of_match, &pdev->dev);
+
+	if (!of_id)
+		return 0;
+
+	if (of_property_read_u32(np, "rotary-encoder,steps", &tmp) == 0)
+		pdata->steps = tmp;
+	if (of_property_read_u32(np, "linux,axis", &tmp) == 0)
+		pdata->axis = tmp;
+
+	pdata->gpio_a = of_get_gpio_flags(np, 0, &flags);
+	pdata->inverted_a = flags & OF_GPIO_ACTIVE_LOW;
+
+	pdata->gpio_b = of_get_gpio_flags(np, 1, &flags);
+	pdata->inverted_b = flags & OF_GPIO_ACTIVE_LOW;
+
+	if (of_get_property(np, "rotary-encoder,relative-axis", NULL))
+		pdata->relative_axis = 1;
+	if (of_get_property(np, "rotary-encoder,rollover", NULL))
+		pdata->rollover = 1;
+	if (of_get_property(np, "rotary-encoder,half-period", NULL))
+		pdata->half_period = 1;
+
+	return 1;
+}
+#else
+static inline int rotary_encoder_probe_dt(struct platform_device *)
+{
+	return 0;
+}
+#endif
+
 static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 {
-	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
+	struct rotary_encoder_platform_data *pdata;
 	struct rotary_encoder *encoder;
 	struct input_dev *input;
 	struct device *dev = &pdev->dev;
 	irq_handler_t handler;
+	bool use_of = 0;
 	int err;
 
-	if (!pdata) {
+	encoder = kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
+	if (!encoder)
+		return -ENOMEM;
+
+	err = rotary_encoder_probe_dt(pdev, encoder);
+	if (err < 0)
+		return err;
+	if (err > 0)
+		use_of = 1;
+
+	if (!&pdev->dev.platform_data && !use_of) {
 		dev_err(&pdev->dev, "missing platform data\n");
 		return -ENOENT;
 	}
 
-	encoder = kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
+	pdata = &encoder->pdata;
+
+	/* if kernel data was provided, copy it over to our local copy */
+	if (pdev->dev.platform_data)
+		memcpy(pdata, &pdev->dev.platform_data, sizeof(*pdata));
+
+	/* create and register the input driver */
 	input = input_allocate_device();
-	if (!encoder || !input) {
-		dev_err(&pdev->dev, "failed to allocate memory for device\n");
+	if (!input) {
+		dev_err(&pdev->dev, "failed to allocate input device\n");
 		err = -ENOMEM;
-		goto exit_free_mem;
+		goto exit_free_encoder;
 	}
 
-	encoder->input = input;
-	encoder->pdata = pdata;
-
-	/* create and register the input driver */
 	input->name = pdev->name;
 	input->id.bustype = BUS_HOST;
-	input->dev.parent = &pdev->dev;
+	input->dev.parent = dev;
+	encoder->input = input;
 
 	if (pdata->relative_axis) {
 		input->evbit[0] = BIT_MASK(EV_REL);
@@ -182,7 +245,7 @@ static int __devinit rotary_encoder_probe(struct platform_device *pdev)
 	err = input_register_device(input);
 	if (err) {
 		dev_err(dev, "failed to register input device\n");
-		goto exit_free_mem;
+		goto exit_free_input;
 	}
 
 	/* request the GPIOs */
@@ -238,8 +301,9 @@ exit_free_gpio_a:
 exit_unregister_input:
 	input_unregister_device(input);
 	input = NULL; /* so we don't try to free it */
-exit_free_mem:
+exit_free_input:
 	input_free_device(input);
+exit_free_encoder:
 	kfree(encoder);
 	return err;
 }
@@ -247,7 +311,7 @@ exit_free_mem:
 static int __devexit rotary_encoder_remove(struct platform_device *pdev)
 {
 	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
-	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
+	struct rotary_encoder_platform_data *pdata = &encoder->pdata;
 
 	free_irq(encoder->irq_a, encoder);
 	free_irq(encoder->irq_b, encoder);
@@ -266,6 +330,7 @@ static struct platform_driver rotary_encoder_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(rotary_encoder_of_match),
 	}
 };
 module_platform_driver(rotary_encoder_driver);
-- 
1.7.10.4

