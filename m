From: Gabor Juhos <juhosg@openwrt.org>
Subject: [RFC 09/18] input: add input driver for polled GPIO buttons
Date: Fri, 12 Nov 2010 20:50:36 +0100
Message-ID: <1289591445-28842-10-git-send-email-juhosg@openwrt.org>
References: <1289591445-28842-1-git-send-email-juhosg@openwrt.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:53412 "EHLO
	phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932872Ab0KLUl5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Nov 2010 15:41:57 -0500
In-Reply-To: <1289591445-28842-1-git-send-email-juhosg@openwrt.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: kaloz@openwrt.org, Gabor Juhos <juhosg@openwrt.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mike Frysinger <vapier@gentoo.org>, linux-input@vger.kernel.org

The existing gpio-keys driver can be usable only for GPIO lines with
interrupt support. Several devices have buttons connected to a GPIO
line which is not capable to generate interrupts. This patch adds a
new input driver using the generic GPIO layer and the input-polldev
to support such buttons.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mike Frysinger <vapier@gentoo.org>
Cc: linux-input@vger.kernel.org
---
 drivers/input/misc/Kconfig        |   16 +++
 drivers/input/misc/Makefile       |    1 +
 drivers/input/misc/gpio_buttons.c |  232 +++++++++++++++++++++++++++++++++++++
 include/linux/gpio_buttons.h      |   33 +++++
 4 files changed, 282 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/gpio_buttons.c
 create mode 100644 include/linux/gpio_buttons.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index b99b8cb..3439b79 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -448,4 +448,20 @@ config INPUT_ADXL34X_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called adxl34x-spi.
 
+config INPUT_GPIO_BUTTONS
+	tristate "Polled GPIO buttons interface"
+	depends on GENERIC_GPIO
+	select INPUT_POLLDEV
+	help
+	  This driver implements support for buttons connected
+	  to GPIO pins of various CPUs (and some other chips).
+
+	  Say Y here if your device has buttons connected
+	  directly to such GPIO pins.  Your board-specific
+	  setup logic must also provide a platform device,
+	  with configuration data saying which GPIOs are used.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gpio-buttons.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 1fe1f6c..3791050 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -42,4 +42,5 @@ obj-$(CONFIG_INPUT_WINBOND_CIR)		+= winbond-cir.o
 obj-$(CONFIG_INPUT_WISTRON_BTNS)	+= wistron_btns.o
 obj-$(CONFIG_INPUT_WM831X_ON)		+= wm831x-on.o
 obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
+obj-$(CONFIG_INPUT_GPIO_BUTTONS)	+= gpio_buttons.o
 
