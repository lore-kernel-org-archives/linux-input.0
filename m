From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [RESEND PATCH v6 04/11] dt-bindings: input: add DT bindings for max77650
Date: Fri, 22 Mar 2019 10:55:26 +0100
Message-ID: <CAMRc=Md0-UkY07vkf+irqUKwHFSj=Nq3fBYKFRqNG9nzWv9YRw@mail.gmail.com>
References: <20190318174228.18194-1-brgl@bgdev.pl> <20190318174228.18194-5-brgl@bgdev.pl>
 <20190322090927.GG27015@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322090927.GG27015@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Rob Herring <robh@kernel.org>
List-Id: linux-input@vger.kernel.org

pt., 22 mar 2019 o 10:09 Pavel Machek <pavel@ucw.cz> napisa=C5=82(a):
>
> On Mon 2019-03-18 18:42:21, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add the DT binding document for the onkey module of max77650.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> > +     onkey {
> > +             compatible =3D "maxim,max77650-onkey";
> > +             linux,code =3D <KEY_END>;
> > +             maxim,onkey-slide;
> > +     };
>
> This is certainly wrong.
>
> "End" key is normal key on a keyboard, certainly not some kind of
> slider.
>
> And this controller is likely to be used for power key, not end key,
> right?

But this is just an example of available properties, not a real use-case.

Bart

>
>                                                                         P=
avel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/b=
log.html
