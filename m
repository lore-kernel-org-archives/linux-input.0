From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH v2 1/1] Input: gpio_keys - add device tree support for interrupt only keys
Date: Wed, 12 Nov 2014 17:02:56 +0100
Message-ID: <1415808176-13282-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:39774 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753075AbaKLQBK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2014 11:01:10 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org

This features already exists for board config setups. Add support for
device tree based systems.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
Please note: Due to current lack of hardware I could not test it yet. V2
includes the changes proposed by Dmitry.

Changes in v2:
* Added device tree bindings
* IRQ is only parsed and mapped when there is no "gpios" property

 .../devicetree/bindings/input/gpio-keys.txt        | 10 ++++++-
 drivers/input/keyboard/gpio_keys.c                 | 34 +++++++++++++---------
 2 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index 5c2c021..a4a38fc 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -10,10 +10,13 @@ Optional properties:
 Each button (key) is represented as a sub-node of "gpio-keys":
 Subnode properties:
 
-	- gpios: OF device-tree gpio specification.
 	- label: Descriptive name of the key.
 	- linux,code: Keycode to emit.
 
+Required mutual exclusive subnode-properties:
+	- gpios: OF device-tree gpio specification.
+	- interrupts: the interrupt line for that input
+
 Optional subnode-properties:
 	- linux,input-type: Specify event type this button/key generates.
 	  If not specified defaults to <1> == EV_KEY.
@@ -33,4 +36,9 @@ Example nodes:
 				linux,code = <103>;
 				gpios = <&gpio1 0 1>;
 			};
+			button@22 {
+				label = "GPIO Key DOWN";
+				linux,code = <108>;
+				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
+			};
 			...
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 8c98e97..ce0d909 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -29,6 +29,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
+#include <linux/of_irq.h>
 #include <linux/spinlock.h>
 
 struct gpio_button_data {
@@ -617,28 +618,33 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 
 	i = 0;
 	for_each_child_of_node(node, pp) {
-		int gpio;
+		int gpio = -1;
+		int irq;
 		enum of_gpio_flags flags;
 
 		if (!of_find_property(pp, "gpios", NULL)) {
-			pdata->nbuttons--;
-			dev_warn(dev, "Found button without gpios\n");
-			continue;
-		}
-
-		gpio = of_get_gpio_flags(pp, 0, &flags);
-		if (gpio < 0) {
-			error = gpio;
-			if (error != -EPROBE_DEFER)
-				dev_err(dev,
-					"Failed to get gpio flags, error: %d\n",
-					error);
-			return ERR_PTR(error);
+			irq = irq_of_parse_and_map(pp, 0);
+			if (irq == 0) {
+				pdata->nbuttons--;
+				dev_warn(dev, "Found button without gpios or irqs\n");
+				continue;
+			}
+		} else {
+			gpio = of_get_gpio_flags(pp, 0, &flags);
+			if (gpio < 0) {
+				error = gpio;
+				if (error != -EPROBE_DEFER)
+					dev_err(dev,
+						"Failed to get gpio flags, error: %d\n",
+						error);
+				return ERR_PTR(error);
+			}
 		}
 
 		button = &pdata->buttons[i++];
 
 		button->gpio = gpio;
+		button->irq = irq;
 		button->active_low = flags & OF_GPIO_ACTIVE_LOW;
 
 		if (of_property_read_u32(pp, "linux,code", &button->code)) {
-- 
2.0.4

