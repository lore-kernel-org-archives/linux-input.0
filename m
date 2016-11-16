From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH -next] Input: gpio_keys: set input direction explicitly for gpio keys
Date: Wed, 16 Nov 2016 11:54:58 +0000
Message-ID: <1479297298-26555-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48818 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750928AbcKPLzI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Nov 2016 06:55:08 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Mika Westerberg <mika.westerberg@linux.intel.com>

Commit 700a38b27eef ("Input: gpio_keys - switch to using generic device
properties") switched to use generic device properties for GPIO keys and
commit 5feeca3c1e39 ("Input: gpio_keys - add support for GPIO descriptors")
switched from legacy GPIO numbers to GPIO descriptors.

Previously devm_gpio_request_one was explicitly passed GPIOF_DIR_IN flag
to set the GPIO direction as input. However devm_get_gpiod_from_child
doesn't have such provisions and hence fwnode_get_named_gpiod can't set
it as input.

This breaks few platforms with the following error:
" gpiochip_lock_as_irq: tried to flag a GPIO set as output for IRQ
  unable to lock HW IRQ <n> for IRQ
  genirq: Failed to request resources for POWER (irq <x>) on irqchip
  gpio_keys: Unable to claim irq <x>; error -22
  gpio-keys: probe failed with error -22 "

This patch fixes the issue by setting input direction explicitly for
gpio input keys. It also remove the existing GPIOF_DIR_IN flag setting
for the legacy gpios and merges into single gpiod_direction_input call.

Fixes: 700a38b27eef ("Input: gpio_keys - switch to using generic device properties")
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/input/keyboard/gpio_keys.c        | 5 +++--
 drivers/input/keyboard/gpio_keys_polled.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

Hi Dmitry,

The other option would be to pass the flag explicitly and add support to
handle it in the path devm_get_gpiod_from_child would take.

Let me know your opinion.

Regards,
Sudeep

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 5576f2ae0b71..238b7be9ca98 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -502,8 +502,6 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		 * Legacy GPIO number, so request the GPIO here and
 		 * convert it to descriptor.
 		 */
-		unsigned flags = GPIOF_IN;
-
 		if (button->active_low)
 			flags |= GPIOF_ACTIVE_LOW;

@@ -521,6 +519,9 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 	}

 	if (bdata->gpiod) {
+		/* set the GPIO direction to input */
+		gpiod_direction_input(bdata->gpiod);
+
 		if (button->debounce_interval) {
 			error = gpiod_set_debounce(bdata->gpiod,
 					button->debounce_interval * 1000);
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 72b350315d43..2edff18f0758 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -319,8 +319,6 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 			 * Legacy GPIO number so request the GPIO here and
 			 * convert it to descriptor.
 			 */
-			unsigned flags = GPIOF_IN;
-
 			if (button->active_low)
 				flags |= GPIOF_ACTIVE_LOW;

@@ -342,6 +340,9 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 			}
 		}

+		/* set the GPIO direction to input */
+		gpiod_direction_input(bdata->gpiod);
+
 		bdata->last_state = -1;
 		bdata->threshold = DIV_ROUND_UP(button->debounce_interval,
 						pdata->poll_interval);
--
2.7.4

