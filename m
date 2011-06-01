From: y@protonic.xs4all.nl
Subject: [PATCH] INPUT: gpio_keys.c: Added OF support and enabled use with I2C GPIO expanders
Date: Wed,  1 Jun 2011 11:07:53 +0200
Message-ID: <3271.73869959569$1306921271@news.gmane.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:20715 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164Ab1FAJlA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Jun 2011 05:41:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>

From: David Jander <david@protonic.nl>

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/input/keyboard/gpio_keys.c |  192 ++++++++++++++++++++++++++++++------
 1 files changed, 161 insertions(+), 31 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index eb30063..34e4174 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -3,6 +3,9 @@
  *
  * Copyright 2005 Phil Blundell
  *
+ * Added OF support and enabled use with I2C GPIO expanders:
+ * Copyright 2010 David Jander <david@protonic.nl>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -25,6 +28,10 @@
 #include <linux/gpio_keys.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
+#ifdef CONFIG_OF
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#endif
 
 struct gpio_button_data {
 	struct gpio_keys_button *button;
@@ -42,6 +49,7 @@ struct gpio_keys_drvdata {
 	int (*enable)(struct device *dev);
 	void (*disable)(struct device *dev);
 	struct gpio_button_data data[0];
+	struct gpio_keys_platform_data *dyn_pdata;
 };
 
 /*
@@ -251,8 +259,7 @@ static ssize_t gpio_keys_show_##name(struct device *dev,		\
 				     struct device_attribute *attr,	\
 				     char *buf)				\
 {									\
-	struct platform_device *pdev = to_platform_device(dev);		\
-	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);	\
+	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);		\
 									\
 	return gpio_keys_attr_show_helper(ddata, buf,			\
 					  type, only_disabled);		\
@@ -278,8 +285,7 @@ static ssize_t gpio_keys_store_##name(struct device *dev,		\
 				      const char *buf,			\
 				      size_t count)			\
 {									\
-	struct platform_device *pdev = to_platform_device(dev);		\
-	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);	\
+	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);		\
 	ssize_t error;							\
 									\
 	error = gpio_keys_attr_store_helper(ddata, buf, type);		\
@@ -359,12 +365,11 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
+static int __devinit gpio_keys_setup_key(struct device *dev,
 					 struct gpio_button_data *bdata,
 					 struct gpio_keys_button *button)
 {
 	char *desc = button->desc ? button->desc : "gpio_keys";
-	struct device *dev = &pdev->dev;
 	unsigned long irqflags;
 	int irq, error;
 
@@ -410,8 +415,8 @@ static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
 	if (!button->can_disable)
 		irqflags |= IRQF_SHARED;
 
-	error = request_any_context_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
-	if (error < 0) {
+	error = request_threaded_irq(irq, NULL, gpio_keys_isr, irqflags, desc, bdata);
+	if (error) {
 		dev_err(dev, "Unable to claim irq %d; error %d\n",
 			irq, error);
 		goto fail3;
@@ -440,18 +445,133 @@ static void gpio_keys_close(struct input_dev *input)
 		ddata->disable(input->dev.parent);
 }
 
+/*
+ * Handlers for alternative sources of platform_data
+ */
+#ifdef CONFIG_OF
+/*
+ * Translate OpenFirmware node properties into platform_data
+ */
+static struct gpio_keys_platform_data *
+gpio_keys_get_alt_pdata(struct device *dev)
+{
+	struct gpio_keys_platform_data *pdata;
+	struct device_node *node, *pp;
+	int i;
+	struct gpio_keys_button *buttons;
+	const u32 *reg;
+	int len;
+
+	node = dev->of_node;
+	if (node == NULL)
+		return NULL;
+
+	pdata = kzalloc(sizeof(struct gpio_keys_platform_data), GFP_KERNEL);
+	if (pdata == NULL) {
+		dev_err(dev, "Unable to allocate platform_data\n");
+		return NULL;
+	}
+
+	reg = of_get_property(node, "linux,autorepeat", &len);
+	if (reg)
+		pdata->rep = reg[0];
+
+	/* First count the subnodes */
+	pdata->nbuttons = 0;
+	pp = NULL;
+	while ((pp = of_get_next_child(node, pp)))
+		pdata->nbuttons++;
+
+	if (pdata->nbuttons == 0)
+		return NULL;
+
+	buttons = kzalloc(pdata->nbuttons * sizeof(*buttons), GFP_KERNEL);
+	if (!buttons)
+		return NULL;
+
+	pp = NULL;
+	i = 0;
+	while ((pp = of_get_next_child(node, pp))) {
+		const char *lbl;
+
+		reg = of_get_property(pp, "reg", &len);
+		if (!reg) {
+			pdata->nbuttons--;
+			printk("Found button without reg\n");
+			continue;
+		}
+		buttons[i].gpio = reg[0];
+
+		reg = of_get_property(pp, "linux,code", &len);
+		if (!reg) {
+			dev_err(dev, "Button without keycode: 0x%x\n", buttons[i].gpio);
+			return NULL;
+		}
+		buttons[i].code = reg[0];
+
+		lbl = of_get_property(pp, "label", &len);
+		buttons[i].desc = (char *)lbl;
+
+		buttons[i].active_low = !!of_get_property(pp, "linux,active_low", NULL);
+
+		reg = of_get_property(pp, "linux,input_type", &len);
+		if (reg)
+			buttons[i].type = reg[0];
+		else
+			buttons[i].type = EV_KEY;
+
+		buttons[i].wakeup = !!of_get_property(pp, "linux,wakeup", NULL);
+
+		reg = of_get_property(pp, "linux,debounc_interval", &len);
+		if (reg)
+			buttons[i].debounce_interval = reg[0];
+		else
+			buttons[i].debounce_interval = 5;
+
+		buttons[i].can_disable = (bool)!!of_get_property(pp, "linux,can_disable", NULL);
+		i++;
+	}
+
+	pdata->buttons = buttons;
+
+	return pdata;
+}
+#else
+static struct gpio_keys_platform_data *
+gpio_keys_get_alt_pdata(struct device *dev)
+{
+	return NULL;
+}
+#endif
+
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
 	struct gpio_keys_drvdata *ddata;
 	struct device *dev = &pdev->dev;
+	struct gpio_keys_platform_data *pdata = dev->platform_data;
+	struct gpio_keys_platform_data *dyn_pdata = NULL;
 	struct input_dev *input;
 	int i, error;
 	int wakeup = 0;
 
+	if (!pdata) {
+		pdata = gpio_keys_get_alt_pdata(dev);
+		if (!pdata)
+			return -ENODEV;
+		/*
+		 * Unlike normal platform_data, this is allocated
+		 * dynamically and must be freed in the driver
+		 */
+		dev->platform_data = pdata;
+		dyn_pdata = pdata;
+	}
+
 	ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
 			pdata->nbuttons * sizeof(struct gpio_button_data),
 			GFP_KERNEL);
