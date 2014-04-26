From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v2] input: gpio-beeper: Simplify GPIO handling
Date: Sat, 26 Apr 2014 09:46:54 +0400
Message-ID: <1398491214-14936-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fallback6.mail.ru ([94.100.176.134]:42094 "EHLO
	fallback6.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbaDZFrW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 26 Apr 2014 01:47:22 -0400
Received: from smtp15.mail.ru (smtp15.mail.ru [94.100.176.133])
	by fallback6.mail.ru (mPOP.Fallback_MX) with ESMTP id BE7A33B5EC47
	for <linux-input@vger.kernel.org>; Sat, 26 Apr 2014 09:47:20 +0400 (MSK)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alexander Shiyan <shc_work@mail.ru>

This patch simplifies GPIO handling in the driver by using GPIO
functions based on descriptors. As a result this driver now can
be used for boards without DT support.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/input/misc/Kconfig       |  2 +-
 drivers/input/misc/gpio-beeper.c | 34 +++++++++++++++-------------------
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 5928ea7..2ff4425 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -224,7 +224,7 @@ config INPUT_GP2A
 
 config INPUT_GPIO_BEEPER
 	tristate "Generic GPIO Beeper support"
-	depends on OF_GPIO
+	depends on GPIOLIB
 	help
 	  Say Y here if you have a beeper connected to a GPIO pin.
 
diff --git a/drivers/input/misc/gpio-beeper.c b/drivers/input/misc/gpio-beeper.c
index b757435..4b90877 100644
--- a/drivers/input/misc/gpio-beeper.c
+++ b/drivers/input/misc/gpio-beeper.c
@@ -1,7 +1,7 @@
 /*
  * Generic GPIO beeper driver
  *
- * Copyright (C) 2013 Alexander Shiyan <shc_work@mail.ru>
+ * Copyright (C) 2013-2014 Alexander Shiyan <shc_work@mail.ru>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -11,7 +11,7 @@
 
 #include <linux/input.h>
 #include <linux/module.h>
-#include <linux/of_gpio.h>
+#include <linux/gpio.h>
 #include <linux/workqueue.h>
 #include <linux/platform_device.h>
 
@@ -19,14 +19,13 @@
 
 struct gpio_beeper {
 	struct work_struct	work;
-	int			gpio;
-	bool			active_low;
-	bool			beeping;
+	struct gpio_desc	*desc;
+	int			beeping;
 };
 
-static void gpio_beeper_toggle(struct gpio_beeper *beep, bool on)
+static void gpio_beeper_toggle(struct gpio_beeper *beep, int val)
 {
-	gpio_set_value_cansleep(beep->gpio, on ^ beep->active_low);
+	gpiod_set_value_cansleep(beep->desc, val);
 }
 
 static void gpio_beeper_work(struct work_struct *work)
@@ -59,24 +58,24 @@ static void gpio_beeper_close(struct input_dev *input)
 	struct gpio_beeper *beep = input_get_drvdata(input);
 
 	cancel_work_sync(&beep->work);
-	gpio_beeper_toggle(beep, false);
+	gpio_beeper_toggle(beep, 0);
 }
 
 static int gpio_beeper_probe(struct platform_device *pdev)
 {
 	struct gpio_beeper *beep;
-	enum of_gpio_flags flags;
 	struct input_dev *input;
-	unsigned long gflags;
 	int err;
 
 	beep = devm_kzalloc(&pdev->dev, sizeof(*beep), GFP_KERNEL);
 	if (!beep)
 		return -ENOMEM;
 
-	beep->gpio = of_get_gpio_flags(pdev->dev.of_node, 0, &flags);
-	if (!gpio_is_valid(beep->gpio))
-		return beep->gpio;
+	beep->desc = devm_gpiod_get(&pdev->dev, NULL);
+	if (!beep->desc)
+		return -EINVAL;
+	if (IS_ERR(beep->desc))
+		return PTR_ERR(beep->desc);
 
 	input = devm_input_allocate_device(&pdev->dev);
 	if (!input)
@@ -94,10 +93,7 @@ static int gpio_beeper_probe(struct platform_device *pdev)
 
 	input_set_capability(input, EV_SND, SND_BELL);
 
-	beep->active_low = flags & OF_GPIO_ACTIVE_LOW;
-	gflags = beep->active_low ? GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
-
-	err = devm_gpio_request_one(&pdev->dev, beep->gpio, gflags, pdev->name);
+	err = gpiod_direction_output(beep->desc, 0);
 	if (err)
 		return err;
 
@@ -106,7 +102,7 @@ static int gpio_beeper_probe(struct platform_device *pdev)
 	return input_register_device(input);
 }
 
-static struct of_device_id gpio_beeper_of_match[] = {
+static struct of_device_id __maybe_unused gpio_beeper_of_match[] = {
 	{ .compatible = BEEPER_MODNAME, },
 	{ }
 };
@@ -116,7 +112,7 @@ static struct platform_driver gpio_beeper_platform_driver = {
 	.driver	= {
 		.name		= BEEPER_MODNAME,
 		.owner		= THIS_MODULE,
-		.of_match_table	= gpio_beeper_of_match,
+		.of_match_table	= of_match_ptr(gpio_beeper_of_match),
 	},
 	.probe	= gpio_beeper_probe,
 };
-- 
1.8.3.2

