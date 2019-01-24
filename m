From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 10/13] gpio: max77650: add GPIO support
Date: Thu, 24 Jan 2019 11:30:18 +0100
Message-ID: <CACRpkdacfOLSs1GPew4gMtL_BX0OTXqBQNWzWZMwAkk+Ah2ETQ@mail.gmail.com>
References: <20190118134244.22253-1-brgl@bgdev.pl> <20190118134244.22253-11-brgl@bgdev.pl>
 <CACRpkdZhy7yBZrGLxhRGaac7v5jZhgUSz9gZAhFXbevJbKjpZw@mail.gmail.com> <CAMRc=Me6OSKDk7bN4++M68DjoeArd+gZx16o0oQBXfRoCWBt2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMRc=Me6OSKDk7bN4++M68DjoeArd+gZx16o0oQBXfRoCWBt2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Brian Masney <masneyb@onstation.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Jan 21, 2019 at 6:07 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> Thank you for your review. While I think you're right about the issue
> being present in this driver, I'm not sure it's really a problem. Do
> we actually require every gpio-controller to also be a stand-alone
> interrupt-controller?

Absolutely not :D

Just GPIO is fine.

> The binding document for the GPIO module doesn't
> mention this - it only requires the gpio-controller property. Without
> the "interrupt-controller" property dtc will bail-out if anyone uses
> this node as the interrupt parent.
>
> If I'm wrong and we do require it, then I think we need to update
> Documentation/devicetree/bindings/gpio/gpio.txt.

What is weird is if a driver with DT bindings not mentioning IRQ
and only probing from DT start implementing IRQ support, that
becomes quite inconsistent. So then max77650_gpio_to_irq()
should just return -ENOTSUPP
or something for now, then it's fine.

We can add the (complicated) IRQ handling later.

I am trying to eat my own dogfood here, I was sweating all
last night trying to implement a hierarchical IRQ controller.
There is no running away from that now. :/

Apparently doing hierarchical IRQs demand that all irq
controllers up to the top-level SoC IRQ controller support
hierarchical interrupts using the v2 version of the irqdomain
API, and currently it seems like the ARM
GIC seems like the only top level IRQ controller that can
do that.

Yours,
Linus Walleij
