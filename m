From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/4] Input: rotary_encoder - move away from platform data structure
Date: Mon, 18 Jan 2016 09:41:42 -0800
Message-ID: <1453138902-11657-5-git-send-email-dmitry.torokhov@gmail.com>
References: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>, Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Drop support for platform data passed via a C-structure and switch to
device properties instead, which should make the driver compatible with all
platforms: OF, ACPI and static boards. Static boards should use property
sets to communicate device parameters to the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/raumfeld.c        |  29 +++++--
 drivers/input/misc/rotary_encoder.c | 147 ++++++++++++++----------------------
 include/linux/rotary_encoder.h      |  13 ----
 3 files changed, 76 insertions(+), 113 deletions(-)
 delete mode 100644 include/linux/rotary_encoder.h

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index d156f79..c559114 100644
--- a/arch/arm/mach-pxa/raumfeld.c
+++ b/arch/arm/mach-pxa/raumfeld.c
@@ -18,13 +18,13 @@
 
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/property.h>
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/gpio.h>
 #include <linux/gpio/machine.h>
 #include <linux/smsc911x.h>
 #include <linux/input.h>
-#include <linux/rotary_encoder.h>
 #include <linux/gpio_keys.h>
 #include <linux/input/eeti_ts.h>
 #include <linux/leds.h>
@@ -378,18 +378,27 @@ static struct gpiod_lookup_table raumfeld_rotary_gpios_table = {
 	},
 };
 
-static struct rotary_encoder_platform_data raumfeld_rotary_encoder_info = {
-	.steps		= 24,
-	.axis		= REL_X,
-	.relative_axis	= 1,
+static u32 raumfeld_rotary_encoder_steps = 24;
+static u32 raumfeld_rotary_encoder_axis = REL_X;
+static u32 raumfeld_rotary_encoder_relative_axis = 1;
+
+static struct property_entry raumfeld_rotary_properties[] = {
+	{ "rotary-encoder,steps-per-period",
+		DEV_PROP_U32, 1, &raumfeld_rotary_encoder_steps, },
+	{ "linux,axis",
+		DEV_PROP_U32, 1, &raumfeld_rotary_encoder_axis, },
+	{ "rotary-encoder,relative_axis", 1, },
+		DEV_PROP_U32, 1, &raumfeld_rotary_encoder_relative_axis, },
+	{ NULL }
+};
+
+static struct property_entry raumfeld_rotary_property_set = {
+	.properties = raumfeld_rotary_properties,
 };
 
 static struct platform_device rotary_encoder_device = {
 	.name		= "rotary-encoder",
 	.id		= 0,
-	.dev		= {
-		.platform_data = &raumfeld_rotary_encoder_info,
-	}
 };
 
 /**
@@ -1061,6 +1070,8 @@ static void __init raumfeld_controller_init(void)
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_controller_pin_config));
 
 	gpiod_add_lookup_table(&raumfeld_rotary_gpios_table);
+	device_add_property_set(&rotary_encoder_device.dev,
+				&raumfeld_rotary_property_set);
 	platform_device_register(&rotary_encoder_device);
 
 	spi_register_board_info(ARRAY_AND_SIZE(controller_spi_devices));
@@ -1099,6 +1110,8 @@ static void __init raumfeld_speaker_init(void)
 	platform_device_register(&smc91x_device);
 
 	gpiod_add_lookup_table(&raumfeld_rotary_gpios_table);
+	device_add_property_set(&rotary_encoder_device.dev,
+				&raumfeld_rotary_property_set);
 	platform_device_register(&rotary_encoder_device);
 
 	raumfeld_audio_init();
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index 1882e65..309612a 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -21,20 +21,23 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
-#include <linux/rotary_encoder.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
 #include <linux/pm.h>
+#include <linux/property.h>
 
 #define DRV_NAME "rotary-encoder"
 
 struct rotary_encoder {
 	struct input_dev *input;
-	const struct rotary_encoder_platform_data *pdata;
+
 	struct mutex access_mutex;
 
-	unsigned int axis;
+	u32 steps;
+	u32 axis;
+	bool relative_axis;
+	bool rollover;
+
 	unsigned int pos;
 
 	struct gpio_desc *gpio_a;
@@ -59,31 +62,29 @@ static int rotary_encoder_get_state(struct rotary_encoder *encoder)
 
 static void rotary_encoder_report_event(struct rotary_encoder *encoder)
 {
-	const struct rotary_encoder_platform_data *pdata = encoder->pdata;
-
-	if (pdata->relative_axis) {
+	if (encoder->relative_axis) {
 		input_report_rel(encoder->input,
-				 pdata->axis, encoder->dir ? -1 : 1);
+				 encoder->axis, encoder->dir ? -1 : 1);
 	} else {
 		unsigned int pos = encoder->pos;
 
 		if (encoder->dir) {
 			/* turning counter-clockwise */