diff --git a/drivers/input/misc/gpio_buttons.c b/drivers/input/misc/gpio_buttons.c
new file mode 100644
index 0000000..51288a3
--- /dev/null
+++ b/drivers/input/misc/gpio_buttons.c
@@ -0,0 +1,232 @@
+/*
+ *  Driver for buttons on GPIO lines not capable of generating interrupts
+ *
+ *  Copyright (C) 2007-2010 Gabor Juhos <juhosg@openwrt.org>
+ *  Copyright (C) 2010 Nuno Goncalves <nunojpg@gmail.com>
+ *
+ *  This file was based on: /drivers/input/misc/cobalt_btns.c
+ *	Copyright (C) 2007 Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
+ *
+ *  also was based on: /drivers/input/keyboard/gpio_keys.c
+ *	Copyright 2005 Phil Blundell
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
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
+#include <linux/gpio_buttons.h>
+
+#define DRV_NAME	"gpio-buttons"
+
+struct gpio_button_data {
+	int last_state;
+	int count;
+	int can_sleep;
+};
+
+struct gpio_buttons_dev {
+	struct input_polled_dev *poll_dev;
+	struct gpio_buttons_platform_data *pdata;
+	struct gpio_button_data *data;
+};
+
+static void gpio_buttons_check_state(struct input_dev *input,
+				      struct gpio_button *button,
+				      struct gpio_button_data *bdata)
+{
+	int state;
+
+	if (bdata->can_sleep)
+		state = !!gpio_get_value_cansleep(button->gpio);
+	else
+		state = !!gpio_get_value(button->gpio);
+
+	if (state != bdata->last_state) {
+		unsigned int type = button->type ?: EV_KEY;
+
+		input_event(input, type, button->code,
+			    !!(state ^ button->active_low));
+		input_sync(input);
+		bdata->count = 0;
+		bdata->last_state = state;
+	}
+}
+
+static void gpio_buttons_poll(struct input_polled_dev *dev)
+{
+	struct gpio_buttons_dev *bdev = dev->private;
+	struct gpio_buttons_platform_data *pdata = bdev->pdata;
+	struct input_dev *input = dev->input;
+	int i;
+
+	for (i = 0; i < bdev->pdata->nbuttons; i++) {
+		struct gpio_button *button = &pdata->buttons[i];
+		struct gpio_button_data *bdata = &bdev->data[i];
+
+		if (bdata->count < button->threshold)
+			bdata->count++;
+		else
+			gpio_buttons_check_state(input, button, bdata);
+
+	}
+}
+
+static int __devinit gpio_buttons_probe(struct platform_device *pdev)
+{
+	struct gpio_buttons_platform_data *pdata = pdev->dev.platform_data;
+	struct device *dev = &pdev->dev;
+	struct gpio_buttons_dev *bdev;
+	struct input_polled_dev *poll_dev;
+	struct input_dev *input;
+	int error;
+	int i;
+
+	if (!pdata)
+		return -ENXIO;
+
+	bdev = kzalloc(sizeof(struct gpio_buttons_dev) +
+		       pdata->nbuttons * sizeof(struct gpio_button_data),
+		       GFP_KERNEL);
+	if (!bdev) {
+		dev_err(dev, "no memory for private data\n");
+		return -ENOMEM;
+	}
+
+	bdev->data = (struct gpio_button_data *) &bdev[1];
+
+	poll_dev = input_allocate_polled_device();
+	if (!poll_dev) {
+		dev_err(dev, "no memory for polled device\n");
+		error = -ENOMEM;
+		goto err_free_bdev;
+	}
+
+	poll_dev->private = bdev;
+	poll_dev->poll = gpio_buttons_poll;
+	poll_dev->poll_interval = pdata->poll_interval;
+
+	input = poll_dev->input;
+
+	input->evbit[0] = BIT(EV_KEY);
+	input->name = pdev->name;
+	input->phys = "gpio-buttons/input0";
+	input->dev.parent = &pdev->dev;
+
+	input->id.bustype = BUS_HOST;
+	input->id.vendor = 0x0001;
+	input->id.product = 0x0001;
+	input->id.version = 0x0100;
+
+	for (i = 0; i < pdata->nbuttons; i++) {
+		struct gpio_button *button = &pdata->buttons[i];
+		unsigned int gpio = button->gpio;
+		unsigned int type = button->type ?: EV_KEY;
+
+		error = gpio_request(gpio,
+				     button->desc ? button->desc : DRV_NAME);
+		if (error) {
+			dev_err(dev, "unable to claim gpio %u, err=%d\n",
+				gpio, error);
+			goto err_free_gpio;
+		}
+
+		error = gpio_direction_input(gpio);
+		if (error) {
+			dev_err(dev,
+				"unable to set direction on gpio %u, err=%d\n",
+				gpio, error);
+			goto err_free_gpio;
+		}
+
+		bdev->data[i].can_sleep = gpio_cansleep(gpio);
+		bdev->data[i].last_state = -1;
+
+		input_set_capability(input, type, button->code);
+	}
+
+	bdev->poll_dev = poll_dev;
+	bdev->pdata = pdata;
+	platform_set_drvdata(pdev, bdev);
+
+	error = input_register_polled_device(poll_dev);
+	if (error) {
+		dev_err(dev, "unable to register polled device, err=%d\n",
+			error);
+		goto err_free_gpio;
+	}
+
+	/* report initial state of the buttons */
+	for (i = 0; i < pdata->nbuttons; i++)
+		gpio_buttons_check_state(input, &pdata->buttons[i],
+					 &bdev->data[i]);
+
+	return 0;
+
+err_free_gpio:
+	for (i = i - 1; i >= 0; i--)
+		gpio_free(pdata->buttons[i].gpio);
+
+	input_free_polled_device(poll_dev);
+
+err_free_bdev:
+	kfree(bdev);
+
+	platform_set_drvdata(pdev, NULL);
+	return error;
+}
+
+static int __devexit gpio_buttons_remove(struct platform_device *pdev)
+{
+	struct gpio_buttons_dev *bdev = platform_get_drvdata(pdev);
+	struct gpio_buttons_platform_data *pdata = bdev->pdata;
+	int i;
+
+	input_unregister_polled_device(bdev->poll_dev);
+
+	for (i = 0; i < pdata->nbuttons; i++)
+		gpio_free(pdata->buttons[i].gpio);
+
+	input_free_polled_device(bdev->poll_dev);
+
+	kfree(bdev);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver gpio_buttons_driver = {
+	.probe	= gpio_buttons_probe,
+	.remove	= __devexit_p(gpio_buttons_remove),
+	.driver	= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init gpio_buttons_init(void)
+{
+	return platform_driver_register(&gpio_buttons_driver);
+}
+
+static void __exit gpio_buttons_exit(void)
+{
+	platform_driver_unregister(&gpio_buttons_driver);
+}
+
+module_init(gpio_buttons_init);
+module_exit(gpio_buttons_exit);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Gabor Juhos <juhosg@openwrt.org>");
+MODULE_DESCRIPTION("Polled GPIO Buttons driver");
diff --git a/include/linux/gpio_buttons.h b/include/linux/gpio_buttons.h
new file mode 100644
index 0000000..f85b993
--- /dev/null
+++ b/include/linux/gpio_buttons.h
@@ -0,0 +1,33 @@
+/*
+ *  Definitions for the GPIO buttons interface driver
+ *
+ *  Copyright (C) 2007-2010 Gabor Juhos <juhosg@openwrt.org>
+ *
+ *  This file was based on: /include/linux/gpio_keys.h
+ *	The original gpio_keys.h seems not to have a license.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+#ifndef _GPIO_BUTTONS_H_
+#define _GPIO_BUTTONS_H_
+
+struct gpio_button {
+	int	gpio;		/* GPIO line number */
+	int	active_low;
+	char	*desc;		/* button description */
+	int	type;		/* input event type (EV_KEY, EV_SW) */
+	int	code;		/* input event code (KEY_*, SW_*) */
+	int	threshold;	/* count threshold */
+};
+
+struct gpio_buttons_platform_data {
+	struct gpio_button *buttons;
+	int	nbuttons;		/* number of buttons */
+	int	poll_interval;		/* polling interval */
+};
+
+#endif /* _GPIO_BUTTONS_H_ */
-- 
1.7.2.1

