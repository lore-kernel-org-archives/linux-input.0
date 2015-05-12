From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 03/17] input: convert LoCoMo keyboard driver to use
 new locomo core
Date: Tue, 12 May 2015 14:13:01 -0700
Message-ID: <20150512211301.GF20725@dtor-ws>
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-4-git-send-email-dbaryshkov@gmail.com>
 <20150512202106.GE20725@dtor-ws>
 <CALT56yOjiBWHH3Uuo82Hqh8Va8V_KCUaaLL7RFtPUjWmfOFbGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CALT56yOjiBWHH3Uuo82Hqh8Va8V_KCUaaLL7RFtPUjWmfOFbGA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrea Adami <andrea.adami@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-input <linux-input@vger.kernel.org>, linux-leds <linux-leds@vger.kernel.org>, linux-spi <linux-spi@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, May 13, 2015 at 12:01:23AM +0300, Dmitry Eremin-Solenikov wrote:
> Hello,
> 
> 2015-05-12 23:21 GMT+03:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> > Hi Dmitry,
> >
> > On Tue, Apr 28, 2015 at 02:55:40AM +0300, Dmitry Eremin-Solenikov wrote:
> >> As LoCoMo is switching to new device model, adapt keyboard driver to
> >> support new locomo core driver.
> >>
> >> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> >> ---
> 
> Thanks for the review.
> 
> >>  /* helper functions for reading the keyboard matrix */
> >> -static inline void locomokbd_charge_all(unsigned long membase)
> >> +static inline void locomokbd_charge_all(struct locomokbd *locomokbd)
> >>  {
> >> -     locomo_writel(0x00FF, membase + LOCOMO_KSC);
> >> +     regmap_write(locomokbd->regmap, LOCOMO_KSC, 0x00ff);
> >>  }
> >>
> >> -static inline void locomokbd_activate_all(unsigned long membase)
> >> +static inline void locomokbd_activate_all(struct locomokbd *locomokbd)
> >
> > Drop "inline"s from the .c file please.
> 
> Why?

Because compiler usually knows better whether a function should be
inlined or not as it keeps track of available registers, so leave the
decision to it.

> 
> >
> >>  {
> >> -     unsigned long r;
> >> -
> >> -     locomo_writel(0, membase + LOCOMO_KSC);
> >> -     r = locomo_readl(membase + LOCOMO_KIC);
> >> -     r &= 0xFEFF;
> >> -     locomo_writel(r, membase + LOCOMO_KIC);
> >> +     regmap_write(locomokbd->regmap, LOCOMO_KSC, 0);
> >> +     regmap_update_bits(locomokbd->regmap, LOCOMO_KIC, 0x100, 0);
> >>  }
> >>
> 
> [skipped]
> 
> >> @@ -291,16 +275,30 @@ static int locomokbd_probe(struct locomo_dev *dev)
> >>
> >>       input_set_drvdata(input_dev, locomokbd);
> >>
> >> -     memcpy(locomokbd->keycode, locomokbd_keycode, sizeof(locomokbd->keycode));
> >> +     memcpy(locomokbd->keycode,
> >> +                     locomokbd_keycode,
> >> +                     sizeof(locomokbd->keycode));
> >> +
> >> +     if (machine_is_collie())
> >> +             locomokbd->keycode[18] = KEY_HOME;
> >> +     else
> >> +             locomokbd->keycode[3] = KEY_HOME;
> >
> > This seems like a new addition. Ideally keymap twiddling shoudl be done
> > from userspace.
> 
> This fixes a hardware issue. Home key is wired differently on two
> devices using this driver.
> I'd prefer to have such setting in board file or in DTS in future,
> however that looks like an
> overkill. What would be your suggestion?

I am OK with doing this in driver, just as a separate patch please.

> 
> >>       /* attempt to get the interrupt */
> >> -     err = request_irq(dev->irq[0], locomokbd_interrupt, 0, "locomokbd", locomokbd);
> >> +     err = request_irq(locomokbd->irq, locomokbd_interrupt, 0,
> >> +                     "locomokbd", locomokbd);
> >
> > devm_request_irq()?
> >
> [skipped]
> 
> >> -static int locomokbd_remove(struct locomo_dev *dev)
> >> +static int locomokbd_remove(struct platform_device *dev)
> >>  {
> >> -     struct locomokbd *locomokbd = locomo_get_drvdata(dev);
> >> +     struct locomokbd *locomokbd = platform_get_drvdata(dev);
> >>
> >> -     free_irq(dev->irq[0], locomokbd);
> >> +     free_irq(locomokbd->irq, locomokbd);
> >
> > Is not needed with devm.
> 
> Not quite. There will be a possibility for the IRQ to happen after deleting
> a timer in locomokbd_remove() and before freeing the IRQ through the devres
> core. Oops.

Right, but if you make sure that device does not generate interrupts in
probe() until open() is called and do the same in close(), then it
should be OK.

> 
> >
> >>
> >>       del_timer_sync(&locomokbd->timer);
> >
> > Should likely to go into close().
> 
> Hmm. I will rethink this part, thank you.
> 
> >> +
> >> +#ifdef CONFIG_PM_SLEEP
> >> +static int locomokbd_suspend(struct device *dev)
> >
> > Mark as __maybe_unused instead of giarding with CONFIG_PM_SLEEP.
> 
> Fine, however I thought that #ifdef's here are a typical pattern.

It is up to subsystems, __maybe_unused provides better compile coverage.

Thanks.

-- 
Dmitry
