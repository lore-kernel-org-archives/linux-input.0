From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v5 07/11] power: supply: max77650: add support for battery charger
Date: Thu, 14 Feb 2019 11:42:03 +0100
Message-ID: <CAMRc=MdR9j3pEw4SFU+SQyWF-jD3n-kp6Z7_6L-bH6J2zyeSZA@mail.gmail.com>
References: <20190213134335.10838-1-brgl@bgdev.pl> <20190213134335.10838-8-brgl@bgdev.pl>
 <20190214103944.GC6132@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190214103944.GC6132@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

czw., 14 lut 2019 o 11:39 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> Hi!
>
> > +#define MAX77650_CHG_OFF                     0x00
> > +#define MAX77650_CHG_PREQ                    0x01
> > +
> > +#define MAX77650_CHGIN_UNDERVOLTAGE_LOCKOUT  0x00
> > +#define MAX77650_CHGIN_OVERVOLTAGE_LOCKOUT   0x01
> > +#define MAX77650_CHGIN_OKAY                  0x11
>
> Thanks for doing this.
>
> > +#define MAX77650_CHG_ON_CURR                 0x02
> > +#define MAX77650_CHG_ON_CURR_JEITA           0x03
> > +#define MAX77650_CHG_ON_VOLT                 0x04
> > +#define MAX77650_CHG_ON_VOLT_JEITA           0x05
> > +#define MAX77650_CHG_ON_TOPOFF                       0x06
> > +#define MAX77650_CHG_ON_TOPOFF_JEITA         0x07
> > +#define MAX77650_CHG_DONE                    0x08
> > +#define MAX77650_CHG_DONE_JEITA                      0x09
> > +#define MAX77650_CHG_SUSP_PREQ_TIM_FAULT     0x0a
> > +#define MAX77650_CHG_SUSP_FAST_CHG_TIM_FAULT 0x0b
> > +#define MAX77650_CHG_SUSP_BATT_TEMP_FAULT    0x0c
> > +
> > +#define MAX77650_CHARGER_CHGIN_DTLS_MASK     GENMASK(3, 2)
> > +#define MAX77650_CHARGER_CHGIN_DTLS_BITS(_reg) \
> > +             (((_reg) & MAX77650_CHARGER_CHGIN_DTLS_MASK) >> 2)
>
> But I guess these could use similar treatment?
>                                                         Pavel
>

These are already called the same as in the manual, so we can keep them rig=
ht?

Bart
