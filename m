From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] Input: misc: gpio_tilt: Delete driver
Date: Wed, 27 Dec 2017 13:15:47 +0100
Message-ID: <20171227121547.20558-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wr0-f173.google.com ([209.85.128.173]:45339 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751935AbdL0MP5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 27 Dec 2017 07:15:57 -0500
Received: by mail-wr0-f173.google.com with SMTP id o15so4407105wrf.12
        for <linux-input@vger.kernel.org>; Wed, 27 Dec 2017 04:15:56 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>

This driver was merged in 2011 as a tool for detecting the orientation
of a screen. The device driver assumes board file setup using the
platform data from <linux/input/gpio_tilt.h>. But no boards in the
kernel tree defines this platform data.

As I am faced with refactoring drivers to use GPIO descriptors and
pass decriptor tables from boards, or use the device tree device
drivers like these creates a serious problem: I cannot fix them and
cannot test them, not even compile-test them with a system actually
using it (no in-tree boardfile).

I suggest to delete this driver and rewrite it using device tree if
it is still in use on actively maintained systems.

I can also offer to rewrite it out of the blue using device tree if
someone promise to test it and help me iterate it.

Cc: Heiko Stübner <heiko@sntech.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Heiko: not meaning to be militant here, just contain the situation,
as stated: if you like the driver and can test it, I can reimplement
it from scratch using device tree.
---
 Documentation/gpio/drivers-on-gpio.txt    |   5 -
 Documentation/input/devices/gpio-tilt.rst | 103 ---------------
 drivers/input/misc/Kconfig                |  14 --
 drivers/input/misc/Makefile               |   1 -
 drivers/input/misc/gpio_tilt_polled.c     | 210 ------------------------------
 include/linux/input/gpio_tilt.h           |  74 -----------
 6 files changed, 407 deletions(-)
 delete mode 100644 Documentation/input/devices/gpio-tilt.rst
 delete mode 100644 drivers/input/misc/gpio_tilt_polled.c
 delete mode 100644 include/linux/input/gpio_tilt.h

diff --git a/Documentation/gpio/drivers-on-gpio.txt b/Documentation/gpio/drivers-on-gpio.txt
index 9a78d385b92e..a2ccbab12eb7 100644
--- a/Documentation/gpio/drivers-on-gpio.txt
+++ b/Documentation/gpio/drivers-on-gpio.txt
@@ -28,11 +28,6 @@ hardware descriptions such as device tree or ACPI:
 - gpio-beeper: drivers/input/misc/gpio-beeper.c is used to provide a beep from
   an external speaker connected to a GPIO line.
 
-- gpio-tilt-polled: drivers/input/misc/gpio_tilt_polled.c provides tilt
-  detection switches using GPIO, which is useful for your homebrewn pinball
-  machine if for nothing else. It can detect different tilt angles of the
-  monitored object.
-
 - extcon-gpio: drivers/extcon/extcon-gpio.c is used when you need to read an
   external connector status, such as a headset line for an audio driver or an
   HDMI connector. It will provide a better userspace sysfs interface than GPIO.
diff --git a/Documentation/input/devices/gpio-tilt.rst b/Documentation/input/devices/gpio-tilt.rst
deleted file mode 100644
index fa6e64570aa7..000000000000
--- a/Documentation/input/devices/gpio-tilt.rst
+++ /dev/null
@@ -1,103 +0,0 @@
-Driver for tilt-switches connected via GPIOs
-============================================
-
-Generic driver to read data from tilt switches connected via gpios.
-Orientation can be provided by one or more than one tilt switches,
-i.e. each tilt switch providing one axis, and the number of axes
-is also not limited.
-
-
-Data structures
----------------
-
-The array of struct gpio in the gpios field is used to list the gpios
-that represent the current tilt state.
-
-The array of struct gpio_tilt_axis describes the axes that are reported
-to the input system. The values set therein are used for the
-input_set_abs_params calls needed to init the axes.
-
-The array of struct gpio_tilt_state maps gpio states to the corresponding
-values to report. The gpio state is represented as a bitfield where the
-bit-index corresponds to the index of the gpio in the struct gpio array.
-In the same manner the values stored in the axes array correspond to
-the elements of the gpio_tilt_axis-array.
-
-
-Example
--------
-
-Example configuration for a single TS1003 tilt switch that rotates around
-one axis in 4 steps and emits the current tilt via two GPIOs::
-
-    static int sg060_tilt_enable(struct device *dev) {
-	    /* code to enable the sensors */
-    };
-
-    static void sg060_tilt_disable(struct device *dev) {
-	    /* code to disable the sensors */
-    };
-
-    static struct gpio sg060_tilt_gpios[] = {
-	    { SG060_TILT_GPIO_SENSOR1, GPIOF_IN, "tilt_sensor1" },
-	    { SG060_TILT_GPIO_SENSOR2, GPIOF_IN, "tilt_sensor2" },
-    };
-
-    static struct gpio_tilt_state sg060_tilt_states[] = {
-	    {
-		    .gpios = (0 << 1) | (0 << 0),
-		    .axes = (int[]) {
-			    0,
-		    },
-	    }, {
-		    .gpios = (0 << 1) | (1 << 0),
-		    .axes = (int[]) {
-			    1, /* 90 degrees */
-		    },
-	    }, {
-		    .gpios = (1 << 1) | (1 << 0),
-		    .axes = (int[]) {
-			    2, /* 180 degrees */
-		    },
-	    }, {
-		    .gpios = (1 << 1) | (0 << 0),
-		    .axes = (int[]) {
-			    3, /* 270 degrees */
-		    },
-	    },
-    };
-
-    static struct gpio_tilt_axis sg060_tilt_axes[] = {
-	    {
-		    .axis = ABS_RY,
-		    .min = 0,
-		    .max = 3,
-		    .fuzz = 0,
-		    .flat = 0,
-	    },
-    };
-
-    static struct gpio_tilt_platform_data sg060_tilt_pdata= {
-	    .gpios = sg060_tilt_gpios,
-	    .nr_gpios = ARRAY_SIZE(sg060_tilt_gpios),
-
-	    .axes = sg060_tilt_axes,
-	    .nr_axes = ARRAY_SIZE(sg060_tilt_axes),
-
-	    .states = sg060_tilt_states,
-	    .nr_states = ARRAY_SIZE(sg060_tilt_states),
-
-	    .debounce_interval = 100,
-
-	    .poll_interval = 1000,
-	    .enable = sg060_tilt_enable,
-	    .disable = sg060_tilt_disable,
-    };
-
-    static struct platform_device sg060_device_tilt = {
-	    .name = "gpio-tilt-polled",
-	    .id = -1,
-	    .dev = {
-		    .platform_data = &sg060_tilt_pdata,
-	    },
-    };
diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 9f082a388388..4791e73839d9 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -268,20 +268,6 @@ config INPUT_GPIO_BEEPER
 	  To compile this driver as a module, choose M here: the
 	  module will be called gpio-beeper.
 
-config INPUT_GPIO_TILT_POLLED
-	tristate "Polled GPIO tilt switch"
-	depends on GPIOLIB || COMPILE_TEST
-	select INPUT_POLLDEV
-	help
-	  This driver implements support for tilt switches connected
-	  to GPIO pins that are not capable of generating interrupts.
-
-	  The list of gpios to use and the mapping of their states
-	  to specific angles is done via platform data.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called gpio_tilt_polled.
-
 config INPUT_GPIO_DECODER
 	tristate "Polled GPIO Decoder Input driver"
 	depends on GPIOLIB || COMPILE_TEST
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 4b6118d313fe..a8f61af865aa 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -36,7 +36,6 @@ obj-$(CONFIG_INPUT_DRV2665_HAPTICS)	+= drv2665.o
 obj-$(CONFIG_INPUT_DRV2667_HAPTICS)	+= drv2667.o
 obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
 obj-$(CONFIG_INPUT_GPIO_BEEPER)		+= gpio-beeper.o
-obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+= gpio_tilt_polled.o
 obj-$(CONFIG_INPUT_GPIO_DECODER)	+= gpio_decoder.o
 obj-$(CONFIG_INPUT_HISI_POWERKEY)	+= hisi_powerkey.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
diff --git a/drivers/input/misc/gpio_tilt_polled.c b/drivers/input/misc/gpio_tilt_polled.c
deleted file mode 100644
index 6e217a45e39a..000000000000
--- a/drivers/input/misc/gpio_tilt_polled.c
+++ /dev/null
@@ -1,210 +0,0 @@
-/*
- *  Driver for tilt switches connected via GPIO lines
- *  not capable of generating interrupts
- *
- *  Copyright (C) 2011 Heiko Stuebner <heiko@sntech.de>
- *
- *  based on: drivers/input/keyboard/gpio_keys_polled.c
- *
- *  Copyright (C) 2007-2010 Gabor Juhos <juhosg@openwrt.org>
- *  Copyright (C) 2010 Nuno Goncalves <nunojpg@gmail.com>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2 as
- *  published by the Free Software Foundation.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/input.h>
-#include <linux/input-polldev.h>
-#include <linux/ioport.h>
-#include <linux/platform_device.h>
-#include <linux/gpio.h>
-#include <linux/input/gpio_tilt.h>
-
-#define DRV_NAME	"gpio-tilt-polled"
-
-struct gpio_tilt_polled_dev {
-	struct input_polled_dev *poll_dev;
-	struct device *dev;
-	const struct gpio_tilt_platform_data *pdata;
-
-	int last_state;
-
-	int threshold;
-	int count;
-};
-
-static void gpio_tilt_polled_poll(struct input_polled_dev *dev)
-{
-	struct gpio_tilt_polled_dev *tdev = dev->private;
-	const struct gpio_tilt_platform_data *pdata = tdev->pdata;
-	struct input_dev *input = dev->input;
-	struct gpio_tilt_state *tilt_state = NULL;
-	int state, i;
-
-	if (tdev->count < tdev->threshold) {
-		tdev->count++;
-	} else {
-		state = 0;
-		for (i = 0; i < pdata->nr_gpios; i++)
-			state |= (!!gpio_get_value(pdata->gpios[i].gpio) << i);
-
-		if (state != tdev->last_state) {
-			for (i = 0; i < pdata->nr_states; i++)
-				if (pdata->states[i].gpios == state)
-					tilt_state = &pdata->states[i];
-
-			if (tilt_state) {
-				for (i = 0; i < pdata->nr_axes; i++)
-					input_report_abs(input,
-							 pdata->axes[i].axis,
-							 tilt_state->axes[i]);
-
-				input_sync(input);
-			}
-
-			tdev->count = 0;
-			tdev->last_state = state;
-		}
-	}
-}
-
-static void gpio_tilt_polled_open(struct input_polled_dev *dev)
-{
-	struct gpio_tilt_polled_dev *tdev = dev->private;
-	const struct gpio_tilt_platform_data *pdata = tdev->pdata;
-
-	if (pdata->enable)
-		pdata->enable(tdev->dev);
-
-	/* report initial state of the axes */
-	tdev->last_state = -1;
-	tdev->count = tdev->threshold;
-	gpio_tilt_polled_poll(tdev->poll_dev);
-}
-
-static void gpio_tilt_polled_close(struct input_polled_dev *dev)
-{
-	struct gpio_tilt_polled_dev *tdev = dev->private;
-	const struct gpio_tilt_platform_data *pdata = tdev->pdata;
-
-	if (pdata->disable)
-		pdata->disable(tdev->dev);
-}
-
-static int gpio_tilt_polled_probe(struct platform_device *pdev)
-{
-	const struct gpio_tilt_platform_data *pdata =
-			dev_get_platdata(&pdev->dev);
-	struct device *dev = &pdev->dev;
-	struct gpio_tilt_polled_dev *tdev;
-	struct input_polled_dev *poll_dev;
-	struct input_dev *input;
-	int error, i;
-
-	if (!pdata || !pdata->poll_interval)
-		return -EINVAL;
-
-	tdev = kzalloc(sizeof(struct gpio_tilt_polled_dev), GFP_KERNEL);
-	if (!tdev) {
-		dev_err(dev, "no memory for private data\n");
-		return -ENOMEM;
-	}
-
-	error = gpio_request_array(pdata->gpios, pdata->nr_gpios);
-	if (error) {
-		dev_err(dev,
-			"Could not request tilt GPIOs: %d\n", error);
-		goto err_free_tdev;
-	}
-
-	poll_dev = input_allocate_polled_device();
-	if (!poll_dev) {
-		dev_err(dev, "no memory for polled device\n");
-		error = -ENOMEM;
-		goto err_free_gpios;
-	}
-
-	poll_dev->private = tdev;
-	poll_dev->poll = gpio_tilt_polled_poll;
-	poll_dev->poll_interval = pdata->poll_interval;
-	poll_dev->open = gpio_tilt_polled_open;
-	poll_dev->close = gpio_tilt_polled_close;
-
-	input = poll_dev->input;
-
-	input->name = pdev->name;
-	input->phys = DRV_NAME"/input0";
-	input->dev.parent = dev;
-
-	input->id.bustype = BUS_HOST;
-	input->id.vendor = 0x0001;
-	input->id.product = 0x0001;
-	input->id.version = 0x0100;
-
-	__set_bit(EV_ABS, input->evbit);
-	for (i = 0; i < pdata->nr_axes; i++)
-		input_set_abs_params(input, pdata->axes[i].axis,
-				     pdata->axes[i].min, pdata->axes[i].max,
-				     pdata->axes[i].fuzz, pdata->axes[i].flat);
-
-	tdev->threshold = DIV_ROUND_UP(pdata->debounce_interval,
-				       pdata->poll_interval);
-
-	tdev->poll_dev = poll_dev;
-	tdev->dev = dev;
-	tdev->pdata = pdata;
-
-	error = input_register_polled_device(poll_dev);
-	if (error) {
-		dev_err(dev, "unable to register polled device, err=%d\n",
-			error);
-		goto err_free_polldev;
-	}
-
-	platform_set_drvdata(pdev, tdev);
-
-	return 0;
-
-err_free_polldev:
-	input_free_polled_device(poll_dev);
-err_free_gpios:
-	gpio_free_array(pdata->gpios, pdata->nr_gpios);
-err_free_tdev:
-	kfree(tdev);
-
-	return error;
-}
-
-static int gpio_tilt_polled_remove(struct platform_device *pdev)
-{
-	struct gpio_tilt_polled_dev *tdev = platform_get_drvdata(pdev);
-	const struct gpio_tilt_platform_data *pdata = tdev->pdata;
-
-	input_unregister_polled_device(tdev->poll_dev);
-	input_free_polled_device(tdev->poll_dev);
-
-	gpio_free_array(pdata->gpios, pdata->nr_gpios);
-
-	kfree(tdev);
-
-	return 0;
-}
-
-static struct platform_driver gpio_tilt_polled_driver = {
-	.probe	= gpio_tilt_polled_probe,
-	.remove	= gpio_tilt_polled_remove,
-	.driver	= {
-		.name	= DRV_NAME,
-	},
-};
-
-module_platform_driver(gpio_tilt_polled_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
-MODULE_DESCRIPTION("Polled GPIO tilt driver");
-MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/linux/input/gpio_tilt.h b/include/linux/input/gpio_tilt.h
deleted file mode 100644
index f9d932476a80..000000000000
--- a/include/linux/input/gpio_tilt.h
+++ /dev/null
@@ -1,74 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _INPUT_GPIO_TILT_H
-#define _INPUT_GPIO_TILT_H
-
-/**
- * struct gpio_tilt_axis - Axis used by the tilt switch
- * @axis:		Constant describing the axis, e.g. ABS_X
- * @min:		minimum value for abs_param
- * @max:		maximum value for abs_param
- * @fuzz:		fuzz value for abs_param
- * @flat:		flat value for abs_param
- */
-struct gpio_tilt_axis {
-	int axis;
-	int min;
-	int max;
-	int fuzz;
-	int flat;
-};
-
-/**
- * struct gpio_tilt_state - state description
- * @gpios:		bitfield of gpio target-states for the value
- * @axes:		array containing the axes settings for the gpio state
- *			The array indizes must correspond to the axes defined
- *			in platform_data
- *
- * This structure describes a supported axis settings
- * and the necessary gpio-state which represent it.
- *
- * The n-th bit in the bitfield describes the state of the n-th GPIO
- * from the gpios-array defined in gpio_regulator_config below.
- */
-struct gpio_tilt_state {
-	int gpios;
-	int *axes;
-};
-
-/**
- * struct gpio_tilt_platform_data
- * @gpios:		Array containing the gpios determining the tilt state
- * @nr_gpios:		Number of gpios
- * @axes:		Array of gpio_tilt_axis descriptions
- * @nr_axes:		Number of axes
- * @states:		Array of gpio_tilt_state entries describing
- *			the gpio state for specific tilts
- * @nr_states:		Number of states available
- * @debounce_interval:	debounce ticks interval in msecs
- * @poll_interval:	polling interval in msecs - for polling driver only
- * @enable:		callback to enable the tilt switch
- * @disable:		callback to disable the tilt switch
- *
- * This structure contains gpio-tilt-switch configuration
- * information that must be passed by platform code to the
- * gpio-tilt input driver.
- */
-struct gpio_tilt_platform_data {
-	struct gpio *gpios;
-	int nr_gpios;
-
-	struct gpio_tilt_axis *axes;
-	int nr_axes;
-
-	struct gpio_tilt_state *states;
-	int nr_states;
-
-	int debounce_interval;
-
-	unsigned int poll_interval;
-	int (*enable)(struct device *dev);
-	void (*disable)(struct device *dev);
-};
-
-#endif
-- 
2.14.3

