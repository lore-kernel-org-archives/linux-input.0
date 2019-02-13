From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 09/11] leds: max77650: add LEDs support
Date: Wed, 13 Feb 2019 11:58:26 +0100
Message-ID: <CAMRc=MfpCU0fRGrQb5CncaHu2Yfdv=NbuZc9Oujb7FUWdn93Pg@mail.gmail.com>
References: <20190201094736.32057-1-brgl@bgdev.pl> <20190201094736.32057-10-brgl@bgdev.pl>
 <20190212121236.GD25613@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212121236.GD25613@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

wt., 12 lut 2019 o 13:12 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
>
> > diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> > index a72f97fca57b..6e7a8f51eccc 100644
> > --- a/drivers/leds/Kconfig
> > +++ b/drivers/leds/Kconfig
> > @@ -608,6 +608,12 @@ config LEDS_TLC591XX
> >         This option enables support for Texas Instruments TLC59108
> >         and TLC59116 LED controllers.
> >
> > +config LEDS_MAX77650
> > +     tristate "LED support for Maxim MAX77650 PMIC"
> > +     depends on MFD_MAX77650
> > +     help
> > +       LEDs driver for MAX77650 family of PMICs from Maxim Integrated.=
"
> > +
>
> List the chips? Remove extra "?
>                                                                         P=
avel

They are already listed in the core mfd Kconfig, but thanks for
spotting that stray ".

Bart
