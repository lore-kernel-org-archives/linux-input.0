From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 02/11] dt-bindings: power: supply: add DT bindings for max77650
Date: Tue, 12 Feb 2019 14:28:10 +0100
Message-ID: <CAMRc=MdCXfPh6g4u-v4GkQJxNDA+v1dqRChcEHdauczrVywkDg@mail.gmail.com>
References: <20190201094736.32057-1-brgl@bgdev.pl> <20190201094736.32057-3-brgl@bgdev.pl>
 <20190212115420.GA24296@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212115420.GA24296@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

wt., 12 lut 2019 o 12:54 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> Hi!
>
> > diff --git a/Documentation/devicetree/bindings/power/supply/max77650-ch=
arger.txt b/Documentation/devicetree/bindings/power/supply/max77650-charger=
.txt
> > new file mode 100644
> > index 000000000000..f3e00d41e299
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
> > +- maxim,vchgin-min:  Minimum CHGIN regulation voltage (in microvolts).=
 Must be
> > +                     one of: 4000000, 4100000, 4200000, 4300000, 44000=
00,
> > +                     4500000, 4600000, 4700000.
> > +- maxim,ichgin-lim:  CHGIN input current limit (in microamps). Must be=
 one of:
> > +                     95000, 190000, 285000, 380000, 475000.
>
> We already have richtek,min-input-voltage-regulation and
> ti,minimum-sys-voltage and ti,in-dpm-voltage.
>
> This is not too consistent with with the rest.. and perhaps common
> name should be used for those?
>
> See also ti,current-limit. That seems to be direct match.
>

Well I can't really use a TI-specific property name on a maxim part, can I?

Bart

PS This version was superseded by v4.
