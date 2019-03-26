From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [RESEND PATCH v6 06/11] mfd: max77650: new core mfd driver
Date: Tue, 26 Mar 2019 14:49:24 +0100
Message-ID: <CAMRc=Me1BbZKPQyAt4RR1eRk9pX3oHFudpm1CnHx3-AuD-G5ug@mail.gmail.com>
References: <20190318174228.18194-1-brgl@bgdev.pl> <20190318174228.18194-7-brgl@bgdev.pl>
 <20190322091223.GI27015@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322091223.GI27015@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

pt., 22 mar 2019 o 10:12 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> On Mon 2019-03-18 18:42:23, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add the core mfd driver for max77650 PMIC. We define five sub-devices
> > for which the drivers will be added in subsequent patches.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  drivers/mfd/Kconfig          |  14 +++
> >  drivers/mfd/Makefile         |   1 +
> >  drivers/mfd/max77650.c       | 234 +++++++++++++++++++++++++++++++++++
> >  include/linux/mfd/max77650.h |  59 +++++++++
> >  4 files changed, 308 insertions(+)
> >  create mode 100644 drivers/mfd/max77650.c
> >  create mode 100644 include/linux/mfd/max77650.h
> >
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 0ce2d8dfc5f1..ade04e124aa0 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -733,6 +733,20 @@ config MFD_MAX77620
> >         provides common support for accessing the device; additional dr=
ivers
> >         must be enabled in order to use the functionality of the device=
.
> >
> > +config MFD_MAX77650
> > +     tristate "Maxim MAX77650/77651 PMIC Support"
> > +     depends on I2C
> > +     depends on OF || COMPILE_TEST
>
> This says it will compile ok in !OF case. Will it?
>

It will compile because the stubs for OF functions will be provided -
it just won't work, because they won't be implemented.

Bart

> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
