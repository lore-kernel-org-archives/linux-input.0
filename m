From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 -next] Input: gpio_keys: set input direction
 explicitly for gpio keys
Date: Wed, 16 Nov 2016 17:18:36 -0800
Message-ID: <20161117011836.GB8133@dtor-ws>
References: <1479303734-16198-1-git-send-email-sudeep.holla@arm.com>
 <1479321502-22265-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36737 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbcKQBSk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 16 Nov 2016 20:18:40 -0500
Content-Disposition: inline
In-Reply-To: <1479321502-22265-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Mika Westerberg <mika.westerberg@linux.intel.com>

On Wed, Nov 16, 2016 at 06:38:22PM +0000, Sudeep Holla wrote:
> Commit 700a38b27eef ("Input: gpio_keys - switch to using generic device
> properties") switched to use generic device properties for GPIO keys and
> commit 5feeca3c1e39 ("Input: gpio_keys - add support for GPIO descriptors")
> switched from legacy GPIO numbers to GPIO descriptors.
> 
> Previously devm_gpio_request_one was explicitly passed GPIOF_DIR_IN flag
> to set the GPIO direction as input. However devm_get_gpiod_from_child
> doesn't have such provisions and hence fwnode_get_named_gpiod can't set
> it as input.
> 
> This breaks few platforms with the following error:
> " gpiochip_lock_as_irq: tried to flag a GPIO set as output for IRQ
>   unable to lock HW IRQ <n> for IRQ
>   genirq: Failed to request resources for POWER (irq <x>) on irqchip
>   gpio_keys: Unable to claim irq <x>; error -22
>   gpio-keys: probe failed with error -22 "
> 
> This patch fixes the issue by setting input direction explicitly for
> gpio input keys. It also remove the existing GPIOF_DIR_IN flag setting
> for the legacy gpios and merges into single gpiod_direction_input call.
> 
> Fixes: 700a38b27eef ("Input: gpio_keys - switch to using generic device properties")
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/input/keyboard/gpio_keys.c        | 10 +++++++++-
>  drivers/input/keyboard/gpio_keys_polled.c | 10 +++++++++-
>  2 files changed, 18 insertions(+), 2 deletions(-)
> 
> v2->v3:
> 	- Added error handling and error message
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index 5576f2ae0b71..ed38a05b3039 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -502,7 +502,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  		 * Legacy GPIO number, so request the GPIO here and
>  		 * convert it to descriptor.
>  		 */
> -		unsigned flags = GPIOF_IN;
> +		unsigned flags = 0;
> 
>  		if (button->active_low)
>  			flags |= GPIOF_ACTIVE_LOW;

Sudeep, I looked into this aa bit deeper, and I have issue with this
part: in absence of GPIOF_IN devm_gpio_request_one() will attempt to
configure GPIO line as output, which may not work. Because of this I
think we should move gpiod_direction_input() call into the "modern"
branch and leave legacy branch as is.

Does the version below work for you?

Thanks!

-- 
Dmitry


Input: gpio_keys - set input direction explicitly for gpio keys

From: Sudeep Holla <sudeep.holla@arm.com>

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
gpio lines described by generic properties.

Fixes: 700a38b27eef ("Input: gpio_keys - switch to using generic device properties")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/gpio_keys.c        |    7 +++++++
 drivers/input/keyboard/gpio_keys_polled.c |    8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 5576f2a..582462d 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -496,6 +496,13 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 						error);
 				return error;
 			}
+		} else {
+			error = gpiod_direction_input(bdata->gpiod);
+			if (error) {
+				dev_err(dev, "Failed to configure GPIO %d as input: %d\n",
+					desc_to_gpio(bdata->gpiod), error);
+				return error;
+			}
 		}
 	} else if (gpio_is_valid(button->gpio)) {
 		/*
diff --git a/drivers/input/keyboard/gpio_keys_polled.c b/drivers/input/keyboard/gpio_keys_polled.c
index 72b3503..bed4f20 100644
--- a/drivers/input/keyboard/gpio_keys_polled.c
+++ b/drivers/input/keyboard/gpio_keys_polled.c
@@ -314,6 +314,14 @@ static int gpio_keys_polled_probe(struct platform_device *pdev)
 				fwnode_handle_put(child);
 				return error;
 			}
+
+			error = gpiod_direction_input(bdata->gpiod);
+			if (error) {
+				dev_err(dev, "Failed to configure GPIO %d as input: %d\n",
+					desc_to_gpio(bdata->gpiod), error);
+				fwnode_handle_put(child);
+				return error;
+			}
 		} else if (gpio_is_valid(button->gpio)) {
 			/*
 			 * Legacy GPIO number so request the GPIO here and
