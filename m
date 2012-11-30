From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC v2] input: Add new driver for GPIO beeper
Date: Fri, 30 Nov 2012 00:36:13 -0800
Message-ID: <20121130083613.GB27232@core.coreip.homeip.net>
References: <1354210139-25374-1-git-send-email-shc_work@mail.ru>
 <20121130062815.GA27232@core.coreip.homeip.net>
 <1354257967.330947278@f93.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47303 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755250Ab2K3IgR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Nov 2012 03:36:17 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so284426pbc.19
        for <linux-input@vger.kernel.org>; Fri, 30 Nov 2012 00:36:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1354257967.330947278@f93.mail.ru>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 30, 2012 at 10:46:07AM +0400, Alexander Shiyan wrote:
> ...
> > I think the driver should look like in the patch below. Can you please
> > tell me if it works for you?
> ...
> 
> Can you please send me patch as attachment?
> 

Sure, however do you know that if you were to simply save the original
email and fed it to "patch" command it would pick up the diff and apply
it?

Thanks.

-- 
Dmitry

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="input-add-new-driver-for-gpio-beeper.patch"

Input: Add new driver for GPIO beeper

From: Alexander Shiyan <shc_work@mail.ru>

This patch adds a new driver for the beeper controlled via GPIO pin.
The driver does not depend on the architecture and is positioned as
a replacement for the specific drivers that are used for this function,
for example drivers/input/misc/ixp4xx-beeper.
Since this patch is RFC only, inline comments are welcome.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/Kconfig                      |    9 +
 drivers/input/misc/Makefile                     |    1 
 drivers/input/misc/gpio-beeper.c                |  154 +++++++++++++++++++++++
 include/linux/platform_data/input-gpio-beeper.h |   20 +++
 4 files changed, 184 insertions(+)
 create mode 100644 drivers/input/misc/gpio-beeper.c
 create mode 100644 include/linux/platform_data/input-gpio-beeper.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 6d2bf0c..0d9b0eb 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -219,6 +219,15 @@ config INPUT_GP2A
 	  To compile this driver as a module, choose M here: the
 	  module will be called gp2ap002a00f.
 
+config INPUT_GPIO_BEEPER
+	tristate "Generic GPIO beeper support"
+	depends on GPIOLIB
+	help
+	  Say Y here if you have a beeper connected to a GPIO pin.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gpio_beeper.
+
 config INPUT_GPIO_TILT_POLLED
 	tristate "Polled GPIO tilt switch"
 	depends on GENERIC_GPIO
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 1f874af..662b39a 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_INPUT_DA9052_ONKEY)	+= da9052_onkey.o
 obj-$(CONFIG_INPUT_DA9055_ONKEY)	+= da9055_onkey.o
 obj-$(CONFIG_INPUT_DM355EVM)		+= dm355evm_keys.o
 obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
+obj-$(CONFIG_INPUT_GPIO_BEEPER)		+= gpio-beeper.o
 obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+= gpio_tilt_polled.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IXP4XX_BEEPER)	+= ixp4xx-beeper.o
diff --git a/drivers/input/misc/gpio-beeper.c b/drivers/input/misc/gpio-beeper.c
new file mode 100644
index 0000000..3408d43
--- /dev/null
+++ b/drivers/input/misc/gpio-beeper.c
@@ -0,0 +1,154 @@
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
+struct gpio_beeper {
+	struct input_dev	*input;
+	struct work_struct	work;
+	char			phys[32];
+	int			gpio_nr;
+	bool			active_low;
+	bool			beeping;
+};
+
+static void gpio_beeper_toggle(struct gpio_beeper *beeper, bool on)
+{
+	gpio_set_value_cansleep(beeper->gpio_nr, on ^ beeper->active_low);
+}
+
+static void gpio_beeper_work(struct work_struct *work)
+{
+	struct gpio_beeper *beeper =
+				container_of(work, struct gpio_beeper, work);
+
+	gpio_beeper_toggle(beeper, beeper->beeping);
+}
+
+static int gpio_beeper_event(struct input_dev *dev, unsigned int type,
+			     unsigned int code, int value)
+{
+	struct gpio_beeper *beeper = input_get_drvdata(dev);
+
+	if (type != EV_SND || code != SND_BELL)
+		return -ENOTSUPP;
+
+	if (value < 0)
+		return -EINVAL;
+
+	beeper->beeping = value;
+	/* Schedule work to actually turn the beeper on or off */
+	schedule_work(&beeper->work);
+
+	return 0;
+}
+
+static void gpio_beeper_close(struct input_dev *input)
+{
+	struct gpio_beeper *beeper = input_get_drvdata(input);
+
+	cancel_work_sync(&beeper->work);
+	gpio_beeper_toggle(beeper, false);
+}
+
+static int gpio_beeper_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	const struct gpio_beeper_pdata *pdata = dev_get_platdata(dev);
+	struct gpio_beeper *beeper;
+	struct input_dev *input;
+	int error;
+
+	if (!pdata) {
+		dev_err(dev, "Missing platform data\n");
+		return -EINVAL;
+	}
+
+	if (!gpio_is_valid(pdata->gpio_nr)) {
+		dev_err(dev, "Invalid gpio %i\n", pdata->gpio_nr);
+		return -EINVAL;
+	}
+
+	beeper = devm_kzalloc(&pdev->dev, sizeof(struct gpio_beeper),
+				GFP_KERNEL);
+	if (!beeper) {
+		dev_err(dev, "Memory allocate error\n");
+		return -ENOMEM;
+	}
+
+	beeper->gpio_nr = pdata->gpio_nr;
+	beeper->active_low = pdata->active_low;
+
+	INIT_WORK(&beeper->work, gpio_beeper_work);
+	snprintf(beeper->phys, sizeof(beeper->phys),
+		 "%s/input0", dev_name(dev));
+
+	input = devm_input_allocate_device(dev);
+	if (!input) {
+		dev_err(&pdev->dev, "Input device allocate error\n");
+		return -ENOMEM;
+	}
+
+	input->name		= pdata->name ?: "GPIO Beeper";
+	input->phys		= beeper->phys;
+	input->id.bustype	= BUS_HOST;
+	input->id.vendor	= 0x0001;
+	input->id.product	= 0x0001;
+	input->id.version	= 0x0100;
+
+	input->close		= gpio_beeper_close;
+	input->event		= gpio_beeper_event;
+
+	input_set_capability(input, EV_SND, SND_BELL);
+
+	error = devm_gpio_request(dev, beeper->gpio_nr, input->name);
+	if (error) {
+		dev_err(dev, "Unable to claim gpio %i\n", beeper->gpio_nr);
+		return error;
+	}
+
+	gpio_direction_output(beeper->gpio_nr, beeper->active_low);
+
+	beeper->input = input;
+	input_set_drvdata(input, beeper);
+	platform_set_drvdata(pdev, beeper);
+
+	return input_register_device(beeper->input);
+}
+
+static void gpio_beeper_shutdown(struct platform_device *pdev)
+{
+	struct gpio_beeper *beeper = platform_get_drvdata(pdev);
+
+	/* Turning OFF immediately */
+	gpio_beeper_close(beeper->input);
+}
+
+static struct platform_driver gpio_beeper_platform_driver = {
+	.driver	= {
+		.name	= "gpio-beeper",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= gpio_beeper_probe,
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

--tKW2IUtsqtDRztdT--
