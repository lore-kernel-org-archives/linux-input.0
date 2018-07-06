From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v10 1/2] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Fri, 6 Jul 2018 07:09:13 +0100
Message-ID: <20180706060913.GU496@dell>
References: <cover.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <e737bb13d17b75ea5e55f59005ef3181d428e704.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_53DbfFTRt2xST6RXg_qu0+LayXjQL2y024We1LHGB3yQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFqH_53DbfFTRt2xST6RXg_qu0+LayXjQL2y024We1LHGB3yQA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: matti.vaittinen@fi.rohmeurope.com, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, sboyd@kernel.org, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com, Andrey Smirnov <andrew.smirnov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Kate Stewart <kstewart@linuxfoundation.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-clk@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kerne>
List-Id: linux-input@vger.kernel.org

On Thu, 05 Jul 2018, Enric Balletbo Serra wrote:

> Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> dia dj., 5 de jul. 2018 a les 16:32:
> >
> > ROHM BD71837 PMIC MFD driver providing interrupts and support
> > for three subsystems:
> > - clk
> > - Regulators
> > - input/power-key
> >
> > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > ---
> >  drivers/mfd/Kconfig              |  13 ++
> >  drivers/mfd/Makefile             |   1 +
> >  drivers/mfd/rohm-bd718x7.c       | 198 +++++++++++++++++++++++
> >  include/linux/mfd/rohm-bd718x7.h | 333 +++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 545 insertions(+)
> >  create mode 100644 drivers/mfd/rohm-bd718x7.c
> >  create mode 100644 include/linux/mfd/rohm-bd718x7.h

[snipping ~550 lines of code]

> The main changes I requested are done so I think you can maintain my
> reviewed-by.
> 
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks for your review, it's much appreciated.

In future would you mind trimming your mails back to only include
relevant sections please?  Going through ~550 lines of code page by
page trying to find your response was a little painful.  TIA.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
