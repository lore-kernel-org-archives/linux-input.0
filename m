From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 3/3] input: gpio_keys: Make use of the device property API
Date: Tue, 1 Mar 2016 09:52:41 +0200
Message-ID: <20160301075241.GD1794@lahna.fi.intel.com>
References: <1455876982-6743-1-git-send-email-geert+renesas@glider.be>
 <1455876982-6743-4-git-send-email-geert+renesas@glider.be>
 <20160222195815.GB28343@dtor-ws>
 <CA+V1Lzrag5QPAPjjhqp8R6uUG4NPb9sG7axiJoBGk4q=ozXV0w@mail.gmail.com>
 <20160229081723.GB1770@lahna.fi.intel.com>
 <CA+V1LzqX7_r1YuBCHSVLbjmp=6Ra=fi+mnVjNGzNhdvEDgXh2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:4803 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbcCAHww (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Mar 2016 02:52:52 -0500
Content-Disposition: inline
In-Reply-To: <CA+V1LzqX7_r1YuBCHSVLbjmp=6Ra=fi+mnVjNGzNhdvEDgXh2Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Aaron Lu <aaron.lu@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Vincent Pelletier <plr.vincent@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-input@vger.kernel.org, linux-gpio@vger.kernel.org

On Mon, Feb 29, 2016 at 04:24:16PM +0000, sergk sergk2mail wrote:
> But how then to obtain gpio name or if it is possible the list of all
> available names?
> For example decoded ACPI DSDT shows the following:
> how to get gpio name for mentioned in your reply function?

For existing systems that do not provide _DSD naming for GPIOs you still
can provide them in the driver itself (ugly but works). See
Documentation/acpi/gpio-properties.txt chapter "ACPI GPIO Mappings
Provided by Drivers".

> Does it according below DSDT should be "GPO1" or "INT33FC" or something other?

No. The DSDT below does not have any names.

> Kind regards,
>                        Serge Kolotylo.
> 
>  Device (TCS5)
>             {
>                 Name (_ADR, Zero)  // _ADR: Address
>                 Name (_HID, "CHPN0001")  // _HID: Hardware ID
>                 Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus)
> */)  // _CID: Compatible ID
>                 Name (_S0W, Zero)  // _S0W: S0 Device Wake State
>                 Name (_DEP, Package (0x02)  // _DEP: Dependencies
>                 {
>                     GPO1,
>                     I2C5
>                 })
>                 Method (_PS3, 0, Serialized)  // _PS3: Power State 3
>                 {
>                 }
> 
>                 Method (_PS0, 0, Serialized)  // _PS0: Power State 0
>                 {
>                     If ((^^^GPO1.AVBL == One))
>                     {
>                         ^^^GPO1.TCD3 = Zero

Note that all these are part of GPIO Operation Region and not accessible
to the i2c-hid driver. The will be used when the device is powered on
and the pinctrl-baytrail has been loaded (that provides the Operation
Region).

If you need to use GPIOs from driver, they are listed in _CRS of the
device.

>                     }
> 
>                     Sleep (0x05)
>                     If ((^^^I2C5.PMI1.AVBG == One))
>                     {
>                         ^^^I2C5.PMI1.TCON = One
>                     }
> 
>                     Sleep (0x1E)
>                     If ((^^^GPO1.AVBL == One))
>                     {
>                         ^^^GPO1.TCD3 = One
>                     }
> 
>                     Sleep (0x78)
>                 }
