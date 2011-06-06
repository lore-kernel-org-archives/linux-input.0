From: David Jander <david@protonic.nl>
Subject: [PATCH 2/3] Input: gpio_keys.c: Added support for device-tree platform data
Date: Mon,  6 Jun 2011 17:12:34 +0200
Message-ID: <1307373155-29470-3-git-send-email-david@protonic.nl>
References: <1307373155-29470-1-git-send-email-david@protonic.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:12849 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757230Ab1FFPrm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jun 2011 11:47:42 -0400
In-Reply-To: <1307373155-29470-1-git-send-email-david@protonic.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>

Signed-off-by: David Jander <david@protonic.nl>
---
 .../devicetree/bindings/gpio/gpio_keys.txt         |   49 ++++++++
 drivers/input/keyboard/gpio_keys.c                 |  131 ++++++++++++++++++++
 2 files changed, 180 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_keys.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio_keys.txt b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
new file mode 100644
index 0000000..ff8ba2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
@@ -0,0 +1,49 @@
+Device-Tree bindings for input/gpio_keys.c keyboard driver
+
+Required properties:
+	- compatible = "linux,gpio-keys", "gpio-keys";
+
+Optional properties:
+	- linux,autorepeat: Boolean, Enable auto repeat feature of Linux input
+	  subsystem.
+
+Each button (key) is represented as a sub-node of "gpio-keys":
+Subnode properties:
+
+	- reg: GPIO number the key is bound to.
+	- label: Descriptive name of the key.
+	- linux,code: Keycode to emit.
+
+Optional subnode-properties:
+	- linux,active_low: Boolean flag to specify active-low GPIO input.
+	- linux,input_type: Specify event type this button/key generates.
+	  Default if unspecified is <1> == EV_KEY.
+	- linux,debounc_interval: Debouncing interval time in milliseconds.
+	  Default if unspecified is 5.
+	- linux,can_disable: Boolean, specify if key can be disabled via
+	  module parameter.
+	- linux,wakeup: Boolean, button can wake-up the system.
+
+Example nodes:
+
+	gpio_keys {
+			compatible = "linux,gpio-keys", "gpio-keys";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			linux,autorepeat;
+			button@20 {
+				label = "GPIO Key ESC";
+				linux,code = <1>;
+				reg = <0x20>;
+				linux,active_low;
+				linux,input_type = <1>;
+			};
+			button@21 {
+				label = "GPIO Key UP";
+				linux,code = <103>;
+				reg = <0x21>;
+				linux,active_low;
+				linux,input_type = <1>;
+			};
+			...
+
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 987498e..4efd067 100644
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
+#include <linux/of.h>
+#include <linux/of_platform.h>
 
 struct gpio_button_data {
 	struct gpio_keys_button *button;
@@ -42,6 +47,7 @@ struct gpio_keys_drvdata {
 	int (*enable)(struct device *dev);
 	void (*disable)(struct device *dev);
 	struct gpio_button_data data[0];
+	struct gpio_keys_platform_data *dyn_pdata;
 };
 
 /*
@@ -442,18 +448,131 @@ static void gpio_keys_close(struct input_dev *input)
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
+gpio_keys_get_devtree_pdata(struct device *dev)
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
+	pdata->rep = !!of_get_property(node, "linux,autorepeat", &len);
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
+gpio_keys_get_devtree_pdata(struct device *dev)
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
+	struct gpio_keys_platform_data *dyn_pdata = NULL;
 	struct input_dev *input;
 	int i, error;
 	int wakeup = 0;
 
+	if (!pdata) {
+		pdata = gpio_keys_get_devtree_pdata(dev);
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
@@ -565,12 +684,21 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
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
+	{ .compatible = "linux,gpio-keys", },
+	{ .compatible = "gpio-keys", },
+	{},
+};
 
 #ifdef CONFIG_PM
 static int gpio_keys_suspend(struct device *dev)
@@ -618,6 +746,8 @@ static const struct dev_pm_ops gpio_keys_pm_ops = {
 };
 #endif
 
+MODULE_DEVICE_TABLE(of, gpio_keys_of_match);
+
 static struct platform_driver gpio_keys_device_driver = {
 	.probe		= gpio_keys_probe,
 	.remove		= __devexit_p(gpio_keys_remove),
@@ -627,6 +757,7 @@ static struct platform_driver gpio_keys_device_driver = {
 #ifdef CONFIG_PM
 		.pm	= &gpio_keys_pm_ops,
 #endif
+		.of_match_table = gpio_keys_of_match,
 	}
 };
 
-- 
1.7.4.1

