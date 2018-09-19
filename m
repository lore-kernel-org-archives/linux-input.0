From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [RFC/PATCH 0/5] Support children for legacy device properties
Date: Wed, 19 Sep 2018 12:55:15 -0700
Message-ID: <CACRpkdYAvhaH6+L8J0sdQd7vYzrAioFhUZAcu2eB6t2hRK0L9Q@mail.gmail.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Linux Input <linux-input@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 17, 2018 at 11:16 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> The generic device properties APIs are very helpful as they allow abstracting
> away details of the platform (whether it is ACPI, device tree, or legacy board
> file), so that individual driver does not need separate code paths to support
> all variants. However there are drivers that currently can not use generic
> device properties API as they need notion of children properties, for example
> gpio_keys driver, that expects every button to be described as a sub-node of
> main device.
>
> This patch series introduces notion of sub-nodes for static properties and ties
> it up with GPIO lookup tables so that they are usable with sub-nodes as well.

This is the patch series I would have written, had I been smart enough.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
for the series.

I can't test the SIM.ONE board with this until next week but the approach
is definately what we want, not just for legacy boards, but also for any
other non-discoverable hardware we currently poke into
drivers/platform or arch/x86/platform etc.

Yours,
Linus Walleij

Yours,
Linus Walleij
