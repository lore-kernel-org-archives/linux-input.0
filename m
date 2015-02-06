From: Hans Holmberg <hans.holmberg@intel.com>
Subject: [PATCH 2/2] input: gpio-joy - GPIO joystick driver
Date: Fri,  6 Feb 2015 10:32:02 +0100
Message-ID: <1423215122-19947-3-git-send-email-hans.holmberg@intel.com>
References: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:44705 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755103AbbBFJ36 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Feb 2015 04:29:58 -0500
In-Reply-To: <1423215122-19947-1-git-send-email-hans.holmberg@intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, Hans Holmberg <hans.holmberg@intel.com>

This is an interrupt-driven driver for digital joysticks
connected to GPIOs. Supports any digital joystick with
signals for up, down, left, right and one signal for
trigger button press, i.e. C64/Atari joysticks.

Signed-off-by: Hans Holmberg <hans.holmberg@intel.com>
---
 drivers/input/joystick/Kconfig    |  10 ++
 drivers/input/joystick/Makefile   |   1 +
 drivers/input/joystick/gpio_joy.c | 208 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)
 create mode 100644 drivers/input/joystick/gpio_joy.c

diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kconfig
index 56eb471..de0220e 100644
--- a/drivers/input/joystick/Kconfig
+++ b/drivers/input/joystick/Kconfig
@@ -70,6 +70,16 @@ config JOYSTICK_GF2K
 	  To compile this driver as a module, choose M here: the
 	  module will be called gf2k.
 
+config JOYSTICK_GPIO
+	tristate "Joysticks connected to GPIOs"
+	depends on GPIOLIB
+	help
+	 Say Y here if you have one or more joysticks connected to your
+	 device directly via GPIOs.
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called gpio_joy.
+
 config JOYSTICK_GRIP
 	tristate "Gravis GrIP joysticks and gamepads"
 	select GAMEPORT
diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/Makefile
index 92dc0de..c20a51a 100644
--- a/drivers/input/joystick/Makefile
+++ b/drivers/input/joystick/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_JOYSTICK_COBRA)		+= cobra.o
 obj-$(CONFIG_JOYSTICK_DB9)		+= db9.o
 obj-$(CONFIG_JOYSTICK_GAMECON)		+= gamecon.o
 obj-$(CONFIG_JOYSTICK_GF2K)		+= gf2k.o
+obj-$(CONFIG_JOYSTICK_GPIO)		+= gpio_joy.o
 obj-$(CONFIG_JOYSTICK_GRIP)		+= grip.o
 obj-$(CONFIG_JOYSTICK_GRIP_MP)		+= grip_mp.o
 obj-$(CONFIG_JOYSTICK_GUILLEMOT)	+= guillemot.o
