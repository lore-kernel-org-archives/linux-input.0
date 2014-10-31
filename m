From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 14/15] gpio: locomo: implement per-pin irq handling
Date: Fri, 31 Oct 2014 09:00:49 +0100
Message-ID: <CACRpkdamVriR9kJSeY=LVAx7ADukT8+GpqmNH9YMnL3OKUk8iw@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<1414454528-24240-15-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-leds-owner@vger.kernel.org>
In-Reply-To: <1414454528-24240-15-git-send-email-dbaryshkov@gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo
List-Id: linux-input@vger.kernel.org

On Tue, Oct 28, 2014 at 1:02 AM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:

> LoCoMo has a possibility to generate per-GPIO edge irqs. Support for
> that was there in old locomo driver, got 'cleaned up' during old driver
> IRQ cascading cleanup and is now reimplemented. It is expected that
> SL-5500 (collie) will use locomo gpio irqs for mmc detection irq.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>

Please don't use open-coded IRQ handling like this, we are moving
away from that.

In Kconfig,

select GPIOLIB_IRQCHIP

and look at the other drivers selecting this for inspiration. There
is even some documentation in Documentation/gpio/driver.txt

You will find that it cuts down a lot of overhead from your driver
and does everything in the right way in a central place.

>  struct locomo_gpio {
>         void __iomem *regs;
> +       int irq;
>
>         spinlock_t lock;
>         struct gpio_chip gpio;
> +       int irq_base;

gpiolib irqchip helpers uses irqdomain to do all this debasing
and rebasing for you. Go with that.

> +static int locomo_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
> +{
> +       struct locomo_gpio *lg = container_of(chip, struct locomo_gpio, gpio);
> +
> +       return lg->irq_base + offset;
> +}

And it implements .to_irq() in the gpiolib core.

> +static void
> +locomo_gpio_handler(unsigned int irq, struct irq_desc *desc)

It's locomo_gpio_irq_handler() right?

> +{
> +       u16 req;
> +       struct locomo_gpio *lg = irq_get_handler_data(irq);
> +       int i = lg->irq_base;
> +
> +       req = readw(lg->regs + LOCOMO_GIR) &
> +             readw(lg->regs + LOCOMO_GPD);
> +
> +       while (req) {
> +               if (req & 1)
> +                       generic_handle_irq(i);
> +               req >>= 1;
> +               i++;
> +       }

Same thing as the MFD device, look closer at how you construct
the IRQ handling loop, so the register gets re-read each iteration.

> +static void locomo_gpio_ack_irq(struct irq_data *d)
> +{
> +       struct locomo_gpio *lg = irq_data_get_irq_chip_data(d);
> +       unsigned long flags;
> +       u16 r;
> +
> +       spin_lock_irqsave(&lg->lock, flags);
> +
> +       r = readw(lg->regs + LOCOMO_GWE);
> +       r |= (0x0001 << (d->irq - lg->irq_base));
> +       writew(r, lg->regs + LOCOMO_GWE);
> +
> +       r = readw(lg->regs + LOCOMO_GIS);
> +       r &= ~(0x0001 << (d->irq - lg->irq_base));
> +       writew(r, lg->regs + LOCOMO_GIS);
> +
> +       r = readw(lg->regs + LOCOMO_GWE);
> +       r &= ~(0x0001 << (d->irq - lg->irq_base));
> +       writew(r, lg->regs + LOCOMO_GWE);
> +
> +       spin_unlock_irqrestore(&lg->lock, flags);
> +}

I really wonder if this locking is needed around these
regioster accesses. It seems more like a habit than
like something that is actually needed. Think it over.

*irqsave* versions of spinlocks are definately wrong
in the irqchip callbacks, if you give it a minute I think
you quickly realize why.

> +static int locomo_gpio_type(struct irq_data *d, unsigned int type)
> +{
> +       unsigned int mask;
> +       struct locomo_gpio *lg = irq_data_get_irq_chip_data(d);
> +       unsigned long flags;
> +
> +       mask = 1 << (d->irq - lg->irq_base);

This should just use d->hwirq with irqdomain implemented
correctly.

(...)

> +static void locomo_gpio_setup_irq(struct locomo_gpio *lg)
> +{
> +       int irq;
> +
> +       lg->irq_base = irq_alloc_descs(-1, 0, LOCOMO_GPIO_NR_IRQS, -1);
> +
> +       /* Install handlers for IRQ_LOCOMO_* */
> +       for (irq = lg->irq_base;
> +                       irq < lg->irq_base + LOCOMO_GPIO_NR_IRQS;
> +                       irq++) {
> +               irq_set_chip_and_handler(irq, &locomo_gpio_chip,
> +                               handle_edge_irq);
> +               irq_set_chip_data(irq, lg);
> +               set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> +       }
> +
> +       /*
> +        * Install handler for IRQ_LOCOMO_HW.
> +        */
> +       irq_set_handler_data(lg->irq, lg);
> +       irq_set_chained_handler(lg->irq, locomo_gpio_handler);
> +}

All this gets redundant with gpiochip_irqchip_add()
and gpiochip_set_chained_irqchip().

Yours,
Linus Walleij
