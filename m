From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 8/8] Input: olpc_apsp: allocate the GPIOs used
Date: Thu, 11 Oct 2018 10:38:20 +0200
Message-ID: <CACRpkdZK3=u-E3KgVQT_Wx8tZBqO3Own_+ASLeq03vaP8q+s7A@mail.gmail.com>
References: <20181010142504.233467-1-lkundrak@v3.sk> <20181010142504.233467-9-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181010142504.233467-9-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: lkundrak@v3.sk, Stephen Boyd <swboyd@chromium.org>, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, quozl@laptop.org, Linux Input <linux-input@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Lubomir,

thanks for your patch!

On Wed, Oct 10, 2018 at 4:26 PM Lubomir Rintel <lkundrak@v3.sk> wrote:

> Take the GPIO lines are used by the SP. The driver doesn't touch the
> lines -- this is done to disallow anything else from fiddling with
> them because that would confuse the SP firmware.
>
> Also, the lines are now nicely visible in /sys/kernel/debug/gpio.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Sadly I do not think this is the right way to do this these days.
In the past I would have agreed.

A few months back, Qualcomm engineers working on ACPI
support ran into similar issues: there were GPIO lines that
could not be touched by the kernel because they were used
by firmware (BIOS).

The solution we devised can be seen in
commit 726cb3ba49692bdae6caff457755e7cdb432efa4
"gpiolib: Support 'gpio-reserved-ranges' property"
which adds a "valid mask" to struct gpio_chip.

It is further refined in the lates working kernel code to make
it easy for users to set up a custom valid_mask.
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commit/?h=devel&id=f8ec92a9f63b3b11e399409141b7868bb405e6b5

So what you should do is modify the platform set-up for
the OLPC to mask off these GPIO lines as invalid since
they are used by the firmware and Linux should not touch
them.

Sadly I don't know which GPIO driver the XO1 is using,
but if you tell us I bet me or Andy will be able to help you
out in finding the right spot to patch.

Yours,
Linus Walleij
