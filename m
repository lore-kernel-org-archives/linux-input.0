From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Wed, 4 Jul 2018 14:56:23 +0000
Message-ID: <20180704145623.zgei3ehrwdpcu26r@penguin>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: matti.vaittinen@fi.rohmeurope.com, Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, mazziesaccount@gmail.com, Arnd Bergmann <arnd@arndb.de>, Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com, andrew.smirnov@gmail.com, Linus Walleij <linus.walleij@linaro.org>, Kate Stewart <kstewart@linuxfoundation.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-clk@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, mikko
List-Id: linux-input@vger.kernel.org

Hi Enric,

On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wrote:
> Hi Matti,
> 
> Thanks for the patch, a few comments below, some are feedback I
> received when I sent some patches to this subsystem.
> 
> Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> dia dt., 19 de juny 2018 a les 12:57:
> > +};
> > +
> > +/* bd71837 multi function cells */
> > +static struct mfd_cell bd71837_mfd_cells[] = {
> > +       {
> > +               .name = "bd71837-clk",
> > +       }, {
> > +               .name = "bd718xx-pwrkey",
> > +               .resources = &irqs[0],
> > +               .num_resources = ARRAY_SIZE(irqs),
> > +       }, {
> > +               .name = "bd71837-pmic",
> > +       },
> nit: no comma at the end

Actually, trailing comma is preferred on structures/arrays without
sentinels, because if one needs to add a new entry/new member, then in
the diff there will have only one new line added, instead of one line
being changed (adding now necessary comma) and one added.

Thanks.

-- 
Dmitry
