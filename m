From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/3] input: gpio_keys: Switch from irq_of_parse_and_map() to platform_get_irq()
Date: Fri, 19 Feb 2016 11:16:21 +0100
Message-ID: <1455876982-6743-3-git-send-email-geert+renesas@glider.be>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:34363 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992554AbcBSKQY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Feb 2016 05:16:24 -0500
In-Reply-To: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Vincent Pelletier <plr.vincent@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Note that irq_of_parse_and_map() returns 0 on failure, while
platform_get_irq() returns -ENXIO on failure, so we have to make irq
signed, and update all error checks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/input/keyboard/gpio_keys.c | 16 ++++++++--------
 include/linux/gpio_keys.h          |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index d2b6c3acd9c32f1d..b6262d94aff19f70 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -30,7 +30,6 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
-#include <linux/of_irq.h>
 #include <linux/spinlock.h>
 
 struct gpio_button_data {
@@ -511,7 +510,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 						button->debounce_interval;
 		}
 
-		if (button->irq) {
+		if (button->irq >= 0) {
 			bdata->irq = button->irq;
 		} else {
 			irq = gpiod_to_irq(button->gpiod);
@@ -531,7 +530,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
 
 	} else {
-		if (!button->irq) {
+		if (button->irq < 0) {
 			dev_err(dev, "No IRQ specified\n");
 			return -EINVAL;
 		}
@@ -631,8 +630,9 @@ static void gpio_keys_close(struct input_dev *input)
  * Translate OpenFirmware node properties into platform_data
  */
 static struct gpio_keys_platform_data *
-gpio_keys_get_devtree_pdata(struct device *dev)
+gpio_keys_get_devtree_pdata(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
 	struct device_node *node, *pp;
 	struct gpio_keys_platform_data *pdata;
 	struct gpio_keys_button *button;
@@ -681,9 +681,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 			button->active_low = flags & OF_GPIO_ACTIVE_LOW;
 		}
 
-		button->irq = irq_of_parse_and_map(pp, 0);
+		button->irq = platform_get_irq(pdev, 0);
 
-		if (!gpio_is_valid(button->gpio) && !button->irq) {
+		if (!gpio_is_valid(button->gpio) && button->irq < 0) {
 			dev_err(dev, "Found button without gpios or irqs\n");
 			return ERR_PTR(-EINVAL);
 		}
@@ -725,7 +725,7 @@ MODULE_DEVICE_TABLE(of, gpio_keys_of_match);
 #else
 
 static inline struct gpio_keys_platform_data *
-gpio_keys_get_devtree_pdata(struct device *dev)
+gpio_keys_get_devtree_pdata(struct platform_device *pdev)
 {
 	return ERR_PTR(-ENODEV);
 }
@@ -743,7 +743,7 @@ static int gpio_keys_probe(struct platform_device *pdev)
 	int wakeup = 0;
 
 	if (!pdata) {
-		pdata = gpio_keys_get_devtree_pdata(dev);
+		pdata = gpio_keys_get_devtree_pdata(pdev);
 		if (IS_ERR(pdata))
 			return PTR_ERR(pdata);
 	}
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index ee2d8c6f91300db7..0c04d38069535b86 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -30,7 +30,7 @@ struct gpio_keys_button {
 	int debounce_interval;
 	bool can_disable;
 	int value;
-	unsigned int irq;
+	int irq;
 	struct gpio_desc *gpiod;
 };
 
-- 
1.9.1