-			if (pdata->rollover)
-				pos += pdata->steps;
+			if (encoder->rollover)
+				pos += encoder->steps;
 			if (pos)
 				pos--;
 		} else {
 			/* turning clockwise */
-			if (pdata->rollover || pos < pdata->steps)
+			if (encoder->rollover || pos < encoder->steps)
 				pos++;
 		}
 
-		if (pdata->rollover)
-			pos %= pdata->steps;
+		if (encoder->rollover)
+			pos %= encoder->steps;
 
 		encoder->pos = pos;
-		input_report_abs(encoder->input, pdata->axis, encoder->pos);
+		input_report_abs(encoder->input, encoder->axis, encoder->pos);
 	}
 
 	input_sync(encoder->input);
@@ -204,91 +205,43 @@ out:
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_OF
-static const struct of_device_id rotary_encoder_of_match[] = {
-	{ .compatible = "rotary-encoder", },
-	{ },
-};
-MODULE_DEVICE_TABLE(of, rotary_encoder_of_match);
-
-static struct rotary_encoder_platform_data *rotary_encoder_parse_dt(struct device *dev)
-{
-	const struct of_device_id *of_id =
-				of_match_device(rotary_encoder_of_match, dev);
-	struct device_node *np = dev->of_node;
-	struct rotary_encoder_platform_data *pdata;
-	enum of_gpio_flags flags;
-	int error;
-
-	if (!of_id || !np)
-		return NULL;
-
-	pdata = devm_kzalloc(dev, sizeof(struct rotary_encoder_platform_data),
-			     GFP_KERNEL);
-	if (!pdata)
-		return ERR_PTR(-ENOMEM);
-
-	of_property_read_u32(np, "rotary-encoder,steps", &pdata->steps);
-	of_property_read_u32(np, "linux,axis", &pdata->axis);
-
-	pdata->relative_axis =
-		of_property_read_bool(np, "rotary-encoder,relative-axis");
-	pdata->rollover = of_property_read_bool(np, "rotary-encoder,rollover");
-
-	error = of_property_read_u32(np, "rotary-encoder,steps-per-period",
-				     &pdata->steps_per_period);
-	if (error) {
-		/*
-		 * The 'half-period' property has been deprecated, you must use
-		 * 'steps-per-period' and set an appropriate value, but we still
-		 * need to parse it to maintain compatibility.
-		 */
-		if (of_property_read_bool(np, "rotary-encoder,half-period")) {
-			pdata->steps_per_period = 2;
-		} else {
-			/* Fallback to one step per period behavior */
-			pdata->steps_per_period = 1;
-		}
-	}
-
-	pdata->wakeup_source = of_property_read_bool(np, "wakeup-source");
-
-	return pdata;
-}
-#else
-static inline struct rotary_encoder_platform_data *
-rotary_encoder_parse_dt(struct device *dev)
-{
-	return NULL;
-}
-#endif
-
 static int rotary_encoder_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	const struct rotary_encoder_platform_data *pdata = dev_get_platdata(dev);
 	struct rotary_encoder *encoder;
 	struct input_dev *input;
 	irq_handler_t handler;
+	u32 steps_per_period;
 	int err;
 
