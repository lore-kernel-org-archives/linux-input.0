From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] gpio fixup domain
Date: Wed, 30 Jan 2019 10:42:41 +0100
Message-ID: <CACRpkdYswaxCOqS9vgtKrLH-Bnxu3p1=KG=S71FGmLr8qu+ciQ@mail.gmail.com>
References: <20190129133545.1931-1-brgl@bgdev.pl> <20190129133545.1931-3-brgl@bgdev.pl>
 <CAMRc=Md4iTPi_i3EO5QT2SW1S2__8mMe22+9tcO7VUE2_hPNiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=Md4iTPi_i3EO5QT2SW1S2__8mMe22+9tcO7VUE2_hPNiw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jan 29, 2019 at 2:39 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> wt., 29 sty 2019 o 14:35 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82=
(a):
>
> Please ignore this one, it got lost on the way. It was just experimentati=
on.

Pretty interesting experiment anyways! Now both GPIO maintainers
know the intricacies of the hierarchical irq domains, which is a win
in itself when we try to come up with some generic handling here.

Yours,
Linus Walleij
