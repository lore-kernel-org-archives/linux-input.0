From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 02/15] GPIO: port LoCoMo gpio support from old driver
Date: Fri, 31 Oct 2014 08:48:35 +0100
Message-ID: <CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo
List-Id: linux-input@vger.kernel.org

On Tue, Oct 28, 2014 at 1:01 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> Add gpiolib driver for gpio pins placed on the LoCoMo GA.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

(...)
> +static int locomo_gpio_get(struct gpio_chip *chip,
> +               unsigned offset)
> +{
> +       struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
> +
> +       return readw(lg->regs + LOCOMO_GPL) & (1 << offset);

Do this:

#include <linux/bitops.h>

return !!(readw(lg->regs + LOCOMO_GPL) & BIT(offset));

So you clamp the returned value to a bool.

> +static void __locomo_gpio_set(struct gpio_chip *chip,
> +               unsigned offset, int value)
> +{
> +       struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
> +       u16  r;
> +
> +       r = readw(lg->regs + LOCOMO_GPO);
> +       if (value)
> +               r |= 1 << offset;

r |= BIT(offset);

> +       else
> +               r &= ~(1 << offset);

r &= BIT(offset);

(etc, everywhere this pattern occurs).
> +static void locomo_gpio_set(struct gpio_chip *chip,
> +               unsigned offset, int value)
> +{
> +       struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&lg->lock, flags);
> +
> +       __locomo_gpio_set(chip, offset, value);
> +
> +       spin_unlock_irqrestore(&lg->lock, flags);

If you actually always have to be getting and releasing a spin lock around
the register writes, contemplate using regmap-mmio because that
is part of what it does.

But is this locking really necessary?

> +static int locomo_gpio_remove(struct platform_device *pdev)
> +{
> +       struct locomo_gpio *lg = platform_get_drvdata(pdev);
> +       int ret;
> +
> +       ret = gpiochip_remove(&lg->gpio);
> +       if (ret) {
> +               dev_err(&pdev->dev, "Can't remove gpio chip: %d\n", ret);
> +               return ret;
> +       }

The return value from gpiochip_remove() has been removed in v3.18-rc1
so this will not compile.

Yours,
Linus Walleij
