From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v8 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date: Thu, 11 Apr 2019 11:50:19 -0500
Message-ID: <CAL_JsqKHGczKAD3VjBsq6G=Ev0t8p_qWZ0YG6rRsqO8GuRAK7Q@mail.gmail.com>
References: <20190403090108.24788-1-brgl@bgdev.pl> <20190403090108.24788-3-brgl@bgdev.pl>
 <20190406070746.GA29624@bogus> <CAMRc=Mc+cTVrzywTydp-10Hj=-m=qCmtK1+4NRiOFHZ855fnDw@mail.gmail.com>
 <CAL_JsqKHjppN2kXqVpv5LjTedykA-Q8vteQDipw=FAaoUZLGeg@mail.gmail.com>
 <CAMRc=Mc4HOn+Pjwf+sD4fU7gNoksRKXz9Yq6zE233CCoNskPiQ@mail.gmail.com> <CAMRc=MfkdBMmhrCM7Ut8ZGkgT=gFTRrbgFmu3MbghGwCRkEEKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=MfkdBMmhrCM7Ut8ZGkgT=gFTRrbgFmu3MbghGwCRkEEKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On Tue, Apr 9, 2019 at 10:38 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> wt., 9 kwi 2019 o 13:04 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(=
a):
> >
> > wt., 9 kwi 2019 o 03:10 Rob Herring <robh@kernel.org> napisa=C5=82(a):
> > >
> > > On Mon, Apr 8, 2019 at 7:25 AM Bartosz Golaszewski <brgl@bgdev.pl> wr=
ote:
> > > >
> > > > sob., 6 kwi 2019 o 09:07 Rob Herring <robh@kernel.org> napisa=C5=82=
(a):
> > > > >
> > > > > On Wed, Apr 03, 2019 at 11:00:59AM +0200, Bartosz Golaszewski wro=
te:
> > > > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > > >
> > > > > > Add the DT binding document for the battery charger module of m=
ax77650.
> > > > > >
> > > > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > > > > ---
> > > > > >  .../power/supply/max77650-charger.txt         | 27 +++++++++++=
++++++++
> > > > > >  1 file changed, 27 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/power/sup=
ply/max77650-charger.txt
> > > > > >
> > > > > > diff --git a/Documentation/devicetree/bindings/power/supply/max=
77650-charger.txt b/Documentation/devicetree/bindings/power/supply/max77650=
-charger.txt
> > > > > > new file mode 100644
> > > > > > index 000000000000..fef188144386
> > > > > > --- /dev/null
> > > > > > +++ b/Documentation/devicetree/bindings/power/supply/max77650-c=
harger.txt
> > > > > > @@ -0,0 +1,27 @@
> > > > > > +Battery charger driver for MAX77650 PMIC from Maxim Integrated=
.
> > > > > > +
> > > > > > +This module is part of the MAX77650 MFD device. For more detai=
ls
> > > > > > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > > > > > +
> > > > > > +The charger is represented as a sub-node of the PMIC node on t=
he device tree.
> > > > > > +
> > > > > > +Required properties:
> > > > > > +--------------------
> > > > > > +- compatible:                Must be "maxim,max77650-charger"
> > > > > > +
> > > > > > +Optional properties:
> > > > > > +--------------------
> > > > > > +- min-microvolt:     Minimum CHGIN regulation voltage (in micr=
ovolts). Must be
> > > > > > +                     one of: 4000000, 4100000, 4200000, 430000=
0, 4400000,
> > > > > > +                     4500000, 4600000, 4700000.
> > > > > > +- current-limit-microamp:    CHGIN input current limit (in mic=
roamps). Must
> > > > > > +                             be one of: 95000, 190000, 285000,=
 380000, 475000.
> > > > >
> > > > > To repeat what I said on v6, these should be common properties IM=
O (and
> > > > > therefore documented as such).
> > > > >
> > > >
> > > > Do you mean a separate "charger.txt" document in
> > > > Documentation/devicetree/bindings/power/supply/?
> > >
> > > Yes, though I thought we had something already.
> > >
> > > Rob
> >
> > We don't AFAICT. There's only a binding document for "simple-battery"
> > in power supply.
> >
> > Bart
>
> Can we have it locally for now but without the maxim prefix and then
> reuse it if any other charger needs such functionality? To make it
> even more generic we can name it: "input-voltage-min-microvolt" &
> "input-current-limit-microamp".

I guess. And defining these as 'input' is good because we do have
similar property names already for battery current limit and voltages.

Rob
