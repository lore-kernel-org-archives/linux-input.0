From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/2] gpio: acpi: add quirk to override GpioInt polarity
Date: Mon, 2 Sep 2019 19:06:06 +0300
Message-ID: <20190902160606.GR2680@smile.fi.intel.com>
References: <20190831030916.13172-1-peter@typeblog.net>
 <20190902100141.GW2680@smile.fi.intel.com>
 <CACRpkdaY_TT_m3XEh_J9TqMQijzUieQDBn+t4=uGUyfP+V0Hzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdaY_TT_m3XEh_J9TqMQijzUieQDBn+t4=uGUyfP+V0Hzg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Cai <peter@typeblog.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Sep 02, 2019 at 03:36:24PM +0200, Linus Walleij wrote:
> On Mon, Sep 2, 2019 at 12:01 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Sat, Aug 31, 2019 at 11:09:14AM +0800, Peter Cai wrote:
> > > On GPD P2 Max, the firmware could not reset the touch panel correctly.
> > > The kernel needs to take on the job instead, but the GpioInt definition
> > > in DSDT specifies ActiveHigh while the GPIO pin should actually be
> > > ActiveLow.
> > >
> > > We need to override the polarity defined by DSDT. The GPIO driver
> > > already allows defining polarity in acpi_gpio_params, but the option is
> > > not applied to GpioInt.
> > >
> > > This patch adds a new quirk that enables the polarity specified in
> > > acpi_gpio_params to also be applied to GpioInt.
> >
> > Thank you for an update!
> >
> > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > on the condition that Dmitry and other input / Goodix developers are okay with
> > the approach in general.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> In case Dmitry needs to merge this.
> 
> Or should I simply merge this patch to the GPIO tree?

For my opinion Input subsystem should decide how to proceed with this.

-- 
With Best Regards,
Andy Shevchenko