+
+	ddata->dyn_pdata = dyn_pdata;
+
 	input = input_allocate_device();
 	if (!ddata || !input) {
 		dev_err(dev, "failed to allocate state\n");
@@ -465,12 +585,12 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	ddata->disable = pdata->disable;
 	mutex_init(&ddata->disable_lock);
 
-	platform_set_drvdata(pdev, ddata);
+	dev_set_drvdata(dev, ddata);
 	input_set_drvdata(input, ddata);
 
-	input->name = pdev->name;
+	input->name = "GPIO_keyboard";
 	input->phys = "gpio-keys/input0";
-	input->dev.parent = &pdev->dev;
+	input->dev.parent = dev;
 	input->open = gpio_keys_open;
 	input->close = gpio_keys_close;
 
@@ -491,7 +611,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		bdata->input = input;
 		bdata->button = button;
 
-		error = gpio_keys_setup_key(pdev, bdata, button);
+		error = gpio_keys_setup_key(dev, bdata, button);
 		if (error)
 			goto fail2;
 
@@ -501,13 +621,12 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		input_set_capability(input, type, button->code);
 	}
 
-	error = sysfs_create_group(&pdev->dev.kobj, &gpio_keys_attr_group);
+	error = sysfs_create_group(&dev->kobj, &gpio_keys_attr_group);
 	if (error) {
 		dev_err(dev, "Unable to export keys/switches, error: %d\n",
 			error);
 		goto fail2;
 	}
