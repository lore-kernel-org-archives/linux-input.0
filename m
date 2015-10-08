From: "Tirdea, Irina" <irina.tirdea@intel.com>
Subject: RE: [PATCH v7 2/9] Input: goodix - reset device at init
Date: Thu, 8 Oct 2015 12:18:37 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0F9A50@irsmsx105.ger.corp.intel.com>
References: <1444299575-17417-1-git-send-email-irina.tirdea@intel.com>
 <1444299575-17417-3-git-send-email-irina.tirdea@intel.com>
 <8618206.7jshXjkP9U@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:10925 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755474AbbJHMTg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Oct 2015 08:19:36 -0400
In-Reply-To: <8618206.7jshXjkP9U@wuerfel>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bastien Nocera <hadess@hadess.net>, Aleksei Mamlin <mamlinav@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Purdila, Octavian" <octavian.purdila@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: 08 October, 2015 13:54
> To: Tirdea, Irina
> Cc: Dmitry Torokhov; Bastien Nocera; Aleksei Mamlin; linux-input@vger.kernel.org; Mark Rutland; Purdila, Octavian; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org
> Subject: Re: [PATCH v7 2/9] Input: goodix - reset device at init
> 
> On Thursday 08 October 2015 13:19:28 Irina Tirdea wrote:
> > After power on, it is recommended that the driver resets the device.
> > The reset procedure timing is described in the datasheet and is used
> > at device init (before writing device configuration) and
> > for power management. It is a sequence of setting the interrupt
> > and reset pins high/low at specific timing intervals. This procedure
> > also includes setting the slave address to the one specified in the
> > ACPI/device tree.
> >
> > This is based on Goodix datasheets for GT911 and GT9271 and on Goodix
> > driver gt9xx.c for Android (publicly available in Android kernel
> > trees for various devices).
> >
> > For reset the driver needs to control the interrupt and
> > reset gpio pins (configured through ACPI/device tree). For devices
> > that do not have the gpio pins declared, the functionality depending
> > on these pins will not be available, but the device can still be used
> > with basic functionality.
> >
> > For both device tree and ACPI, the interrupt gpio pin configuration is
> > read from the "irq-gpio" property and the reset pin configuration is
> > read from the "reset-gpio" property. For ACPI 5.1, named properties
> > can be specified using the _DSD section. If there is no _DSD section
> > in the ACPI table, the driver will fall back to using indexed gpio
> > pins declared in the _CRS section.
> 
> Would it help to use a plain "gpios" property here to always look
> up the lines by index?
> 

The problem with ACPI indexed gpios is that platforms declare the
pins in random order. In this case we have some platforms that declare
the interrupt pin first and others that declare the reset pin first.
There is no way to differentiate between them so the only way to support
these platforms is to pick a default and list all exceptions in the driver.
My previous implementation did that with indexed gpios and dmi quirks. [1]

This can be solved by using named gpios, which are available starting with ACPI 5.1.
In this way we know exactly which is the interrupt pin and which is the reset pin
and we do not need to add any additional exceptions to the driver.
However, we still need to support the platforms that are already out there so
we fall back to indexed gpios.

[1] https://lkml.org/lkml/2015/9/15/609

> > +/*
> > + * Some platforms specify the gpio pins for interrupt and reset properly
> > + * in ACPI, but cannot use the interrupt pin as output due to their specific
> > + * HW configuration.
> > + */
> > +static const struct dmi_system_id goodix_no_gpio_pins_support[] = {
> > +#if defined(CONFIG_DMI) && defined(CONFIG_X86)
> > +	{
> > +		.ident = "Onda v975w",
> > +		.matches = {
> > +			DMI_MATCH(DMI_BIOS_VENDOR, "American Megatrends Inc."),
> > +			DMI_MATCH(DMI_PRODUCT_UUID,
> > +				  "03000200-0400-0500-0006-000700080009"),
> > +			DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> > +			DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
> > +		}
> > +	},
> 
> I think lists like this in drivers should be avoided if at all possible,
> it just leads to other people adding their platform in the lists as
> opposed to fixing their boot loaders.
> 
> Can you find another way to detect at runtime whether it works, and
> print a warning if it doesn't?

I agree with you on this, but unfortunately I have not found a better way to do it.

The main problem comes from the interrupt pin. This device uses the interrupt pin
as output, which some platforms do not support (either due to the HW configuration
or due to flagging it wrong in BIOS) [2] [3]. There is no error returned, just a warning
in dmesg.

[2] https://lkml.org/lkml/2015/9/28/851
[3] https://lkml.org/lkml/2015/9/30/607

> If there is no way to detect that kind
> of device, we should probably have another property that the driver
> can read to determine this, so we can avoid adding each system here.
> 

If one or both gpio pins are not declared in ACPI/DT or if gpio initialization fails,
the driver will work without the functionality that depends on them. 

However, this will not work for platforms that are already out and for which we cannot
modify the ACPI table (like Onda v975w, WinBook TW100 and WinBook TW700).

> > +	/* HIGH: 0x28/0x29, LOW: 0xBA/0xBB */
> > +	error = gpiod_direction_output(ts->gpiod_int, ts->client->addr == 0x14);
> > +	if (error)
> > +		return error;
> 
> If the "interrupt" gpio is used as an output, maybe it has the wrong
> name? Is that the name from the goodix datasheet (that would be ok)
> or something you picked?
> 

This is from the goodix datasheet [4]. The pin that is used for receiving interrupts
is also used as output (for reset and suspend procedures).

[4] https://drive.google.com/folderview?id=0BxCVOQS3ZymGfmJyY2RKbE5XbVlKNlktVTlwV0lxNEdxd2dzeWZER094cmJPVnMxN1F0Yzg&usp=sharing

Thanks,
Irina

> 	Arnd
