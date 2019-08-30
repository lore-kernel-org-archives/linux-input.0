From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] gpio: acpi: add quirk to override GpioInt polarity
Date: Fri, 30 Aug 2019 14:42:26 +0300
Message-ID: <20190830114226.GW2680@smile.fi.intel.com>
References: <20190830000024.20384-1-peter@typeblog.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830000024.20384-1-peter@typeblog.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Cai <peter@typeblog.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 30, 2019 at 08:00:23AM +0800, Peter Cai wrote:
> On GPD P2 Max, the firmware could not reset the touch panel correctly.
> The kernel needs to take on the job instead, but the GpioInt definition
> in DSDT specifies ActiveHigh while the GPIO pin should actually be
> ActiveLow.
> 
> We need to override the polarity defined by DSDT. The GPIO driver
> already allows defining polarity in acpi_gpio_params, but the option is
> not applied to GpioInt.
> 
> This patch adds a new quirk that enables the polarity specified in
> acpi_gpio_params to also be applied to GpioInt.

In general if it's really the case, I'm not objecting to have another quirk.
So, I would wait for the comments on the second patch to see how it's going.

>  include/linux/acpi.h        |  6 ++++++

The GPIO part of the header had been moved to the drivers/gpio/gpiolib-acpi.h.
Please, base your series on top of the gpio/for-next.

>  			lookup->info.flags = GPIOD_IN;
> -			lookup->info.polarity = agpio->polarity;

> +			if (lookup->info.quirks &
> +					ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) {

Disregard checkpatch I would leave this on one line.

> +				dev_warn(&lookup->info.adev->dev, FW_BUG "Incorrect polarity specified by GpioInt, overriding.\n");
> +				lookup->info.polarity = lookup->active_low;
> +			} else {
> +				lookup->info.polarity = agpio->polarity;
> +			}
>  			lookup->info.triggering = agpio->triggering;

Since the quirk makes sense only for GpioInt and basically no-op for GpioIo,
I would move the check out of if (gpioint) {} else {} conditional:

	if (gpioint) {
		...
	} else {
		...
	}

	if (quirk) {
		dev_warn();
		polarity = ...;
	}

-- 
With Best Regards,
Andy Shevchenko
