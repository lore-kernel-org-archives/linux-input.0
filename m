From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 10/13] gpio: max77650: add GPIO support
Date: Mon, 21 Jan 2019 15:20:13 +0100
Message-ID: <CACRpkdZhy7yBZrGLxhRGaac7v5jZhgUSz9gZAhFXbevJbKjpZw@mail.gmail.com>
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-11-brgl@bgdev.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118134244.22253-11-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Brian Masney <masneyb@onstation.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylib>
List-Id: linux-input@vger.kernel.org

Hi Bartosz,

thanks for the patch!

On Fri, Jan 18, 2019 at 2:43 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Add GPIO support for max77650 mfd device. This PMIC exposes a single
> GPIO line.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Overall you know for sure what you're doing so not much to
say about the GPIO chip etc. The .set_config() is nice and
helpful (maybe you will be able to also add pull up/down
using Thomas Petazzoni's new config interfaces!)

However enlighten me on this:

> +static int max77650_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
> +{
> +       struct max77650_gpio_chip *chip = gpiochip_get_data(gc);
> +
> +       return regmap_irq_get_virq(chip->irq_chip_data, MAX77650_INT_GPI);
> +}

I know this may be opening the gates to a lot of coding, but
isn't this IRQ hierarchical? I.e. that irqchip is not in the
node of the GPIO chip but in the node of the MFD top
device, with a 1:1 mapping between some of the IRQs
and a certain GPIO line.

Using regmap IRQ makes it confusing for me so I do not
know for sure if that is the case.

I am worried that you are recreating a problem (present in many
drivers, including some written by me, mea culpa) that Brian Masney
has been trying to solve for the gpiochip inside the SPMI
GPIO (drivers/pinctrl/qcom/pinctrl-spmi-gpio.c).

I have queued Brians refactoring and solution here:
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=ib-qcom-spmi

And the overall description on what he's trying to achieve is
here:
https://marc.info/?l=linux-gpio&m=154793071511130&w=2

My problem description (which I fear will apply also to this
driver):
https://www.spinics.net/lists/linux-gpio/msg34655.html

I plan to merge Brians patches soon-ish to devel and then from
there try to construct more helpers in the gpiolib core,
and if possible fix some of the old drivers who rely on
.to_irq().

We will certainly fix ssbi-gpio as well, and that is a good start
since the Qualdcomm platforms are so pervasive in the
market.

But maybe this doesn't apply here? I am not the smartest...
Just want to make sure that it is possible to refer an
interrupt directly to this DT node, as it is indeed marked
as interrupt-controller.

Yours,
Linus Walleij
