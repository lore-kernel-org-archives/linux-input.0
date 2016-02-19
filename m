From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] input: gpio_keys_polled: Correct check for invalid gpiod
Date: Fri, 19 Feb 2016 11:04:33 +0100
Message-ID: <1455876273-5913-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:41563 "EHLO
	albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757364AbcBSKEh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Feb 2016 05:04:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

At this point in gpio_keys_polled_probe(), button->gpiod contains either
a pointer to a GPIO descriptor or NULL, because:
  - gpio_keys_polled_get_devtree_pdata() fills in button->gpiod only if
    devm_get_gpiod_from_child() succeeded,
  - gpio_to_desc() returns NULL on failure, not an ERR_PTR(),
  - button->gpiod is untouched if it was NULL, and button->gpio is not
    valid.

Hence check for NULL only, and return -EINVAL on failure.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Question: Should it return -ENOENT instead?

next-20160219:drivers/leds/leds-gpio.c uses -EINVAL, too.
---
 drivers/input/keyboard/gpio_keys_polled.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 62bdb1d48c49dbd9..1ef3c66099a50d72 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -330,8 +330,8 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 			button->gpiod = gpio_to_desc(button->gpio);
 		}
 
-		if (IS_ERR(button->gpiod))
-			return PTR_ERR(button->gpiod);
+		if (!button->gpiod)
+			return -EINVAL;
 
 		bdata->can_sleep = gpiod_cansleep(button->gpiod);
 		bdata->last_state = -1;
-- 
1.9.1

