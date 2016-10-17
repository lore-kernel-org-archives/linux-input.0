From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] Input: gpio-keys: Convert to universal device properties API
Date: Mon, 17 Oct 2016 17:38:03 +0300
Message-ID: <20161017143803.142231-1-mika.westerberg@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2679 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932489AbcJQOih (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Oct 2016 10:38:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org

In order to use this driver in ACPI based systems, convert the driver to
take advantage of device properties APIs instead of Device Tree specific
one and make it available outside of CONFIG_OF.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/input/keyboard/gpio_keys.c | 92 ++++++++++++++++----------------------
 1 file changed, 38 insertions(+), 54 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 29093657f2ef..0e6d516df01b 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -22,13 +22,12 @@
 #include <linux/proc_fs.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/input.h>
 #include <linux/gpio_keys.h>
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
 #include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/of_gpio.h>
 #include <linux/of_irq.h>
 #include <linux/spinlock.h>
 
@@ -479,13 +478,15 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	spin_lock_init(&bdata->lock);
 
 	if (gpio_is_valid(button->gpio)) {
-
-		error = devm_gpio_request_one(&pdev->dev, button->gpio,
-					      GPIOF_IN, desc);
-		if (error < 0) {
-			dev_err(dev, "Failed to request GPIO %d, error %d\n",
-				button->gpio, error);
-			return error;
+		/* Only request GPIO if GPIO descriptor is not used */
+		if (!button->gpiod) {
+			error = devm_gpio_request_one(&pdev->dev, button->gpio,
+						      GPIOF_IN, desc);
+			if (error < 0) {
+				dev_err(dev, "Failed to request GPIO %d, error %d\n",
+					button->gpio, error);
+				return error;
+			}
 		}
 
 		if (button->debounce_interval) {
@@ -608,29 +609,17 @@ static void gpio_keys_close(struct input_dev *input)
 		pdata->disable(input->dev.parent);
 }
 
-/*
- * Handlers for alternative sources of platform_data
- */
-
-#ifdef CONFIG_OF
-/*
- * Translate OpenFirmware node properties into platform_data
- */
 static struct gpio_keys_platform_data *
 gpio_keys_get_devtree_pdata(struct device *dev)
 {
-	struct device_node *node, *pp;
 	struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button *button;
+	struct fwnode_handle *child;
 	int error;
 	int nbuttons;
 	int i;
 
-	node = dev->of_node;
-	if (!node)
-		return ERR_PTR(-ENODEV);
-
-	nbuttons = of_get_available_child_count(node);
+	nbuttons = device_get_child_node_count(dev);
 	if (nbuttons == 0)
 		return ERR_PTR(-ENODEV);
 
@@ -643,55 +632,60 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 	pdata->buttons = (struct gpio_keys_button *)(pdata + 1);
 	pdata->nbuttons = nbuttons;
 
-	pdata->rep = !!of_get_property(node, "autorepeat", NULL);
+	if (device_property_present(dev, "autorepeat"))
+		pdata->rep = true;
 
-	of_property_read_string(node, "label", &pdata->name);
+	device_property_read_string(dev, "label", &pdata->name);
 
 	i = 0;
-	for_each_available_child_of_node(node, pp) {
-		enum of_gpio_flags flags;
-
+	device_for_each_child_node(dev, child) {
 		button = &pdata->buttons[i++];
 
-		button->gpio = of_get_gpio_flags(pp, 0, &flags);
-		if (button->gpio < 0) {
-			error = button->gpio;
+		button->gpiod = devm_get_gpiod_from_child(dev, NULL, child);
+		if (IS_ERR(button->gpiod)) {
+			error = PTR_ERR(button->gpiod);
 			if (error != -ENOENT) {
 				if (error != -EPROBE_DEFER)
 					dev_err(dev,
-						"Failed to get gpio flags, error: %d\n",
+						"Failed to get gpio, error: %d\n",
 						error);
 				return ERR_PTR(error);
 			}
 		} else {
-			button->active_low = flags & OF_GPIO_ACTIVE_LOW;
+			button->active_low = gpiod_is_active_low(button->gpiod);
 		}
 
-		button->irq = irq_of_parse_and_map(pp, 0);
+		/* This is only supported by Device Tree */
+		button->irq = irq_of_parse_and_map(to_of_node(child), 0);
 
-		if (!gpio_is_valid(button->gpio) && !button->irq) {
+		if (IS_ERR(button->gpiod) && !button->irq) {
 			dev_err(dev, "Found button without gpios or irqs\n");
 			return ERR_PTR(-EINVAL);
 		}
 
-		if (of_property_read_u32(pp, "linux,code", &button->code)) {
+		button->gpio = desc_to_gpio(button->gpiod);
+
+		if (fwnode_property_read_u32(child, "linux,code",
+					     &button->code)) {
 			dev_err(dev, "Button without keycode: 0x%x\n",
 				button->gpio);
 			return ERR_PTR(-EINVAL);
 		}
 
-		button->desc = of_get_property(pp, "label", NULL);
+		fwnode_property_read_string(child, "label", &button->desc);
 
-		if (of_property_read_u32(pp, "linux,input-type", &button->type))
+		if (fwnode_property_read_u32(child, "linux,input-type",
+					     &button->type))
 			button->type = EV_KEY;
 
-		button->wakeup = of_property_read_bool(pp, "wakeup-source") ||
-				 /* legacy name */
-				 of_property_read_bool(pp, "gpio-key,wakeup");
+		if (fwnode_property_present(child, "wakeup-source") ||
+		    fwnode_property_present(child, "gpio-key,wakeup"))
+			button->wakeup = true;
 
-		button->can_disable = !!of_get_property(pp, "linux,can-disable", NULL);
+		if (fwnode_property_present(child, "linux,can-disable"))
+			button->can_disable = true;
 
-		if (of_property_read_u32(pp, "debounce-interval",
+		if (fwnode_property_read_u32(child, "debounce-interval",
 					 &button->debounce_interval))
 			button->debounce_interval = 5;
 	}
@@ -708,16 +702,6 @@ static const struct of_device_id gpio_keys_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, gpio_keys_of_match);
 
-#else
-
-static inline struct gpio_keys_platform_data *
-gpio_keys_get_devtree_pdata(struct device *dev)
-{
-	return ERR_PTR(-ENODEV);
-}
-
-#endif
-
 static int gpio_keys_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -873,7 +857,7 @@ static struct platform_driver gpio_keys_device_driver = {
 	.driver		= {
 		.name	= "gpio-keys",
 		.pm	= &gpio_keys_pm_ops,
-		.of_match_table = of_match_ptr(gpio_keys_of_match),
+		.of_match_table = gpio_keys_of_match,
 	}
 };
 
-- 
2.9.3

