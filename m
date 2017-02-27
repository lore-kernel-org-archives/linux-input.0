From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 0/4] gpio: make gpiod_count() API consistent
Date: Mon, 27 Feb 2017 09:27:35 +0100
Message-ID: <20170227082735.GA2373@mail.corp.redhat.com>
References: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Feb 20 2017 or thereabouts, Andy Shevchenko wrote:
> There are three possibilities in gpiod_count(): ACPI, OF, and
> platform data.
> 
> Some of them return 0, which requires to be handled separately, though
> developers rather lazy and just shadow an actual error code.
> 
> Let's make this API consistent by not allowing 0 in returned value.
> 
> There are luckily only 3 users right now, one of them handles this
> properly, the rest is converted in this series.
> 
> Series is supposed to go through GPIO tree.
> 
> Andy Shevchenko (4):
>   gpio: acpi: Don't return 0 on acpi_gpio_count()
>   gpio: of: Don't return 0 on dt_gpio_count()
>   platform/x86: surface3_button: Propagate error from gpiod_count()
>   Input: soc_button_array - Propagate error from gpiod_count()

Not sure if this still matters, but still:
Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> 
>  drivers/gpio/gpiolib-acpi.c            | 4 ++--
>  drivers/gpio/gpiolib.c                 | 4 ++--
>  drivers/input/misc/soc_button_array.c  | 5 +++--
>  drivers/platform/x86/surface3_button.c | 5 +++--
>  4 files changed, 10 insertions(+), 8 deletions(-)
> 
> -- 
> 2.11.0
> 
