From: Daniel Mack <daniel@caiaq.de>
Subject: [PATCH] generic driver for rotary encoders on GPIOs
Date: Fri, 27 Feb 2009 09:48:35 +0100
Message-ID: <1235724515-10166-1-git-send-email-daniel@caiaq.de>
References: <20090227064314.GB32470@buzzloop.caiaq.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:41864 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbZB0ItN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 03:49:13 -0500
In-Reply-To: <20090227064314.GB32470@buzzloop.caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Mack <daniel@caiaq.de>

This patch adds a generic driver for rotary encoders connected to GPIO
pins of a system. It relies on gpiolib and generic hardware irqs. The
documentation that also comes with this patch explains the concept and
how to use the driver.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
---
 new version:
	* dropped depencency to GENERIC_HARDIRQS
	* dropped gpio_a and gpio_b from struct rotary_encoder_platform_data
	* use irq_to_gpio()
	* added include/linux/rotary-encoder.h

 Documentation/input/rotary-encoder.txt |  108 +++++++++++++++
 drivers/input/misc/Kconfig             |   11 ++
 drivers/input/misc/Makefile            |    2 +
 drivers/input/misc/rotary_encoder.c    |  237 ++++++++++++++++++++++++++++++++
 include/linux/rotary-encoder.h         |   10 ++
 5 files changed, 368 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/input/rotary-encoder.txt
 create mode 100644 drivers/input/misc/rotary_encoder.c
 create mode 100644 include/linux/rotary-encoder.h

diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
new file mode 100644
index 0000000..ef18df6
--- /dev/null
+++ b/Documentation/input/rotary-encoder.txt
@@ -0,0 +1,108 @@
+rotary-encoder - a generic driver for GPIO connected devices
+Daniel Mack <daniel@caiaq.de>, Feb 2009
+
+0. Function
+-----------
+
+Rotary encoders are devices which are connected to the CPU or other
+peripherals with two wires. The outputs are phase-shifted by 90 degrees
+and by triggering on falling and rising edges, the turn direction can
+be determined.
+
+The phase diagram of these two outputs look like this:
+
+                  _____       _____       _____
+                 |     |     |     |     |     |
+  Channel A  ____|     |_____|     |_____|     |____
+
+                 :  :  :  :  :  :  :  :  :  :  :  :
+            __       _____       _____       _____
+              |     |     |     |     |     |     |
+  Channel B   |_____|     |_____|     |_____|     |__
+
+                 :  :  :  :  :  :  :  :  :  :  :  :
+  Event          a  b  c  d  a  b  c  d  a  b  c  d
+
+                |<-------->|
+	          one step
+
+
+For more information, please see
+	http://en.wikipedia.org/wiki/Rotary_encoder
+
+
+1. Events / state machine
+-------------------------
+
+a) Rising edge on channel A, channel B in low state
+	This state is used to recognize a clockwise turn
+
+b) Rising edge on channel B, channel A in high state
+	When entering this state, the encoder is put into 'armed' state,
+	meaning that there it has seen half the way of a one-step transition.
+
+c) Falling edge on channel A, channel B in high state
+	This state is used to recognize a counter-clockwise turn
+
+d) Falling edge on channel B, channel A in low state
+	Parking position. If the encoder enters this state, a full transition
+	should have happend, unless it flipped back on half the way. The
+	'armed' state tells us about that.
+
+2. Platform requirements
+------------------------
+
+As there is no hardware dependent call in this driver, the platform it is
+used with must support gpiolib. Another requirement is that IRQs must be
+able to fire on both edges.
+
+
+3. Board integration
+--------------------
+
+To use this driver in your system, register a platform_device with the
+name 'rotary-encoder' and associate the IRQs and some specific platform
+data with it.
+
+struct rotary_encoder_platform_data is declared in
+include/linux/rotary-encoder.h and needs to be filled with the number of
+steps the encoder has and can carry information about externally inverted
+signals (because of used invertig buffer or other reasons).
+
+Because GPIO to IRQ mapping is platform specific, this information must
+be given in seperately to the driver. See the example below.
+
+---------<snip>---------
+
+/* board support file example */
+
+#define GPIO_ROTARY_A 1
+#define GPIO_ROTARY_B 2
+
+static struct resource rotary_encoder_resources[] = {
+	[0] = {
+		.flags = IORESOURCE_IRQ,
+		.start = gpio_to_irq(GPIO_ROTARY_A)
+	},
+	[1] = {
+		.flags = IORESOURCE_IRQ,
+		.start = gpio_to_irq(GPIO_ROTARY_B)
+	}
+};
+
+static struct rotary_encoder_platform_data my_rotary_encoder_info = {
+	.steps = 24,
+	.inverted_a = 0,
+	.inverted_b = 0,
+};
+
+static struct platform_device rotary_encoder_device = {
+	.name		= "rotary-encoder",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(rotary_encoder_resources),
+	.resource	= rotary_encoder_resources,
+	.dev		= {
+		.platform_data = &my_rotary_encoder_info,
+	}
+};
+
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 67e5553..806d2e6 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -227,4 +227,15 @@ config INPUT_PCF50633_PMU
 	 Say Y to include support for delivering  PMU events via  input
 	 layer on NXP PCF50633.
 
