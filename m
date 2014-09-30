From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [RFC 1/1] Input: gpio_keys - add device tree support for interrupt only keys
Date: Tue, 30 Sep 2014 17:40:47 +0200
Message-ID: <1412091647-1562-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:54472 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750818AbaI3PsI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Sep 2014 11:48:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-input@vger.kernel.org

This features already exists for board config setups. Add support for
device tree based systems.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
I'm aware thatthe device tree binding description is missing yet. But for now
I just want some feedback about that approach.

 drivers/input/keyboard/gpio_keys.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 8c98e97..7b90e1b 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
+#include <linux/of_irq.h>
 #include <linux/spinlock.h>
 
 struct gpio_button_data {
@@ -617,28 +618,32 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 
 	i = 0;
 	for_each_child_of_node(node, pp) {
-		int gpio;
+		int gpio = -1;
+		int irq;
 		enum of_gpio_flags flags;
 
-		if (!of_find_property(pp, "gpios", NULL)) {
+		irq = irq_of_parse_and_map(pp, 0);
+
+		if (of_find_property(pp, "gpios", NULL)) {
+			gpio = of_get_gpio_flags(pp, 0, &flags);
+			if (gpio < 0) {
+				error = gpio;
+				if (error != -EPROBE_DEFER)
+					dev_err(dev,
+						"Failed to get gpio flags, error: %d\n",
+						error);
+				return ERR_PTR(error);
+			}
+		} else if (irq == 0) {
 			pdata->nbuttons--;
-			dev_warn(dev, "Found button without gpios\n");
+			dev_warn(dev, "Found button without gpios or irqs\n");
 			continue;
 		}
 
-		gpio = of_get_gpio_flags(pp, 0, &flags);
-		if (gpio < 0) {
-			error = gpio;
-			if (error != -EPROBE_DEFER)
-				dev_err(dev,
-					"Failed to get gpio flags, error: %d\n",
-					error);
-			return ERR_PTR(error);
-		}
-
 		button = &pdata->buttons[i++];
 
 		button->gpio = gpio;
+		button->irq = irq;
 		button->active_low = flags & OF_GPIO_ACTIVE_LOW;
 
 		if (of_property_read_u32(pp, "linux,code", &button->code)) {
-- 
1.8.5.5

