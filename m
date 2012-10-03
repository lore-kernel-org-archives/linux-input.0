From: Tomasz Figa <t.figa@samsung.com>
Subject: [PATCH] input: keyboard: gpio-keys: Try to parse IRQ from device tree
Date: Wed, 03 Oct 2012 13:20:00 +0200
Message-ID: <1349263201-422-1-git-send-email-t.figa@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, m.szyprowski@samsung.com, t.figa@samsung.com, tomasz.figa@gmail.com, dmitry.torokhov@gmail.com
List-Id: linux-input@vger.kernel.org

On modern platforms using device tree and non-legacy IRQ domains there
is usually no way to perform direct translation between GPIO and IRQ,
because the IRQ of interest is not mapped yet into sparse IRQ namespace.

This patch modifies the gpio_keys driver to parse IRQ from device tree
and use gpio_to_irq only as a fallback.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 Documentation/devicetree/bindings/gpio/gpio_keys.txt | 2 ++
 drivers/input/keyboard/gpio_keys.c                   | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_keys.txt b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
index 5c2c021..7f318a5 100644
--- a/Documentation/devicetree/bindings/gpio/gpio_keys.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_keys.txt
@@ -20,6 +20,8 @@ Optional subnode-properties:
 	- debounce-interval: Debouncing interval time in milliseconds.
 	  If not specified defaults to 5.
 	- gpio-key,wakeup: Boolean, button can wake-up the system.
+	- interrupt: Interrupt used for this key (required if no translation
+	  between GPIO and IRQ is available).
 
 Example nodes:
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6a68041..a33660c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -28,6 +28,7 @@
 #include <linux/gpio.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
+#include <linux/of_irq.h>
 #include <linux/spinlock.h>
 
 struct gpio_button_data {
@@ -464,7 +465,7 @@ static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
 						button->debounce_interval;
 		}
 
-		irq = gpio_to_irq(button->gpio);
+		irq = (button->irq) ? : gpio_to_irq(button->gpio);
 		if (irq < 0) {
 			error = irq;
 			dev_err(dev,
@@ -597,6 +598,7 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 
 		button = &pdata->buttons[i++];
 
+		button->irq = irq_of_parse_and_map(pp, 0);
 		button->gpio = of_get_gpio_flags(pp, 0, &flags);
 		button->active_low = flags & OF_GPIO_ACTIVE_LOW;
 
-- 
1.7.12
