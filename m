From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH RFC v2] input: Add new driver for GPIO beeper
Date: Thu, 29 Nov 2012 21:28:59 +0400
Message-ID: <1354210139-25374-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp12.mail.ru ([94.100.176.89]:40013 "EHLO smtp12.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465Ab2K2R3I (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Nov 2012 12:29:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Shiyan <shc_work@mail.ru>

This patch adds a new driver for the beeper controlled via GPIO pin.
The driver does not depend on the architecture and is positioned as
a replacement for the specific drivers that are used for this function,
for example drivers/input/misc/ixp4xx-beeper.
Since this patch is RFC only, inline comments are welcome.
---
 drivers/input/misc/Kconfig                      |    6 +
 drivers/input/misc/Makefile                     |    1 +
 drivers/input/misc/gpio-beeper.c                |  156 +++++++++++++++++++++++
 include/linux/platform_data/input-gpio-beeper.h |   20 +++
 4 files changed, 183 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/gpio-beeper.c
 create mode 100644 include/linux/platform_data/input-gpio-beeper.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 259ef31..549af80 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -222,6 +222,12 @@ config INPUT_GP2A
 	  To compile this driver as a module, choose M here: the
 	  module will be called gp2ap002a00f.
 
+config INPUT_GPIO_BEEPER
+	tristate "Generic GPIO beeper support"
+	depends on GPIOLIB
+	help
+	  Say Y here if you have a beeper connected to the GPIO pin.
+
 config INPUT_GPIO_TILT_POLLED
 	tristate "Polled GPIO tilt switch"
 	depends on GENERIC_GPIO
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 1f1e1b1..8234854 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
 obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
 obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
 obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
+obj-$(CONFIG_INPUT_GPIO_BEEPER)		+= gpio-beeper.o
 obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+= gpio_tilt_polled.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
diff --git a/drivers/input/misc/gpio-beeper.c b/drivers/input/misc/gpio-beeper.c
new file mode 100644
index 0000000..6bc2a2c
--- /dev/null
+++ b/drivers/input/misc/gpio-beeper.c
@@ -0,0 +1,156 @@
+/*
+ *  Generic GPIO beeper driver
+ *
+ *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/gpio.h>
+#include <linux/input.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/workqueue.h>
+#include <linux/platform_device.h>
+
+#include <linux/platform_data/input-gpio-beeper.h>
+
+struct gpio_beeper_priv {
+	struct input_dev	*input;
+	struct delayed_work	work;
+	char			phys[32];
+	int			gpio_nr;
+	int			active_low:1;
+};
+
+static void gpio_beeper_change(struct gpio_beeper_priv *s, int set)
+{
+	gpio_set_value_cansleep(s->gpio_nr, set ^ s->active_low);
+}
+
+static void gpio_beeper_work(struct work_struct *work)
+{
+	struct gpio_beeper_priv *s = container_of(work, struct gpio_beeper_priv,
+						  work.work);
+
+	gpio_beeper_change(s, 0);
+}
+
+static int gpio_beeper_event(struct input_dev *dev, unsigned int type,
+			     unsigned int code, int value)
+{
+	struct gpio_beeper_priv *s = input_get_drvdata(dev);
+
+	if ((type != EV_SND) || (code != SND_BELL))
+		return -ENOTSUPP;
+
+	if (value < 0)
+		return -EINVAL;
+
+	if (!value)
+		value = 1000;
+
+	/* Turning beeper ON */
+	gpio_beeper_change(s, 1);
+	/* Schedule work for turning OFF */
+	mod_delayed_work(system_wq, &s->work, msecs_to_jiffies(value));
+
+	return 0;
+}
+
+static int gpio_beeper_probe(struct platform_device *pdev)
+{
+	struct gpio_beeper_pdata *pdata = dev_get_platdata(&pdev->dev);
+	struct gpio_beeper_priv *s;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "Missing platform data\n");
+		return -EINVAL;
+	}
+
+	if (!gpio_is_valid(pdata->gpio_nr)) {
+		dev_err(&pdev->dev, "Invalid gpio %i\n", pdata->gpio_nr);
+		return -EINVAL;
+	}
+
+	s = devm_kzalloc(&pdev->dev, sizeof(struct gpio_beeper_priv),
+			 GFP_KERNEL);
+	if (!s) {
+		dev_err(&pdev->dev, "Memory allocate error\n");
+		return -ENOMEM;
+	}
+
+	s->gpio_nr = pdata->gpio_nr;
+	s->active_low = pdata->active_low;
+
+	s->input = devm_input_allocate_device(&pdev->dev);
+	if (!s->input) {
+		dev_err(&pdev->dev, "Input device allocate error\n");
+		return -ENOMEM;
+	}
+
+	snprintf(s->phys, sizeof(s->phys), "%s/input0",
+		 pdata->name ? pdata->name : dev_name(&pdev->dev));
+	s->input->dev.parent	= &pdev->dev;
+	s->input->name		= dev_name(&pdev->dev);
+	s->input->phys		= s->phys;
+	s->input->id.bustype	= BUS_HOST;
+	s->input->id.vendor	= 0x0001;
+	s->input->id.product	= 0x0001;
+	s->input->id.version	= 0x0100;
+	s->input->evbit[0]	= BIT(EV_SND);
+	s->input->sndbit[0]	= BIT(SND_BELL);
+	s->input->event		= gpio_beeper_event;
+
+	if (devm_gpio_request(&pdev->dev, s->gpio_nr, s->input->name)) {
+		dev_err(&pdev->dev, "Unable to claim gpio %i\n", s->gpio_nr);
+		return -EBUSY;
+	}
+
+	gpio_direction_output(s->gpio_nr, s->active_low);
+
+	input_set_drvdata(s->input, s);
+	platform_set_drvdata(pdev, s);
+
+	INIT_DELAYED_WORK(&s->work, gpio_beeper_work);
+
+	return input_register_device(s->input);
+}
+
+static int gpio_beeper_remove(struct platform_device *pdev)
+{
+	struct gpio_beeper_priv *s = platform_get_drvdata(pdev);
+
+	input_unregister_device(s->input);
+	cancel_delayed_work_sync(&s->work);
+	gpio_beeper_change(s, 0);
+	platform_set_drvdata(pdev, NULL);
+
+	return 0;
+}
+
+static void gpio_beeper_shutdown(struct platform_device *pdev)
+{
+	struct gpio_beeper_priv *s = platform_get_drvdata(pdev);
+
+	/* Turning OFF immediately */
+	flush_delayed_work(&s->work);
+}
+
+static struct platform_driver gpio_beeper_platform_driver = {
+	.driver	= {
+		.name	= "gpio-beeper",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= gpio_beeper_probe,
+	.remove		= gpio_beeper_remove,
+	.shutdown	= gpio_beeper_shutdown,
+};
+module_platform_driver(gpio_beeper_platform_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alexander Shiyan <shc_work@mail.ru>");
+MODULE_DESCRIPTION("Generic GPIO beeper driver");
diff --git a/include/linux/platform_data/input-gpio-beeper.h b/include/linux/platform_data/input-gpio-beeper.h
new file mode 100644
index 0000000..9eb4362
--- /dev/null
+++ b/include/linux/platform_data/input-gpio-beeper.h
@@ -0,0 +1,20 @@
+/*
+ *  Copyright (C) 2012 Alexander Shiyan <shc_work@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __PLATFORM_DATA_INPUT_GPIO_BEEPER_H_
+#define __PLATFORM_DATA_INPUT_GPIO_BEEPER_H_
+
+/* gpio-beeper platform data structure */
+struct gpio_beeper_pdata {
+	const char	*name;		/* Name of device (Optional) */
+	int		gpio_nr;	/* GPIO number */
+	int		active_low:1;	/* Set if active level is LOW */
+};
+
+#endif
-- 
1.7.8.6