+config INPUT_GPIO_ROTARY_ENCODER
+	tristate "Rotary encoders connected to GPIO pins"
+	depends on GPIOLIB && GENERIC_GPIO
+	help
+	  Say Y here to add support for rotary encoders connected to GPIO lines.
+	  Check file:Documentation/incput/rotary_encoder.txt for more
+	  information.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called rotary_encoder.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index bb62e6e..e86cee6 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -22,3 +22,5 @@ obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
 obj-$(CONFIG_INPUT_APANEL)		+= apanel.o
 obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_PCF50633_PMU)	+= pcf50633-input.o
+obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+= rotary_encoder.o
+
diff --git a/drivers/input/misc/rotary_encoder.c b/drivers/input/misc/rotary_encoder.c
new file mode 100644
index 0000000..77d8eca
--- /dev/null
+++ b/drivers/input/misc/rotary_encoder.c
@@ -0,0 +1,237 @@
+/*
+ * rotary_encoder.c
+ *
+ * (c) 2009 Daniel Mack <daniel@caiaq.de>
+ *
+ * state machine code inspired by code from Tim Ruetz
+ *
+ * A generic driver for rotary encoders connected to GPIO lines.
+ * See file:Documentation/input/rotary_encoder.txt for more information
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/rotary-encoder.h>
+
+#define DRV_NAME "rotary-encoder"
+
+struct rotary_encoder {
+	unsigned int irq_a;
+	unsigned int irq_b;
+	unsigned int gpio_a;
+	unsigned int gpio_b;
+	unsigned int pos;
+	unsigned int armed;
+	unsigned int dir;
+	struct input_dev *input;
+	struct rotary_encoder_platform_data *pdata;
+};
+
+static void rotary_encoder_left(struct rotary_encoder *encoder)
+{
+	encoder->pos += encoder->pdata->steps;
+	encoder->pos--;
+	encoder->pos %= encoder->pdata->steps;
+	input_report_abs(encoder->input, ABS_X, encoder->pos);
+	input_sync(encoder->input);
+}
+
+static void rotary_encoder_right(struct rotary_encoder *encoder)
+{
+	encoder->pos++;
+	encoder->pos %= encoder->pdata->steps;
+	input_report_abs(encoder->input, ABS_X, encoder->pos);
+	input_sync(encoder->input);
+}
+
+static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
+{
+	struct rotary_encoder *encoder = dev_id;
+	int a = !!gpio_get_value(encoder->gpio_a);
+	int b = !!gpio_get_value(encoder->gpio_b);
+	int state;
+
+	a ^= encoder->pdata->inverted_a;
+	b ^= encoder->pdata->inverted_b;
+	state = (a << 1) | b;
+
+	switch (state) {
+	case 0x0:
+		if (!encoder->armed)
+			break;
+
+		if (encoder->dir)
+			rotary_encoder_left(encoder);
+		else
+			rotary_encoder_right(encoder);
+
+		encoder->armed = 0;
+		break;
+	case 0x1:
+	case 0x2:
+		if (!encoder->armed)
+			break;
+
+		encoder->dir = state - 1;
+		break;
+	case 0x3:
+		encoder->armed = 1;
+		break;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int __devinit rotary_encoder_probe(struct platform_device *pdev)
+{
+	struct rotary_encoder *encoder;
+	struct resource *irq_a_res;
+	struct resource *irq_b_res;
+	unsigned long irq_flags;
+	int err;
+
+	encoder = kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
+	if (!encoder) {
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	irq_flags = IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE;
+	irq_a_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	irq_b_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
+	encoder->pdata = pdev->dev.platform_data;
+
+	if (!irq_a_res || !irq_b_res || !encoder->pdata) {
+		dev_err(&pdev->dev, "insufficient resources\n");
+		err = -ENOENT;
+		goto exit_free_mem;
+	}
+
+	encoder->irq_a = irq_a_res->start;
+	encoder->irq_b = irq_b_res->start;
+	encoder->gpio_a = irq_to_gpio(encoder->irq_a);
+	encoder->gpio_b = irq_to_gpio(encoder->irq_b);
+
+	/* create and register the input driver */
+	encoder->input = input_allocate_device();
+	if (!encoder->input) {
+		dev_err(&pdev->dev, "failed to allocate input device\n");
+		err = -ENOMEM;
+		goto exit_free_mem;
+	}
+
+	encoder->input->name = pdev->name;
+	encoder->input->id.bustype = BUS_HOST;
+	encoder->input->dev.parent = &pdev->dev;
+	encoder->input->evbit[0] = BIT_MASK(EV_ABS);
+	encoder->input->absbit[0] = BIT_MASK(ABS_X);
+	input_set_abs_params(encoder->input, ABS_X, 0,
+			     encoder->pdata->steps, 0, 1);
+	platform_set_drvdata(pdev, encoder);
+
+	err = input_register_device(encoder->input);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto exit_free_input;
+	}
+
+	/* request the GPIOs */
+	err = gpio_request(encoder->gpio_a, DRV_NAME);
+	if (err) {
+		dev_err(&pdev->dev, "unable to request GPIO %d\n",
+			encoder->gpio_a);
+		goto exit_free_input;
+	}
+
+	err = gpio_request(encoder->gpio_b, DRV_NAME);
+	if (err) {
+		dev_err(&pdev->dev, "unable to request GPIO %d\n",
+			encoder->gpio_b);
+		goto exit_free_gpio_a;
+	}
+
+	/* request the IRQs */
+	err = request_irq(encoder->irq_a, &rotary_encoder_irq,
+			  irq_flags, DRV_NAME, encoder);
+	if (err) {
+		dev_err(&pdev->dev, "unable to request IRQ %d\n",
+			encoder->irq_a);
+		goto exit_free_gpio;
+	}
+
+	err = request_irq(encoder->irq_b, &rotary_encoder_irq,
+			  irq_flags, DRV_NAME, encoder);
+	if (err) {
+		dev_err(&pdev->dev, "unable to request IRQ %d\n",
+			encoder->irq_b);
+		goto exit_free_irq_a;
+	}
+
+	return 0;
+
+exit_free_irq_a:
+	free_irq(encoder->irq_a, encoder);
+exit_free_gpio:
+	gpio_free(encoder->gpio_b);
+exit_free_gpio_a:
+	gpio_free(encoder->gpio_a);
+exit_free_input:
+	input_free_device(encoder->input);
+exit_free_mem:
+	kfree(encoder);
+exit:
+	return err;
+}
+
+
+static int __devexit rotary_encoder_remove(struct platform_device *pdev)
+{
+	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
+	gpio_free(encoder->gpio_a);
+	gpio_free(encoder->gpio_b);
+	free_irq(encoder->irq_a, encoder);
+	free_irq(encoder->irq_b, encoder);
+	input_free_device(encoder->input);
+	platform_set_drvdata(pdev, NULL);
+	kfree(encoder);
+	return 0;
+}
+
+static struct platform_driver rotary_encoder_driver = {
+	.probe		= rotary_encoder_probe,
+	.remove		= __devexit_p(rotary_encoder_remove),
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	}
+};
+
+static int __init rotary_encoder_init(void)
+{
+	return platform_driver_register(&rotary_encoder_driver);
+}
+
+static void __exit rotary_encoder_exit(void)
+{
+	platform_driver_unregister(&rotary_encoder_driver);
+}
+
+module_init(rotary_encoder_init);
+module_exit(rotary_encoder_exit);
+
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DESCRIPTION("GPIO rotary encoder driver");
+MODULE_AUTHOR("Daniel Mack <daniel@caiaq.de>");
+MODULE_LICENSE("GPL v2");
+
diff --git a/include/linux/rotary-encoder.h b/include/linux/rotary-encoder.h
new file mode 100644
index 0000000..b6238ff
--- /dev/null
+++ b/include/linux/rotary-encoder.h
@@ -0,0 +1,10 @@
+#ifndef __ROTARY_ENCODER_H__
+#define __ROTARY_ENCODER_H__
+
+struct rotary_encoder_platform_data {
+	unsigned int steps;
+	unsigned int inverted_a;
+	unsigned int inverted_b;
+};
+
+#endif /* __ROTARY_ENCODER_H__ */
-- 
1.6.1.3

