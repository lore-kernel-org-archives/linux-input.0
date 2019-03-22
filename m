From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [RESEND PATCH v6 09/11] leds: max77650: add LEDs support
Date: Fri, 22 Mar 2019 10:53:32 +0100
Message-ID: <CAMRc=Mf1DxF1e63y+HsXtCFxZW8R0XWDLUXGy+4cp3zBS0_qhw@mail.gmail.com>
References: <20190318174228.18194-1-brgl@bgdev.pl> <20190318174228.18194-10-brgl@bgdev.pl>
 <20190322092124.GK27015@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322092124.GK27015@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

pt., 22 mar 2019 o 10:21 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> On Mon 2019-03-18 18:42:26, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This adds basic support for LEDs for the max77650 PMIC. The device has
> > three current sinks for driving LEDs.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
>
> > +             label =3D of_get_property(child, "label", NULL);
> > +             if (!label) {
> > +                     led->cdev.name =3D "max77650::";
> > +             } else {
> > +                     led->cdev.name =3D devm_kasprintf(dev, GFP_KERNEL=
,
> > +                                                     "max77650:%s", la=
bel);
> > +                     if (!led->cdev.name)
> > +                             return -ENOMEM;
> > +             }
>
> I'd rather not have the "max77650:" prefix in the LED name (as it is
> useless).
>

I was instructed to do so by the LED subsystem maintainer.

Bart

> Best regards,
>                                                                         P=
avel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
