From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 08/13] regulator: max77650: add regulator support
Date: Fri, 18 Jan 2019 19:18:00 +0100
Message-ID: <CAMpxmJV6bjT558OTiqAGAxHe1ZcJ5u-LPVF45P677EZweXxrSw@mail.gmail.com>
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-9-brgl@bgdev.pl>
 <20190118180148.GD6260@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118180148.GD6260@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, linux-devicetree <devicetree@vger.kernel.org>, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

pt., 18 sty 2019 o 19:01 Mark Brown <broonie@kernel.org> napisa=C5=82(a):
>
> On Fri, Jan 18, 2019 at 02:42:39PM +0100, Bartosz Golaszewski wrote:
>
> > Add regulator support for max77650. We support all four variants of thi=
s
> > PMIC including non-linear voltage table for max77651 SBB1 rail.
>

Sorry for spamming, I missed it the last time.

> Looks good, the ramping stuff might be a candidate for core (TBH I was
> sure we'd got that implemented already but we don't seem to) but that
> can be done later and the more complex one with non-linear steps does
> feel like it might have to stay in the driver anyway.
>

I'm thinking about implementing that in the core for the next release
cycle and then making this driver the first user.

Bart

> A couple of small nits:
>
> > +++ b/drivers/regulator/max77650-regulator.c
> > @@ -0,0 +1,537 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2018 BayLibre SAS
> > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Please make the entire header C++ style so it looks more intentional.
>
> > +             for_each_child_of_node(dev->of_node, child) {
> > +                     if (!of_node_name_eq(child, rdesc->desc.name))
> > +                             continue;
> > +
> > +                     init_data =3D of_get_regulator_init_data(dev, chi=
ld,
> > +                                                            &rdesc->de=
sc);
> > +                     if (!init_data)
> > +                             return -ENOMEM;
> > +
> > +                     config.of_node =3D child;
> > +                     config.init_data =3D init_data;
> > +             }
>
> You don't need to do this, the core will do it for you (it will actually
> still do it even with the above, it'll only fall back to using
> config->init_data if it's own lookup fails).
