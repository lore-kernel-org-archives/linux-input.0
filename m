From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH v7 1/4] mfd: bd71837: mfd driver for ROHM BD71837 PMIC
Date: Tue, 3 Jul 2018 10:09:53 +0200
Message-ID: <CAFqH_53qUTeTcG1ijX-pbfgwwEes-f9i5MzOtv4eeM03V2Bq1Q@mail.gmail.com>
References: <cover.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <7e1888375c979accc402e9ddd7316e528b2ac52c.1529404894.git.matti.vaittinen@fi.rohmeurope.com>
 <CAFqH_51izuVgHukAORvwjZqGhxy85tdNdaHL9mOUnPnbCQmQjA@mail.gmail.com>
 <20180626112455.GC2118@localhost.localdomain> <CAFqH_52NERfORwSkBh0stW+mvzRpw0to9CiWPwLB9mFo_TsW_w@mail.gmail.com>
 <20180626120306.GD2118@localhost.localdomain> <CAFqH_52v3-L1xLL12hzyGCbuooX5T52Lm7BXHM3sBX1ERWmhiQ@mail.gmail.com>
 <20180703065648.GB20176@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703065648.GB20176@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: matti.vaittinen@fi.rohmeurope.com, Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, chenjh@rock-chips.com, Andrey Smirnov <andrew.smirnov@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Kate Stewart <kstewart@linuxfoundation.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-clk@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@>
List-Id: linux-input@vger.kernel.org

Hi,
Missatge de Lee Jones <lee.jones@linaro.org> del dia dt., 3 de jul.
2018 a les 8:56:
>
> On Tue, 26 Jun 2018, Enric Balletbo Serra wrote:
>
> > Hi Matti,
> >
> > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > dia dt., 26 de juny 2018 a les 14:03:
> > >
> > > Hello Again Eric,
> > >
> > > On Tue, Jun 26, 2018 at 01:40:40PM +0200, Enric Balletbo Serra wrote:
> > > > Hi Matti,
> > > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com> del
> > > > dia dt., 26 de juny 2018 a les 13:25:
> > > > > On Tue, Jun 26, 2018 at 11:06:33AM +0200, Enric Balletbo Serra wr=
ote:
> > > > > > Missatge de Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>=
 del
> > > > > > dia dt., 19 de juny 2018 a les 12:57:
> > > > >
> > > > > > > +static const struct of_device_id bd71837_of_match[] =3D {
> > > > > > > +       { .compatible =3D "rohm,bd71837", .data =3D (void *)0=
},
> > > > > > > +       { },
> > > > > >
> > > > > > nit: { /* sentinel */ }
> > > > >
> > > > > I am sorry but I didn't quite get the point here. Could you pleas=
e
> > > > > explain what did you expect to be added here?
> > > > >
> > > >
> > > > It's a nit but It is a good practice to specify that the last entry=
 is
> > > > a sentinel. Just this.
> > > >
> > > > +static const struct of_device_id bd71837_of_match[] =3D {
> > > > +       { .compatible =3D "rohm,bd71837", .data =3D (void *)0},
> > > > +       { /* sentinel */ }
> > > > +};
> > >
> > > Oh, I see. Finally something I can disagree =3D) I quickly opened few
> > > random drivers which declare match table. None of them practiced this
> > > good practice. So I guess it is not such a standard after all. And I
> > > guess the meaning of last entry in match table should be quite obviou=
s.
> > > Adding the comment /* sentinel */ sounds like stating the obvious at
> > > best - at worst it gets one just to wonder what the "sentinel" means =
=3D)
> > >
> >
> > git grep "/\* sentinel \*/"
> >
> > Anyway, I marked this change as a nit, so you don't need to change. I
> > just commented because at some point I received a "complain" when I
> > didn't add it. But this is up to the maintainer and I am not sure if
> > the "complain" was received in this subsystem :)
>
> Certainly not from me.  I don't agree with the practice.
>
Ok, Removed from my notes.

> I'd like to know who is enforcing this!

I tried to find from where my note comes from but I did not find it.
Anyway, it's clear now that you don't like it, so I'll remove from the
pending patches I have and see if someone complains about it again.

Thanks,
 Enric

>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
