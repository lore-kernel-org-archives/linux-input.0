From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 12/13] input: max77650: add onkey support
Date: Thu, 31 Jan 2019 11:18:35 -0800
Message-ID: <CAKdAkRQUAMsT7SA7oAaEmLrkZ6hOdAqCC9RC6HGRsjJ+TvASrQ@mail.gmail.com>
References: <20190129133545.1931-1-brgl@bgdev.pl> <20190129133545.1931-14-brgl@bgdev.pl>
 <20190130185328.GA149208@dtor-ws> <CAMRc=McaqqmU6S_Yz35ZMvhWtWO4hTASA0fmL5CT4JizbYgu4Q@mail.gmail.com>
 <20190131122813.GB20797@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190131122813.GB20797@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org

On Thu, Jan 31, 2019 at 4:28 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jan 31, 2019 at 09:15:01AM +0100, Bartosz Golaszewski wrote:
>
> > I'm not sure what the policy is on merging MFD drivers, but I'm seeing
> > that Mark Brown has already picked up the regulator part into his tree
> > (including the binding document). I think you can just pick up the
> > input patches and it will simply not show up in Kconfig until the core
> > mfd module is upstream.
>
> > @Mark: could you please confirm it?
>
> Right, as it's a new MFD the Kconfig will stop it causing build breakage
> until the MFD is merged.  I'm doing it partly just to cut down on the
> amount of mail from resends while the rest of the series gets reviewed.

Ugh, I might have pulled it in if it did not reference the new header
file. As a rule I try to enable all symbols that result in input
devices being created so as much of input code is covered... I'd
prefer input piece be merged with MFD.

Thanks.

-- 
Dmitry
