From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v2] Input: gpio_keys: allocate pins
Date: Fri, 12 Oct 2012 23:33:06 +0200
Message-ID: <1350077586-18171-1-git-send-email-zonque@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:32856 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752209Ab2JLVdY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Oct 2012 17:33:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jonas.aberg@stericsson.com, lee.jones@linaro.org, Daniel Mack <zonque@gmail.com>, Linus Walleij <linus.walleij@linaro.org>

This allows DT driven boards to allocate and configure the pinmux once
the driver is probed.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6a68041..52c6698 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -29,6 +29,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/spinlock.h>
+#include <linux/pinctrl/consumer.h>
 
 struct gpio_button_data {
 	const struct gpio_keys_button *button;
@@ -664,6 +665,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	const struct gpio_keys_platform_data *pdata = dev_get_platdata(dev);
 	struct gpio_keys_drvdata *ddata;
 	struct input_dev *input;
+	struct pinctrl *pinctrl;
 	int i, error;
 	int wakeup = 0;
 
@@ -701,6 +703,11 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	input->id.product = 0x0001;
 	input->id.version = 0x0100;
 
+	/* request pin mux */
+	pinctrl = devm_pinctrl_get_select_default(dev);
+	if (IS_ERR(pinctrl))
+		dev_info(dev, "pins are not configured from the driver\n");
+
 	/* Enable auto repeat feature of Linux input subsystem */
 	if (pdata->rep)
 		__set_bit(EV_REP, input->evbit);
-- 
1.7.11.4

