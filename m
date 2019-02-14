From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v5 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date: Thu, 14 Feb 2019 10:29:22 +0100
Message-ID: <CAMRc=MeyMnRMzmexgNBF5PkP-Hs2G2sS4hCP4mTZR5jxC=ej1w@mail.gmail.com>
References: <20190213134335.10838-1-brgl@bgdev.pl> <20190213134335.10838-3-brgl@bgdev.pl>
 <20190213204834.GA31342@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213204834.GA31342@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

=C5=9Br., 13 lut 2019 o 21:48 Rob Herring <robh@kernel.org> napisa=C5=82(a)=
:
>
> On Wed, Feb 13, 2019 at 02:43:26PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add the DT binding document for the battery charger module of max77650.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  .../power/supply/max77650-charger.txt         | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/supply/max7=
7650-charger.txt
> >
> > diff --git a/Documentation/devicetree/bindings/power/supply/max77650-ch=
arger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger=
.txt
> > new file mode 100644
> > index 000000000000..16e24173c80e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/supply/max77650-charger.t=
xt
> > @@ -0,0 +1,27 @@
> > +Battery charger driver for MAX77650 PMIC from Maxim Integrated.
> > +
> > +This module is part of the MAX77650 MFD device. For more details
> > +see Documentation/devicetree/bindings/mfd/max77650.txt.
> > +
> > +The charger is represented as a sub-node of the PMIC node on the devic=
e tree.
> > +
> > +Required properties:
> > +--------------------
> > +- compatible:                Must be "maxim,max77650-charger"
> > +
> > +Optional properties:
> > +--------------------
> > +- min-input-voltage: Minimum CHGIN regulation voltage (in microvolts).=
 Must be
> > +                     one of: 4000000, 4100000, 4200000, 4300000, 44000=
00,
> > +                     4500000, 4600000, 4700000.
> > +- current-limit:     CHGIN input current limit (in microamps). Must be=
 one of:
> > +                     95000, 190000, 285000, 380000, 475000.
>
> Unit suffix? Really, these should be common properties. We have
> some I think. Charger bindings are a mess though...
>

Do you mean a suffix like: ua for microamps and uv for microvolts? I'm
not seeing any other such properties.

Bart

> > +
> > +Example:
> > +--------
> > +
> > +     charger {
> > +             compatible =3D "maxim,max77650-charger";
> > +             maxim,vchgin-min =3D <4200000>;
> > +             maxim,ichgin-lim =3D <285000>;
>
> Doesn't match above.
>
> > +     };
> > --
> > 2.20.1
> >
