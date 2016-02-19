From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] input: gpio_keys: Make use of the device property API
Date: Fri, 19 Feb 2016 11:16:22 +0100
Message-ID: <1455876982-6743-4-git-send-email-geert+renesas@glider.be>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Vincent Pelletier <plr.vincent@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-input@vger.kernel.org

Make use of the device property API in this driver so that both OF based
systems and ACPI based systems can use this driver.

Based on commits b26d4e2283b6d9b6 ("input: gpio_keys_polled: Make use of
device property API"), 99b4ffbd84ea4191 ("Input: gpio_keys[_polled] -
change name of wakeup property"), and 1feb57a245a4910b ("gpio: add
parameter to allow the use named gpios").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested with DT only.
---
 drivers/input/keyboard/gpio_keys.c | 77 +++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 47 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index b6262d94aff19f70..5764308e3b26314a 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -27,9 +27,6 @@
 #include <linux/workqueue.h>
 #include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of.h>
-#include <linux/of_platform.h>
-#include <linux/of_gpio.h>
 #include <linux/spinlock.h>
 
 struct gpio_button_data {
@@ -625,26 +622,20 @@ static void gpio_keys_close(struct input_dev *input)
  * Handlers for alternative sources of platform_data
  */
 
-#ifdef CONFIG_OF
 /*
- * Translate OpenFirmware node properties into platform_data
+ * Translate properties into platform_data
  */
 static struct gpio_keys_platform_data *
 gpio_keys_get_devtree_pdata(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct device_node *node, *pp;
 	struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button *button;
+	struct fwnode_handle *child;
 	int error;
 	int nbuttons;
-	int i;
-
-	node = dev->of_node;
-	if (!node)
-		return ERR_PTR(-ENODEV);
 
-	nbuttons = of_get_available_child_count(node);
+	nbuttons = device_get_child_node_count(dev);
 	if (nbuttons == 0)
 		return ERR_PTR(-ENODEV);
 
@@ -655,32 +646,29 @@ gpio_keys_get_devtree_pdata(struct platform_device *pdev)
 		return ERR_PTR(-ENOMEM);
 
 	pdata->buttons = (struct gpio_keys_button *)(pdata + 1);
-	pdata->nbuttons = nbuttons;
-
-	pdata->rep = !!of_get_property(node, "autorepeat", NULL);
 
-	of_property_read_string(node, "label", &pdata->name);
+	pdata->rep = device_property_present(dev, "autorepeat");
+	device_property_read_string(dev, "label", &pdata->name);
 
-	i = 0;
-	for_each_available_child_of_node(node, pp) {
-		enum of_gpio_flags flags;
+	device_for_each_child_node(dev, child) {
+		struct gpio_desc *desc;
 
-		button = &pdata->buttons[i++];
-
-		button->gpio = of_get_gpio_flags(pp, 0, &flags);
-		if (button->gpio < 0) {
-			error = button->gpio;
+		desc = devm_get_gpiod_from_child(dev, NULL, child);
+		if (IS_ERR(desc)) {
+			error = PTR_ERR(desc);
 			if (error != -ENOENT) {
 				if (error != -EPROBE_DEFER)
 					dev_err(dev,
 						"Failed to get gpio flags, error: %d\n",
 						error);
+				fwnode_handle_put(child);
 				return ERR_PTR(error);
 			}
-		} else {
-			button->active_low = flags & OF_GPIO_ACTIVE_LOW;
 		}
 
+		button = &pdata->buttons[pdata->nbuttons++];
+		button->gpiod = desc;
+
 		button->irq = platform_get_irq(pdev, 0);
 
 		if (!gpio_is_valid(button->gpio) && button->irq < 0) {
@@ -688,24 +676,29 @@ gpio_keys_get_devtree_pdata(struct platform_device *pdev)
 			return ERR_PTR(-EINVAL);
 		}
 
-		if (of_property_read_u32(pp, "linux,code", &button->code)) {
-			dev_err(dev, "Button without keycode: 0x%x\n",
-				button->gpio);
+		if (fwnode_property_read_u32(child, "linux,code",
+					     &button->code)) {
+			dev_err(dev, "Button without keycode: %d\n",
+				pdata->nbuttons - 1);
+			fwnode_handle_put(child);
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
+		button->wakeup =
+			fwnode_property_read_bool(child, "wakeup-source") ||
+			 /* legacy name */
+			 fwnode_property_read_bool(child, "gpio-key,wakeup");
 
-		button->can_disable = !!of_get_property(pp, "linux,can-disable", NULL);
+		button->can_disable =
+			fwnode_property_present(child, "linux,can-disable");
 
-		if (of_property_read_u32(pp, "debounce-interval",
+		if (fwnode_property_read_u32(child, "debounce-interval",
 					 &button->debounce_interval))
 			button->debounce_interval = 5;
 	}
@@ -722,16 +715,6 @@ static const struct of_device_id gpio_keys_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, gpio_keys_of_match);
 
-#else
-
-static inline struct gpio_keys_platform_data *
-gpio_keys_get_devtree_pdata(struct platform_device *pdev)
-{
-	return ERR_PTR(-ENODEV);
-}
-
-#endif
-
 static int gpio_keys_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -887,7 +870,7 @@ static struct platform_driver gpio_keys_device_driver = {
 	.driver		= {
 		.name	= "gpio-keys",
 		.pm	= &gpio_keys_pm_ops,
-		.of_match_table = of_match_ptr(gpio_keys_of_match),
+		.of_match_table = gpio_keys_of_match,
 	}
 };
 
-- 
1.9.1

