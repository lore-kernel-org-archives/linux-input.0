From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/5 v2] input: mouse: Kill off platform data for GPIO mouse
Date: Mon, 25 Sep 2017 18:34:26 +0200
Message-ID: <20170925163430.22397-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:52314 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964935AbdIYQej (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 25 Sep 2017 12:34:39 -0400
Received: by mail-pg0-f47.google.com with SMTP id i195so4264750pgd.9
        for <linux-input@vger.kernel.org>; Mon, 25 Sep 2017 09:34:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Linus Walleij <linus.walleij@linaro.org>

This is not used much: git grep  gpio_mouse_platform_data shows
that absolutely nothing in the kernel defines this platform
data.

It could be argued that the driver should be deleted. But that
is a bit harsh I think since it seems generally useful. So
this patch starts a series which repurposes it to be used with
hardware nodes from device tree or ACPI.

This first patch simply localize the platform data header and
allocates a dummy platform data.

Yes: this patch leaves the driver in a pretty useless state,
but since nothing is instantiating this driver, it doesn't
make it more useless than it already is. Later patches makes
use of the driver.

Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Collect Hand-Christian's ACK
---
 drivers/input/mouse/gpio_mouse.c | 59 +++++++++++++++++++++++++++++++++-----
 include/linux/gpio_mouse.h       | 61 ----------------------------------------
 2 files changed, 52 insertions(+), 68 deletions(-)
 delete mode 100644 include/linux/gpio_mouse.h

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index ced07391304b..dcaba1e4fffb 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -12,8 +12,54 @@
 #include <linux/platform_device.h>
 #include <linux/input-polldev.h>
 #include <linux/gpio.h>
-#include <linux/gpio_mouse.h>
 
+#define GPIO_MOUSE_POLARITY_ACT_HIGH	0x00
+#define GPIO_MOUSE_POLARITY_ACT_LOW	0x01
+
+#define GPIO_MOUSE_PIN_UP	0
+#define GPIO_MOUSE_PIN_DOWN	1
+#define GPIO_MOUSE_PIN_LEFT	2
+#define GPIO_MOUSE_PIN_RIGHT	3
+#define GPIO_MOUSE_PIN_BLEFT	4
+#define GPIO_MOUSE_PIN_BMIDDLE	5
+#define GPIO_MOUSE_PIN_BRIGHT	6
+#define GPIO_MOUSE_PIN_MAX	7
+
+/**
+ * struct gpio_mouse_platform_data
+ * @scan_ms: integer in ms specifying the scan periode.
+ * @polarity: Pin polarity, active high or low.
+ * @up: GPIO line for up value.
+ * @down: GPIO line for down value.
+ * @left: GPIO line for left value.
+ * @right: GPIO line for right value.
+ * @bleft: GPIO line for left button.
+ * @bmiddle: GPIO line for middle button.
+ * @bright: GPIO line for right button.
+ * @pins: GPIO line numbers used for the mouse.
+ *
+ * This struct must be added to the platform_device in the board code.
+ * It is used by the gpio_mouse driver to setup GPIO lines and to
+ * calculate mouse movement.
+ */
+struct gpio_mouse_platform_data {
+	int scan_ms;
+	int polarity;
+
+	union {
+		struct {
+			int up;
+			int down;
+			int left;
+			int right;
+
+			int bleft;
+			int bmiddle;
+			int bright;
+		};
+		int pins[GPIO_MOUSE_PIN_MAX];
+	};
+};
 
 /*
  * Timer function which is run every scan_ms ms when the device is opened.
@@ -47,17 +93,16 @@ static void gpio_mouse_scan(struct input_polled_dev *dev)
 
 static int gpio_mouse_probe(struct platform_device *pdev)
 {
-	struct gpio_mouse_platform_data *pdata = dev_get_platdata(&pdev->dev);
+	struct device *dev = &pdev->dev;
+	struct gpio_mouse_platform_data *pdata;
 	struct input_polled_dev *input_poll;
 	struct input_dev *input;
 	int pin, i;
 	int error;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "no platform data\n");
-		error = -ENXIO;
-		goto out;
-	}
+	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return -ENOMEM;
 
 	if (pdata->scan_ms < 0) {
 		dev_err(&pdev->dev, "invalid scan time\n");
diff --git a/include/linux/gpio_mouse.h b/include/linux/gpio_mouse.h
deleted file mode 100644
index 44ed7aa14d85..000000000000
--- a/include/linux/gpio_mouse.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/*
- * Driver for simulating a mouse on GPIO lines.
- *
- * Copyright (C) 2007 Atmel Corporation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef _GPIO_MOUSE_H
-#define _GPIO_MOUSE_H
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
-
-/**
- * struct gpio_mouse_platform_data
- * @scan_ms: integer in ms specifying the scan periode.
- * @polarity: Pin polarity, active high or low.
- * @up: GPIO line for up value.
- * @down: GPIO line for down value.
- * @left: GPIO line for left value.
- * @right: GPIO line for right value.
- * @bleft: GPIO line for left button.
- * @bmiddle: GPIO line for middle button.
- * @bright: GPIO line for right button.
- *
- * This struct must be added to the platform_device in the board code.
- * It is used by the gpio_mouse driver to setup GPIO lines and to
- * calculate mouse movement.
- */
-struct gpio_mouse_platform_data {
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
-};
-
-#endif /* _GPIO_MOUSE_H */
-- 
2.13.5

