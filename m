From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 2/2] touchscreen: goodix: define GPIO mapping for GPD P2
 Max
Date: Fri, 30 Aug 2019 21:16:59 +0300
Message-ID: <20190830181659.GO2680@smile.fi.intel.com>
References: <20190830000024.20384-1-peter@typeblog.net>
 <20190830000024.20384-2-peter@typeblog.net>
 <20190830115505.GX2680@smile.fi.intel.com>
 <CA+Zf_0etfu7282TQ4wYE8tOrhh2Je4aV4Dz5tgC_wt7=FMAidA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+Zf_0etfu7282TQ4wYE8tOrhh2Je4aV4Dz5tgC_wt7=FMAidA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Cai <peter@typeblog.net>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Aug 30, 2019 at 11:15:27PM +0800, Peter Cai wrote:
> On Fri, Aug 30, 2019, 7:55 PM Andy Shevchenko <
> andriy.shevchenko@linux.intel.com> wrote:

> > I guess most of these #ifdef:s makes code less readable for exchange of
> saving
> few bytes in the module footprint.
> 
> Well since they can only be used when ACPI is supported

> (devm_acpi_dev_add_driver_gpios does not exist without ACPI defined, thus
> the last guard must exist),

This is not correct.

> if they were not guarded then we would be left
> with a bunch of unused variables warnings when building without ACPI which
> doesn't seem good.

Good / no-good is only matter of few dozens of bytes here and there to be saved.

> Should we use __maybe_unused here instead of #ifdef guards?

No, it won't make sense, because the structures will be part of
_add_driver_gpio() call, due to which compiler likely can't recognize unused
structures. However, you may try with warnings enabled `make W=1`.

> > Comma at the end?
> 
> I was trying to follow the style of this driver but it doesn't seem to be
> really consistent within itself. Another dmi_system_id definition in the
> same file mixed both styles so I was kind of confused.

I see. So, this is for Dmitry's preferences.

-- 
With Best Regards,
Andy Shevchenko
