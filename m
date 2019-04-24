From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v10 00/11] mfd: add support for max77650 PMIC
Date: Wed, 24 Apr 2019 10:45:00 +0200
Message-ID: <CAMRc=McN78_gJw_T4EPucM8veTC9XRUu7TGJ0J+zPsU=0Hu2GQ@mail.gmail.com>
References: <20190423090451.23711-1-brgl@bgdev.pl> <20190424083127.GB6699@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424083127.GB6699@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@denx.de>, Lee Jones <lee.jones@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

=C5=9Br., 24 kwi 2019 o 10:31 Pavel Machek <pavel@denx.de> napisa=C5=82(a):
>
> On Tue 2019-04-23 11:04:40, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > This series adds support for max77650 ultra low-power PMIC. It provides
> > the core mfd driver and a set of five sub-drivers for the regulator,
> > power supply, gpio, leds and input subsystems.
> >
> > Patches 1-4 add the DT binding documents. Patch 5 documents mfd_add_dev=
ices().
> > Patches 6-10 add all drivers. Last patch adds a MAINTAINERS entry for t=
his
> > device.
> >
> > The regulator part is already upstream.
>
> I see v10 in my inbox... and acks from all over the place, but patches
> not going in. Who takes these? I don't think I need another 10
> versions in my inbox...
>                                                                 Pavel

I think Lee Jones should take them through the MFD tree. With the ack
from Sebastian Reichel on the driver part and the example in the
charger binding fixed I think they are ready to be picked up.

Bart
