From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 1/5] Input: gpio-keys: Support getting descriptors from board
Date: Fri, 24 Nov 2017 10:30:41 +0100
Message-ID: <20171124093045.5961-2-linus.walleij@linaro.org>
References: <20171124093045.5961-1-linus.walleij@linaro.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36215 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbdKXJav (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Nov 2017 04:30:51 -0500
Received: by mail-lf0-f68.google.com with SMTP id k66so24748664lfg.3
        for <linux-input@vger.kernel.org>; Fri, 24 Nov 2017 01:30:51 -0800 (PST)
In-Reply-To: <20171124093045.5961-1-linus.walleij@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>

There are any number of board files in the kernel providing
keys/pushbuttons/switches using simple GPIO. In order to
transfer these smoothly to use GPIO descriptors with
descriptor tables in the board files and no static GPIO
numbers, we need to accept that the board files provide
named GPIOs associated with the GPIO chip device.

Luckily gpio_keys of both polled and interrupt-enabled
type will optionally pass a "desc" field which we can use
as the name of the GPIO to look up and request a GPIO
line for a certain key defined in a per-board descriptor
lookup table.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/input/keyboard/gpio_keys.c        | 14 +++++++++++++-
 drivers/input/keyboard/gpio_keys_polled.c | 10 ++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 87e613dc33b8..420262a4fd54 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -520,7 +520,9 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	} else if (gpio_is_valid(button->gpio)) {
 		/*
 		 * Legacy GPIO number, so request the GPIO here and
-		 * convert it to descriptor.
+		 * convert it to descriptor. This code goes away once
+		 * we convert all old board files to provide descriptor
+		 * tables.
 		 */
 		unsigned flags = GPIOF_IN;
 
@@ -537,6 +539,16 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		bdata->gpiod = gpio_to_desc(button->gpio);
 		if (!bdata->gpiod)
 			return -EINVAL;
+	} else {
+		/*
+		 * Try to look up from the descriptor table, includes
+		 * letting gpiolib handle inversion semantics. This is
+		 * optional since we have interrupt-only keys as well.
+		 */
+		bdata->gpiod = devm_gpiod_get_optional(dev, desc,
+						       GPIOD_IN);
+		if (IS_ERR(bdata->gpiod))
+			return PTR_ERR(bdata->gpiod);
 	}
 
 	if (bdata->gpiod) {
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index edc7262103b9..1bc428a7edea 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -342,6 +342,16 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 					button->gpio);
 				return -EINVAL;
 			}
+		} else {
+			/*
+			 * Try to look up from the descriptor table, includes
+			 * letting gpiolib handle inversion semantics.
+			 */
+			bdata->gpiod = devm_gpiod_get_optional(dev,
+							       button->desc,
+							       GPIOD_IN);
+			if (IS_ERR(bdata->gpiod))
+				return PTR_ERR(bdata->gpiod);
 		}
 
 		bdata->last_state = -1;
-- 
2.14.3

