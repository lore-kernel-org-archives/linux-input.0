From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/15] mfd: add new driver for Sharp LoCoMo
Date: Fri, 31 Oct 2014 08:42:24 +0100
Message-ID: <CACRpkdbW3NA00zMZr216ZeZpgVkXwKUo30biTVd5kcHKGGtkHg@mail.gmail.com>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
	<1414454528-24240-2-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1414454528-24240-2-git-send-email-dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-fbdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Andrea Adami <andrea.adami-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bryan Wu <cooloney-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jingoo
List-Id: linux-input@vger.kernel.org

On Tue, Oct 28, 2014 at 1:01 AM, Dmitry Eremin-Solenikov
<dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> LoCoMo is a GA used on Sharp Zaurus SL-5x00. Current driver does has
> several design issues (special bus instead of platform bus, doesn't use
> mfd-core, etc).
>
> Implement 'core' parts of locomo support as an mfd driver.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
(...)

> +/* DAC send data */
> +#define        M62332_SLAVE_ADDR       0x4e    /* Slave address  */
> +#define        M62332_W_BIT            0x00    /* W bit (0 only) */
> +#define        M62332_SUB_ADDR         0x00    /* Sub address    */
> +#define        M62332_A_BIT            0x00    /* A bit (0 only) */
> +
> +/* DAC setup and hold times (expressed in us) */
> +#define DAC_BUS_FREE_TIME      5       /*   4.7 us */
> +#define DAC_START_SETUP_TIME   5       /*   4.7 us */
> +#define DAC_STOP_SETUP_TIME    4       /*   4.0 us */
> +#define DAC_START_HOLD_TIME    5       /*   4.7 us */
> +#define DAC_SCL_LOW_HOLD_TIME  5       /*   4.7 us */
> +#define DAC_SCL_HIGH_HOLD_TIME 4       /*   4.0 us */
> +#define DAC_DATA_SETUP_TIME    1       /*   250 ns */
> +#define DAC_DATA_HOLD_TIME     1       /*   300 ns */
> +#define DAC_LOW_SETUP_TIME     1       /*   300 ns */
> +#define DAC_HIGH_SETUP_TIME    1       /*  1000 ns */
(...)

It seems some DAC handling is part of the MFD driver, and we recently
discussed that MFD should not be doing misc stuff but mainly act as
arbiter and switching station.

Can you please move the DAC parts of the driver to
drivers/iio/dac?

The IIO DAC subsystem will likely add other goodies to
the driver for free and give a nice API to consumers.

> +/* IRQ support */
> +static void locomo_handler(unsigned int irq, struct irq_desc *desc)
> +{
> +       struct locomo *lchip = irq_get_handler_data(irq);
> +       int req, i;
> +
> +       /* Acknowledge the parent IRQ */
> +       desc->irq_data.chip->irq_ack(&desc->irq_data);
> +
> +       /* check why this interrupt was generated */
> +       req = readw(lchip->base + LOCOMO_ICR) & 0x0f00;
> +
> +       if (req) {
> +               /* generate the next interrupt(s) */
> +               irq = lchip->irq_base;

This use if a static IRQ base is oldschool. Use irqdomain,
see for example tc3589x.c.

irq_domain_add_simple() should suffice.

IIRC you have used irqdomain before so you know the drill.

> +               for (i = 0; i <= 3; i++, irq++) {
> +                       if (req & (0x0100 << i))
> +                               generic_handle_irq(irq);
> +
> +               }

Reading the status register once and then check the IRQs
can be dangerous on non-threaded interrupt handlers as it could
miss transient IRQs appearing duing the IRQ handling.

The best example code is in drivers/irqchip.

For example in irq-vic.c there is this nice loop:

        while ((stat = readl_relaxed(vic->base + VIC_IRQ_STATUS))) {
                irq = ffs(stat) - 1;
                handle_domain_irq(vic->domain, irq, regs);
                handled = 1;
        }

Note how stat is re-read on each iteration.

> +static void locomo_setup_irq(struct locomo *lchip)
> +{
> +       int irq;
> +
> +       lchip->irq_base = irq_alloc_descs(-1, 0, LOCOMO_NR_IRQS, -1);

irqdomain will allocate descriptors for you when calling
irq_create_mapping() which should be done for all lines.

> +       /* Install handlers for IRQ_LOCOMO_* */
> +       for (irq = lchip->irq_base;
> +                       irq < lchip->irq_base + LOCOMO_NR_IRQS;
> +                       irq++) {
> +               irq_set_chip_and_handler(irq, &locomo_chip, handle_level_irq);
> +               irq_set_chip_data(irq, lchip);
> +               set_irq_flags(irq, IRQF_VALID | IRQF_PROBE);
> +       }
> +
> +       /*
> +        * Install handler for IRQ_LOCOMO_HW.
> +        */
> +       irq_set_irq_type(lchip->irq, IRQ_TYPE_EDGE_FALLING);
> +       irq_set_handler_data(lchip->irq, lchip);
> +       irq_set_chained_handler(lchip->irq, locomo_handler);
> +}

(...)
> +       /* Longtime timer */
> +       writew(0, lchip->base + LOCOMO_LTINT);
> +       /* SPI */
> +       writew(0, lchip->base + LOCOMO_SPI + LOCOMO_SPIIE);
> +
> +       writew(6 + 8 + 320 + 30 - 10, lchip->base + LOCOMO_ASD);

That's a few magic numbers and calculation don't you think?

A comment stating what's going on would be helpful.

> +       r = readw(lchip->base + LOCOMO_ASD);
> +       r |= 0x8000;
> +       writew(r, lchip->base + LOCOMO_ASD);
> +
> +       writew(6 + 8 + 320 + 30 - 10 - 128 + 4, lchip->base + LOCOMO_HSD);

Dito.

> +       r = readw(lchip->base + LOCOMO_HSD);
> +       r |= 0x8000;
> +       writew(r, lchip->base + LOCOMO_HSD);
> +
> +       writew(128 / 8, lchip->base + LOCOMO_HSC);

Dito.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
