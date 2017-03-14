From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 1/4] gpio: acpi: Don't return 0 on acpi_gpio_count()
Date: Tue, 14 Mar 2017 13:51:31 +0200
Message-ID: <20170314115131.GO2957@lahna.fi.intel.com>
References: <20170220161549.39490-1-andriy.shevchenko@linux.intel.com>
 <20170220161549.39490-2-andriy.shevchenko@linux.intel.com>
 <CACRpkdYcPnh-2JLA658RW1RmTcMtRORkDrWe8pgEtmKXE-XSWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYcPnh-2JLA658RW1RmTcMtRORkDrWe8pgEtmKXE-XSWQ@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Input <linux-input@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86 <platform-driver-x86@vger.kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Mar 14, 2017 at 10:43:02AM +0100, Linus Walleij wrote:
> On Mon, Feb 20, 2017 at 5:15 PM, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > It's unusual to have error checking like (ret <= 0) in cases when
> > counting GPIO resources. In case when it's mandatory we propagate the
> > error (-ENOENT), otherwise we don't use the result.
> >
> > This makes consistent behaviour across all possible variants called in
> > gpiod_count().
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Mika/Rafael, can you look at this patch?

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
