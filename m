From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [RESEND PATCH v6 02/11] dt-bindings: power: supply: add DT
 bindings for max77650
Date: Tue, 26 Mar 2019 18:34:48 +0100
Message-ID: <CAMRc=MdMqjZtQkWXaK3-5myXUZMd_tNirQGE5wKpA6uoCsGhaw@mail.gmail.com>
References: <20190318174040.17899-1-brgl@bgdev.pl> <20190318174040.17899-3-brgl@bgdev.pl>
 <20190322090038.GE27015@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322090038.GE27015@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

pt., 22 mar 2019 o 10:00 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> On Mon 2019-03-18 18:40:31, Bartosz Golaszewski wrote:
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
> > index 000000000000..d25c95369616
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
> > +- min-microvolt:     Minimum CHGIN regulation voltage (in microvolts).=
 Must be
> > +                     one of: 4000000, 4100000, 4200000, 4300000, 44000=
00,
> > +                     4500000, 4600000, 4700000.
>
> Probably needs "max," prefix. And .. what does this mean? Will charger
> shutdown if input is less than this?
>

The charger will enter the undervoltage lockout state and stop
charging, this is explained in the manual, so I don't think the
bindings are the right place to add this information.

Bart

> > +- curr-lim-microamp: CHGIN input current limit (in microamps). Must be=
 one of:
> > +                     95000, 190000, 285000, 380000, 475000.
>
> "current-limit-microamp", I guess. And probably "max,current-limit-microa=
mp".
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
