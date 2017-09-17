From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5] input: mouse: Convert GPIO mouse to use descriptors
Date: Sun, 17 Sep 2017 13:14:44 +0200
Message-ID: <20170917111445.30880-5-linus.walleij@linaro.org>
References: <20170917111445.30880-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:43206 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750860AbdIQLPH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 17 Sep 2017 07:15:07 -0400
Received: by mail-lf0-f52.google.com with SMTP id c80so5677662lfh.0
        for <linux-input@vger.kernel.org>; Sun, 17 Sep 2017 04:15:06 -0700 (PDT)
In-Reply-To: <20170917111445.30880-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc: Linus Walleij <linus.walleij@linaro.org>

This converts the GPIO mouse to use descriptors and
fwnode properties. The polarity settings go out the window
since GPIO descriptor already know about polarity so this
should be configured in device tree or ACPI or similar.

Set scanning interval by default to 50ms if not found as
a property on the device.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/mouse/gpio_mouse.c | 171 ++++++++++++++-------------------------
 1 file changed, 60 insertions(+), 111 deletions(-)

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index d1914bb3531f..7bd2a8ac6e6e 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -2,6 +2,7 @@
  * Driver for simulating a mouse on GPIO lines.
  *
  * Copyright (C) 2007 Atmel Corporation
+ * Copyright (C) 2017 Linus Walleij <linus.walleij@linaro.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -11,24 +12,12 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/input-polldev.h>
-#include <linux/gpio.h>
-
-#define GPIO_MOUSE_POLARITY_ACT_HIGH	0x00
-#define GPIO_MOUSE_POLARITY_ACT_LOW	0x01
-
-#define GPIO_MOUSE_PIN_UP	0
-#define GPIO_MOUSE_PIN_DOWN	1
-#define GPIO_MOUSE_PIN_LEFT	2
-#define GPIO_MOUSE_PIN_RIGHT	3
-#define GPIO_MOUSE_PIN_BLEFT	4
-#define GPIO_MOUSE_PIN_BMIDDLE	5
-#define GPIO_MOUSE_PIN_BRIGHT	6
-#define GPIO_MOUSE_PIN_MAX	7
+#include <linux/gpio/consumer.h>
+#include <linux/property.h>
 
 /**
  * struct gpio_mouse
- * @scan_ms: integer in ms specifying the scan periode.
- * @polarity: Pin polarity, active high or low.
+ * @scan_ms: the scan interval in milliseconds.
  * @up: GPIO line for up value.
  * @down: GPIO line for down value.
  * @left: GPIO line for left value.
@@ -36,29 +25,20 @@
  * @bleft: GPIO line for left button.
  * @bmiddle: GPIO line for middle button.
  * @bright: GPIO line for right button.
- * @pins: GPIO line numbers used for the mouse.
  *
  * This struct must be added to the platform_device in the board code.
  * It is used by the gpio_mouse driver to setup GPIO lines and to
  * calculate mouse movement.
  */
 struct gpio_mouse {
-	int scan_ms;
-	int polarity;
-
-	union {
-		struct {
-			int up;
-			int down;
-			int left;
-			int right;
-
-			int bleft;
-			int bmiddle;
-			int bright;
-		};
-		int pins[GPIO_MOUSE_PIN_MAX];
-	};
+	u32 scan_ms;
+	struct gpio_desc *up;
+	struct gpio_desc *down;
+	struct gpio_desc *left;
+	struct gpio_desc *right;
+	struct gpio_desc *bleft;
+	struct gpio_desc *bmiddle;
+	struct gpio_desc *bright;
 };
 
 /*
@@ -71,20 +51,18 @@ static void gpio_mouse_scan(struct input_polled_dev *dev)
 	struct input_dev *input = dev->input;
 	int x, y;
 
-	if (gpio->bleft >= 0)
+	if (!IS_ERR(gpio->bleft))
 		input_report_key(input, BTN_LEFT,
-				gpio_get_value(gpio->bleft) ^ gpio->polarity);
-	if (gpio->bmiddle >= 0)
+				 gpiod_get_value(gpio->bleft));
+	if (!IS_ERR(gpio->bmiddle))
 		input_report_key(input, BTN_MIDDLE,
-				gpio_get_value(gpio->bmiddle) ^ gpio->polarity);
-	if (gpio->bright >= 0)
+				 gpiod_get_value(gpio->bmiddle));
+	if (!IS_ERR(gpio->bright))
 		input_report_key(input, BTN_RIGHT,
-				gpio_get_value(gpio->bright) ^ gpio->polarity);
+				 gpiod_get_value(gpio->bright));
 
-	x = (gpio_get_value(gpio->right) ^ gpio->polarity)
-		- (gpio_get_value(gpio->left) ^ gpio->polarity);
-	y = (gpio_get_value(gpio->down) ^ gpio->polarity)
-		- (gpio_get_value(gpio->up) ^ gpio->polarity);
+	x = gpiod_get_value(gpio->right) - gpiod_get_value(gpio->left);
+	y = gpiod_get_value(gpio->down) - gpiod_get_value(gpio->up);
 
 	input_report_rel(input, REL_X, x);
 	input_report_rel(input, REL_Y, y);
@@ -97,52 +75,45 @@ static int gpio_mouse_probe(struct platform_device *pdev)
 	struct gpio_mouse *gmouse;
 	struct input_polled_dev *input_poll;
 	struct input_dev *input;
-	int pin, i;
-	int error;
+	int ret;
 
 	gmouse = devm_kzalloc(dev, sizeof(*gmouse), GFP_KERNEL);
 	if (!gmouse)
 		return -ENOMEM;
 
-	if (gmouse->scan_ms < 0) {
-		dev_err(&pdev->dev, "invalid scan time\n");
-		error = -EINVAL;
-		goto out;
-	}
-
-	for (i = 0; i < GPIO_MOUSE_PIN_MAX; i++) {
-		pin = gmouse->pins[i];
-
-		if (pin < 0) {
-
-			if (i <= GPIO_MOUSE_PIN_RIGHT) {
-				/* Mouse direction is required. */
-				dev_err(&pdev->dev,
-					"missing GPIO for directions\n");
-				error = -EINVAL;
-				goto out_free_gpios;
-			}
-
-			if (i == GPIO_MOUSE_PIN_BLEFT)
-				dev_dbg(&pdev->dev, "no left button defined\n");
-
-		} else {
-			error = gpio_request(pin, "gpio_mouse");
-			if (error) {
-				dev_err(&pdev->dev, "fail %d pin (%d idx)\n",
-					pin, i);
-				goto out_free_gpios;
-			}
-
-			gpio_direction_input(pin);
-		}
+	/* Assign some default scanning time */
+	ret = device_property_read_u32(dev, "scan-interval",
+				       &gmouse->scan_ms);
+	if (ret || (gmouse->scan_ms == 0)) {
+		dev_err(dev, "invalid scan time, set to 50 ms\n");
+		gmouse->scan_ms = 50;
 	}
 
