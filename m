From: Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>
Subject: [PATCH v3] Add generic GPIO-tilt driver
Date: Tue, 29 Nov 2011 13:24:33 +0100
Message-ID: <201111291324.34045.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h1778886.stratoserver.net ([85.214.133.74]:46299 "EHLO
	h1778886.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752378Ab1K2MYh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Nov 2011 07:24:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Heiko =?iso-8859-1?q?St=FCbner?= <heiko@sntech.de>

There exist tilt switches that simply report their tilt-state via some gpios.

The number and orientation of their axes can vary depending on the switch
used and the build of the device. Also two or more one-axis switches
could be combined to provide multi-dimensional orientation.

One example of a device using such a switch is the family of Qisda
ebook readers, where the switch provides information about the
landscape / portrait orientation of the device. The example in
Documentation/input/gpio-tilt.txt documents exactly this one-axis device.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
changes since v2: use module_platform_driver
changes since v1: address comments from Dmitry Torokhov
* bdev -> tdev
* report initial axis state during open and not during probe
* don't clone platform data and use the original instead

 Documentation/input/gpio-tilt.txt     |  103 ++++++++++++++++
 drivers/input/misc/Kconfig            |   14 ++
 drivers/input/misc/Makefile           |    1 +
 drivers/input/misc/gpio_tilt_polled.c |  214 +++++++++++++++++++++++++++++++++
 include/linux/gpio_tilt.h             |   73 +++++++++++
 5 files changed, 405 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/input/gpio-tilt.txt
 create mode 100644 drivers/input/misc/gpio_tilt_polled.c
 create mode 100644 include/linux/gpio_tilt.h

diff --git a/Documentation/input/gpio-tilt.txt b/Documentation/input/gpio-tilt.txt
new file mode 100644
index 0000000..06d60c3
--- /dev/null
+++ b/Documentation/input/gpio-tilt.txt
@@ -0,0 +1,103 @@
+Driver for tilt-switches connected via GPIOs
+============================================
+
+Generic driver to read data from tilt switches connected via gpios.
+Orientation can be provided by one or more than one tilt switches,
+i.e. each tilt switch providing one axis, and the number of axes
+is also not limited.
+
+
+Data structures:
+----------------
+
+The array of struct gpio in the gpios field is used to list the gpios
+that represent the current tilt state.
+
+The array of struct gpio_tilt_axis describes the axes that are reported
+to the input system. The values set therein are used for the
+input_set_abs_params calls needed to init the axes.
+
+The array of struct gpio_tilt_state maps gpio states to the corresponding
+values to report. The gpio state is represented as a bitfield where the
+bit-index corresponds to the index of the gpio in the struct gpio array.
+In the same manner the values stored in the axes array correspond to
+the elements of the gpio_tilt_axis-array.
+
+
+Example:
+--------
+
+Example configuration for a single TS1003 tilt switch that rotates around
+one axis in 4 steps and emitts the current tilt via two GPIOs.
+
+static int sg060_tilt_enable(struct device *dev) {
+	/* code to enable the sensors */
+};
+
+static void sg060_tilt_disable(struct device *dev) {
+	/* code to disable the sensors */
+};
+
+static struct gpio sg060_tilt_gpios[] = {
+	{ SG060_TILT_GPIO_SENSOR1, GPIOF_IN, "tilt_sensor1" },
+	{ SG060_TILT_GPIO_SENSOR2, GPIOF_IN, "tilt_sensor2" },
+};
+
+static struct gpio_tilt_state sg060_tilt_states[] = {
+	{
+		.gpios = (0 << 1) | (0 << 0),
+		.axes = (int[]) {
+			0,
+		},
+	}, {
+		.gpios = (0 << 1) | (1 << 0),
+		.axes = (int[]) {
+			1, /* 90 degrees */
+		},
+	}, {
+		.gpios = (1 << 1) | (1 << 0),
+		.axes = (int[]) {
+			2, /* 180 degrees */
+		},
+	}, {
+		.gpios = (1 << 1) | (0 << 0),
+		.axes = (int[]) {
+			3, /* 270 degrees */
+		},
+	},
+};
+
+static struct gpio_tilt_axis sg060_tilt_axes[] = {
+	{
+		.axis = ABS_RY,
+		.min = 0,
+		.max = 3,
+		.fuzz = 0,
+		.flat = 0,
+	},
+};
+
+static struct gpio_tilt_platform_data sg060_tilt_pdata= {
+	.gpios = sg060_tilt_gpios,
+	.nr_gpios = ARRAY_SIZE(sg060_tilt_gpios),
+
+	.axes = sg060_tilt_axes,
+	.nr_axes = ARRAY_SIZE(sg060_tilt_axes),
+
+	.states = sg060_tilt_states,
+	.nr_states = ARRAY_SIZE(sg060_tilt_states),
+
+	.debounce_interval = 100,
+
+	.poll_interval = 1000,
+	.enable = sg060_tilt_enable,
+	.disable = sg060_tilt_disable,
+};
+
+static struct platform_device sg060_device_tilt = {
+	.name = "gpio-tilt-polled",
+	.id = -1,
+	.dev = {
+		.platform_data = &sg060_tilt_pdata,
+	},
+};
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 22d875f..e53b443 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -179,6 +179,20 @@ config INPUT_APANEL
 	 To compile this driver as a module, choose M here: the module will
 	 be called apanel.
 
+config INPUT_GPIO_TILT_POLLED
+	tristate "Polled GPIO tilt switch"
+	depends on GENERIC_GPIO
+	select INPUT_POLLDEV
+	help
+	  This driver implements support for tilt switches connected
+	  to GPIO pins that are not capable of generating interrupts.
+
+	  The list of gpios to use and the mapping of their states
+	  to specific angles is done via platform data.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gpio_tilt_polled.
+
 config INPUT_IXP4XX_BEEPER
 	tristate "IXP4XX Beeper support"
 	depends on ARCH_IXP4XX
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index a244fc6..90070c1 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -23,6 +23,7 @@ obj-$(CONFIG_INPUT_CMA3000_I2C)		+= cma3000_d0x_i2c.o
 obj-$(CONFIG_INPUT_COBALT_BTNS)		+= cobalt_btns.o
 obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
+obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+= gpio_tilt_polled.o
 obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
 obj-$(CONFIG_INPUT_KEYSPAN_REMOTE)	+= keyspan_remote.o
 obj-$(CONFIG_INPUT_KXTJ9)		+= kxtj9.o
diff --git a/drivers/input/misc/gpio_tilt_polled.c b/drivers/input/misc/gpio_tilt_polled.c
new file mode 100644
index 0000000..ebc3f08
--- /dev/null
+++ b/drivers/input/misc/gpio_tilt_polled.c
@@ -0,0 +1,214 @@
+/*
+ *  Driver for tilt switches connected via GPIO lines
+ *  not capable of generating interrupts
+ *
+ *  Copyright (C) 2011 Heiko Stuebner <heiko@sntech.de>
+ *
+ *  based on: /drivers/input/keyboard/gpio_keys_polled.c
+ *
+ *  Copyright (C) 2007-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2010 Nuno Goncalves <nunojpg@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/input.h>
+#include <linux/input-polldev.h>
+#include <linux/ioport.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/gpio_tilt.h>
+
+#define DRV_NAME	"gpio-tilt-polled"
+
+struct gpio_tilt_polled_dev {
+	struct input_polled_dev *poll_dev;
+	struct device *dev;
+	struct gpio_tilt_platform_data *pdata;
+
+	int last_state;
+
+	int threshold;
+	int count;
+};
+
+static void gpio_tilt_polled_poll(struct input_polled_dev *dev)
+{
+	struct gpio_tilt_polled_dev *tdev = dev->private;
+	struct gpio_tilt_platform_data *pdata = tdev->pdata;
+	struct input_dev *input = dev->input;
+	struct gpio_tilt_state *tilt_state = NULL;
+	int state, i;
+
+	if (tdev->count < tdev->threshold) {
+		tdev->count++;
+	} else {
+		state = 0;
+		for (i = 0; i < pdata->nr_gpios; i++)
+			state |= (!!gpio_get_value(pdata->gpios[i].gpio) << i);
+
+		if (state != tdev->last_state) {
+			for (i = 0; i < pdata->nr_states; i++)
+				if (pdata->states[i].gpios == state)
+					tilt_state = &pdata->states[i];
+
+			if (tilt_state) {
+				for (i = 0; i < pdata->nr_axes; i++)
+					input_report_abs(input,
+							 pdata->axes[i].axis,
+							 tilt_state->axes[i]);
+
+				input_sync(input);
+			}
+
+			tdev->count = 0;
+			tdev->last_state = state;
+		}
+	}
+}
+
+static void gpio_tilt_polled_open(struct input_polled_dev *dev)
+{
+	struct gpio_tilt_polled_dev *tdev = dev->private;
+	struct gpio_tilt_platform_data *pdata = tdev->pdata;
+
+	if (pdata->enable)
+		pdata->enable(tdev->dev);
+
+	/* report initial state of the axes */
+	tdev->last_state = -1;
+	tdev->count = tdev->threshold;
+	gpio_tilt_polled_poll(tdev->poll_dev);
+}
+
+static void gpio_tilt_polled_close(struct input_polled_dev *dev)
+{
+	struct gpio_tilt_polled_dev *tdev = dev->private;
+	struct gpio_tilt_platform_data *pdata = tdev->pdata;
+
+	if (pdata->disable)
+		pdata->disable(tdev->dev);
+}
+
+static int __devinit gpio_tilt_polled_probe(struct platform_device *pdev)
+{
+	struct gpio_tilt_platform_data *pdata = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct gpio_tilt_polled_dev *tdev;
+	struct input_polled_dev *poll_dev;
+	struct input_dev *input;
+	int error, i;
+
+	if (!pdata || !pdata->poll_interval)
+		return -EINVAL;
+
+	tdev = kzalloc(sizeof(struct gpio_tilt_polled_dev), GFP_KERNEL);
+	if (!tdev) {
+		dev_err(dev, "no memory for private data\n");
+		return -ENOMEM;
+	}
+
+	error = gpio_request_array(pdata->gpios, pdata->nr_gpios);
+	if (error) {
+		dev_err(dev,
+		   "Could not request tilt GPIOs: %d\n", error);
+		goto err_free_tdev;
+	}
+
+	poll_dev = input_allocate_polled_device();
+	if (!poll_dev) {
+		dev_err(dev, "no memory for polled device\n");
+		error = -ENOMEM;
+		goto err_free_gpios;
+	}
+
+	poll_dev->private = tdev;
+	poll_dev->poll = gpio_tilt_polled_poll;
+	poll_dev->poll_interval = pdata->poll_interval;
+	poll_dev->open = gpio_tilt_polled_open;
+	poll_dev->close = gpio_tilt_polled_close;
+
+	input = poll_dev->input;
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
+	__set_bit(EV_ABS, input->evbit);
+	for (i = 0; i < pdata->nr_axes; i++) {
+		input_set_abs_params(input, pdata->axes[i].axis,
+				     pdata->axes[i].min, pdata->axes[i].max,
+				     pdata->axes[i].fuzz, pdata->axes[i].flat);
+	}
+
+	tdev->threshold = DIV_ROUND_UP(pdata->debounce_interval,
+				       pdata->poll_interval);
+
+	tdev->poll_dev = poll_dev;
+	tdev->dev = dev;
+	tdev->pdata = pdata;
+
+	error = input_register_polled_device(poll_dev);
+	if (error) {
+		dev_err(dev, "unable to register polled device, err=%d\n",
+			error);
+		goto err_free_polldev;
+	}
+
+	platform_set_drvdata(pdev, tdev);
+
+	return 0;
+
+err_free_polldev:
+	input_free_polled_device(poll_dev);
+err_free_gpios:
+	gpio_free_array(pdata->gpios, pdata->nr_gpios);
+err_free_tdev:
+	kfree(tdev);
+
+	return error;
+}
+
+static int __devexit gpio_tilt_polled_remove(struct platform_device *pdev)
+{
+	struct gpio_tilt_polled_dev *tdev = platform_get_drvdata(pdev);
+	struct gpio_tilt_platform_data *pdata = tdev->pdata;
+
+	platform_set_drvdata(pdev, NULL);
+
+	input_unregister_polled_device(tdev->poll_dev);
+	input_free_polled_device(tdev->poll_dev);
+
+	gpio_free_array(pdata->gpios, pdata->nr_gpios);
+
+	kfree(tdev);
+
+	return 0;
+}
+
+static struct platform_driver gpio_tilt_polled_driver = {
+	.probe	= gpio_tilt_polled_probe,
+	.remove	= __devexit_p(gpio_tilt_polled_remove),
+	.driver	= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+module_platform_driver(gpio_tilt_polled_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
+MODULE_DESCRIPTION("Polled GPIO tilt driver");
+MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/gpio_tilt.h b/include/linux/gpio_tilt.h
new file mode 100644
index 0000000..809fe93
--- /dev/null
+++ b/include/linux/gpio_tilt.h
@@ -0,0 +1,73 @@
+#ifndef _GPIO_TILT_H
+#define _GPIO_TILT_H
+
+/**
+ * struct gpio_tilt_axis - Axis used by the tilt switch
+ * @axis:		Constant describing the axis, e.g. ABS_X
+ * @min:		minimum value for abs_param
+ * @max:		maximum value for abs_param
+ * @fuzz:		fuzz value for abs_param
+ * @flat:		flat value for abs_param
+ */
+struct gpio_tilt_axis {
+	int axis;
+	int min;
+	int max;
+	int fuzz;
+	int flat;
+};
+
+/**
+ * struct gpio_tilt_state - state description
+ * @gpios:		bitfield of gpio target-states for the value
+ * @axes:		array containing the axes settings for the gpio state
+ *			The array indizes must correspond to the axes defined
+ *			in platform_data
+ *
+ * This structure describes a supported axis settings
+ * and the necessary gpio-state which represent it.
+ *
+ * The n-th bit in the bitfield describes the state of the n-th GPIO
+ * from the gpios-array defined in gpio_regulator_config below.
+ */
+struct gpio_tilt_state {
+	int gpios;
+	int *axes;
+};
+
+/**
+ * struct gpio_tilt_platform_data
+ * @gpios:		Array containing the gpios determining the tilt state
+ * @nr_gpios:		Number of gpios
+ * @axes:		Array of gpio_tilt_axis descriptions
+ * @nr_axes:		Number of axes
+ * @states:		Array of gpio_tilt_state entries describing
+ *			the gpio state for specific tilts
+ * @nr_states:		Number of states available
+ * @debounce_interval:	debounce ticks interval in msecs
+ * @poll_interval:	polling interval in msecs - for polling driver only
+ * @enable:		callback to enable the tilt switch
+ * @disable:		callback to disable the tilt switch
+ *
+ * This structure contains gpio-tilt-switch configuration
+ * information that must be passed by platform code to the
+ * gpio-tilt input driver.
+ */
+struct gpio_tilt_platform_data {
+	struct gpio *gpios;
+	int nr_gpios;
+
+	struct gpio_tilt_axis *axes;
+	int nr_axes;
+
+	struct gpio_tilt_state *states;
+	int nr_states;
+
+	int debounce_interval;
+
+	unsigned int poll_interval;
+	int (*enable)(struct device *dev);
+	void (*disable)(struct device *dev);
+};
+
+#endif
-- 
1.7.5.4