-
 	error = input_register_device(input);
 	if (error) {
 		dev_err(dev, "Unable to register input device, error: %d\n",
@@ -520,12 +639,12 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		gpio_keys_report_event(&ddata->data[i]);
 	input_sync(input);
 
-	device_init_wakeup(&pdev->dev, wakeup);
+	device_init_wakeup(dev, wakeup);
 
 	return 0;
 
  fail3:
-	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
+	sysfs_remove_group(&dev->kobj, &gpio_keys_attr_group);
  fail2:
 	while (--i >= 0) {
 		free_irq(gpio_to_irq(pdata->buttons[i].gpio), &ddata->data[i]);
@@ -535,7 +654,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		gpio_free(pdata->buttons[i].gpio);
 	}
 
-	platform_set_drvdata(pdev, NULL);
+	dev_set_drvdata(dev, NULL);
  fail1:
 	input_free_device(input);
 	kfree(ddata);
@@ -545,14 +664,15 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 
 static int __devexit gpio_keys_remove(struct platform_device *pdev)
 {
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
-	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	struct gpio_keys_platform_data *pdata = dev->platform_data;
+	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
 	struct input_dev *input = ddata->input;
 	int i;
 
-	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
+	sysfs_remove_group(&dev->kobj, &gpio_keys_attr_group);
 
-	device_init_wakeup(&pdev->dev, 0);
+	device_init_wakeup(dev, 0);
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		int irq = gpio_to_irq(pdata->buttons[i].gpio);
@@ -562,21 +682,29 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 		cancel_work_sync(&ddata->data[i].work);
 		gpio_free(pdata->buttons[i].gpio);
 	}
+	if (ddata->dyn_pdata) {
+		kfree(pdata->buttons);
+		kfree(pdata);
+	}
 
 	input_unregister_device(input);
 
 	return 0;
 }
 
+static struct of_device_id gpio_keys_of_match[] = {
+	{ .compatible = "linux,gpio-keys", .data = NULL, },
+	{ .compatible = "gpio-keys", .data = NULL, },
+	{},
+};
 
 #ifdef CONFIG_PM
 static int gpio_keys_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_platform_data *pdata = dev->platform_data;
 	int i;
 
-	if (device_may_wakeup(&pdev->dev)) {
+	if (device_may_wakeup(dev)) {
 		for (i = 0; i < pdata->nbuttons; i++) {
 			struct gpio_keys_button *button = &pdata->buttons[i];
 			if (button->wakeup) {
@@ -591,15 +719,14 @@ static int gpio_keys_suspend(struct device *dev)
 
 static int gpio_keys_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
-	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
+	struct gpio_keys_platform_data *pdata = dev->platform_data;
 	int i;
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 
 		struct gpio_keys_button *button = &pdata->buttons[i];
-		if (button->wakeup && device_may_wakeup(&pdev->dev)) {
+		if (button->wakeup && device_may_wakeup(dev)) {
 			int irq = gpio_to_irq(button->gpio);
 			disable_irq_wake(irq);
 		}
@@ -617,6 +744,8 @@ static const struct dev_pm_ops gpio_keys_pm_ops = {
 };
 #endif
 
+MODULE_DEVICE_TABLE(of, gpio_keys_of_match);
+
 static struct platform_driver gpio_keys_device_driver = {
 	.probe		= gpio_keys_probe,
 	.remove		= __devexit_p(gpio_keys_remove),
@@ -626,6 +755,7 @@ static struct platform_driver gpio_keys_device_driver = {
 #ifdef CONFIG_PM
 		.pm	= &gpio_keys_pm_ops,
 #endif
+		.of_match_table = gpio_keys_of_match,
 	}
 };
 
@@ -639,10 +769,10 @@ static void __exit gpio_keys_exit(void)
 	platform_driver_unregister(&gpio_keys_device_driver);
 }
 
-module_init(gpio_keys_init);
+late_initcall(gpio_keys_init);
 module_exit(gpio_keys_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Phil Blundell <pb@handhelds.org>");
-MODULE_DESCRIPTION("Keyboard driver for CPU GPIOs");
+MODULE_DESCRIPTION("Keyboard driver for GPIOs");
 MODULE_ALIAS("platform:gpio-keys");
-- 
1.7.4.1

