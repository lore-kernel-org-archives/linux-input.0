From: Nava kishore Manne <nava.manne@xilinx.com>
Subject: [LINUX PATCH v2] gpio_keys: Added support to read the IRQ_FLAGS from devicetree
Date: Mon, 4 Apr 2016 15:26:10 +0530
Message-ID: <1459763770-2296-1-git-send-email-navam@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-sn1nam02on0051.outbound.protection.outlook.com ([104.47.36.51]:13968
	"EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754268AbcDDKK4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 Apr 2016 06:10:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, bjorn.andersson@sonymobile.com, navam@xilinx.com, van.freenix@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This patch adds the support to read the IRQ_FLAGS from the device
instead of hard code the flags in gpio_keys_setup_key().

example gpio-keys DT node:

gpio-keys {
	compatible = "gpio-keys";
	#address-cells = <1>;
	#size-cells = <0>;
	autorepeat;
		sw14 {
			label = "sw14";
			gpios = <&gpio0 12 1>;
			/*
			 * Triggering Type:
			 *
			 * 1 - edge rising
			 * 2 - edge falling
			 * 4 - level active high
			 * 8 - level active low
			 *
			 */
			linux,code = <108>; /* down */
			gpio-key,wakeup;
			autorepeat;
		};
	};

Signed-off-by: Nava kishore Manne <navam@xilinx.com>
---
Changes for v2:
		-None

 drivers/input/keyboard/gpio_keys.c | 8 ++++----
 include/linux/gpio_keys.h          | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index bef317f..07b50ad 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -497,7 +497,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		INIT_DELAYED_WORK(&bdata->work, gpio_keys_gpio_work_func);
 
 		isr = gpio_keys_gpio_isr;
-		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
+		irqflags = button->irq_flags;
 
 	} else {
 		if (!button->irq) {
@@ -630,11 +630,10 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 
 	i = 0;
 	for_each_child_of_node(node, pp) {
-		enum of_gpio_flags flags;
 
 		button = &pdata->buttons[i++];
 
-		button->gpio = of_get_gpio_flags(pp, 0, &flags);
+		button->gpio = of_get_gpio_flags(pp, 0, &button->irq_flags);
 		if (button->gpio < 0) {
 			error = button->gpio;
 			if (error != -ENOENT) {
@@ -645,7 +644,8 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 				return ERR_PTR(error);
 			}
 		} else {
-			button->active_low = flags & OF_GPIO_ACTIVE_LOW;
+			button->active_low = button->irq_flags
+						& OF_GPIO_ACTIVE_LOW;
 		}
 
 		button->irq = irq_of_parse_and_map(pp, 0);
diff --git a/include/linux/gpio_keys.h b/include/linux/gpio_keys.h
index ee2d8c6..0aeecea 100644
--- a/include/linux/gpio_keys.h
+++ b/include/linux/gpio_keys.h
@@ -31,6 +31,7 @@ struct gpio_keys_button {
 	bool can_disable;
 	int value;
 	unsigned int irq;
+	unsigned int irq_flags;
 	struct gpio_desc *gpiod;
 };
 
-- 
2.1.2

