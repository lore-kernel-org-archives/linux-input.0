From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC/PATCH 0/5] Support children for legacy device properties
Date: Tue, 18 Sep 2018 07:23:40 +0300
Message-ID: <CAHp75VcguYVeKMLGZ-S2JTvY0omSbBpjeqGNby+SzVqUoNdQiw@mail.gmail.com>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-input <linux-input@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 17, 2018 at 9:18 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
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

I like the idea.
Though, I Cc'ed this to Mika and Sakari who might be interested to see
and, perhaps, comment on it.

>
> Thanks.
>
> --
> Dmitry
>


-- 
With Best Regards,
Andy Shevchenko