diff --git a/drivers/input/joystick/gpio_joy.c b/drivers/input/joystick/gpio_joy.c
new file mode 100644
index 0000000..d0e22b3
--- /dev/null
+++ b/drivers/input/joystick/gpio_joy.c
@@ -0,0 +1,208 @@
+/*
+ * Driver for digital joysticks connected using GPIOs
+ *
+ * Copyright (C) 2015, Intel Corporation
+ * Author: Hans Holmberg  <hans.holmberg@intel.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/gpio/consumer.h>
+#include <linux/workqueue.h>
+#include <linux/kernel.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/timer.h>
+#include <linux/jiffies.h>
+#include <linux/input.h>
+#include <linux/property.h>
+
+#define DRV_NAME "gpio-joy"
+#define DEFAULT_DEBOUNCE_MS 10
+
+enum control_pin_indices {
+	LEFT,
+	RIGHT,
+	UP,
+	DOWN,
+	BUTTON,
+	NUM_CONTROL_PINS,
+};
+
+static const char *gpio_ids[NUM_CONTROL_PINS] = {
+	"left", "right", "up", "down", "button"};
+
+struct control_pin {
+	struct gpio_desc *gpio;
+	int irq;
+};
+
+struct gpio_joy_drvdata {
+	struct input_dev *input;
+	struct delayed_work work;
+	unsigned long debounce_jiffies;
+	struct control_pin control_pins[NUM_CONTROL_PINS];
+};
+
+static void gpio_joy_report_state(struct gpio_joy_drvdata *ddata)
+{
+	struct input_dev *input = ddata->input;
+
+	input_report_abs(input, ABS_X,
+		gpiod_get_value_cansleep(ddata->control_pins[RIGHT].gpio) -
+		gpiod_get_value_cansleep(ddata->control_pins[LEFT].gpio));
+
+	input_report_abs(input, ABS_Y,
+		gpiod_get_value_cansleep(ddata->control_pins[DOWN].gpio) -
+		gpiod_get_value_cansleep(ddata->control_pins[UP].gpio));
+
+	input_report_key(input, BTN_TRIGGER,
+		gpiod_get_value_cansleep(ddata->control_pins[BUTTON].gpio));
+
+	input_sync(input);
+}
+
+static void gpio_joy_work(struct work_struct *work)
+{
+	struct delayed_work *delayed_work =
+		container_of(work, struct delayed_work, work);
+	struct gpio_joy_drvdata *ddata =
+		container_of(delayed_work, struct gpio_joy_drvdata, work);
+
+	gpio_joy_report_state(ddata);
+}
+
+static irqreturn_t gpio_joy_isr(int irq, void *dev_id)
+{
+	struct gpio_joy_drvdata *ddata = dev_id;
+
+	mod_delayed_work(system_wq, &ddata->work, ddata->debounce_jiffies);
+
+	return IRQ_HANDLED;
+}
+
+static void gpio_joy_quiesce(void *data)
+{
+	struct gpio_joy_drvdata *ddata = data;
+
+	cancel_delayed_work_sync(&ddata->work);
+}
+
+static int gpio_joy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct input_dev *input;
+	struct gpio_joy_drvdata *ddata;
+	int i, err;
+	unsigned int debounce_ms;
+
+	ddata = devm_kzalloc(dev, sizeof(struct gpio_joy_drvdata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	ddata->input = input;
+	platform_set_drvdata(pdev, ddata);
+
+	input->name = pdev->name;
+	input->phys = DRV_NAME"/input0";
+	input->dev.parent = &pdev->dev;
+
+	input->id.bustype = BUS_HOST;
+	input->id.vendor = 0x0001;
+	input->id.product = 0x0001;
+	input->id.version = 0x0100;
+
+	set_bit(EV_KEY, input->evbit);
+	set_bit(EV_ABS, input->evbit);
+	set_bit(BTN_TRIGGER, input->keybit);
+
+	input_set_abs_params(input, ABS_X, -1, 1, 0, 0);
+	input_set_abs_params(input, ABS_Y, -1, 1, 0, 0);
+
+	/* debounce interval is optional */
+	if (device_property_read_u32(dev, "debounce-interval-ms", &debounce_ms))
+		debounce_ms = DEFAULT_DEBOUNCE_MS;
+	ddata->debounce_jiffies = msecs_to_jiffies(debounce_ms);
+
+	for (i = 0; i < ARRAY_SIZE(ddata->control_pins) ; i++) {
+		struct gpio_desc *gpio;
+		int irq;
+
+		gpio = devm_gpiod_get(&pdev->dev,
+				gpio_ids[i]);
+		if (IS_ERR(gpio)) {
+			dev_err(dev, "unable to allocate gpio: %s\n",
+					gpio_ids[i]);
+			err = PTR_ERR(gpio);
+			goto fail;
+		}
+		ddata->control_pins[i].gpio = gpio;
+
+		irq = gpiod_to_irq(gpio);
+		if (irq < 0) {
+			dev_err(dev, "unable to get irq for gpio: %s\n",
+					gpio_ids[i]);
+			err = irq;
+			goto fail;
+		}
+		ddata->control_pins[i].irq = irq;
+	}
+
+	INIT_DELAYED_WORK(&ddata->work, gpio_joy_work);
+	err = devm_add_action(dev, gpio_joy_quiesce, ddata);
+
+	for (i = 0; i < ARRAY_SIZE(ddata->control_pins) ; i++) {
+		err = devm_request_any_context_irq(dev,
+				ddata->control_pins[i].irq,
+				gpio_joy_isr,
+				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING |
+				IRQF_ONESHOT,
+				input->name, ddata);
+
+		if (err < 0) {
+			dev_err(dev, "unable to claim irq %d\n",
+				ddata->control_pins[i].irq);
+			goto fail;
+		}
+	}
+
+	err = input_register_device(input);
+	if (err) {
+		dev_err(dev, "unable to register input device\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	return err;
+}
+
+static const struct of_device_id gpio_joy_of_match[] = {
+	{ .compatible = DRV_NAME, },
+	{ },
+};
+
+static struct platform_driver gpio_joy_driver = {
+	.probe		= gpio_joy_probe,
+	.driver		= {
+		.name	= DRV_NAME,
+		.of_match_table = gpio_joy_of_match,
+	}
+};
+
+module_platform_driver(gpio_joy_driver);
+
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Hans Holmberg <hans.holmberg@intel.com>");
+MODULE_DESCRIPTION("Driver for digital joysticks connected via GPIOs");
-- 
1.9.1

