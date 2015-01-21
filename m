From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: About Goodix-TS on Bay Trail, and ACPI and interrupts
Date: Wed, 21 Jan 2015 12:16:54 +0200
Message-ID: <20150121101654.GM1850@lahna.fi.intel.com>
References: <20150117010306.7e32b72524e4c0cf8296bbac@ao2.it>
 <20150119153758.GA18115@mail.corp.redhat.com>
 <20150120100548.GG1850@lahna.fi.intel.com>
 <20150120175645.f0f95b83da0355b8fdc7dd0d@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26362 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752947AbbAUKRE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Jan 2015 05:17:04 -0500
Content-Disposition: inline
In-Reply-To: <20150120175645.f0f95b83da0355b8fdc7dd0d@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Mathias Nyman <mathias.nyman@linux.intel.com>

On Tue, Jan 20, 2015 at 05:56:45PM +0100, Antonio Ospite wrote:
> Hi Mika, I tested the patch but I still can't get the IRQ.
> 
> The new code in i2c-hid does more or less what I was trying to do in
> the goodix driver as proof of concept:
> http://ao2.it/tmp/Goodix-TS_Teclast-X98-Air-3G/0001-XXX-goodix-add-support-for-GODX0911.patch
> 
> The gpio chip correspondent to the pin can be retrieved, but the gpio
> descriptor can't be obtained and so the conversion from gpio to irq
> can't happen, here is the full dmesg:
> http://ao2.it/tmp/Goodix-TS_Teclast-X98-Air-3G/dmesg_Teclast_X98_Air_3G_mainline_i2c-hid_patch.log
> 
> I am pasting here the interesting parts, with some more printouts I
> added to understand what was going on:
> 
> [    9.056071] i2c_hid i2c-GODX0911:01: GPIO lookup for consumer irq
> [    9.056080] i2c_hid i2c-GODX0911:01: using ACPI for GPIO lookup
> [    9.056086] acpi GODX0911:01: GPIO: looking up irq-gpios
> [    9.056093] acpi GODX0911:01: GPIO: _DSD returned GODX0911:01 3 0 0 1
> [    9.056160] acpi_find_gpio: ares->type: 19
> [    9.056164] acpi_find_gpio: ares->type: 17
> [    9.056167] acpi_find_gpio: pin_index: 0, agpio->pin_table_length: 1
> [    9.056170] acpi_get_gpiod: path: \_SB.GPO2 pin: 68
> [    9.056176] acpi_get_gpiod: handle found
> [    9.056180] acpi_get_gpiod: gpiochip found
> [    9.056183] acpi_get_gpiod: pin: 68
> [    9.056186] acpi_get_gpiod: offset: 68
> [    9.056189] gpiochip_get_desc: hwnum: 68 chip->ngpio: 44
> [    9.056192] acpi_find_gpio: desc_error: -22
> [    9.056195] acpi_find_gpio: ares->type: 17
> [    9.056198] acpi_find_gpio: ares->type: 7
> [    9.056204] acpi GODX0911:01: GPIO: looking up irq-gpio
> [    9.056209] acpi GODX0911:01: GPIO: looking up 0 in _CRS
> [    9.056272] acpi_find_gpio: ares->type: 19
> [    9.056276] acpi_find_gpio: ares->type: 17
> [    9.056280] acpi_find_gpio: pin_index: 0, agpio->pin_table_length: 1
> [    9.056283] acpi_get_gpiod: path: \_SB.GPO2 pin: 68
> [    9.056288] acpi_get_gpiod: handle found
> [    9.056291] acpi_get_gpiod: gpiochip found
> [    9.056294] acpi_get_gpiod: pin: 68
> [    9.056297] acpi_get_gpiod: offset: 68
> [    9.056300] gpiochip_get_desc: hwnum: 68 chip->ngpio: 44
> [    9.056303] acpi_find_gpio: desc_error: -22
> [    9.056306] acpi_find_gpio: ares->type: 17
> [    9.056308] acpi_find_gpio: ares->type: 7
> [    9.056314] i2c_hid i2c-GODX0911:01: lookup for GPIO irq failed
> [    9.056319] i2c_hid i2c-GODX0911:01: Failed to get GPIO interrupt
> [    9.073895] i2c_hid: probe of i2c-GODX0911:01 failed with error -22
> 
> As I was trying to say in the original mail, the DSDT declares a gpio
> pin number (68) grater than the number of gpios for GPO2 (which on Bay
> Trail is 44, isn't it?).

That's right.

> Is the DSDT just wrong? Or could there be anything missing in the
> pinctrl-baytrail driver?

I think the DSDT is wrong here.

I found out from my mail archives that similar Goodix panel was used on
some internal reference design boards (it also used Goodix driver, btw).
Those also had the 0x44 GPIO there but that was wrong and it looked like
the correct GPIO number is 3 (in GPO2).

Not sure if that's the case here but maybe worth trying.
