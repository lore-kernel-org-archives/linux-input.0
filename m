From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] Input: samsung-keypad: Add support for pinctrl
Date: Thu,  6 Dec 2012 15:48:46 +0530
Message-ID: <1354789126-28304-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:56672 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422997Ab2LFKZs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Dec 2012 05:25:48 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so4338301pad.19
        for <linux-input@vger.kernel.org>; Thu, 06 Dec 2012 02:25:47 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, kgene.kim@samsung.com, sachin.kamat@linaro.org, linus.walleij@linaro.org, patches@linaro.org

Added support for pin configuration using pinctrl subsystem
to the Samsung keypad driver.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 .../devicetree/bindings/input/samsung-keypad.txt   |   12 ++++++++++++
 drivers/input/keyboard/samsung-keypad.c            |    7 ++++++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/samsung-keypad.txt b/Documentation/devicetree/bindings/input/samsung-keypad.txt
index ce3e394..616cfeb 100644
--- a/Documentation/devicetree/bindings/input/samsung-keypad.txt
+++ b/Documentation/devicetree/bindings/input/samsung-keypad.txt
@@ -25,6 +25,7 @@ Required Board Specific Properties:
 - samsung,keypad-num-columns: Number of column lines connected to the
   keypad controller.
 
+- Samsung GPIO variant (deprecated):
 - row-gpios: List of gpios used as row lines. The gpio specifier for
   this property depends on the gpio controller to which these row lines
   are connected.
@@ -33,6 +34,10 @@ Required Board Specific Properties:
   this property depends on the gpio controller to which these column
   lines are connected.
 
+- Pinctrl variant (preferred, if available):
+  - pinctrl-0: Pin control group to be used for this controller.
+  - pinctrl-names: Should contain only one value - "default".
+
 - Keys represented as child nodes: Each key connected to the keypad
   controller is represented as a child node to the keypad controller
   device node and should include the following properties.
@@ -56,6 +61,7 @@ Example:
 		linux,input-no-autorepeat;
 		linux,input-wakeup;
 
+		/* Samsung GPIO variant begins here */
 		row-gpios = <&gpx2 0 3 3 0
 			     &gpx2 1 3 3 0>;
 
@@ -67,6 +73,12 @@ Example:
 			     &gpx1 5 3 0 0
 			     &gpx1 6 3 0 0
 			     &gpx1 7 3 0 0>;
+		/* Samsung GPIO variant ends here */
+
+		/* Pinctrl variant begins here */
+		pinctrl-0 = <&keypad_row0 &keypad_col0>;
+		pinctrl-names = "default";
+		/* Pinctrl variant ends here */
 
 		key_1 {
 			keypad,row = <0>;
diff --git a/drivers/input/keyboard/samsung-keypad.c b/drivers/input/keyboard/samsung-keypad.c
index 22e357b..18770e4 100644
--- a/drivers/input/keyboard/samsung-keypad.c
+++ b/drivers/input/keyboard/samsung-keypad.c
@@ -27,6 +27,7 @@
 #include <linux/of_gpio.h>
 #include <linux/sched.h>
 #include <linux/input/samsung-keypad.h>
+#include <linux/pinctrl/consumer.h>
 
 #define SAMSUNG_KEYIFCON			0x00
 #define SAMSUNG_KEYIFSTSCLR			0x04
@@ -79,6 +80,7 @@ struct samsung_keypad {
 	unsigned int rows;
 	unsigned int cols;
 	unsigned int row_state[SAMSUNG_MAX_COLS];
+	struct pinctrl *pctrl;
 #ifdef CONFIG_OF
 	int row_gpios[SAMSUNG_MAX_ROWS];
 	int col_gpios[SAMSUNG_MAX_COLS];
@@ -424,9 +426,12 @@ static int samsung_keypad_probe(struct platform_device *pdev)
 	keypad->stopped = true;
 	init_waitqueue_head(&keypad->wait);
 
+	keypad->pctrl = devm_pinctrl_get_select_default(&pdev->dev);
+
 	if (pdev->dev.of_node) {
 #ifdef CONFIG_OF
-		samsung_keypad_parse_dt_gpio(&pdev->dev, keypad);
+		if (IS_ERR(keypad->pctrl))
+			samsung_keypad_parse_dt_gpio(&pdev->dev, keypad);
 		keypad->type = of_device_is_compatible(pdev->dev.of_node,
 					"samsung,s5pv210-keypad");
 #endif
-- 
1.7.4.1

