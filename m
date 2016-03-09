From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 3/3] input: gpio_keys: Make use of the device property API
Date: Wed, 9 Mar 2016 10:36:08 +0700
Message-ID: <CACRpkdb2vwjcpvOdmn36u_ESpapoc7_BPGOVFGKfsRmW_Q2cQA@mail.gmail.com>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
	<1455876982-6743-4-git-send-email-geert+renesas@glider.be>
	<20160222195815.GB28343@dtor-ws>
	<CA+V1Lzrag5QPAPjjhqp8R6uUG4NPb9sG7axiJoBGk4q=ozXV0w@mail.gmail.com>
	<20160229081723.GB1770@lahna.fi.intel.com>
	<CA+V1LzqX7_r1YuBCHSVLbjmp=6Ra=fi+mnVjNGzNhdvEDgXh2Q@mail.gmail.com>
	<20160301075241.GD1794@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20160301075241.GD1794@lahna.fi.intel.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: sergk sergk2mail <sergk.admin@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vincent Pelletier <plr.vincent@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Linux Input <linux-input@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Mar 1, 2016 at 2:52 PM, Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
> On Mon, Feb 29, 2016 at 04:24:16PM +0000, sergk sergk2mail wrote:

>> But how then to obtain gpio name or if it is possible the list of all
>> available names?
>> For example decoded ACPI DSDT shows the following:
>> how to get gpio name for mentioned in your reply function?
>
> For existing systems that do not provide _DSD naming for GPIOs you still
> can provide them in the driver itself (ugly but works). See
> Documentation/acpi/gpio-properties.txt chapter "ACPI GPIO Mappings
> Provided by Drivers".

I just this merge window added an ABI for userspace to read name
of the GPIO line and also consumer name ("label") by using the
two strings stored in struct gpio_desc.

Currently this will be initialized per-offset from the seldom used
char names[] in struct gpio_chip, if not NULL.

We're working on DT bindings to set this per-line from the DT, and
if ACPI has a mechanism to name individual lines, please submit
patches for assigning this properly! (Hi Mika ;)

For consumers struct gpio_desc is opaque, but if they actually need
to know the name of a line we can add gpiod_get_name(struct gpio_desc *)
but then I want to know a usecase. debugfs and userspace ABI is
already displaying it just fine.

Yours,
Linus Walleij
