From: David Jander <david@protonic.nl>
Subject: [PATCH v4 2/3] Input: gpio_keys.c: Added support for device-tree platform data
Date: Tue, 14 Jun 2011 11:08:10 +0200
Message-ID: <1308042491-20203-3-git-send-email-david@protonic.nl>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:13770 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab1FNJIA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 05:08:00 -0400
In-Reply-To: <1308042491-20203-1-git-send-email-david@protonic.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>

This patch enables fetching configuration data which is normally provided via
platform_data from the device-tree instead.
If the device is configured from device-tree data, the platform_data struct
is not used, and button data needs to be allocated dynamically.
Big part of this patch deals with confining pdata usage to the probe function,
to make this possible.

Signed-off-by: David Jander <david@protonic.nl>
---
 .../devicetree/bindings/gpio/gpio_keys.txt         |   49 +++++++
 drivers/input/keyboard/gpio_keys.c                 |  147 ++++++++++++++++++--
 2 files changed, 186 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_keys.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio_keys.txt b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
new file mode 100644
index 0000000..60a4d8e
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
@@ -0,0 +1,49 @@
+Device-Tree bindings for input/gpio_keys.c keyboard driver
+
+Required properties:
+	- compatible = "gpio-keys";
+
+Optional properties:
+	- autorepeat: Boolean, Enable auto repeat feature of Linux input
+	  subsystem.
+
+Each button (key) is represented as a sub-node of "gpio-keys":
+Subnode properties:
+
+	- reg: GPIO number the key is bound to if linux GPIO numbering is used.
+	- gpios: OF devcie-tree gpio specification, can be used alternatively
+	  if 'reg' is not specified, to use device-tree GPIOs.
+	- label: Descriptive name of the key.
+	- linux,code: Keycode to emit.
+
+Optional subnode-properties:
+	- active-low: Boolean flag to specify active-low GPIO input. Not used
+	  if device-tree gpios property is used.
+	- linux,input-type: Specify event type this button/key generates.
+	  Default if unspecified is <1> == EV_KEY.
+	- debounce-interval: Debouncing interval time in milliseconds.
+	  Default if unspecified is 5.
+	- wakeup: Boolean, button can wake-up the system.
+
+Example nodes:
+
+	gpio_keys {
+			compatible = "gpio-keys";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			autorepeat;
+			button@20 {
+				label = "GPIO Key ESC";
+				linux,code = <1>;
+				reg = <0x20>;
+				key-active-low;
+				linux,input-type = <1>;
+			};
+			button@21 {
+				label = "GPIO Key UP";
+				linux,code = <103>;
+				gpios = <&gpio1 0 1>;
+				linux,input-type = <1>;
+			};
+			...
+
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 987498e..78aeeaa 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -3,6 +3,9 @@
  *
  * Copyright 2005 Phil Blundell
  *
+ * Added OF support:
+ * Copyright 2010 David Jander <david@protonic.nl>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -25,6 +28,8 @@
 #include <linux/gpio_keys.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
+#include <linux/of_platform.h>
+#include <linux/of_gpio.h>
 
 struct gpio_button_data {
 	struct gpio_keys_button *button;
@@ -442,15 +447,124 @@ static void gpio_keys_close(struct input_dev *input)
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
+gpio_keys_get_devtree_pdata(struct device *dev,
+			    struct gpio_keys_platform_data *altp)
+{
+	struct gpio_keys_platform_data *pdata = altp;
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
+	memset(pdata, 0, sizeof *pdata);
+
+	pdata->rep = !!of_get_property(node, "autorepeat", &len);
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
+	buttons = kzalloc(pdata->nbuttons * (sizeof *buttons), GFP_KERNEL);
+	if (!buttons)
+		return NULL;
+
+	pp = NULL;
+	i = 0;
+	while ((pp = of_get_next_child(node, pp))) {
+		const char *lbl;
+		enum of_gpio_flags flags;
+
+		reg = of_get_property(pp, "reg", &len);
+		if (!reg && !of_find_property(pp, "gpios", NULL)) {
+			pdata->nbuttons--;
+			dev_warn(dev, "Found button without reg and without gpios\n");
+			continue;
+		}
+		if (reg) {
+			buttons[i].gpio = be32_to_cpup(reg);
+			buttons[i].active_low = !!of_get_property(pp, "key-active-low", NULL);
+		} else {
+			buttons[i].gpio = of_get_gpio_flags(pp, 0, &flags);
+			buttons[i].active_low = !!(flags & OF_GPIO_ACTIVE_LOW);
+		}
+
+		reg = of_get_property(pp, "linux,code", &len);
+		if (!reg) {
+			dev_err(dev, "Button without keycode: 0x%x\n", buttons[i].gpio);
+			goto out_fail;
+		}
+		buttons[i].code = be32_to_cpup(reg);
+
+		lbl = of_get_property(pp, "label", &len);
+		buttons[i].desc = (char *)lbl;
+
+		reg = of_get_property(pp, "linux,input-type", &len);
+		if (reg)
+			buttons[i].type = be32_to_cpup(reg);
+		else
+			buttons[i].type = EV_KEY;
+
+		buttons[i].wakeup = !!of_get_property(pp, "wakeup", NULL);
+
+		reg = of_get_property(pp, "debounce-interval", &len);
+		if (reg)
+			buttons[i].debounce_interval = be32_to_cpup(reg);
+		else
+			buttons[i].debounce_interval = 5;
+		i++;
+	}
+
+	pdata->buttons = buttons;
+
+	return pdata;
+
+out_fail:
+	kfree(buttons);
+	return NULL;
+}
+#else
+static struct gpio_keys_platform_data *
+gpio_keys_get_devtree_pdata(struct device *dev,
+			    struct gpio_keys_platform_data *altp)
+{
+	return NULL;
+}
+#endif
+
 static int __devinit gpio_keys_probe(struct platform_device *pdev)
 {
 	struct gpio_keys_drvdata *ddata;
 	struct device *dev = &pdev->dev;
 	struct gpio_keys_platform_data *pdata = dev->platform_data;
+	struct gpio_keys_platform_data alt_pdata;
 	struct input_dev *input;
 	int i, error;
 	int wakeup = 0;
 
+	if (!pdata) {
+		pdata = gpio_keys_get_devtree_pdata(dev, &alt_pdata);
+		if (!pdata)
+			return -ENODEV;
+	}
+
 	ddata = kzalloc(sizeof(struct gpio_keys_drvdata) +
 			pdata->nbuttons * sizeof(struct gpio_button_data),
 			GFP_KERNEL);
@@ -548,7 +662,6 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 static int __devexit gpio_keys_remove(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct gpio_keys_platform_data *pdata = dev->platform_data;
 	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
 	struct input_dev *input = ddata->input;
 	int i;
@@ -557,30 +670,42 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 
 	device_init_wakeup(dev, 0);
 
-	for (i = 0; i < pdata->nbuttons; i++) {
-		int irq = gpio_to_irq(pdata->buttons[i].gpio);
+	for (i = 0; i < ddata->n_buttons; i++) {
+		int irq = gpio_to_irq(ddata->data[i].button->gpio);
 		free_irq(irq, &ddata->data[i]);
 		if (ddata->data[i].timer_debounce)
 			del_timer_sync(&ddata->data[i].timer);
 		cancel_work_sync(&ddata->data[i].work);
-		gpio_free(pdata->buttons[i].gpio);
+		gpio_free(ddata->data[i].button->gpio);
 	}
 
+	/*
+	 * If we had no platform_data, we allocated buttons dynamically, and
+	 * must free them here. ddata->data[0].button is the pointer to the
+	 * beginning of the allocated array.
+	 */
+	if (!dev->platform_data)
+		kfree(ddata->data[0].button);
+
 	input_unregister_device(input);
 
 	return 0;
 }
 
+static struct of_device_id gpio_keys_of_match[] = {
+	{ .compatible = "gpio-keys", },
+	{},
+};
 
 #ifdef CONFIG_PM
 static int gpio_keys_suspend(struct device *dev)
 {
-	struct gpio_keys_platform_data *pdata = dev->platform_data;
+	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
 	int i;
 
 	if (device_may_wakeup(dev)) {
-		for (i = 0; i < pdata->nbuttons; i++) {
-			struct gpio_keys_button *button = &pdata->buttons[i];
+		for (i = 0; i < ddata->n_buttons; i++) {
+			struct gpio_keys_button *button = ddata->data[i].button;
 			if (button->wakeup) {
 				int irq = gpio_to_irq(button->gpio);
 				enable_irq_wake(irq);
@@ -594,12 +719,11 @@ static int gpio_keys_suspend(struct device *dev)
 static int gpio_keys_resume(struct device *dev)
 {
 	struct gpio_keys_drvdata *ddata = dev_get_drvdata(dev);
-	struct gpio_keys_platform_data *pdata = dev->platform_data;
 	int i;
 
-	for (i = 0; i < pdata->nbuttons; i++) {
+	for (i = 0; i < ddata->n_buttons; i++) {
 
-		struct gpio_keys_button *button = &pdata->buttons[i];
+		struct gpio_keys_button *button = ddata->data[i].button;
 		if (button->wakeup && device_may_wakeup(dev)) {
 			int irq = gpio_to_irq(button->gpio);
 			disable_irq_wake(irq);
@@ -618,6 +742,8 @@ static const struct dev_pm_ops gpio_keys_pm_ops = {
 };
 #endif
 
+MODULE_DEVICE_TABLE(of, gpio_keys_of_match);
+
 static struct platform_driver gpio_keys_device_driver = {
 	.probe		= gpio_keys_probe,
 	.remove		= __devexit_p(gpio_keys_remove),
@@ -627,6 +753,7 @@ static struct platform_driver gpio_keys_device_driver = {
 #ifdef CONFIG_PM
 		.pm	= &gpio_keys_pm_ops,
 #endif
+		.of_match_table = gpio_keys_of_match,
 	}
 };
 
-- 
1.7.4.1