-	if (!pdata) {
-		pdata = rotary_encoder_parse_dt(dev);
-		if (IS_ERR(pdata))
-			return PTR_ERR(pdata);
-
-		if (!pdata) {
-			dev_err(dev, "missing platform data\n");
-			return -EINVAL;
-		}
-	}
-
 	encoder = devm_kzalloc(dev, sizeof(struct rotary_encoder), GFP_KERNEL);
 	if (!encoder)
 		return -ENOMEM;
 
 	mutex_init(&encoder->access_mutex);
-	encoder->pdata = pdata;
+
+	device_property_read_u32(dev, "rotary-encoder,steps", &encoder->steps);
+
+	err = device_property_read_u32(dev, "rotary-encoder,steps-per-period",
+				       &steps_per_period);
+	if (err) {
+		/*
+		 * The 'half-period' property has been deprecated, you must
+		 * use 'steps-per-period' and set an appropriate value, but
+		 * we still need to parse it to maintain compatibility. If
+		 * neither property is present we fall back to the one step
+		 * per period behavior.
+		 */
+		steps_per_period = device_property_read_bool(dev,
+					"rotary-encoder,half-period") ? 2 : 1;
+	}
+
+	encoder->rollover =
+		device_property_read_bool(dev, "rotary-encoder,rollover");
+
+	device_property_read_u32(dev, "linux,axis", &encoder->axis);
+	encoder->relative_axis =
+		device_property_read_bool(dev, "rotary-encoder,relative-axis");
 
 	encoder->gpio_a = devm_gpiod_get_index(dev, NULL, 0, GPIOD_IN);
 	if (IS_ERR(encoder->gpio_a)) {
@@ -318,12 +271,13 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	input->id.bustype = BUS_HOST;
 	input->dev.parent = dev;
 
-	if (pdata->relative_axis)
-		input_set_capability(input, EV_REL, pdata->axis);
+	if (encoder->relative_axis)
+		input_set_capability(input, EV_REL, encoder->axis);
 	else
-		input_set_abs_params(input, pdata->axis, 0, pdata->steps, 0, 1);
+		input_set_abs_params(input,
+				     encoder->axis, 0, encoder->steps, 0, 1);
 
-	switch (pdata->steps_per_period) {
+	switch (steps_per_period) {
 	case 4:
 		handler = &rotary_encoder_quarter_period_irq;
 		encoder->last_stable = rotary_encoder_get_state(encoder);
@@ -337,7 +291,7 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		break;
 	default:
 		dev_err(dev, "'%d' is not a valid steps-per-period value\n",
-			pdata->steps_per_period);
+			steps_per_period);
 		return -EINVAL;
 	}
 
@@ -363,7 +317,8 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	device_init_wakeup(&pdev->dev, pdata->wakeup_source);
+	device_init_wakeup(dev,
+			   device_property_read_bool(dev, "wakeup-source"));
 
 	platform_set_drvdata(pdev, encoder);
 
@@ -397,6 +352,14 @@ static int __maybe_unused rotary_encoder_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(rotary_encoder_pm_ops,
 			 rotary_encoder_suspend, rotary_encoder_resume);
 
+#ifdef CONFIG_OF
+static const struct of_device_id rotary_encoder_of_match[] = {
+	{ .compatible = "rotary-encoder", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rotary_encoder_of_match);
+#endif
+
 static struct platform_driver rotary_encoder_driver = {
 	.probe		= rotary_encoder_probe,
 	.driver		= {
diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
deleted file mode 100644
index 4536c81..0000000
--- a/include/linux/rotary_encoder.h
+++ /dev/null
@@ -1,13 +0,0 @@
-#ifndef __ROTARY_ENCODER_H__
-#define __ROTARY_ENCODER_H__
-
-struct rotary_encoder_platform_data {
-	unsigned int steps;
-	unsigned int axis;
-	unsigned int steps_per_period;
-	bool relative_axis;
-	bool rollover;
-	bool wakeup_source;
-};
-
-#endif /* __ROTARY_ENCODER_H__ */
-- 
2.6.0.rc2.230.g3dd15c0
