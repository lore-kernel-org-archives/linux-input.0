From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] touchscreen: goodix: define GPIO mapping for GPD P2
 Max
Date: Fri, 30 Aug 2019 14:55:05 +0300
Message-ID: <20190830115505.GX2680@smile.fi.intel.com>
References: <20190830000024.20384-1-peter@typeblog.net>
 <20190830000024.20384-2-peter@typeblog.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830000024.20384-2-peter@typeblog.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Cai <peter@typeblog.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 30, 2019 at 08:00:24AM +0800, Peter Cai wrote:
> The firmware of GPD P2 Max could not handle panel resets although code
> is present in DSDT. The kernel needs to take on this job instead, but
> the DSDT does not provide _DSD, rendering kernel helpless when trying to
> find the respective GPIO pins.
> 
> Fortunately, this time GPD has proper DMI vendor / product strings that
> we could match against. We simply apply an acpi_gpio_mapping table when
> GPD P2 Max is matched.
> 
> Additionally, the DSDT definition of the irq pin specifies a wrong
> polarity. The new quirk introduced in the previous patch
> (ACPI_GPIO_QUIRK_OVERRIDE_POLARITY) is applied to correct this.

> +#ifdef CONFIG_ACPI

I guess most of these #ifdef:s makes code less readable for exchange of saving
few bytes in the module footprint.

> +	{ "irq-gpios", &irq_gpios_default, 1,
> +		ACPI_GPIO_QUIRK_OVERRIDE_POLARITY },

One line?

> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "GPD"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "P2 MAX")

Comma at the end?

> +		},
> +		.driver_data = &gpio_mapping_force_irq_active_high

Ditto.

-- 
With Best Regards,
Andy Shevchenko
