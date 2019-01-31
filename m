From: Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v2 12/13] input: max77650: add onkey support
Date: Thu, 31 Jan 2019 09:15:01 +0100
Message-ID: <CAMRc=McaqqmU6S_Yz35ZMvhWtWO4hTASA0fmL5CT4JizbYgu4Q@mail.gmail.com>
References: <20190129133545.1931-1-brgl@bgdev.pl> <20190129133545.1931-14-brgl@bgdev.pl>
 <20190130185328.GA149208@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130185328.GA149208@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

=C5=9Br., 30 sty 2019 o 19:53 Dmitry Torokhov <dmitry.torokhov@gmail.com> n=
apisa=C5=82(a):
>
> On Tue, Jan 29, 2019 at 02:35:44PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add support for the push- and slide-button events for max77650.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Please feel free to merge with other patches (MFD tree I suppose?).
>

Hi Dmitry,

I'm not sure what the policy is on merging MFD drivers, but I'm seeing
that Mark Brown has already picked up the regulator part into his tree
(including the binding document). I think you can just pick up the
input patches and it will simply not show up in Kconfig until the core
mfd module is upstream.

@Mark: could you please confirm it?

Best regards,
Bartosz Golaszewski
