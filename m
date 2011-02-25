From: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
Subject: [PATCH] input: generic driver for slide switches
Date: Fri, 25 Feb 2011 14:29:18 +0100
Message-ID: <1298640558-3030-1-git-send-email-alexander.stein@informatik.tu-chemnitz.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from jessica.hrz.tu-chemnitz.de ([134.109.132.47]:39942 "EHLO
	jessica.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755669Ab1BYN31 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Feb 2011 08:29:27 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>

This patch adds a generic driver for slide switches connected to GPIO
pins of a system. It requires gpiolib and generic hardware irqs.

Signed-off-by: Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
---
 drivers/input/misc/Kconfig         |    9 ++
 drivers/input/misc/Makefile        |    1 +
 drivers/input/misc/slide_switch.c  |  268 ++++++++++++++++++++++++++++++++++++
 include/linux/input/slide_switch.h |   16 ++
 4 files changed, 294 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/misc/slide_switch.c
 create mode 100644 include/linux/input/slide_switch.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index b0c6772..ba9395c 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -341,6 +341,15 @@ config INPUT_GPIO_ROTARY_ENCODER
 	  To compile this driver as a module, choose M here: the
 	  module will be called rotary_encoder.
 
+config INPUT_GPIO_SLIDE_SWITCH
+	tristate "Slide switches connected to GPIO pins"
+	depends on GPIOLIB && GENERIC_GPIO
+	help
+	  Say Y here to add support for slide switches connected to GPIO lines.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called slide_switch.
+
 config INPUT_RB532_BUTTON
 	tristate "Mikrotik Routerboard 532 button interface"
 	depends on MIKROTIK_RB532
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 9b47971..d81fdc9 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -35,6 +35,7 @@ obj-$(CONFIG_INPUT_POWERMATE)		+= powermate.o
 obj-$(CONFIG_INPUT_PWM_BEEPER)		+= pwm-beeper.o
 obj-$(CONFIG_INPUT_RB532_BUTTON)	+= rb532_button.o
 obj-$(CONFIG_INPUT_GPIO_ROTARY_ENCODER)	+= rotary_encoder.o
+obj-$(CONFIG_INPUT_GPIO_SLIDE_SWITCH)	+= slide_switch.o
 obj-$(CONFIG_INPUT_SGI_BTNS)		+= sgi_btns.o
 obj-$(CONFIG_INPUT_SPARCSPKR)		+= sparcspkr.o
 obj-$(CONFIG_INPUT_TWL4030_PWRBUTTON)	+= twl4030-pwrbutton.o
diff --git a/drivers/input/misc/slide_switch.c b/drivers/input/misc/slide_switch.c
new file mode 100644
index 0000000..0f69b3a
--- /dev/null
+++ b/drivers/input/misc/slide_switch.c
@@ -0,0 +1,268 @@
+/*
+ * slide_switch.c
+ *
+ * (c) 2011 Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>
+ *
+ * A generic driver for slide switches connected to GPIO lines.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#define DEBUG
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/input.h>
+#include <linux/gpio.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <linux/input/slide_switch.h>
+
+#define DRV_NAME "slide-switch"
+
+struct slide_switch {
+	struct input_dev *input;
+	struct slide_switch_platform_data *pdata;
+
+	struct timer_list timer;
+	struct work_struct work;
+	int timer_debounce;	/* in msecs */
+};
+
+static void slide_switch_report_event(struct slide_switch *slide_switch)
+{
+	struct input_dev *input = slide_switch->input;
+	struct slide_switch_platform_data *pdata = slide_switch->pdata;
+	unsigned long posbit;
+	int i, on, pos, invalidpos;
+
+	posbit = 0;
+	for (i = 0; i < pdata->gpios; i++) {
+		on = gpio_get_value(pdata->gpiolist[i].gpio) ? 1 : 0;
+		on ^= pdata->gpiolist[i].inverted;
+		if (on)
+			set_bit(i, &posbit);
+	}
+
+	pos = find_first_bit(&posbit, pdata->gpios);
+	invalidpos = find_next_bit(&posbit, pdata->gpios, pos + 1);
+
+	/* Check if there is only one bit set */
+	if (pos < pdata->gpios && invalidpos == pdata->gpios) {
+		input_report_abs(slide_switch->input, pdata->axis, pos);
+		input_sync(input);
+	}
+}
+
+static void slide_switch_work_func(struct work_struct *work)
+{
+	struct slide_switch *slide_switch =
+		container_of(work, struct slide_switch, work);
+
+	slide_switch_report_event(slide_switch);
+}
+
+static void slide_switch_timer(unsigned long _data)
+{
+	struct slide_switch *slide_switch = (struct slide_switch *)_data;
+
+	schedule_work(&slide_switch->work);
+}
+
+static irqreturn_t slide_switch_irq(int irq, void *dev_id)
+{
+	struct slide_switch *slide_switch = dev_id;
+
+	if (slide_switch->timer_debounce)
+		mod_timer(&slide_switch->timer,
+			jiffies + msecs_to_jiffies(slide_switch->timer_debounce));
+	else
+		schedule_work(&slide_switch->work);
+
+	return IRQ_HANDLED;
+}
+
+static int slide_switch_register_gpios(struct device *dev,
+		const struct slide_switch_gpio *gpio,
+		struct slide_switch *slide_switch)
+{
+	int err, gpio_num, irq;
+	struct slide_switch_platform_data *pdata = slide_switch->pdata;
+
+	gpio_num = gpio->gpio;
+	irq = gpio_to_irq(gpio_num);
+
+	err = gpio_request(gpio_num, DRV_NAME);
+	if (err) {
+		dev_err(dev, "unable to request GPIO %d\n",
+			gpio_num);
+		goto exit_fail;
+	}
+
+	err = gpio_direction_input(gpio_num);
+	if (err) {
+		dev_err(dev, "unable to set GPIO %d for input\n",
+			gpio_num);
+		goto exit_unregister_gpio;
+	}
+
+	if (pdata->debounce_ms) {
+		err = gpio_set_debounce(gpio_num,
+					pdata->debounce_ms * 1000);
+		/* use timer if gpiolib doesn't provide debounce */
+		if (err < 0)
+			slide_switch->timer_debounce = pdata->debounce_ms;
+	}
+
+	/* request the IRQs */
+	err = request_irq(irq, &slide_switch_irq,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			DRV_NAME, slide_switch);
+	if (err) {
+		dev_err(dev, "unable to request IRQ %d\n",
+			irq);
+		goto exit_unregister_gpio;
+	}
+
+	return 0;
+
+exit_unregister_gpio:
+	gpio_free(gpio_num);
+exit_fail:
+
+	return 1;
+}
+
+static void slide_switch_unregister_gpios(struct device *dev,
+		const struct slide_switch_gpio *gpio,
+		struct slide_switch *slide_switch)
+{
+	int gpio_num, irq;
+
+	gpio_num = gpio->gpio;
+	irq = gpio_to_irq(gpio_num);
+
+	free_irq(irq, slide_switch);
+	gpio_free(gpio_num);
+}
+
+static int __devinit slide_switch_probe(struct platform_device *pdev)
+{
+	struct slide_switch_platform_data *pdata = pdev->dev.platform_data;
+	struct slide_switch *slide_switch;
+	struct input_dev *input;
+	int err, i;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "missing platform data\n");
+		return -ENOENT;
+	}
+
+	if (!pdata->gpios || !pdata->gpiolist) {
+		dev_err(&pdev->dev, "no GPIOs provided\n");
+		return -ENOENT;
+	}
+
+	slide_switch = kzalloc(sizeof(struct slide_switch), GFP_KERNEL);
+	input = input_allocate_device();
+	if (!slide_switch || !input) {
+		dev_err(&pdev->dev, "failed to allocate memory for device\n");
+		err = -ENOMEM;
+		goto exit_free_mem;
+	}
+
+	slide_switch->input = input;
+	slide_switch->pdata = pdata;
+
+	/* create and register the input driver */
+	input->name = pdev->name;
+	input->id.bustype = BUS_HOST;
+	input->dev.parent = &pdev->dev;
+
+	input->evbit[0] = BIT_MASK(EV_ABS);
+	input_set_abs_params(slide_switch->input,
+				pdata->axis, 0, pdata->gpios, 0, 0);
+
+	err = input_register_device(input);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register input device\n");
+		goto exit_free_mem;
+	}
+
+	setup_timer(&slide_switch->timer, slide_switch_timer,
+				(unsigned long)slide_switch);
+	INIT_WORK(&slide_switch->work, slide_switch_work_func);
+
+	/* Register GPIOs */
+	for (i = 0; i < pdata->gpios; i++) {
+		err = slide_switch_register_gpios(&pdev->dev,
+			&pdata->gpiolist[i], slide_switch);
+		if (err) {
+			for (i--; i >= 0; i--) {
+				slide_switch_unregister_gpios(&pdev->dev,
+					&pdata->gpiolist[i], slide_switch);
+			}
+			goto exit_unregister_input;
+		}
+	}
+
+	platform_set_drvdata(pdev, slide_switch);
+
+	return 0;
+
+exit_unregister_input:
+	input_unregister_device(input);
+	input = NULL; /* so we don't try to free it */
+exit_free_mem:
+	input_free_device(input);
+	kfree(slide_switch);
+	return err;
+}
+
+static int __devexit slide_switch_remove(struct platform_device *pdev)
+{
+	struct slide_switch *slide_switch = platform_get_drvdata(pdev);
+	struct slide_switch_platform_data *pdata = pdev->dev.platform_data;
+	int i;
+
+	/* Unregister GPIOs */
+	for (i = 0; i < pdata->gpios; i++)
+		slide_switch_unregister_gpios(&pdev->dev,
+				&pdata->gpiolist[i], slide_switch);
+
+	input_unregister_device(slide_switch->input);
+	platform_set_drvdata(pdev, NULL);
+	kfree(slide_switch);
+
+	return 0;
+}
+
+static struct platform_driver slide_switch_driver = {
+	.probe		= slide_switch_probe,
+	.remove		= __devexit_p(slide_switch_remove),
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	}
+};
+
+static int __init slide_switch_init(void)
+{
+	return platform_driver_register(&slide_switch_driver);
+}
+
+static void __exit slide_switch_exit(void)
+{
+	platform_driver_unregister(&slide_switch_driver);
+}
+
+module_init(slide_switch_init);
+module_exit(slide_switch_exit);
+
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_DESCRIPTION("GPIO slide switch driver");
+MODULE_AUTHOR("Alexander Stein <alexander.stein@informatik.tu-chemnitz.de>");
+MODULE_LICENSE("GPL v2");
+
diff --git a/include/linux/input/slide_switch.h b/include/linux/input/slide_switch.h
new file mode 100644
index 0000000..b7544cb
--- /dev/null
+++ b/include/linux/input/slide_switch.h
@@ -0,0 +1,16 @@
+#ifndef __SLIDE_SWITCH_H__
+#define __SLIDE_SWITCH_H__
+
+struct slide_switch_gpio {
+	unsigned int gpio;
+	unsigned int inverted;
+};
+
+struct slide_switch_platform_data {
+	unsigned int axis;
+	const struct slide_switch_gpio *gpiolist;
+	unsigned int gpios;
+	unsigned int debounce_ms;
+};
+
+#endif /* __SLIDE_SWITCH_H__ */
-- 
1.7.4.1

