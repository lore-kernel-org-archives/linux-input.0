From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] generic driver for rotary encoders on GPIOs
Date: Wed, 4 Mar 2009 00:48:52 -0800
Message-ID: <20090304084851.GB7394@dtor-d630.eng.vmware.com>
References: <20090303090317.GA14246@dtor-d630.eng.vmware.com> <1236074367-23172-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:53783 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbZCDItE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2009 03:49:04 -0500
Received: by qw-out-2122.google.com with SMTP id 5so4779147qwi.37
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2009 00:49:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1236074367-23172-1-git-send-email-daniel@caiaq.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-input@vger.kernel.org, H Hartley Sweeten <hsweeten@visionengravers.com>

Hi Daniel,

On Tue, Mar 03, 2009 at 10:59:27AM +0100, Daniel Mack wrote:
> This patch adds a generic driver for rotary encoders connected to GPIO
> pins of a system. It relies on gpiolib and generic hardware irqs. The
> documentation that also comes with this patch explains the concept and
> how to use the driver.
> 
> Signed-off-by: Daniel Mack <daniel@caiaq.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: H Hartley Sweeten <hsweeten@visionengravers.com>
> ---
>  New version with Dmitry's change requests included:
> 
>   * calling input_free_device() in case input_register_device() fails
>   * calling input_unregister_device() in all other cases
>   * made the axis information part of the platform data
> 

I fiddled with the driver a little bit more changing formatting, please
take a look and if you are still OK with it I will apply to 'next'.

Thanks!

-- 
Dmitry


Input: generic driver for rotary encoders on GPIOs

From: Daniel Mack <daniel@caiaq.de>

This patch adds a generic driver for rotary encoders connected to GPIO
pins of a system. It relies on gpiolib and generic hardware irqs. The
documentation that also comes with this patch explains the concept and
how to use the driver.

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 Documentation/input/rotary-encoder.txt |  101 +++++++++++++++
 drivers/input/misc/Kconfig             |   11 ++
 drivers/input/misc/Makefile            |    2 
 drivers/input/misc/rotary_encoder.c    |  219 ++++++++++++++++++++++++++++++++
 include/linux/rotary_encoder.h         |   13 ++
 5 files changed, 346 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/input/rotary-encoder.txt
 create mode 100644 drivers/input/misc/rotary_encoder.c
 create mode 100644 include/linux/rotary_encoder.h


diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
new file mode 100644
index 0000000..435102a
--- /dev/null
+++ b/Documentation/input/rotary-encoder.txt
@@ -0,0 +1,101 @@
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
+#include <linux/input.h>
+#include <linux/rotary_encoder.h>
+
+#define GPIO_ROTARY_A 1
+#define GPIO_ROTARY_B 2
+
+static struct rotary_encoder_platform_data my_rotary_encoder_info = {
+	.steps		= 24,
+	.axis		= ABS_X,
+	.gpio_a		= GPIO_ROTARY_A,
+	.gpio_b		= GPIO_ROTARY_B,
+	.inverted_a	= 0,
+	.inverted_b	= 0,
+};
+
+static struct platform_device rotary_encoder_device = {
+	.name		= "rotary-encoder",
+	.id		= 0,
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
index 0000000..c9bcab4
--- /dev/null
+++ b/drivers/input/misc/rotary_encoder.c
@@ -0,0 +1,219 @@
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
+#include <linux/rotary_encoder.h>
+
+#define DRV_NAME "rotary-encoder"
+
+struct rotary_encoder {
+	unsigned int irq_a;
+	unsigned int irq_b;
+	unsigned int pos;
+	unsigned int armed;
+	unsigned int dir;
+	struct input_dev *input;
+	struct rotary_encoder_platform_data *pdata;
+};
+
+static irqreturn_t rotary_encoder_irq(int irq, void *dev_id)
+{
+	struct rotary_encoder *encoder = dev_id;
+	struct rotary_encoder_platform_data *pdata = encoder->pdata;
+	int a = !!gpio_get_value(pdata->gpio_a);
+	int b = !!gpio_get_value(pdata->gpio_b);
+	int state;
+
+	a ^= pdata->inverted_a;
+	b ^= pdata->inverted_b;
+	state = (a << 1) | b;
+
+	switch (state) {
+
+	case 0x0:
+		if (encoder->armed) {
+			if (encoder->dir) {
+				/* turning counter-clockwise */
+				encoder->pos += pdata->steps;
+				encoder->pos--;
+				encoder->pos %= pdata->steps;
+			} else {
+				/* turning clockwise */
+				encoder->pos++;
+				encoder->pos %= pdata->steps;
+			}
+			input_report_abs(encoder->input,
+					 pdata->axis, encoder->pos);
+			input_sync(encoder->input);
+			encoder->armed = 0;
+		}
+		break;
+
+	case 0x1:
+	case 0x2:
+		if (encoder->armed)
+			encoder->dir = state - 1;
+		break;
+
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
+	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
+	struct rotary_encoder *encoder;
+	struct input_dev *input;
+	int err;
+
+	if (!pdata || !pdata->steps) {
+		dev_err(&pdev->dev, "invalid platform data\n");
+		return -ENOENT;
+	}
+
+	encoder = kzalloc(sizeof(struct rotary_encoder), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!encoder || !input) {
+		dev_err(&pdev->dev, "failed to allocate memory for device\n");
+		err = -ENOMEM;
+		goto exit_free_mem;
+	}
+
+	encoder->input = input;
+	encoder->pdata = pdata;
+	encoder->irq_a = gpio_to_irq(pdata->gpio_a);
+	encoder->irq_b = gpio_to_irq(pdata->gpio_b);
+
+	/* create and register the input driver */
+	input->name = pdev->name;
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = &pdev->dev;
+	input->evbit[0] = BIT_MASK(EV_ABS);
+	input_set_abs_params(encoder->input,
+			     pdata->axis, 0, pdata->steps, 0, 1);
+
+	err = input_register_device(input);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto exit_free_mem;
+	}
+
+	/* request the GPIOs */
+	err = gpio_request(pdata->gpio_a, DRV_NAME);
+	if (err) {
+		dev_err(&pdev->dev, "unable to request GPIO %d\n",
+			pdata->gpio_a);
+		goto exit_unregister_input;
+	}
+
+	err = gpio_request(pdata->gpio_b, DRV_NAME);
+	if (err) {
+		dev_err(&pdev->dev, "unable to request GPIO %d\n",
+			pdata->gpio_b);
+		goto exit_free_gpio_a;
+	}
+
+	/* request the IRQs */
+	err = request_irq(encoder->irq_a, &rotary_encoder_irq,
+			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
+			  DRV_NAME, encoder);
+	if (err) {
+		dev_err(&pdev->dev, "unable to request IRQ %d\n",
+			encoder->irq_a);
+		goto exit_free_gpio_b;
+	}
+
+	err = request_irq(encoder->irq_b, &rotary_encoder_irq,
+			  IORESOURCE_IRQ_HIGHEDGE | IORESOURCE_IRQ_LOWEDGE,
+			  DRV_NAME, encoder);
+	if (err) {
+		dev_err(&pdev->dev, "unable to request IRQ %d\n",
+			encoder->irq_b);
+		goto exit_free_irq_a;
+	}
+
+	platform_set_drvdata(pdev, encoder);
+
+	return 0;
+
+exit_free_irq_a:
+	free_irq(encoder->irq_a, encoder);
+exit_free_gpio_b:
+	gpio_free(pdata->gpio_b);
+exit_free_gpio_a:
+	gpio_free(pdata->gpio_a);
+exit_unregister_input:
+	input_unregister_device(input);
+	input = NULL; /* so we don't try to free it */
+exit_free_mem:
+	input_free_device(input);
+	kfree(encoder);
+	return err;
+}
+
+static int __devexit rotary_encoder_remove(struct platform_device *pdev)
+{
+	struct rotary_encoder *encoder = platform_get_drvdata(pdev);
+	struct rotary_encoder_platform_data *pdata = pdev->dev.platform_data;
+
+	free_irq(encoder->irq_a, encoder);
+	free_irq(encoder->irq_b, encoder);
+	gpio_free(pdata->gpio_a);
+	gpio_free(pdata->gpio_b);
+	input_unregister_device(encoder->input);
+	platform_set_drvdata(pdev, NULL);
+	kfree(encoder);
+
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
diff --git a/include/linux/rotary_encoder.h b/include/linux/rotary_encoder.h
new file mode 100644
index 0000000..12d63a3
--- /dev/null
+++ b/include/linux/rotary_encoder.h
@@ -0,0 +1,13 @@
+#ifndef __ROTARY_ENCODER_H__
+#define __ROTARY_ENCODER_H__
+
+struct rotary_encoder_platform_data {
+	unsigned int steps;
+	unsigned int axis;
+	unsigned int gpio_a;
+	unsigned int gpio_b;
+	unsigned int inverted_a;
+	unsigned int inverted_b;
+};
+
+#endif /* __ROTARY_ENCODER_H__ */
