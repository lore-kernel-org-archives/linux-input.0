From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v8 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date: Tue, 9 Apr 2019 13:04:21 +0200
Message-ID: <CAMRc=Mc4HOn+Pjwf+sD4fU7gNoksRKXz9Yq6zE233CCoNskPiQ@mail.gmail.com>
References: <20190403090108.24788-1-brgl@bgdev.pl> <20190403090108.24788-3-brgl@bgdev.pl>
 <20190406070746.GA29624@bogus> <CAMRc=Mc+cTVrzywTydp-10Hj=-m=qCmtK1+4NRiOFHZ855fnDw@mail.gmail.com>
 <CAL_JsqKHjppN2kXqVpv5LjTedykA-Q8vteQDipw=FAaoUZLGeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqKHjppN2kXqVpv5LjTedykA-Q8vteQDipw=FAaoUZLGeg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

wt., 9 kwi 2019 o 03:10 Rob Herring <robh@kernel.org> napisa=C5=82(a):
>
> On Mon, Apr 8, 2019 at 7:25 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > sob., 6 kwi 2019 o 09:07 Rob Herring <robh@kernel.org> napisa=C5=82(a):
> > >
> > > On Wed, Apr 03, 2019 at 11:00:59AM +0200, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > Add the DT binding document for the battery charger module of max77=
650.
> > > >
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > ---
> > > >  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++=
++++
> > > >  1 file changed, 27 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/power/supply/=
max77650-charger.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/power/supply/max7765=
0-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650-cha=
rger.txt
> > > > new file mode 100644
> > > > index 000000000000..fef188144386
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/power/supply/max77650-charg=
er.txt
> > > > @@ -0,0 +1,27 @@
> > > > +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> > > > +
> > > > +This module is part of the MAX77650 MFD device. For more details
> > > > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > > > +
> > > > +The charger is represented as a sub-node of the PMIC node on the d=
evice tree.
> > > > +
> > > > +Required properties:
> > > > +--------------------
> > > > +- compatible:                Must be "maxim,max77650-charger"
> > > > +
> > > > +Optional properties:
> > > > +--------------------
> > > > +- min-microvolt:     Minimum CHGIN regulation voltage (in microvol=
ts). Must be
> > > > +                     one of: 4000000, 4100000, 4200000, 4300000, 4=
400000,
> > > > +                     4500000, 4600000, 4700000.
> > > > +- current-limit-microamp:    CHGIN input current limit (in microam=
ps). Must
> > > > +                             be one of: 95000, 190000, 285000, 380=
000, 475000.
> > >
> > > To repeat what I said on v6, these should be common properties IMO (a=
nd
> > > therefore documented as such).
> > >
> >
> > Do you mean a separate "charger.txt" document in
> > Documentation/devicetree/bindings/power/supply/?
>
> Yes, though I thought we had something already.
>
> Rob

We don't AFAICT. There's only a binding document for "simple-battery"
in power supply.

Bart
