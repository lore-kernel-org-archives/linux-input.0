From: Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com>
Subject: [PATCH 1/1] gpio_mouse driver
Date: Tue, 29 May 2007 15:07:26 +0200
Message-ID: <1180444046354-git-send-email-hcegtvedt@norway.atmel.com>
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: Hans-Christian Egtvedt <hcegtvedt@norway.atmel.com>, Hans-Christian Egtvedt <hcegtvedt@atmel.com>
List-Id: linux-input@vger.kernel.org

This patch adds support for simulating a mouse using GPIO lines.

The driver needs a platform_data struct to be defined and registered with the
appropriate platform_device.

The driver has been tested on AT32AP7000 microprocessor using the ATSTK1000
development board.

Signed-off-by: Hans-Christian Egtvedt <hcegtvedt@atmel.com>
---
 drivers/input/mouse/Kconfig      |   15 ++
 drivers/input/mouse/Makefile     |    1 +
 drivers/input/mouse/gpio_mouse.c |  281 ++++++++++++++++++++++++++++++++++++++
 include/linux/gpio_mouse.h       |   53 +++++++
 4 files changed, 350 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/Kconfig b/drivers/input/mouse/Kconfig
index 35d998c..a3c7057 100644
--- a/drivers/input/mouse/Kconfig
+++ b/drivers/input/mouse/Kconfig
@@ -125,4 +125,19 @@ config MOUSE_HIL
 	help
 	  Say Y here to support HIL pointers.
 
+config MOUSE_GPIO
+	tristate "GPIO mouse"
+	depends on GENERIC_GPIO
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
diff --git a/drivers/input/mouse/Makefile b/drivers/input/mouse/Makefile
index 21a1de6..5d0fc43 100644
--- a/drivers/input/mouse/Makefile
+++ b/drivers/input/mouse/Makefile
@@ -13,5 +13,6 @@ obj-$(CONFIG_MOUSE_PS2)		+= psmouse.o
 obj-$(CONFIG_MOUSE_SERIAL)	+= sermouse.o
 obj-$(CONFIG_MOUSE_HIL)		+= hil_ptr.o
 obj-$(CONFIG_MOUSE_VSXXXAA)	+= vsxxxaa.o
+obj-$(CONFIG_MOUSE_GPIO)	+= gpio_mouse.o
 
 psmouse-objs  := psmouse-base.o alps.o logips2pp.o synaptics.o lifebook.o trackpoint.o
diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
new file mode 100644
index 0000000..7a95185
--- /dev/null
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -0,0 +1,281 @@
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
+#include <linux/timer.h>
+#include <linux/jiffies.h>
+#include <linux/platform_device.h>
+#include <linux/input.h>
+#include <linux/gpio_mouse.h>
+
+#include <asm/gpio.h>
+
+/*
+ * Timer function which is run every scan_ms ms when the device is opened. The
+ * dev input varaible is set to the the input_dev pointer.
+ */
+static void gpio_mouse_scan(unsigned long _dev)
+{
+	struct input_dev *input = (struct input_dev *)_dev;
+	struct gpio_mouse_platform_data *gpio = input->private;
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
+
+	mod_timer(&gpio->timer, jiffies + msecs_to_jiffies(gpio->scan_ms));
+}
+
+/* Only start the timer when the device is actually in use, i.e. opened. */
+static int gpio_mouse_open(struct input_dev *input)
+{
+	struct gpio_mouse_platform_data *gpio = input->private;
+	gpio->timer.expires = jiffies + msecs_to_jiffies(gpio->scan_ms);
+	gpio->timer.data = (unsigned long)input;
+	add_timer(&gpio->timer);
+	return 0;
+}
+
+static void gpio_mouse_close(struct input_dev *input)
+{
+	struct gpio_mouse_platform_data *gpio = input->private;
+	del_timer_sync(&gpio->timer);
+}
+
+static int __init gpio_mouse_probe(struct platform_device *pdev)
+{
+	struct gpio_mouse_platform_data *pdata = pdev->dev.platform_data;
+	struct input_dev *input;
+	int ret;
+
+	if (!pdata) {
+		dev_dbg(&pdev->dev, "no platform data\n");
+		ret = -ENXIO;
+		goto out;
+	}
+
+	if (pdata->up < 0 || pdata->down < 0 || pdata->right < 0
+			|| pdata->left < 0) {
+		dev_dbg(&pdev->dev, "missing GPIO for directions\n");
+		ret = -EINVAL;
+		goto out;
+	}
+	if (pdata->scan_ms < 0) {
+		dev_dbg(&pdev->dev, "invalid scan time\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Mouse direction, required. */
+	ret = gpio_request(pdata->up, "gpio_mouse_up");
+	if (ret) {
+		dev_dbg(&pdev->dev, "fail up pin\n");
+		goto out_gpio_up;
+	}
+	ret = gpio_request(pdata->down, "gpio_mouse_down");
+	if (ret) {
+		dev_dbg(&pdev->dev, "fail down pin\n");
+		goto out_gpio_down;
+	}
+	ret = gpio_request(pdata->left, "gpio_mouse_left");
+	if (ret) {
+		dev_dbg(&pdev->dev, "fail left pin\n");
+		goto out_gpio_left;
+	}
+	ret = gpio_request(pdata->right, "gpio_mouse_right");
+	if (ret) {
+		dev_dbg(&pdev->dev, "fail right pin\n");
+		goto out_gpio_right;
+	}
+
+	gpio_direction_input(pdata->up);
+	gpio_direction_input(pdata->down);
+	gpio_direction_input(pdata->left);
+	gpio_direction_input(pdata->right);
+
+	/* Mouse buttons, not required, but should at least have bleft. */
+	if (pdata->bleft >= 0) {
+		ret = gpio_request(pdata->bleft, "gpio_mouse_bleft");
+		if (ret) {
+			dev_dbg(&pdev->dev, "fail bleft pin\n");
+			goto out_gpio_bleft;
+		}
+		gpio_direction_input(pdata->bleft);
+	} else {
+		dev_dbg(&pdev->dev, "no left button defined\n");
+	}
+	if (pdata->bmiddle >= 0) {
+		ret = gpio_request(pdata->bmiddle, "gpio_mouse_bmiddle");
+		if (ret) {
+			dev_dbg(&pdev->dev, "fail bmiddle pin\n");
+			goto out_gpio_bmiddle;
+		}
+		gpio_direction_input(pdata->bmiddle);
+	}
+	if (pdata->bright >= 0) {
+		ret = gpio_request(pdata->bright, "gpio_mouse_bright");
+		if (ret) {
+			dev_dbg(&pdev->dev, "fail bright pin\n");
+			goto out_gpio_bright;
+		}
+		gpio_direction_input(pdata->bright);
+	}
+
+	input = input_allocate_device();
+	if (!input) {
+		dev_dbg(&pdev->dev, "not enough memory for input device\n");
+		ret = -ENOMEM;
+		goto out_input_allocate;
+	}
+
+	platform_set_drvdata(pdev, input);
+
+	input->name = pdev->name;
+	input->cdev.dev = &pdev->dev;
+	input->private = pdata;
+
+	/*
+	 * Revisit: is bustype, vendor, product and version needed to
+	 * input->id? And if they should be present, what values should they
+	 * have?
+	 */
+
+	input->evbit[0] = BIT(EV_REL);
+	if (pdata->bleft >= 0 || pdata->bmiddle >= 0 || pdata->bright >= 0) {
+		input->evbit[0] |= BIT(EV_KEY);
+
+		if (pdata->bleft >= 0)
+			input->keybit[LONG(BTN_MOUSE)] = BIT(BTN_LEFT);
+		if (pdata->bmiddle >= 0)
+			input->keybit[LONG(BTN_MOUSE)] |= BIT(BTN_MIDDLE);
+		if (pdata->bright >= 0)
+			input->keybit[LONG(BTN_MOUSE)] |= BIT(BTN_RIGHT);
+	}
+	input->relbit[0] = BIT(REL_X) | BIT(REL_Y);
+
+	input->open = gpio_mouse_open;
+	input->close = gpio_mouse_close;
+
+	/* Init the scan timer. */
+	pdata->timer.function = gpio_mouse_scan;
+	pdata->timer.base = &boot_tvec_bases;
+
+	ret = input_register_device(input);
+	if (ret) {
+		dev_dbg(&pdev->dev, "could not register input device\n");
+		goto out_reg_dev;
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
+out_reg_dev:
+	input_free_device(input);
+	platform_set_drvdata(pdev, NULL);
+out_input_allocate:
+	if (pdata->bright >= 0)
+		gpio_free(pdata->bright);
+out_gpio_bright:
+	if (pdata->bmiddle >= 0)
+		gpio_free(pdata->bmiddle);
+out_gpio_bmiddle:
+	if (pdata->bleft >= 0)
+		gpio_free(pdata->bleft);
+out_gpio_bleft:
+	if (pdata->right >= 0)
+		gpio_free(pdata->right);
+out_gpio_right:
+	if (pdata->left >= 0)
+		gpio_free(pdata->left);
+out_gpio_left:
+	if (pdata->down >= 0)
+		gpio_free(pdata->down);
+out_gpio_down:
+	if (pdata->up >= 0)
+		gpio_free(pdata->up);
+out_gpio_up:
+out:
+	return ret;
+}
+
+static int __exit gpio_mouse_remove(struct platform_device *pdev)
+{
+	struct gpio_mouse_platform_data *pdata = pdev->dev.platform_data;
+	struct input_dev *input = platform_get_drvdata(pdev);
+
+	if (input)
+		input_unregister_device(input);
+
+	if (pdata->up >= 0)
+		gpio_free(pdata->up);
+	if (pdata->down >= 0)
+		gpio_free(pdata->down);
+	if (pdata->left >= 0)
+		gpio_free(pdata->left);
+	if (pdata->right >= 0)
+		gpio_free(pdata->right);
+	if (pdata->bleft >= 0)
+		gpio_free(pdata->bleft);
+	if (pdata->bmiddle >= 0)
+		gpio_free(pdata->bmiddle);
+	if (pdata->bright >= 0)
+		gpio_free(pdata->bright);
+
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+struct platform_driver gpio_mouse_device_driver = {
+	.remove		= __exit_p(gpio_mouse_remove),
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
diff --git a/include/linux/gpio_mouse.h b/include/linux/gpio_mouse.h
new file mode 100644
index 0000000..8b01950
--- /dev/null
+++ b/include/linux/gpio_mouse.h
@@ -0,0 +1,53 @@
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
+#include <linux/timer.h>
+
+#define GPIO_MOUSE_POLARITY_ACT_HIGH	0x00
+#define GPIO_MOUSE_POLARITY_ACT_LOW	0x01
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
+ * @bright: GPIO line for right button.
+ * @bmiddle: GPIO line for middle button.
+ * @timer: placeholder for struct timer_list initialized in the driver.
+ *
+ * This struct must be added to the platform_device in the board code. It is
+ * used by the gpio_mouse driver to setup GPIO lines, calculate mouse movement
+ * and have a reference to the timer used for scanning.
+ */
+struct gpio_mouse_platform_data {
+	int scan_ms;
+	int polarity;
+
+	int up;
+	int down;
+	int left;
+	int right;
+
+	int bleft;
+	int bmiddle;
+	int bright;
+
+	/* private */
+	struct timer_list timer;
+};
+
+#endif /* _GPIO_MOUSE_H */
-- 
1.4.4.2
