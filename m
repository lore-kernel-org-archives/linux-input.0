From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] input: rotary-encoder: add DT bindings
Date: Tue, 24 Jul 2012 19:38:06 +0200
Message-ID: <1343151487-27841-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:43741 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755600Ab2GXRpF (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jul 2012 13:45:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jhovold@gmail.com, hartleys@visionengravers.com, Daniel Mack <zonque@gmail.com>

This adds devicetree bindings to the rotary encoder driver and some
documenation about how to use them. Tested on a PXA3xx platform.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 .../devicetree/bindings/input/rotary-encoder.txt   |   37 ++++++++++++
 drivers/input/misc/rotary_encoder.c                |   63 +++++++++++++++++++-
 2 files changed, 99 insertions(+), 1 deletion(-)
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
index f07f784..350cbd1 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -24,6 +24,8 @@
 #include <linux/gpio.h>
 #include <linux/rotary_encoder.h>
 #include <linux/slab.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
 
 #define DRV_NAME "rotary-encoder"
 
@@ -140,14 +142,72 @@ static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+#ifdef CONFIG_OF
+static struct of_device_id rotary_encoder_of_match[] = {
+	{ .compatible = "rotary-encoder", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rotary_encoder_of_match);
+
+static int rotary_encoder_probe_dt(struct platform_device *pdev)
+{
+	int tmp;
+	enum of_gpio_flags flags;
+	struct rotary_encoder_platform_data *pdata;
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id =
+		of_match_device(rotary_encoder_of_match, &pdev->dev);
+
+	if (!of_id)
+		return 0;
+
+	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
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
+	pdev->dev.platform_data = pdata;
+
+	return 0;
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
 	irq_handler_t handler;
 	int err;
 
+	err = rotary_encoder_probe_dt(pdev);
+	if (err)
+		return err;
+
+	pdata = pdev->dev.platform_data;
+
 	if (!pdata) {
 		dev_err(&pdev->dev, "missing platform data\n");
 		return -ENOENT;
@@ -282,6 +342,7 @@ static struct platform_driver rotary_encoder_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(rotary_encoder_of_match),
 	}
 };
 module_platform_driver(rotary_encoder_driver);
-- 
1.7.10.4

