From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5/5 v2] input: mouse: Add device tree probing to GPIO mouse
Date: Mon, 25 Sep 2017 18:34:30 +0200
Message-ID: <20170925163430.22397-5-linus.walleij@linaro.org>
References: <20170925163430.22397-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:50369 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965206AbdIYQet (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 25 Sep 2017 12:34:49 -0400
Received: by mail-pf0-f169.google.com with SMTP id m63so4054076pfk.7
        for <linux-input@vger.kernel.org>; Mon, 25 Sep 2017 09:34:49 -0700 (PDT)
In-Reply-To: <20170925163430.22397-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Linus Walleij <linus.walleij@linaro.org>

This makes the GPIO mouse probe nicely from the device tree
if found in a tree. As the driver uses device properties it
can easily be amended to also probe from ACPI devices.

Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Collect Hans-Christian's ACK
- Rebase on the other changes.
---
 drivers/input/mouse/gpio_mouse.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index 4f3c9ca7b821..deefe0df56b4 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -14,6 +14,7 @@
 #include <linux/input-polldev.h>
 #include <linux/gpio/consumer.h>
 #include <linux/property.h>
+#include <linux/of.h>
 
 /**
  * struct gpio_mouse
@@ -158,10 +159,17 @@ static int gpio_mouse_probe(struct platform_device *pdev)
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
 	.driver		= {
 		.name	= "gpio_mouse",
+		.of_match_table = gpio_mouse_of_match,
 	}
 };
 module_platform_driver(gpio_mouse_device_driver);
-- 
2.13.5

