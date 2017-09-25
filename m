From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/5 v2] input: mouse: Convert GPIO mouse to use descriptors
Date: Mon, 25 Sep 2017 18:34:29 +0200
Message-ID: <20170925163430.22397-4-linus.walleij@linaro.org>
References: <20170925163430.22397-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:49501 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965206AbdIYQer (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 25 Sep 2017 12:34:47 -0400
Received: by mail-pf0-f172.google.com with SMTP id l188so4055778pfc.6
        for <linux-input@vger.kernel.org>; Mon, 25 Sep 2017 09:34:47 -0700 (PDT)
In-Reply-To: <20170925163430.22397-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Linus Walleij <linus.walleij@linaro.org>

This converts the GPIO mouse to use descriptors and
fwnode properties. The polarity settings go out the window
since GPIO descriptor already know about polarity so this
should be configured in device tree or ACPI or similar.

Set scanning interval by default to 50ms if not found as
a property on the device.

Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Collect Hans-Christian's ACK
- Use devm_gpiod_get_optional() on the buttons.
- Check button optional descriptors with IS_ERR() and
  handle errors properly.
- If a button gpiod is !NULL it is valid
- Since we are using devm_* to allocate the input device,
  the .remove() function is not needed at all, so removed
  it.
---
 drivers/input/mouse/gpio_mouse.c | 193 ++++++++++++++-------------------------
 1 file changed, 69 insertions(+), 124 deletions(-)

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index d1914bb3531f..4f3c9ca7b821 100644
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
+	if (gpio->bleft)
 		input_report_key(input, BTN_LEFT,
-				gpio_get_value(gpio->bleft) ^ gpio->polarity);
-	if (gpio->bmiddle >= 0)
+				 gpiod_get_value(gpio->bleft));
+	if (gpio->bmiddle)
 		input_report_key(input, BTN_MIDDLE,
-				gpio_get_value(gpio->bmiddle) ^ gpio->polarity);
-	if (gpio->bright >= 0)
+				 gpiod_get_value(gpio->bmiddle));
+	if (gpio->bright)
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
@@ -97,52 +75,51 @@ static int gpio_mouse_probe(struct platform_device *pdev)
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
+	/* Assign some default scanning time */
+	ret = device_property_read_u32(dev, "scan-interval-ms",
+				       &gmouse->scan_ms);
+	if (ret || (gmouse->scan_ms == 0)) {
+		dev_err(dev, "invalid scan time, set to 50 ms\n");
+		gmouse->scan_ms = 50;
 	}
 
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
-	}
-
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
+	gmouse->bleft = devm_gpiod_get_optional(dev, "button-left", GPIOD_IN);
+	if (IS_ERR(gmouse->bleft))
+		return PTR_ERR(gmouse->bleft);
+	gmouse->bmiddle = devm_gpiod_get_optional(dev, "button-middle", GPIOD_IN);
+	if (IS_ERR(gmouse->bmiddle))
+		return PTR_ERR(gmouse->bmiddle);
+	gmouse->bright = devm_gpiod_get_optional(dev, "button-right", GPIOD_IN);
+	if (IS_ERR(gmouse->bright))
+		return PTR_ERR(gmouse->bright);
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
@@ -159,61 +136,30 @@ static int gpio_mouse_probe(struct platform_device *pdev)
 
 	input_set_capability(input, EV_REL, REL_X);
 	input_set_capability(input, EV_REL, REL_Y);
-	if (gmouse->bleft >= 0)
+	if (gmouse->bleft)
 		input_set_capability(input, EV_KEY, BTN_LEFT);
-	if (gmouse->bmiddle >= 0)
+	if (gmouse->bmiddle)
 		input_set_capability(input, EV_KEY, BTN_MIDDLE);
-	if (gmouse->bright >= 0)
+	if (gmouse->bright)
 		input_set_capability(input, EV_KEY, BTN_RIGHT);
 
-	error = input_register_polled_device(input_poll);
-	if (error) {
-		dev_err(&pdev->dev, "could not register input device\n");
-		goto out_free_polldev;
-	}
-
-	dev_dbg(&pdev->dev, "%d ms scan time, buttons: %s%s%s\n",
-			gmouse->scan_ms,
-			gmouse->bleft < 0 ? "" : "left ",
-			gmouse->bmiddle < 0 ? "" : "middle ",
-			gmouse->bright < 0 ? "" : "right");
-
-	return 0;
-
- out_free_polldev:
-	input_free_polled_device(input_poll);
-
- out_free_gpios:
-	while (--i >= 0) {
-		pin = gmouse->pins[i];
-		if (pin)
-			gpio_free(pin);
+	ret = input_register_polled_device(input_poll);
+	if (ret) {
+		dev_err(dev, "could not register input device\n");
+		return ret;
 	}
- out:
-	return error;
-}
 
-static int gpio_mouse_remove(struct platform_device *pdev)
-{
-	struct input_polled_dev *input = platform_get_drvdata(pdev);
-	struct gpio_mouse *gmouse = input->private;
-	int pin, i;
-
-	input_unregister_polled_device(input);
-	input_free_polled_device(input);
-
-	for (i = 0; i < GPIO_MOUSE_PIN_MAX; i++) {
-		pin = gmouse->pins[i];
-		if (pin >= 0)
-			gpio_free(pin);
-	}
+	dev_dbg(dev, "%d ms scan time, buttons: %s%s%s\n",
+		gmouse->scan_ms,
+		gmouse->bleft ? "" : "left ",
+		gmouse->bmiddle ? "" : "middle ",
+		gmouse->bright ? "" : "right");
 
 	return 0;
 }
 
 static struct platform_driver gpio_mouse_device_driver = {
 	.probe		= gpio_mouse_probe,
-	.remove		= gpio_mouse_remove,
 	.driver		= {
 		.name	= "gpio_mouse",
 	}
@@ -224,4 +170,3 @@ MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
 MODULE_DESCRIPTION("GPIO mouse driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:gpio_mouse"); /* work with hotplug and coldplug */
-
-- 
2.13.5

