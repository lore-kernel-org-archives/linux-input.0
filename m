From: Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [PATCH 1/1] gpio_mouse driver (rewritten to GIT kernel)
Date: Sat, 2 Jun 2007 00:24:59 -0400
Message-ID: <200706020025.00738.dtor@insightbb.com>
References: <11806115231841-git-send-email-hcegtvedt@norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <11806115231841-git-send-email-hcegtvedt@norway.atmel.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: linux-input@vger.kernel.org

Hi,

On Thursday 31 May 2007 07:38, Hans-Christian Egtvedt wrote:
> This patch adds support for simulating a mouse using GPIO lines.
> 

Thank you for updating the patch. It looks much better now, I see only
couple of issues:

> +
> +	if (!pdata) {
> +		dev_dbg(&pdev->dev, "no platform data\n");
> +		ret = -ENXIO;

I think -EINVAL suits here better.

> +
> +	/* Mouse direction, required. */
> +	ret = gpio_request(pdata->up, "gpio_mouse_up");
> +	if (ret) {
> +		dev_dbg(&pdev->dev, "fail up pin\n");
> +		goto out_gpio_up;
> +	}

Repeated gpio requests could be folded together.

> +
> +	if (input)
> +		input_unregister_polled_device(input);

You also need input_free_polled_device(). This is different from regular
input devices becase polled device is not refcounted (but corresponding
input device is).

> +
> +struct platform_driver gpio_mouse_device_driver = {
> +	.remove		= __exit_p(gpio_mouse_remove),

I think gpio_mouse_remove shoudl be __devexit so unbinding via sysfs still
works.

I tried implementing my suggestions, the result is the patch below. Please
take a look at it and if you agree with it (and it still works) I will
apply it. Thank you!

-- 
Dmitry

From: Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com>

Input: add gpio-mouse driver

Adds support for simulating a mouse using GPIO lines. The driver
needs an appropriate platform device to be created by architecture
code.

The driver has been tested on AT32AP7000 microprocessor using the
ATSTK1000 development board.

Signed-off-by: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/mouse/Kconfig      |   17 +++
 drivers/input/mouse/Makefile     |    1 
 drivers/input/mouse/gpio_mouse.c |  196 +++++++++++++++++++++++++++++++++++++++
 include/linux/gpio_mouse.h       |   61 ++++++++++++
 4 files changed, 275 insertions(+)

Index: work/drivers/input/mouse/Kconfig
===================================================================
--- work.orig/drivers/input/mouse/Kconfig
+++ work/drivers/input/mouse/Kconfig
@@ -216,4 +216,21 @@ config MOUSE_HIL
 	help
 	  Say Y here to support HIL pointers.
 
+config MOUSE_GPIO
+	tristate "GPIO mouse"
+	depends on GENERIC_GPIO
+	select INPUT_MISC
+	select INPUT_POLLDEV
+	help
+	  This driver simulates a mouse on GPIO lines of various CPUs (and some
+	  other chips).
+
+	  Say Y here if your device has buttons or a simple joystick connected
+	  directly to GPIO lines. Your board-specific setup logic must also
+	  provide a platform device and platform data saying which GPIOs are
+	  used.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gpio_mouse.
+
 endif
Index: work/drivers/input/mouse/Makefile
===================================================================
--- work.orig/drivers/input/mouse/Makefile
+++ work/drivers/input/mouse/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
+obj-$(CONFIG_MOUSE_GPIO)	+= gpio_mouse.o
 
 psmouse-objs := psmouse-base.o synaptics.o
 
Index: work/drivers/input/mouse/gpio_mouse.c
===================================================================
--- /dev/null
+++ work/drivers/input/mouse/gpio_mouse.c
@@ -0,0 +1,196 @@
+/*
+ * Driver for simulating a mouse on GPIO lines.
+ *
+ * Copyright (C) 2007 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/input-polldev.h>
+#include <linux/gpio_mouse.h>
+
+#include <asm/gpio.h>
+
+/*
+ * Timer function which is run every scan_ms ms when the device is opened.
+ * The dev input varaible is set to the the input_dev pointer.
+ */
+static void gpio_mouse_scan(struct input_polled_dev *dev)
+{
+	struct gpio_mouse_platform_data *gpio = dev->private;
+	struct input_dev *input = dev->input;
+	int x, y;
+
+	if (gpio->bleft >= 0)
+		input_report_key(input, BTN_LEFT,
+				gpio_get_value(gpio->bleft) ^ gpio->polarity);
+	if (gpio->bmiddle >= 0)
+		input_report_key(input, BTN_MIDDLE,
+				gpio_get_value(gpio->bmiddle) ^ gpio->polarity);
+	if (gpio->bright >= 0)
+		input_report_key(input, BTN_RIGHT,
+				gpio_get_value(gpio->bright) ^ gpio->polarity);
+
+	x = (gpio_get_value(gpio->right) ^ gpio->polarity)
+		- (gpio_get_value(gpio->left) ^ gpio->polarity);
+	y = (gpio_get_value(gpio->down) ^ gpio->polarity)
+		- (gpio_get_value(gpio->up) ^ gpio->polarity);
+
+	input_report_rel(input, REL_X, x);
+	input_report_rel(input, REL_Y, y);
+	input_sync(input);
+}
+
+static int __init gpio_mouse_probe(struct platform_device *pdev)
+{
+	struct gpio_mouse_platform_data *pdata = pdev->dev.platform_data;
+	struct input_polled_dev *input_poll;
+	struct input_dev *input;
+	int pin, i;
+	int error;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "no platform data\n");
+		error = -ENXIO;
+		goto out;
+	}
+
+	if (pdata->scan_ms < 0) {
+		dev_err(&pdev->dev, "invalid scan time\n");
+		error = -EINVAL;
+		goto out;
+	}
+
+	for (i = 0; i < GPIO_MOUSE_PIN_MAX; i++) {
+		pin = pdata->pins[i];
+
+		if (pin < 0) {
+
+			if (i <= GPIO_MOUSE_PIN_RIGHT) {
+				/* Mouse direction is required. */
+				dev_err(&pdev->dev,
+					"missing GPIO for directions\n");
+				error = -EINVAL;
+				goto out_free_gpios;
+			}
+
+			if (i == GPIO_MOUSE_PIN_BLEFT)
+				dev_dbg(&pdev->dev, "no left button defined\n");
+
+		} else {
+			error = gpio_request(pin, "gpio_mouse");
+			if (error) {
+				dev_err(&pdev->dev, "fail %d pin (%d idx)\n",
+					pin, i);
+				goto out_free_gpios;
+			}
+
+			gpio_direction_input(pin);
+		}
+	}
+
+	input_poll = input_allocate_polled_device();
+	if (!input_poll) {
+		dev_err(&pdev->dev, "not enough memory for input device\n");
+		error = -ENOMEM;
+		goto out_free_gpios;
+	}
+
+	platform_set_drvdata(pdev, input_poll);
+
+	/* set input-polldev handlers */
+	input_poll->private = pdata;
+	input_poll->poll = gpio_mouse_scan;
+	input_poll->poll_interval = pdata->scan_ms;
+
+	input = input_poll->input;
+	input->name = pdev->name;
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = &pdev->dev;
+
+	input_set_capability(input, EV_REL, REL_X);
+	input_set_capability(input, EV_REL, REL_Y);
+	if (pdata->bleft >= 0)
+		input_set_capability(input, EV_KEY, BTN_LEFT);
+	if (pdata->bmiddle >= 0)
+		input_set_capability(input, EV_KEY, BTN_MIDDLE);
+	if (pdata->bright >= 0)
+		input_set_capability(input, EV_KEY, BTN_RIGHT);
+
+	error = input_register_polled_device(input_poll);
+	if (error) {
+		dev_err(&pdev->dev, "could not register input device\n");
+		goto out_free_polldev;
+	}
+
+	dev_dbg(&pdev->dev, "%d ms scan time, buttons: %s%s%s\n",
+			pdata->scan_ms,
+			pdata->bleft < 0 ? "" : "left ",
+			pdata->bmiddle < 0 ? "" : "middle ",
+			pdata->bright < 0 ? "" : "right");
+
+	return 0;
+
+ out_free_polldev:
+	input_free_polled_device(input_poll);
+	platform_set_drvdata(pdev, NULL);
+
+ out_free_gpios:
+	while (--i >= 0) {
+		pin = pdata->pins[i];
+		if (pin)
+			gpio_free(pin);
+	}
+ out:
+	return error;
+}
+
+static int __devexit gpio_mouse_remove(struct platform_device *pdev)
+{
+	struct input_polled_dev *input = platform_get_drvdata(pdev);
+	struct gpio_mouse_platform_data *pdata = input->private;
+	int pin, i;
+
+	input_unregister_polled_device(input);
+	input_free_polled_device(input);
+
+	for (i = 0; i < GPIO_MOUSE_PIN_MAX; i++) {
+		pin = pdata->pins[i];
+		if (pin >= 0)
+			gpio_free(pin);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+struct platform_driver gpio_mouse_device_driver = {
+	.remove		= __devexit_p(gpio_mouse_remove),
+	.driver		= {
+		.name	= "gpio_mouse",
+	}
+};
+
+static int __init gpio_mouse_init(void)
+{
+	return platform_driver_probe(&gpio_mouse_device_driver,
+			gpio_mouse_probe);
+}
+module_init(gpio_mouse_init);
+
+static void __exit gpio_mouse_exit(void)
+{
+	platform_driver_unregister(&gpio_mouse_device_driver);
+}
+module_exit(gpio_mouse_exit);
+
+MODULE_AUTHOR("Hans-Christian Egtvedt <hcegtvedt@atmel.com>");
+MODULE_DESCRIPTION("GPIO mouse driver");
+MODULE_LICENSE("GPL");
Index: work/include/linux/gpio_mouse.h
===================================================================
--- /dev/null
+++ work/include/linux/gpio_mouse.h
@@ -0,0 +1,61 @@
+/*
+ * Driver for simulating a mouse on GPIO lines.
+ *
+ * Copyright (C) 2007 Atmel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _GPIO_MOUSE_H
+#define _GPIO_MOUSE_H
+
+#define GPIO_MOUSE_POLARITY_ACT_HIGH	0x00
+#define GPIO_MOUSE_POLARITY_ACT_LOW	0x01
+
+#define GPIO_MOUSE_PIN_UP	0
+#define GPIO_MOUSE_PIN_DOWN	1
+#define GPIO_MOUSE_PIN_LEFT	2
+#define GPIO_MOUSE_PIN_RIGHT	3
+#define GPIO_MOUSE_PIN_BLEFT	4
+#define GPIO_MOUSE_PIN_BMIDDLE	5
+#define GPIO_MOUSE_PIN_BRIGHT	6
+#define GPIO_MOUSE_PIN_MAX	7
+
+/**
+ * struct gpio_mouse_platform_data
+ * @scan_ms: integer in ms specifying the scan periode.
+ * @polarity: Pin polarity, active high or low.
+ * @up: GPIO line for up value.
+ * @down: GPIO line for down value.
+ * @left: GPIO line for left value.
+ * @right: GPIO line for right value.
+ * @bleft: GPIO line for left button.
+ * @bmiddle: GPIO line for middle button.
+ * @bright: GPIO line for right button.
+ *
+ * This struct must be added to the platform_device in the board code.
+ * It is used by the gpio_mouse driver to setup GPIO lines and to
+ * calculate mouse movement.
+ */
+struct gpio_mouse_platform_data {
+	int scan_ms;
+	int polarity;
+
+	union {
+		struct {
+			int up;
+			int down;
+			int left;
+			int right;
+
+			int bleft;
+			int bmiddle;
+			int bright;
+		};
+		int pins[GPIO_MOUSE_PIN_MAX];
+	};
+};
+
+#endif /* _GPIO_MOUSE_H */