-	input_poll = input_allocate_polled_device();
+	/*
+	 * These are compulsory GPIOs so bail out if any of them are
+	 * not found.
+	 */
+	gmouse->up = devm_gpiod_get(dev, "up", GPIOD_IN);
+	if (IS_ERR(gmouse->up))
+		return PTR_ERR(gmouse->up);
+	gmouse->down = devm_gpiod_get(dev, "down", GPIOD_IN);
+	if (IS_ERR(gmouse->down))
+		return PTR_ERR(gmouse->down);
+	gmouse->left = devm_gpiod_get(dev, "left", GPIOD_IN);
+	if (IS_ERR(gmouse->left))
+		return PTR_ERR(gmouse->left);
+	gmouse->right = devm_gpiod_get(dev, "right", GPIOD_IN);
+	if (IS_ERR(gmouse->right))
+		return PTR_ERR(gmouse->right);
+
+	gmouse->bleft = devm_gpiod_get(dev, "button-left", GPIOD_IN);
+	gmouse->bmiddle = devm_gpiod_get(dev, "button-middle", GPIOD_IN);
+	gmouse->bright = devm_gpiod_get(dev, "button-right", GPIOD_IN);
+
+	input_poll = devm_input_allocate_polled_device(dev);
 	if (!input_poll) {
-		dev_err(&pdev->dev, "not enough memory for input device\n");
-		error = -ENOMEM;
-		goto out_free_gpios;
+		dev_err(dev, "not enough memory for input device\n");
+		return -ENOMEM;
 	}
 
 	platform_set_drvdata(pdev, input_poll);
@@ -166,48 +137,26 @@ static int gpio_mouse_probe(struct platform_device *pdev)
 	if (gmouse->bright >= 0)
 		input_set_capability(input, EV_KEY, BTN_RIGHT);
 
-	error = input_register_polled_device(input_poll);
-	if (error) {
-		dev_err(&pdev->dev, "could not register input device\n");
-		goto out_free_polldev;
+	ret = input_register_polled_device(input_poll);
+	if (ret) {
+		dev_err(dev, "could not register input device\n");
+		return ret;
 	}
 
-	dev_dbg(&pdev->dev, "%d ms scan time, buttons: %s%s%s\n",
-			gmouse->scan_ms,
-			gmouse->bleft < 0 ? "" : "left ",
-			gmouse->bmiddle < 0 ? "" : "middle ",
-			gmouse->bright < 0 ? "" : "right");
+	dev_dbg(dev, "%d ms scan time, buttons: %s%s%s\n",
+		gmouse->scan_ms,
+		IS_ERR(gmouse->bleft) ? "" : "left ",
+		IS_ERR(gmouse->bmiddle) ? "" : "middle ",
+		IS_ERR(gmouse->bright) ? "" : "right");
 
 	return 0;
-
- out_free_polldev:
-	input_free_polled_device(input_poll);
-
- out_free_gpios:
-	while (--i >= 0) {
-		pin = gmouse->pins[i];
-		if (pin)
-			gpio_free(pin);
-	}
- out:
-	return error;
 }
 
 static int gpio_mouse_remove(struct platform_device *pdev)
 {
 	struct input_polled_dev *input = platform_get_drvdata(pdev);
-	struct gpio_mouse *gmouse = input->private;
-	int pin, i;
 
 	input_unregister_polled_device(input);
-	input_free_polled_device(input);
-
-	for (i = 0; i < GPIO_MOUSE_PIN_MAX; i++) {
-		pin = gmouse->pins[i];
-		if (pin >= 0)
-			gpio_free(pin);
-	}
-
 	return 0;
 }
 
-- 
2.13.5

