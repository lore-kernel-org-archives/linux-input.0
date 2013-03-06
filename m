From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH] input: samsung-keypad: let device core setup the default pin
 configuration
Date: Wed, 06 Mar 2013 17:19:17 +0530
Message-ID: <1362570557-14274-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, heiko@sntech.de, jy0922.shim@samsung.com, dh09.lee@samsung.com, patches@linaro.org
List-Id: linux-input@vger.kernel.org

With device core now able to setup the default pin configuration,
the pin configuration code based on the deprecated Samsung specific
gpio bindings is removed.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 .../devicetree/bindings/input/samsung-keypad.txt   |   25 ++--------
 drivers/input/keyboard/samsung-keypad.c            |   52 +-------------------
 2 files changed, 7 insertions(+), 70 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/samsung-keypad.txt b/Documentation/devicetree/bindings/input/samsung-keypad.txt
index ce3e394..73ad847 100644
--- a/Documentation/devicetree/bindings/input/samsung-keypad.txt
+++ b/Documentation/devicetree/bindings/input/samsung-keypad.txt
@@ -25,14 +25,6 @@ Required Board Specific Properties:
 - samsung,keypad-num-columns: Number of column lines connected to the
   keypad controller.
 
-- row-gpios: List of gpios used as row lines. The gpio specifier for
-  this property depends on the gpio controller to which these row lines
-  are connected.
-
-- col-gpios: List of gpios used as column lines. The gpio specifier for
-  this property depends on the gpio controller to which these column
-  lines are connected.
-
 - Keys represented as child nodes: Each key connected to the keypad
   controller is represented as a child node to the keypad controller
   device node and should include the following properties.
@@ -41,6 +33,9 @@ Required Board Specific Properties:
   - linux,code: the key-code to be reported when the key is pressed
     and released.
 
+- pinctrl-0: Should specify pin control groups used for this controller.
+- pinctrl-names: Should contain only one value - "default".
+
 Optional Properties specific to linux:
 - linux,keypad-no-autorepeat: do no enable autorepeat feature.
 - linux,keypad-wakeup: use any event on keypad as wakeup event.
@@ -55,18 +50,8 @@ Example:
 		samsung,keypad-num-columns = <8>;
 		linux,input-no-autorepeat;
 		linux,input-wakeup;
-
-		row-gpios = <&gpx2 0 3 3 0
-			     &gpx2 1 3 3 0>;
-
-		col-gpios = <&gpx1 0 3 0 0
-			     &gpx1 1 3 0 0
-			     &gpx1 2 3 0 0
-			     &gpx1 3 3 0 0
-			     &gpx1 4 3 0 0
-			     &gpx1 5 3 0 0
-			     &gpx1 6 3 0 0
-			     &gpx1 7 3 0 0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&keypad_rows &keypad_columns>;
 
 		key_1 {
 			keypad,row = <0>;
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 22e357b..03bdad7 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -24,7 +24,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_gpio.h>
 #include <linux/sched.h>
 #include <linux/input/samsung-keypad.h>
 
@@ -79,10 +78,6 @@ struct samsung_keypad {
 	unsigned int rows;
 	unsigned int cols;
 	unsigned int row_state[SAMSUNG_MAX_COLS];
-#ifdef CONFIG_OF
-	int row_gpios[SAMSUNG_MAX_ROWS];
-	int col_gpios[SAMSUNG_MAX_COLS];
-#endif
 	unsigned short keycodes[];
 };
 
@@ -304,45 +299,6 @@ static struct samsung_keypad_platdata *samsung_keypad_parse_dt(
 
 	return pdata;
 }
-
-static void samsung_keypad_parse_dt_gpio(struct device *dev,
-				struct samsung_keypad *keypad)
-{
-	struct device_node *np = dev->of_node;
-	int gpio, error, row, col;
-
-	for (row = 0; row < keypad->rows; row++) {
-		gpio = of_get_named_gpio(np, "row-gpios", row);
-		keypad->row_gpios[row] = gpio;
-		if (!gpio_is_valid(gpio)) {
-			dev_err(dev, "keypad row[%d]: invalid gpio %d\n",
-					row, gpio);
-			continue;
-		}
-
-		error = devm_gpio_request(dev, gpio, "keypad-row");
-		if (error)
-			dev_err(dev,
-				"keypad row[%d] gpio request failed: %d\n",
-				row, error);
-	}
-
-	for (col = 0; col < keypad->cols; col++) {
-		gpio = of_get_named_gpio(np, "col-gpios", col);
-		keypad->col_gpios[col] = gpio;
-		if (!gpio_is_valid(gpio)) {
-			dev_err(dev, "keypad column[%d]: invalid gpio %d\n",
-					col, gpio);
-			continue;
-		}
-
-		error = devm_gpio_request(dev, gpio, "keypad-col");
-		if (error)
-			dev_err(dev,
-				"keypad column[%d] gpio request failed: %d\n",
-				col, error);
-	}
-}
 #else
 static
 struct samsung_keypad_platdata *samsung_keypad_parse_dt(struct device *dev)
@@ -424,15 +380,11 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	keypad->stopped = true;
 	init_waitqueue_head(&keypad->wait);
 
-	if (pdev->dev.of_node) {
-#ifdef CONFIG_OF
-		samsung_keypad_parse_dt_gpio(&pdev->dev, keypad);
+	if (pdev->dev.of_node)
 		keypad->type = of_device_is_compatible(pdev->dev.of_node,
 					"samsung,s5pv210-keypad");
-#endif
-	} else {
+	else
 		keypad->type = platform_get_device_id(pdev)->driver_data;
-	}
 
 	input_dev->name = pdev->name;
 	input_dev->id.bustype = BUS_HOST;
-- 
1.6.6.rc2
