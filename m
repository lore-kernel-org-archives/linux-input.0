From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/4] gpio: make gpiod_count() API consistent
Date: Tue, 28 Feb 2017 11:48:06 +0200
Message-ID: <1488275286.20145.49.camel@linux.intel.com>
References: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
         <20170227082735.GA2373@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20170227082735.GA2373@mail.corp.redhat.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 2017-02-27 at 09:27 +0100, Benjamin Tissoires wrote:
> On Feb 20 2017 or thereabouts, Andy Shevchenko wrote:
> > There are three possibilities in gpiod_count(): ACPI, OF, and
> > platform data.
> > 
> > Some of them return 0, which requires to be handled separately,
> > though
> > developers rather lazy and just shadow an actual error code.
> > 
> > Let's make this API consistent by not allowing 0 in returned value.
> > 
> > There are luckily only 3 users right now, one of them handles this
> > properly, the rest is converted in this series.
> > 
> > Series is supposed to go through GPIO tree.
> > 
> > Andy Shevchenko (4):
> >   gpio: acpi: Don't return 0 on acpi_gpio_count()
> >   gpio: of: Don't return 0 on dt_gpio_count()
> >   platform/x86: surface3_button: Propagate error from gpiod_count()
> >   Input: soc_button_array - Propagate error from gpiod_count()
> 
> Not sure if this still matters, but still:
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I'm sure it is.

Linus, is your plan to go through queue after merge window is closed?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
