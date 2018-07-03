From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Tue, 3 Jul 2018 07:53:29 +0100
Message-ID: <20180703065329.GA20176@dell>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
 <20180626112455.GC2118@localhost.localdomain>
 <CAFqH_52NERfORwSkBh0stW+mvzRpw0to9CiWPwLB9mFo_TsW_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_52NERfORwSkBh0stW+mvzRpw0to9CiWPwLB9mFo_TsW_w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: matti.vaittinen@fi.rohmeurope.com, Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, mazziesaccount@gmail.com, Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com, andrew.smirnov@gmail.com, Linus Walleij <linus.walleij@linaro.org>, Kate Stewart <kstewart@linuxfoundation.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-clk@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel
List-Id: linux-input@vger.kernel.org

On Tue, 26 Jun 2018, Enric Balletbo Serra wrote:

> Hi Matti,
> Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> dia dt., 26 de juny 2018 a les 13:25:
> >
> > Hello Eric,
> >
> > Thanks for the comments! I'll be addressing these in patch series v8
> > - except the regmap wrapper one which will be taken care of by another
> > patch set.
> >
> > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wrote:
> > > Hi Matti,
> > >
> > > Thanks for the patch, a few comments below, some are feedback I
> > > received when I sent some patches to this subsystem.
> > >
> > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > dia dt., 19 de juny 2018 a les 12:57:
> > > >
> > > > ROHM BD71837 PMIC MFD driver providing interrupts and support
> > > > for two subsystems:
> > > > - clk
> > > > - Regulators
> > > >
> > > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > > ---
> > > >  drivers/mfd/Kconfig         |  13 ++
> > > >  drivers/mfd/Makefile        |   1 +
> > > >  drivers/mfd/bd71837.c       | 221 ++++++++++++++++++++++++++
> > > >  include/linux/mfd/bd71837.h | 367 ++++++++++++++++++++++++++++++++++++++++++++
> > > >  4 files changed, 602 insertions(+)
> > > >  create mode 100644 drivers/mfd/bd71837.c
> > > >  create mode 100644 include/linux/mfd/bd71837.h

[...]

> > > > +static const struct of_device_id bd71837_of_match[] = {
> > > > +       { .compatible = "rohm,bd71837", .data = (void *)0},
> > > > +       { },
> > >
> > > nit: { /* sentinel */ }
> >
> > I am sorry but I didn't quite get the point here. Could you please
> > explain what did you expect to be added here?
> >
> 
> It's a nit but It is a good practice to specify that the last entry is
> a sentinel. Just this.
> 
> +static const struct of_device_id bd71837_of_match[] = {
> +       { .compatible = "rohm,bd71837", .data = (void *)0},
> +       { /* sentinel */ }
> +};

I would not say this is "good practice" at all.

We all know what empty brackets mean.  No need for obvious comments.

When authors put this, I let it go because "sentinel" is a cool word -
and nothing more! ;)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
