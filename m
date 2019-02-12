From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v3 10/11] input: max77650: add onkey support
Date: Tue, 12 Feb 2019 14:29:49 +0100
Message-ID: <CAMRc=Md57e93vCV+uJ4WSma2AefdN89iWXCyKiY7yLsWFGUihg@mail.gmail.com>
References: <20190201094736.32057-1-brgl@bgdev.pl> <20190201094736.32057-11-brgl@bgdev.pl>
 <20190212121745.GE25613@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190212121745.GE25613@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

wt., 12 lut 2019 o 13:17 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> Hi!
>
> > +     error =3D device_property_read_string(dev,
> > +                                         "maxim,onkey-mode", &mode_pro=
p);
> > +     if (error)
> > +             mode_prop =3D "push";
> > +
> > +     if (strcmp(mode_prop, "push") =3D=3D 0)
> > +             mode =3D MAX77650_ONKEY_MODE_PUSH;
> > +     else if (strcmp(mode_prop, "slide") =3D=3D 0)
> > +             mode =3D MAX77650_ONKEY_MODE_SLIDE;
> > +     else
> > +             return -EINVAL;
> ...
> > +     onkey->input->name =3D "max77650_onkey";
> > +     onkey->input->phys =3D "max77650_onkey/input0";
> > +     onkey->input->id.bustype =3D BUS_I2C;
> > +     input_set_capability(onkey->input, EV_KEY, onkey->code);
>
> Is EV_KEY correct for mode=3D=3Dslide?
>

Others are not really documented. Does EV_SW stand for switch event?
In that case it would probably be better.

Bart
