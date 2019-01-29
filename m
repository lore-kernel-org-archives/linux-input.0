From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 10/13] gpio: max77650: add GPIO support
Date: Tue, 29 Jan 2019 14:22:00 +0100
Message-ID: <CAMRc=Mewf0p1v+afVKDhg8FJHip09ipt3_uO5uYtJP75HyuCSQ@mail.gmail.com>
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-11-brgl@bgdev.pl>
 <CACRpkdZhy7yBZrGLxhRGaac7v5jZhgUSz9gZAhFXbevJbKjpZw@mail.gmail.com>
 <CAMRc=Me6OSKDk7bN4++M68DjoeArd+gZx16o0oQBXfRoCWBt2A@mail.gmail.com>
 <CACRpkdacfOLSs1GPew4gMtL_BX0OTXqBQNWzWZMwAkk+Ah2ETQ@mail.gmail.com> <CAMRc=MftwsuooC8vLmnGYiiKj2rVShXeuekTrho8JRihjiBJ+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MftwsuooC8vLmnGYiiKj2rVShXeuekTrho8JRihjiBJ+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Brian Masney <masneyb@onstation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

wt., 29 sty 2019 o 12:00 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(a=
):
>
> czw., 24 sty 2019 o 11:30 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
> >
> > On Mon, Jan 21, 2019 at 6:07 PM Bartosz Golaszewski <brgl@bgdev.pl> wro=
te:
> >
> > > Thank you for your review. While I think you're right about the issue
> > > being present in this driver, I'm not sure it's really a problem. Do
> > > we actually require every gpio-controller to also be a stand-alone
> > > interrupt-controller?
> >
> > Absolutely not :D
> >
> > Just GPIO is fine.
> >
> > > The binding document for the GPIO module doesn't
> > > mention this - it only requires the gpio-controller property. Without
> > > the "interrupt-controller" property dtc will bail-out if anyone uses
> > > this node as the interrupt parent.
> > >
> > > If I'm wrong and we do require it, then I think we need to update
> > > Documentation/devicetree/bindings/gpio/gpio.txt.
> >
> > What is weird is if a driver with DT bindings not mentioning IRQ
> > and only probing from DT start implementing IRQ support, that
> > becomes quite inconsistent. So then max77650_gpio_to_irq()
> > should just return -ENOTSUPP
> > or something for now, then it's fine.
> >
>
> I don't see it as weird at all. I see the need to define the register
> and interrupt resources in DT for SoC peripherals becaue SoCs often
> reuse IPs. But in the case of a self-contained i2c PMIC - the modules
> such as GPIO are tightly coupled with the core functionality. In the
> case of this device for example: there isn't even a separate set of
> mask/status registers for GPIO interrupts.
>
> Most mfd devices setup the resources in a hard-coded manner.
>
> > We can add the (complicated) IRQ handling later.
> >
> > I am trying to eat my own dogfood here, I was sweating all
> > last night trying to implement a hierarchical IRQ controller.
> > There is no running away from that now. :/
> >
> > Apparently doing hierarchical IRQs demand that all irq
> > controllers up to the top-level SoC IRQ controller support
> > hierarchical interrupts using the v2 version of the irqdomain
> > API, and currently it seems like the ARM
> > GIC seems like the only top level IRQ controller that can
> > do that.
> >
>
> Yep, and for that reason I can't use the regmap irq_chip abstraction
> for now because it doesn't implement support for hierarchical
> interrupts either.
>
> How about the cascaded gpiochip irq_chip?
>
> Best regards,
> Bartosz

Nah that won't work either without a proper hierarchy...

In that case, let's leave out the irq support for now. I'll send v2.

Bart
