From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/6] Input: gpio_keys[_polled] - change name of wakeup property
Date: Fri, 17 Jul 2015 17:36:19 -0700
Message-ID: <1437179781-21124-5-git-send-email-dmitry.torokhov@gmail.com>
References: <1437179781-21124-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437179781-21124-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

Wakeup property of device is not Linux-specific, it describes intended
system behavior regardless of the OS being used. Therefore let's drop
"linux," prefix, and, while at it, use the same name as I2C bus does:
"wakeup-source".

We keep parsing old name to keep compatibility with old DTSes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 Documentation/devicetree/bindings/input/gpio-keys-polled.txt | 2 +-
 Documentation/devicetree/bindings/input/gpio-keys.txt        | 2 +-
 drivers/input/keyboard/gpio_keys.c                           | 4 +++-
 drivers/input/keyboard/gpio_keys_polled.c                    | 5 ++++-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
index 313abef..5b91f5a 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys-polled.txt
@@ -20,7 +20,7 @@ Optional subnode-properties:
 	  If not specified defaults to <1> == EV_KEY.
 	- debounce-interval: Debouncing interval time in milliseconds.
 	  If not specified defaults to 5.
-	- gpio-key,wakeup: Boolean, button can wake-up the system.
+	- wakeup-source: Boolean, button can wake-up the system.
 
 Example nodes:
 
diff --git a/Documentation/devicetree/bindings/input/gpio-keys.txt b/Documentation/devicetree/bindings/input/gpio-keys.txt
index 44b7057..072bf75 100644
--- a/Documentation/devicetree/bindings/input/gpio-keys.txt
+++ b/Documentation/devicetree/bindings/input/gpio-keys.txt
@@ -23,7 +23,7 @@ Optional subnode-properties:
 	  If not specified defaults to <1> == EV_KEY.
 	- debounce-interval: Debouncing interval time in milliseconds.
 	  If not specified defaults to 5.
-	- gpio-key,wakeup: Boolean, button can wake-up the system.
+	- wakeup-source: Boolean, button can wake-up the system.
 	- linux,can-disable: Boolean, indicates that button is connected
 	  to dedicated (not shared) interrupt which can be disabled to
 	  suppress events from the button.
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index ddf4045..1df4507 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -655,7 +655,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 		if (of_property_read_u32(pp, "linux,input-type", &button->type))
 			button->type = EV_KEY;
 
-		button->wakeup = !!of_get_property(pp, "gpio-key,wakeup", NULL);
+		button->wakeup = of_property_read_bool(pp, "wakeup-source") ||
+				 /* legacy name */
+				 of_property_read_bool(pp, "gpio-key,wakeup");
 
 		button->can_disable = !!of_get_property(pp, "linux,can-disable", NULL);
 
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 097d721..5a0c999 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -152,7 +152,10 @@ static struct gpio_keys_platform_data *gpio_keys_polled_get_devtree_pdata(struct
 					     &button->type))
 			button->type = EV_KEY;
 
-		button->wakeup = fwnode_property_present(child, "gpio-key,wakeup");
+		button->wakeup =
+			fwnode_property_read_bool(child, "wakeup-source") ||
+			/* legacy name */
+			fwnode_property_read_bool(child, "gpio-key,wakeup");
 
 		if (fwnode_property_read_u32(child, "debounce-interval",
 					     &button->debounce_interval))
-- 
2.4.3.573.g4eafbef
