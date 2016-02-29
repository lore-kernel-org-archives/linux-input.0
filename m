From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/3] input: gpio_keys: Make use of the device property API
Date: Mon, 29 Feb 2016 10:17:23 +0200
Message-ID: <20160229081723.GB1770@lahna.fi.intel.com>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
 <1455876982-6743-4-git-send-email-geert+renesas@glider.be>
 <20160222195815.GB28343@dtor-ws>
 <CA+V1Lzrag5QPAPjjhqp8R6uUG4NPb9sG7axiJoBGk4q=ozXV0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:64181 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753045AbcB2IUt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Feb 2016 03:20:49 -0500
Content-Disposition: inline
In-Reply-To: <CA+V1Lzrag5QPAPjjhqp8R6uUG4NPb9sG7axiJoBGk4q=ozXV0w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vincent Pelletier <plr.vincent@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org

On Sun, Feb 28, 2016 at 02:03:34AM +0000, sergk sergk2mail wrote:
> Sorry to interrupt with question, but I guess this thread has right
> people for related to this topic question.
> The question is reversed to the topic - how to, having working touch
> driver in Android and Windows determine which exactly gpio pin is used
> as INT\WAKE gpio by the driver?

On ACPI systems the device description has either Interrupt() or
GpioInt() resource in its _CRS list (see
Documentation/acpi/gpio-properties.txt).

> Or for example even when I have some variant of such gpio pin how to
> ensure that it is exactly this gpio?
> For example practical task: I am trying to determine which exactly
> gpio pin is responsible for INT/WAKE touchscreen on Chuwi Vi10
> (baytrail x86_64 Arch 4.4.2 vanilla kernel with my custom config).
> Exploring /sys/class/gpio/* have guessed that in Android it is
> probably gpio134 but in Linux 4.4.2 probably gpio393. How to compare
> such pins and ensure that in Linux 393 gpio is the same as 134 in
> Android?
> Is this possible to do in any predictable (not guessing or enumerating
> all range) way?

Both DT and ACPI provide means to assign GPIOs to devices. We can then
use Linux APIs to query those. For example getting GPIO with name
"reset" is done like:

	struct gpio_desc *reset_desc;

	reset_desc = gpiod_get(dev, "reset", GPIOD_OUT_HIGH);

This will retrieve the GPIO using firmware description (ACPI, DT) if
available. No need to deal with the GPIO numbers.
