From: Antonio Ospite <ao2@ao2.it>
Subject: Re: About Goodix-TS on Bay Trail, and ACPI and interrupts
Date: Tue, 20 Jan 2015 17:56:45 +0100
Message-ID: <20150120175645.f0f95b83da0355b8fdc7dd0d@ao2.it>
References: <20150117010306.7e32b72524e4c0cf8296bbac@ao2.it>
	<20150119153758.GA18115@mail.corp.redhat.com>
	<20150120100548.GG1850@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:51109 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345AbbATQ5D (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Jan 2015 11:57:03 -0500
In-Reply-To: <20150120100548.GG1850@lahna.fi.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Mathias Nyman <mathias.nyman@linux.intel.com>

On Tue, 20 Jan 2015 12:05:48 +0200
Mika Westerberg <mika.westerberg@intel.com> wrote:

> On Mon, Jan 19, 2015 at 10:37:58AM -0500, Benjamin Tissoires wrote:
> > Hi Antonio,
> > 
> > [adding Mika in CC, he implemented most of the ACPI and GPIO for
> > i2c-hid]
> > 
> > On Jan 17 2015 or thereabouts, Antonio Ospite wrote:
> > > Hi,
> > > 
> > > I am trying to make the Goodix driver (drivers/input/touchscreen/goodix.c)
> > > working with a Teclast X98 Air 3G, a tablet based on Intel Bay Trail,
> > > but I am new to ACPI and I could use some help.
> > > 
> > > I am working with a 3.19-rc4 kernel compiled for x86_64.
> > > 
> > > This is the DSDT section in the UEFI firmware:
> > > 
> > >             Device (TCS0)
> > >             {
> > >                 Name (_ADR, Zero)  // _ADR: Address
> > >                 Name (_HID, "GODX0911")  // _HID: Hardware ID
> > >                 Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
> > 
[...]
> > >                     Name (ABUF, ResourceTemplate ()
> > >                     {
> > >                         I2cSerialBus (0x0014, ControllerInitiated, 0x0019F0A0,
> > >                             AddressingMode7Bit, "\\_SB.I2C4",
> > >                             0x00, ResourceConsumer, ,
> > >                             )
> > >                         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionInputOnly,
> > >                             "\\_SB.GPO2", 0x00, ResourceConsumer, ,
> > >                             )
> > >                             {   // Pin list
> > >                                 0x0044
> > >                             }
> > >                         GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> > >                             "\\_SB.GPO1", 0x00, ResourceConsumer, ,
> > >                             )
> > >                             {   // Pin list
> > >                                 0x001A
> > >                             }
> > >                     })
> > 
> > It looks like the GPIOs are correctly declared. The ACPI code should set
> > the client->irq auto-magically. It's not the case, so I guess Mika
> > should be able to tell us more on that.
> 
> The current i2c-hid.c does not cope with GPIO interrupts. I've attached
> an experimental patch that should convert the driver to use them.
> 
> Antonio, can you try that out and check if i2c-hid driver gets you
> working touch screen? Also please add "i2c_hid.debug=1" to the kernel
> command line so we can see if it returns proper HID descriptor.

Hi Mika, I tested the patch but I still can't get the IRQ.

The new code in i2c-hid does more or less what I was trying to do in
the goodix driver as proof of concept:
http://ao2.it/tmp/Goodix-TS_Teclast-X98-Air-3G/0001-XXX-goodix-add-support-for-GODX0911.patch

The gpio chip correspondent to the pin can be retrieved, but the gpio
descriptor can't be obtained and so the conversion from gpio to irq
can't happen, here is the full dmesg:
http://ao2.it/tmp/Goodix-TS_Teclast-X98-Air-3G/dmesg_Teclast_X98_Air_3G_mainline_i2c-hid_patch.log

I am pasting here the interesting parts, with some more printouts I
added to understand what was going on:

[    9.056071] i2c_hid i2c-GODX0911:01: GPIO lookup for consumer irq
[    9.056080] i2c_hid i2c-GODX0911:01: using ACPI for GPIO lookup
[    9.056086] acpi GODX0911:01: GPIO: looking up irq-gpios
[    9.056093] acpi GODX0911:01: GPIO: _DSD returned GODX0911:01 3 0 0 1
[    9.056160] acpi_find_gpio: ares->type: 19
[    9.056164] acpi_find_gpio: ares->type: 17
[    9.056167] acpi_find_gpio: pin_index: 0, agpio->pin_table_length: 1
[    9.056170] acpi_get_gpiod: path: \_SB.GPO2 pin: 68
[    9.056176] acpi_get_gpiod: handle found
[    9.056180] acpi_get_gpiod: gpiochip found
[    9.056183] acpi_get_gpiod: pin: 68
[    9.056186] acpi_get_gpiod: offset: 68
[    9.056189] gpiochip_get_desc: hwnum: 68 chip->ngpio: 44
[    9.056192] acpi_find_gpio: desc_error: -22
[    9.056195] acpi_find_gpio: ares->type: 17
[    9.056198] acpi_find_gpio: ares->type: 7
[    9.056204] acpi GODX0911:01: GPIO: looking up irq-gpio
[    9.056209] acpi GODX0911:01: GPIO: looking up 0 in _CRS
[    9.056272] acpi_find_gpio: ares->type: 19
[    9.056276] acpi_find_gpio: ares->type: 17
[    9.056280] acpi_find_gpio: pin_index: 0, agpio->pin_table_length: 1
[    9.056283] acpi_get_gpiod: path: \_SB.GPO2 pin: 68
[    9.056288] acpi_get_gpiod: handle found
[    9.056291] acpi_get_gpiod: gpiochip found
[    9.056294] acpi_get_gpiod: pin: 68
[    9.056297] acpi_get_gpiod: offset: 68
[    9.056300] gpiochip_get_desc: hwnum: 68 chip->ngpio: 44
[    9.056303] acpi_find_gpio: desc_error: -22
[    9.056306] acpi_find_gpio: ares->type: 17
[    9.056308] acpi_find_gpio: ares->type: 7
[    9.056314] i2c_hid i2c-GODX0911:01: lookup for GPIO irq failed
[    9.056319] i2c_hid i2c-GODX0911:01: Failed to get GPIO interrupt
[    9.073895] i2c_hid: probe of i2c-GODX0911:01 failed with error -22

As I was trying to say in the original mail, the DSDT declares a gpio
pin number (68) grater than the number of gpios for GPO2 (which on Bay
Trail is 44, isn't it?).

Is the DSDT just wrong? Or could there be anything missing in the
pinctrl-baytrail driver?

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
