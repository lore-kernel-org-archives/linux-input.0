From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/4] Input: rotary_encoder - convert to use gpiod API
Date: Mon, 18 Jan 2016 09:41:40 -0800
Message-ID: <1453138902-11657-3-git-send-email-dmitry.torokhov@gmail.com>
References: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34746 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069AbcARRlq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jan 2016 12:41:46 -0500
In-Reply-To: <1453138902-11657-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, =?UTF-8?q?Timo=20Ter=C3=A4s?= <timo.teras@iki.fi>, Daniel Mack <daniel@zonque.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Instead of using old GPIO API, let's switch to GPIOD API, which
automatically handles polarity.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 arch/arm/mach-pxa/raumfeld.c        | 21 +++++++++--
 drivers/input/misc/rotary_encoder.c | 73 +++++++++++++++++--------------------
 include/linux/rotary_encoder.h      |  4 --
 3 files changed, 50 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-pxa/raumfeld.c b/arch/arm/mach-pxa/raumfeld.c
index 36571a9..d156f79 100644
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
@@ -366,14 +367,21 @@ static struct pxaohci_platform_data raumfeld_ohci_info = {
  * Rotary encoder input device
  */
 
+static struct gpiod_lookup_table raumfeld_rotary_gpios_table = {
+	.dev_id = "rotary-encoder",
+	.table = {
+		GPIO_LOOKUP_IDX("gpio-0",
+				GPIO_VOLENC_A, NULL, 0, GPIO_ACTIVE_LOW),
+		GPIO_LOOKUP_IDX("gpio-0",
+				GPIO_VOLENC_B, NULL, 1, GPIO_ACTIVE_HIGH),
+		{ },
+	},
+};
+
 static struct rotary_encoder_platform_data raumfeld_rotary_encoder_info = {
 	.steps		= 24,
 	.axis		= REL_X,
 	.relative_axis	= 1,
-	.gpio_a		= GPIO_VOLENC_A,
-	.gpio_b		= GPIO_VOLENC_B,
-	.inverted_a	= 1,
-	.inverted_b	= 0,
 };
 
 static struct platform_device rotary_encoder_device = {
@@ -1051,7 +1059,10 @@ static void __init raumfeld_controller_init(void)
 	int ret;
 
 	pxa3xx_mfp_config(ARRAY_AND_SIZE(raumfeld_controller_pin_config));
+
+	gpiod_add_lookup_table(&raumfeld_rotary_gpios_table);
 	platform_device_register(&rotary_encoder_device);
+
 	spi_register_board_info(ARRAY_AND_SIZE(controller_spi_devices));
 	i2c_register_board_info(0, &raumfeld_controller_i2c_board_info, 1);
 
@@ -1086,6 +1097,8 @@ static void __init raumfeld_speaker_init(void)
 	i2c_register_board_info(0, &raumfeld_connector_i2c_board_info, 1);
 
 	platform_device_register(&smc91x_device);
+
+	gpiod_add_lookup_table(&raumfeld_rotary_gpios_table);
 	platform_device_register(&rotary_encoder_device);
 
 	raumfeld_audio_init();
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
index b9a86ca..e913bfb64 100644
--- a/drivers/input/misc/rotary_encoder.c
+++ b/drivers/input/misc/rotary_encoder.c
@@ -20,12 +20,11 @@
 #include <linux/input.h>
 #include <linux/device.h>
 #include <linux/platform_device.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/rotary_encoder.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/of_gpio.h>
 #include <linux/pm.h>
 
 #define DRV_NAME "rotary-encoder"
@@ -38,6 +37,9 @@ struct rotary_encoder {
 	unsigned int axis;
 	unsigned int pos;
 
+	struct gpio_desc *gpio_a;
+	struct gpio_desc *gpio_b;
+
 	unsigned int irq_a;
 	unsigned int irq_b;
 
@@ -47,13 +49,10 @@ struct rotary_encoder {
 	char last_stable;
 };
 
-static int rotary_encoder_get_state(const struct rotary_encoder_platform_data *pdata)
+static int rotary_encoder_get_state(struct rotary_encoder *encoder)
 {
-	int a = !!gpio_get_value_cansleep(pdata->gpio_a);
-	int b = !!gpio_get_value_cansleep(pdata->gpio_b);
-
-	a ^= pdata->inverted_a;
-	b ^= pdata->inverted_b;
+	int a = !!gpiod_get_value_cansleep(encoder->gpio_a);
+	int b = !!gpiod_get_value_cansleep(encoder->gpio_b);
 
 	return ((a << 1) | b);
 }
@@ -97,7 +96,7 @@ static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
 
 	mutex_lock(&encoder->access_mutex);
 
-	state = rotary_encoder_get_state(encoder->pdata);
+	state = rotary_encoder_get_state(encoder);
 
 	switch (state) {
 	case 0x0:
@@ -130,7 +129,7 @@ static irqreturn_t rotary_encoder_half_period_irq(int irq, void *dev_id)
 
 	mutex_lock(&encoder->access_mutex);
 
-	state = rotary_encoder_get_state(encoder->pdata);
+	state = rotary_encoder_get_state(encoder);
 
 	switch (state) {
 	case 0x00:
@@ -160,7 +159,7 @@ static irqreturn_t rotary_encoder_quarter_period_irq(int irq, void *dev_id)
 
 	mutex_lock(&encoder->access_mutex);
 
-	state = rotary_encoder_get_state(encoder->pdata);
+	state = rotary_encoder_get_state(encoder);
 
 	/*
 	 * We encode the previous and the current state using a byte.
@@ -232,12 +231,6 @@ static struct rotary_encoder_platform_data *rotary_encoder_parse_dt(struct devic
 	of_property_read_u32(np, "rotary-encoder,steps", &pdata->steps);
 	of_property_read_u32(np, "linux,axis", &pdata->axis);
 
-	pdata->gpio_a = of_get_gpio_flags(np, 0, &flags);
-	pdata->inverted_a = flags & OF_GPIO_ACTIVE_LOW;
-
-	pdata->gpio_b = of_get_gpio_flags(np, 1, &flags);
-	pdata->inverted_b = flags & OF_GPIO_ACTIVE_LOW;
-
 	pdata->relative_axis =
 		of_property_read_bool(np, "rotary-encoder,relative-axis");
 	pdata->rollover = of_property_read_bool(np, "rotary-encoder,rollover");
@@ -294,14 +287,32 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 	if (!encoder)
 		return -ENOMEM;
 
+	mutex_init(&encoder->access_mutex);
+	encoder->pdata = pdata;
+
+	encoder->gpio_a = devm_gpiod_get_index(dev, NULL, 0, GPIOD_IN);
+	if (IS_ERR(encoder->gpio_a)) {
+		err = PTR_ERR(encoder->gpio_a);
+		dev_err(dev, "unable to get GPIO at index 0: %d\n", err);
+		return err;
+	}
+
+	encoder->irq_a = gpiod_to_irq(encoder->gpio_a);
+
+	encoder->gpio_b = devm_gpiod_get_index(dev, NULL, 1, GPIOD_IN);
+	if (IS_ERR(encoder->gpio_b)) {
+		err = PTR_ERR(encoder->gpio_b);
+		dev_err(dev, "unable to get GPIO at index 1: %d\n", err);
+		return err;
+	}
+
+	encoder->irq_b = gpiod_to_irq(encoder->gpio_b);
+
 	input = devm_input_allocate_device(dev);
 	if (!input)
 		return -ENOMEM;
 
-	mutex_init(&encoder->access_mutex);
-
 	encoder->input = input;
-	encoder->pdata = pdata;
 
 	input->name = pdev->name;
 	input->id.bustype = BUS_HOST;
@@ -316,32 +327,14 @@ static int rotary_encoder_probe(struct platform_device *pdev)
 				     pdata->axis, 0, pdata->steps, 0, 1);
 	}
 
-	/* request the GPIOs */
-	err = devm_gpio_request_one(dev, pdata->gpio_a, GPIOF_IN,
-				    dev_name(dev));
-	if (err) {
-		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_a);
-		return err;
-	}
-
-	err = devm_gpio_request_one(dev, pdata->gpio_b, GPIOF_IN,
-				    dev_name(dev));
-	if (err) {
-		dev_err(dev, "unable to request GPIO %d\n", pdata->gpio_b);
-		return err;
-	}
-
-	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
-	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
-
 	switch (pdata->steps_per_period) {
 	case 4:
 		handler = &rotary_encoder_quarter_period_irq;
-		encoder->last_stable = rotary_encoder_get_state(pdata);
+		encoder->last_stable = rotary_encoder_get_state(encoder);
 		break;
 	case 2:
 		handler = &rotary_encoder_half_period_irq;
-		encoder->last_stable = rotary_encoder_get_state(pdata);
+		encoder->last_stable = rotary_encoder_get_state(encoder);
 		break;
 	case 1:
 		handler = &rotary_encoder_irq;
diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
index fe3dc64..4536c81 100644
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
-- 
2.6.0.rc2.230.g3dd15c0

