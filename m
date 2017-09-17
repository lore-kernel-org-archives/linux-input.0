From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/5] input: mouse: Rename GPIO mouse variables
Date: Sun, 17 Sep 2017 13:14:42 +0200
Message-ID: <20170917111445.30880-3-linus.walleij@linaro.org>
References: <20170917111445.30880-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:54131 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdIQLPD (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 17 Sep 2017 07:15:03 -0400
Received: by mail-lf0-f43.google.com with SMTP id k9so5652040lfe.10
        for <linux-input@vger.kernel.org>; Sun, 17 Sep 2017 04:15:02 -0700 (PDT)
In-Reply-To: <20170917111445.30880-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc: Linus Walleij <linus.walleij@linaro.org>

Use more apropriate names for the "platform data" which is
now just a simple state container for the GPIO mouse.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/mouse/gpio_mouse.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index dcaba1e4fffb..d1914bb3531f 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -26,7 +26,7 @@
 #define GPIO_MOUSE_PIN_MAX	7
 
 /**
- * struct gpio_mouse_platform_data
+ * struct gpio_mouse
  * @scan_ms: integer in ms specifying the scan periode.
  * @polarity: Pin polarity, active high or low.
  * @up: GPIO line for up value.
@@ -42,7 +42,7 @@
  * It is used by the gpio_mouse driver to setup GPIO lines and to
  * calculate mouse movement.
  */
-struct gpio_mouse_platform_data {
+struct gpio_mouse {
 	int scan_ms;
 	int polarity;
 
@@ -67,7 +67,7 @@ struct gpio_mouse_platform_data {
  */
 static void gpio_mouse_scan(struct input_polled_dev *dev)
 {
-	struct gpio_mouse_platform_data *gpio = dev->private;
+	struct gpio_mouse *gpio = dev->private;
 	struct input_dev *input = dev->input;
 	int x, y;
 
@@ -94,24 +94,24 @@ static void gpio_mouse_scan(struct input_polled_dev *dev)
 static int gpio_mouse_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	struct gpio_mouse_platform_data *pdata;
+	struct gpio_mouse *gmouse;
 	struct input_polled_dev *input_poll;
 	struct input_dev *input;
 	int pin, i;
 	int error;
 
-	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
-	if (!pdata)
+	gmouse = devm_kzalloc(dev, sizeof(*gmouse), GFP_KERNEL);
+	if (!gmouse)
 		return -ENOMEM;
 
-	if (pdata->scan_ms < 0) {
+	if (gmouse->scan_ms < 0) {
 		dev_err(&pdev->dev, "invalid scan time\n");
 		error = -EINVAL;
 		goto out;
 	}
 
 	for (i = 0; i < GPIO_MOUSE_PIN_MAX; i++) {
-		pin = pdata->pins[i];
+		pin = gmouse->pins[i];
 
 		if (pin < 0) {
 
@@ -148,9 +148,9 @@ static int gpio_mouse_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, input_poll);
 
 	/* set input-polldev handlers */
-	input_poll->private = pdata;
+	input_poll->private = gmouse;
 	input_poll->poll = gpio_mouse_scan;
-	input_poll->poll_interval = pdata->scan_ms;
+	input_poll->poll_interval = gmouse->scan_ms;
 
 	input = input_poll->input;
 	input->name = pdev->name;
@@ -159,11 +159,11 @@ static int gpio_mouse_probe(struct platform_device *pdev)
 
 	input_set_capability(input, EV_REL, REL_X);
 	input_set_capability(input, EV_REL, REL_Y);
-	if (pdata->bleft >= 0)
+	if (gmouse->bleft >= 0)
 		input_set_capability(input, EV_KEY, BTN_LEFT);
-	if (pdata->bmiddle >= 0)
+	if (gmouse->bmiddle >= 0)
 		input_set_capability(input, EV_KEY, BTN_MIDDLE);
-	if (pdata->bright >= 0)
+	if (gmouse->bright >= 0)
 		input_set_capability(input, EV_KEY, BTN_RIGHT);
 
 	error = input_register_polled_device(input_poll);
@@ -173,10 +173,10 @@ static int gpio_mouse_probe(struct platform_device *pdev)
 	}
 
 	dev_dbg(&pdev->dev, "%d ms scan time, buttons: %s%s%s\n",
-			pdata->scan_ms,
-			pdata->bleft < 0 ? "" : "left ",
-			pdata->bmiddle < 0 ? "" : "middle ",
-			pdata->bright < 0 ? "" : "right");
+			gmouse->scan_ms,
+			gmouse->bleft < 0 ? "" : "left ",
+			gmouse->bmiddle < 0 ? "" : "middle ",
+			gmouse->bright < 0 ? "" : "right");
 
 	return 0;
 
@@ -185,7 +185,7 @@ static int gpio_mouse_probe(struct platform_device *pdev)
 
  out_free_gpios:
 	while (--i >= 0) {
-		pin = pdata->pins[i];
+		pin = gmouse->pins[i];
 		if (pin)
 			gpio_free(pin);
 	}
@@ -196,14 +196,14 @@ static int gpio_mouse_probe(struct platform_device *pdev)
 static int gpio_mouse_remove(struct platform_device *pdev)
 {
 	struct input_polled_dev *input = platform_get_drvdata(pdev);
-	struct gpio_mouse_platform_data *pdata = input->private;
+	struct gpio_mouse *gmouse = input->private;
 	int pin, i;
 
 	input_unregister_polled_device(input);
 	input_free_polled_device(input);
 
 	for (i = 0; i < GPIO_MOUSE_PIN_MAX; i++) {
-		pin = pdata->pins[i];
+		pin = gmouse->pins[i];
 		if (pin >= 0)
 			gpio_free(pin);
 	}
-- 
2.13.5

