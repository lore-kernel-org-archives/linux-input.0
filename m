From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: gpio_keys: Switch from irq_of_parse_and_map()
 to platform_get_irq()
Date: Tue, 23 Feb 2016 11:35:48 -0800
Message-ID: <20160223193548.GC30638@dtor-ws>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
 <1455876982-6743-3-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455876982-6743-3-git-send-email-geert+renesas@glider.be>
Sender: linux-gpio-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Aaron Lu <aaron.lu@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vincent Pelletier <plr.vincent@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Feb 19, 2016 at 11:16:21AM +0100, Geert Uytterhoeven wrote:
> Note that irq_of_parse_and_map() returns 0 on failure, while
> platform_get_irq() returns -ENXIO on failure, so we have to make irq
> signed, and update all error checks.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/input/keyboard/gpio_keys.c | 16 ++++++++--------
>  include/linux/gpio_keys.h          |  2 +-
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
> index d2b6c3acd9c32f1d..b6262d94aff19f70 100644
> --- a/drivers/input/keyboard/gpio_keys.c
> +++ b/drivers/input/keyboard/gpio_keys.c
> @@ -30,7 +30,6 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_gpio.h>
> -#include <linux/of_irq.h>
>  #include <linux/spinlock.h>
>  
>  struct gpio_button_data {
> @@ -511,7 +510,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  						button->debounce_interval;
>  		}
>  
> -		if (button->irq) {
> +		if (button->irq >= 0) {
>  			bdata->irq = button->irq;
>  		} else {
>  			irq = gpiod_to_irq(button->gpiod);
> @@ -531,7 +530,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
>  		irqflags = IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING;
>  
>  	} else {
> -		if (!button->irq) {
> +		if (button->irq < 0) {
>  			dev_err(dev, "No IRQ specified\n");
>  			return -EINVAL;
>  		}
> @@ -631,8 +630,9 @@ static void gpio_keys_close(struct input_dev *input)
>   * Translate OpenFirmware node properties into platform_data
>   */
>  static struct gpio_keys_platform_data *
> -gpio_keys_get_devtree_pdata(struct device *dev)
> +gpio_keys_get_devtree_pdata(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct device_node *node, *pp;
>  	struct gpio_keys_platform_data *pdata;
>  	struct gpio_keys_button *button;
> @@ -681,9 +681,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
>  			button->active_low = flags & OF_GPIO_ACTIVE_LOW;
>  		}
>  
> -		button->irq = irq_of_parse_and_map(pp, 0);
> +		button->irq = platform_get_irq(pdev, 0);

There are a lot of current users of platform data that do not specify
button IRQ (and leave it as 0). If we start treating 0 as valid IRQ
number then we may break them.

I do not think that any real setup will actually use IRQ 0 as anything
but timer, so can we do:

		int irq;

		...

		irq = platform_get_irq(pdev, 0);
		if (irq < 0) {
			if (irq == -EPROBE_DEFER)
				return ERR_PTR(-EPROBE_DEFER);

			/* The driver treats IRQ 0 as invalid */
			irq = 0;
		}

		button->irq = irq;

and leave the rest of the code and users as is?


Or maybe inner condition should be:

			if (irq != -ENXIO)
				return ERR_PTR(irq);

Thanks.

-- 
Dmitry
