From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5] input: mouse: Add device tree probing to GPIO mouse
Date: Sun, 17 Sep 2017 13:14:45 +0200
Message-ID: <20170917111445.30880-6-linus.walleij@linaro.org>
References: <20170917111445.30880-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f44.google.com ([209.85.215.44]:54136 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbdIQLPJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 17 Sep 2017 07:15:09 -0400
Received: by mail-lf0-f44.google.com with SMTP id k9so5652128lfe.10
        for <linux-input@vger.kernel.org>; Sun, 17 Sep 2017 04:15:09 -0700 (PDT)
In-Reply-To: <20170917111445.30880-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc: Linus Walleij <linus.walleij@linaro.org>

This makes the GPIO mouse probe nicely from the device tree
if found in a tree. As the driver uses device properties it
can easily be amended to also probe from ACPI devices.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/mouse/gpio_mouse.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index 7bd2a8ac6e6e..bf748efb270a 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -14,6 +14,7 @@
 #include <linux/input-polldev.h>
 #include <linux/gpio/consumer.h>
 #include <linux/property.h>
+#include <linux/of.h>
 
 /**
  * struct gpio_mouse
@@ -160,11 +161,18 @@ static int gpio_mouse_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id gpio_mouse_of_match[] = {
+	{ .compatible = "gpio-mouse", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, gpio_mouse_of_match);
+
 static struct platform_driver gpio_mouse_device_driver = {
 	.probe		= gpio_mouse_probe,
 	.remove		= gpio_mouse_remove,
 	.driver		= {
 		.name	= "gpio_mouse",
+		.of_match_table = gpio_mouse_of_match,
 	}
 };
 module_platform_driver(gpio_mouse_device_driver);
@@ -173,4 +181,3 @@ MODULE_AUTHOR("Hans-Christian Egtvedt <egtvedt@samfundet.no>");
 MODULE_DESCRIPTION("GPIO mouse driver");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:gpio_mouse"); /* work with hotplug and coldplug */
-
-- 
2.13.5

